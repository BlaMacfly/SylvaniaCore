-- Siege d'Orgrimmar (carte 1136) - evenement de Galakras et cimetiere.
-- Base : dc_world. Rejouable (DELETE puis INSERT sur des GUID et cles fixes).
-- Signalement 11/10/2026 : « Galakras ne bouge pas », « apres Galakras on meurt en un coup et
-- on reapparait aux Tarides du Nord ».
--
-- Deroulement scripte (instance_siege_of_orgrimmar.cpp, siege_of_orgrimmar_part_2.cpp) :
-- scene 1 des chefs -> 7 canons Kor'kron sabotes (dialogue) -> scene 2 -> dialogue avec
-- Lor'themar (Horde) ou Jaina (Alliance) -> Galakras. Aucun de ces PNJ n'etait pose (absents
-- aussi de LegionCore, notre source de portage) : l'evenement ne pouvait pas commencer et les
-- 7 tireurs d'elite (72261) gardaient la route pour toujours.
-- Sources : base monde alexkulya/pandaria_5.4.8 (canons, Aethas : positions exactes) ;
-- LegionCore (menus de dialogue) ; positions de scene du script pour les chefs (ils parlent
-- sur les navires d'arrivee puis la scene 2 les teleporte aux quais, galakrasNpcPos2).

-- 1. Les 7 canons Kor'kron (npc_siege_of_orgrimmar_korkron_cannon) - positions pandaria_5.4.8
DELETE FROM `creature` WHERE `guid` BETWEEN 290330001 AND 290330012;
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`dynamicflags`,`ScriptName`,`movementmode`,`VerifiedBuild`) VALUES
(290330001,72358,1136,6738,0,'14,15,16,17',0,0,0,-1,0,0,1380.06,-4961.46,0.93234,4.9222,604800,0,0,1,0,0,0,0,0,0,0,'',0,0),
(290330002,72358,1136,6738,0,'14,15,16,17',0,0,0,-1,0,0,1331.97,-5000.61,1.18869,5.01491,604800,0,0,1,0,0,0,0,0,0,0,'',0,0),
(290330003,72358,1136,6738,0,'14,15,16,17',0,0,0,-1,0,0,1281.93,-5011.49,1.222,5.68869,604800,0,0,1,0,0,0,0,0,0,0,'',0,0),
(290330004,72358,1136,6738,0,'14,15,16,17',0,0,0,-1,0,0,1249.06,-5039.08,2.00319,5.04139,604800,0,0,1,0,0,0,0,0,0,0,'',0,0),
(290330005,72358,1136,6738,0,'14,15,16,17',0,0,0,-1,0,0,1399.55,-4931.88,11.3721,4.58533,604800,0,0,1,0,0,0,0,0,0,0,'',0,0),
(290330006,72358,1136,6738,0,'14,15,16,17',0,0,0,-1,0,0,1265.59,-5023.52,1.07554,5.29874,604800,0,0,1,0,0,0,0,0,0,0,'',0,0),
(290330007,72358,1136,6738,0,'14,15,16,17',0,0,0,-1,0,0,1351.58,-4989.4,0.676455,5.33594,604800,0,0,1,0,0,0,0,0,0,0,'',0,0),
-- 2. Chefs Horde : sur le navire d'arrivee Horde, autour du point ou les joueurs sont
--    teleportes (galakrasPlayersPos2[1] = 1767.58 -5265.74 6.97), face a eux.
(290330008,72560,1136,6738,0,'14,15,16,17',0,0,0,-1,0,0,1764.5,-5263.5,6.97,5.65,604800,0,0,1,0,0,0,0,0,0,0,'',0,0),
(290330009,72561,1136,6738,0,'14,15,16,17',0,0,0,-1,0,0,1765.0,-5268.5,6.97,0.82,604800,0,0,1,0,0,0,0,0,0,0,'',0,0),
--    Aethas Sunreaver : il ouvre le Portail mineur (145531) a la scene 1, donc SUR le navire
--    Horde, tourne vers le point d'arrivee des joueurs (la position pandaria_5.4.8 aux quais,
--    utilisee d'abord, ouvrait le portail la-bas : signalement du 11/10 a 22h19).
(290330010,73909,1136,6738,0,'14,15,16,17',0,0,0,-1,0,0,1761.5,-5266.0,6.97,0.0,604800,0,0,1,0,0,0,0,0,0,0,'',0,0),
-- 3. Chefs Alliance : point du navire Alliance du script (galakrasNpcPos2[0]) ; Varian entre
--    Jaina et le point d'arrivee des joueurs (galakrasPlayersPos2[0]).
(290330011,72302,1136,6738,0,'14,15,16,17',0,0,0,-1,0,0,1360.96,-5404.39,10.32,4.89,604800,0,0,1,0,0,0,0,0,0,0,'',0,0),
(290330012,72311,1136,6738,0,'14,15,16,17',0,0,0,-1,0,0,1363.5,-5410.0,10.4,1.59,604800,0,0,1,0,0,0,0,0,0,0,'',0,0);

-- 4. Menus de dialogue (LegionCore). sGossipSelect attend l'option 0 ; le drapeau de dialogue
--    est pose par le script a la scene 2 seulement (npcflag du modele laisse a 0).
DELETE FROM `gossip_menu` WHERE `MenuId` IN (15992, 15803);
INSERT INTO `gossip_menu` (`MenuId`,`TextId`,`VerifiedBuild`) VALUES (15992,23053,0),(15803,22732,0);
DELETE FROM `gossip_menu_option` WHERE `MenuId` IN (72560, 15992, 15803);
INSERT INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES
(72560,0,0,'We are at your disposal.',89462,1,1,0),
(15992,0,0,'We are at your disposal.',89462,1,1,0),
(15803,0,0,'My soldiers are your soldiers, oh my king.',75319,1,1,0);
UPDATE `creature_template` SET `gossip_menu_id` = 72560 WHERE `entry` = 72560;
UPDATE `creature_template` SET `gossip_menu_id` = 15992 WHERE `entry` = 72302;
UPDATE `creature_template` SET `gossip_menu_id` = 15803 WHERE `entry` = 72311;

-- 5. Cimetiere : la zone du Siege (6738) n'en avait aucun (« Zone 6738 Team 67 does not have a
--    linked graveyard ») ; le joueur etait renvoye au cimetiere le plus proche de Kalimdor.
--    LegionCore rattache le cimetiere du raid du Val (4575) a la zone 6738.
DELETE FROM `graveyard_zone` WHERE `ID` = 4575 AND `GhostZone` = 6738;
INSERT INTO `graveyard_zone` (`ID`,`GhostZone`,`Faction`,`Comment`) VALUES (4575,6738,0,'Siege of Orgrimmar - Vale Raid GY');

-- 6. Portail mineur -> quais : le portail (221522) lance 145524 sur le joueur, effet 252 vers
--    une destination en base (TARGET_DEST_DB) qui n'existait pas : le clic ne faisait rien.
--    Destination = « position at the docks » du script (galakrasPlayersPos2[2]) ; l'orientation
--    1.664 est portee par le sort lui-meme.
DELETE FROM `spell_target_position` WHERE `ID` = 145524 AND `EffectIndex` = 0;
INSERT INTO `spell_target_position` (`ID`,`EffectIndex`,`MapID`,`PositionX`,`PositionY`,`PositionZ`,`VerifiedBuild`) VALUES
(145524,0,1136,1440.49,-5015.87,12.11,0);

-- Retour arriere :
-- DELETE FROM `spell_target_position` WHERE `ID` = 145524 AND `EffectIndex` = 0;
-- DELETE FROM `creature` WHERE `guid` BETWEEN 290330001 AND 290330012;
-- DELETE FROM `gossip_menu` WHERE `MenuId` IN (15992, 15803);
-- DELETE FROM `gossip_menu_option` WHERE `MenuId` IN (72560, 15992, 15803);
-- UPDATE `creature_template` SET `gossip_menu_id` = 0 WHERE `entry` IN (72560, 72302, 72311);
-- DELETE FROM `graveyard_zone` WHERE `ID` = 4575 AND `GhostZone` = 6738;
