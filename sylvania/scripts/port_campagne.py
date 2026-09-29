#!/usr/bin/env python3
"""Portage d'une campagne de domaine de classe depuis LegionCore (lc_world_ref) vers dc_world.

Usage : port_campagne.py <nom> <questline_id>[,<questline_id>...] [--areas 7877,...]
Produit <nom>.sql (a appliquer sur une copie d'abord) et <nom>.log (ce qui n'a pas ete porte).

Principes :
- Les quetes, objectifs et templates viennent de la meme source Blizzard des deux cotes : on ne
  reecrit que ce qui MANQUE chez nous, jamais ce qui existe (nos correctifs priment).
- Les tables indexees par GUID de spawn ne sont jamais copiees telles quelles : les spawns
  LegionCore recoivent des GUID neufs chez nous (voir memoire chantier-krigsgaldrnet).
- smart_scripts : numeros d'evenements / actions / cibles traduits PAR NOM entre les deux
  enums ; une ligne intraduisible fait abandonner tout le script du PNJ (log).
"""
import json, re, subprocess, sys, collections, math
sys.path.insert(0, "/home/ubuntu")
from db2read import DB2

LC, DC = "lc_world_ref", "dc_world"
OURS_SMART = "/home/ubuntu/DestinyCore/src/server/game/AI/SmartScripts/SmartScriptMgr.h"
LC_SMART = "/home/ubuntu/tmp/audit-domaines/lc_SmartScriptMgr.h"
DBC = "/home/ubuntu/server/data/dbc/enUS/"

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

def cols(db, table):
    return [r["COLUMN_NAME"] for r in q("information_schema",
        "SELECT COLUMN_NAME FROM COLUMNS WHERE TABLE_SCHEMA='%s' AND TABLE_NAME='%s' ORDER BY ORDINAL_POSITION" % (db, table))]

# ---------------------------------------------------------------- enums SmartAI
def smart_enum(path, name):
    s = open(path, encoding="latin1").read()
    m = re.search(r"enum\s+" + name + r"\s*\{(.*?)\};", s, re.S)
    return {int(v): n for n, v in re.findall(r"^\s*(SMART_[A-Z0-9_]+)\s*=\s*(\d+)", m.group(1), re.M)}

ALIASES = {  # meme semantique, nom different
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
tr_ev, ev_names = translator("SMART_EVENT")
tr_ac, ac_names = translator("SMART_ACTION")
tr_tg, tg_names = translator("SMARTAI_TARGETS")

# ---------------------------------------------------------------- groupes de phases (client)
pg = DB2(DBC + "PhaseXPhaseGroup.db2", None, None, -1, -1)
group_of = {}
for gid, recs in pg.parentMap.items():
    group_of[frozenset(pg.getRaw(r, 0, 0, "h") for r in recs)] = gid

# ---------------------------------------------------------------- entree
name = sys.argv[1]
lines = [x for x in sys.argv[2].split(",")]
areas = []
if "--areas" in sys.argv:
    areas = [int(x) for x in sys.argv[sys.argv.index("--areas") + 1].split(",")]
QL = json.load(open("/home/ubuntu/tmp/audit-domaines/questlines.json"))
Q = sorted({qq for l in lines for qq in QL[l]["quests"]})
sql, log = [], []
def L(*a):
    log.append(" ".join(str(x) for x in a))
sql.append("-- Portage campagne %s depuis LegionCore (lignes de quetes %s, %d quetes)" % (name, sys.argv[2], len(Q)))

# ---------------------------------------------------------------- 1. phases
defs = q(LC, """SELECT DISTINCT d.zoneId,d.entry,d.phaseId,d.comment FROM phase_definitions d
  LEFT JOIN conditions c ON c.SourceTypeOrReferenceId=23 AND c.SourceGroup=d.zoneId AND c.SourceEntry=d.entry
  WHERE (c.ConditionValue1 IN (%s) AND c.ConditionTypeOrReference IN (8,9,14,28,41,47,48))""" % ids(Q))
if areas:  # phases utilisees par les spawns LC des zones propres a la classe (ex. le Pavillon)
    used = set()
    for r in q(LC, "SELECT DISTINCT PhaseId FROM creature WHERE areaId IN (%s) AND PhaseId<>'' UNION SELECT DISTINCT PhaseId FROM gameobject WHERE areaId IN (%s) AND PhaseId<>''" % (ids(areas), ids(areas))):
        used |= {int(x) for x in r["PhaseId"].split()}
    known = {(int(d["zoneId"]), int(d["entry"])) for d in defs}
    area_zones = {int(r["zoneId"]) for r in q(LC, "SELECT DISTINCT zoneId FROM creature WHERE areaId IN (%s)" % ids(areas))}
    for d in q(LC, "SELECT zoneId,entry,phaseId,comment FROM phase_definitions WHERE phaseId IN (%s) AND zoneId IN (%s)" % (ids(used), ids(area_zones))):
        if (int(d["zoneId"]), int(d["entry"])) not in known:
            defs.append(d)
P = set()
phase_rows = collections.defaultdict(list)  # (phase, zone) -> [lc entry]
for d in defs:
    ph = d["phaseId"].split()
    if len(ph) != 1:
        L("PHASE multi ignoree", d)
        continue
    phase_rows[(int(ph[0]), int(d["zoneId"]))].append(d)
    P.add(int(ph[0]))
exist_pa = {(int(r["AreaId"]), int(r["PhaseId"])) for r in q(DC, "SELECT AreaId,PhaseId FROM phase_area WHERE PhaseId IN (%s)" % ids(P))}
objid = {(int(r["QuestID"]), int(r["ObjectID"])): int(r["ID"]) for r in q(DC, "SELECT QuestID,ObjectID,ID FROM quest_objectives")}
sql.append("\n-- 1. Phases (%d)" % len(phase_rows))
for (ph, zone), entries in sorted(phase_rows.items()):
    if (zone, ph) in exist_pa:
        L("PHASE deja chez nous", zone, ph)
        continue
    conds, eg_base, ok = [], 0, True
    for d in entries:
        cs = q(LC, "SELECT * FROM conditions WHERE SourceTypeOrReferenceId=23 AND SourceGroup=%s AND SourceEntry=%s" % (d["zoneId"], d["entry"]))
        if not cs:  # definition sans condition : phase toujours active dans la zone
            conds = None
            break
        egs = sorted({int(c["ElseGroup"]) for c in cs})
        for c in cs:
            t, v1, v2 = int(c["ConditionTypeOrReference"]), int(c["ConditionValue1"]), int(c["ConditionValue2"])
            if t == 41:  # LC : objectif (quete, ObjectID) accompli -> chez nous type 48 (ID d'objectif)
                if (v1, v2) not in objid:
                    L("PHASE %d zone %d : objectif %d/%d introuvable, phase abandonnee" % (ph, zone, v1, v2)); ok = False; break
                t, v1, v2 = 48, objid[(v1, v2)], 0
            elif t not in (8, 9, 14, 28, 47):
                L("PHASE %d zone %d : condition type %d non traduite, phase abandonnee" % (ph, zone, t)); ok = False; break
            conds.append({"SourceTypeOrReferenceId": 26, "SourceGroup": ph, "SourceEntry": zone, "SourceId": 0,
                          "ElseGroup": eg_base + egs.index(int(c["ElseGroup"])), "ConditionTypeOrReference": t,
                          "ConditionTarget": int(c["ConditionTarget"]), "ConditionValue1": v1, "ConditionValue2": v2,
                          "ConditionValue3": int(c["ConditionValue3"]), "NegativeCondition": int(c["NegativeCondition"]),
                          "ErrorType": 0, "ErrorTextId": 0, "ScriptName": "", "Comment": "LC %s : %s" % (d["entry"], (d["comment"] or "")[:60])})
        if not ok:
            break
        eg_base += len(egs)
    if not ok:
        P.discard(ph)
        continue
    sql.append(ins("phase_area", {"AreaId": zone, "PhaseId": ph, "Comment": "LC: " + " / ".join((d["comment"] or "") for d in entries)[:250]}))
    for c in conds or []:
        sql.append(ins("conditions", c))

# ---------------------------------------------------------------- 2. spawns
def spawn_filter(table):
    # une phase n'est active que dans les zones ou elle est definie : un spawn hors de ces zones
    # appartient a un autre contenu qui partage le meme numero de phase
    zones_of = collections.defaultdict(set)
    for (ph, zone) in phase_rows:
        if ph in P:
            zones_of[ph].add(zone)
    rows = q(LC, "SELECT * FROM `%s` WHERE PhaseId<>''" % table)
    keep = []
    # PNJ dont la campagne a besoin (donneur, receveur, cible d'objectif) et qui n'existent
    # NULLE PART chez nous : on prend leurs spawns LegionCore, phases ou non
    if table == "creature":
        need = {int(r["id"]) for t in ("creature_queststarter", "creature_questender")
                for r in q(LC, "SELECT id FROM %s WHERE quest IN (%s) AND id<400000" % (t, ids(Q)))}
        need |= {int(r["ObjectID"]) for r in q(LC, "SELECT ObjectID FROM quest_objectives WHERE QuestID IN (%s) AND Type IN (0,3)" % ids(Q))}
        have = {int(r["id"]) for r in q(DC, "SELECT DISTINCT id FROM creature WHERE id IN (%s)" % ids(need))}
        for r in q(LC, "SELECT * FROM creature WHERE id IN (%s)" % ids(need - have)):
            ph = set(int(x) for x in r["PhaseId"].split())
            if ph and not (ph & P):
                L("SPAWN requis id %s (LC %s) : phases %s hors campagne, ignore" % (r["id"], r["guid"], sorted(ph)))
                continue
            keep.append(r)
    keep_guids = {r["guid"] for r in keep}
    rows = [r for r in rows if r["guid"] not in keep_guids]
    for r in rows:
        ph = set(int(x) for x in r["PhaseId"].split())
        if any(int(r["zoneId"]) in zones_of[p] for p in ph & P):
            keep.append(r)
    return keep
def difficulties(mask):
    mask = int(mask)
    return ",".join(str(i) for i in range(64) if mask >> i & 1) or "0"
def phase_fields(r):
    ph = {int(x) for x in r["PhaseId"].split()}
    if not ph:
        return 0, 0
    if len(ph) == 1:
        return next(iter(ph)), 0
    g = group_of.get(frozenset(ph))
    if g:
        return 0, g
    inP = ph & P
    if len(inP) == 1:
        L("SPAWN %s %s : phases %s sans groupe client, gardee %s" % (r["id"], r["guid"], sorted(ph), inP))
        return next(iter(inP)), 0
    return None, None

nextguid = {"creature": int(q(DC, "SELECT MAX(guid) m FROM creature")[0]["m"]) + 1000,
            "gameobject": int(q(DC, "SELECT MAX(guid) m FROM gameobject")[0]["m"]) + 1000}
guidmap = {"creature": {}, "gameobject": {}}
new_guids = {"creature": set(), "gameobject": set()}
entries_spawned = {"creature": set(), "gameobject": set()}
for table in ("creature", "gameobject"):
    lc_rows = spawn_filter(table)
    ours = collections.defaultdict(list)
    for r in q(DC, "SELECT guid,id,map,position_x x,position_y y,position_z z,PhaseId,PhaseGroup FROM `%s` WHERE id IN (%s)" % (table, ids(r["id"] for r in lc_rows))):
        ours[(int(r["id"]), int(r["map"]))].append(r)
    sql.append("\n-- 2. Spawns %s (%d candidats LegionCore)" % (table, len(lc_rows)))
    added = matched = 0
    for r in lc_rows:
        pid, pgroup = phase_fields(r)
        if pid is None:
            L("SPAWN %s %s id %s : phases %s ambigues, ignore" % (table, r["guid"], r["id"], r["PhaseId"]))
            continue
        near = [o for o in ours[(int(r["id"]), int(r["map"]))]
                if math.dist((float(o["x"]), float(o["y"]), float(o["z"])), (float(r["position_x"]), float(r["position_y"]), float(r["position_z"]))) < 5]
        if near:  # deja pose chez nous : on lui donne la phase LegionCore, sans le deplacer
            for o in near:
                if int(o["PhaseId"]) or int(o["PhaseGroup"]):
                    continue
                # hors du domaine de classe, nos spawns sont du monde ouvert visible par tous :
                # les phaser les ferait disparaitre pour qui n'est pas dans la campagne
                if int(r["areaId"]) not in areas:
                    L("SPAWN %s guid %s id %s : pas rephase (hors domaine, area %s)" % (table, o["guid"], r["id"], r["areaId"]))
                    continue
                sql.append("UPDATE `%s` SET PhaseId=%d, PhaseGroup=%d WHERE guid=%s; -- %s id %s (LC %s)" % (table, pid, pgroup, o["guid"], table, r["id"], r["guid"]))
                matched += 1
            guidmap[table][int(r["guid"])] = int(near[0]["guid"])
            continue
        close = [o for o in ours[(int(r["id"]), int(r["map"]))]
                 if math.dist((float(o["x"]), float(o["y"]), float(o["z"])), (float(r["position_x"]), float(r["position_y"]), float(r["position_z"]))) < 50]
        if close:  # le meme PNJ existe deja a proximite (pose a la main, autre releve) : pas de doublon
            L("SPAWN %s id %s (LC %s) non ajoute : deja chez nous a proximite (guid %s)" % (table, r["id"], r["guid"], close[0]["guid"]))
            guidmap[table][int(r["guid"])] = int(close[0]["guid"])
            continue
        g = nextguid[table]; nextguid[table] += 1
        guidmap[table][int(r["guid"])] = g
        new_guids[table].add(g)
        entries_spawned[table].add(int(r["id"]))
        base = {"guid": g, "id": int(r["id"]), "map": int(r["map"]), "zoneId": int(r["zoneId"]), "areaId": int(r["areaId"]),
                "spawnDifficulties": difficulties(r["spawnMask"]), "phaseUseFlags": 0, "PhaseId": pid, "PhaseGroup": pgroup,
                "terrainSwapMap": -1, "position_x": float(r["position_x"]), "position_y": float(r["position_y"]),
                "position_z": float(r["position_z"]), "orientation": float(r["orientation"]), "spawntimesecs": int(r["spawntimesecs"])}
        if table == "creature":
            mt = int(r["MovementType"])
            if mt == 2:
                mt = 0; L("SPAWN creature %d (id %s) : chemin LC non porte, immobile" % (g, r["id"]))
            base.update({"modelid": int(r["modelid"]), "equipment_id": int(r["equipment_id"]), "spawndist": float(r["spawndist"]) if mt == 1 else 0,
                         "currentwaypoint": 0, "curhealth": int(r["curhealth"]), "curmana": int(r["curmana"]), "MovementType": mt,
                         "npcflag": int(r["npcflag"]), "unit_flags": int(r["unit_flags"]), "unit_flags2": 0, "unit_flags3": int(r["unit_flags3"]),
                         "dynamicflags": int(r["dynamicflags"]), "ScriptName": "", "movementmode": 0, "VerifiedBuild": 0})
        else:
            base.update({"rotation0": float(r["rotation0"]), "rotation1": float(r["rotation1"]), "rotation2": float(r["rotation2"]),
                         "rotation3": float(r["rotation3"]), "animprogress": int(r["animprogress"]), "state": int(r["state"]),
                         "isActive": int(r["isActive"]), "ScriptName": "", "VerifiedBuild": 0})
        sql.append(ins(table, base) + " -- LC %s" % r["guid"])
        added += 1
    L("SPAWNS %s : %d ajoutes, %d des notres rephases" % (table, added, matched))

# creature_addon des nouveaux spawns
newc = {lg: g for lg, g in guidmap["creature"].items() if g in new_guids["creature"]}
if newc:
    sql.append("\n-- creature_addon des nouveaux spawns")
    for r in q(LC, "SELECT * FROM creature_addon WHERE guid IN (%s)" % ids(newc)):
        sql.append(ins("creature_addon", {"guid": newc[int(r["guid"])], "path_id": 0, "mount": int(r["mount"]), "bytes1": int(r["bytes1"]),
                   "bytes2": int(r["bytes2"]), "emote": int(r["emote"]), "aiAnimKit": 0, "movementAnimKit": 0, "meleeAnimKit": 0,
                   "visibilityDistanceType": 0, "auras": r["auras"] or ""}))

# ---------------------------------------------------------------- 3. relations de quete manquantes
sql.append("\n-- 3. Donneurs / receveurs presents chez LegionCore et absents chez nous")
for t in ("creature_queststarter", "creature_questender", "gameobject_queststarter", "gameobject_questender"):
    ours = {(int(r["id"]), int(r["quest"])) for r in q(DC, "SELECT id,quest FROM %s WHERE quest IN (%s)" % (t, ids(Q)))}
    for r in q(LC, "SELECT id,quest FROM %s WHERE quest IN (%s) AND id<400000" % (t, ids(Q))):
        k = (int(r["id"]), int(r["quest"]))
        if k not in ours:
            sql.append("INSERT IGNORE INTO `%s` (id,quest) VALUES (%d,%d);" % (t, k[0], k[1]))

# ---------------------------------------------------------------- 4. PNJ : gossip, textes, SmartAI
npc_ids = set(entries_spawned["creature"]) | {int(r["id"]) for t in ("creature_queststarter", "creature_questender")
                                              for r in q(LC, "SELECT id FROM %s WHERE quest IN (%s)" % (t, ids(Q)))}
npc_ids |= {int(r["ObjectID"]) for r in q(LC, "SELECT ObjectID FROM quest_objectives WHERE QuestID IN (%s) AND Type IN (0,3)" % ids(Q))}
npc_ids = {i for i in npc_ids if i < 400000}
lc_t = {int(r["entry"]): r for r in q(LC, "SELECT entry,AIName,ScriptName,gossip_menu_id,npcflag FROM creature_template WHERE entry IN (%s)" % ids(npc_ids))}
dc_t = {int(r["entry"]): r for r in q(DC, "SELECT entry,AIName,ScriptName,gossip_menu_id,npcflag FROM creature_template WHERE entry IN (%s)" % ids(npc_ids))}
dc_smart = {int(r["e"]) for r in q(DC, "SELECT DISTINCT entryorguid e FROM smart_scripts WHERE source_type=0 AND entryorguid IN (%s)" % ids(npc_ids))}
dc_text = {int(r["CreatureID"]) for r in q(DC, "SELECT DISTINCT CreatureID FROM creature_text WHERE CreatureID IN (%s)" % ids(npc_ids))}
sql.append("\n-- 4. Modeles de PNJ (%d)" % len(npc_ids))

_bt = {}
def bt_text(bid, fallback, male=True):
    bid = int(bid or 0)
    if bid and bid not in _bt:
        r = q("dc_hotfixes", "SELECT Text,Text1 FROM broadcast_text WHERE ID=%d" % bid)
        _bt[bid] = (r[0]["Text"] or r[0]["Text1"] or "") if r else None
    t = _bt.get(bid) if bid else None
    if t:
        return t
    if fallback and re.search("[\u0400-\u04FF]", fallback):
        L("TEXTE russe sans broadcast_text anglais (bid %d) : %s" % (bid, fallback[:60]))
        return ""
    return fallback or ""

menus_needed = set()
emitted_al = set()  # listes d'actions deja ecrites (une meme liste peut servir a plusieurs PNJ)
for e in sorted(npc_ids):
    lt, dt = lc_t.get(e), dc_t.get(e)
    if not lt or not dt:
        L("PNJ %d absent d'un cote (lc=%s dc=%s)" % (e, bool(lt), bool(dt))); continue
    sets = []
    if int(dt["gossip_menu_id"]) == 0 and int(lt["gossip_menu_id"]):
        sets.append("gossip_menu_id=%s" % lt["gossip_menu_id"]); menus_needed.add(int(lt["gossip_menu_id"]))
    missing_flags = int(lt["npcflag"]) & ~int(dt["npcflag"]) & 0x3  # gossip / donneur de quetes seulement
    if missing_flags:
        sets.append("npcflag=npcflag|%d" % missing_flags)
    if lt["AIName"] == "SmartAI" and not dt["ScriptName"] and e not in dc_smart:
        rows = q(LC, "SELECT * FROM smart_scripts WHERE source_type=0 AND entryorguid=%d ORDER BY id" % e)
        # listes d'actions appelees (action 80/87/88)
        al = set()
        for r in rows:
            nm = ac_names.get(int(r["action_type"]), "")
            if nm == "SMART_ACTION_CALL_TIMED_ACTIONLIST": al.add(int(r["action_param1"]))
            if nm in ("SMART_ACTION_CALL_RANDOM_TIMED_ACTIONLIST",):
                al |= {int(r["action_param%d" % i]) for i in range(1, 7) if int(r["action_param%d" % i])}
            if nm == "SMART_ACTION_CALL_RANDOM_RANGE_TIMED_ACTIONLIST":
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
                                     "action_param3", "action_param4", "action_param5", "action_param6", "target_param1", "target_param2",
                                     "target_param3", "target_x", "target_y", "target_z", "target_o", "comment")}
            row.update({"event_type": ev, "action_type": ac, "target_type": tg, "event_param5": 0, "event_param_string": ""})
            row["comment"] = "LegionCore : %s / %s" % (ev_names.get(int(r["event_type"]), "?")[12:], ac_names.get(int(r["action_type"]), "?")[13:])
            for k in row:
                if k not in ("comment", "event_param_string") and row[k] is not None:
                    row[k] = float(row[k]) if k.startswith("target_") and k[-1] in "xyzo" else int(row[k])
            if ac_names.get(int(r["action_type"])) == "SMART_ACTION_TALK" and e not in dc_text:
                pass
            out.append(row)
        if bad:
            L("SMART %d abandonne : %s non traduisible" % (e, bad))
        elif out:
            sets.append("AIName='SmartAI'")
            existing_al = {int(r["e"]) for r in q(DC, "SELECT DISTINCT entryorguid e FROM smart_scripts WHERE source_type=9 AND entryorguid IN (%s)" % ids(al))} if al else set()
            for row in out:
                if row["source_type"] == 9 and (row["entryorguid"] in existing_al or row["entryorguid"] in emitted_al):
                    continue
                sql.append(ins("smart_scripts", row))
            emitted_al |= {row["entryorguid"] for row in out if row["source_type"] == 9}
    elif lt["AIName"] == "SmartAI" and dt["ScriptName"]:
        L("PNJ %d : script C++ chez nous (%s), SmartAI LC non porte" % (e, dt["ScriptName"]))
    if e not in dc_text:
        seen_txt = set()
        for r in q(LC, "SELECT * FROM creature_text WHERE Entry=%d ORDER BY GroupID,ID" % e):
            k = (int(r["GroupID"]), int(r["ID"]))
            if k in seen_txt:  # LegionCore n'a pas de cle primaire sur cette table
                continue
            seen_txt.add(k)
            sql.append(ins("creature_text", {"CreatureID": e, "GroupID": k[0], "ID": k[1], "Text": bt_text(r["BroadcastTextID"], r["Text"]),
                "Type": int(r["Type"]), "Language": int(r["Language"]), "Probability": float(r["Probability"]), "Emote": int(r["Emote"]),
                "Duration": int(r["Duration"]), "Sound": int(r["Sound"]), "BroadcastTextId": int(r["BroadcastTextID"]), "TextRange": 0,
                "comment": "LegionCore"}))
    if sets:
        sql.append("UPDATE creature_template SET %s WHERE entry=%d;" % (", ".join(sets), e))

# clics de sort : notre core n'ajoute PAS UNIT_NPC_FLAG_SPELLCLICK tout seul (il ne fait que le retirer)
click_ids = npc_ids | set(entries_spawned["creature"])
lc_click = q(LC, "SELECT npc_entry,spell_id,cast_flags,user_type FROM npc_spellclick_spells WHERE npc_entry IN (%s)" % ids(click_ids))
dc_click = {int(r["npc_entry"]) for r in q(DC, "SELECT DISTINCT npc_entry FROM npc_spellclick_spells WHERE npc_entry IN (%s)" % ids(click_ids))}
names = {int(r["entry"]): r["name"] for r in q(DC, "SELECT entry,name FROM creature_template WHERE entry IN (%s)" % ids(click_ids))}
sql.append("\n-- 4b. Clics de sort")
flag_ids = set()
for r in lc_click:
    e = int(r["npc_entry"])
    if (names.get(e) or "").startswith("Invisible"):  # siege de vehicule, pas un PNJ a cliquer
        continue
    if e not in dc_click:
        sql.append("INSERT IGNORE INTO npc_spellclick_spells (npc_entry,spell_id,cast_flags,user_type) VALUES (%d,%s,%s,%s);" % (e, r["spell_id"], r["cast_flags"], r["user_type"]))
    flag_ids.add(e)
for r in q(DC, "SELECT DISTINCT s.npc_entry e FROM npc_spellclick_spells s JOIN creature_template t ON t.entry=s.npc_entry WHERE s.npc_entry IN (%s) AND t.name NOT LIKE 'Invisible%%'" % ids(click_ids)):
    flag_ids.add(int(r["e"]))
if flag_ids:
    sql.append("UPDATE creature_template SET npcflag = npcflag | 16777216 WHERE entry IN (%s) AND (npcflag & 16777216) = 0;" % ids(flag_ids))

# menus de gossip (et sous-menus)
todo, seen = set(menus_needed), set()
have_menu = {int(r["MenuId"]) for r in q(DC, "SELECT DISTINCT MenuId FROM gossip_menu")}
have_opt = {int(r["MenuId"]) for r in q(DC, "SELECT DISTINCT MenuId FROM gossip_menu_option")}
have_text = {int(r["ID"]) for r in q(DC, "SELECT ID FROM npc_text")}
sql.append("\n-- 5. Menus de dialogue")
while todo:
    m = todo.pop(); seen.add(m)
    if m not in have_menu:
        for r in q(LC, "SELECT * FROM gossip_menu WHERE Entry=%d" % m):
            sql.append(ins("gossip_menu", {"MenuId": m, "TextId": int(r["TextID"]), "VerifiedBuild": 0}))
            if int(r["TextID"]) not in have_text:
                for t in q(LC, "SELECT * FROM npc_text WHERE ID=%s" % r["TextID"]):
                    sql.append(ins("npc_text", {k: int(t[k]) if k != "VerifiedBuild" else 0 for k in t}))
                have_text.add(int(r["TextID"]))
    if m not in have_opt:
        for r in q(LC, "SELECT * FROM gossip_menu_option WHERE MenuID=%d" % m):
            sql.append(ins("gossip_menu_option", {"MenuId": m, "OptionIndex": int(r["OptionIndex"]), "OptionIcon": int(r["OptionNPC"]),
                "OptionText": bt_text(r["OptionBroadcastTextID"], r["OptionText"]), "OptionBroadcastTextId": int(r["OptionBroadcastTextID"]), "OptionType": int(r["OptionType"]),
                "OptionNpcFlag": int(r["OptionNpcflag"]), "VerifiedBuild": 0}))
            if int(r["ActionMenuID"]):
                L("GOSSIP %d/%s : sous-menu %s (action de menu non geree par notre schema)" % (m, r["OptionIndex"], r["ActionMenuID"]))
        for c in q(LC, "SELECT * FROM conditions WHERE SourceTypeOrReferenceId IN (14,15) AND SourceGroup=%d" % m):
            c.pop("ErrorTextId", None)
            c = {k: (v if k in ("ScriptName", "Comment") else int(v)) for k, v in c.items() if v is not None}
            c.setdefault("ErrorType", 0); c.setdefault("ErrorTextId", 0); c["Comment"] = "LegionCore"
            sql.append(ins("conditions", c))

open(name + ".sql", "w").write("\n".join(sql) + "\n")
open(name + ".log", "w").write("\n".join(log) + "\n")
print("%s.sql : %d lignes ; %s.log : %d remarques" % (name, len(sql), name, len(log)))
