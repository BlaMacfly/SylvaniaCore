#!/usr/bin/env python3
"""Complements d'un portage port_carte.py : apparences, trajets et modeles squelettes, depuis LegionCore.

Usage : complements_carte.py <nom> <portage.sql> [<dossier de scripts>...]
- creature_addon des apparitions portees (monture, postures, emote, auras) ;
- trajets LegionCore (creature_addon.path_id -> waypoint_data), chemin = guid * 10, MovementType 2 ;
- modeles squelettes (niveau 1 chez nous, issus du seul cache client : amicaux, sans statistiques) :
  niveaux, faction, vitesses, attaque, drapeaux, immunites, or, et ce qui manque (npcflag, gossip,
  vehicule, sorts) ; les entrees des enumerations des dossiers de scripts sont traitees aussi
  (creatures invoquees par les scripts, jamais posees) ;
- creature_template_addon des memes modeles s'il manque chez nous.
Ne reecrit jamais une valeur deja renseignee chez nous, sauf sur un modele squelette.
"""
import glob
import os
import re
import subprocess
import sys

LC, DC = "lc_world_ref", "dc_world"
STATE_FLAGS = 0x4000018
# drapeaux flags_extra de meme sens dans les deux cores (0x200 et 0x400000+ different chez LegionCore)
EXTRA_OK = 0x1 | 0x2 | 0x4 | 0x8 | 0x10 | 0x20 | 0x40 | 0x80 | 0x100 | 0x4000 | 0x8000 | 0x20000 | 0x40000 | 0x80000 | 0x100000 | 0x200000 | 0x20000000 | 0x40000000


def q(db, sql):
    out = subprocess.run(["mysql", db, "-B", "-e", sql], capture_output=True, text=True)
    if out.returncode:
        raise SystemExit("SQL %s : %s\n%s" % (db, out.stderr, sql))
    lines = out.stdout.split("\n")
    if not lines or not lines[0]:
        return []
    cols = lines[0].split("\t")
    return [dict(zip(cols, [None if v == "NULL" else v for v in l.split("\t")])) for l in lines[1:] if l != ""]


def ids(xs):
    xs = sorted(set(int(x) for x in xs))
    return ",".join(map(str, xs)) if xs else "NULL"


def lit(v):
    if v is None:
        return "NULL"
    if isinstance(v, (int, float)):
        return repr(v)
    return "'" + str(v).replace("\\", "\\\\").replace("'", "\\'") + "'"


name, port = sys.argv[1], sys.argv[2]
folders = sys.argv[3:]
sql, log = ["-- Complements LegionCore de %s" % os.path.basename(port)], []

# apparitions portees : notre guid -> guid LegionCore
spawns = {}
for m in re.finditer(r"^INSERT INTO `creature` \(.*?\) VALUES \((\d+),(\d+),.*-- LC (\d+)$", open(port, encoding="utf-8").read(), re.M):
    spawns[int(m.group(3))] = (int(m.group(1)), int(m.group(2)))

# ---------------------------------------------------------------- 1. apparences et trajets
addons = {int(r["guid"]): r for r in q(LC, "SELECT * FROM creature_addon WHERE guid IN (%s)" % ids(spawns))}
paths = {int(r["path_id"]) for r in addons.values() if r["path_id"] and int(r["path_id"])}
wp = {}
for r in q(LC, "SELECT * FROM waypoint_data WHERE id IN (%s) ORDER BY id,point" % ids(paths)):
    wp.setdefault(int(r["id"]), []).append(r)
lcmove = {int(r["guid"]): int(r["MovementType"]) for r in q(LC, "SELECT guid,MovementType FROM creature WHERE guid IN (%s)" % ids(spawns))}
sql.append("\n-- 1. Apparences et trajets des apparitions portees")
npath = 0
for lg, (g, e) in sorted(spawns.items()):
    a = addons.get(lg)
    path = 0
    if a and a["path_id"] and int(a["path_id"]) in wp:
        path = g * 10
        for r in wp[int(a["path_id"])]:
            mt = int(r["move_flag"] or 0)
            sql.append("INSERT INTO `waypoint_data` (id,point,position_x,position_y,position_z,orientation,delay,move_type,action,action_chance,wpguid) "
                       "VALUES (%d,%d,%s,%s,%s,%s,%d,%d,0,100,0);" % (path, int(r["point"]), r["position_x"], r["position_y"], r["position_z"],
                                                                     r["orientation"] or 0, int(r["delay"] or 0), mt if mt < 4 else 0))
        sql.append("UPDATE `creature` SET MovementType=2, spawndist=0 WHERE guid=%d;" % g)
        npath += 1
    elif lcmove.get(lg) == 2:
        L = "trajet LegionCore absent (chemin %s)" % (a["path_id"] if a else "-")
        log.append("CHEMIN %d (id %d, LC %d) : %s" % (g, e, lg, L))
    if a or path:
        auras = (a["auras"] or "").strip() if a else ""
        sql.append("INSERT INTO `creature_addon` (guid,path_id,mount,bytes1,bytes2,emote,aiAnimKit,movementAnimKit,meleeAnimKit,visibilityDistanceType,auras) "
                   "VALUES (%d,%d,%d,%d,%d,%d,0,0,0,0,%s);" % (g, path, int(a["mount"] or 0) if a else 0, int(a["bytes1"] or 0) if a else 0,
                                                               int(a["bytes2"] or 0) if a else 0, int(a["emote"] or 0) if a else 0, lit(auras)))
log.append("TRAJETS : %d portes" % npath)

# ---------------------------------------------------------------- 2. modeles squelettes
entries = {e for g, e in spawns.values()}
for f in folders:
    src = "".join(open(p, encoding="latin1").read() for p in glob.glob(os.path.join(f, "*.cpp")) + glob.glob(os.path.join(f, "*.h")))
    entries |= {int(v) for k, v in re.findall(r"\b((?:NPC|BOSS|MOB|CREATURE)_[A-Z0-9_]+)\s*=\s*(\d+)", src) if int(v) > 1000}
dc_t = {int(r["entry"]): r for r in q(DC, "SELECT * FROM creature_template WHERE entry IN (%s)" % ids(entries))}
lc_t = {int(r["entry"]): r for r in q(LC, "SELECT * FROM creature_template WHERE entry IN (%s)" % ids(entries))}
menus = {int(r["m"]) for r in q(DC, "SELECT DISTINCT MenuID m FROM gossip_menu")}
sql.append("\n-- 2. Modeles squelettes (niveau 1, cache client seul) completes d'apres LegionCore")
fixed = []
for e in sorted(entries):
    d, l = dc_t.get(e), lc_t.get(e)
    if not d or not l:
        continue
    if not (int(d["minlevel"]) <= 1 and int(d["maxlevel"]) <= 1 and int(l["minlevel"]) > 1):
        continue
    s = {"minlevel": int(l["minlevel"]), "maxlevel": int(l["maxlevel"]), "faction": int(l["faction"]),
         "speed_walk": float(l["speed_walk"]), "speed_run": float(l["speed_run"]),
         "BaseAttackTime": int(l["baseattacktime"]), "RangeAttackTime": int(l["rangeattacktime"]),
         "unit_class": int(l["unit_class"]) or 1, "unit_flags": int(l["unit_flags"]) & ~STATE_FLAGS,
         "unit_flags2": int(l["unit_flags2"]), "unit_flags3": int(l["unit_flags3"]),
         "mingold": int(l["mingold"]), "maxgold": int(l["maxgold"]),
         "mechanic_immune_mask": int(l["mechanic_immune_mask"]),
         "flags_extra": (int(d["flags_extra"]) | int(l["flags_extra"])) & EXTRA_OK,
         "InhabitType": int(l["InhabitType"]), "RegenHealth": int(l["RegenHealth"])}
    if not int(d["npcflag"]):
        s["npcflag"] = int(l["npcflag"]) | (int(l["npcflag2"] or 0) << 32)
    gm = int(l["gossip_menu_id"])
    if not int(d["gossip_menu_id"]) and gm:
        if gm in menus:
            s["gossip_menu_id"] = gm
        else:
            log.append("MODELE %d : menu %d de LegionCore absent chez nous" % (e, gm))
    if not int(d["VehicleId"]) and int(l["VehicleId"]):
        s["VehicleId"] = int(l["VehicleId"])
    if not any(int(d["spell%d" % i]) for i in range(1, 9)) and any(int(l["spell%d" % i]) for i in range(1, 9)):
        s.update({"spell%d" % i: int(l["spell%d" % i]) for i in range(1, 9)})
    sql.append("UPDATE `creature_template` SET %s WHERE entry=%d AND minlevel<=1 AND maxlevel<=1; -- %s" % (
        ", ".join("`%s`=%s" % (k, lit(v)) for k, v in s.items()), e, d["name"]))
    fixed.append(e)
log.append("MODELES : %d squelettes completes" % len(fixed))

# ---------------------------------------------------------------- 3. creature_template_addon
have = {int(r["entry"]) for r in q(DC, "SELECT entry FROM creature_template_addon WHERE entry IN (%s)" % ids(fixed))}
sql.append("\n-- 3. creature_template_addon manquants")
for r in q(LC, "SELECT * FROM creature_template_addon WHERE entry IN (%s)" % ids(set(fixed) - have)):
    path = int(r["path_id"] or 0)
    if path:
        log.append("MODELE %s : chemin de modele %d non porte" % (r["entry"], path))
    sql.append("INSERT INTO `creature_template_addon` (entry,path_id,mount,bytes1,bytes2,emote,aiAnimKit,movementAnimKit,meleeAnimKit,visibilityDistanceType,auras) "
               "VALUES (%s,0,%d,%d,%d,%d,0,0,0,0,%s);" % (r["entry"], int(r["mount"] or 0), int(r["bytes1"] or 0), int(r["bytes2"] or 0),
                                                          int(r["emote"] or 0), lit((r["auras"] or "").strip())))

open(name + ".sql", "w", encoding="utf-8").write("\n".join(sql) + "\n")
open(name + ".log", "w", encoding="utf-8").write("\n".join(log) + "\n")
print("%s.sql : %d lignes ; %s.log : %d remarques" % (name, len(sql), name, len(log)))
