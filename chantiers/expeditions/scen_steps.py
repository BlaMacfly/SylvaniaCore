import sys, wdc1, collections
D="/home/ubuntu/server/data/dbc/enUS/"
def load(n):
    f=wdc1.WDC1(D+n); return {rid:vals for rid,vals in f.rows()}
st=load("ScenarioStep.db2"); ct=load("CriteriaTree.db2"); cr=load("Criteria.db2")
kids=collections.defaultdict(list)
for i,v in ct.items(): kids[v[5]].append(i)
def show(tid,ind):
    v=ct[tid]; line="  "*ind+f"tree {tid} amount={v[1]} op={v[3]}"
    if v[4]:
        c=cr.get(v[4]); line+=f" criteria {v[4]} type={c[6]} asset={c[0]}" if c else f" criteria {v[4]} ?"
    print(line)
    for k in sorted(kids[tid], key=lambda k: ct[k][6]): show(k,ind+1)
for sc in map(int,sys.argv[1:]):
    print("== scenario",sc)
    for sid,v in sorted(((i,v) for i,v in st.items() if v[2]==sc), key=lambda x:x[1][5]):
        print(f"step {sid} order={v[5]} flags={v[6]} rewardQuest={v[4]} tree={v[7]}")
        show(v[7],1)
