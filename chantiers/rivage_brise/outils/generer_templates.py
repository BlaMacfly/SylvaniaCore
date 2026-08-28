# -*- coding: utf-8 -*-
"""Transpose les colonnes de jouabilite des creature_template de la
carte 1460 depuis la reference. Produit le SQL et son retour arriere."""
import io, re, subprocess

DUMP = '/home/ubuntu/tmp/abs/LegionCore_world_2020_04_25.sql'
SORTIE = '/home/ubuntu/DestinyCore/sql/sylvania/rivage_templates_1460.sql'
RETOUR = '/home/ubuntu/DestinyCore/chantiers/rivage_brise/retour_templates_1460.sql'

# EXCLUS volontairement :
#   AIName      -- pourrait defaire un comportement pose sciemment chez nous
#   flags_extra -- porte des drapeaux que le coeur calcule lui-meme
#                  (CREATURE_FLAG_EXTRA_DUNGEON_BOSS est pose au chargement)
COLONNES = ['minlevel','maxlevel','unit_class','unit_flags','unit_flags2','npcflag',
            'speed_walk','speed_run','mechanic_immune_mask','RegenHealth']


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


q = ("SELECT ct.entry,ct.name," + ','.join('ct.`%s`' % c for c in COLONNES) +
     " FROM creature_template ct WHERE ct.entry IN (SELECT DISTINCT c.id FROM creature c "
     "WHERE c.map=1460 AND c.id NOT IN (SELECT DISTINCT id FROM creature WHERE map<>1460));")
brut = subprocess.check_output(['sudo', 'mysql', 'dc_world', '-N', '-e', q]).decode('utf-8', 'replace')
notre = {}
for l in brut.splitlines():
    p = l.split('\t')
    if len(p) == len(COLONNES) + 2:
        notre[int(p[0])] = (p[1], dict(zip(COLONNES, p[2:])))
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
                    ref[e] = {c: v[cols.index(c)].strip("'") for c in COLONNES if c in cols}
        l = f.readline()

maj, rb, touchees = [], [], 0
for e in sorted(ref):
    nom, nos = notre[e]
    diff = {}
    for c in COLONNES:
        if c not in ref[e]: continue
        a, b = nos[c].strip(), ref[e][c].strip()
        try:
            egal = abs(float(a) - float(b)) < 1e-6
        except ValueError:
            egal = (a == b)
        if not egal:
            diff[c] = b
    if not diff:
        continue
    touchees += 1
    maj.append("UPDATE `creature_template` SET %s WHERE `entry`=%d; -- %s"
               % (', '.join('`%s`=%s' % (c, v) for c, v in sorted(diff.items())), e, nom[:38]))
    rb.append("UPDATE `creature_template` SET %s WHERE `entry`=%d;"
              % (', '.join('`%s`=%s' % (c, nos[c]) for c in sorted(diff)), e))

print('entrees a corriger : %d' % touchees)

L = ["-- =====================================================================",
     "-- Rivage brise (carte 1460) -- MODELES DE CREATURES incomplets",
     "--",
     "-- Signale en jeu : « exemple lui n'est pas attaquable », capture d'un",
     "-- .npc info montrant Felguard Legionnaire (109591) en Level: 1.",
     "--",
     "-- Nos creature_template de l'epoque Legion sont des SOUCHES : sur les",
     "-- 152 entrees exclusives a cette carte, 141 sont au niveau 1. La",
     "-- faction, corrigee au tour precedent, n'etait que la partie visible.",
     "--",
     "-- Divergences relevees face au dump de reference :",
     "--   minlevel  150/152     unit_flags2  147/152",
     "--   maxlevel  145/152     unit_flags   136/152",
     "--   unit_class 62/152     speed_run     55/152",
     "--",
     "-- EXCLUS VOLONTAIREMENT du correctif :",
     "--   AIName      -- 32 divergences, mais transposer pourrait defaire un",
     "--                  comportement pose sciemment chez nous.",
     "--   flags_extra -- porte des drapeaux que le coeur calcule lui-meme,",
     "--                  dont CREATURE_FLAG_EXTRA_DUNGEON_BOSS, pose au",
     "--                  chargement depuis instance_encounters.",
     "--",
     "-- PORTEE : %d entrees, toutes exclusives a la carte 1460. Les entrees" % touchees,
     "-- possedant un spawn ailleurs sont ecartees -- ce sont des declencheurs",
     "-- invisibles pour lesquels les valeurs actuelles sont correctes.",
     "--",
     "-- Retour arriere : chantiers/rivage_brise/retour_templates_1460.sql",
     "-- =====================================================================",
     ""]
io.open(SORTIE, 'w', encoding='utf-8').write('\n'.join(L + maj) + '\n')
io.open(RETOUR, 'w', encoding='utf-8').write(
    '-- Retour arriere des modeles de la carte 1460, valeurs d avant correction.\n'
    + '\n'.join(rb) + '\n')
print('ecrit : %s' % SORTIE)
print('retour : %s' % RETOUR)
