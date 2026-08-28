# -*- coding: utf-8 -*-
"""Compare la faction de reference et la notre pour les creatures
placees sur la carte 1460. N'ecrit rien : rapport seul."""
import io, re, subprocess

DUMP = '/home/ubuntu/tmp/abs/LegionCore_world_2020_04_25.sql'


def decoupe_tuples(bloc):
    res, cur, prof, chaine, echap = [], [], 0, False, False
    for c in bloc:
        if chaine:
            cur.append(c)
            if echap: echap = False
            elif c == '\\': echap = True
            elif c == "'": chaine = False
            continue
        if c == "'":
            chaine = True; cur.append(c)
        elif c == '(':
            prof += 1
            cur = [] if prof == 1 else cur + [c]
        elif c == ')':
            prof -= 1
            if prof == 0: res.append(''.join(cur))
            else: cur.append(c)
        elif prof > 0:
            cur.append(c)
    return res


def champs(t):
    vals, cur, chaine, echap = [], [], False, False
    for c in t:
        if chaine:
            cur.append(c)
            if echap: echap = False
            elif c == '\\': echap = True
            elif c == "'": chaine = False
            continue
        if c == "'":
            chaine = True; cur.append(c)
        elif c == ',':
            vals.append(''.join(cur).strip()); cur = []
        else:
            cur.append(c)
    vals.append(''.join(cur).strip())
    return vals


# entrees reellement placees chez nous sur la carte 1460, avec notre faction
sortie = subprocess.check_output(
    ['sudo', 'mysql', 'dc_world', '-N', '-e',
     "SELECT DISTINCT c.id, ct.faction, ct.name FROM creature c "
     "JOIN creature_template ct ON ct.entry=c.id WHERE c.map=1460;"])
notre = {}
for ligne in sortie.decode('utf-8', 'replace').splitlines():
    p = ligne.split('\t')
    if len(p) >= 3:
        notre[int(p[0])] = (int(p[1]), p[2])
print('entrees placees sur la carte 1460 : %d' % len(notre))

# faction cote reference
motif = re.compile(r"insert\s+into\s+`creature_template`\(([^)]*)\)\s+values\s*", re.I)
ref = {}
with io.open(DUMP, encoding='utf-8', errors='replace') as f:
    l = f.readline()
    while l:
        m = motif.match(l.lstrip())
        if m:
            cols = [c.strip().strip('`') for c in m.group(1).split(',')]
            b = [l[l.lower().find('values') + 6:]]
            while not b[-1].rstrip().endswith(';'):
                s = f.readline()
                if not s: break
                b.append(s)
            if 'entry' in cols and 'faction' in cols:
                ie, ifa = cols.index('entry'), cols.index('faction')
                for t in decoupe_tuples(''.join(b)):
                    v = champs(t)
                    if len(v) == len(cols):
                        try:
                            e = int(v[ie])
                        except ValueError:
                            continue
                        if e in notre:
                            ref[e] = int(v[ifa])
        l = f.readline()

print('trouvees dans la reference : %d' % len(ref))
divergentes = {e: (notre[e][0], ref[e], notre[e][1]) for e in ref if ref[e] != notre[e][0]}
print('FACTIONS DIVERGENTES : %d' % len(divergentes))
print()
from collections import Counter
c = Counter((n, r) for n, r, _ in divergentes.values())
print('  notre -> reference   nombre')
for (n, r), k in c.most_common(12):
    print('  %5d -> %-8d      %d' % (n, r, k))
print()
print('  exemples :')
for e in list(divergentes)[:12]:
    n, r, nom = divergentes[e]
    print('    %-8d %-30s %d -> %d' % (e, nom[:30], n, r))
