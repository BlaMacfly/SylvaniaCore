#!/usr/bin/env python3
"""SmartAI de la TDB 7.3.5 (TrinityCore, memes enums que notre core) pour des PNJ inertes chez nous.
Usage : tdb_smart.py <tdb_smart.tsv> <sortie.sql>. Suit les listes d'actions (action 80 / 87 / 88) en source 9.
N'ecrit rien pour une entree qui a deja des lignes chez nous."""
import subprocess
import sys

src, dst = sys.argv[1], sys.argv[2]


def q(sql):
    return subprocess.run(["mysql", "-N", "dc_world", "-e", sql], capture_output=True, text=True).stdout


ours_cols = [l.split("\t")[0] for l in q("SHOW COLUMNS FROM smart_scripts").splitlines()]


def read(path):
    lines = open(path, encoding="utf-8").read().splitlines()
    cols = lines[0].split("\t")
    return cols, [dict(zip(cols, l.split("\t"))) for l in lines[1:] if l]


cols, rows = read(src)
lists = set()
for r in rows:
    for a, p in (("80", ["action_param1"]), ("87", ["action_param%d" % i for i in range(1, 7)]), ("88", ["action_param1", "action_param2"])):
        if r["action_type"] == a:
            for c in p:
                v = r[c]
                if v not in ("0", ""):
                    lists.add(v)
if lists:
    out = subprocess.run(["python3", "/home/ubuntu/tmp/tdb_extraire.py", "smart_scripts", "entryorguid", ",".join(sorted(lists))], capture_output=True, text=True).stdout
    _, more = read("/dev/stdin") if False else (None, [dict(zip(cols, l.split("\t"))) for l in out.splitlines()[1:] if l])
    rows += [r for r in more if r["source_type"] == "9"]
have = {l for l in q("SELECT DISTINCT CONCAT(entryorguid,'/',source_type) FROM smart_scripts").splitlines()}
sql, skip = ["-- SmartAI de la TDB 7.3.5 (TrinityCore) pour des PNJ marques SmartAI sans aucune ligne chez nous"], set()
for r in rows:
    k = "%s/%s" % (r["entryorguid"], r["source_type"])
    if k in have:
        skip.add(k)
        continue
    use = [c for c in ours_cols if c in r]
    sql.append("INSERT INTO `smart_scripts` (%s) VALUES (%s);" % (",".join("`%s`" % c for c in use), ",".join(r[c] for c in use)))
open(dst, "w", encoding="utf-8").write("\n".join(sql) + "\n")
print(len(sql) - 1, "lignes ;", len(lists), "listes d'actions ; deja chez nous :", sorted(skip))
missing = [c for c in ours_cols if c not in cols]
print("colonnes absentes de la TDB (valeur par defaut) :", missing)
