-- ============================================================================
-- BYPASS de l'intro Légion scriptée → Dalaran / Îles Brisées. 2026-06-14.
-- ----------------------------------------------------------------------------
-- CONTEXTE : toute l'intro Légion (Bataille pour la Rive Brisée 42740, deuil/
--   couronnement 40517, téléport Dalaran « In the Blink of an Eye » 44663, etc.)
--   est une enfilade de SCÉNARIOS scriptés NON implémentés sur ce core → les
--   joueurs s'y retrouvent bloqués quête après quête. Le contenu Îles Brisées
--   AU-DELÀ est, lui, pleinement peuplé (Dalaran 1220 = 27k créatures, maîtres
--   des vols, Khadgar, portails de zones).
--
-- SOLUTION (choix : bypass) : un PNJ « Émissaire de Khadgar » au port de
--   Hurlevent (là où l'intro coince) téléporte directement le joueur dans la
--   Dalaran flottante (près du maître des vols Aludane Whitecloud) → accès
--   immédiat au contenu fonctionnel, sans subir le tunnel scripté cassé.
--
--   On NE touche PAS aux quêtes d'intro (pas d'arrachage risqué) : le portail
--   offre simplement le chemin qui marche. Les contournements 42782/42740 déjà
--   appliqués restent valides ; 40517 n'a PAS besoin d'être appliqué (superflu
--   sous le bypass).
--
-- Entry custom 900001 (max creature_template <1M = 884978 ; <1M = hors infra).
-- APPLICATION : exécuter ce SQL sur la base world PUIS REDÉMARRER le worldserver.
--   (Un NOUVEAU creature_template ne peut PAS être chargé à chaud : `.reload
--    creature_template` ne fait que MODIFIER l'existant — limite TrinityCore
--    « can not add new creatures without restarting ». Donc restart obligatoire.)
-- ============================================================================

-- 1) Template du PNJ émissaire (modèle Khadgar, gossip, non-attaquable, SmartAI)
DELETE FROM creature_template WHERE entry=900001;
INSERT INTO creature_template
 (entry, name, subname, modelid1, minlevel, maxlevel, faction, npcflag, unit_class, unit_flags, AIName)
VALUES
 (900001, 'Archmage Khadgar', 'Téléporteur', 65834, 110, 110, 35, 1, 1, 768, 'SmartAI');

-- 2) Spawn au port de Hurlevent (embarcadère, près de Recruiter Lee / Genn)
DELETE FROM creature WHERE guid=280000210;
INSERT INTO creature
 (guid, id, map, zoneId, areaId, spawnDifficulties, position_x, position_y, position_z, orientation,
  spawntimesecs, MovementType)
VALUES
 (280000210, 900001, 0, 1519, 4411, '0', -8487, 1090, 17.95, 3.8, 300, 0);

-- 3) Clic (gossip) -> téléport vers Dalaran (map 1220, maître des vols)
--    event 64 = GOSSIP_HELLO ; action 62 = SMART_ACTION_TELEPORT (param1 = mapId)
--    cible 7 = INVOKER (le joueur) ; destination dans target_x/y/z/o
DELETE FROM smart_scripts WHERE source_type=0 AND entryorguid=900001;
INSERT INTO smart_scripts
 (entryorguid,source_type,id,link,event_type,event_phase_mask,event_chance,event_flags,
  event_param1,event_param2,event_param3,event_param4,
  action_type,action_param1,action_param2,action_param3,action_param4,action_param5,action_param6,
  target_type,target_param1,target_param2,target_param3,target_x,target_y,target_z,target_o,comment)
VALUES
 (900001,0,0,0, 64,0,100,0, 0,0,0,0, 62,1220,0,0,0,0,0, 7,0,0,0, -864,4298,745.5,3.0, 'Bypass intro Legion: teleport joueur vers Dalaran');
