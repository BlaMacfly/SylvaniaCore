import sys
sys.path.insert(0,'/home/ubuntu')
from db2read import DB2
types='iiiiiififfiiiiffififfffffiiiii'
arr=[1]*25+[4,2,2,2,1]
d=DB2('/home/ubuntu/server/data/dbc/enUS/SpellEffect.db2',types,arr,0,29)
F_AURA=4; F_MISC=26; F_SPELL=29; F_EFFECT=1
res={18:{},19:{}}
rev={}
for pid,idxs in d.parentMap.items():
    for i in idxs: rev[i]=pid
for r in range(d.recCount):
    if d.getRaw(r,F_EFFECT,0,'i')!=6: continue
    a=d.getRaw(r,F_AURA,0,'i')
    if a in (18,19):
        m=d.getRaw(r,F_MISC,0,'i'); s=rev.get(r,-1)
        res[a].setdefault(m,[]).append(s)
for t in sorted(set(res[18])|set(res[19])):
    print(t,'INVIS',sorted(res[18].get(t,[]))[:12],'DETECT',sorted(res[19].get(t,[]))[:12])
