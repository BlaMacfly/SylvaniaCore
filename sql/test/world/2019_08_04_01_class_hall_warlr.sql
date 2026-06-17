UPDATE `creature_template` SET `npcflag`=2, `ScriptName`='npc_ritssyn_flamescowl_103506' WHERE `entry`=103506;
DELETE FROM `creature_queststarter` WHERE `id` = '103506';
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES
('103506', '40716');


DELETE FROM `quest_poi` WHERE (`QuestID`=40716 AND `BlobIndex`=1 AND `Idx1`=1);
INSERT INTO `quest_poi` (`QuestID`, `BlobIndex`, `Idx1`, `ObjectiveIndex`, `QuestObjectiveID`, `QuestObjectID`, `MapID`, `WorldMapAreaId`, `Floor`, `Priority`, `Flags`, `WorldEffectID`, `PlayerConditionID`, `WoDUnk1`, `AlwaysAllowMergingBlobs`, `VerifiedBuild`) VALUES
(40716, 1, 1, -1, 0, 0, 1220, 1014, 0, 0, 2, 0, 39611, 0, 0, 26124); -- The Sixth

UPDATE `quest_poi` SET `AlwaysAllowMergingBlobs`=0, `VerifiedBuild`=26124 WHERE (`QuestID`=40716 AND `BlobIndex`=0 AND `Idx1`=0); -- The Sixth
UPDATE `quest_poi` SET `AlwaysAllowMergingBlobs`=0, `VerifiedBuild`=26124 WHERE (`QuestID`=40716 AND `BlobIndex`=0 AND `Idx1`=0); -- The Sixth
UPDATE `quest_poi` SET `AlwaysAllowMergingBlobs`=0, `VerifiedBuild`=26124 WHERE (`QuestID`=40716 AND `BlobIndex`=0 AND `Idx1`=0); -- The Sixth

DELETE FROM `quest_poi_points` WHERE (`QuestID`=40716 AND `Idx1`=1 AND `Idx2`=0) ;
INSERT INTO `quest_poi_points` (`QuestID`, `Idx1`, `Idx2`, `X`, `Y`, `VerifiedBuild`) VALUES
(40716, 1, 0, -853, 4384, 26124); -- The Sixth

DELETE FROM `quest_details` WHERE `ID`=40716;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES
(40716, 0, 0, 0, 0, 0, 0, 0, 0, 26124); -- The Sixth

SET NAMES 'utf8';
SET @GROUP_ID=0,@ID=0;
DELETE FROM `creature_text` WHERE (`CreatureID`=103506);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `comment`) VALUES
(103506, @GROUP_ID+0, @ID+0, 'A moment of your time, warlock. The Council of the Black Harvest requests your assistance.', 12, 0, 100, 1, 0, 61694, 106111, ' to Player');