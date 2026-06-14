-- ============================================================================
-- Quête 42740 « The Battle for Broken Shore » (FR « La Bataille pour la Rive
--   Brisée ») — CONTOURNEMENT temporaire. 2026-06-14.
-- ----------------------------------------------------------------------------
-- CONTEXTE : 42740 est la quête-SCÉNARIO instancié (map 1466, scénario 1172).
--   Le scénario n'est pas implémenté sur ce core (pas de spawns phasés, pas de
--   script C++ d'orchestration, pas de cinématique). Objectifs bloqués :
--     - 108920 Captain Angelica  (« Ship taken to the Broken Shore »)
--     - 90918  Finale Kill Credit (« Broken Shore assaulted » = fin du scénario)
--   Rendeur 100395 Genn Greymane non spawné.
--
-- BUT : débloquer la progression vers les Îles Brisées en attendant le vrai
--   scénario. ⚠️ NON-Blizzlike : la bataille/cinématique est SAUTÉE. À RETIRER
--   quand le scénario complet sera en place.
--
-- Mécanique : Captain Angelica spawnée au port (gossip) ; un clic crédite les
--   2 objectifs (pattern KILLCREDIT déjà validé). Genn Greymane spawné à côté
--   pour le rendu (il enchaîne ensuite la chaîne vers les Îles Brisées).
--   Coords = embarcadère du port (z=17.95, niveau de Lee/Dameron, confirmé).
--   Application : SQL puis restart world (nouveaux spawns).
-- ============================================================================

-- 1) Captain Angelica : cliquable (gossip) + SmartAI
UPDATE creature_template SET npcflag = npcflag | 1, AIName='SmartAI' WHERE entry=108920;

DELETE FROM creature WHERE guid=280000203;
INSERT INTO creature
 (guid,id,map,zoneId,areaId,spawnDifficulties,position_x,position_y,position_z,orientation,
  spawntimesecs,MovementType) VALUES
 (280000203,108920,0,1519,4411,'0', -8505, 1086, 17.95, 5.2, 300,0);

DELETE FROM smart_scripts WHERE source_type=0 AND entryorguid=108920;
INSERT INTO smart_scripts
 (entryorguid,source_type,id,link,event_type,event_phase_mask,event_chance,event_flags,
  event_param1,event_param2,event_param3,event_param4,
  action_type,action_param1,action_param2,action_param3,action_param4,action_param5,action_param6,
  target_type,target_param1,target_param2,target_param3,target_x,target_y,target_z,target_o,comment) VALUES
 (108920,0,0,0, 64,0,100,0, 0,0,0,0, 33,108920,0,0,0,0,0, 7,0,0,0, 0,0,0,0, 'Q42740 workaround: credit Ship taken (108920)'),
 (108920,0,1,0, 64,0,100,0, 0,0,0,0, 33, 90918,0,0,0,0,0, 7,0,0,0, 0,0,0,0, 'Q42740 workaround: credit Finale (90918)');

-- 2) Genn Greymane (rendeur 42740, déjà npcflag=3) : juste le spawner au port
DELETE FROM creature WHERE guid=280000204;
INSERT INTO creature
 (guid,id,map,zoneId,areaId,spawnDifficulties,position_x,position_y,position_z,orientation,
  spawntimesecs,MovementType) VALUES
 (280000204,100395,0,1519,4411,'0', -8489, 1086, 17.95, 4.2, 300,0);
