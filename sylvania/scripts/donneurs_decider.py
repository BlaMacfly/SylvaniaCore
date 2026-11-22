#!/usr/bin/env python3
"""Donneurs et receveurs de quetes absents chez nous : LegionCore croise avec Wowhead.

Usage : donneurs_decider.py <wowhead.tsv> <nom>
wowhead.tsv : quete, statut HTTP, departs (n123,o456,i789 separes par des virgules), arrivees, retiree (0/1).
Regles, seulement pour une quete qui n'a AUCUN donneur (resp. receveur) chez nous :
- PNJ que LegionCore ET Wowhead donnent : ajoute ;
- sinon PNJ unique de Wowhead, pose chez nous : ajoute (note « Wowhead seul ») ;
- objet de Wowhead pose chez nous : gameobject_queststarter / questender ;
- objet d'inventaire (depart par un objet) : rien, note.
Le PNJ recoit le drapeau de donneur de quetes (npcflag 2) s'il ne l'a pas.
"""
import collections
import subprocess
import sys

wh_path, name = sys.argv[1], sys.argv[2]


def q(sql):
    out = subprocess.run(["mysql", "-N", "dc_world", "-e", sql], capture_output=True, text=True)
    if out.returncode:
        raise SystemExit(out.stderr)
    return [l.split("\t") for l in out.stdout.splitlines()]


wh = {}
for l in open(wh_path):
    p = l.rstrip("\n").split("\t")
    if len(p) < 5:
        continue
    wh[int(p[0])] = (int(p[1]), [x for x in p[2].split(",") if x], [x for x in p[3].split(",") if x], p[4] == "1")
quests = sorted(wh)
L = ",".join(map(str, quests))
lc_s, lc_e = collections.defaultdict(set), collections.defaultdict(set)
for qu, i in q("SELECT quest,id FROM lc_world_ref.creature_queststarter WHERE quest IN (%s)" % L):
    lc_s[int(qu)].add(int(i))
for qu, i in q("SELECT quest,id FROM lc_world_ref.creature_questender WHERE quest IN (%s)" % L):
    lc_e[int(qu)].add(int(i))
has_s = {int(x[0]) for x in q("SELECT quest FROM creature_queststarter WHERE quest IN (%s) UNION SELECT quest FROM gameobject_queststarter WHERE quest IN (%s)" % (L, L))}
has_e = {int(x[0]) for x in q("SELECT quest FROM creature_questender WHERE quest IN (%s) UNION SELECT quest FROM gameobject_questender WHERE quest IN (%s)" % (L, L))}
spawned_cr = {int(x[0]) for x in q("SELECT DISTINCT id FROM creature")}
spawned_go = {int(x[0]) for x in q("SELECT DISTINCT id FROM gameobject")}
cr_tpl = {int(x[0]): (x[1], int(x[2])) for x in q("SELECT entry,name,npcflag FROM creature_template")}
title = {int(x[0]): x[1] for x in q("SELECT ID,LogTitle FROM quest_template WHERE ID IN (%s)" % L)}

sql = ["-- Donneurs et receveurs de quetes absents chez nous, d'apres LegionCore croise avec Wowhead (pages de quete)"]
log, flag_npc = [], set()
stats = collections.Counter()


def decide(qu, kind, lc, whl, have):
    if qu in have:
        return
    st, s, e, gone = wh[qu]
    w = s if kind == "s" else e
    wn = {int(x[1:]) for x in w if x[0] == "n"}
    wo = {int(x[1:]) for x in w if x[0] == "o"}
    wi = [x for x in w if x[0] == "i"]
    t_cr = "creature_queststarter" if kind == "s" else "creature_questender"
    t_go = "gameobject_queststarter" if kind == "s" else "gameobject_questender"
    both = sorted(lc.get(qu, set()) & wn)
    picked = []
    if both:
        picked = [(i, "LegionCore + Wowhead") for i in both]
    elif len(wn) == 1 and next(iter(wn)) in spawned_cr:
        picked = [(next(iter(wn)), "Wowhead seul (LegionCore : %s)" % sorted(lc.get(qu, set())))]
    for i, why in picked:
        if i not in cr_tpl:
            log.append("%d %s : PNJ %d absent de creature_template" % (qu, kind, i))
            continue
        sql.append("INSERT IGNORE INTO `%s` (`id`, `quest`) VALUES (%d, %d); -- %s / %s ; %s%s" % (
            t_cr, i, qu, cr_tpl[i][0].replace("\n", " "), title.get(qu, "?"), why, "" if i in spawned_cr else " ; PNJ NON POSE"))
        stats[kind + ("_pose" if i in spawned_cr else "_nonpose")] += 1
        flag_npc.add(i)
    if not picked:
        gos = sorted(x for x in wo if x in spawned_go)
        for g in gos:
            sql.append("INSERT IGNORE INTO `%s` (`id`, `quest`) VALUES (%d, %d); -- objet / %s ; Wowhead" % (t_go, g, qu, title.get(qu, "?")))
            stats[kind + "_objet"] += 1
        if not gos:
            log.append("%d %s %s : rien (LC %s, Wowhead %s%s)" % (qu, kind, title.get(qu, "?"), sorted(lc.get(qu, set())), w, " retiree" if gone else ""))
            stats[kind + "_rien" + ("_objetinv" if wi else "")] += 1


for qu in quests:
    st, s, e, gone = wh[qu]
    if st != 200:
        log.append("%d : Wowhead statut %d" % (qu, st))
        continue
    if gone:
        log.append("%d %s : retiree du jeu selon Wowhead" % (qu, title.get(qu, "?")))
        stats["retiree"] += 1
        continue
    decide(qu, "s", lc_s, s, has_s)
    decide(qu, "e", lc_e, e, has_e)

sql.append("\n-- Drapeau de donneur de quetes")
for i in sorted(flag_npc):
    if not cr_tpl[i][1] & 2:
        sql.append("UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry`=%d; -- %s" % (i, cr_tpl[i][0]))
        sql.append("UPDATE `creature` SET `npcflag`=`npcflag`|2 WHERE `id`=%d AND `npcflag`<>0 AND (`npcflag`&2)=0;" % i)
open(name + ".sql", "w").write("\n".join(sql) + "\n")
open(name + ".log", "w").write("\n".join(log) + "\n")
print(dict(stats))
