#!/usr/bin/env python3
"""Regroupe les spawns ajoutes/rephases par phasage_<zone>.sql selon leur ensemble de phases final, avec la
condition d'activation de chaque phase."""
import collections, csv, re, subprocess, sys
Z = int(sys.argv[1])
def q(db, sql):
    o = subprocess.run(["mysql", "-N", db, "-e", sql], capture_output=True, text=True, check=True).stdout
    return [l.split("\t") for l in o.split("\n") if l]
names = {int(e): n for e, n in q("dc_world", "SELECT entry,name FROM creature_template")}
gnames = {int(e): n for e, n in q("dc_world", "SELECT entry,name FROM gameobject_template")}
groups = collections.defaultdict(set)
for r in csv.DictReader(open("/home/ubuntu/tmp/PhaseXPhaseGroup.csv")):
    groups[int(r["PhaseGroupID"])].add(int(r["PhaseID"]))
for p, g in q("dc_hotfixes", "SELECT PhaseID,PhaseGroupID FROM phase_x_phase_group"):
    groups[int(g)].add(int(p))
s = open("/home/ubuntu/tmp/phasage/phasage_%d.sql" % Z).read()
for p, g in re.findall(r"VALUES \(\d+,(\d+),(\d+),0\)", open("/home/ubuntu/tmp/phasage/phasage_%d_hotfixes.sql" % Z).read()):
    groups[int(g)].add(int(p))
cond = collections.defaultdict(list)
for p, eg, t, v1, neg in re.findall(r"VALUES \(26,(\d+),%d,0,(\d+),(\d+),\d+,(\d+),\d+,\d+,(\d+)," % Z, s):
    cond[int(p)].append((eg, ("!" if neg == "1" else "") + "%s:%s" % (t, v1)))
for p, eg, t, v1, neg in q("dc_world", "SELECT SourceGroup,ElseGroup,ConditionTypeOrReference,ConditionValue1,NegativeCondition FROM conditions WHERE SourceTypeOrReferenceId=26 AND SourceEntry=%d" % Z):
    if int(p) not in cond or True:
        cond[int(p)].append((eg, ("!" if neg == "1" else "") + "%s:%s" % (t, v1)))
def cstr(p):
    g = collections.defaultdict(list)
    for eg, c in cond.get(p, []):
        g[eg].append(c)
    return "|".join(sorted({"&".join(sorted(v)) for v in g.values()})) or "TOUJOURS"
sets = collections.defaultdict(collections.Counter)
for tbl, pid, pg, i in re.findall(r"INSERT INTO `(creature|gameobject)` \(.*?\) VALUES \(\d+,(?:\d+,){0,0}(\d+),", "", 0):
    pass
for line in s.split("\n"):
    m = re.match(r"INSERT INTO `(creature|gameobject)` \((.*?)\) VALUES \((.*)\);", line)
    if m:
        cols = [c.strip("`") for c in m.group(2).split(",")]
        vals = re.findall(r"'(?:[^']|'')*'|[^,]+", m.group(3))
        r = dict(zip(cols, vals))
        ph = {int(r["PhaseId"])} if int(r["PhaseId"]) else groups[int(r["PhaseGroup"])]
        sets[frozenset(ph)][(m.group(1)[0], int(r["id"]), "+")] += 1
        continue
    m = re.match(r"UPDATE `(creature|gameobject)` SET PhaseId=(\d+), PhaseGroup=(\d+) WHERE guid=\d+; -- id (\d+)", line)
    if m:
        ph = {int(m.group(2))} if int(m.group(2)) else groups[int(m.group(3))]
        sets[frozenset(ph)][(m.group(1)[0], int(m.group(4)), "~")] += 1
for ph, c in sorted(sets.items(), key=lambda x: -sum(x[1].values())):
    print("== %d spawns, phases %s" % (sum(c.values()), " ".join("%d[%s]" % (p, cstr(p)) for p in sorted(ph)))[:400])
    print("   " + ", ".join("%s%s %s x%d" % (k[2], k[0], (names if k[0] == "c" else gnames).get(k[1], k[1]), n) for k, n in c.most_common(12))[:400])
