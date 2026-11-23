#!/usr/bin/env python3
"""Phases actives d'un personnage dans une zone (et ses sous-zones), d'apres ses quetes en base.

Usage : phases_perso.py <guid> <zone>
Pour chaque aire de la zone : phases actives, drapeaux Phase.db2 (0x10 cosmetique), et alerte si une phase
non cosmetique est active (le joueur ne voit plus alors les PNJ sans phase).
"""
import collections, csv, subprocess, sys

GUID, ZONE = int(sys.argv[1]), int(sys.argv[2])

def q(db, sql):
    o = subprocess.run(["mysql", "-N", db, "-e", sql], capture_output=True, text=True, check=True).stdout
    return [l.split("\t") for l in o.split("\n") if l]

parent = {int(r["ID"]): int(r["ParentAreaID"]) for r in csv.DictReader(open("/home/ubuntu/tmp/AreaTable.csv"))}
pflags = {int(r["ID"]): int(r["Flags"]) for r in csv.DictReader(open("/home/ubuntu/tmp/Phase.csv"))}
pflags.update({int(a): int(b) for a, b in q("dc_hotfixes", "SELECT ID,Flags FROM phase")})

R = {int(x[0]) for x in q("dc_characters", "SELECT quest FROM character_queststatus_rewarded WHERE guid=%d" % GUID)}
st = {int(a): int(b) for a, b in q("dc_characters", "SELECT quest,status FROM character_queststatus WHERE guid=%d" % GUID)}
taken = set(st)
complete = {k for k, v in st.items() if v == 1}
obj_done = {(int(a), int(b)) for a, b, c in q("dc_characters", "SELECT quest,objective,data FROM character_queststatus_objectives WHERE guid=%d" % GUID) if int(c) > 0}
obj = {int(i): (int(qq), int(idx), int(amt)) for i, qq, idx, amt in q("dc_world", "SELECT ID,QuestID,StorageIndex,Amount FROM quest_objectives")}
objdata = {(int(a), int(b)): int(c) for a, b, c in q("dc_characters", "SELECT quest,objective,data FROM character_queststatus_objectives WHERE guid=%d" % GUID)}
auras = {int(x[0]) for x in q("dc_characters", "SELECT spell FROM character_aura WHERE guid=%d" % GUID)}

pa = collections.defaultdict(dict)
for a, p, c in q("dc_world", "SELECT AreaId,PhaseId,IFNULL(Comment,'') FROM phase_area"):
    pa[int(a)][int(p)] = c
conds = collections.defaultdict(lambda: collections.defaultdict(list))
for g, e, eg, t, v1, v2, v3, neg in q("dc_world", "SELECT SourceGroup,SourceEntry,ElseGroup,ConditionTypeOrReference,ConditionValue1,ConditionValue2,ConditionValue3,NegativeCondition FROM conditions WHERE SourceTypeOrReferenceId=26"):
    conds[(int(g), int(e))][int(eg)].append((int(t), int(v1), int(v2), int(neg)))

def holds(c):
    t, v1, v2, neg = c
    if t == 8: r = v1 in R
    elif t == 9: r = v1 in taken
    elif t == 28: r = v1 in complete
    elif t == 14: r = v1 not in R and v1 not in taken
    elif t == 1: r = v1 in auras
    elif t == 48:
        qq, idx, amt = obj.get(v1, (0, 0, 0))
        r = qq in R or qq in complete or objdata.get((qq, idx), 0) >= max(amt, 1)
    elif t == 47:
        s = 6 if v1 in R else (1 if v1 in complete else (3 if v1 in taken else 0))
        r = bool(v2 & (1 << s))
    else:
        return None
    return r != bool(neg)

areas = [a for a in parent if a == ZONE or parent.get(a) == ZONE or parent.get(parent.get(a)) == ZONE]
for area in sorted(areas):
    act, a, seen = [], area, set()
    while a and a not in seen:
        seen.add(a)
        for p, com in pa.get(a, {}).items():
            cs = conds.get((p, a))
            res = [all(holds(c) is not False for c in grp) for grp in cs.values()] if cs else [True]
            if any(res):
                unk = cs and any(holds(c) is None for grp in cs.values() for c in grp)
                act.append((p, a, com, unk))
        a = parent.get(a, 0)
    nc = [x for x in act if not pflags.get(x[0], 0) & 0x10]
    if area == ZONE or nc:
        print("== aire %d : %d phases actives%s" % (area, len(act), "  !!! NON COSMETIQUES : %s" % [x[0] for x in nc] if nc else ""))
        for p, a, com, unk in (act if area == ZONE else nc):
            print("   %5d (aire %d) drapeaux %s %s%s" % (p, a, hex(pflags.get(p, -1)), com[:70], " [condition non modelisee]" if unk else ""))
print("auras du personnage :", sorted(auras))
