# -*- coding: utf-8 -*-
"""Extrait les 5 chemins scriptes du Rivage brise (carte 1666).

Ils vivent dans `waypoint_data_script`, une table que notre coeur n'a
pas : notre sWaypointMgr ne lit que `waypoint_data`. C'est pourquoi
l'extraction precedente, qui ne regardait que cette derniere, les avait
manques -- et pourquoi les alliés comme le corbeau restaient immobiles.

Correspondance des colonnes, pilotee par les NOMS :
    reference                       nous
    id, point, position_x/y/z,      identiques
    orientation, delay,
    action, action_chance
    move_flag                   ->  move_type   (voir ci-dessous)
    speed, entry                ->  ABANDONNEES, aucun equivalent
    wpguid                      ->  0

move_flag vaut 1 sur la totalite des 87 points des cinq chemins. Notre
enumeration donne 0=marche, 1=course, 2=atterrissage, 3=decollage : la
valeur 1 designe la course dans les deux. Le vol du corbeau ne vient pas
du chemin mais de SetFlyMode et du vehicule.

CONTROLE : les effectifs attendus sont ecrits en dur et verifies. Un
extracteur qui renvoie zero sans broncher est le piege deja rencontre
sur ce chantier.
"""
import io, re, sys

DUMP = '/home/ubuntu/tmp/abs/LegionCore_world_2020_04_25.sql'
ATTENDU = {11322705: 24, 11322706: 18, 11322707: 23, 11322708: 21, 11322709: 1}

# colonnes de waypoint_data_script, relevees dans l'entete de l'INSERT
COLS = ['id','point','position_x','position_y','position_z','orientation',
        'delay','move_flag','speed','action','action_chance','entry','wpguid']

motif = re.compile(r'^\((\d+),(.*)\)[,;]\s*$')
trouves = {k: [] for k in ATTENDU}

with io.open(DUMP, encoding='utf-8', errors='surrogateescape') as f:
    for ligne in f:
        m = motif.match(ligne)
        if not m:
            continue
        ident = int(m.group(1))
        if ident not in ATTENDU:
            continue
        champs = [ident] + [c.strip() for c in m.group(2).split(',')]
        if len(champs) != len(COLS):
            sys.exit('ERREUR : %d champs pour le chemin %d, %d attendus'
                     % (len(champs), ident, len(COLS)))
        trouves[ident].append(dict(zip(COLS, champs)))

for ident, n in sorted(ATTENDU.items()):
    reel = len(trouves[ident])
    if reel != n:
        sys.exit('ERREUR : chemin %d -> %d points extraits, %d attendus.'
                 % (ident, reel, n))

total = sum(len(v) for v in trouves.values())

L = []
L.append('-- ' + '=' * 69)
L.append("-- Assaut du Rivage brisé (carte 1666) — les 5 chemins scriptés")
L.append('--')
L.append("-- Ces chemins vivent dans `waypoint_data_script` chez la référence,")
L.append("-- une table que notre cœur n'a pas : sWaypointMgr ne lit que")
L.append("-- `waypoint_data`. L'extraction du 27/08 ne regardait que cette")
L.append("-- dernière et les avait donc manqués — d'où des alliés immobiles et,")
L.append("-- plus grave, un corbeau arcanique qui ne décollait jamais.")
L.append('--')
L.append("-- Le 11322708 est le vol d'arrivée : c'est l'atteinte de son point 20")
L.append("-- qui déclenche l'étape 0 du scénario. Sans lui, rien ne démarre.")
L.append('--')
L.append("-- move_flag → move_type : la valeur est 1 sur les %d points." % total)
L.append("-- Notre énumération donne 0=marche, 1=course, 2=atterrissage,")
L.append("-- 3=décollage ; la course correspond. `speed` et `entry` n'ont")
L.append("-- aucun équivalent chez nous et sont abandonnées.")
L.append('--')
for ident, n in sorted(ATTENDU.items()):
    L.append('--   %d : %2d points' % (ident, n))
L.append('-- ' + '=' * 69)
L.append('')
L.append('DELETE FROM `waypoint_data` WHERE `id` BETWEEN 11322705 AND 11322709;')
L.append('')
L.append('INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,'
         '`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES')

lignes = []
for ident in sorted(ATTENDU):
    for r in sorted(trouves[ident], key=lambda x: int(x['point'])):
        lignes.append('(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,0)' % (
            r['id'], r['point'], r['position_x'], r['position_y'], r['position_z'],
            r['orientation'], r['delay'], r['move_flag'], r['action'], r['action_chance']))

L.append(',\n'.join(lignes) + ';')

io.open('/tmp/rivage_1666_chemins.sql', 'w', encoding='utf-8').write('\n'.join(L) + '\n')
print('%d points extraits sur %d chemins, controles conformes' % (total, len(ATTENDU)))
