#!/usr/bin/env python3
"""port_smart.py <sortie> <creatures> [<areatriggers>] : SmartAI de LegionCore pour des PNJ et des zones de declenchement.

Les numeros d'evenements, d'actions et de cibles sont traduits PAR NOM entre les deux enums (comme port_campagne.py) ;
une ligne intraduisible fait abandonner tout le script de l'entree. On ne touche pas une entree qui a deja un ScriptName
ou un SmartAI chez nous. Les listes d'actions appelees (source 9) suivent. Les repliques manquantes sont prises dans
broadcast_text (anglais officiel, traduit par le client).
"""
import re, subprocess, sys

LC, DC = "lc_world_ref", "dc_world"
OURS_SMART = "/home/ubuntu/DestinyCore/src/server/game/AI/SmartScripts/SmartScriptMgr.h"
LC_SMART = "/home/ubuntu/tmp/audit-domaines/lc_SmartScriptMgr.h"

def q(db, sql):
    out = subprocess.run(["mysql", db, "-B", "-e", sql], capture_output=True, text=True)
    if out.returncode:
        raise SystemExit("SQL %s : %s\n%s" % (db, out.stderr, sql))
    lines = out.stdout.split("\n")
    if not lines or not lines[0]:
        return []
    cols = lines[0].split("\t")
    return [dict(zip(cols, [None if v == "NULL" else v for v in l.split("\t")])) for l in lines[1:] if l != ""]

def lit(v):
    if v is None:
        return "NULL"
    if isinstance(v, (int, float)):
        return repr(v)
    return "'" + str(v).replace("\\", "\\\\").replace("'", "\\'") + "'"

def ins(table, row):
    return "INSERT INTO `%s` (%s) VALUES (%s);" % (table, ",".join("`%s`" % k for k in row), ",".join(lit(v) for v in row.values()))

def smart_enum(path, name):
    s = open(path, encoding="latin1").read()
    m = re.search(r"enum\s+" + name + r"\s*\{(.*?)\};", s, re.S)
    return {int(v): n for n, v in re.findall(r"^\s*(SMART_[A-Z0-9_]+)\s*=\s*(\d+)", m.group(1), re.M)}

ALIASES = {"SMART_ACTION_SUMMON_CONVERSATION": "SMART_ACTION_START_CONVERSATION",
           "SMART_EVENT_TARGET_CASTING": "SMART_EVENT_VICTIM_CASTING", "SMART_ACTION_ADD_QUEST": "SMART_ACTION_OFFER_QUEST"}
def translator(name):
    a = smart_enum(LC_SMART, name)
    b = {v: k for k, v in smart_enum(OURS_SMART, name).items()}
    return (lambda n: None if a.get(n) is None else b.get(ALIASES.get(a[n], a[n]), b.get(a[n]))), a
tr_ev, ev_names = translator("SMART_EVENT")
tr_ac, ac_names = translator("SMART_ACTION")
tr_tg, tg_names = translator("SMARTAI_TARGETS")

name = sys.argv[1]
creatures = [int(x) for x in sys.argv[2].split(",") if x]
args = [a for a in sys.argv[3:] if not a.startswith("--")]
triggers = [int(x) for x in args[0].split(",") if x] if args and args[0] != "-" else []
def opt(name):
    return sys.argv[sys.argv.index(name) + 1] if name in sys.argv else ""
# --merge e1,e2 : ajouter les lignes LC a notre SmartAI existant (ids decales, lignes identiques ignorees)
merge = {int(x) for x in opt("--merge").split(",") if x}
# --merge-credit e1,e2 : comme --merge, mais seulement les groupes de lignes liees (link) qui donnent un credit
merge_credit = {int(x) for x in opt("--merge-credit").split(",") if x}
merge |= merge_credit

def credit_components(rows):
    """Lignes source 0 des composantes liees (par link) contenant un credit, ou un appel de liste qui en donne un."""
    credit_names = ("SMART_ACTION_CALL_KILLEDMONSTER", "SMART_ACTION_KILL_CREDIT", "SMART_ACTION_CALL_GROUPEVENTHAPPENS")
    lists_with_credit = {int(r["entryorguid"]) for r in rows if r["source_type"] == "9" and ac_names.get(int(r["action_type"]), "") in credit_names}
    base = [r for r in rows if r["source_type"] == "0"]
    parent = {int(r["id"]): int(r["id"]) for r in base}
    def find(x):
        while parent[x] != x:
            x = parent[x]
        return x
    for r in base:
        if int(r["link"]) and int(r["link"]) in parent:
            parent[find(int(r["id"]))] = find(int(r["link"]))
    keep = set()
    for r in base:
        nm = ac_names.get(int(r["action_type"]), "")
        if nm in credit_names or (nm.startswith("SMART_ACTION_CALL_") and "ACTIONLIST" in nm and int(r["action_param1"]) in lists_with_credit):
            keep.add(find(int(r["id"])))
    ids = {int(r["id"]) for r in base if find(int(r["id"])) in keep}
    used_lists = set()
    for r in base:
        if int(r["id"]) in ids:
            used_lists |= action_lists([r])
    return [r for r in rows if (r["source_type"] == "0" and int(r["id"]) in ids) or (r["source_type"] == "9" and int(r["entryorguid"]) in used_lists)]
# --menus lc:nous,... : le menu de dialogue vise par SMART_EVENT_GOSSIP_SELECT, LC utilisant ses propres numeros
menus = {int(a): int(b) for a, b in (x.split(":") for x in opt("--menus").split(",") if x)}
# --gobjects g1,g2 : SmartAI d'objets (source 1) ; --auto-menus : menu LC du PNJ -> notre menu officiel du meme PNJ
gobjects = [int(x) for x in opt("--gobjects").split(",") if x]
auto_menus = "--auto-menus" in sys.argv
# --adopt-menus : PNJ sans menu chez nous -> il prend le menu LC (porte avec son texte et ses options s'il manque)
adopt_menus = "--adopt-menus" in sys.argv
ported_menus = set()

def port_menu(m):
    """gossip_menu, npc_text et options du menu LC m, pour ce qui manque chez nous ; False si rien d'utilisable."""
    out = []
    if not q(DC, "SELECT 1 FROM gossip_menu WHERE MenuId=%d LIMIT 1" % m) and m not in ported_menus:
        for r in q(LC, "SELECT * FROM gossip_menu WHERE Entry=%d" % m):
            out.append(ins("gossip_menu", {"MenuId": m, "TextId": int(r["TextID"]), "VerifiedBuild": 0}))
            if not q(DC, "SELECT 1 FROM npc_text WHERE ID=%s" % r["TextID"]):
                for t in q(LC, "SELECT * FROM npc_text WHERE ID=%s" % r["TextID"]):
                    out.append(ins("npc_text", {k: int(t[k]) if k != "VerifiedBuild" else 0 for k in t}))
    if not q(DC, "SELECT 1 FROM gossip_menu_option WHERE MenuId=%d LIMIT 1" % m) and m not in ported_menus:
        opts = []
        for r in q(LC, "SELECT * FROM gossip_menu_option WHERE MenuID=%d" % m):
            bid = int(r["OptionBroadcastTextID"] or 0)
            txt = english(bid) if bid else None
            if not txt:
                txt = r["OptionText"] or ""
                if any("\u0400" <= ch <= "\u04FF" for ch in txt):
                    continue
            opts.append(ins("gossip_menu_option", {"MenuId": m, "OptionIndex": int(r["OptionIndex"]), "OptionIcon": int(r["OptionNPC"]),
                "OptionText": txt, "OptionBroadcastTextId": bid, "OptionType": int(r["OptionType"]), "OptionNpcFlag": int(r["OptionNpcflag"]), "VerifiedBuild": 0}))
        if not opts:
            return None
        out += opts
    ported_menus.add(m)
    return out
sql, log = ["-- SmartAI porte de LegionCore (%s)" % name], []

bt = {}
def english(bid):
    if bid not in bt:
        r = q("dc_hotfixes", "SELECT Text, Text1 FROM broadcast_text WHERE ID=%d" % bid)
        bt[bid] = (r[0]["Text"] or r[0]["Text1"]) if r else None
    return bt[bid]

def convert(rows):
    out = []
    for r in rows:
        ev, ac, tg = tr_ev(int(r["event_type"])), tr_ac(int(r["action_type"])), tr_tg(int(r["target_type"]))
        if ev is None or ac is None or tg is None:
            return None, "event %s / action %s / cible %s" % (ev_names.get(int(r["event_type"])), ac_names.get(int(r["action_type"])), tg_names.get(int(r["target_type"])))
        row = {k: r[k] for k in ("entryorguid", "source_type", "id", "link", "event_phase_mask", "event_chance", "event_flags",
                                 "event_param1", "event_param2", "event_param3", "event_param4", "action_param1", "action_param2",
                                 "action_param3", "action_param4", "action_param5", "action_param6", "target_param1", "target_param2",
                                 "target_param3", "target_x", "target_y", "target_z", "target_o")}
        row.update({"event_type": ev, "action_type": ac, "target_type": tg, "event_param5": 0, "event_param_string": ""})
        row["comment"] = "LegionCore : %s / %s" % (ev_names.get(int(r["event_type"]), "?")[12:], ac_names.get(int(r["action_type"]), "?")[13:])
        for k in row:
            if k not in ("comment", "event_param_string") and row[k] is not None:
                row[k] = float(row[k]) if k.startswith("target_") and k[-1] in "xyzo" else int(row[k])
        out.append(row)
    return out, None

def action_lists(rows):
    al = set()
    for r in rows:
        nm = ac_names.get(int(r["action_type"]), "")
        if nm == "SMART_ACTION_CALL_TIMED_ACTIONLIST":
            al.add(int(r["action_param1"]))
        elif nm == "SMART_ACTION_CALL_RANDOM_TIMED_ACTIONLIST":
            al |= {int(r["action_param%d" % i]) for i in range(1, 7) if int(r["action_param%d" % i])}
        elif nm == "SMART_ACTION_CALL_RANDOM_RANGE_TIMED_ACTIONLIST":
            al |= set(range(int(r["action_param1"]), int(r["action_param2"]) + 1))
    return al

have_al = {int(r["e"]) for r in q(DC, "SELECT DISTINCT entryorguid e FROM smart_scripts WHERE source_type=9")}
for e in creatures:
    t = q(DC, "SELECT AIName, ScriptName FROM creature_template WHERE entry=%d" % e)
    if not t:
        log.append("PNJ %d absent chez nous" % e); continue
    ours = q(DC, "SELECT * FROM smart_scripts WHERE source_type=0 AND entryorguid=%d ORDER BY id" % e)
    if t[0]["ScriptName"] or (ours and e not in merge):
        log.append("PNJ %d : deja scripte chez nous (%s)" % (e, t[0]["ScriptName"] or "SmartAI")); continue
    rows = q(LC, "SELECT * FROM smart_scripts WHERE source_type=0 AND entryorguid=%d ORDER BY id" % e)
    al = action_lists(rows)
    if al:
        rows += q(LC, "SELECT * FROM smart_scripts WHERE source_type=9 AND entryorguid IN (%s) ORDER BY entryorguid, id" % ",".join(map(str, al)))
    if e in merge_credit:
        rows = credit_components(rows)
        if not rows:
            log.append("PNJ %d : aucune chaine de credit chez LC" % e); continue
    out, bad = convert(rows)
    if bad:
        log.append("PNJ %d abandonne : %s" % (e, bad)); continue
    gossip_select = {v: k for k, v in ev_names.items()}.get("SMART_EVENT_GOSSIP_SELECT")
    local_menus = dict(menus)
    if auto_menus:
        lc_menu = q(LC, "SELECT gossip_menu_id m FROM creature_template WHERE entry=%d" % e)
        our_menu = int(q(DC, "SELECT gossip_menu_id m FROM creature_template WHERE entry=%d" % e)[0]["m"])
        uses = {int(r["event_param1"]) for r in rows if r["source_type"] == "0" and int(r["event_type"]) == gossip_select}
        if uses:
            lc_m = int(lc_menu[0]["m"]) if lc_menu else 0
            if not our_menu and adopt_menus and lc_m and uses <= {lc_m, e}:
                menu_sql = port_menu(lc_m)
                if menu_sql is None:
                    log.append("PNJ %d abandonne : menu LC %d sans option utilisable" % (e, lc_m)); continue
                sql.append("\n-- PNJ %d : menu de dialogue %d repris de LC" % (e, lc_m))
                sql.extend(menu_sql)
                sql.append("UPDATE creature_template SET gossip_menu_id=%d, npcflag=npcflag|1 WHERE entry=%d AND gossip_menu_id=0;" % (lc_m, e))
                for m in uses:
                    local_menus.setdefault(m, lc_m)
            elif not our_menu or not q(DC, "SELECT 1 FROM gossip_menu_option WHERE MenuId=%d LIMIT 1" % our_menu):
                log.append("PNJ %d abandonne : dialogue LC (menus %s) sans menu a options chez nous" % (e, sorted(uses))); continue
            else:
                for m in uses:
                    local_menus.setdefault(m, our_menu)
    for row in out:
        if row["source_type"] == 0 and int(rows[out.index(row)]["event_type"]) == gossip_select and row["event_param1"] in local_menus:
            row["event_param1"] = local_menus[row["event_param1"]]
    if ours:
        sig = lambda r: tuple(int(r[k]) for k in ("event_type", "event_param1", "event_param2", "event_param3", "event_param4", "action_type", "action_param1", "action_param2", "target_type"))
        have = {sig(r) for r in ours}
        linked = {row["link"] for row in out if row["source_type"] == 0 and row["link"]}
        offset = max(int(r["id"]) for r in ours) + 1
        kept = []
        for row in out:
            if row["source_type"] == 0:
                if sig(row) in have and not row["link"] and row["id"] not in linked:
                    continue
                row["id"] += offset
                if row["link"]:
                    row["link"] += offset
            kept.append(row)
        out = kept
        log.append("PNJ %d : fusion avec notre SmartAI (ids LC decales de %d)" % (e, offset))
    sql.append("\n-- PNJ %d" % e)
    for row in out:
        if row["source_type"] == 9 and row["entryorguid"] in have_al:
            continue
        sql.append(ins("smart_scripts", row))
    have_al |= {row["entryorguid"] for row in out if row["source_type"] == 9}
    sql.append("UPDATE creature_template SET AIName='SmartAI' WHERE entry=%d AND ScriptName='';" % e)
    if not q(DC, "SELECT 1 FROM creature_text WHERE CreatureID=%d LIMIT 1" % e):
        seen = set()
        for r in q(LC, "SELECT GroupID, ID, Type, Language, Probability, Emote, Duration, Sound, BroadcastTextID FROM creature_text WHERE Entry=%d ORDER BY GroupID, ID" % e):
            k = (int(r["GroupID"]), int(r["ID"]))
            txt = english(int(r["BroadcastTextID"] or 0))
            if k in seen or not txt:
                continue
            seen.add(k)
            sql.append(ins("creature_text", {"CreatureID": e, "GroupID": k[0], "ID": k[1], "Text": txt, "Type": int(r["Type"]),
                "Language": int(r["Language"]), "Probability": float(r["Probability"]), "Emote": int(r["Emote"]), "Duration": int(r["Duration"]),
                "Sound": int(r["Sound"]), "BroadcastTextId": int(r["BroadcastTextID"]), "TextRange": 0, "comment": "LegionCore"}))

for g in gobjects:
    t = q(DC, "SELECT AIName, ScriptName FROM gameobject_template WHERE entry=%d" % g)
    if not t:
        log.append("objet %d absent chez nous" % g); continue
    if t[0]["ScriptName"] or t[0]["AIName"] or q(DC, "SELECT 1 FROM smart_scripts WHERE source_type=1 AND entryorguid=%d LIMIT 1" % g):
        log.append("objet %d : deja scripte chez nous" % g); continue
    rows = q(LC, "SELECT * FROM smart_scripts WHERE source_type=1 AND entryorguid=%d ORDER BY id" % g)
    al = action_lists(rows)
    if al:
        rows += q(LC, "SELECT * FROM smart_scripts WHERE source_type=9 AND entryorguid IN (%s) ORDER BY entryorguid, id" % ",".join(map(str, al)))
    gossip_select = {v: k for k, v in ev_names.items()}.get("SMART_EVENT_GOSSIP_SELECT")
    if any(r["source_type"] == "1" and int(r["event_type"]) == gossip_select for r in rows):
        log.append("objet %d abandonne : dialogue d objet (menus non verifies)" % g); continue
    out, bad = convert(rows)
    if bad or not out:
        log.append("objet %d abandonne : %s" % (g, bad or "rien chez LC")); continue
    sql.append("\n-- objet %d" % g)
    for row in out:
        if row["source_type"] == 9 and row["entryorguid"] in have_al:
            continue
        sql.append(ins("smart_scripts", row))
    have_al |= {row["entryorguid"] for row in out if row["source_type"] == 9}
    sql.append("UPDATE gameobject_template SET AIName='SmartGameObjectAI' WHERE entry=%d AND ScriptName='';" % g)

for at in triggers:
    if q(DC, "SELECT 1 FROM areatrigger_scripts WHERE entry=%d" % at) or q(DC, "SELECT 1 FROM smart_scripts WHERE source_type=2 AND entryorguid=%d LIMIT 1" % at):
        log.append("zone %d : deja scriptee chez nous" % at); continue
    out, bad = convert(q(LC, "SELECT * FROM smart_scripts WHERE source_type=2 AND entryorguid=%d ORDER BY id" % at))
    if bad or not out:
        log.append("zone %d abandonnee : %s" % (at, bad or "rien chez LC")); continue
    sql.append("\n-- zone de declenchement %d" % at)
    sql += [ins("smart_scripts", row) for row in out]
    sql.append("INSERT INTO areatrigger_scripts (entry, ScriptName) VALUES (%d, 'SmartTrigger');" % at)

open(name + ".sql", "w").write("\n".join(sql) + "\n")
open(name + ".log", "w").write("\n".join(log) + "\n")
print("%s.sql : %d lignes ; %d remarques" % (name, len(sql), len(log)))
