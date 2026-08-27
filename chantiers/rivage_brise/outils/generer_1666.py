# -*- coding: utf-8 -*-
"""Genere le SQL de placement de la carte 1666 dans NOTRE schema.
N'applique rien : ecrit un fichier.

La correspondance est pilotee par les NOMS de colonnes, pas par leur
position : si les schemas bougent, le generateur ne produira pas de
decalage silencieux -- il s'arretera.
"""
import io, re, sys
from collections import Counter

DUMP = '/home/ubuntu/tmp/abs/LegionCore_world_2020_04_25.sql'
SORTIE = '/home/ubuntu/DestinyCore/sql/sylvania/rivage_brise_placements.sql'

GUID_CREA = 290100000
GUID_GO = 210200000

NOS_CREA = ['guid','id','map','zoneId','areaId','spawnDifficulties','phaseUseFlags','PhaseId',
            'PhaseGroup','terrainSwapMap','modelid','equipment_id','position_x','position_y',
            'position_z','orientation','spawntimesecs','spawndist','currentwaypoint','curhealth',
            'curmana','MovementType','npcflag','unit_flags','unit_flags2','unit_flags3',
            'dynamicflags','ScriptName','movementmode','VerifiedBuild']

NOS_GO = ['guid','id','map','zoneId','areaId','spawnDifficulties','phaseUseFlags','PhaseId',
          'PhaseGroup','terrainSwapMap','position_x','position_y','position_z','orientation',
          'rotation0','rotation1','rotation2','rotation3','spawntimesecs','animprogress','state',
          'isActive','ScriptName','VerifiedBuild']

NOS_WP = ['id','point','position_x','position_y','position_z','orientation','delay',
          'move_type','action','action_chance','wpguid']

# valeurs imposees, quelle que soit la reference
FIXES = {
    'spawnDifficulties': "'12'",   # 4096 = 2^12, difficulte « Normal Scenario »
    'phaseUseFlags': '0',
    'PhaseGroup': '0',
    'terrainSwapMap': '-1',
    'unit_flags2': '0',
    'ScriptName': "''",
    'movementmode': '0',
    'VerifiedBuild': '0',
    'wpguid': '0',
}

# nos colonnes qui portent un autre nom dans la reference
ALIAS = {'move_type': 'move_flag'}


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


def lire(tables):
    """Renvoie {table: (colonnes, [tuples decoupes])} pour tout le dump."""
    motif = re.compile(r"insert\s+into\s+`(%s)`\(([^)]*)\)\s+values\s*" % '|'.join(tables), re.I)
    out = {t: {'cols': None, 'rows': []} for t in tables}
    with io.open(DUMP, encoding='utf-8', errors='replace') as f:
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
            out[table]['cols'] = cols
            for t in decoupe_tuples(''.join(morceaux)):
                v = champs(t)
                if len(v) == len(cols):
                    out[table]['rows'].append(v)
            ligne = f.readline()
    return out


def valeur(nom, cols, v, guid_neuf):
    if nom == 'guid':
        return str(guid_neuf)
    if nom in FIXES:
        return FIXES[nom]
    src = ALIAS.get(nom, nom)
    if src not in cols:
        raise KeyError("colonne '%s' absente de la reference" % src)
    brut = v[cols.index(src)]
    if nom in ('PhaseId', 'PhaseGroup'):          # chaine cote reference, entier chez nous
        b = brut.strip().strip("'")
        return b if b else '0'
    return brut


print('lecture du dump...')
d = lire(['creature', 'gameobject', 'waypoint_data'])

crea = [v for v in d['creature']['rows'] if v[d['creature']['cols'].index('map')] == '1666']
go = [v for v in d['gameobject']['rows'] if v[d['gameobject']['cols'].index('map')] == '1666']
print('creatures 1666 : %d | objets 1666 : %d' % (len(crea), len(go)))
assert crea and go, 'extraction vide -- refuser de generer'

# renumerotation, en gardant la trace ancien -> nouveau
i_guid_c = d['creature']['cols'].index('guid')
map_guid = {}
for n, v in enumerate(crea):
    map_guid[v[i_guid_c]] = GUID_CREA + n

# chemins des creatures mobiles
i_mt = d['creature']['cols'].index('MovementType')
mobiles = {v[i_guid_c] for v in crea if v[i_mt] == '2'}
wp_cols = d['waypoint_data']['cols']
i_wid = wp_cols.index('id')
wp = [v for v in d['waypoint_data']['rows'] if v[i_wid] in mobiles]
chemins = len({v[i_wid] for v in wp})
print('creatures mobiles : %d | chemins trouves : %d | points : %d' % (len(mobiles), chemins, len(wp)))

lignes = []
A = lignes.append
A("-- =====================================================================")
A("-- Assaut du Rivage brise (carte 1666) -- PLACEMENTS")
A("--")
A("-- Transpose depuis le dump world de dufernst/LegionCore-7.3.5, meme")
A("-- lignee uwow que notre fork. Les deux schemas divergent : la")
A("-- correspondance ci-dessous est pilotee par les NOMS de colonnes, et le")
A("-- generateur s'arrete plutot que de produire un decalage silencieux.")
A("--")
A("-- DECISIONS, etablies sur donnees et non supposees :")
A("--   spawnMask 4096 = 2^12 -> spawnDifficulties '12', la difficulte 12")
A("--   etant « Normal Scenario » d'apres Difficulty.db2 du build")
A("--   7.3.5.26972 (type instance 5, 5 joueurs).")
A("--   GUID renumerotes a partir de %d (creatures) et %d (objets)," % (GUID_CREA, GUID_GO))
A("--   au-dessus de nos maxima 290000114 et 210120986.")
A("--   PhaseId : chaine vide cote reference -> 0 chez nous (entier).")
A("--")
A("-- ABANDONNE faute d'equivalent : npcflag2, AiID, MovementID, MeleeID,")
A("-- isActive (creature), skipClone, personal_size, isTeemingSpawn.")
A("-- 12 creatures portaient AiID=7424, une table d'IA propre au coeur de")
A("-- reference : leur comportement est PERDU et reste a refaire.")
A("--")
A("-- Contenu : %d creatures, %d objets, %d chemins (%d points)." % (len(crea), len(go), chemins, len(wp)))
A("-- =====================================================================")
A("")
A("DELETE FROM `creature` WHERE `map`=1666;")
A("DELETE FROM `gameobject` WHERE `map`=1666;")
A("DELETE FROM `waypoint_data` WHERE `id` BETWEEN %d AND %d;" % (GUID_CREA, GUID_CREA + len(crea)))
A("")

A("INSERT INTO `creature` (%s) VALUES" % ','.join('`%s`' % c for c in NOS_CREA))
bouts = []
for n, v in enumerate(crea):
    bouts.append('(' + ','.join(valeur(c, d['creature']['cols'], v, GUID_CREA + n) for c in NOS_CREA) + ')')
A(',\n'.join(bouts) + ';')
A("")

A("INSERT INTO `gameobject` (%s) VALUES" % ','.join('`%s`' % c for c in NOS_GO))
bouts = []
for n, v in enumerate(go):
    bouts.append('(' + ','.join(valeur(c, d['gameobject']['cols'], v, GUID_GO + n) for c in NOS_GO) + ')')
A(',\n'.join(bouts) + ';')
A("")

if wp:
    A("INSERT INTO `waypoint_data` (%s) VALUES" % ','.join('`%s`' % c for c in NOS_WP))
    bouts = []
    for v in wp:
        anc = v[i_wid]
        ligne_vals = []
        for c in NOS_WP:
            if c == 'id':
                ligne_vals.append(str(map_guid[anc]))
            else:
                ligne_vals.append(valeur(c, wp_cols, v, 0))
        bouts.append('(' + ','.join(ligne_vals) + ')')
    A(',\n'.join(bouts) + ';')

io.open(SORTIE, 'w', encoding='utf-8').write('\n'.join(lignes) + '\n')
print('ecrit : %s' % SORTIE)
