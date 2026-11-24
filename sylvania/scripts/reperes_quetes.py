#!/usr/bin/env python3
"""Reperes de carte (quest_poi + points) des quetes donnees chez nous sans aucun repere : TDB 7.3.5, sinon LegionCore."""
import subprocess, sys
def tdb(table, ids):
    out = subprocess.run(["python3", "/home/ubuntu/tmp/tdb_extraire2.py", table, "QuestID", ",".join(ids)], capture_output=True, text=True).stdout
    rows = [l.split("\t") for l in out.splitlines()]
    return rows[0], rows[1:]
def lc(table, ids):
    out = subprocess.run(["mysql", "-B", "-e", "SELECT * FROM lc_world_ref.%s WHERE QuestID IN (%s)" % (table, ",".join(ids))], capture_output=True, text=True).stdout
    rows = [l.split("\t") for l in out.splitlines()] or [[]]
    return rows[0], [[("NULL" if v == "NULL" else v) for v in r] for r in rows[1:]]
ids = open("poi_q.txt").read().split()
cp, tp = tdb("quest_poi", ids)
cq, tq = tdb("quest_poi_points", ids)
in_tdb = sorted({r[0] for r in tp})
rest = [i for i in ids if i not in set(in_tdb)]
lqcols, lq = lc("quest_poi_points", rest)
with_pts = sorted({r[0] for r in lq})
lcols, lp = lc("quest_poi", with_pts) if with_pts else ([], [])
out = ["-- Reperes de carte des quetes donnees chez nous sans aucun repere : TDB 7.3.5 (%d quetes), sinon LegionCore (%d)." % (len(in_tdb), len({r[0] for r in lp}))]
def ins(t, cols, rows, src):
    for i in range(0, len(rows), 500):
        out.append("INSERT INTO `%s` (%s) VALUES\n%s; -- %s" % (t, ",".join("`%s`" % c for c in cols), ",\n".join("(%s)" % ",".join(r) for r in rows[i:i + 500]), src))
ins("quest_poi", cp, tp, "TDB")
ins("quest_poi_points", cq, tq, "TDB")
ins("quest_poi", lcols, lp, "LC")
ins("quest_poi_points", lqcols, lq, "LC")
open(sys.argv[1], "w").write("\n".join(out) + "\n")
print("TDB", len(in_tdb), "LC", len({r[0] for r in lp}), "lignes", len(tp) + len(lp), "points", len(tq) + len(lq))
