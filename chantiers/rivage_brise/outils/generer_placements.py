# -*- coding: utf-8 -*-
"""Genere le SQL de placement d'une carte depuis le dump de reference,
transpose dans NOTRE schema.

    python3 generer_placements.py <carte> <guid_creature> <guid_objet>

La correspondance est pilotee par les NOMS de colonnes : si un schema
bouge, le generateur s'arrete au lieu de produire un decalage silencieux.

ATTENTION -- une version precedente de cet outil, obtenue en substituant
mecaniquement le numero de carte, produisait un fichier dont les DELETE
visaient encore l'ancienne carte. Le fichier aurait vide la mauvaise et
laisse l'autre intacte. Ici le numero de carte ne vit qu'a UN endroit,
la variable CARTE, et sert partout.
"""
import io, re, sys

if len(sys.argv) != 4:
    sys.exit(__doc__)

CARTE = sys.argv[1]
GUID_CREA = int(sys.argv[2])
GUID_GO = int(sys.argv[3])

DUMP = '/home/ubuntu/tmp/abs/LegionCore_world_2020_04_25.sql'
SORTIE = '/home/ubuntu/DestinyCore/sql/sylvania/rivage_brise_placements_%s.sql' % CARTE

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

FIXES = {'phaseUseFlags':'0', 'PhaseGroup':'0', 'terrainSwapMap':'-1', 'unit_flags2':'0',
         'ScriptName':"''", 'movementmode':'0', 'VerifiedBuild':'0', 'wpguid':'0'}
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


def valeur(nom, cols, v, guid_neuf, difficulte):
    if nom == 'guid':
        return str(guid_neuf)
    if nom == 'spawnDifficulties':
        return "'%s'" % difficulte
    if nom in FIXES:
        return FIXES[nom]
    src = ALIAS.get(nom, nom)
    if src not in cols:
        raise KeyError("colonne '%s' absente de la reference" % src)
    brut = v[cols.index(src)]
    if nom in ('PhaseId', 'PhaseGroup'):
        b = brut.strip().strip("'")
        return b if b else '0'
    return brut


print('lecture du dump (carte %s)...' % CARTE)
d = lire(['creature', 'gameobject', 'waypoint_data'])

cc, cg = d['creature']['cols'], d['gameobject']['cols']
crea = [v for v in d['creature']['rows'] if v[cc.index('map')] == CARTE]
go = [v for v in d['gameobject']['rows'] if v[cg.index('map')] == CARTE]
if not crea:
    sys.exit('extraction vide pour la carte %s -- on ne genere rien' % CARTE)

# la difficulte se DEDUIT du spawnMask, elle n'est pas supposee
masques = {v[cc.index('spawnMask')] for v in crea}
if len(masques) != 1:
    sys.exit('spawnMask non uniforme (%s) -- transposition a decider a la main' % masques)
masque = int(masques.pop())
if masque & (masque - 1):
    sys.exit('spawnMask %d n est pas une puissance de 2 -- a decider a la main' % masque)
DIFFICULTE = masque.bit_length() - 1
print('spawnMask %d -> difficulte %d' % (masque, DIFFICULTE))

i_guid = cc.index('guid')
map_guid = {v[i_guid]: GUID_CREA + n for n, v in enumerate(crea)}

mobiles = {v[i_guid] for v in crea if v[cc.index('MovementType')] == '2'}
wpc = d['waypoint_data']['cols']
wp = [v for v in d['waypoint_data']['rows'] if v[wpc.index('id')] in mobiles]
chemins = len({v[wpc.index('id')] for v in wp})
print('creatures %d | objets %d | mobiles %d | chemins %d | points %d'
      % (len(crea), len(go), len(mobiles), chemins, len(wp)))
if chemins != len(mobiles):
    print('  ATTENTION : %d creatures mobiles sans chemin' % (len(mobiles) - chemins))

L = []
L.append("-- =====================================================================")
L.append("-- Rivage brise -- PLACEMENTS de la carte %s" % CARTE)
L.append("--")
L.append("-- Transpose depuis le dump world de dufernst/LegionCore-7.3.5, meme")
L.append("-- lignee uwow que notre fork. Les schemas divergent : la")
L.append("-- correspondance est pilotee par les NOMS de colonnes, et le")
L.append("-- generateur s'arrete plutot que de produire un decalage silencieux.")
L.append("--")
L.append("-- DIFFICULTE : deduite, pas supposee. Les %d placements portent tous" % len(crea))
L.append("-- spawnMask %d = 2^%d, d'ou spawnDifficulties '%d'." % (masque, DIFFICULTE, DIFFICULTE))
L.append("--")
L.append("-- GUID renumerotes a partir de %d (creatures) et %d (objets)," % (GUID_CREA, GUID_GO))
L.append("-- au-dessus de nos maxima connus 290000114 et 210120986.")
L.append("-- PhaseId : chaine vide cote reference -> 0 chez nous (colonne entiere).")
L.append("--")
L.append("-- ABANDONNE faute d'equivalent chez nous : npcflag2, AiID, MovementID,")
L.append("-- MeleeID, isActive (creature), skipClone, personal_size, isTeemingSpawn.")
L.append("--")
L.append("-- Contenu : %d creatures, %d objets, %d chemins (%d points)." % (len(crea), len(go), chemins, len(wp)))
L.append("-- =====================================================================")
L.append("")
L.append("DELETE FROM `creature` WHERE `map`=%s;" % CARTE)
L.append("DELETE FROM `gameobject` WHERE `map`=%s;" % CARTE)
L.append("DELETE FROM `waypoint_data` WHERE `id` BETWEEN %d AND %d;" % (GUID_CREA, GUID_CREA + len(crea)))
L.append("")

L.append("INSERT INTO `creature` (%s) VALUES" % ','.join('`%s`' % c for c in NOS_CREA))
L.append(',\n'.join('(' + ','.join(valeur(c, cc, v, GUID_CREA + n, DIFFICULTE) for c in NOS_CREA) + ')'
                    for n, v in enumerate(crea)) + ';')
L.append("")

if go:
    L.append("INSERT INTO `gameobject` (%s) VALUES" % ','.join('`%s`' % c for c in NOS_GO))
    L.append(',\n'.join('(' + ','.join(valeur(c, cg, v, GUID_GO + n, DIFFICULTE) for c in NOS_GO) + ')'
                        for n, v in enumerate(go)) + ';')
    L.append("")

if wp:
    L.append("INSERT INTO `waypoint_data` (%s) VALUES" % ','.join('`%s`' % c for c in NOS_WP))
    bouts = []
    for v in wp:
        vals = [str(map_guid[v[wpc.index('id')]]) if c == 'id'
                else valeur(c, wpc, v, 0, DIFFICULTE) for c in NOS_WP]
        bouts.append('(' + ','.join(vals) + ')')
    L.append(',\n'.join(bouts) + ';')

io.open(SORTIE, 'w', encoding='utf-8').write('\n'.join(L) + '\n')
print('ecrit : %s' % SORTIE)
