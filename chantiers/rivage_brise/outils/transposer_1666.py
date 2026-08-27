# -*- coding: utf-8 -*-
"""Transpose les placements de la carte 1666 du dump de reference vers
NOTRE schema. Ne touche a rien : produit un rapport et un fichier SQL.

Les deux schemas divergent, la correspondance est donc explicite :

  reference                nous
  ---------                ----
  guid                     guid        (RENUMEROTE, voir plus bas)
  id, map, zoneId, areaId  identiques
  spawnMask                spawnDifficulties   (a decider, voir rapport)
  phaseMask                -- non transposable, on laisse les valeurs neutres
  PhaseId                  PhaseId
  modelid .. dynamicflags  identiques
  unit_flags3              unit_flags3
  npcflag2, AiID,          -- ABANDONNES : ces colonnes n'existent pas chez
  MovementID, MeleeID,        nous. AiID et MovementID renvoient a des tables
  isActive, skipClone,        propres a ce coeur ; les abandonner fait perdre
  personal_size,              une part du comportement, a recreer autrement.
  isTeemingSpawn

Les GUID sont renumerotes au-dessus de nos maxima (creature 290000114,
gameobject 210120986) pour ne heurter aucun spawn existant.
"""
import io, re, sys
from collections import Counter

CHEMIN = '/home/ubuntu/tmp/abs/LegionCore_world_2020_04_25.sql'
SORTIE = '/home/ubuntu/tmp/abs/rivage_brise_spawns.sql'

GUID_CREATURE_DEPART = 290100000
GUID_GO_DEPART = 210200000

# colonnes de NOTRE schema
NOS_CREATURE = ['guid','id','map','zoneId','areaId','spawnDifficulties','phaseUseFlags','PhaseId',
                'PhaseGroup','terrainSwapMap','modelid','equipment_id','position_x','position_y',
                'position_z','orientation','spawntimesecs','spawndist','currentwaypoint','curhealth',
                'curmana','MovementType','npcflag','unit_flags','unit_flags2','unit_flags3',
                'dynamicflags','ScriptName','movementmode','VerifiedBuild']

NOS_GO = ['guid','id','map','zoneId','areaId','spawnDifficulties','phaseUseFlags','PhaseId',
          'PhaseGroup','terrainSwapMap','position_x','position_y','position_z','orientation',
          'rotation0','rotation1','rotation2','rotation3','spawntimesecs','animprogress','state',
          'isActive','ScriptName','VerifiedBuild']


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
            if prof == 1: cur = []
            else: cur.append(c)
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


motif = re.compile(r"insert\s+into\s+`(creature|gameobject)`\(([^)]*)\)\s+values\s*", re.I)
recolte = {'creature': {'cols': None, 'lignes': []}, 'gameobject': {'cols': None, 'lignes': []}}

with io.open(CHEMIN, encoding='utf-8', errors='replace') as f:
    ligne = f.readline()
    while ligne:
        m = motif.match(ligne.lstrip())
        if not m:
            ligne = f.readline(); continue
        table = m.group(1).lower()
        cols = [c.strip().strip('`') for c in m.group(2).split(',')]
        morceaux = [ligne[ligne.lower().find('values') + 6:]]
        while not morceaux[-1].rstrip().endswith(';'):
            s = f.readline()
            if not s: break
            morceaux.append(s)
        i_map = cols.index('map')
        recolte[table]['cols'] = cols
        for t in decoupe_tuples(''.join(morceaux)):
            v = champs(t)
            if len(v) == len(cols) and v[i_map] == '1666':
                recolte[table]['lignes'].append(v)
        ligne = f.readline()

# ------------------------------------------------------------------
# RAPPORT : ce que je ne peux pas transposer mecaniquement
# ------------------------------------------------------------------
print('================= RAPPORT DE TRANSPOSITION =================')
for table in ('creature', 'gameobject'):
    r = recolte[table]
    print('\n--- %s : %d lignes ---' % (table, len(r['lignes'])))
    if not r['lignes']:
        continue
    cols = r['cols']
    for nom in ('spawnMask', 'phaseMask', 'PhaseId', 'spawntimesecs', 'MovementType', 'AiID', 'MovementID', 'isActive'):
        if nom in cols:
            i = cols.index(nom)
            c = Counter(l[i] for l in r['lignes'])
            print('  %-14s : %s' % (nom, ', '.join('%s(x%d)' % x for x in c.most_common(6))))

print('\n(la generation SQL n est PAS lancee : on decide d abord de spawnDifficulties)')
