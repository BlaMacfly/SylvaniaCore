# -*- coding: utf-8 -*-
"""Genere creature_template_journal pour les boss WoD/Legion sans butin.
   Source officielle : JournalInstance -> JournalEncounter -> JournalEncounterCreature."""
import sys, subprocess, collections
sys.path.insert(0, '/home/ubuntu')
from db2read import DB2
D = '/home/ubuntu/server/data/dbc/enUS/'

CIBLES = [1175,1176,1182,1195,1209,1279,1358,1205,1228,
          1456,1458,1466,1477,1492,1501,1544,1571,1753,1520,1530,1676]

# adds / decors qui partagent le modele du boss mais ne doivent rien lacher
EXCLUS = {
 76057,   # Carrion Worm (add de Bonemaw)
 76874, 76945, 76884,   # Dreadwing / Ironcrusher / Cruelfang (bestioles de Darmac)
 77337,   # Aknor Steelbringer (add de Flamebender)
 76810,   # Furnace Engineer
 76087,   # Defense Construct (Skyreach)
 99801, 105383, 105322, 105304,  # tentacules
 117123,  # Tidescale Legionnaire
 122571, 125860, 122319, 125340, # adds du Siege du Triumvirat
 118460,  # Engine of Souls (l'encontre se termine sur Soul Queen Dejahna)
 76018, 82556,  # Drakonid Monstrosity (trash UBRS)
 106482,  # Malfurion (PNJ de la rencontre Cenarius)
 120996,  # doublon d'Atrigan
 77810,   # doublon de Soulbinder Nyami
 84336,   # doublon de Yalnu (pre-event)
 83893, 83892,  # Protecteurs anciens : on garde Dulhu comme porteur
 76973,   # Hans'gar : on garde Franzok
 78237,   # Phemos : on garde Pol
 116689,  # Atrigan : on garde Belac
 118523, 118374,  # Soeurs de la Lune : on garde Priestess Lunaspyre
 102681, 102679,  # Dragons du Cauchemar : on garde Lethon
 80808, 80805,    # Contremaitres du Rail-de-fer : on garde Ahri'ok Dugru
 83613,   # Koramar : on garde Skulloc
 76806,   # Haut fourneau : on garde Foreman Feldspar ? non -> voir plus bas
 77231, 77477,    # Vierges de fer : on garde Admiral Gar'an
}
# Haut fourneau : la rencontre se termine sur le Coeur de la Montagne
EXCLUS.discard(76806); EXCLUS.add(76809)

ji  = DB2(D+'JournalInstance.db2',         "ssiiiihhbbi", [1]*11,                  10, -1)
je  = DB2(D+'JournalEncounter.db2',        "ssfhhhhbbii", [1,1,2,1,1,1,1,1,1,1,1], -1, -1)
jec = DB2(D+'JournalEncounterCreature.db2',"ssiiihbi",    [1]*8,                    7,  5)
jei = DB2(D+'JournalEncounterItem.db2',    "ihbbbi",      [1]*6,                    5,  1)

instMap = {ji.getId(i): ji.getRaw(i,6,0,"h") for i in range(ji.recCount)}
encMap = {}
for i in range(je.recCount):
    eid = je.getId(i); mid = instMap.get(je.getRaw(i,6,0,"h"), 0)
    if mid in CIBLES: encMap[eid] = mid
nbItems = {eid: len(jei.parentMap.get(eid, [])) for eid in encMap}
disp = collections.defaultdict(set)
for eid, idxs in jec.parentMap.items():
    if eid in encMap:
        for r in idxs: disp[eid].add(jec.getRaw(r,2,0,"i"))

q = ("SELECT DISTINCT c.map, ct.entry, ct.name, ct.rank, ct.ScriptName, "
     "ct.modelid1, ct.modelid2, ct.modelid3, ct.modelid4, "
     "(SELECT COUNT(*) FROM creature c2 WHERE c2.id=ct.entry AND c2.map=c.map), "
     "(SELECT COUNT(*) FROM creature_loot_template l WHERE l.entry=ct.lootid) "
     "FROM creature c JOIN creature_template ct ON ct.entry=c.id "
     "WHERE c.map IN (%s)" % ','.join(map(str, CIBLES)))
out = subprocess.run(['mysql','-N','-B','dc_world','-e',q], capture_output=True, text=True).stdout
byMapModel = collections.defaultdict(list)
for line in out.splitlines():
    f = line.split('\t')
    mp, entry, name, rank, script = int(f[0]), int(f[1]), f[2], int(f[3]), f[4]
    spawns, butin = int(f[9]), int(f[10])
    for m in (int(x) for x in f[5:9]):
        if m: byMapModel[(mp, m)].append((entry, name, rank, script, spawns, butin))

rows, rejets = [], []
for eid, mid in sorted(encMap.items(), key=lambda kv: kv[1]):
    cands, seen = [], set()
    for d in disp.get(eid, ()):
        for c in byMapModel.get((mid, d), []):
            if c[0] in seen: continue
            seen.add(c[0]); cands.append(c)
    # on ne garde que les boss credibles, sans butin, hors liste d'exclusion
    keep = [c for c in cands
            if c[0] not in EXCLUS and c[5] == 0
            and (c[3].startswith('boss_') or c[2] == 3 or (c[2] >= 1 and c[4] <= 3))]
    if not keep:
        rejets.append((mid, eid, nbItems.get(eid,0), [(c[0], c[1], c[5]) for c in cands]))
        continue
    keep.sort(key=lambda c: (0 if c[3].startswith('boss_') else 1, c[4]))
    for c in keep:
        rows.append((mid, eid, c[0], c[1], nbItems.get(eid,0)))

print("-- creature_template_journal : %d lignes" % len(rows))
for mid, eid, entry, name, n in rows:
    print("(%d, %d), -- carte %d : %s (%d objets au journal)" % (entry, eid, mid, name, n))
print()
print("-- rencontres sans candidat retenu : %d" % len(rejets))
for mid, eid, n, cands in rejets:
    print("--   carte %d rencontre %d (%d objets) -> %s" % (mid, eid, n, cands if cands else "aucun PNJ apparu"))
