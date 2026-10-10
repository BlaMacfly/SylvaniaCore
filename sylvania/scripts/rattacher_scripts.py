#!/usr/bin/env python3
"""Rattache les scripts C++ compiles d'un dossier a leurs modeles, d'apres le code lui-meme.

Usage : rattacher_scripts.py <dossier de scripts> <nom>
Source 1 : les enregistrements commentes de l'auteur (`new npc_x(); // 71603, 73197`).
Source 2, en secours : les enumerations du fichier (npc_immerseus_sha_puddle -> NPC_SHA_PUDDLE),
apres retrait du seul prefixe propre au fichier ; jamais de correspondance par nom de modele.
Ne rattache que si le modele n'a pas deja de script ; le reste va dans <nom>.log.
"""
import collections
import glob
import os
import re
import subprocess
import sys

folder, name = sys.argv[1], sys.argv[2]


def q(sql):
    out = subprocess.run(["mysql", "-N", "dc_world", "-e", sql], capture_output=True, text=True).stdout
    return [l.split("\t") for l in out.splitlines()]


ENUM_RE = r"\b((?:NPC|GO|GOB|GAMEOBJECT|MOB|CREATURE)_[A-Z0-9_]+)\s*=\s*(\d+)"


def enums_of(paths):
    out = {}
    for f in paths:
        for k, v in re.findall(ENUM_RE, open(f, encoding="latin1").read()):
            out.setdefault(k, set()).add(int(v))
    return out


headers = enums_of(glob.glob(os.path.join(folder, "*.h")) + glob.glob(os.path.join(folder, "*.hpp")))
cur = {("cr", int(e)): sn for e, sn in q("SELECT entry,ScriptName FROM creature_template")}
cur.update({("go", int(e)): sn for e, sn in q("SELECT entry,ScriptName FROM gameobject_template")})
used_names = {sn for sn in cur.values() if sn}

log, assign = [], collections.defaultdict(set)  # (kind, entry) -> {(script, fichier, source)}
for path in sorted(glob.glob(os.path.join(folder, "*.cpp"))):
    f = os.path.basename(path)
    s = open(path, encoding="latin1").read()
    local = enums_of([path])
    # classe -> (nom de script, type)
    cls = {}
    for c, kind, n in re.findall(r"class\s+(\w+)\s*:\s*public\s+(CreatureScript|GameObjectScript)\b.*?\1\s*\(\s*\)\s*:\s*\2\(\"(\w+)\"\)", s, re.S):
        cls[c] = (n, "go" if kind == "GameObjectScript" else "cr")
    for c, kind in re.findall(r"Register(Creature|GameObject)AI\((\w+)\)", s):
        pass
    for kind, c in re.findall(r"Register(Creature|GameObject)AI\((\w+)\)", s):
        cls[c] = (c, "go" if kind == "GameObject" else "cr")
    commented = set()
    for c, ids_txt in re.findall(r"^\s*(?:new\s+(\w+)\(\)|Register(?:Creature|GameObject)AI\((\w+)\))\s*;\s*//\s*([0-9][0-9 ,]*)", s, re.M) and \
            [(a or b, t) for a, b, t in re.findall(r"^\s*(?:new\s+(\w+)\(\)|Register(?:Creature|GameObject)AI\((\w+)\))\s*;\s*//\s*([0-9][0-9 ,]*)", s, re.M)]:
        if c not in cls:
            continue  # sort, aura, declencheur : hors sujet
        n, kind = cls[c]
        commented.add(c)
        for e in re.findall(r"\d+", ids_txt):
            assign[(kind, int(e))].add((n, f, "commentaire"))
    stem = re.sub(r"^boss_|_part_\d+$", "", f[:-4])
    for c, (n, kind) in cls.items():
        if c in commented or n in used_names:
            continue
        low, hits = n.lower(), set()
        for pre in ("npc_%s_" % stem, "go_%s_" % stem, "boss_", "npc_", "go_"):
            if low.startswith(pre):
                token = low[len(pre):].upper()
                prefixes = ("GO_", "GOB_", "GAMEOBJECT_") if kind == "go" else ("NPC_", "MOB_", "CREATURE_")
                for table in (local, headers):
                    hits = set().union(*[table.get(p + token, set()) for p in prefixes])
                    if hits:
                        break
                if hits:
                    break
        if len(hits) == 1:
            assign[(kind, next(iter(hits)))].add((n, f, "enumeration"))
        else:
            log.append("%s %s : %s" % (f, n, "ambigu %s" % sorted(hits) if hits else "aucune entree"))

# Scripts de sorts et de zones de declenchement : seulement d'apres les commentaires de l'auteur.
spell_rows, at_rows, areatrigger_ai = set(), set(), set()
for path in sorted(glob.glob(os.path.join(folder, "*.cpp"))):
    s = open(path, encoding="latin1").read()
    named = {}
    for c, n in re.findall(r"class\s+(\w+)\s*:\s*public\s+SpellScriptLoader\b.*?\1\s*\(\s*\)\s*:\s*SpellScriptLoader\(\"(\w+)\"\)", s, re.S):
        named[c] = ("spell", n)
    for c in re.findall(r"Register(?:Spell|Aura)Script\((\w+)\)", s):
        named[c] = ("spell", c)
    for c, n in re.findall(r"class\s+(\w+)\s*:\s*public\s+AreaTriggerScript\b.*?\1\s*\(\s*\)\s*:\s*AreaTriggerScript\(\"(\w+)\"\)", s, re.S):
        named[c] = ("at", n)
    for a, b, ids_txt in re.findall(r"^\s*(?:new\s+(\w+)\(\)|Register(?:Spell|Aura)Script\((\w+)\))\s*;\s*//\s*([0-9][0-9 ,]*)", s, re.M):
        c = a or b
        if c not in named:
            continue
        kind, n = named[c]
        for e in re.findall(r"\d+", ids_txt):
            (spell_rows if kind == "spell" else at_rows).add((int(e), n))
    # sorts parametres : new spell_x_aoe("nom_du_script", SPELL_...); // ids
    for n, ids_txt in re.findall(r"^\s*new\s+\w+\(\s*\"(spell_\w+)\"[^;]*\)\s*;\s*//\s*([0-9][0-9 ,]*)", s, re.M):
        for e in re.findall(r"\d+", ids_txt):
            spell_rows.add((int(e), n))
    # zones au sol : RegisterAreaTriggerAI(x); // sort qui cree la zone
    for c, ids_txt in re.findall(r"^\s*RegisterAreaTriggerAI\((\w+)\)\s*;\s*//\s*([0-9][0-9 ,]*)", s, re.M):
        for e in re.findall(r"\d+", ids_txt):
            areatrigger_ai.add((int(e), c))
have_spell = {(int(i), n) for i, n in q("SELECT spell_id,ScriptName FROM spell_script_names")}
have_at = {int(i) for i, n in q("SELECT entry,ScriptName FROM areatrigger_scripts")}

sql = ["-- Rattachement des scripts de %s (commentaires d'enregistrement, sinon enumerations)" % folder]
for e, n in sorted(spell_rows - have_spell):
    sql.append("INSERT IGNORE INTO `spell_script_names` (spell_id, ScriptName) VALUES (%d, '%s');" % (e, n))
for e, n in sorted(at_rows):
    if e in have_at:
        log.append("zone de declenchement %d deja scriptee, %s non rattache" % (e, n))
        continue
    sql.append("INSERT IGNORE INTO `areatrigger_scripts` (entry, ScriptName) VALUES (%d, '%s');" % (e, n))
if areatrigger_ai:
    sys.path.insert(0, "/home/ubuntu")
    from db2read import DB2
    se = DB2("/home/ubuntu/server/data/dbc/enUS/SpellEffect.db2", "iiiiiififfiiiiffififfffffiiiii", [1] * 25 + [4, 2, 2, 2, 1], 0, 29)
    owner = {}
    for pid, idxs in se.parentMap.items():
        for i in idxs:
            owner[i] = pid
    created = collections.defaultdict(set)  # sort -> modeles de zone crees (effet 179)
    for r in range(se.recCount):
        if se.getRaw(r, 1, 0, "i") == 179:
            created[owner.get(r)].add(se.getRaw(r, 26, 0, "i"))
    at_tpl = {int(i): n for i, n in q("SELECT Id,ScriptName FROM areatrigger_template")}
    claims = collections.defaultdict(set)
    for spell, c in areatrigger_ai:
        if not created.get(spell):
            log.append("zone %s : le sort %d ne cree aucune zone" % (c, spell))
        for tid in created.get(spell, ()):
            claims[tid].add(c)
    for tid, cs in sorted(claims.items()):
        if len(cs) > 1:
            log.append("modele de zone %d revendique par %s" % (tid, sorted(cs)))
        elif tid not in at_tpl:
            log.append("modele de zone %d (%s) absent de areatrigger_template" % (tid, next(iter(cs))))
        elif at_tpl[tid]:
            if at_tpl[tid] != next(iter(cs)):
                log.append("modele de zone %d deja rattache a %s" % (tid, at_tpl[tid]))
        else:
            sql.append("UPDATE `areatrigger_template` SET ScriptName='%s' WHERE Id=%d AND ScriptName='';" % (next(iter(cs)), tid))
for (kind, e), cands in sorted(assign.items()):
    names = {c[0] for c in cands}
    if len(names) > 1:
        log.append("entree %d revendiquee par plusieurs scripts : %s" % (e, sorted(names)))
        continue
    n, f, how = sorted(cands)[0]
    if (kind, e) not in cur:
        log.append("%s %s -> %d (%s) : modele absent de la base" % (f, n, e, how))
        continue
    if cur[(kind, e)]:
        if cur[(kind, e)] != n:
            log.append("%s %s -> %d (%s) : modele deja rattache a %s" % (f, n, e, how, cur[(kind, e)]))
        continue
    table = "gameobject_template" if kind == "go" else "creature_template"
    sql.append("UPDATE `%s` SET ScriptName='%s' WHERE entry=%d AND ScriptName=''; -- %s (%s)" % (table, n, e, f, how))

open(name + ".sql", "w").write("\n".join(sql) + "\n")
open(name + ".log", "w").write("\n".join(log) + "\n")
print("%d rattachements, %d remarques" % (len(sql) - 1, len(log)))
