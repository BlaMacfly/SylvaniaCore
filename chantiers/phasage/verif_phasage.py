#!/usr/bin/env python3
"""Verifie qu'apres phasage d'une zone, chaque quete de la zone garde un donneur visible (prerequis rendus,
quete non prise) et un receveur visible (quete prise et accomplie).

Usage : verif_phasage.py <db> <zone> [hotfixes_supplementaires.sql]
Modele simplifie du joueur : quetes rendues = fermeture des PrevQuestID ; aucune autre quete en cours.
Conditions non modelisees (aura, classe, faction...) : supposees vraies.
"""
import collections, csv, re, subprocess, sys

DB, ZONE = sys.argv[1], int(sys.argv[2])

def q(db, sql):
    o = subprocess.run(["mysql", "-N", db, "-e", sql], capture_output=True, text=True, check=True).stdout
    return [l.split("\t") for l in o.split("\n") if l]

parent = {int(r["ID"]): int(r["ParentAreaID"]) for r in csv.DictReader(open("/home/ubuntu/tmp/AreaTable.csv"))}
groups = collections.defaultdict(set)
for r in csv.DictReader(open("/home/ubuntu/tmp/PhaseXPhaseGroup.csv")):
    groups[int(r["PhaseGroupID"])].add(int(r["PhaseID"]))
for p, g in q("dc_hotfixes", "SELECT PhaseID,PhaseGroupID FROM phase_x_phase_group"):
    groups[int(g)].add(int(p))
if len(sys.argv) > 3:
    for p, g in re.findall(r"VALUES \(\d+,(\d+),(\d+),0\)", open(sys.argv[3]).read()):
        groups[int(g)].add(int(p))

pa = collections.defaultdict(set)
for a, p in q(DB, "SELECT AreaId,PhaseId FROM phase_area"):
    pa[int(a)].add(int(p))
conds = collections.defaultdict(lambda: collections.defaultdict(list))
for g, e, eg, t, v1, v2, v3, neg in q(DB, "SELECT SourceGroup,SourceEntry,ElseGroup,ConditionTypeOrReference,ConditionValue1,ConditionValue2,ConditionValue3,NegativeCondition FROM conditions WHERE SourceTypeOrReferenceId=26"):
    conds[(int(g), int(e))][int(eg)].append((int(t), int(v1), int(v2), int(neg)))
obj_quest = {int(i): int(qq) for i, qq in q(DB, "SELECT ID,QuestID FROM quest_objectives")}

prev = {}
for qid, pv in q(DB, "SELECT ID,PrevQuestID FROM quest_template_addon"):
    prev[int(qid)] = int(pv)
def closure(qid):
    R, x, seen = set(), prev.get(qid, 0), set()
    while x > 0 and x not in seen:
        seen.add(x); R.add(x); x = prev.get(x, 0)
    return R

def holds(c, R, taken, complete):
    t, v1, v2, neg = c
    if t == 8: r = v1 in R
    elif t == 9: r = v1 in taken
    elif t == 28: r = v1 in complete
    elif t == 14: r = v1 not in R and v1 not in taken
    elif t == 48: r = obj_quest.get(v1) in complete
    elif t == 47:
        st = 6 if v1 in R else (1 if v1 in complete else (3 if v1 in taken else 0))
        r = bool(v2 & (1 << st))
    else: r = True
    return r != bool(neg)

def player_phases(area, R, taken, complete):
    ph, a, seen = set(), area, set()
    while a and a not in seen:
        seen.add(a)
        for p in pa.get(a, ()):
            cs = conds.get((p, a))
            if not cs or any(all(holds(c, R, taken, complete) for c in grp) for grp in cs.values()):
                ph.add(p)
        a = parent.get(a, 0)
    return ph

spawns = collections.defaultdict(list)
for i, area, pid, pg in q(DB, "SELECT id,areaId,PhaseId,PhaseGroup FROM creature"):
    s = {int(pid)} if int(pid) else (groups.get(int(pg), set()) if int(pg) else set())
    spawns[int(i)].append((int(area), s))

def visible(npc, R, taken, complete):
    for area, s in spawns.get(npc, ()):
        if not s or s & player_phases(area, R, taken, complete):
            return True
    return False

quests = {int(r[0]): r[1] for r in q(DB, "SELECT ID,LogTitle FROM quest_template WHERE QuestSortID=%d" % ZONE)}
starters = collections.defaultdict(set); enders = collections.defaultdict(set)
for i, qq in q(DB, "SELECT id,quest FROM creature_queststarter"):
    starters[int(qq)].add(int(i))
for i, qq in q(DB, "SELECT id,quest FROM creature_questender"):
    enders[int(qq)].add(int(i))
bad = []
for qid, title in sorted(quests.items()):
    R = closure(qid)
    if starters[qid] and not any(visible(n, R, set(), set()) for n in starters[qid]):
        bad.append("DONNEUR invisible  %6d %-40s donneurs %s" % (qid, title[:40], sorted(starters[qid])))
    if enders[qid] and not any(visible(n, R, {qid}, {qid}) for n in enders[qid]):
        bad.append("RECEVEUR invisible %6d %-40s receveurs %s" % (qid, title[:40], sorted(enders[qid])))
print("%d quetes de la zone, %d problemes" % (len(quests), len(bad)))
print("\n".join(bad))
