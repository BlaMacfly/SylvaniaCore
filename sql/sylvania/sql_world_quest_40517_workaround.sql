-- ============================================================================
-- Quête 40517 « The Fallen Lion » (FR « Le Lion terrassé ») — CONTOURNEMENT.
-- 2026-06-14. Suite directe de 42740 (donnée par Genn Greymane).
-- ----------------------------------------------------------------------------
-- PROBLÈME : non rendable. Rendeur Anduin Wrynn (100429) NON spawné, et les
--   objectifs sont des crédits de SCÈNE SCRIPTÉE (deuil au Donjon de Hurlevent,
--   couronnement d'Anduin) non implémentée :
--     0 (opt) 100696 « Ride a gryphon to Stormwind Keep »
--     2       100454 « Hear Leaders Mourning »
--     3       100419 « Deliver Varian's letter and listen to King Anduin »
--
-- CONTOURNEMENT : spawn d'Anduin Wrynn (déjà npcflag=3 donneur/gossip, modèle
--   65199) dans la salle du trône (coords POI réelles -8360,231 ; z≈157 d'après
--   les PNJ voisins). Son gossip crédite les 3 objectifs (pattern KILLCREDIT
--   validé) → la quête se complète → Anduin propose le rendu.
--   ⚠️ NON-Blizzlike : la scène/cinématique de deuil est sautée.
--   Application : SQL puis restart world (nouveau spawn).
-- ============================================================================

UPDATE creature_template SET AIName='SmartAI' WHERE entry=100429;

DELETE FROM creature WHERE guid=280000205;
INSERT INTO creature
 (guid,id,map,zoneId,areaId,spawnDifficulties,position_x,position_y,position_z,orientation,
  spawntimesecs,MovementType) VALUES
 (280000205,100429,0,1519,1519,'0', -8360, 231, 157.0, 3.14, 300,0);

DELETE FROM smart_scripts WHERE source_type=0 AND entryorguid=100429;
INSERT INTO smart_scripts
 (entryorguid,source_type,id,link,event_type,event_phase_mask,event_chance,event_flags,
  event_param1,event_param2,event_param3,event_param4,
  action_type,action_param1,action_param2,action_param3,action_param4,action_param5,action_param6,
  target_type,target_param1,target_param2,target_param3,target_x,target_y,target_z,target_o,comment) VALUES
 (100429,0,0,0, 64,0,100,0, 0,0,0,0, 33,100454,0,0,0,0,0, 7,0,0,0, 0,0,0,0, 'Q40517 workaround: credit Hear Leaders Mourning (100454)'),
 (100429,0,1,0, 64,0,100,0, 0,0,0,0, 33,100419,0,0,0,0,0, 7,0,0,0, 0,0,0,0, 'Q40517 workaround: credit Deliver letter/listen Anduin (100419)'),
 (100429,0,2,0, 64,0,100,0, 0,0,0,0, 33,100696,0,0,0,0,0, 7,0,0,0, 0,0,0,0, 'Q40517 workaround: credit (opt) gryphon ride (100696)');
