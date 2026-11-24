#!/usr/bin/env python3
"""Patrouilles : nos PNJ immobiles que LegionCore fait patrouiller au meme endroit (meme modele a moins de 5 m).

Usage : gen_patrouilles.py > sortie.sql   (stats et ecartes sur stderr)
Trajet LC : creature_addon.path_id, sinon waypoint_data id = guid, sinon guid*10 (convention LegionCore).
Trajet chez nous : id = notre guid * 10 (libre, verifie), points LC (marche/course, attentes), sans scripts de point.
Ecartes : PNJ a script C++, SmartAI qui deplace le PNJ (lui-meme ou ses listes d'actions), membre (non meneur)
d'une formation, accessoire de vehicule, PNJ assis/couche ou en emote permanente, trajet de moins de 2 points,
deja un trajet ou un mouvement chez nous.
"""
import collections
import math
import subprocess
import sys


def q(sql):
    out = subprocess.run(["mysql", "-N", "-B", "-e", sql], capture_output=True, text=True)
    if out.returncode:
        raise SystemExit(out.stderr + sql)
    return [l.split("\t") for l in out.stdout.splitlines() if l]


MOVING = {29, 46, 53, 54, 55, 69, 89, 97, 114}
stats = collections.Counter()

# 1. candidats : nos spawns immobiles, LC patrouille du meme modele a moins de 5 m
lc = collections.defaultdict(list)
for g, e, m, x, y, z, pid in q("SELECT c.guid, c.id, c.map, c.position_x, c.position_y, c.position_z, COALESCE(a.path_id,0) "
                               "FROM lc_world_ref.creature c LEFT JOIN lc_world_ref.creature_addon a ON a.guid=c.guid WHERE c.MovementType=2"):
    lc[(e, m)].append((int(g), float(x), float(y), float(z), int(pid)))
ours = q("SELECT c.guid, c.id, c.map, c.position_x, c.position_y, c.position_z, t.ScriptName, t.AIName, "
         "COALESCE(a.path_id,0), COALESCE(a.emote,0), COALESCE(a.bytes1,0), a.guid IS NOT NULL "
         "FROM dc_world.creature c JOIN dc_world.creature_template t ON t.entry=c.id LEFT JOIN dc_world.creature_addon a ON a.guid=c.guid "
         "WHERE c.MovementType=0")
members = {r[0] for r in q("SELECT memberGUID FROM dc_world.creature_formations WHERE memberGUID<>leaderGUID")}
accessories = {r[0] for r in q("SELECT accessory_entry FROM dc_world.vehicle_template_accessory")}
paths = set()
lcpaths = {int(r[0]) for r in q("SELECT DISTINCT id FROM lc_world_ref.waypoint_data")}
ourpaths = {int(r[0]) for r in q("SELECT DISTINCT id FROM dc_world.waypoint_data")}

# SmartAI qui deplace : entree source 0 avec une action de mouvement, ou qui appelle une liste qui en a une
smart = collections.defaultdict(list)
for e, st, a, p1, p2, p3, p4, p5, p6 in q("SELECT entryorguid, source_type, action_type, action_param1, action_param2, action_param3, "
                                          "action_param4, action_param5, action_param6 FROM dc_world.smart_scripts WHERE source_type IN (0,9)"):
    smart[(st, e)].append((int(a), [int(p1), int(p2), int(p3), int(p4), int(p5), int(p6)]))


def moves(e):
    for a, p in smart.get(("0", e), []):
        if a in MOVING:
            return True
        lists = [p[0]] if a == 80 else [x for x in p if x] if a == 87 else list(range(p[0], p[1] + 1)) if a == 88 else []
        for lst in lists:
            if any(a2 in MOVING for a2, _ in smart.get(("9", str(lst)), [])):
                return True
    return False


taken, chosen = set(), []
for g, e, m, x, y, z, sn, ai, pid, emote, b1, has_addon in ours:
    cands = lc.get((e, m))
    if not cands:
        continue
    pos = (float(x), float(y), float(z))
    best = min(cands, key=lambda c: math.dist(pos, c[1:4]))
    d = math.dist(pos, best[1:4])
    if d >= 5 or math.dist(pos[:2], best[1:3]) >= 5:
        continue
    stats["candidats"] += 1
    if best[0] in taken:
        stats["trajet LC deja attribue a un autre de nos PNJ"] += 1
        continue
    why = None
    if sn:
        why = "script C++"
    elif ai == "SmartAI" and moves(e):
        why = "SmartAI qui deplace"
    elif g in members:
        why = "membre de formation"
    elif e in accessories:
        why = "accessoire de vehicule"
    elif int(pid):
        why = "deja un trajet"
    elif int(emote) or int(b1) & 0xFF:
        why = "emote ou posture permanente"
    if why:
        stats["ecarte : " + why] += 1
        continue
    lp = best[4] if best[4] in lcpaths else best[0] if best[0] in lcpaths else best[0] * 10 if best[0] * 10 in lcpaths else 0
    if not lp:
        stats["ecarte : pas de trajet LC"] += 1
        continue
    np_ = int(g) * 10
    if np_ in ourpaths or np_ > 0xFFFFFFFF:
        stats["ecarte : identifiant de trajet pris"] += 1
        continue
    taken.add(best[0])
    chosen.append((g, e, lp, np_, has_addon == "1", pos))

# 2. points
pts = collections.defaultdict(list)
lps = sorted({c[2] for c in chosen})
for i in range(0, len(lps), 2000):
    for r in q("SELECT id, point, position_x, position_y, position_z, orientation, delay, move_flag FROM lc_world_ref.waypoint_data "
               "WHERE id IN (%s) ORDER BY id, point" % ",".join(map(str, lps[i:i + 2000]))):
        pts[int(r[0])].append(r[1:])

print("-- Patrouilles reprises de LegionCore (gen_patrouilles.py) : nos PNJ immobiles que LC fait patrouiller au meme endroit.")
print("-- Trajet = notre guid * 10 ; points LC sans scripts de point. Ecartes : scripts C++, SmartAI qui deplace, formations,")
print("-- vehicules, postures permanentes.")
n = 0
for g, e, lp, np_, has_addon, pos in chosen:
    p = pts.get(lp, [])
    if len(p) < 2:
        stats["ecarte : trajet LC de moins de 2 points"] += 1
        continue
    # un numero de trajet LC peut coincider avec un guid sans etre le sien : le trajet doit passer pres du spawn
    if min(math.dist(pos[:2], (float(r[1]), float(r[2]))) for r in p) > 30:
        stats["ecarte : trajet LC qui ne passe pas a moins de 30 m du spawn"] += 1
        continue
    vals = []
    for k, (point, x, y, z, o, delay, mf) in enumerate(p):
        vals.append("(%d,%d,%s,%s,%s,%s,%d,%d,0,100,0)" % (np_, k + 1, x, y, z, o if o not in ("", "NULL") else "0", int(delay), 1 if mf == "1" else 0))
    print("INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES %s;" % ",".join(vals))
    if has_addon:
        print("UPDATE `creature_addon` SET `path_id`=%d WHERE `guid`=%s AND `path_id`=0;" % (np_, g))
    else:
        print("INSERT INTO `creature_addon` (`guid`,`path_id`) VALUES (%s,%d);" % (g, np_))
    print("UPDATE `creature` SET `MovementType`=2, `spawndist`=0 WHERE `guid`=%s AND `MovementType`=0; -- id %s, LC %d" % (g, e, lp))
    n += 1
stats["poses"] = n
for k, v in sorted(stats.items()):
    print("%s : %d" % (k, v), file=sys.stderr)
