#!/usr/bin/env python3
# Genere le SQL des restrictions de classe et de metier manquantes (LC, TDB 7.3.5 prioritaire).
import subprocess
def q(sql):
    out = subprocess.run(['mysql', '-N', '-B', '-e', sql], capture_output=True, text=True, check=True).stdout
    return [l.split('\t') for l in out.splitlines() if l]

classes = {}
# TDB 7.3.5 : classe non nulle, la notre nulle ou differente
for i, t, d in q("""SELECT t.ID, t.AllowableClasses, IFNULL(a.AllowableClasses,0) FROM tdb735_ref.quest_template_addon t
    JOIN dc_world.quest_template q ON q.ID=t.ID LEFT JOIN dc_world.quest_template_addon a ON a.ID=t.ID
    WHERE t.AllowableClasses<>0 AND IFNULL(a.AllowableClasses,0)=0"""):
    classes[int(i)] = (int(t), int(d), 'TDB')
# LC : seulement si la TDB n'a pas de ligne pour la quete
for i, l, d in q("""SELECT l.ID, l.AllowableClasses, IFNULL(a.AllowableClasses,0) FROM lc_world_ref.quest_template_addon l
    JOIN dc_world.quest_template q ON q.ID=l.ID LEFT JOIN dc_world.quest_template_addon a ON a.ID=l.ID
    LEFT JOIN tdb735_ref.quest_template_addon t ON t.ID=l.ID
    WHERE l.AllowableClasses<>0 AND IFNULL(a.AllowableClasses,0)=0 AND t.ID IS NULL"""):
    classes.setdefault(int(i), (int(l), int(d), 'LC'))

skills = {}
for i, s, p in q("""SELECT l.ID, l.RequiredSkillID, l.RequiredSkillPoints FROM lc_world_ref.quest_template_addon l
    JOIN dc_world.quest_template q ON q.ID=l.ID LEFT JOIN dc_world.quest_template_addon a ON a.ID=l.ID
    LEFT JOIN tdb735_ref.quest_template_addon t ON t.ID=l.ID
    WHERE l.RequiredSkillID<>0 AND IFNULL(a.RequiredSkillID,0)=0 AND IFNULL(t.RequiredSkillID,0)=0"""):
    skills[int(i)] = (int(s), max(int(p), 1))
for i, s, p in q("""SELECT t.ID, t.RequiredSkillID, t.RequiredSkillPoints FROM tdb735_ref.quest_template_addon t
    JOIN dc_world.quest_template q ON q.ID=t.ID LEFT JOIN dc_world.quest_template_addon a ON a.ID=t.ID
    WHERE t.RequiredSkillID<>0 AND IFNULL(a.RequiredSkillID,0)=0"""):
    skills[int(i)] = (int(s), max(int(p), 1))

print("-- Restrictions de classe et de metier absentes de quest_template_addon.")
print("-- Classe : TDB 7.3.5 si elle a une ligne pour la quete, sinon LegionCore ; metier : LegionCore (la TDB n'a pas ces quetes) et TDB.")
print("-- Sans elles, les quetes d'appel des domaines de classe (Dalaran) et les quetes de metier de Legion etaient proposees a tous.")
print("-- %d classes, %d metiers." % (len(classes), len(skills)))
print()
for i in sorted(classes):
    v, old, src = classes[i]
    print("INSERT INTO `quest_template_addon` (`ID`,`AllowableClasses`) VALUES (%d,%d) ON DUPLICATE KEY UPDATE `AllowableClasses`=VALUES(`AllowableClasses`); -- %s, avant %d" % (i, v, src, old))
print()
for i in sorted(skills):
    s, p = skills[i]
    print("INSERT INTO `quest_template_addon` (`ID`,`RequiredSkillID`,`RequiredSkillPoints`) VALUES (%d,%d,%d) ON DUPLICATE KEY UPDATE `RequiredSkillID`=VALUES(`RequiredSkillID`),`RequiredSkillPoints`=VALUES(`RequiredSkillPoints`);" % (i, s, p))
