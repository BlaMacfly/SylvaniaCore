-- Couture de Legion, « Un jeu d'enfant... non ? » (38945, Tanithria, Dalaran) : les materiaux de la boutique de
-- Tanithria ne donnaient rien. Repris de LegionCore :
--  * la soie tissee (242633), le fil (242634) et les epines affutees (242686) n'etaient pas poses ;
--  * aucun des objets n'avait de butin (Data1 = 0, gameobject_loot_template vide) ni d'objet de quete (scintillement) ;
--  * 38945 suit 38944 et precede 38946 chez LC (PrevQuestID absents chez nous).
SET @G := (SELECT MAX(guid) FROM gameobject);
DELETE FROM `gameobject` WHERE `id` IN (242633,242634,242686) AND `map`=1220;
INSERT INTO `gameobject` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`,`isActive`,`ScriptName`,`VerifiedBuild`) VALUES
(@G+1,242633,1220,8445,8445,'0',0,0,0,-1,-768.684,4582.86,728.926,1.09553,0,0,0.520782,0.85369,300,0,1,0,'',0),
(@G+2,242686,1220,8445,8445,'0',0,0,0,-1,-773.035,4579.62,727.873,2.98643,0,0,0.996992,0.0775021,300,0,1,0,'',0),
(@G+3,242634,1220,8445,8445,'0',0,0,0,-1,-773.903,4579.09,728.728,3.16326,0,0,0.999941,-0.0108315,300,0,1,0,'',0);

UPDATE `gameobject_template` SET `Data1`=`entry` WHERE `entry` IN (242633,242634,242636,242638);

DELETE FROM `gameobject_loot_template` WHERE `Entry` IN (242633,242634,242636,242638);
INSERT INTO `gameobject_loot_template` (`Entry`,`Item`,`Reference`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(242633,127286,0,100,1,1,0,20,20,'Tanithria''s Silkweave - 38945'),
(242634,127287,0,100,1,1,0,1,1,'Tanithria''s Thread - 38945'),
(242636,127289,0,100,1,1,0,1,1,'Tanithria''s Purple Dye - 38945'),
(242638,127291,0,100,1,1,0,1,1,'Tanithria''s Red Dye - 38945');

DELETE FROM `gameobject_questitem` WHERE `GameObjectEntry` IN (242633,242634,242636,242638);
INSERT INTO `gameobject_questitem` (`GameObjectEntry`,`Idx`,`ItemId`,`VerifiedBuild`) VALUES
(242633,0,127286,0),(242634,0,127287,0),(242636,0,127289,0),(242638,0,127291,0);

UPDATE `quest_template_addon` SET `PrevQuestID`=38944 WHERE `ID`=38945 AND `PrevQuestID`=0;
UPDATE `quest_template_addon` SET `PrevQuestID`=38945 WHERE `ID`=38946 AND `PrevQuestID`=0;
