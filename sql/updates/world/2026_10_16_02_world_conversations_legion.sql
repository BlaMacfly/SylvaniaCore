-- Conversations de quetes Legion (AshamaneCore, donnees relevees en 7.3.5 build 26972) : la conversation se lance a
-- l acceptation de la quete. Tables indexees par numero de quete / conversation / PNJ uniquement.

-- AshamaneCore be26247df2 : DB/SAI: Conversation for The Legion Returns Alliance
-- Conversation for Legion Returns

UPDATE `quest_template_addon` SET `ScriptName`='SmartQuest' WHERE `id`=40519;

DELETE FROM `conversation_actors` WHERE `ConversationId`=2507;
INSERT INTO `conversation_actors` (`ConversationId`, `ConversationActorId`, `Idx`, `VerifiedBuild`) VALUES
(2507, 53609, 0, 26972);

DELETE FROM `conversation_actor_template` WHERE `Id`=53609;
INSERT INTO `conversation_actor_template` (`Id`, `CreatureId`, `CreatureModelId`, `VerifiedBuild`) VALUES
(53609, 108589, 70626, 26972);

DELETE FROM `conversation_line_template` WHERE `Id`=5310;
INSERT INTO `conversation_line_template` (`Id`, `StartTime`, `UiCameraID`, `ActorIdx`, `Flags`, `VerifiedBuild`) VALUES
(5310, 0, 82, 0, 0, 26972);

DELETE FROM `conversation_template` WHERE `Id`=2507;
INSERT INTO `conversation_template` (`Id`, `FirstLineID`, `LastLineEndTime`, `VerifiedBuild`) VALUES
(2507, 5310, 19211, 26972);

DELETE FROM `smart_scripts` WHERE `entryorguid`=40519;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(40519, 5, 0, 0, 47, 0, 100, 0, 40519, 0, 0, 0, 0, '', 143, 2507, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Quest Taken - Push Conversation');

-- AshamaneCore 430a1482bd : DB/Quest: Blink of an Eye.
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=101004;



DELETE FROM `smart_scripts` WHERE `entryorGuid`=44663;

DELETE FROM `smart_scripts` WHERE `entryOrGuid` = 101004;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(101004, 0, 0, 0, 19, 0, 100, 0, 44663, 0, 0, 0, 0, 143, 3827, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On quest accepted - Player who accepted: Start conversation 3827');

-- (Felstorm s Plea 41035 ecartee : sa conversation 1263 n existe pas chez nous)

-- AshamaneCore f49af06674 : DB/Conversation: The Dreadlords prize
-- conversation The Dreadlords prize

DELETE FROM `conversation_template` WHERE `Id`=3364;
INSERT INTO `conversation_template` (`Id`, `FirstLineID`, `LastLineEndTime`, `VerifiedBuild`) VALUES
(3364, 7069, 25979, 26365);

DELETE FROM `conversation_line_template` WHERE `Id` IN (7069, 7070, 7071, 7079);
INSERT INTO `conversation_line_template` (`Id`, `StartTime`, `UiCameraID`, `ActorIdx`, `Flags`, `VerifiedBuild`) VALUES
(7069, 0, 0, 0, 0, 26365),
(7070, 4733, 0, 0, 256, 26365),
(7071, 11355, 0, 0, 0, 26365),
(7079, 17638, 0, 0, 0, 26365);

DELETE FROM `conversation_actors` WHERE `ConversationId`=3364;
INSERT INTO `conversation_actors` (`ConversationId`, `ConversationActorId`, `Idx`, `VerifiedBuild`) VALUES
(3364, 51396, 0, 26365);

-- Dreadlords Prize
SET @ENTRY := 41036;
UPDATE `quest_template_addon` SET `ScriptName` = 'SmartQuest' WHERE `ID` = @ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type` = 5 AND `entryOrGuid` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ENTRY, 5, 0, 0, 47, 0, 100, 0, 0, 0, 0, 0, 0, 143, 3364, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On quest accepted - Player who accepted: Start conversation 3364');

-- AshamaneCore 6f97f3c1a5 : DB/Conversation: An Audience with the king.
DELETE FROM `conversation_actors` WHERE (`Idx`=0 AND `ConversationId` IN (745));
INSERT INTO `conversation_actors` (`ConversationId`, `ConversationActorId`, `ConversationActorGuid`, `Idx`, `VerifiedBuild`) VALUES
(745, 48432, 0, 0, 26972);

DELETE FROM `conversation_actor_template` WHERE `Id` IN (48432);
INSERT INTO `conversation_actor_template` (`Id`, `CreatureId`, `CreatureModelId`, `VerifiedBuild`) VALUES
(48432, 99456, 64011, 26972);

DELETE FROM `conversation_line_template` WHERE `Id` IN (1774);
INSERT INTO `conversation_line_template` (`Id`, `StartTime`, `UiCameraID`, `ActorIdx`, `Flags`, `VerifiedBuild`) VALUES
(1774, 0, 270, 0, 0, 26972);

DELETE FROM `conversation_template` WHERE `Id` IN (745);
INSERT INTO `conversation_template` (`Id`, `FirstLineID`, `LastLineEndTime`, `ScriptName`, `VerifiedBuild`) VALUES
(745, 1774, 10065, '', 26972);

DELETE FROM `smart_scripts` WHERE `entryorguid` = 40714 AND `source_type` = 5;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(40714, 5, 0, 0, 47, 0, 100, 0, 0, 0, 0, 0, 0, 143, 745, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On Quest Pushed - Start Conversation");

DELETE FROM `quest_template_addon` WHERE `ID` = 40714;
INSERT INTO `quest_template_addon` (`ID`, `ScriptName`) VALUES 
(40714, 'SmartQuest');

