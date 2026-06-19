-- =====================================================================
-- Quete 39800 "Greymane's Gambit" / "Le stratagème de Grisetête"
-- (suite de 38206). C'est un SCENARIO instancie (vol du Bruleciel vers
-- Stormheim + combat) NON implemente : objectif = credit 113320
-- "Credit - Scenario Complete", rendu a Sky Admiral Rogers entree 90749
-- deja spawnee en STORMHEIM (map 1220, ~3203 3077 440, zone 7541).
--
-- Un scenario ne se reproduit pas en base (framework instancie + C++).
-- BYPASS choisi par le joueur : a l'acceptation de la quete chez Genn
-- (96663), on credite le scenario ET on teleporte le joueur en Stormheim
-- pres de Rogers 90749 pour rendre et continuer.
--
-- Genn (96663) est deja AIName='SmartAI' (fix 38206). On AJOUTE 2 regles
-- sur l'event 19 (ACCEPTED_QUEST 39800) : id 1 credit, id 2 teleport.
-- Effet a chaud via .reload smart_scripts. Perso deja sur la quete :
-- abandonner 39800 puis la reprendre chez Genn (re-declenche accept).
-- Date: 2026-06-19
-- =====================================================================

DELETE FROM smart_scripts WHERE entryorguid=96663 AND source_type=0 AND id IN (1,2);
INSERT INTO smart_scripts
(entryorguid,source_type,id,link,event_type,event_phase_mask,event_chance,event_flags,
 event_param1,event_param2,event_param3,event_param4,event_param5,
 action_type,action_param1,action_param2,action_param3,action_param4,action_param5,action_param6,
 target_type,target_param1,target_param2,target_param3,target_x,target_y,target_z,target_o,comment) VALUES
(96663,0,1,0,19,0,100,0, 39800,0,0,0,0, 33,113320,0,0,0,0,0, 7,0,0,0, 0,0,0,0, 'Greymane Gambit - on accept 39800: credit Scenario Complete (113320)'),
(96663,0,2,0,19,0,100,0, 39800,0,0,0,0, 62,1220,0,0,0,0,0,    7,0,0,0, 3207,3077,440, 3.14, 'Greymane Gambit - on accept 39800: teleport player to Stormheim near Rogers 90749');
