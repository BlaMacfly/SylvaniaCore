#!/usr/bin/env python3
"""Entraineurs poses sans rien a enseigner : rattaches (creature_default_trainer) a celui de NOS entraineurs officiels
dont la liste de sorts recouvre le mieux la liste LegionCore du PNJ (npc_trainer). Pas de nouvelle liste inventee.
Usage : entraineurs.py <sortie.sql> [seuil]   (dans ~/tmp/refs : tr_ids.txt)"""
import collections, subprocess, sys
def q(sql):
    return [l.split("\t") for l in subprocess.run(["mysql", "-N", "-B", "-e", sql], capture_output=True, text=True).stdout.splitlines() if l]
SEUIL = float(sys.argv[2]) if len(sys.argv) > 2 else 0.7
ids = open("tr_ids.txt").read().split()
ours = collections.defaultdict(set)
for t, s in q("SELECT TrainerId, SpellId FROM dc_world.trainer_spell"):
    ours[t].add(s)
lc = collections.defaultdict(set)
for e, s in q("SELECT entry, spell FROM lc_world_ref.npc_trainer WHERE entry IN (%s)" % ",".join(ids)):
    lc[e].add(s)
names = {r[0]: (r[1], r[2]) for r in q("SELECT entry, name, COALESCE(subname,'') FROM dc_world.creature_template WHERE entry IN (%s)" % ",".join(ids))}
out = ["-- Entraineurs poses sans rien a enseigner, rattaches a celui de nos entraineurs dont la liste recouvre le mieux"
       " la liste LegionCore du PNJ (seuil %.2f ; recouvrement = sorts LC trouves chez nous / sorts LC)." % SEUIL]
stats = collections.Counter()
for e in ids:
    s = lc.get(e)
    if not s:
        stats["sans liste LC"] += 1
        continue
    best, score = None, 0
    for t, sp in ours.items():
        inter = len(s & sp)
        sc = inter / len(s) * (inter / len(sp)) ** 0.5   # recouvrement de la liste LC, penalise les listes trop larges
        if sc > score:
            best, score = t, sc
    if score < SEUIL:
        stats["recouvrement insuffisant"] += 1
        print("ECARTE %s %s <%s> meilleur %s %.2f (%d sorts LC)" % (e, names[e][0], names[e][1], best, score, len(s)), file=sys.stderr)
        continue
    out.append("INSERT INTO `creature_default_trainer` (`CreatureId`,`TrainerId`) VALUES (%s,%s); -- %s <%s>, recouvrement %.2f"
               % (e, best, names[e][0].replace("'", ""), names[e][1].replace("'", ""), score))
    stats["rattaches"] += 1
open(sys.argv[1], "w").write("\n".join(out) + "\n")
print(dict(stats), file=sys.stderr)
