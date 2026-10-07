#!/usr/bin/env python3
# Genere le SQL versionne du registre des expeditions (world_quest). Lecture seule des bases.
import subprocess, collections

def q(sql):
    out = subprocess.run(['sudo', 'mysql', '-N', '-e', sql], capture_output=True, text=True, check=True).stdout
    return [l.split('\t') for l in out.strip().split('\n') if l]

OUT = '/home/ubuntu/DestinyCore/sql/sylvania/'

# ---------- 1. entrees a retirer (pas des expeditions, ou sans objectif) ----------
KEEP_INFO = {'113', '128', '146'}  # Time to Rumble, emissaires, assauts de la Legion
retire = q("""SELECT w.id, IFNULL(q.LogTitle,'(sans titre)'), q.QuestInfoID FROM dc_world.world_quest w JOIN dc_world.quest_template q ON q.ID=w.id
              WHERE (q.QuestType<>3 OR NOT EXISTS (SELECT 1 FROM dc_world.quest_objectives o WHERE o.QuestID=w.id))""")
retire = [r for r in retire if r[2] not in KEEP_INFO]

# ---------- 2. candidats LegionCore ----------
spawned = {r[0] for r in q("SELECT DISTINCT id FROM dc_world.creature")}
credit = set()
for e, k1, k2 in q("SELECT t.entry, t.KillCredit1, t.KillCredit2 FROM dc_world.creature_template t WHERE t.KillCredit1<>0 OR t.KillCredit2<>0"):
    if e in spawned:
        credit.add(k1); credit.add(k2)
gos = {r[0] for r in q("SELECT DISTINCT id FROM dc_world.gameobject")}

rows = q("""SELECT u.QuestID, u.Timer, u.VariableID, u.Value, u.VerifiedBuild, u.EventID FROM lc_world_ref.world_quest_update u""")
by = collections.defaultdict(list)
for r in rows:
    by[r[0]].append(r)

existing = {r[0] for r in q("SELECT id FROM dc_world.world_quest")}
qt = {r[0]: r for r in q("SELECT ID, QuestType, QuestInfoID, IFNULL(LogTitle,'') FROM dc_world.quest_template")}
objs = collections.defaultdict(list)
for qid, t, oid in q("SELECT QuestID, Type, ObjectID FROM dc_world.quest_objectives"):
    objs[qid].append((t, oid))

EXCL_INFO = {'0', '139', '142', '144', '145', '146'}
stats = collections.Counter()
imports = []
for qid, lst in sorted(by.items(), key=lambda x: int(x[0])):
    if any(r[5] != '0' for r in lst): stats['evenement'] += 1; continue
    if qid in existing: stats['deja la'] += 1; continue
    t = qt.get(qid)
    if not t: stats['pas de quete chez nous'] += 1; continue
    if t[1] != '3': stats['pas une expedition'] += 1; continue
    if t[2] in EXCL_INFO: stats['categorie exclue (assaut/boss mondial)'] += 1; continue
    o = objs.get(qid)
    if not o: stats['sans objectif'] += 1; continue
    bad = False
    for ty, oid in o:
        if ty == '0' and oid not in spawned and oid not in credit: bad = True
        if ty == '2' and oid not in gos: bad = True
    if bad: stats['cible absente du monde'] += 1; continue
    r = max(lst, key=lambda r: (int(r[4]), int(r[1])))
    imports.append((qid, r[1], r[2], r[3], t[3]))
    stats['importees'] += 1

ids_retire = ','.join(r[0] for r in retire)
L = ["-- Registre des expeditions (quetes mondiales).",
     "-- 1) Retire %d entrees qui ne sont pas des expeditions jouables : invasions de l avant-patch 7.0," % len(retire),
     "--    hebdomadaires de donjon, archeologie, quetes sans titre ni objectif, points d invasion sans objectif.",
     "--    Gardes : emissaires (128), assauts de la Legion (146), Time to Rumble (113).",
     "-- 2) Importe %d expeditions relevees en officiel (lc_world_ref.world_quest_update, builds <= 26972)," % len(imports),
     "--    QuestType 3, avec objectifs, cibles presentes dans le monde ; exclues : liees a un evenement,",
     "--    quetes d assaut (139/142, seulement pendant l assaut), boss mondiaux (144).",
     "-- Sauvegarde : ~/tmp/sauvegardes/world_quest_2026-10-07.sql (+ dc_characters.world_quest)",
     "-- Rollback   : 2026_10_07_expeditions_registre_rollback.sql",
     "",
     "DELETE FROM world_quest WHERE id IN (%s);" % ids_retire,
     "",
     "INSERT INTO world_quest (id, duration, variable, value) VALUES"]
for i, (qid, dur, var, val, title) in enumerate(imports):
    L.append("(%s, %s, %s, %s)%s -- %s" % (qid, dur, var, val, ',' if i < len(imports) - 1 else ';', title.replace('\n', ' ')))
open(OUT + '2026_10_07_expeditions_registre.sql', 'w').write('\n'.join(L) + '\n')

back = q("SELECT id, duration, variable, value FROM dc_world.world_quest WHERE id IN (%s)" % ids_retire)
R = ["-- Annule 2026_10_07_expeditions_registre.sql",
     "DELETE FROM world_quest WHERE id IN (%s);" % ','.join(x[0] for x in imports),
     "INSERT INTO world_quest (id, duration, variable, value) VALUES",
     ',\n'.join("(%s, %s, %s, %s)" % tuple(b) for b in back) + ';']
open(OUT + '2026_10_07_expeditions_registre_rollback.sql', 'w').write('\n'.join(R) + '\n')

print('retirees', len(retire)); print(dict(stats))
print('retire chars a nettoyer :', ids_retire)
