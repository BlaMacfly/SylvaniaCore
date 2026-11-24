#!/usr/bin/env python3
"""Bestioles (creature_template.type 8) : par modele et par carte, l'ecart d'effectif avec LegionCore est comble.

Usage : gen_bestioles.py > sortie.sql   (stats sur stderr)
Les mascottes sauvages des combats de mascottes sont tirees de ces bestioles (wild_battlepet_zone_pool) :
la Pandarie en avait 1857 contre 6401 chez LC. On ajoute, pour chaque (modele, carte), les apparitions LC les
plus eloignees des notres, autant que l'ecart ; jamais a moins de 10 m d'une des notres du meme modele.
Ecartes : apparitions LC en phase ou d'evenement, cartes d'instance, modeles propres a LC (>= 400000).
GUID neufs ; modele d'affichage laisse au gabarit ; deplacement aleatoire garde (trajet LC -> aleatoire 5 m).
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


critters = {r[0] for r in q("SELECT entry FROM dc_world.creature_template WHERE type=8 AND entry<400000")}
instances = {r[0] for r in q("SELECT map FROM dc_world.instance_template")}
ev = {r[0] for r in q("SELECT guid FROM lc_world_ref.game_event_creature")}
ours = collections.defaultdict(list)
for e, m, x, y, z in q("SELECT id, map, position_x, position_y, position_z FROM dc_world.creature"):
    if e in critters:
        ours[(e, m)].append((float(x), float(y), float(z)))
lc = collections.defaultdict(list)
stats = collections.Counter()
for r in q("SELECT guid, id, map, zoneId, areaId, spawnMask, position_x, position_y, position_z, orientation, spawntimesecs, "
           "spawndist, MovementType, curhealth, PhaseId FROM lc_world_ref.creature WHERE id<400000"):
    g, e, m = r[0], r[1], r[2]
    if e not in critters:
        continue
    if m in instances:
        stats["ecarte : instance"] += 1
        continue
    if g in ev or (r[14] and r[14] != "0"):
        stats["ecarte : phase ou evenement"] += 1
        continue
    lc[(e, m)].append(r)
guid = int(q("SELECT MAX(guid) FROM dc_world.creature")[0][0]) + 1000
print("-- Bestioles reprises de LegionCore (gen_bestioles.py) : ecart d effectif par modele et par carte, apparitions LC")
print("-- les plus eloignees des notres. Source des mascottes sauvages (wild_battlepet_zone_pool).")
rows = []
for (e, m), lst in sorted(lc.items(), key=lambda kv: (int(kv[0][1]), int(kv[0][0]))):
    mine = ours[(e, m)]
    gap = len(lst) - len(mine)
    if gap <= 0:
        continue
    scored = []
    for r in lst:
        p = (float(r[6]), float(r[7]), float(r[8]))
        scored.append((min((math.dist(p, o) for o in mine), default=1e9), r, p))
    scored.sort(key=lambda s: -s[0])
    for d, r, p in scored[:gap]:
        if d < 10:
            stats["ecarte : a moins de 10 m d une des notres"] += 1
            continue
        mt, sd = int(r[12]), float(r[11])
        if mt == 2:
            mt, sd = 1, 5.0
        if mt == 1 and sd <= 0:
            sd = 5.0
        mask = int(r[5])
        diff = ",".join(str(i) for i in range(64) if mask >> i & 1) or "0"
        rows.append("(%d,%s,%s,%s,%s,'%s',0,0,0,-1,0,0,%s,%s,%s,%s,%s,%s,0,%s,0,%d,0,0,0,0,'',0,0)" % (
            guid, e, m, r[3], r[4], diff, p[0], p[1], p[2], r[9], r[10], sd if mt == 1 else 0, r[13], mt))
        guid += 1
        stats["poses carte %s" % m] += 1
cols = ("guid,id,map,zoneId,areaId,spawnDifficulties,phaseUseFlags,PhaseId,PhaseGroup,terrainSwapMap,modelid,equipment_id,"
        "position_x,position_y,position_z,orientation,spawntimesecs,spawndist,currentwaypoint,curhealth,curmana,MovementType,"
        "npcflag,unit_flags,unit_flags2,unit_flags3,ScriptName,movementmode,VerifiedBuild")
for i in range(0, len(rows), 500):
    print("INSERT INTO `creature` (%s) VALUES\n%s;" % (",".join("`%s`" % c for c in cols.split(",")), ",\n".join(rows[i:i + 500])))
stats["total"] = len(rows)
for k, v in sorted(stats.items(), key=lambda kv: -kv[1]):
    print("%s : %d" % (k, v), file=sys.stderr)
