#!/usr/bin/env python3
# Pour chaque script creature/objet d'un dossier : enumerations dont le nom partage le plus de mots, avec le nom du modele en base.
import glob, os, re, subprocess, sys
folder = sys.argv[1]
STOP = set(sys.argv[2].split(",")) if len(sys.argv) > 2 else set()
def q(sql):
    return [l.split("\t") for l in subprocess.run(["mysql", "-N", "dc_world", "-e", sql], capture_output=True, text=True).stdout.splitlines()]
src = "".join(open(p, encoding="latin1").read() for p in glob.glob(os.path.join(folder, "*.cpp")) + glob.glob(os.path.join(folder, "*.h")))
enums = {}
for k, v in re.findall(r"\b((?:NPC|BOSS|GO|GOB|GAMEOBJECT|MOB|CREATURE)_[A-Z0-9_]+)\s*=\s*(\d+)", src):
    enums[k] = int(v)
ours = {n: "cr" for n in re.findall(r":\s*CreatureScript\(\"(\w+)\"\)", src) + re.findall(r"RegisterCreatureAI\((\w+)\)", src)}
ours.update({n: "go" for n in re.findall(r":\s*GameObjectScript\(\"(\w+)\"\)", src) + re.findall(r"RegisterGameObjectAI\((\w+)\)", src)})
cr = {int(e): (n, s) for e, n, s in q("SELECT entry,name,ScriptName FROM creature_template")}
go = {int(e): (n, s) for e, n, s in q("SELECT entry,name,ScriptName FROM gameobject_template")}
def toks(s): return set(s.lower().split("_")) - {"boss", "npc", "go", "gob", "mob", "creature", "gameobject", "new", "the", "of", "ai"} - STOP
for n, kind in sorted(ours.items()):
    t = toks(n)
    best = []
    for k, v in enums.items():
        if (kind == "go") != k.startswith(("GO", "GAMEOBJECT")):
            continue
        sc = len(t & toks(k)) / max(len(t), 1)
        if sc > 0:
            best.append((sc, k, v))
    best.sort(reverse=True)
    tbl = go if kind == "go" else cr
    out = ["%s=%d[%s|%s](%.2f)" % (k, v, tbl.get(v, ("ABSENT", ""))[0][:22], tbl.get(v, ("", ""))[1], sc) for sc, k, v in best[:3]]
    used = [str(e) for e, (nm, s) in tbl.items() if s == n]
    print("%-3s %-34s deja=%-12s %s" % (kind, n, ",".join(used) or "-", "  ".join(out)))
