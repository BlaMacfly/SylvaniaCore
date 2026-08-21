-- =====================================================================
-- Caveau des Gardiennes — quête « Arrêtez Gul'dan ! » (38723 / 40253)
-- Objectif 3 : « Crusher & Sledge slain & power taken », crédit 106241.
--
-- AUCUNE source ne l'accordait : vérifié, pas une seule ligne smart_scripts
-- avec action 33 / param 106241 sur tout le serveur. Le code C++ qui le
-- donne (npc_sledge et npc_crusher dans zone_vault_of_wardens.cpp, lignes
-- 556 et 883) n'est PAS rattaché : sur les 26 scripts que déclare ce
-- fichier, UN SEUL est lié en base (npc_vault_of_the_wardens_vampiric_felbat).
-- Tuer Marteau et Pilon ne validait donc rien, et la quête restait bloquée.
--
-- Choix d'implémentation : plutôt que de rattacher les IA C++ — ce qui
-- remplacerait le SmartAI existant de Sledge (7 lignes, gestion de l'aggro
-- et du couple) et de Crusher (1 ligne) — on ajoute simplement le crédit à
-- leur SmartAI. Rien n'est remplacé, et surtout on évite de reconduire la
-- fragilité du C++ : celui-ci accorde le crédit dans DamageTaken aux seuls
-- joueurs présents dans la liste de menace au coup fatal, exactement le
-- motif qui avait bloqué Tyranna sur Mardum (voir commit 7987f07d).
--
-- Cible 18 = SMART_TARGET_PLAYER_DISTANCE : tous les joueurs à 100 m,
-- sans condition de menace. Fonctionne en solo comme en groupe.
--
-- Les deux PNJ l'accordent, comme le fait le C++ d'origine : l'objectif ne
-- demande qu'un crédit, le premier des deux à mourir le donne.
--
-- Identifications vérifiées contre la base (les commentaires de ce fichier
-- source sont peu fiables, mais ces deux-là portent GUID + entrée + nom et
-- concordent) :
--   guid 20542915 -> entrée 92990 « Sledge »  (Marteau)
--   guid 20542912 -> entrée 97632 « Crusher » (Pilon)
--
-- Rechargeable à chaud : reload smart_scripts
-- =====================================================================

DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid` IN (97632,92990) AND `id`=90;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(97632,0,90,0,6,0,100,0,0,0,0,0,33,106241,0,0,0,0,0,18,100,0,0,0,0,0,0,'Crusher - a la mort - credit 106241 (Arretez Guldan)'),
(92990,0,90,0,6,0,100,0,0,0,0,0,33,106241,0,0,0,0,0,18,100,0,0,0,0,0,0,'Sledge - a la mort - credit 106241 (Arretez Guldan)');
