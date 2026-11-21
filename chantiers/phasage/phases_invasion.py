#!/usr/bin/env python3
"""Phases d'une zone dont toutes les definitions LC ne portent que sur les quetes donnees (invasions, assauts)."""
import collections, subprocess, sys
Z = int(sys.argv[1]); A = {int(x) for x in sys.argv[2].split(",")}
def q(db, sql):
    o = subprocess.run(["mysql", "-N", db, "-e", sql], capture_output=True, text=True, check=True).stdout
    return [l.split("\t") for l in o.split("\n") if l]
refs = collections.defaultdict(set)
for e, t, v1 in q("lc_world_ref", "SELECT SourceEntry,ConditionTypeOrReference,ConditionValue1 FROM conditions WHERE SourceTypeOrReferenceId=23 AND SourceGroup=%d" % Z):
    refs[int(e)].add(int(v1) if int(t) in (8, 9, 14, 28, 41, 47) else -1)
by = collections.defaultdict(list)
for e, ph, c in q("lc_world_ref", "SELECT entry,phaseId,comment FROM phase_definitions WHERE zoneId=%d" % Z):
    for p in ph.split():
        by[int(p)].append(int(e))
res = sorted(p for p, es in by.items() if all(refs[e] and refs[e] <= A for e in es))
print(",".join(map(str, res)))
for p in res:
    print(p, sorted({x for e in by[p] for x in refs[e]}))
