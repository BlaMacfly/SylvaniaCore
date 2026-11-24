#!/usr/bin/env python3
"""Objets que LegionCore pose et dont nous n'avons meme pas le modele : modeles + apparitions.

Usage : port_objets.py <nom>   (dans ~/tmp/gob : ids.txt, tdb735_tpl.tsv, tdb1200_tpl.tsv, disp.txt)
Produit <nom>.sql (monde), <nom>_hotfixes.sql (groupes de phases maison) et <nom>.log.

Modeles, par source :
- TDB 7.3.5 quand elle a l'entree : ligne entiere (releve officiel, meme schema que nous) ;
- sinon donnees LegionCore (7.3.5) avec nom / icone / barre d'incantation de la TDB 1200 (TrinityCore master) ;
- sinon LegionCore seul, sauf nom casse (russe mal encode) sur un objet avec lequel on interagit : ecarte.
Ecartes : modele 3D absent du client, entrees >= 277800 (BfA), objets lies a un evenement (micro-fetes :
portage a part), objets de pools LegionCore.
Apparitions : GUID neufs, phases LC limitees a celles qu'au moins une phase_area de la zone donne chez nous
(un spawn LC est visible des qu'une de ses phases l'est), groupe client ou groupe maison si plusieurs ;
doublon (meme modele ou meme affichage a moins de 3 m d'un des notres) ecarte ; dans une instance, porte
fermee que nos scripts ne citent pas ecartee (elle bloquerait le passage).
"""
import collections
import csv
import math
import re
import subprocess
import sys

LC, DC, HF = "lc_world_ref", "dc_world", "dc_hotfixes"
name = sys.argv[1]
INTERACTIFS = {1, 2, 3, 7, 9, 10, 22, 25, 43, 45}   # bouton, donneur de quete, coffre, siege, texte, goober, lanceur...


def unesc(v):
    if v == "NULL":
        return None
    return v.replace("\\t", "\t").replace("\\n", "\n").replace("\\0", "\0").replace("\\\\", "\\")


def q(db, sql):
    out = subprocess.run(["mysql", db, "-B", "-e", sql], capture_output=True, text=True)
    if out.returncode:
        raise SystemExit("SQL %s : %s\n%s" % (db, out.stderr, sql))
    lines = out.stdout.split("\n")
    if not lines or not lines[0]:
        return []
    cols = lines[0].split("\t")
    return [dict(zip(cols, map(unesc, l.split("\t")))) for l in lines[1:] if l != ""]


def lit(v):
    if v is None:
        return "NULL"
    if isinstance(v, (int, float)):
        return repr(v)
    return "'" + str(v).replace("\\", "\\\\").replace("'", "\\'") + "'"


def ins(table, row):
    return "INSERT INTO `%s` (%s) VALUES (%s);" % (table, ",".join("`%s`" % k for k in row), ",".join(lit(v) for v in row.values()))


def sqlval(v):
    """Valeur d'un dump TDB (extracteur) -> python."""
    v = v.strip()
    if v == "NULL":
        return None
    if v.startswith("'"):
        return v[1:-1].replace("\\'", "'").replace("''", "'").replace('\\"', '"').replace("\\\\", "\\")
    return v


def tdb(path):
    rows = [l.rstrip("\n").split("\t") for l in open(path, encoding="utf-8", errors="replace")]
    return {int(v[0]): {k: sqlval(x) for k, x in zip(rows[0], v)} for v in rows[1:]}


log, sql, hf = [], ["-- Objets poses par LegionCore dont nous n'avions pas le modele (port_objets.py)"], []


def L(*a):
    log.append(" ".join(str(x) for x in a))


ids = [int(x) for x in open("ids.txt").read().split()]
disp = {int(x) for x in open("disp.txt").read().split()}
t735, t1200 = tdb("tdb735_tpl.tsv"), tdb("tdb1200_tpl.tsv")
lc_t = {int(r["entry"]): r for r in q(LC, "SELECT * FROM gameobject_template WHERE entry IN (%s)" % ",".join(map(str, ids)))}
our_cols = [r["Field"] for r in q(DC, "SHOW COLUMNS FROM gameobject_template")]
registered = set(open("/home/ubuntu/tmp/scripts_orphelins.txt").read().split())
lc_ev = {int(r["guid"]) for r in q(LC, "SELECT guid FROM game_event_gameobject")}
lc_pool = {int(r["guid"]) for r in q(LC, "SELECT guid FROM pool_gameobject")}
lc_sp = collections.defaultdict(list)
for r in q(LC, "SELECT * FROM gameobject WHERE id IN (%s)" % ",".join(map(str, ids))):
    lc_sp[int(r["id"])].append(r)

# ---------------------------------------------------------------- 1. modeles
tpl_ok, smart_go = {}, []
for e in ids:
    r = lc_t[e]
    sp = lc_sp[e]
    if all(int(s["guid"]) in lc_ev for s in sp):
        L("MODELE %d (%s) : objet d evenement, porte avec les micro-fetes" % (e, r["name"]))
        continue
    if all(int(s["guid"]) in lc_pool for s in sp):
        L("MODELE %d (%s) : seulement dans des pools LegionCore, ecarte" % (e, r["name"]))
        continue
    if 139900 <= e <= 139904:
        L("MODELE %d (%s) : entree propre a LegionCore (mana ancien en devise), ecartee" % (e, r["name"]))
        continue
    if e >= 277800:
        L("MODELE %d (%s) : entree BfA, ecartee" % (e, r["name"]))
        continue
    if int(r["displayId"]) and int(r["displayId"]) not in disp:
        L("MODELE %d (%s) : affichage %s absent du client, ecarte" % (e, r["name"], r["displayId"]))
        continue
    typ = int(r["type"])
    if e in t735:
        row = {k: t735[e][k] for k in our_cols if k in t735[e]}
        src = "TDB 7.3.5"
    else:
        row = {k: r[k] for k in ["entry", "type", "displayId", "name", "IconName", "castBarCaption", "unk1", "size"] + ["Data%d" % i for i in range(33)]}
        row.update({"RequiredLevel": 0, "AIName": "", "ScriptName": "", "VerifiedBuild": 0})
        src = "LegionCore"
        if e in t1200 and int(t1200[e]["type"]) == typ:
            for k in ("name", "IconName", "castBarCaption"):
                row[k] = t1200[e][k] or ""
            src = "LegionCore, nom TDB 1200"
        elif re.search(r"[^\x20-\x7e]", r["name"] or ""):
            if typ in INTERACTIFS:
                L("MODELE %d type %d : nom LegionCore casse (%r), objet interactif ecarte (nom a relever)" % (e, typ, r["name"]))
                continue
            row["name"] = ""
            src = "LegionCore, nom casse vide (objet decoratif)"
    for k in row:
        if k in ("name", "IconName", "castBarCaption", "unk1", "AIName", "ScriptName"):
            row[k] = row[k] or ""
        elif k == "size":
            row[k] = float(row[k])
        else:
            row[k] = int(row[k] or 0)
    # scripts : ScriptName LC seulement s'il est enregistre dans notre binaire et libre ; SmartAI porte a part
    row["AIName"], row["ScriptName"] = "", ""
    if r["ScriptName"] and r["ScriptName"] in registered:
        row["ScriptName"] = r["ScriptName"]
    elif r["ScriptName"]:
        L("MODELE %d : script LegionCore %s absent de notre binaire" % (e, r["ScriptName"]))
    if r["AIName"] == "SmartGameObjectAI" and not row["ScriptName"]:
        smart_go.append(e)
    sql.append(ins("gameobject_template", row) + " -- " + src)
    if int(r["faction"]) or int(r["flags"]) or int(r["MinGold"]) or int(r["MaxGold"]):
        sql.append(ins("gameobject_template_addon", {"entry": e, "faction": int(r["faction"]), "flags": int(r["flags"]),
                                                     "mingold": int(r["MinGold"]), "maxgold": int(r["MaxGold"]),
                                                     "WorldEffectID": int(r["WorldEffectID"] or 0)}))
    for i in range(1, 7):
        it = int(r["questItem%d" % i] or 0)
        if it:
            sql.append(ins("gameobject_questitem", {"GameObjectEntry": e, "Idx": i - 1, "ItemId": it, "VerifiedBuild": 0}))
    tpl_ok[e] = row
L("MODELES : %d portes sur %d" % (len(tpl_ok), len(ids)))

# butin des coffres (type 3 : Data1 ; trou de peche 25 : Data1) absent chez nous
lootids = {t["Data1"] for t in tpl_ok.values() if t["type"] in (3, 25) and t["Data1"]}
have = {int(r["Entry"]) for r in q(DC, "SELECT DISTINCT Entry FROM gameobject_loot_template WHERE Entry IN (%s)" % ",".join(map(str, lootids or {0})))}
n_loot = 0
for lid in sorted(lootids - have):
    for l in q(LC, "SELECT * FROM gameobject_loot_template WHERE entry=%d" % lid):
        item, ch, mc = int(l["item"]), float(l["ChanceOrQuestChance"]), int(l["mincountOrRef"])
        if mc < 0 or item <= 0:
            L("BUTIN %d : reference ou devise LC ecartee (%s)" % (lid, item))
            continue
        sql.append(ins("gameobject_loot_template", {"Entry": lid, "Item": item, "Reference": 0, "Chance": abs(ch),
                   "QuestRequired": 1 if ch < 0 else 0, "LootMode": int(l["lootmode"]) or 1, "GroupId": int(l["groupid"]),
                   "MinCount": mc, "MaxCount": int(l["maxcount"]), "Comment": "LegionCore"}))
        n_loot += 1
L("BUTIN : %d lignes pour %d coffres" % (n_loot, len(lootids - have)))

# ---------------------------------------------------------------- 2. apparitions
phases_ok = {int(r["ID"]) for r in csv.DictReader(open("/home/ubuntu/tmp/Phase.csv")) if int(r["Flags"]) & 0x10}
area_ph = collections.defaultdict(set)
for r in q(DC, "SELECT AreaId, PhaseId FROM phase_area"):
    area_ph[int(r["AreaId"])].add(int(r["PhaseId"]))
groups = collections.defaultdict(set)
for r in csv.DictReader(open("/home/ubuntu/tmp/PhaseXPhaseGroup.csv")):
    groups[int(r["PhaseGroupID"])].add(int(r["PhaseID"]))
for r in q(HF, "SELECT PhaseID, PhaseGroupID FROM phase_x_phase_group"):
    groups[int(r["PhaseGroupID"])].add(int(r["PhaseID"]))
group_of = {frozenset(v): k for k, v in groups.items()}
next_group = max(10001, max(groups) + 1)
next_pxg = max(200000, int(q(HF, "SELECT COALESCE(MAX(ID),0) m FROM phase_x_phase_group")[0]["m"]) + 1)
instances = {int(r["map"]) for r in q(DC, "SELECT map FROM instance_template")}
src_txt = subprocess.run(["grep", "-rhoE", r"\b2[0-9]{5}\b|\b1[0-9]{5}\b", "/home/ubuntu/DestinyCore/src/server/scripts"],
                         capture_output=True, text=True).stdout.split()
cited = {int(x) for x in src_txt}
nextguid = int(q(DC, "SELECT MAX(guid) m FROM gameobject")[0]["m"]) + 1000
ours = {}


def ours_on(m):
    if m not in ours:
        # LEFT JOIN : nos apparitions orphelines (modele absent, rejetees au chargement) revivent avec ce lot
        ours[m] = [(int(r["id"]), int(r["displayId"]) if r["displayId"] else tpl_ok.get(int(r["id"]), {}).get("displayId", 0),
                    float(r["x"]), float(r["y"]), float(r["z"])) for r in q(DC,
                   "SELECT g.id, t.displayId, g.position_x x, g.position_y y, g.position_z z FROM gameobject g "
                   "LEFT JOIN gameobject_template t ON t.entry=g.id WHERE g.map=%d" % m)]
    return ours[m]


stats = collections.Counter()
for e in sorted(tpl_ok):
    t = tpl_ok[e]
    for r in lc_sp[e]:
        g, m = int(r["guid"]), int(r["map"])
        if g in lc_ev or g in lc_pool:
            stats["evenement/pool"] += 1
            continue
        pos = (float(r["position_x"]), float(r["position_y"]), float(r["position_z"]))
        ph = {int(x) for x in (r["PhaseId"] or "").split() if int(x)}
        pid = pg = 0
        if not ph:
            if int(r["phaseMask"]) not in (1, 65535):
                L("SPAWN LC %d id %d : phaseMask %s sans PhaseId, ecarte" % (g, e, r["phaseMask"]))
                stats["phaseMask"] += 1
                continue
        else:
            given = area_ph.get(int(r["zoneId"]), set()) | area_ph.get(int(r["areaId"]), set())
            keep = {p for p in ph if p in given and p in phases_ok}
            if not keep:
                L("SPAWN LC %d id %d (%s) : phases %s jamais donnees chez nous dans la zone %s, ecarte" % (g, e, t["name"], sorted(ph), r["zoneId"]))
                stats["phase inactive"] += 1
                continue
            if len(keep) == 1:
                pid = next(iter(keep))
            else:
                fs = frozenset(keep)
                if fs not in group_of:
                    group_of[fs] = next_group
                    for p in sorted(fs):
                        hf.append("INSERT INTO `phase_x_phase_group` (`ID`,`PhaseID`,`PhaseGroupID`,`VerifiedBuild`) VALUES (%d,%d,%d,0);" % (next_pxg, p, next_group))
                        next_pxg += 1
                    next_group += 1
                pg = group_of[fs]
        if t["type"] == 0 and int(r["state"]) == 1 and e not in cited:
            L("SPAWN LC %d id %d (%s) carte %d : porte ou mur ferme inconnu de nos scripts, ecarte (bloquerait le passage)" % (g, e, t["name"], m))
            stats["porte fermee"] += 1
            continue
        if t["type"] == 6 and e not in t735 and e not in cited:
            L("SPAWN LC %d id %d (%s) carte %d : piege sans releve TDB ni script, ecarte" % (g, e, t["name"], m))
            stats["piege"] += 1
            continue
        near = [o for o in ours_on(m) if (o[0] == e or (t["displayId"] and o[1] == t["displayId"])) and math.dist(pos, o[2:]) < 3]
        if near:
            L("SPAWN LC %d id %d : doublon de notre objet %d a %.1f m" % (g, e, near[0][0], math.dist(pos, near[0][2:])))
            stats["doublon"] += 1
            continue
        ours[m].append((e, t["displayId"], *pos))
        mask = int(r["spawnMask"])
        row = {"guid": nextguid, "id": e, "map": m, "zoneId": int(r["zoneId"]), "areaId": int(r["areaId"]),
               "spawnDifficulties": ",".join(str(i) for i in range(64) if mask >> i & 1) or "0",
               "phaseUseFlags": 0, "PhaseId": pid, "PhaseGroup": pg, "terrainSwapMap": -1,
               "position_x": pos[0], "position_y": pos[1], "position_z": pos[2], "orientation": float(r["orientation"]),
               "rotation0": float(r["rotation0"]), "rotation1": float(r["rotation1"]), "rotation2": float(r["rotation2"]),
               "rotation3": float(r["rotation3"]), "spawntimesecs": int(r["spawntimesecs"]), "animprogress": int(r["animprogress"]),
               "state": int(r["state"]), "isActive": int(r["isActive"]), "ScriptName": "", "VerifiedBuild": 0}
        nextguid += 1
        sql.append(ins("gameobject", row) + " -- LC %d" % g)
        stats["pose"] += 1
L("APPARITIONS : %s" % dict(stats))
L("GROUPES maison : %d" % (next_group - max(10001, max(groups) + 1)))
L("SMARTAI a porter (port_smart.py --gobjects) : %s" % ",".join(map(str, smart_go)))

open(name + ".sql", "w", encoding="utf-8").write("\n".join(sql) + "\n")
open(name + "_hotfixes.sql", "w", encoding="utf-8").write("\n".join(hf) + "\n")
open(name + ".log", "w", encoding="utf-8").write("\n".join(log) + "\n")
print("%s.sql : %d lignes ; groupes maison %d lignes ; %s" % (name, len(sql), len(hf), dict(stats)))
