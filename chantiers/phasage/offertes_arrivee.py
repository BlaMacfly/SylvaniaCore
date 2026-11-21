import sys
# Usage : offertes_arrivee.py <db> <zone> [hotfixes_supplementaires.sql]
DBX = sys.argv[1]
sys.argv = ["x"] + sys.argv[1:]
src = open("/home/ubuntu/tmp/verif_phasage.py").read().split("bad = []")[0]
g = {}; exec(src, g)
n = 0
for qid in g["quests"]:
    if g["prev"].get(qid, 0) > 0: continue
    if g["starters"][qid] and any(g["visible"](s, set(), set(), set()) for s in g["starters"][qid]): n += 1
print(DBX, ": quetes prenables en arrivant :", n, "sur", len(g["quests"]))
