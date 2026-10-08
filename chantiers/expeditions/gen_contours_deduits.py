#!/usr/bin/env python3
# Contours DEDUITS des expeditions du registre qui n'en ont aucun, faute de source (ni LegionCore ni TDB 735) :
# rectangle autour des apparitions des cibles de la quete (le serveur donne l'expedition au joueur qui entre
# dans ce rectangle, voir ObjectMgr::BonusQuestsRects). Lecture seule des bases.
import subprocess, statistics, collections

def q(sql):
    out = subprocess.run(['sudo', 'mysql', '-N', '-e', sql], capture_output=True, text=True, check=True).stdout
    return [l.split('\t') for l in out.rstrip('\n').split('\n') if l]

ARGUS = {8574: 1135, 8701: 1170, 8899: 1171}   # zone -> carte du monde (Krokuun, Mac'Aree, Desert d'Antoran)
quetes = q("""SELECT w.id, q.QuestSortID, IFNULL(q.LogTitle,'') FROM dc_world.world_quest w JOIN dc_world.quest_template q ON q.ID=w.id
              WHERE q.QuestType=3 AND NOT EXISTS (SELECT 1 FROM dc_world.quest_poi_points p WHERE p.QuestID=w.id) ORDER BY w.id""")
# carte du monde habituelle de chaque zone des Iles brisees, d'apres les contours existants
wma = {}
for zone, m in q("""SELECT q.QuestSortID, p.WorldMapAreaId FROM dc_world.quest_poi p JOIN dc_world.quest_template q ON q.ID=p.QuestID
                    WHERE p.MapID=1220 AND q.QuestSortID>0 GROUP BY q.QuestSortID, p.WorldMapAreaId ORDER BY COUNT(*)"""):
    wma[int(zone)] = int(m)
wma.update(ARGUS)

objs = collections.defaultdict(list)
for qid, t, oid in q(f"SELECT QuestID, Type, ObjectID FROM dc_world.quest_objectives WHERE QuestID IN ({','.join(r[0] for r in quetes)})"):
    objs[qid].append((t, oid))

poi, pts, faits, rates = [], [], [], []
for qid, zone, titre in quetes:
    zone = int(zone)
    carte = 1669 if zone in ARGUS else 1220
    cibles_c = [oid for t, oid in objs[qid] if t == '0']
    cibles_g = [oid for t, oid in objs[qid] if t == '2']
    pos = []
    if cibles_c:
        I = ','.join(cibles_c)
        pos += q(f"""SELECT position_x, position_y FROM dc_world.creature WHERE map={carte} AND zoneId={zone}
                     AND (id IN ({I}) OR id IN (SELECT entry FROM dc_world.creature_template WHERE KillCredit1 IN ({I}) OR KillCredit2 IN ({I})))""")
    if cibles_g:
        pos += q(f"SELECT position_x, position_y FROM dc_world.gameobject WHERE map={carte} AND zoneId={zone} AND id IN ({','.join(cibles_g)})")
    if not pos and cibles_c:
        # la creature peut etre rattachee a une zone voisine : toute la carte
        I = ','.join(cibles_c)
        pos += q(f"""SELECT position_x, position_y FROM dc_world.creature WHERE map={carte}
                     AND (id IN ({I}) OR id IN (SELECT entry FROM dc_world.creature_template WHERE KillCredit1 IN ({I}) OR KillCredit2 IN ({I})))""")
    if not pos and any(t == '12' for t, _ in objs[qid]) and titre:
        # combat de mascottes : le dresseur porte le nom de la quete
        nom = titre.replace("'", "\\'")
        pos += q(f"""SELECT c.position_x, c.position_y FROM dc_world.creature c JOIN dc_world.creature_template t ON t.entry=c.id
                     WHERE c.map={carte} AND t.name='{nom}'""")
    if not pos:
        rates.append((qid, titre))
        continue
    xs = [float(p[0]) for p in pos]; ys = [float(p[1]) for p in pos]
    mx, my = statistics.median(xs), statistics.median(ys)
    groupe = [(x, y) for x, y in zip(xs, ys) if (x - mx) ** 2 + (y - my) ** 2 <= 250 ** 2] or [(mx, my)]
    x0 = min(x for x, _ in groupe) - 30; x1 = max(x for x, _ in groupe) + 30
    y0 = min(y for _, y in groupe) - 30; y1 = max(y for _, y in groupe) + 30
    poi.append(f"({qid}, 0, 0, 0, 0, 0, {carte}, {wma.get(zone, 0)}, 0, 0, 0, 0, 0, 0, 0, 0)")
    for i, (x, y) in enumerate([(x0, y0), (x1, y0), (x1, y1), (x0, y1)]):
        pts.append(f"({qid}, 0, {i}, {int(x)}, {int(y)}, 0)")
    faits.append(qid)

O = '/home/ubuntu/DestinyCore/sql/sylvania/2026_10_08_expeditions_contours_deduits'
L = ["-- Contours DEDUITS (aucune source : ni LegionCore ni TDB 735.00) pour les expeditions du registre qui n'en avaient pas.",
     "-- Rectangle autour des apparitions des cibles (groupe principal dans 250 m de la mediane, marge 30 m) ;",
     "-- combats de mascottes : le dresseur du meme nom. Sans eux, l'expedition n'entre jamais dans le journal.",
     f"-- {len(faits)} quetes. Sans cible posee, non traitees : {', '.join(t for _, t in rates) or 'aucune'}.",
     "-- Rollback : ..._contours_deduits_rollback.sql", "",
     "INSERT INTO quest_poi (QuestID, BlobIndex, Idx1, ObjectiveIndex, QuestObjectiveID, QuestObjectID, MapID, WorldMapAreaId, Floor,",
     "  Priority, Flags, WorldEffectID, PlayerConditionID, WoDUnk1, AlwaysAllowMergingBlobs, VerifiedBuild) VALUES",
     ',\n'.join(poi) + ';', "",
     "INSERT INTO quest_poi_points (QuestID, Idx1, Idx2, X, Y, VerifiedBuild) VALUES", ',\n'.join(pts) + ';']
open(O + '.sql', 'w').write('\n'.join(L) + '\n')
I = ','.join(faits)
open(O + '_rollback.sql', 'w').write(f"-- Annule 2026_10_08_expeditions_contours_deduits.sql\nDELETE FROM quest_poi WHERE QuestID IN ({I}) AND VerifiedBuild=0;\n"
                                      f"DELETE FROM quest_poi_points WHERE QuestID IN ({I}) AND VerifiedBuild=0;\n")
print(len(faits), 'contours ;', len(rates), 'sans cible :', rates)
