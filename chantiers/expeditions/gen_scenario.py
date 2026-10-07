#!/usr/bin/env python3
# Etape finale d'un assaut de la Legion : scenario instancie repris de LegionCore. Lecture seule des bases.
# Usage : gen_scenario.py <nom> <carte> <scenario> <zone> <quete_scenario> <donneur> <receveur> <objectif_points> <scripts>
#   <scripts> = "entree:ScriptName,entree:ScriptName,..."
import subprocess, sys

NOM, MAP, SCEN, ZONE, QUETE, DONNEUR, RECEVEUR, OBJ_POINTS = sys.argv[1], *map(int, sys.argv[2:9])
SCRIPTS = dict(x.split(':') for x in sys.argv[9].split(',')) if len(sys.argv) > 9 and sys.argv[9] else {}
OUT = f'/home/ubuntu/DestinyCore/sql/sylvania/2026_10_08_scenario_assaut_{NOM}'

def q(sql):
    out = subprocess.run(['sudo', 'mysql', '-N', '-e', sql], capture_output=True, text=True, check=True).stdout
    return [l.split('\t') for l in out.rstrip('\n').split('\n') if l]

assert not q(f"SELECT 1 FROM dc_world.creature WHERE map={MAP} LIMIT 1"), 'la carte a deja des creatures'
assert not q(f"SELECT 1 FROM dc_world.scenarios WHERE map={MAP}"), 'scenario deja declare'

start_c = int(q("SELECT MAX(guid)+1 FROM dc_world.creature")[0][0])
cre = q(f"""SELECT c.id, c.zoneId, c.areaId, c.position_x, c.position_y, c.position_z, c.orientation, c.spawntimesecs, c.spawndist,
                   IF(c.MovementType=2,0,c.MovementType),
                   IF(c.equipment_id>0 AND EXISTS(SELECT 1 FROM dc_world.creature_equip_template e WHERE e.CreatureID=c.id AND e.ID=c.equipment_id), c.equipment_id, 0),
                   t.name
            FROM lc_world_ref.creature c JOIN dc_world.creature_template t ON t.entry=c.id WHERE c.map={MAP} ORDER BY c.id, c.guid""")
start_g = int(q("SELECT MAX(guid)+1 FROM dc_world.gameobject")[0][0])
gob = q(f"""SELECT g.id, g.zoneId, g.areaId, g.position_x, g.position_y, g.position_z, g.orientation, g.rotation0, g.rotation1, g.rotation2, g.rotation3,
                   g.spawntimesecs, g.animprogress, g.state
            FROM lc_world_ref.gameobject g JOIN dc_world.gameobject_template t ON t.entry=g.id WHERE g.map={MAP} ORDER BY g.id, g.guid""")
ids = sorted({r[0] for r in cre}, key=int)
I = ','.join(ids)

# scripts en base des combattants (SmartAI LegionCore), seulement pour les entrees sans script chez nous
smart_lc = q(f"""SELECT entryorguid, id, link, event_type, event_phase_mask, event_chance, event_flags, event_param1, event_param2, event_param3, event_param4,
                        action_type, action_param1, action_param2, action_param3, action_param4, action_param5, action_param6,
                        target_type, target_param1, target_param2, target_param3, target_x, target_y, target_z, target_o, comment
                 FROM lc_world_ref.smart_scripts WHERE source_type=0 AND entryorguid IN ({I}) ORDER BY entryorguid, id""")
deja_smart = {r[0] for r in q(f"SELECT DISTINCT entryorguid FROM dc_world.smart_scripts WHERE source_type=0 AND entryorguid IN ({I})")}
smart = [r for r in smart_lc if r[0] not in deja_smart and r[0] not in SCRIPTS]
smart_ids = sorted({r[0] for r in smart}, key=int)
# actions et evenements LegionCore inconnus chez nous : on n'importe que lancer un sort (11) sur soi ou la cible, sur un evenement de mise a jour (0 ou 60)
assert all(r[3] in ('0', '60') and r[11] == '11' and r[18] in ('1', '2') for r in smart), 'evenement ou action SmartAI non verifie'

clicks = q(f"SELECT npc_entry, spell_id, cast_flags, user_type FROM lc_world_ref.npc_spellclick_spells WHERE npc_entry IN ({I})")
deja_click = {r[0] for r in q(f"SELECT DISTINCT npc_entry FROM dc_world.npc_spellclick_spells WHERE npc_entry IN ({I})")}
clicks = [r for r in clicks if r[0] not in deja_click]

tpl_avant = q(f"SELECT entry, AIName, ScriptName FROM dc_world.creature_template WHERE entry IN ({','.join(sorted(set(SCRIPTS) | set(smart_ids) | {str(DONNEUR)}, key=int))})")
ender_deja = q(f"SELECT 1 FROM dc_world.creature_questender WHERE id={RECEVEUR} AND quest={QUETE}")
starter_deja = q(f"SELECT 1 FROM dc_world.creature_queststarter WHERE id={DONNEUR} AND quest={QUETE}")
cond_deja = q(f"SELECT 1 FROM dc_world.conditions WHERE SourceTypeOrReferenceId=19 AND SourceEntry={QUETE}")

esc = lambda x: x.replace('\\', '\\\\').replace("'", "\\'")
L = [f"-- Assaut de la Legion, etape finale ({NOM}) : scenario {SCEN} sur la carte {MAP}, repris de LegionCore (lc_world_ref).",
     f"-- {len(cre)} creatures, {len(gob)} objets (difficulte 12 : scenario ; la 1 est refusee sur ces cartes), {len(smart)} lignes SmartAI de combat,",
     f"-- {len(clicks)} clics. Quete {QUETE} : donneur {DONNEUR} (une fois les points de la Legion repousses), receveur {RECEVEUR}.",
     f"-- Rollback : 2026_10_08_scenario_assaut_{NOM}_rollback.sql", "",
     f"INSERT INTO scenarios (map, difficulty, scenario_A, scenario_H, zoneid) VALUES ({MAP}, 0, {SCEN}, {SCEN}, {ZONE});", "",
     "INSERT INTO creature (guid, id, map, zoneId, areaId, spawnDifficulties, phaseUseFlags, PhaseId, PhaseGroup, terrainSwapMap, modelid, equipment_id,",
     "  position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, MovementType, npcflag,",
     "  unit_flags, unit_flags2, unit_flags3, dynamicflags, ScriptName, movementmode, VerifiedBuild) VALUES"]
for i, r in enumerate(cre):
    cid, z, a, x, y, zz, o, rs, dist, mt, eq, name = r
    L.append(f"({start_c+i}, {cid}, {MAP}, {z}, {a}, '12', 0, 0, 0, -1, 0, {eq}, {x}, {y}, {zz}, {o}, {rs}, {dist}, 0, 1, 0, {mt}, 0, 0, 0, 0, 0, '', 0, 0)"
             + (',' if i < len(cre) - 1 else ';') + f" -- {name}")
if gob:
    L += ["", "INSERT INTO gameobject (guid, id, map, zoneId, areaId, spawnDifficulties, phaseUseFlags, PhaseId, PhaseGroup, terrainSwapMap,",
          "  position_x, position_y, position_z, orientation, rotation0, rotation1, rotation2, rotation3, spawntimesecs, animprogress, state, isActive, ScriptName, VerifiedBuild) VALUES"]
    L.append(',\n'.join(f"({start_g+i}, {r[0]}, {MAP}, {r[1]}, {r[2]}, '12', 0, 0, 0, -1, {', '.join(r[3:11])}, {r[11]}, {r[12]}, {r[13]}, 0, '', 0)"
                        for i, r in enumerate(gob)) + ';')
L.append("")
for e, sn in SCRIPTS.items():
    L.append(f"UPDATE creature_template SET AIName = '', ScriptName = '{sn}' WHERE entry = {e};")
for e in smart_ids:
    L.append(f"UPDATE creature_template SET AIName = 'SmartAI' WHERE entry = {e} AND ScriptName = '';")
if smart:
    L += ["", "INSERT INTO smart_scripts (entryorguid, source_type, id, link, event_type, event_phase_mask, event_chance, event_flags,",
          "  event_param1, event_param2, event_param3, event_param4, action_type, action_param1, action_param2, action_param3, action_param4,",
          "  action_param5, action_param6, target_type, target_param1, target_param2, target_param3, target_x, target_y, target_z, target_o, comment) VALUES"]
    L.append(',\n'.join("(" + r[0] + ", 0, " + ', '.join(r[1:26]) + f", '{esc(r[26])}')" for r in smart) + ';')
if clicks:
    L += ["", "INSERT INTO npc_spellclick_spells (npc_entry, spell_id, cast_flags, user_type) VALUES",
          ',\n'.join('(' + ', '.join(r) + ')' for r in clicks) + ';']
L.append("")
if not starter_deja: L.append(f"INSERT INTO creature_queststarter (id, quest) VALUES ({DONNEUR}, {QUETE});")
if not ender_deja: L.append(f"INSERT INTO creature_questender (id, quest) VALUES ({RECEVEUR}, {QUETE});")
if not cond_deja:
    L.append("INSERT INTO conditions (SourceTypeOrReferenceId, SourceGroup, SourceEntry, SourceId, ElseGroup, ConditionTypeOrReference, ConditionTarget,")
    L.append("  ConditionValue1, ConditionValue2, ConditionValue3, NegativeCondition, ErrorType, ErrorTextId, ScriptName, Comment) VALUES")
    L.append(f"(19, 0, {QUETE}, 0, 0, 48, 0, {OBJ_POINTS}, 0, 0, 0, 0, 0, '', 'Assaut {NOM} : quete de scenario apres les 4 points repousses');")
open(OUT + '.sql', 'w').write('\n'.join(L) + '\n')

R = [f"-- Annule 2026_10_08_scenario_assaut_{NOM}.sql",
     f"DELETE FROM scenarios WHERE map={MAP};",
     f"DELETE FROM creature WHERE guid BETWEEN {start_c} AND {start_c+len(cre)-1};"]
if gob: R.append(f"DELETE FROM gameobject WHERE guid BETWEEN {start_g} AND {start_g+len(gob)-1};")
for e, ai, sn in tpl_avant:
    R.append(f"UPDATE creature_template SET AIName = '{esc(ai)}', ScriptName = '{esc(sn)}' WHERE entry = {e};")
if smart: R.append(f"DELETE FROM smart_scripts WHERE source_type=0 AND entryorguid IN ({','.join(smart_ids)});")
if clicks: R.append(f"DELETE FROM npc_spellclick_spells WHERE npc_entry IN ({','.join(sorted({r[0] for r in clicks}))});")
if not starter_deja: R.append(f"DELETE FROM creature_queststarter WHERE id={DONNEUR} AND quest={QUETE};")
if not ender_deja: R.append(f"DELETE FROM creature_questender WHERE id={RECEVEUR} AND quest={QUETE};")
if not cond_deja: R.append(f"DELETE FROM conditions WHERE SourceTypeOrReferenceId=19 AND SourceEntry={QUETE};")
open(OUT + '_rollback.sql', 'w').write('\n'.join(R) + '\n')
print(f"creatures {len(cre)} objets {len(gob)} smart {len(smart)} ({len(smart_ids)} entrees) clics {len(clicks)} scripts {len(SCRIPTS)}")
