#!/usr/bin/env python3
"""Donneurs et receveurs absents chez nous repris de LegionCore, sans Wowhead (bloque), avec garde-fous.

Retenu seulement si : la quete n'a aucun donneur (resp. receveur) chez nous ; le PNJ LegionCore est pose
chez nous, dans la zone de la quete (tri positif), n'est pas un PNJ technique et porte chez LegionCore le
drapeau de donneur ; la quete est du contenu Legion (zones des Iles brisees, categories Legion, races
alliees) ou d'une fete. Ecartes : campagnes de classe 7.2 (-406 : LegionCore les range toutes chez
Modera ou Khadgar, donneurs de remplacement), anciennes quetes de classe, contenu BfA (>= 50000).
"""
import collections
import subprocess

LEGION_ZONES = {7334, 7558, 7503, 7541, 7637, 7502, 7543, 7731, 8147, 8440, 7578, 7813, 7846, 7979, 8000, 8026, 8124, 8285, 8701, 8445}
LEGION_CATS = {-427, -377, -420, -408, -422, -426, -429, -438, -439, -440, -394, -423, -419, -373, -394, -402, -405, -407, -409, -410}
HOLIDAYS = {-22, -366, -376, -370, -374, -369, -41, -375, -21, -378, -364}


def q(sql):
    out = subprocess.run(["mysql", "-N", "dc_world", "-e", sql], capture_output=True, text=True)
    if out.returncode:
        raise SystemExit(out.stderr)
    return [l.split("\t") for l in out.stdout.splitlines()]


ids = [int(x) for x in open("/home/ubuntu/tmp/donneurs/q.txt").read().split()]
L = ",".join(map(str, ids))
quest = {int(r[0]): (int(r[1]), r[2]) for r in q("SELECT ID,QuestSortID,LogTitle FROM quest_template WHERE ID IN (%s)" % L)}
zones = collections.defaultdict(set)
for i, z in q("SELECT DISTINCT id,zoneId FROM creature"):
    zones[int(i)].add(int(z))
tpl = {int(r[0]): (r[1], int(r[2])) for r in q("SELECT entry,name,npcflag FROM creature_template")}
lcflag = {int(r[0]): int(r[1]) for r in q("SELECT entry,npcflag FROM lc_world_ref.creature_template")}
TECH = ("Bunny", "Trigger", "Invisible", "Stalker", "Dummy", "Credit", "Generic", "Controller")


def eligible_quest(qu):
    sort, _ = quest[qu]
    if qu >= 50000:
        return False
    if sort > 0:
        return sort in LEGION_ZONES and qu >= 38000
    return sort in LEGION_CATS or sort in HOLIDAYS


def npc_ok(qu, npc):
    if npc not in tpl or npc not in zones:
        return "non pose"
    if any(t in tpl[npc][0] for t in TECH):
        return "technique"
    if not lcflag.get(npc, 0) & 2:
        return "sans drapeau LC"
    sort = quest[qu][0]
    if sort > 0 and sort not in zones[npc]:
        return "autre zone"
    return None


sql = ["-- Donneurs et receveurs de quetes absents chez nous, repris de LegionCore (garde-fous : voir donneurs_lc.py)"]
log, stats, flag = [], collections.Counter(), set()
for kind, t_lc, t_us in (("s", "creature_queststarter", "creature_queststarter"), ("e", "creature_questender", "creature_questender")):
    have = {int(r[0]) for r in q("SELECT quest FROM %s WHERE quest IN (%s) UNION SELECT quest FROM gameobject_%s WHERE quest IN (%s)" % (t_us, L, t_us.split("_", 1)[1], L))}
    for qu, npc in q("SELECT quest,id FROM lc_world_ref.%s WHERE quest IN (%s) ORDER BY quest,id" % (t_lc, L)):
        qu, npc = int(qu), int(npc)
        if qu in have or qu not in quest:
            continue
        if not eligible_quest(qu):
            stats[kind + "_hors_perimetre"] += 1
            continue
        why = npc_ok(qu, npc)
        if why:
            log.append("%d %s %s : PNJ %d %s" % (qu, kind, quest[qu][1], npc, why))
            stats[kind + "_" + why.replace(" ", "_")] += 1
            continue
        sql.append("INSERT IGNORE INTO `%s` (`id`, `quest`) VALUES (%d, %d); -- %s / %s" % (t_us, npc, qu, tpl[npc][0], quest[qu][1]))
        stats[kind + "_ajoute"] += 1
        flag.add(npc)
sql.append("\n-- Drapeau de donneur de quetes (npcflag 2)")
for i in sorted(flag):
    if not tpl[i][1] & 2:
        sql.append("UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry`=%d; -- %s" % (i, tpl[i][0]))
        sql.append("UPDATE `creature` SET `npcflag`=`npcflag`|2 WHERE `id`=%d AND `npcflag`<>0 AND (`npcflag`&2)=0;" % i)
open("/home/ubuntu/tmp/donneurs/donneurs_lc.sql", "w").write("\n".join(sql) + "\n")
open("/home/ubuntu/tmp/donneurs/donneurs_lc.log", "w").write("\n".join(log) + "\n")
print(dict(stats))
