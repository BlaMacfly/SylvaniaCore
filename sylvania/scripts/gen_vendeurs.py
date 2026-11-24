#!/usr/bin/env python3
"""Marchands poses chez nous auxquels il manque des objets par rapport a LegionCore : objets manquants ajoutes.

Usage (dans ~/tmp/refs : items.txt = Item.db2 + hotfix, xcost.txt = ItemExtendedCost.db2 + hotfix) :
gen_vendeurs.py > sortie.sql
Source : la TDB 7.3.5 si elle a ce marchand, sinon LegionCore. Seuls les objets absents chez nous (objet + cout + type)
sont ajoutes, apres nos emplacements. Ecartes : marchands JcJ (gladiateur, combattant, conquete : LegionCore a
reecrit ses saisons), objets ou couts absents du client.
"""
import collections
import re
import subprocess
import sys


def q(sql):
    out = subprocess.run(["mysql", "-N", "-B", "-e", sql], capture_output=True, text=True)
    if out.returncode:
        raise SystemExit(out.stderr + sql)
    return [l.split("\t") for l in out.stdout.splitlines() if l]


items = set(open("items.txt").read().split())
xcost = set(open("xcost.txt").read().split()) | {"0"}
vendors = q("SELECT l.entry, t.name, t.subname FROM (SELECT entry, COUNT(*) n FROM lc_world_ref.npc_vendor GROUP BY entry) l "
            "LEFT JOIN (SELECT entry, COUNT(*) n FROM dc_world.npc_vendor GROUP BY entry) d ON d.entry=l.entry "
            "JOIN dc_world.creature_template t ON t.entry=l.entry WHERE d.n IS NULL "
            "AND EXISTS (SELECT 1 FROM dc_world.creature c WHERE c.id=l.entry)")
stats = collections.Counter()
keep = []
for e, name, sub in vendors:
    if re.search(r"Gladiator|Combatant|Conquest|Honor|Arena|Rated|Elite", sub or "", re.I):
        stats["marchand JcJ ecarte"] += 1
        continue
    keep.append(e)
ids = ",".join(keep)
tdb_out = subprocess.run(["python3", "/home/ubuntu/tmp/tdb_extraire2.py", "npc_vendor", "entry", ids], capture_output=True, text=True).stdout.splitlines()
tcols = tdb_out[0].split("\t")
tdb = collections.defaultdict(list)
for l in tdb_out[1:]:
    d = dict(zip(tcols, l.split("\t")))
    tdb[d["entry"]].append((d["item"], d["maxcount"], d["incrtime"], d["ExtendedCost"], d["type"], d.get("PlayerConditionID", "0"), d.get("IgnoreFiltering", "0")))
lc = collections.defaultdict(list)
for r in q("SELECT entry, item, maxcount, incrtime, ExtendedCost, type, PlayerConditionID, IgnoreFiltering FROM lc_world_ref.npc_vendor "
           "WHERE entry IN (%s) ORDER BY entry, slot" % ids):
    lc[r[0]].append(tuple(r[1:]))
ours = collections.defaultdict(set)
maxslot = collections.Counter()
for e, it, xc, ty, sl in q("SELECT entry, item, ExtendedCost, type, slot FROM dc_world.npc_vendor WHERE entry IN (%s)" % ids):
    ours[e].add((it, xc, ty))
    maxslot[e] = max(maxslot[e], int(sl))
rows = []
src_of = {}
for e in keep:
    src, lst = ("TDB", tdb[e]) if tdb.get(e) else ("LC", lc[e])
    n = 0
    for it, mc, inc, xc, ty, pc, ign in lst:
        if (it, xc, ty) in ours[e]:
            continue
        if ty == "1" and it not in items:
            stats["objet absent du client"] += 1
            continue
        if xc not in xcost:
            stats["cout absent du client"] += 1
            continue
        maxslot[e] += 1
        ours[e].add((it, xc, ty))
        rows.append("(%s,%d,%s,%s,%s,%s,-1,%s,'',%s,%s,0)" % (e, maxslot[e], it, mc, inc, xc, ty, pc or 0, ign or 0)); src_of[e] = src
        n += 1
    if n:
        stats["marchands completes (%s)" % src] += 1
        stats["objets ajoutes"] += n
print("-- Objets manquants de nos marchands, d apres la TDB 7.3.5 si elle a le marchand, sinon LegionCore (gen_vendeurs.py).")
print("-- Marchands JcJ ecartes ; objets et couts absents du client ecartes.")
for i in range(0, len(rows), 500):
    print("INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`OverrideGoldCost`,`type`,`BonusListIDs`,"
          "`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES\n%s;" % ",\n".join(rows[i:i + 500]))
for k, v in sorted(stats.items()):
    print("%s : %d" % (k, v), file=sys.stderr)
open("sources.txt", "w").write("\n".join("%s %s" % kv for kv in src_of.items()) + "\n")
