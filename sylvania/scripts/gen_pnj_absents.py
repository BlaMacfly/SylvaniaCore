#!/usr/bin/env python3
"""PNJ jamais poses chez nous (modele present) que LegionCore pose en monde ouvert, hors phase et hors evenement.

Usage : gen_pnj_absents.py > sortie.sql   (stats sur stderr ; liste des entrees posees dans pnj_absents_poses.txt)
Ecartes, car apparus chez nous autrement ou risques :
- invoques chez nous : sort d'invocation (SpellEffect 28/56), SmartAI (actions 12 / 107), creature_summon_groups,
  event_scripts (commande 10), ou cite dans un script C++ (numero dans src/server/scripts) ;
- accessoires de vehicule ; PNJ exclus par nos boucles de phasage (ils creaient des blocages de quetes) ;
- Rivage brise (7543) et intro de Tanaan (7025), phases a la main ;
- bestioles (portees a part), modeles propres a LC (>= 400000), instances ;
- cartes hors monde ouvert : scenarios (PNJ pilotes par etapes) et cartes BfA ; seules les cartes OUVERTES sont gardees.
Patrouilles LC reprises (trajet LC sous notre guid * 10) ; modele d'affichage laisse au gabarit.
"""
import collections
import glob
import re
import subprocess
import sys

sys.path.insert(0, "/home/ubuntu")
from db2read import DB2


def q(sql):
    out = subprocess.run(["mysql", "-N", "-B", "-e", sql], capture_output=True, text=True)
    if out.returncode:
        raise SystemExit(out.stderr + sql)
    return [l.split("\t") for l in out.stdout.splitlines() if l]


OUVERTES = {"0", "1", "530", "571", "646", "648", "654", "860", "870", "1064", "1116", "1220", "1669", "732", "974", "1464"}
stats = collections.Counter()
spawned = {r[0] for r in q("SELECT DISTINCT id FROM dc_world.creature")}
tpl = {r[0]: r for r in q("SELECT entry, type, ScriptName, AIName FROM dc_world.creature_template WHERE entry<400000")}
instances = {r[0] for r in q("SELECT map FROM dc_world.instance_template")}
ev = {r[0] for r in q("SELECT guid FROM lc_world_ref.game_event_creature")}

summoned = set()
se = DB2("/home/ubuntu/server/data/dbc/enUS/SpellEffect.db2", "iiiiiififfiiiiffififfffffiiiii", [1] * 25 + [4, 2, 2, 2, 1], 0, 29)
for r in range(se.recCount):
    if se.getRaw(r, 1, 0, "i") in (28, 56):
        summoned.add(str(se.getRaw(r, 26, 0, "i")))
n_spell = len(summoned)
summoned |= {r[0] for r in q("SELECT DISTINCT action_param1 FROM dc_world.smart_scripts WHERE action_type=12")}
summoned |= {r[0] for r in q("SELECT DISTINCT entry FROM dc_world.creature_summon_groups")}
summoned |= {r[0] for r in q("SELECT DISTINCT datalong FROM dc_world.event_scripts WHERE command=10")}
summoned |= {r[0] for r in q("SELECT DISTINCT accessory_entry FROM dc_world.vehicle_template_accessory")}
cited = set()
for f in glob.glob("/home/ubuntu/DestinyCore/src/server/scripts/**/*.cpp", recursive=True) + \
         glob.glob("/home/ubuntu/DestinyCore/src/server/scripts/**/*.h", recursive=True):
    cited |= set(re.findall(r"\b\d{4,6}\b", open(f, encoding="latin1").read()))
exclus = set()
for f in glob.glob("/home/ubuntu/tmp/phasage/exclus*.txt"):
    exclus |= {x for x in re.split(r"[,\s]+", open(f).read()) if x}

lcpaths = {r[0] for r in q("SELECT DISTINCT id FROM lc_world_ref.waypoint_data")}
addon_path = {r[0]: r[1] for r in q("SELECT guid, path_id FROM lc_world_ref.creature_addon WHERE path_id<>0")}
rows, chosen = [], []
guid = int(q("SELECT MAX(guid) FROM dc_world.creature")[0][0]) + 1000
for r in q("SELECT guid, id, map, zoneId, areaId, spawnMask, position_x, position_y, position_z, orientation, spawntimesecs, "
           "spawndist, MovementType, curhealth, curmana, PhaseId, npcflag, unit_flags FROM lc_world_ref.creature WHERE id<400000"):
    g, e, m, zone = r[0], r[1], r[2], r[3]
    if e in spawned or e not in tpl or tpl[e][1] == "8":
        continue
    if m in instances or g in ev or (r[15] and r[15] != "0"):
        continue
    if m not in OUVERTES:
        stats["ecarte : carte %s (scenario, BfA...)" % m] += 1
        continue
    why = None
    if e in summoned:
        why = "invoque chez nous"
    elif e in cited:
        why = "cite dans un script C++"
    elif e in exclus:
        why = "exclu par le phasage"
    elif zone in ("7543", "7025"):
        why = "Rivage brise / intro de Tanaan"
    if why:
        stats["ecarte : " + why] += 1
        continue
    mt, sd = int(r[12]), float(r[11])
    path = None
    if mt == 2:
        lp = addon_path.get(g) if addon_path.get(g) in lcpaths else g if g in lcpaths else str(int(g) * 10) if str(int(g) * 10) in lcpaths else None
        if lp:
            path = lp
        else:
            mt, sd = 0, 0
    if mt == 1 and sd <= 0:
        sd = 5.0
    if mt == 0:
        sd = 0
    mask = int(r[5])
    diff = ",".join(str(i) for i in range(64) if mask >> i & 1) or "0"
    rows.append("(%d,%s,%s,%s,%s,'%s',0,0,0,-1,0,0,%s,%s,%s,%s,%s,%s,0,%s,%s,%d,0,0,0,0,'',0,0)" % (
        guid, e, m, zone, r[4], diff, r[6], r[7], r[8], r[9], r[10], sd, r[13], r[14], mt))
    if path:
        chosen.append((guid, path))
    stats["poses carte %s" % m] += 1
    stats["poses"] += 1
    guid += 1
    spawned_new = True
print("-- PNJ jamais poses chez nous que LegionCore pose en monde ouvert, hors phase et hors evenement (gen_pnj_absents.py).")
print("-- Ecartes : invoques chez nous (sorts, SmartAI, groupes, scripts d evenement, C++), vehicules, exclus du phasage.")
cols = ("guid,id,map,zoneId,areaId,spawnDifficulties,phaseUseFlags,PhaseId,PhaseGroup,terrainSwapMap,modelid,equipment_id,"
        "position_x,position_y,position_z,orientation,spawntimesecs,spawndist,currentwaypoint,curhealth,curmana,MovementType,"
        "npcflag,unit_flags,unit_flags2,unit_flags3,ScriptName,movementmode,VerifiedBuild")
for i in range(0, len(rows), 500):
    print("INSERT INTO `creature` (%s) VALUES\n%s;" % (",".join("`%s`" % c for c in cols.split(",")), ",\n".join(rows[i:i + 500])))
pts = collections.defaultdict(list)
lps = sorted({p for _, p in chosen}, key=int)
for i in range(0, len(lps), 2000):
    for w in q("SELECT id, point, position_x, position_y, position_z, orientation, delay, move_flag FROM lc_world_ref.waypoint_data "
               "WHERE id IN (%s) ORDER BY id, point" % ",".join(lps[i:i + 2000])):
        pts[w[0]].append(w[1:])
for g, p in chosen:
    pp = pts.get(p, [])
    if len(pp) < 2:
        print("UPDATE `creature` SET `MovementType`=0 WHERE `guid`=%d;" % g)
        continue
    print("INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES %s;"
          % ",".join("(%d,%d,%s,%s,%s,%s,%d,%d,0,100,0)" % (g * 10, k + 1, x, y, z, o if o not in ("", "NULL") else "0", int(d), 1 if mf == "1" else 0)
                     for k, (pt, x, y, z, o, d, mf) in enumerate(pp)))
    print("INSERT INTO `creature_addon` (`guid`,`path_id`) VALUES (%d,%d);" % (g, g * 10))
    stats["patrouilles"] += 1
open("pnj_absents_poses.txt", "w").write("\n".join(sorted({r.split(",")[1] for r in rows}, key=int)) + "\n")
print("-- sorts d invocation lus : %d entrees" % n_spell, file=sys.stderr)
for k, v in sorted(stats.items(), key=lambda kv: -kv[1]):
    print("%s : %d" % (k, v), file=sys.stderr)
