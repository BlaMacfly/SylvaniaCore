# -*- coding: utf-8 -*-
"""Extraction carte 1666 — version corrigee : une instruction INSERT
s'etale sur plusieurs lignes, on accumule jusqu'au point-virgule final."""
import io, re
from collections import Counter

CHEMIN = '/home/ubuntu/tmp/abs/LegionCore_world_2020_04_25.sql'
motif = re.compile(r"insert\s+into\s+`(creature|gameobject)`\(([^)]*)\)\s+values\s*", re.I)


def decoupe_tuples(bloc):
    tuples, courant, prof, chaine, echap = [], [], 0, False, False
    for c in bloc:
        if chaine:
            courant.append(c)
            if echap:
                echap = False
            elif c == '\\':
                echap = True
            elif c == "'":
                chaine = False
            continue
        if c == "'":
            chaine = True
            courant.append(c)
        elif c == '(':
            prof += 1
            if prof == 1:
                courant = []
            else:
                courant.append(c)
        elif c == ')':
            prof -= 1
            if prof == 0:
                tuples.append(''.join(courant))
            else:
                courant.append(c)
        elif prof > 0:
            courant.append(c)
    return tuples


def champs(t):
    vals, courant, chaine, echap = [], [], False, False
    for c in t:
        if chaine:
            courant.append(c)
            if echap:
                echap = False
            elif c == '\\':
                echap = True
            elif c == "'":
                chaine = False
            continue
        if c == "'":
            chaine = True
            courant.append(c)
        elif c == ',':
            vals.append(''.join(courant).strip())
            courant = []
        else:
            courant.append(c)
    vals.append(''.join(courant).strip())
    return vals


stats = {}

with io.open(CHEMIN, encoding='utf-8', errors='replace') as f:
    ligne = f.readline()
    while ligne:
        m = motif.match(ligne.lstrip())
        if not m:
            ligne = f.readline()
            continue

        table = m.group(1).lower()
        cols = [c.strip().strip('`') for c in m.group(2).split(',')]

        # accumuler jusqu'au ';' final
        morceaux = [ligne[ligne.lower().find('values') + 6:]]
        while not morceaux[-1].rstrip().endswith(';'):
            suite = f.readline()
            if not suite:
                break
            morceaux.append(suite)
        bloc = ''.join(morceaux)

        i_map = cols.index('map')
        i_id = cols.index('id')

        s = stats.setdefault(table, {'cols': cols, 'total': 0, 'cartes': Counter(), 'l1666': []})
        for t in decoupe_tuples(bloc):
            v = champs(t)
            if len(v) != len(cols):
                continue
            s['total'] += 1
            s['cartes'][v[i_map]] += 1
            if v[i_map] == '1666':
                s['l1666'].append(v)

        ligne = f.readline()

for table, s in stats.items():
    print('=== %s ===' % table)
    print('  tuples analyses : %d' % s['total'])
    print('  cartes les plus peuplees : %s' % ', '.join('%s(%d)' % c for c in s['cartes'].most_common(6)))
    print('  >>> CARTE 1666 : %d lignes' % len(s['l1666']))
    if s['l1666']:
        i_id = s['cols'].index('id')
        c = Counter(l[i_id] for l in s['l1666'])
        print('      %d entrees distinctes ; top 15 :' % len(c))
        for e, n in c.most_common():
            print('        entree %-8s x%d' % (e, n))
    print()
