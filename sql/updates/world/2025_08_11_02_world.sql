DELETE FROM `creature` WHERE `guid`=450254;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `PhaseId`, `PhaseGroup`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `VerifiedBuild`) VALUES
(450254, 119390, 0, 40, 20, 0, 169, 0, 0, 0, -11059.6, 1562.27, 44.2951, 4.10445, 180, 0, 0, 0, 0, 0, 0, 0, 0, 26124); -- Marcus "Bagman" Brown (Area: -Westfall- - Difficulty: 0);

DELETE FROM `creature_template_addon` WHERE `entry`=119390;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES
(119390, 0, 0, 1, 0, 0, '79116');

UPDATE `creature_template` SET `npcflag`=131 WHERE `entry`=119390;
UPDATE `creature_template` SET `gossip_menu_id`=20871 WHERE `entry`=119390;

DELETE FROM `creature_text` WHERE `CreatureID`=119390;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `comment`) VALUES 
(119390, 0, 0, 'There is a lot of movement within the Deadmines. I suspect the place has been infested with all manner of creatures. Shall we investiga', 12, 0, 100, 1, 0, 0, 127853, 'Marcus "Bagman" Brown');

DELETE FROM `gossip_menu_option` WHERE `MenuID`=20871 AND `OptionIndex`=1;
DELETE FROM `gossip_menu_option` WHERE `MenuID`=20871 AND `OptionIndex`=2;
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionIndex`, `OptionIcon`, `OptionText`, `OptionBroadcastTextId`, `OptionType`, `OptionNpcflag`, `VerifiedBuild`) VALUES
(20871, 1, 0, 'Take me into the Deadmines.', 127852,  1, 1, 26124),
(20871, 2, 1, 'I wish to trade.', 122362,  3, 128, 26124);

DELETE FROM `creature_queststarter` WHERE `id`=119390 AND `quest`=46291;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES
(119390, 46291);

DELETE FROM `creature_questender` WHERE `id`=119390 AND `quest`=46291;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES
(119390, 46291);