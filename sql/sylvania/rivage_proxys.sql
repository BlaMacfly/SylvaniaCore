-- =====================================================================
-- Rivage brisé — les cinq « Proxy » qui n'existaient nulle part
--
-- Suite de l'audit du 23/08/2026. Cinq objectifs obligatoires de la
-- chaîne de retour dans les capitales sont des crédits portés par des
-- PNJ déclencheurs invisibles, dont AUCUN n'était posé :
--
--   40517 « Le lion terrassé »
--     obj 1  100419  Proxy - Listen to King Anduin and the Council
--   40522 « Le destin de la Horde »
--     obj 0  100541  Proxy - Meet with Saurfang
--     obj 1  100552  Proxy - Enter Grommash Hold
--     obj 2  100934  Proxy - Learn Fate of the Horde
--     obj 3  100985  Proxy - Speak to the Warchief
--
-- Ces entrées portent déjà le modèle 4626, le modèle invisible standard
-- des déclencheurs : rien à masquer, il suffisait de les poser.
--
-- POSITIONS — toutes issues de `quest_poi_points`, jamais estimées.
-- Chacune a été validée par son voisinage, et le résultat est net :
--   100419 (-8360, 231)   -> Anduin Wrynn à 3,6 m, salle du trône. z 157.07
--   100541 (1606, -4377)  -> rampe de la Vallée de la force ; Grunt et
--                            Héraut du chef de guerre à même altitude. z 21.19
--   100552 (1674, -4341)  -> Garrosh Hellscream à 1,8 m, Saurfang,
--                            Nazgrim et Sauranok à 11 m : c'est bien
--                            l'intérieur de l'Enclos de Grommash. z 29.19
--   100985 (1249, -4380)  -> la Sylvanas 100866 posée hier est à 4,5 m.
--                            Confirmation croisée du placement. z 28.54
--
-- ⚠️ SEULE EXCEPTION : 100934 « Learn Fate of the Horde » n'a AUCUN point
-- d'intérêt dans la table. Il est posé au même endroit que 100985, au
-- motif qu'il est l'objectif immédiatement précédent dans la séquence
-- (entrer dans l'Enclos -> apprendre le destin de la Horde -> prêter
-- serment au chef de guerre) et que les deux se passent devant Sylvanas.
-- C'est le seul placement de ce lot qui ne repose pas sur une donnée.
--
-- MÉCANISME
-- Motif déjà employé et fonctionnel sur ce serveur (Gerk 29455, Burr
-- 29454, Croisé Dargath 29468) : évènement 10 (hors combat, à vue),
-- paramètre 1 = non hostile, portée 20 m, temps de recharge 2 s, puis
-- action 33 qui accorde le crédit à celui qui approche.
-- Portée réduite à 10 m pour 100934 et 100985, qui sont au même endroit :
-- à 20 m ils se déclencheraient tous deux d'un coup et la séquence
-- perdrait son sens.
--
-- `unit_flags` = 33554688 (insensible aux joueurs + non sélectionnable),
-- pour qu'aucun de ces déclencheurs ne puisse être ciblé par erreur.
--
-- ⚠️ REDÉMARRAGE NÉCESSAIRE (table `creature`).
-- =====================================================================

DELETE FROM `creature` WHERE `guid` BETWEEN 290000110 AND 290000114;
INSERT INTO `creature`
 (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,
  `terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,
  `spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,
  `npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`dynamicflags`,`ScriptName`,`movementmode`,`VerifiedBuild`) VALUES
(290000110,100419,0,1519,6292,0,0,0,0,-1,0,0, -8360.0,231.0,157.07,2.25, 300,0,0,1,0,0, 0,33554688,0,0,0,'',0,0),
(290000111,100541,1,1637,5170,0,0,0,0,-1,0,0, 1606.0,-4377.0,21.19,1.12, 300,0,0,1,0,0, 0,33554688,0,0,0,'',0,0),
(290000112,100552,1,1637,5356,0,0,0,0,-1,0,0, 1674.0,-4341.0,29.19,3.59, 300,0,0,1,0,0, 0,33554688,0,0,0,'',0,0),
(290000113,100934,1,14,4982,0,0,0,0,-1,0,0, 1249.0,-4380.0,28.54,1.53, 300,0,0,1,0,0, 0,33554688,0,0,0,'',0,0),
(290000114,100985,1,14,4982,0,0,0,0,-1,0,0, 1249.0,-4380.0,28.54,1.53, 300,0,0,1,0,0, 0,33554688,0,0,0,'',0,0);

-- --- crédit accordé à l'approche ---------------------------------------
UPDATE `creature_template` SET `AIName`='SmartAI'
 WHERE `entry` IN (100419,100541,100552,100934,100985) AND `AIName`='';

DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid` IN (100419,100541,100552,100934,100985);
INSERT INTO `smart_scripts`
 (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,
  `event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`event_param_string`,
  `action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,
  `target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(100419,0,0,0,10,0,100,0, 1,20,2000,2000,0,'', 33,100419,0,0,0,0,0, 7,0,0,0, 0,0,0,0,
 'Proxy Ecouter le roi Anduin - A vue hors combat - Credit (quete 40517)'),
(100541,0,0,0,10,0,100,0, 1,20,2000,2000,0,'', 33,100541,0,0,0,0,0, 7,0,0,0, 0,0,0,0,
 'Proxy Rencontrer Saurfang - A vue hors combat - Credit (quete 40522)'),
(100552,0,0,0,10,0,100,0, 1,20,2000,2000,0,'', 33,100552,0,0,0,0,0, 7,0,0,0, 0,0,0,0,
 'Proxy Entrer dans l Enclos de Grommash - A vue hors combat - Credit (quete 40522)'),
(100934,0,0,0,10,0,100,0, 1,10,2000,2000,0,'', 33,100934,0,0,0,0,0, 7,0,0,0, 0,0,0,0,
 'Proxy Apprendre le destin de la Horde - A vue hors combat - Credit (quete 40522)'),
(100985,0,0,0,10,0,100,0, 1,10,2000,2000,0,'', 33,100985,0,0,0,0,0, 7,0,0,0, 0,0,0,0,
 'Proxy Parler au chef de guerre - A vue hors combat - Credit (quete 40522)');
