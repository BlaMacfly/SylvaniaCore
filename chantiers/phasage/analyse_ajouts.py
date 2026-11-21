#!/usr/bin/env python3
"""Classe les PNJ qu'ajouterait phasage_<zone>.sql : deja poses ailleurs dans la zone chez nous, ou nouveaux."""
import collections, re, subprocess, sys
Z = int(sys.argv[1])
def q(db, sql):
    o = subprocess.run(["mysql", "-N", db, "-e", sql], capture_output=True, text=True, check=True).stdout
    return [l.split("\t") for l in o.split("\n") if l]
ours = collections.Counter(int(i) for i, in q("dc_world", "SELECT id FROM creature WHERE zoneId=%d" % Z))
names = {int(e): n for e, n in q("dc_world", "SELECT entry,name FROM creature_template")}
add = collections.Counter()
ph = collections.defaultdict(set)
for l in open("/home/ubuntu/tmp/phasage/phasage_%d.sql" % Z):
    if l.startswith("INSERT INTO `creature` "):
        m = re.search(r"VALUES \(\d+,(\d+),", l)
        i = int(m.group(1)); add[i] += 1
        ph[i].add(l.split("phases ")[-1].strip())
dup = {i: n for i, n in add.items() if ours[i]}
print("ajouts %d (%d entrees) ; dont entrees deja posees chez nous : %d spawns (%d entrees)" % (
    sum(add.values()), len(add), sum(dup.values()), len(dup)))
for i, n in add.most_common(40):
    print("%6d %-30s +%3d  chez nous %3d  %s" % (i, names.get(i, "?")[:30], n, ours[i], " | ".join(sorted(ph[i]))[:90]))
