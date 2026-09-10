import sys, subprocess, collections
sys.path.insert(0, '/home/ubuntu')
from db2read import DB2
D = '/home/ubuntu/server/data/dbc/enUS/'
ji  = DB2(D+'JournalInstance.db2',         "ssiiiihhbbi", [1]*11,                  10, -1)
je  = DB2(D+'JournalEncounter.db2',        "ssfhhhhbbii", [1,1,2,1,1,1,1,1,1,1,1], -1, -1)
jei = DB2(D+'JournalEncounterItem.db2',    "ihbbbi",      [1]*6,                    5,  1)
instMap = {ji.getId(i): ji.getRaw(i,6,0,"h") for i in range(ji.recCount)}
enc = {}
for i in range(je.recCount):
    enc[je.getId(i)] = (instMap.get(je.getRaw(i,6,0,"h"),0), je.getRaw(i,9,0,"i"))
rows = subprocess.run(['mysql','-N','-B','dc_world','-e',
  "SELECT j.entry, j.JournalEncounterID, ct.name FROM creature_template_journal j "
  "JOIN creature_template ct ON ct.entry=j.entry WHERE j.entry>70000"],
  capture_output=True, text=True).stdout
print("entry\tenc\tcarte\tordre\tnbObjets\tnom")
bad=0
for line in rows.splitlines():
    e, eid, name = line.split('\t'); eid=int(eid)
    mid, oi = enc.get(eid, (0,0))
    n = len(jei.parentMap.get(eid, []))
    flag = "" if (mid and n) else "  <<< PROBLEME"
    if flag: bad+=1
    print("%s\t%d\t%d\t%d\t%d\t%s%s" % (e, eid, mid, oi, n, name, flag))
print("problemes:", bad)
