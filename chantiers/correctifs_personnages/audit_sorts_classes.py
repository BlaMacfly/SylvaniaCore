"""Sorts appris par un personnage alors qu'ils appartiennent a d'autres classes.

Classes legitimes d'un sort = union de ses sources dans les DB2 :
  SpecializationSpells (spe -> classe, hors specialisations de familier), maitrises de spe,
  Talent (ClassID), SkillLineAbility (ClassMask, sinon classes de la competence d'apres
  SkillRaceClassInfo). Une seule source ouverte a toutes les classes rend le sort generique.
"""
import subprocess
import sys
from collections import defaultdict

sys.path.insert(0, '/home/ubuntu')
from db2read import DB2

D = '/home/ubuntu/server/data/dbc/enUS/'
ALL = None  # marqueur « toutes classes »


def parents(db):
    rev = {}
    for pid, idxs in db.parentMap.items():
        for i in idxs:
            rev[i] = pid
    return rev


allowed = defaultdict(set)
generic = set()

spec = DB2(D + 'ChrSpecialization.db2', 'sssibbbbbiiii', [1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1], 9, 4)
spec_class = {}
rev = parents(spec)
for r in range(spec.recCount):
    sid, cls = spec.getId(r), rev.get(r, 0)
    spec_class[sid] = cls
    if cls:
        for k in range(2):
            m = spec.getRaw(r, 3, k, 'i')
            if m:
                allowed[m].add(cls)

ss = DB2(D + 'SpecializationSpells.db2', 'siihbi', [1] * 6, 5, 3)
rev = parents(ss)
for r in range(ss.recCount):
    cls = spec_class.get(rev.get(r), 0)
    if cls:
        allowed[ss.getRaw(r, 1, 0, 'i')].add(cls)

tal = DB2(D + 'Talent.db2', 'siihbbbbb', [1, 1, 1, 1, 1, 1, 1, 2, 1], -1, -1)
for r in range(tal.recCount):
    cls, sp = tal.getRaw(r, 8, 0, 'b'), tal.getRaw(r, 1, 0, 'i')
    if cls and sp:
        allowed[sp].add(cls)

srci = DB2(D + 'SkillRaceClassInfo.db2', 'lhhhbbi', [1] * 7, -1, 1)
rev = parents(srci)
skill_classes = defaultdict(set)
for r in range(srci.recCount):
    skill, mask = rev.get(r), srci.getRaw(r, 6, 0, 'i') & 0xFFFFFFFF
    if skill is None:
        continue
    if mask in (0, 0xFFFFFFFF):
        skill_classes[skill].add(ALL)
    else:
        for c in range(1, 13):
            if mask & (1 << (c - 1)):
                skill_classes[skill].add(c)

sla = DB2(D + 'SkillLineAbility.db2', 'liiihhhhhbihbb', [1] * 14, 1, 4)
rev = parents(sla)
for r in range(sla.recCount):
    sp, mask, skill = sla.getRaw(r, 2, 0, 'i'), sla.getRaw(r, 10, 0, 'i') & 0xFFFFFFFF, rev.get(r)
    if mask:
        for c in range(1, 13):
            if mask & (1 << (c - 1)):
                allowed[sp].add(c)
    else:
        classes = skill_classes.get(skill, {ALL})
        if ALL in classes:
            generic.add(sp)
        else:
            allowed[sp] |= classes

bound = {sp: cls for sp, cls in allowed.items() if sp not in generic}

out = subprocess.run(['mysql', '-N', 'dc_characters', '-e',
                      'SELECT c.guid, c.name, c.class, c.level, c.account, s.spell FROM character_spell s '
                      'JOIN characters c ON c.guid = s.guid'], capture_output=True, text=True).stdout
fautes = defaultdict(list)
infos = {}
for line in out.splitlines():
    guid, name, cls, lvl, acc, sp = line.split('\t')
    cls, sp = int(cls), int(sp)
    if sp in bound and cls not in bound[sp]:
        fautes[int(guid)].append(sp)
        infos[int(guid)] = (name, cls, lvl, acc)

par_sort = defaultdict(int)
for g, sps in fautes.items():
    for sp in sps:
        par_sort[sp] += 1

print('sorts lies a des classes :', len(bound), '- personnages en faute :', len(fautes))
for g in sorted(fautes, key=lambda x: -len(fautes[x])):
    name, cls, lvl, acc = infos[g]
    print(f'guid {g} {name} classe {cls} niv {lvl} compte {acc} : {len(fautes[g])} -> {sorted(fautes[g])[:30]}')
print('sorts les plus frequents :', sorted(par_sort.items(), key=lambda x: -x[1])[:25])
print('classes legitimes de ces sorts :', {sp: sorted(bound[sp]) for sp, _ in sorted(par_sort.items(), key=lambda x: -x[1])[:25]})
