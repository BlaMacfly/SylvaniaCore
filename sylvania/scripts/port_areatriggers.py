#!/usr/bin/env python3
"""Zones au sol (AreaTrigger de sort) des scripts d'un dossier, converties depuis LegionCore.

Usage : port_areatriggers.py <dossier de scripts> <nom>
Pour chaque `RegisterAreaTriggerAI(x); // sorts` du dossier : sort -> SpellMiscId (effet 179 ou
aura 395, SpellEffect.db2) -> ligne LegionCore `areatrigger_template` (entry = SpellMiscId,
customEntry = identifiant de zone) -> chez nous `areatrigger_template` + `spell_areatrigger`
(+ sommets de polygone), avec le script rattache.

Formes, d'apres AreaTrigger.cpp / AreaTriggerData.cpp de LegionCore 7.3.5 :
  polygon          -> polygone (3) : Data0/1 = Height/HeightTarget, sommets areatrigger_polygon
  hasAreaTriggerBox-> boite (1)    : demi-longueurs Radius, Height ; Z non fourni (journalise)
  Height sans poly -> cylindre (4) : Radius, RadiusTarget, Height, HeightTarget, Float4, Float5
  sinon            -> sphere (0)   : Radius, RadiusTarget
Ne remplace rien : une zone ou un SpellMiscId deja connus chez nous sont laisses tels quels.
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
FLOAT_COLS = ("Radius", "RadiusTarget", "Height", "HeightTarget", "Float4", "Float5")


def q(db, sql):
    out = subprocess.run(["mysql", db, "-B", "-e", sql], capture_output=True, text=True)
    if out.returncode:
        raise SystemExit(out.stderr)
    lines = out.stdout.split("\n")
    if not lines or not lines[0]:
        return []
    cols = lines[0].split("\t")
    return [dict(zip(cols, l.split("\t"))) for l in lines[1:] if l]


se = DB2("/home/ubuntu/server/data/dbc/enUS/SpellEffect.db2", "iiiiiififfiiiiffififfffffiiiii", [1] * 25 + [4, 2, 2, 2, 1], 0, 29)
owner = {i: pid for pid, idxs in se.parentMap.items() for i in idxs}
miscs_of = collections.defaultdict(set)
for r in range(se.recCount):
    eff, aura = se.getRaw(r, 1, 0, "i"), se.getRaw(r, 4, 0, "i")
    if eff == 179 or (eff in (6, 35, 119, 128, 129) and aura == 395):
        m = se.getRaw(r, 26, 0, "i")
        if m:
            miscs_of[owner.get(r)].add(m)

wanted = collections.defaultdict(set)  # SpellMiscId -> {(sort, script)}
for path in sorted(glob.glob(os.path.join(folder, "*.cpp"))):
    for c, ids_txt in re.findall(r"^\s*RegisterAreaTriggerAI\((\w+)\)\s*;\s*//\s*([0-9][0-9 ,]*)",
                                 open(path, encoding="latin1").read(), re.M):
        for s in map(int, re.findall(r"\d+", ids_txt)):
            for m in miscs_of.get(s, ()):
                wanted[m].add((s, c))

ours_misc = {int(r["SpellMiscId"]) for r in q("dc_world", "SELECT SpellMiscId FROM spell_areatrigger")}
ours_tpl = {int(r["Id"]): r for r in q("dc_world", "SELECT Id,Type,ScriptName FROM areatrigger_template")}
lc_rows = collections.defaultdict(list)
for r in q("lc_world_ref", "SELECT entry,spellId,customEntry,Radius,RadiusTarget,Height,HeightTarget,`Float4`,`Float5`,"
           "hasAreaTriggerBox,`polygon`,HasFollowsTerrain,HasAttached,HasAbsoluteOrientation,HasDynamicShape,"
           "HasFaceMovementDir,isMoving,MoveCurveID,MorphCurveID,FacingCurveID,ScaleCurveID,DecalPropertiesId "
           "FROM areatrigger_template"):
    lc_rows[int(r["entry"])].append(r)
lc_circle = {(int(r["entry"]), int(r["spellId"])) for r in q("lc_world_ref", "SELECT entry,spellId FROM areatrigger_template_circle")}

sql, log = ["-- Zones au sol de %s, converties depuis LegionCore" % folder], []
tpl_done, scripts_on = {}, collections.defaultdict(set)
for m, uses in sorted(wanted.items()):
    if m in ours_misc:
        log.append("SpellMiscId %d deja chez nous" % m)
        continue
    rows = lc_rows.get(m)
    if not rows:
        log.append("SpellMiscId %d (%s) : absent de LegionCore" % (m, sorted(uses)))
        continue
    spells = {s for s, _ in uses}
    pick = [r for r in rows if int(r["spellId"]) in spells] or rows
    r = pick[0]
    at = int(r["customEntry"]) or m
    for _, c in uses:
        scripts_on[at].add(c)
    f = {k: float(r[k]) for k in FLOAT_COLS}
    flags = (1 if int(r["HasAbsoluteOrientation"]) else 0) | (2 if int(r["HasDynamicShape"]) else 0) | \
            (4 if int(r["HasAttached"]) else 0) | (8 if int(r["HasFaceMovementDir"]) else 0) | \
            (16 if int(r["HasFollowsTerrain"]) else 0)
    verts = []
    if int(r["polygon"]) and not int(r["hasAreaTriggerBox"]):
        typ, data = 3, (f["Height"], f["HeightTarget"], 0, 0, 0, 0)
        pts = collections.defaultdict(dict)
        for p in q("lc_world_ref", "SELECT type,id,x,y FROM areatrigger_polygon WHERE entry=%d AND spellId=%s ORDER BY id" % (at, r["spellId"])):
            pts[int(p["type"])][int(p["id"])] = (float(p["x"]), float(p["y"]))
        base, target = pts.get(1, {}), pts.get(2, {})
        if len(base) < 3:
            log.append("zone %d (misc %d) : polygone sans sommets chez LegionCore, ecartee" % (at, m))
            continue
        for i, idx in enumerate(sorted(base)):
            tx, ty = target.get(idx, (0.0, 0.0))
            verts.append((i, base[idx][0], base[idx][1], tx, ty))
    elif int(r["hasAreaTriggerBox"]):
        typ, data = 1, (f["Radius"], f["Height"], max(f["Float4"], 5.0), f["RadiusTarget"], f["HeightTarget"], max(f["Float5"], 5.0))
        log.append("zone %d (misc %d) : boite, hauteur Z non fournie par LegionCore (5 m par defaut)" % (at, m))
    elif f["Height"] > 0:
        typ, data = 4, tuple(f[k] for k in FLOAT_COLS)
    else:
        typ, data = 0, (f["Radius"], f["RadiusTarget"], 0, 0, 0, 0)
    if int(r["isMoving"]) or (m, int(r["spellId"])) in lc_circle:
        log.append("zone %d (misc %d) : mobile chez LegionCore (trajectoire non portee)" % (at, m))
    sql.append("INSERT IGNORE INTO `spell_areatrigger` (SpellMiscId,AreaTriggerId,MoveCurveId,ScaleCurveId,MorphCurveId,"
               "FacingCurveId,DecalPropertiesId,TimeToTarget,TimeToTargetScale,VerifiedBuild) VALUES "
               "(%d,%d,%s,%s,%s,%s,%s,0,0,0); -- sort %s" % (m, at, r["MoveCurveID"], r["ScaleCurveID"], r["MorphCurveID"],
                                                          r["FacingCurveID"], r["DecalPropertiesId"], r["spellId"]))
    if at in ours_tpl or at in tpl_done:
        if at in ours_tpl and int(ours_tpl[at]["Type"]) != typ:
            log.append("zone %d deja chez nous avec une autre forme (%s), gardee" % (at, ours_tpl[at]["Type"]))
        continue
    tpl_done[at] = (typ, flags, data)
    sql.append("INSERT INTO `areatrigger_template` (Id,Type,Flags,Data0,Data1,Data2,Data3,Data4,Data5,ScriptName,VerifiedBuild) "
               "VALUES (%d,%d,%d,%s,'',0);" % (at, typ, flags, ",".join(repr(float(x)) for x in data)))
    for i, x, y, tx, ty in verts:
        sql.append("INSERT INTO `areatrigger_template_polygon_vertices` (AreaTriggerId,Idx,VerticeX,VerticeY,VerticeTargetX,"
                   "VerticeTargetY,VerifiedBuild) VALUES (%d,%d,%r,%r,%r,%r,0);" % (at, i, x, y, tx, ty))

sql.append("\n-- Scripts")
for at, cs in sorted(scripts_on.items()):
    if len(cs) > 1:
        log.append("zone %d revendiquee par %s : pas de script" % (at, sorted(cs)))
        continue
    cur = ours_tpl.get(at, {}).get("ScriptName", "")
    if cur:
        if cur != next(iter(cs)):
            log.append("zone %d deja rattachee a %s" % (at, cur))
        continue
    sql.append("UPDATE `areatrigger_template` SET ScriptName='%s' WHERE Id=%d AND ScriptName='';" % (next(iter(cs)), at))

open(name + ".sql", "w").write("\n".join(sql) + "\n")
open(name + ".log", "w").write("\n".join(log) + "\n")
print("%d zones, %d lignes SQL, %d remarques" % (len(tpl_done), len(sql), len(log)))
