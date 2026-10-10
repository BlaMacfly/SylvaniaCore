#!/usr/bin/env python3
"""Portage des apparitions d'une carte entiere depuis LegionCore (lc_world_ref) vers dc_world.

Usage : port_carte.py <nom> <map> [<map>...]
Produit <nom>.sql (a tester sur dc_world_test d'abord) et <nom>.log (ce qui n'a pas ete porte).

Pour les instances vides chez nous (aucune apparition) dont LegionCore a les donnees.
- Spawns : GUID neufs, spawnMask -> spawnDifficulties, entrees propres a LegionCore (>= 400000)
  et modeles absents chez nous ecartes, drapeaux d'etat passager retires (0x8, 0x10, SKINNABLE).
- ScriptName des modeles : seulement s'il est vide chez nous ET enregistre dans notre binaire
  (liste « does not have a script name assigned » du dernier demarrage + noms deja utilises).
- SmartAI : porte (enums traduits par nom) pour les PNJ sans script C++ ni SmartAI chez nous.
- creature_text manquants, clics de sort manquants.
Ne reecrit jamais ce qui existe deja chez nous.
"""
import collections
import math
import re
import subprocess
import sys

LC, DC = "lc_world_ref", "dc_world"
OURS_SMART = "/home/ubuntu/DestinyCore/src/server/game/AI/SmartScripts/SmartScriptMgr.h"
LC_SMART = "/home/ubuntu/tmp/audit-domaines/lc_SmartScriptMgr.h"
WORLD_LOG = "/home/ubuntu/dc-world.log"
STATE_FLAGS = 0x4000018  # PVP_ATTACKABLE | RENAME | SKINNABLE : etats passagers, filtres au chargement


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


def ids(xs):
    xs = sorted(set(int(x) for x in xs))
    return ",".join(map(str, xs)) if xs else "NULL"


def lit(v):
    if v is None:
        return "NULL"
    if isinstance(v, (int, float)):
        return repr(v)
    return "'" + str(v).replace("\\", "\\\\").replace("'", "\\'") + "'"


def ins(table, row):
    return "INSERT INTO `%s` (%s) VALUES (%s);" % (
        table, ",".join("`%s`" % k for k in row), ",".join(lit(v) for v in row.values()))


def smart_enum(path, name):
    s = open(path, encoding="latin1").read()
    m = re.search(r"enum\s+" + name + r"\s*\{(.*?)\};", s, re.S)
    return {int(v): n for n, v in re.findall(r"^\s*(SMART_[A-Z0-9_]+)\s*=\s*(\d+)", m.group(1), re.M)}


ALIASES = {
    "SMART_ACTION_SUMMON_CONVERSATION": "SMART_ACTION_START_CONVERSATION",
    "SMART_EVENT_TARGET_CASTING": "SMART_EVENT_VICTIM_CASTING",
    "SMART_ACTION_ADD_QUEST": "SMART_ACTION_OFFER_QUEST",
}


def translator(name):
    a = smart_enum(LC_SMART, name)
    b = {v: k for k, v in smart_enum(OURS_SMART, name).items()}

    def tr(n):
        nm = a.get(n)
        if nm is None:
            return None
        return b.get(ALIASES.get(nm, nm), b.get(nm))
    return tr, a


def registered_scripts():
    """Noms de scripts compiles dans le binaire en service."""
    text = open(WORLD_LOG, encoding="latin1").read()
    boot = text.rfind("Using configuration file")
    part = text[boot:]
    free = set(re.findall(r"Script named '([^']+)' does not have a script name assigned", part))
    missing = set(re.findall(r"Script '([^']+)' is referenced by the database, but does not exist in the core", part))
    used = {r["n"] for t in ("creature_template", "gameobject_template", "creature", "gameobject")
            for r in q(DC, "SELECT DISTINCT ScriptName n FROM %s WHERE ScriptName<>''" % t)}
    return free | (used - missing)


name, maps = sys.argv[1], [int(x) for x in sys.argv[2:]]
sql, log = ["-- Portage LegionCore des apparitions des cartes %s" % maps], []


def L(*a):
    log.append(" ".join(str(x) for x in a))


tr_ev, ev_names = translator("SMART_EVENT")
tr_ac, ac_names = translator("SMART_ACTION")
tr_tg, tg_names = translator("SMARTAI_TARGETS")
REG = registered_scripts()

# ---------------------------------------------------------------- 1. spawns
our_cr = {int(r["entry"]) for r in q(DC, "SELECT entry FROM creature_template")}
our_go = {int(r["entry"]) for r in q(DC, "SELECT entry FROM gameobject_template")}
nextguid = {"creature": int(q(DC, "SELECT MAX(guid) m FROM creature")[0]["m"]) + 1000,
            "gameobject": int(q(DC, "SELECT MAX(guid) m FROM gameobject")[0]["m"]) + 1000}
spawned = {"creature": set(), "gameobject": set()}


def difficulties(mask):
    return ",".join(str(i) for i in range(64) if int(mask) >> i & 1) or "0"


for table, known in (("creature", our_cr), ("gameobject", our_go)):
    rows = q(LC, "SELECT * FROM `%s` WHERE map IN (%s)" % (table, ids(maps)))
    ours = collections.defaultdict(list)
    for r in q(DC, "SELECT guid,id,position_x x,position_y y,position_z z FROM `%s` WHERE map IN (%s)" % (table, ids(maps))):
        ours[int(r["id"])].append(r)
    sql.append("\n-- 1. Apparitions %s (%d chez LegionCore)" % (table, len(rows)))
    added = 0
    for r in rows:
        e = int(r["id"])
        if e >= 400000:
            L("SPAWN %s LC %s id %d : entree propre a LegionCore, ecartee" % (table, r["guid"], e))
            continue
        if e not in known:
            L("SPAWN %s LC %s id %d : modele absent chez nous, ecarte" % (table, r["guid"], e))
            continue
        if r.get("PhaseId"):
            L("SPAWN %s LC %s id %d : phases %s, ecarte (a traiter a la main)" % (table, r["guid"], e, r["PhaseId"]))
            continue
        pos = (float(r["position_x"]), float(r["position_y"]), float(r["position_z"]))
        if any(math.dist(pos, (float(o["x"]), float(o["y"]), float(o["z"]))) < 5 for o in ours[e]):
            L("SPAWN %s LC %s id %d : deja chez nous", table, r["guid"], e)
            continue
        g = nextguid[table]
        nextguid[table] += 1
        spawned[table].add(e)
        base = {"guid": g, "id": e, "map": int(r["map"]), "zoneId": int(r["zoneId"]), "areaId": int(r["areaId"]),
                "spawnDifficulties": difficulties(r["spawnMask"]), "phaseUseFlags": 0, "PhaseId": 0, "PhaseGroup": 0,
                "terrainSwapMap": -1, "position_x": pos[0], "position_y": pos[1], "position_z": pos[2],
                "orientation": float(r["orientation"]), "spawntimesecs": int(r["spawntimesecs"])}
        if table == "creature":
            mt = int(r["MovementType"])
            if mt == 2:
                mt = 0
                L("SPAWN creature %d (id %d, LC %s) : chemin LegionCore non porte, immobile" % (g, e, r["guid"]))
            base.update({"modelid": int(r["modelid"]), "equipment_id": 0,
                         "spawndist": float(r["spawndist"]) if mt == 1 else 0.0, "currentwaypoint": 0,
                         "curhealth": int(r["curhealth"]), "curmana": int(r["curmana"]), "MovementType": mt,
                         "npcflag": int(r["npcflag"]) | (int(r["npcflag2"] or 0) << 32),
                         "unit_flags": int(r["unit_flags"]) & ~STATE_FLAGS, "unit_flags2": 0,
                         "unit_flags3": int(r["unit_flags3"]), "dynamicflags": int(r["dynamicflags"]),
                         "ScriptName": "", "movementmode": 0, "VerifiedBuild": 0})
        else:
            base.update({"rotation0": float(r["rotation0"]), "rotation1": float(r["rotation1"]),
                         "rotation2": float(r["rotation2"]), "rotation3": float(r["rotation3"]),
                         "animprogress": int(r["animprogress"]), "state": int(r["state"]),
                         "isActive": int(r["isActive"]), "ScriptName": "", "VerifiedBuild": 0})
        sql.append(ins(table, base) + " -- LC %s" % r["guid"])
        added += 1
    L("SPAWNS %s : %d ajoutes" % (table, added))

# ---------------------------------------------------------------- 2. scripts des modeles
sql.append("\n-- 2. ScriptName des modeles (vides chez nous, enregistres dans notre binaire)")
for tpl, key in (("creature_template", "creature"), ("gameobject_template", "gameobject")):
    es = spawned[key]
    if not es:
        continue
    lc = {int(r["entry"]): r["ScriptName"] or "" for r in q(LC, "SELECT entry,ScriptName FROM %s WHERE entry IN (%s)" % (tpl, ids(es)))}
    dc = {int(r["entry"]): r["ScriptName"] or "" for r in q(DC, "SELECT entry,ScriptName FROM %s WHERE entry IN (%s)" % (tpl, ids(es)))}
    for e in sorted(es):
        a, b = lc.get(e, ""), dc.get(e, "")
        if not a or a == b:
            continue
        if b:
            L("%s %d : script chez nous %s, LegionCore %s, garde le notre" % (tpl, e, b, a))
        elif a in REG:
            sql.append("UPDATE `%s` SET ScriptName=%s WHERE entry=%d AND ScriptName='';" % (tpl, lit(a), e))
        else:
            L("%s %d : script LegionCore %s absent de notre binaire" % (tpl, e, a))

# ---------------------------------------------------------------- 3. SmartAI et textes des PNJ poses
es = spawned["creature"]
lc_t = {int(r["entry"]): r for r in q(LC, "SELECT entry,AIName,ScriptName FROM creature_template WHERE entry IN (%s)" % ids(es))}
dc_t = {int(r["entry"]): r for r in q(DC, "SELECT entry,AIName,ScriptName FROM creature_template WHERE entry IN (%s)" % ids(es))}
dc_smart = {int(r["e"]) for r in q(DC, "SELECT DISTINCT entryorguid e FROM smart_scripts WHERE source_type=0 AND entryorguid IN (%s)" % ids(es))}
dc_text = {int(r["c"]) for r in q(DC, "SELECT DISTINCT CreatureID c FROM creature_text WHERE CreatureID IN (%s)" % ids(es))}
bt_en = {}
sql.append("\n-- 3. SmartAI et textes")
emitted_al = set()
for e in sorted(es):
    lt, dt = lc_t.get(e), dc_t.get(e)
    if not lt or not dt:
        continue
    if lt["AIName"] == "SmartAI" and e not in dc_smart:
        if dt["ScriptName"] or (lc_t[e]["ScriptName"] and lc_t[e]["ScriptName"] in REG):
            L("PNJ %d : script C++ chez nous, SmartAI LegionCore non porte" % e)
        else:
            rows = q(LC, "SELECT * FROM smart_scripts WHERE source_type=0 AND entryorguid=%d ORDER BY id" % e)
            al = set()
            for r in rows:
                nm = ac_names.get(int(r["action_type"]), "")
                if nm == "SMART_ACTION_CALL_TIMED_ACTIONLIST":
                    al.add(int(r["action_param1"]))
                elif nm == "SMART_ACTION_CALL_RANDOM_TIMED_ACTIONLIST":
                    al |= {int(r["action_param%d" % i]) for i in range(1, 7) if int(r["action_param%d" % i])}
                elif nm == "SMART_ACTION_CALL_RANDOM_RANGE_TIMED_ACTIONLIST":
                    al |= set(range(int(r["action_param1"]), int(r["action_param2"]) + 1))
            if al:
                rows += q(LC, "SELECT * FROM smart_scripts WHERE source_type=9 AND entryorguid IN (%s) ORDER BY entryorguid,id" % ids(al))
            out, bad = [], None
            for r in rows:
                ev, ac, tg = tr_ev(int(r["event_type"])), tr_ac(int(r["action_type"])), tr_tg(int(r["target_type"]))
                if ev is None or ac is None or tg is None:
                    bad = "event %s / action %s / cible %s" % (ev_names.get(int(r["event_type"])), ac_names.get(int(r["action_type"])), tg_names.get(int(r["target_type"])))
                    break
                row = {k: r[k] for k in ("entryorguid", "source_type", "id", "link", "event_phase_mask", "event_chance", "event_flags",
                                         "event_param1", "event_param2", "event_param3", "event_param4", "action_param1", "action_param2",
                                         "action_param3", "action_param4", "action_param5", "action_param6", "target_param1",
                                         "target_param2", "target_param3", "target_x", "target_y", "target_z", "target_o")}
                row.update({"event_type": ev, "action_type": ac, "target_type": tg, "event_param5": 0, "event_param_string": "",
                            "comment": "LegionCore : %s / %s" % (ev_names.get(int(r["event_type"]), "?")[12:], ac_names.get(int(r["action_type"]), "?")[13:])})
                for k in row:
                    if k not in ("comment", "event_param_string") and row[k] is not None:
                        row[k] = float(row[k]) if k.startswith("target_") and k[-1] in "xyzo" else int(row[k])
                out.append(row)
            if bad:
                L("SMART %d abandonne : %s non traduisible" % (e, bad))
            elif out:
                existing_al = {int(r["e"]) for r in q(DC, "SELECT DISTINCT entryorguid e FROM smart_scripts WHERE source_type=9 AND entryorguid IN (%s)" % ids(al))} if al else set()
                for row in out:
                    if row["source_type"] == 9 and (row["entryorguid"] in existing_al or row["entryorguid"] in emitted_al):
                        continue
                    sql.append(ins("smart_scripts", row))
                emitted_al |= {row["entryorguid"] for row in out if row["source_type"] == 9}
                sql.append("UPDATE creature_template SET AIName='SmartAI' WHERE entry=%d AND AIName='' AND ScriptName='';" % e)
    if e not in dc_text:
        seen = set()
        for r in q(LC, "SELECT * FROM creature_text WHERE Entry=%d ORDER BY GroupID,ID" % e):
            k = (int(r["GroupID"]), int(r["ID"]))
            if k in seen:
                continue
            seen.add(k)
            bid = int(r["BroadcastTextID"] or 0)
            text = None
            if bid:
                if bid not in bt_en:
                    rr = q("dc_hotfixes", "SELECT Text,Text1 FROM broadcast_text WHERE ID=%d" % bid)
                    bt_en[bid] = (rr[0]["Text"] or rr[0]["Text1"]) if rr else None
                text = bt_en[bid]
            if not text:
                L("TEXTE %d/%d/%d : sans broadcast_text chez nous, ecarte (LegionCore est en russe)" % (e, k[0], k[1]))
                continue
            sql.append(ins("creature_text", {"CreatureID": e, "GroupID": k[0], "ID": k[1], "Text": text,
                "Type": int(r["Type"]), "Language": int(r["Language"]), "Probability": float(r["Probability"]),
                "Emote": int(r["Emote"]), "Duration": int(r["Duration"]), "Sound": int(r["Sound"]),
                "BroadcastTextId": bid, "TextRange": 0, "comment": "LegionCore"}))

# ---------------------------------------------------------------- 4. clics de sort
lc_click = q(LC, "SELECT npc_entry,spell_id,cast_flags,user_type FROM npc_spellclick_spells WHERE npc_entry IN (%s)" % ids(es))
dc_click = {int(r["npc_entry"]) for r in q(DC, "SELECT DISTINCT npc_entry FROM npc_spellclick_spells WHERE npc_entry IN (%s)" % ids(es))}
sql.append("\n-- 4. Clics de sort")
for r in lc_click:
    if int(r["npc_entry"]) not in dc_click:
        sql.append("INSERT IGNORE INTO npc_spellclick_spells (npc_entry,spell_id,cast_flags,user_type) VALUES (%s,%s,%s,%s);"
                   % (r["npc_entry"], r["spell_id"], r["cast_flags"], r["user_type"]))

open(name + ".sql", "w", encoding="utf-8").write("\n".join(sql) + "\n")
open(name + ".log", "w", encoding="utf-8").write("\n".join(log) + "\n")
print("%s.sql : %d lignes ; %s.log : %d remarques" % (name, len(sql), name, len(log)))
