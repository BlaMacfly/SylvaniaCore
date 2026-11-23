#!/usr/bin/env python3
"""Phases non cosmetiques de phase_area (toutes zones) : origine, conditions, spawns qui les utilisent."""
import collections, csv, subprocess

def q(db, sql):
    o = subprocess.run(["mysql", "-N", db, "-e", sql], capture_output=True, text=True, check=True).stdout
    return [l.split("\t") for l in o.split("\n") if l]

pflags = {int(r["ID"]): int(r["Flags"]) for r in csv.DictReader(open("/home/ubuntu/tmp/Phase.csv"))}
pflags.update({int(a): int(b) for a, b in q("dc_hotfixes", "SELECT ID,Flags FROM phase")})
groups = collections.defaultdict(set)
for r in csv.DictReader(open("/home/ubuntu/tmp/PhaseXPhaseGroup.csv")):
    groups[int(r["PhaseGroupID"])].add(int(r["PhaseID"]))
for p, g in q("dc_hotfixes", "SELECT PhaseID,PhaseGroupID FROM phase_x_phase_group"):
    groups[int(g)].add(int(p))
nc = collections.defaultdict(list)
for a, p, c in q("dc_world", "SELECT AreaId,PhaseId,IFNULL(Comment,'') FROM phase_area"):
    if not pflags.get(int(p), 0) & 0x10:
        nc[int(p)].append((int(a), c))
for tbl in ("creature", "gameobject"):
    use = collections.Counter(); only = collections.Counter()
    for pid, pg, n in q("dc_world", "SELECT PhaseId,PhaseGroup,COUNT(*) FROM %s WHERE map=1220 GROUP BY PhaseId,PhaseGroup" % tbl):
        s = {int(pid)} if int(pid) else groups.get(int(pg), set())
        for p in s & set(nc):
            use[p] += int(n)
            if not (s - set(nc)):
                only[p] += int(n)
    nc_use = (use, only)
    globals()[tbl] = nc_use
for p in sorted(nc):
    lc = all(c.startswith("LC") for a, c in nc[p])
    print("%5d drapeaux %-5s %s aires %s | creatures %d (seule %d) objets %d (seule %d) | %s" % (
        p, hex(pflags.get(p, -1)), "LC " if lc else "TDB", sorted({a for a, c in nc[p]}),
        creature[0][p], creature[1][p], gameobject[0][p], gameobject[1][p], nc[p][0][1][:50]))
