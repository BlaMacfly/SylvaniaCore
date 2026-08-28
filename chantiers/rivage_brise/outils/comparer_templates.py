# -*- coding: utf-8 -*-
"""Compare NOS creature_template avec ceux de la reference, pour les
entrees exclusives a la carte 1460. Rapport seul, n'ecrit rien."""
import io, re, subprocess
from collections import Counter

DUMP = '/home/ubuntu/tmp/abs/LegionCore_world_2020_04_25.sql'

# colonnes qui pesent sur la jouabilite, et presentes dans les deux schemas
CANDIDATES = ['minlevel','maxlevel','faction','npcflag','speed_walk','speed_run','scale','rank',
              'BaseAttackTime','RangeAttackTime','unit_class','unit_flags','unit_flags2',
              'dynamicflags','family','type','type_flags','HealthModifier','ManaModifier',
              'ArmorModifier','DamageModifier','ExperienceModifier','RegenHealth',
              'mechanic_immune_mask','flags_extra','MovementType','AIName','lootid']


def dec(b):
    r, c, p, s, e = [], [], 0, False, False
    for ch in b:
        if s:
            c.append(ch)
            if e: e = False
            elif ch == '\\': e = True
            elif ch == "'": s = False
            continue
        if ch == "'": s = True; c.append(ch)
        elif ch == '(':
            p += 1; c = [] if p == 1 else c + [ch]
        elif ch == ')':
            p -= 1
            if p == 0: r.append(''.join(c))
            else: c.append(ch)
        elif p > 0: c.append(ch)
    return r


def ch_(t):
    v, c, s, e = [], [], False, False
    for x in t:
        if s:
            c.append(x)
            if e: e = False
            elif x == '\\': e = True
            elif x == "'": s = False
            continue
        if x == "'": s = True; c.append(x)
        elif x == ',': v.append(''.join(c).strip()); c = []
        else: c.append(x)
    v.append(''.join(c).strip()); return v


nos_cols = subprocess.check_output(
    ['sudo', 'mysql', 'dc_world', '-N', '-e', 'SHOW COLUMNS FROM creature_template;']
).decode('utf-8', 'replace')
nos_cols = [l.split('\t')[0] for l in nos_cols.splitlines() if l.strip()]

communes = [c for c in CANDIDATES if c in nos_cols]
print('colonnes comparees : %d' % len(communes))

q = ("SELECT ct.entry," + ','.join('ct.`%s`' % c for c in communes) +
     " FROM creature_template ct WHERE ct.entry IN (SELECT DISTINCT c.id FROM creature c "
     "WHERE c.map=1460 AND c.id NOT IN (SELECT DISTINCT id FROM creature WHERE map<>1460));")
brut = subprocess.check_output(['sudo', 'mysql', 'dc_world', '-N', '-e', q]).decode('utf-8', 'replace')
notre = {}
for l in brut.splitlines():
    p = l.split('\t')
    if len(p) == len(communes) + 1:
        notre[int(p[0])] = dict(zip(communes, p[1:]))
print('entrees exclusives a la carte 1460 : %d' % len(notre))

mot = re.compile(r"insert\s+into\s+`creature_template`\(([^)]*)\)\s+values\s*", re.I)
ref = {}
with io.open(DUMP, encoding='utf-8', errors='replace') as f:
    l = f.readline()
    while l:
        m = mot.match(l.lstrip())
        if m:
            cols = [c.strip().strip('`') for c in m.group(1).split(',')]
            b = [l[l.lower().find('values') + 6:]]
            while not b[-1].rstrip().endswith(';'):
                s = f.readline()
                if not s: break
                b.append(s)
            ie = cols.index('entry')
            for t in dec(''.join(b)):
                v = ch_(t)
                if len(v) != len(cols): continue
                try: e = int(v[ie])
                except ValueError: continue
                if e in notre:
                    ref[e] = {c: v[cols.index(c)] for c in communes if c in cols}
        l = f.readline()

print('retrouvees dans la reference : %d' % len(ref))
print()
print('  colonne                divergentes / comparees')
divergences = Counter()
for e in ref:
    for c in communes:
        if c not in ref[e]: continue
        a = notre[e][c].strip()
        b = ref[e][c].strip().strip("'")
        try:
            egal = abs(float(a) - float(b)) < 1e-6
        except ValueError:
            egal = (a == b)
        if not egal:
            divergences[c] += 1
for c in communes:
    if divergences[c]:
        print('  %-22s %4d / %d' % (c, divergences[c], len(ref)))
