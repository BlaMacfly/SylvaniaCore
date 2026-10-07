#!/usr/bin/env python3
# Chefs de faction et receveurs des quetes de scenario d'assaut, absents de notre monde : spawns repris de
# LegionCore (lc_world_ref), dans un calque libre de la zone allume par la quete principale de l'assaut OU par
# la quete de scenario (en cours / terminee non rendue). Lecture seule des bases.
import subprocess

def q(sql):
    out = subprocess.run(['sudo', 'mysql', '-N', '-e', sql], capture_output=True, text=True, check=True).stdout
    return [l.split('\t') for l in out.rstrip('\n').split('\n') if l]

# zone, quete principale, quete de scenario, chef (donneur), receveur
ZONES = [
    (7558, 45812, 45856, 118183, 118440, 'valsharah'),
    (7503, 45840, 46182, 119676, 119944, 'hautroc'),
    (7541, 45839, 46110, 116868, 118781, 'tornheim'),
]
POOL = ['6209', '6210', '6212', '6214', '6216', '6159', '6160', '6161', '6162', '6163', '7502', '7503', '7504', '7505',
        '7506', '7507', '7508', '7509', '7510', '7511', '7512', '7513', '7514']
OUT = '/home/ubuntu/DestinyCore/sql/sylvania/2026_10_08_assauts_chefs'

start = int(q("SELECT MAX(guid)+1 FROM dc_world.creature")[0][0])
L = ["-- Chefs de faction (donneurs des quetes de scenario) et receveurs des assauts de Val'sharah, Haut-Roc et Tornheim.",
     "-- Positions de LegionCore ; visibles via un calque libre de la zone, allume par la quete principale de l'assaut",
     "-- (prise) ou par la quete de scenario (en cours ou terminee, masque 10). Rollback : ..._chefs_rollback.sql", ""]
R = ["-- Annule 2026_10_08_assauts_chefs.sql"]
guid = start
npcflags = {}
for zone, assaut, scen, chef, receveur, nom in ZONES:
    used = {r[0] for r in q(f"SELECT PhaseId FROM dc_world.phase_area WHERE AreaId={zone}")} | \
           {r[0] for r in q(f"SELECT DISTINCT PhaseId FROM dc_world.creature WHERE zoneId={zone}")}
    phase = next(p for p in POOL if p not in used)
    for npc in (chef, receveur):
        assert not q(f"SELECT 1 FROM dc_world.creature WHERE id={npc} AND map=1220"), (npc, 'deja pose')
        r = q(f"""SELECT c.zoneId, c.areaId, c.position_x, c.position_y, c.position_z, c.orientation, t.name
                  FROM lc_world_ref.creature c JOIN dc_world.creature_template t ON t.entry=c.id
                  WHERE c.map=1220 AND c.id={npc} ORDER BY c.guid LIMIT 1""")[0]
        L.append("INSERT INTO creature (guid, id, map, zoneId, areaId, spawnDifficulties, phaseUseFlags, PhaseId, PhaseGroup, terrainSwapMap, modelid, equipment_id,"
                 " position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, MovementType, npcflag,"
                 " unit_flags, unit_flags2, unit_flags3, dynamicflags, ScriptName, movementmode, VerifiedBuild) VALUES"
                 f" ({guid}, {npc}, 1220, {r[0]}, {r[1]}, '0', 0, {phase}, 0, -1, 0, 0, {r[2]}, {r[3]}, {r[4]}, {r[5]}, 300, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, '', 0, 0); -- {r[6]}")
        guid += 1
        npcflags[npc] = 3 if npc == chef else 2
    L.append(f"INSERT INTO phase_area (AreaId, PhaseId, Comment) VALUES ({zone}, {phase}, 'Assaut de la Legion - chefs {nom}');")
    L.append("INSERT INTO conditions (SourceTypeOrReferenceId, SourceGroup, SourceEntry, SourceId, ElseGroup, ConditionTypeOrReference, ConditionTarget,"
             " ConditionValue1, ConditionValue2, ConditionValue3, NegativeCondition, ErrorType, ErrorTextId, ScriptName, Comment) VALUES"
             f" (26, {phase}, {zone}, 0, 0, 9, 0, {assaut}, 0, 0, 0, 0, 0, '', 'Assaut {nom} : chefs (assaut en cours)'),"
             f" (26, {phase}, {zone}, 0, 1, 47, 0, {scen}, 10, 0, 0, 0, 0, '', 'Assaut {nom} : chefs (scenario en cours ou a rendre)');")
    L.append("")
    R.append(f"DELETE FROM phase_area WHERE AreaId={zone} AND PhaseId={phase} AND Comment='Assaut de la Legion - chefs {nom}';")
    R.append(f"DELETE FROM conditions WHERE SourceTypeOrReferenceId=26 AND SourceEntry={zone} AND SourceGroup={phase} AND Comment LIKE 'Assaut {nom} : chefs%';")
    print(nom, 'calque', phase)

avant = {r[0]: r[1] for r in q(f"SELECT entry, npcflag FROM dc_world.creature_template WHERE entry IN ({','.join(map(str, npcflags))})")}
for npc, fl in npcflags.items():
    L.append(f"UPDATE creature_template SET npcflag = npcflag | {fl} WHERE entry = {npc};")
    R.append(f"UPDATE creature_template SET npcflag = {avant[str(npc)]} WHERE entry = {npc};")
R.insert(1, f"DELETE FROM creature WHERE guid BETWEEN {start} AND {guid-1};")
open(OUT + '.sql', 'w').write('\n'.join(L) + '\n')
open(OUT + '_rollback.sql', 'w').write('\n'.join(R) + '\n')
print('creatures', start, '->', guid - 1)
