-- =====================================================================
-- Quete 38206 "Making the Rounds" / "Tournee d'inspection"
-- Suite de 38035, sur le pont du Bruleciel (Hurlevent, map 0,
-- terrainSwapMap 1066, area 4411). Sequence scriptee NON implementee :
-- 3 objectifs sans aucun credit possible + rendeur Genn Greymane non spawne.
--   obj1 96662 "Inspect Deck Guns"        -> cliquer un canon
--   obj2 96661 "Salute 7th Legion Dragoons"-> saluer/cliquer un dragon
--   obj3 96663 "Speak with Genn Greymane"  -> parler a Genn (= rendeur)
--
-- Reproduction (interactive, fidele aux objectifs) :
--   - Genn Greymane (96663) spawne sur le pont, gossip-hello credite obj3 + rend.
--   - 2 canons cliquables (110712, NON-vehicule) : clic -> credit 96662.
--   - 2 dragons (92933) : /salut ou clic -> credit 96661.
--   - Amiral Rogers reste a son poste (choregraphie de marche non reproduite).
--
-- + CORRECTION BUG 38035 : Rogers (96644) avait ScriptName='SmartAI' au lieu
--   de AIName='SmartAI' -> SmartAI jamais actif -> credits 38035 jamais tires.
--   On corrige : AIName='SmartAI', ScriptName=''.
-- Date: 2026-06-19
-- =====================================================================

-- ---------- Correction bug Rogers (active enfin les credits 38035) ----------
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=96644;

-- ---------- Activer SmartAI sur les PNJ de la sequence (aucun = vehicule) ----------
UPDATE creature_template SET AIName='SmartAI' WHERE entry IN (96663,110712,92933);

-- ---------- Spawns sur le pont (z/terrainSwap copies des Skyfire Marines) ----------
DELETE FROM creature WHERE guid BETWEEN 280001398 AND 280001402;
INSERT INTO creature
 (guid,id,map,zoneId,areaId,spawnDifficulties,phaseUseFlags,PhaseId,PhaseGroup,terrainSwapMap,modelid,equipment_id,
  position_x,position_y,position_z,orientation,spawntimesecs,spawndist,currentwaypoint,curhealth,curmana,MovementType,
  npcflag,unit_flags,unit_flags2,unit_flags3,dynamicflags,ScriptName,movementmode,VerifiedBuild) VALUES
-- Genn Greymane (rendeur + obj3) : npcflag herite du template (2 = questgiver)
(280001398, 96663, 0,1519,4411, 0,0,0,0, 1066, 0,0, -8396, 1376, 135.508, 3.14,   300,0,0,1,0,0, 0,0,0,0,0,'',0,0),
-- Canons cliquables (obj1) : npcflag=1 (gossip) en override de spawn
(280001399,110712, 0,1519,4411, 0,0,0,0, 1066, 0,0, -8390, 1370, 135.508, 4.712,  300,0,0,1,0,0, 1,0,0,0,0,'',0,0),
(280001400,110712, 0,1519,4411, 0,0,0,0, 1066, 0,0, -8390, 1384, 135.508, 1.571,  300,0,0,1,0,0, 1,0,0,0,0,'',0,0),
-- Dragons (obj2) : npcflag=1 (gossip) override ; unit_flags herite (pacifie)
(280001401, 92933, 0,1519,4411, 0,0,0,0, 1066, 0,0, -8408, 1374, 135.508, 0.20,   300,0,0,1,0,0, 1,0,0,0,0,'',0,0),
(280001402, 92933, 0,1519,4411, 0,0,0,0, 1066, 0,0, -8408, 1380, 135.508, 0.20,   300,0,0,1,0,0, 1,0,0,0,0,'',0,0);

-- ---------- smart_scripts ----------
-- Genn (entry-based, 0 autre spawn) : gossip hello -> credit obj3 (96663)
DELETE FROM smart_scripts WHERE entryorguid=96663 AND source_type=0;
INSERT INTO smart_scripts
(entryorguid,source_type,id,link,event_type,event_phase_mask,event_chance,event_flags,
 event_param1,event_param2,event_param3,event_param4,event_param5,
 action_type,action_param1,action_param2,action_param3,action_param4,action_param5,action_param6,
 target_type,target_param1,target_param2,target_param3,target_x,target_y,target_z,target_o,comment) VALUES
(96663,0,0,0,64,0,100,0, 0,0,0,0,0, 33,96663,0,0,0,0,0, 7,0,0,0,0,0,0,0,'Making the Rounds - Genn: gossip hello -> credit Speak with Genn (96663)');

-- Canons (entry-based, 110712 = 0 autre spawn) : gossip hello -> credit obj1 (96662)
DELETE FROM smart_scripts WHERE entryorguid=110712 AND source_type=0;
INSERT INTO smart_scripts
(entryorguid,source_type,id,link,event_type,event_phase_mask,event_chance,event_flags,
 event_param1,event_param2,event_param3,event_param4,event_param5,
 action_type,action_param1,action_param2,action_param3,action_param4,action_param5,action_param6,
 target_type,target_param1,target_param2,target_param3,target_x,target_y,target_z,target_o,comment) VALUES
(110712,0,0,0,64,0,100,0, 0,0,0,0,0, 33,96662,0,0,0,0,0, 7,0,0,0,0,0,0,0,'Making the Rounds - Deck Gun: gossip hello -> credit Inspect Deck Guns (96662)');

-- Dragons (guid-based, 92933 spawne ailleurs) : gossip hello OU /salut -> credit obj2 (96661)
DELETE FROM smart_scripts WHERE entryorguid IN (-280001401,-280001402) AND source_type=0;
INSERT INTO smart_scripts
(entryorguid,source_type,id,link,event_type,event_phase_mask,event_chance,event_flags,
 event_param1,event_param2,event_param3,event_param4,event_param5,
 action_type,action_param1,action_param2,action_param3,action_param4,action_param5,action_param6,
 target_type,target_param1,target_param2,target_param3,target_x,target_y,target_z,target_o,comment) VALUES
(-280001401,0,0,0,64,0,100,0, 0,0,0,0,0, 33,96661,0,0,0,0,0, 7,0,0,0,0,0,0,0,'Making the Rounds - Dragoon: gossip hello -> credit Salute Dragoons (96661)'),
(-280001401,0,1,0,43,0,100,0, 66,0,0,0,0, 33,96661,0,0,0,0,0, 7,0,0,0,0,0,0,0,'Making the Rounds - Dragoon: on SALUTE emote -> credit Salute Dragoons (96661)'),
(-280001402,0,0,0,64,0,100,0, 0,0,0,0,0, 33,96661,0,0,0,0,0, 7,0,0,0,0,0,0,0,'Making the Rounds - Dragoon: gossip hello -> credit Salute Dragoons (96661)'),
(-280001402,0,1,0,43,0,100,0, 66,0,0,0,0, 33,96661,0,0,0,0,0, 7,0,0,0,0,0,0,0,'Making the Rounds - Dragoon: on SALUTE emote -> credit Salute Dragoons (96661)');
