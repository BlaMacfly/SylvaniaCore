# -*- coding: utf-8 -*-
"""Genere les corrections de faction pour les creatures de la carte 1460.

PRUDENCE : creature_template.faction agit PARTOUT, pas seulement sur la
carte visee. On exclut donc toute entree qui possede un spawn sur une
autre carte -- en pratique des declencheurs invisibles, pour lesquels la
faction 35 est correcte et ne doit surtout pas etre touchee.
"""
import io, re, subprocess

DUMP = '/home/ubuntu/tmp/abs/LegionCore_world_2020_04_25.sql'
SORTIE = '/home/ubuntu/DestinyCore/sql/sylvania/rivage_factions_1460.sql'


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


def sql(q):
    return subprocess.check_output(['sudo', 'mysql', 'dc_world', '-N', '-e', q]).decode('utf-8', 'replace')


# entrees exclusivement presentes sur la carte 1460
lignes = sql("SELECT c.id, ct.faction, ct.name FROM creature c "
             "JOIN creature_template ct ON ct.entry=c.id WHERE c.map=1460 "
             "AND c.id NOT IN (SELECT DISTINCT id FROM creature WHERE map<>1460) "
             "GROUP BY c.id, ct.faction, ct.name;")
notre = {}
for l in lignes.splitlines():
    p = l.split('\t')
    if len(p) >= 3:
        notre[int(p[0])] = (int(p[1]), p[2])

exclues = sql("SELECT COUNT(DISTINCT id) FROM creature WHERE map=1460 "
              "AND id IN (SELECT DISTINCT id FROM creature WHERE map<>1460);").strip()
print('entrees exclusives a la carte 1460 : %d (exclues car partagees : %s)' % (len(notre), exclues))

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

corr = {e: (notre[e][0], ref[e], notre[e][1]) for e in ref if ref[e] != notre[e][0]}
print('a corriger : %d' % len(corr))

L = []
L.append("-- =====================================================================")
L.append("-- Rivage brise (carte 1460) -- CORRECTION DES FACTIONS")
L.append("--")
L.append("-- Signale en jeu, capture a l'appui : « ce sont bien des ennemis mais")
L.append("-- flagues en allie » -- les demons portaient une plaque de nom verte.")
L.append("--")
L.append("-- Notre creature_template porte la faction 35 (amicale envers tous)")
L.append("-- comme valeur par defaut pour ces PNJ de Legion : sur les 156 entrees")
L.append("-- placees, 135 divergeaient de la reference. Ce trou est ANTERIEUR a")
L.append("-- l'import des placements, qui ne touche pas creature_template.")
L.append("--")
L.append("-- Valeurs reprises de creature_template du dump de reference")
L.append("-- (dufernst/LegionCore-7.3.5, meme lignee uwow).")
L.append("--")
L.append("-- PRUDENCE : creature_template.faction agit PARTOUT. Les entrees")
L.append("-- possedant un spawn hors de la carte 1460 sont donc EXCLUES -- ce")
L.append("-- sont des declencheurs invisibles (General Purpose Bunny) pour")
L.append("-- lesquels la faction 35 est correcte et ne doit pas etre touchee.")
L.append("--")
L.append("-- Portee : %d entrees corrigees, exclusives a la carte 1460." % len(corr))
L.append("-- =====================================================================")
L.append("")

from collections import Counter
c = Counter((n, r) for n, r, _ in corr.values())
for (n, r), k in c.most_common():
    L.append("-- %5d -> %-6d  (%d creatures)" % (n, r, k))
L.append("")

for e in sorted(corr):
    n, r, nom = corr[e]
    L.append("UPDATE `creature_template` SET `faction`=%d WHERE `entry`=%d; -- %s (etait %d)"
             % (r, e, nom.replace('--', '-').strip("'")[:40], n))

io.open(SORTIE, 'w', encoding='utf-8').write('\n'.join(L) + '\n')
print('ecrit : %s' % SORTIE)
