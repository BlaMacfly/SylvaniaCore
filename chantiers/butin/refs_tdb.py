#!/usr/bin/env python3
"""Tables de butin referencees mais absentes chez nous, reprises de la TDB 7.3.5 (references imbriquees suivies)."""
import subprocess, sys
def q(sql):
    return [l.split("\t") for l in subprocess.run(["mysql", "-N", "-B", "-e", sql], capture_output=True, text=True).stdout.splitlines() if l]
def tdb(table, ids):
    out = subprocess.run(["python3", "/home/ubuntu/tmp/tdb_extraire2.py", table, "Entry", ",".join(map(str, sorted(ids)))], capture_output=True, text=True).stdout
    rows = [l.split("\t") for l in out.splitlines()]
    return rows[0], rows[1:]
have_ref = {int(r[0]) for r in q("SELECT DISTINCT Entry FROM dc_world.reference_loot_template")}
go_ids = [int(x) for x in open("go_loot_absents.txt").read().split()]
ref_ids = {int(x) for x in open("refs_absentes.txt").read().split()}
out = ["-- Tables de butin referencees chez nous mais absentes (rejets au demarrage du 24/11), reprises de la TDB 7.3.5."]
cols, go_rows = tdb("gameobject_loot_template", go_ids)
got_go = sorted({int(r[0]) for r in go_rows})
for r in go_rows:
    if r[2] not in ("0", "") and int(r[2]) not in have_ref:
        ref_ids.add(int(r[2]))
done, n_ref = set(), 0
ref_rows = []
while ref_ids - done - have_ref:
    todo = ref_ids - done - have_ref
    done |= todo
    c2, rows = tdb("reference_loot_template", todo)
    for r in rows:
        ref_rows.append(r)
        if r[2] not in ("0", "") and int(r[2]) not in have_ref:
            ref_ids.add(int(r[2]))
got_ref = sorted({int(r[0]) for r in ref_rows})
def ins(table, cols, rows):
    if rows:
        out.append("INSERT INTO `%s` (%s) VALUES\n%s;" % (table, ",".join("`%s`" % c for c in cols), ",\n".join("(%s)" % ",".join(r) for r in rows)))
out.append("-- references : %d tables" % len(got_ref))
ins("reference_loot_template", cols, ref_rows)
out.append("-- objets : %d tables" % len(got_go))
ins("gameobject_loot_template", cols, go_rows)
open(sys.argv[1], "w").write("\n".join(out) + "\n")
miss_ref = sorted((ref_ids - have_ref) - set(got_ref))
print("references portees", len(got_ref), "absentes de la TDB", miss_ref)
print("objets portes", len(got_go), "sur", len(go_ids))
