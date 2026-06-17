-- fix - workaraound - quest 14368 save-the-children

UPDATE `creature_template` SET `AIName`='SmartAI', `npcflag`='16777219', `unit_flags`='33536' WHERE  `entry`=36287; 
UPDATE `creature_template` SET `AIName`='SmartAI', `npcflag`='16777219', `unit_flags`='33536' WHERE  `entry`=36288;
UPDATE `creature_template` SET `AIName`='SmartAI', `npcflag`='16777219', `unit_flags`='33536', `MovementType`='1' WHERE  `entry`=36289;

delete FROM `creature_addon` WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `id` IN (36289, 36288, 36287) AND `map`=654 AND `phaseid`=182); 
delete FROM `creature` WHERE `id` IN (36289, 36288, 36287) AND `map`=654 AND `phaseid`=182; 

DELETE FROM `creature` WHERE `guid` IN (801490, 801496, 801486);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) 
VALUES 
(801490, 36287, 654, 4714, 4793, 0, 0, 182, 0, -1, 0, 0, -1987.47, 2508.71, 1.47526, 0.872665, 300, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 25549),
(801496, 36288, 654, 4714, 4793, 0, 0, 182, 0, -1, 0, 0, -1931.61, 2562.29, 12.815, 5.75959, 300, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 25549),
(801486, 36289, 654, 4714, 4793, 0, 0, 182, 0, -1, 0, 0, -1935.49, 2541.38, 1.47525, 4.78220, 300, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, '', 25549);

DELETE FROM `creature_addon` WHERE `guid` IN (801490, 801496, 801486);
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `auras`) 
VALUES 
(801490, 0, 0, 0, 1, 0, 0, 0, 0, ''),
(801496, 0, 0, 0, 1, 0, 0, 0, 0, ''),
(801486, 0, 0, 0, 1, 0, 0, 0, 0, '');

DELETE FROM `creature_text` WHERE `CreatureID` in (36289, 36288, 36287) AND `GroupID`=1;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) 
VALUES
(36287, 1, 1, 'You are scary!  I just want my mommy!', 12, 0, 100, 18, 0, 23508, 0, 0, 'Cynthia to Player'), -- 36325
(36288, 1, 1, 'Are you one of the good worgen, $G mister:ma\'am;?  Did you see Cynthia hiding in the sheds outside?', 12, 0, 100, 0, 0, 23508, 0, 0, 'Ashley to Player'), -- 36326
(36289, 1, 1, 'Don\'t hurt me!  I was just looking for my sisters!  I think Ashley\'s inside that house!', 12, 0, 100, 0, 0, 23508, 0, 0, 'James to Player'); -- 36324

DELETE FROM `creature_text` WHERE `CreatureID` in (36289, 36288, 36287) AND `GroupID`=0;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) 
VALUES
(36287, 0, 1, 'It\'s not safe here. Go to Allen\'s basement.', 12, 0, 100, 0, 0, 0, 0, 0, 'Player to Cynthia'),
(36288, 0, 1, 'Join the others inside the basement next door. Hurry!', 12, 0, 100, 0, 0, 0, 0, 0, 'Player to Ashley'),
(36289, 0, 1, 'Your mother\'s in the basement next door. Get to her now!', 12, 0, 100, 0, 0, 0, 0, 0, 'Player to James');

DELETE FROM `hotfixes`.`broadcast_text` WHERE id IN (36324, 36325, 36326);
INSERT INTO `hotfixes`.`broadcast_text` (`ID`, `Text`, `Text1`, `EmoteID1`, `EmoteID2`, `EmoteID3`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmotesID`, `LanguageID`, `Flags`, `ConditionID`, `SoundEntriesID1`, `SoundEntriesID2`, `VerifiedBuild`) 
VALUES 
(36324, 'Don\'t hurt me!  I was just looking for my sisters!  I think Ashley\'s inside that house!', '', 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 26365),
(36325, '', 'You are scary!  I just want my mommy!', 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 26365),
(36326, '', 'Are you one of the good worgen, $G mister:ma\'am;?  Did you see Cynthia hiding in the sheds outside?', 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 26365);

DELETE FROM `quest_poi` WHERE `QuestID`=14368;
INSERT INTO `quest_poi` (`QuestID`, `BlobIndex`, `Idx1`, `ObjectiveIndex`, `QuestObjectiveID`, `QuestObjectID`, `MapID`, `WorldMapAreaId`, `Floor`, `Priority`, `Flags`, `WorldEffectID`, `PlayerConditionID`, `WoDUnk1`, `AlwaysAllowMergingBlobs`, `VerifiedBuild`) 
VALUES 
(14368, 1, 0, 0, 264863, 36287, 654, 545, 0, 0, 1, 0, 0, 0, 0, 26365),
(14368, 2, 1, 0, 264864, 36288, 654, 545, 0, 0, 1, 0, 0, 0, 0, 25549),
(14368, 3, 2, 0, 264865, 36289, 654, 545, 0, 0, 1, 0, 0, 0, 0, 25549),
(14368, 4, 3, -1, 0, 36291, 654, 545, 0, 0, 1, 0, 0, 0, 0, 25549);

DELETE FROM `quest_poi_points` WHERE  `QuestID`=14368 AND `Idx1`=4 AND `Idx2`=0;