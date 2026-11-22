#!/usr/bin/env python3
"""Statistiques de modeles reprises de la TDB 7.3.5 quand les notres sont au defaut (rang 0, vie x1).

Usage : tdb_modeles.py <nom> <portage.sql> [<dossier de scripts>...]
Entrees : celles des apparitions du portage et des enumerations des dossiers. Pour chaque modele ou
nous avons HealthModifier = 1 et rank = 0 alors que la TDB (donnees de sniff) a autre chose : rang,
type_flags, multiplicateurs de vie, mana, armure, degats, expansion de vie et classe d'unite.
"""
import glob
import os
import re
import subprocess
import sys

name, port = sys.argv[1], sys.argv[2]
folders = sys.argv[3:]
entries = {int(m.group(1)) for m in re.finditer(r"^INSERT INTO `creature` \(.*?\) VALUES \(\d+,(\d+),", open(port, encoding="utf-8").read(), re.M)}
for f in folders:
    src = "".join(open(p, encoding="latin1").read() for p in glob.glob(os.path.join(f, "*.cpp")) + glob.glob(os.path.join(f, "*.h")))
    entries |= {int(v) for k, v in re.findall(r"\b((?:NPC|BOSS|MOB|CREATURE)_[A-Z0-9_]+)\s*=\s*(\d+)", src) if int(v) > 1000}
    entries |= {int(v) for v in re.findall(r"\bnpc_\w+_(\d{5,6})\b", src)}

out = subprocess.run(["python3", "/home/ubuntu/tmp/tdb_extraire.py", "creature_template", "entry", ",".join(map(str, sorted(entries)))],
                     capture_output=True, text=True).stdout.splitlines()
head = out[0].split("\t")
tdb = {}
for l in out[1:]:
    d = dict(zip(head, l.split("\t")))
    tdb[int(d["entry"])] = d
ours = {}
for l in subprocess.run(["mysql", "-N", "dc_world", "-e", "SELECT entry,name,rank,HealthModifier FROM creature_template WHERE entry IN (%s)" % ",".join(map(str, sorted(entries)))],
                        capture_output=True, text=True).stdout.splitlines():
    e, n, r, hm = l.split("\t")
    ours[int(e)] = (n, int(r), float(hm))
COLS = ["rank", "type_flags", "type_flags2", "HealthModifier", "HealthModifierExtra", "ManaModifier", "ManaModifierExtra",
        "ArmorModifier", "DamageModifier", "HealthScalingExpansion", "unit_class"]
sql = ["-- Modeles au defaut (rang 0, vie x1) completes d'apres la TDB 7.3.5 (TrinityCore 735.00, 2018-02-19)"]
for e in sorted(entries):
    if e not in ours or e not in tdb:
        continue
    n, r, hm = ours[e]
    d = tdb[e]
    if r != 0 or hm != 1.0 or (int(d["rank"]) == 0 and float(d["HealthModifier"]) == 1.0):
        continue
    s = {k: d[k] for k in COLS if k in d}
    if "unit_class" in s and s["unit_class"] == "0":
        del s["unit_class"]
    sql.append("UPDATE `creature_template` SET %s WHERE entry=%d AND `rank`=0 AND HealthModifier=1; -- %s" % (
        ", ".join("`%s`=%s" % (k, v) for k, v in s.items()), e, n))
# repli : cache client de LegionCore (creature_template_wdb), rang 1 pour tout ce qui n'est pas normal (comme la TDB)
rest = [e for e in sorted(entries) if e in ours and e not in tdb and ours[e][1] == 0 and ours[e][2] == 1.0]
if rest:
    wdb = subprocess.run(["mysql", "-N", "lc_world_ref", "-e", "SELECT Entry,TypeFlags,TypeFlags2,Classification,HpMulti,PowerMulti,RequiredExpansion "
                          "FROM creature_template_wdb WHERE Entry IN (%s)" % ",".join(map(str, rest))], capture_output=True, text=True).stdout.splitlines()
    for l in wdb:
        e, tf, tf2, cl, hp, pw, ex = l.split("\t")
        if float(hp) == 1.0 and cl == "0":
            continue
        sql.append("UPDATE `creature_template` SET `rank`=%d, `type_flags`=%s, `type_flags2`=%s, `HealthModifier`=%s, `ManaModifier`=%s, "
                   "`HealthScalingExpansion`=%s WHERE entry=%s AND `rank`=0 AND HealthModifier=1; -- %s (cache client LegionCore)" % (
                       1 if cl != "0" else 0, tf, tf2, hp, pw, ex, e, ours[int(e)][0]))
open(name + ".sql", "w", encoding="utf-8").write("\n".join(sql) + "\n")
print("%s.sql : %d modeles" % (name, len(sql) - 1))
