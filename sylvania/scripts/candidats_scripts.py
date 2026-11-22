#!/usr/bin/env python3
# Candidats de rattachement : nos scripts d'un dossier <-> entrees posees par LegionCore sur la carte.
# Indices : nom LC du script, enumerations NPC_/BOSS_/GO_ de nos fichiers, nom du modele.
import glob, os, re, subprocess, sys, difflib
folder, maps = sys.argv[1], sys.argv[2]
def q(db, sql):
    out = subprocess.run(["mysql", "-N", db, "-e", sql], capture_output=True, text=True).stdout
    return [l.split("\t") for l in out.splitlines()]
src = ""
for p in glob.glob(os.path.join(folder, "*.cpp")) + glob.glob(os.path.join(folder, "*.h")):
    src += open(p, encoding="latin1").read()
enums = {}
for k, v in re.findall(r"\b((?:NPC|BOSS|GO|GOB|GAMEOBJECT|MOB|CREATURE)_[A-Z0-9_]+)\s*=\s*(\d+)", src):
    enums.setdefault(int(v), set()).add(k)
ours = {}
for n in re.findall(r":\s*CreatureScript\(\"(\w+)\"\)", src): ours[n] = "cr"
for n in re.findall(r"RegisterCreatureAI\((\w+)\)", src): ours[n] = "cr"
for n in re.findall(r":\s*GameObjectScript\(\"(\w+)\"\)", src): ours[n] = "go"
for n in re.findall(r"RegisterGameObjectAI\((\w+)\)", src): ours[n] = "go"
for n in re.findall(r":\s*InstanceMapScript\(\"(\w+)\",\s*(\d+)\)", src): print("INSTANCE", n)
used = {r[0] for r in q("dc_world", "SELECT ScriptName FROM creature_template WHERE ScriptName<>'' UNION SELECT ScriptName FROM gameobject_template WHERE ScriptName<>''")}
rows = q("lc_world_ref", "SELECT DISTINCT 'cr', t.entry, t.ScriptName FROM creature c JOIN creature_template t ON t.entry=c.id WHERE c.map IN (%s) UNION SELECT DISTINCT 'go', t.entry, t.ScriptName FROM gameobject g JOIN gameobject_template t ON t.entry=g.id WHERE g.map IN (%s)" % (maps, maps))
names = {(k, int(e)): n for k, e, n in q("dc_world", "SELECT 'cr',entry,name FROM creature_template UNION ALL SELECT 'go',entry,name FROM gameobject_template")}
rows = [(k, e, names.get((k, int(e)), "?"), sn) for k, e, sn in rows]
dc = {(k, int(e)): sn for k, e, sn in q("dc_world", "SELECT 'cr',entry,ScriptName FROM creature_template UNION ALL SELECT 'go',entry,ScriptName FROM gameobject_template")}
def norm(s): return set(re.sub(r"^(boss|npc|go|mob|spell)_", "", s.lower()).split("_")) - {"new","the","of","kara","karazhan","legion","arc","coen","vow","tov"}
for kind, e, nm, lsn in rows:
    e = int(e)
    if not lsn and e not in enums: continue
    cur = dc.get((kind, e))
    if cur is None: continue
    toks = norm(lsn) | set(re.sub(r"[^a-z ]", "", nm.lower()).split()) - {"the","of"}
    for en in enums.get(e, ()): toks |= norm(en.lower())
    best = sorted(((len(toks & norm(o)) / max(1, len(norm(o))), o) for o, k in ours.items() if k == kind), reverse=True)[:2]
    print("%s %6d %-32s LC=%-38s chez_nous=%-25s enum=%s  -> %s" % (kind, e, nm[:32], lsn, cur or "-", ",".join(sorted(enums.get(e, ())))[:40], " | ".join("%s(%.2f)%s" % (o, s, "*" if o in used else "") for s, o in best if s > 0)))
print("NOS SCRIPTS :", " ".join(sorted(o + ("*" if o in used else "") for o in ours)))
