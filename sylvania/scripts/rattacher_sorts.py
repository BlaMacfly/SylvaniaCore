#!/usr/bin/env python3
"""Rattache les scripts de sorts non rattaches d'un dossier, en verifiant leurs crochets contre SpellEffect.db2.

Usage : rattacher_sorts.py <dossier> <nom> [mots a ignorer,...]
Candidats : les valeurs SPELL_* du dossier. Un candidat n'est retenu que si CHAQUE crochet du script
(SpellEffectFn / AuraEffect*Fn : indice d'effet + type d'effet ou d'aura ; *TargetSelectFn : cible)
existe dans le sort. Parmi les candidats valides, ceux qui partagent le plus de mots avec le nom du script.
Un script sans crochet verifiable n'est rattache que si un seul candidat a le meilleur score, et c'est note.
"""
import collections
import glob
import os
import re
import subprocess
import sys

sys.path.insert(0, "/home/ubuntu")
from db2read import DB2

folder, name = sys.argv[1], sys.argv[2]
STOP = set(sys.argv[3].split(",")) if len(sys.argv) > 3 else set()
CORE = "/home/ubuntu/DestinyCore/src/server"


def enum_values(path, enum):
    s = open(path, encoding="latin1").read()
    m = re.search(r"enum\s+" + enum + r"\b[^{]*\{(.*?)\};", s, re.S)
    out = {}
    for k, v in re.findall(r"^\s*([A-Z_0-9]+)\s*=\s*(\d+)", m.group(1), re.M):
        out[k] = int(v)
    return out


EFF = enum_values(CORE + "/game/Miscellaneous/SharedDefines.h", "SpellEffectName")
TGT = enum_values(CORE + "/game/Miscellaneous/SharedDefines.h", "Targets")
AUR = enum_values(CORE + "/game/Spells/Auras/SpellAuraDefines.h", "AuraType")

se = DB2("/home/ubuntu/server/data/dbc/enUS/SpellEffect.db2", "iiiiiififfiiiiffififfffffiiiii", [1] * 25 + [4, 2, 2, 2, 1], 0, 29)
owner = {}
for pid, idxs in se.parentMap.items():
    for i in idxs:
        owner[i] = pid
effects = collections.defaultdict(list)  # sort -> [(indice, effet, aura, cibleA, cibleB)]
for r in range(se.recCount):
    sp = owner.get(r)
    if sp is None:
        continue
    effects[sp].append((se.getRaw(r, 3, 0, "i"), se.getRaw(r, 1, 0, "i"), se.getRaw(r, 4, 0, "i"),
                        se.getRaw(r, 28, 0, "i"), se.getRaw(r, 28, 1, "i")))


def idx(e):
    return 255 if e in ("EFFECT_ALL", "EFFECT_FIRST_FOUND") else int(e.split("_")[1])


def hook_ok(sp, h):
    kind, e, val = h
    for (i, eff, aura, ta, tb) in effects.get(sp, ()):
        if e != 255 and i != e:
            continue
        if kind == "eff" and (val is None or eff == val):
            return True
        if kind == "aura" and eff in (6, 27, 35, 65, 119, 128, 129, 143, 174, 202) and (val is None or aura == val):
            return True
        if kind == "tgt" and (val is None or val in (ta, tb)):
            return True
    return False


files = glob.glob(os.path.join(folder, "*.cpp")) + glob.glob(os.path.join(folder, "*.h"))
allsrc = "".join(open(p, encoding="latin1").read() for p in files)
spells = {}
for k, v in re.findall(r"\b(SPELL_[A-Z0-9_]+)\s*=\s*(\d+)", allsrc):
    spells.setdefault(int(v), set()).add(k)
for k, v in re.findall(r"constexpr\s+uint32\s+(SPELL_[A-Z0-9_]+)\s*=\s*(\d+)", allsrc):
    spells.setdefault(int(v), set()).add(k)

# blocs de scripts : nom -> texte de la classe
blocks = {}
src = allsrc
heads = [(m.start(), m.group(1)) for m in re.finditer(r"class\s+(\w+)\s*:\s*public\s+(?:SpellScriptLoader|SpellScript|AuraScript)\b", src)]
for n, (pos, cls) in enumerate(heads):
    end = heads[n + 1][0] if n + 1 < len(heads) else len(src)
    blocks[cls] = src[pos:end]
loaders = [(m.start(), m.group(1)) for m in re.finditer(r"class\s+(\w+)\s*:\s*public\s+SpellScriptLoader\b", src)]
lblock = {}
for n, (pos, cls) in enumerate(loaders):
    lblock[cls] = src[pos:loaders[n + 1][0] if n + 1 < len(loaders) else len(src)]
names = {}
for cls, n in re.findall(r"class\s+(\w+)\s*:\s*public\s+SpellScriptLoader\b.*?\1\s*\(\s*\)\s*:\s*SpellScriptLoader\(\"(\w+)\"\)", src, re.S):
    names[n] = lblock.get(cls, "")
for cls in re.findall(r"Register(?:Spell|Aura)Script\((\w+)\)", src):
    names[cls] = blocks.get(cls, "")
for cls in re.findall(r"RegisterSpellAndAuraScriptPair\((\w+),\s*\w+\)", src):
    names[cls] = blocks.get(cls, "")

have = collections.defaultdict(set)
for l in subprocess.run(["mysql", "-N", "dc_world", "-e", "SELECT spell_id,ScriptName FROM spell_script_names"], capture_output=True, text=True).stdout.splitlines():
    i, n = l.split("\t")
    have[n].add(int(i))


def toks(s):
    return set(s.lower().split("_")) - {"spell", "aura", "the", "of", "a"} - STOP


sql, log = ["-- Scripts de sorts de %s, crochets verifies contre SpellEffect.db2" % folder], []
for n, body in sorted(names.items()):
    if have.get(n):
        continue
    hooks = []
    for e, v in re.findall(r"SpellEffectFn\(\s*[\w:]+\s*,\s*(EFFECT_\w+)\s*,\s*(SPELL_EFFECT_\w+)\s*\)", body):
        hooks.append(("eff", idx(e), None if v == "SPELL_EFFECT_ANY" else EFF.get(v, -1)))
    for e, v in re.findall(r"AuraEffect\w*Fn\(\s*[\w:]+\s*,\s*(EFFECT_\w+)\s*,\s*(SPELL_AURA_\w+)", body):
        hooks.append(("aura", idx(e), None if v == "SPELL_AURA_ANY" else AUR.get(v, -1)))
    for e, v in re.findall(r"Object(?:Area)?TargetSelectFn\(\s*[\w:]+\s*,\s*(EFFECT_\w+)\s*,\s*(TARGET_\w+)\s*\)", body):
        hooks.append(("tgt", idx(e), TGT.get(v, -1)))
    t = toks(n)
    scored = []
    for sp, ks in spells.items():
        s = max(len(t & toks(k)) / max(len(t | toks(k)), 1) for k in ks)
        if s > 0 and all(hook_ok(sp, h) for h in hooks) and sp in effects:
            scored.append((s, sp, sorted(ks)[0]))
    if not scored:
        log.append("%s : aucun candidat (crochets %s)" % (n, hooks))
        continue
    top = max(s for s, _, _ in scored)
    best = [(sp, k) for s, sp, k in scored if s == top]
    if not hooks and len(best) > 1:
        log.append("%s : sans crochet verifiable, ambigu %s" % (n, best))
        continue
    if len(best) > 3:
        log.append("%s : trop de candidats %s" % (n, best))
        continue
    for sp, k in best:
        sql.append("INSERT IGNORE INTO `spell_script_names` (spell_id, ScriptName) VALUES (%d, '%s'); -- %s%s" % (
            sp, n, k, "" if hooks else " (sans crochet verifiable)"))
open(name + ".sql", "w").write("\n".join(sql) + "\n")
open(name + ".log", "w").write("\n".join(log) + "\n")
print("%d rattachements, %d remarques" % (len(sql) - 1, len(log)))
