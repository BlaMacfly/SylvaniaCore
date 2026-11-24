#!/usr/bin/env python3
"""Dialogues des PNJ poses chez nous sans menu (gossip_menu_id 0) alors que LegionCore leur en donne un.

Usage : gen_menus.py > sortie.sql   (stats sur stderr)
- menu deja chez nous : on ne fait que le rattacher ;
- sinon le menu LC est porte (gossip_menu), avec son texte (npc_text) s'il nous manque et que toutes ses
  repliques existent dans notre broadcast_text ; sinon le PNJ est laisse tel quel ;
- options LC des menus portes (et des menus a nous qui n'en ont aucune) : texte anglais officiel pris dans
  broadcast_text (LegionCore stocke du russe), types sans risque seulement, sous-menus suivis (3 niveaux),
  point d'interet garde s'il existe chez nous, boite de confirmation portee ;
- drapeau GOSSIP ajoute quand LC l'a.
"""
import collections
import re
import subprocess
import sys


def q(sql):
    out = subprocess.run(["mysql", "-N", "-B", "-e", sql], capture_output=True, text=True)
    if out.returncode:
        raise SystemExit(out.stderr + sql)
    return [l.split("\t") for l in out.stdout.splitlines() if l]


def esc(s):
    return s.replace("\\", "\\\\").replace("'", "\\'")


SAFE = {1, 3, 4, 5, 8, 9, 10, 11, 12, 13, 14, 15, 20}
stats = collections.Counter()
npcs = q("SELECT d.entry, d.npcflag, lt.npcflag, lt.gossip_menu_id FROM dc_world.creature_template d "
         "JOIN lc_world_ref.creature_template lt ON lt.entry=d.entry WHERE d.gossip_menu_id=0 AND lt.gossip_menu_id<>0 "
         "AND EXISTS (SELECT 1 FROM dc_world.creature c WHERE c.id=d.entry)")
our_menu = {r[0] for r in q("SELECT DISTINCT MenuId FROM dc_world.gossip_menu")}
our_opt_menu = {r[0] for r in q("SELECT DISTINCT MenuId FROM dc_world.gossip_menu_option")}
our_text = {r[0] for r in q("SELECT ID FROM dc_world.npc_text")}
bt = {}
our_poi = {r[0] for r in q("SELECT ID FROM dc_world.points_of_interest")}
lc_menu = collections.defaultdict(list)
for m, t in q("SELECT Entry, TextID FROM lc_world_ref.gossip_menu"):
    lc_menu[m].append(t)
lc_text = {r[0]: r for r in q("SELECT * FROM lc_world_ref.npc_text")}
lc_opt = collections.defaultdict(list)
for r in q("SELECT MenuID, OptionIndex, OptionNPC, OptionText, OptionType, OptionNpcflag, ActionMenuID, ActionPoiID, BoxCoded, BoxMoney, "
           "BoxText, OptionBroadcastTextID, BoxBroadcastTextID FROM lc_world_ref.gossip_menu_option"):
    lc_opt[r[0]].append(r)


def english(bid):
    if not bid or bid == "0":
        return None
    if bid not in bt:
        r = q("SELECT Text, Text1 FROM dc_hotfixes.broadcast_text WHERE ID=%s" % bid)
        bt[bid] = (r[0][0] or r[0][1]) if r else None
        if bt[bid] in ("", "NULL"):
            bt[bid] = None
    return bt[bid]


sql_menu, sql_text, sql_opt, sql_tpl = [], [], [], []
new_menus = set()


def port_menu(m, depth=0):
    """Rend True si le menu m existe (deja ou porte)."""
    if m in our_menu or m in new_menus:
        return True
    texts = lc_menu.get(m)
    if not texts:
        return False
    for t in texts:
        if t not in our_text:
            r = lc_text.get(t)
            if not r:
                return False
            ids = [x for x in r[9:17] if x not in ("0", "")]
            if not ids or any(english(x) is None for x in ids):
                stats["menu ecarte : texte %s sans replique chez nous" % ("LC")] += 1
                return False
    for t in texts:
        if t not in our_text:
            r = lc_text[t]
            sql_text.append("INSERT INTO `npc_text` (`ID`,`Probability0`,`Probability1`,`Probability2`,`Probability3`,`Probability4`,`Probability5`,"
                            "`Probability6`,`Probability7`,`BroadcastTextID0`,`BroadcastTextID1`,`BroadcastTextID2`,`BroadcastTextID3`,"
                            "`BroadcastTextID4`,`BroadcastTextID5`,`BroadcastTextID6`,`BroadcastTextID7`,`VerifiedBuild`) VALUES (%s,0);"
                            % ",".join(r[:17]))
            our_text.add(t)
            stats["textes portes"] += 1
        sql_menu.append("INSERT INTO `gossip_menu` (`MenuId`,`TextId`,`VerifiedBuild`) VALUES (%s,%s,0);" % (m, t))
    new_menus.add(m)
    stats["menus portes"] += 1
    port_options(m, depth)
    return True


def port_options(m, depth):
    if m in our_opt_menu:
        return
    our_opt_menu.add(m)
    for (_, idx, icon, text, typ, nflag, amenu, apoi, bcoded, bmoney, btext, obid, bbid) in lc_opt.get(m, []):
        if int(typ) not in SAFE:
            stats["option ecartee : type %s" % typ] += 1
            continue
        txt = english(obid) or (text if text and not re.search(r"[^\x20-\x7e]", text) and text != "NULL" else None)
        if not txt:
            stats["option ecartee : texte russe sans replique"] += 1
            continue
        if amenu not in ("0", "") and (depth >= 3 or not port_menu(amenu, depth + 1)):
            stats["option ecartee : sous-menu introuvable"] += 1
            continue
        sql_opt.append("INSERT INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,"
                       "`OptionNpcFlag`,`VerifiedBuild`) VALUES (%s,%s,%s,'%s',%s,%s,%s,0);" % (m, idx, icon, esc(txt), obid or 0, typ, nflag))
        poi = apoi if apoi in our_poi else "0"
        if amenu not in ("0", "") or poi != "0":
            sql_opt.append("INSERT IGNORE INTO `gossip_menu_option_action` (`MenuId`,`OptionIndex`,`ActionMenuId`,`ActionPoiId`) VALUES (%s,%s,%s,%s);"
                           % (m, idx, amenu or 0, poi))
        if bcoded not in ("0", "") or bmoney not in ("0", "") or bbid not in ("0", ""):
            bx = english(bbid) or (btext if btext and not re.search(r"[^\x20-\x7e]", btext) and btext != "NULL" else "")
            sql_opt.append("INSERT IGNORE INTO `gossip_menu_option_box` (`MenuId`,`OptionIndex`,`BoxCoded`,`BoxMoney`,`BoxText`,`BoxBroadcastTextId`) "
                           "VALUES (%s,%s,%s,%s,'%s',%s);" % (m, idx, bcoded or 0, bmoney or 0, esc(bx), bbid or 0))
        stats["options portees"] += 1


for e, dflag, lflag, m in npcs:
    if not port_menu(m):
        stats["PNJ laisses : menu LC non portable"] += 1
        continue
    if m in our_menu:
        port_options(m, 0)   # menu a nous sans aucune option alors que LC en a
    flag = int(dflag) | (int(lflag) & 1)
    sql_tpl.append("UPDATE `creature_template` SET `gossip_menu_id`=%s, `npcflag`=%d WHERE `entry`=%s AND `gossip_menu_id`=0;" % (m, flag, e))
    stats["PNJ rattaches (menu deja chez nous)" if m in our_menu else "PNJ rattaches (menu porte)"] += 1

print("-- Dialogues des PNJ poses sans menu chez nous, menu chez LegionCore (gen_menus.py).")
print("-- Menus deja chez nous rattaches ; menus, textes et options LC portes (anglais officiel de broadcast_text).")
for block in (sql_text, sql_menu, sql_opt, sql_tpl):
    print("\n".join(block))
for k, v in sorted(stats.items()):
    print("%s : %d" % (k, v), file=sys.stderr)
