INSERT INTO `gossip_menu` (`MenuId`, `TextId`, `VerifiedBuild`) VALUES
(19646, 25240, 23420); -- 108527


INSERT INTO `gossip_menu_option` (`MenuId`, `OptionIndex`, `OptionIcon`, `OptionText`, `OptionBroadcastTextId`, `VerifiedBuild`) VALUES
(19646, 0, 32, 'Who\'s looking for a job?', 0, 23420);


INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `comment`) VALUES
(108527, 0, 0, 'While Razelikh is not privy to the Legion\'s current plans, he does know a great deal of magic that can give us an edge.', 12, 0, 100, 1, 0, 0, UNKNOWN, 'Loramus Thalipedes');

UPDATE `creature_template` SET `ScriptName`='npc_illidari_fel_bat_94324' WHERE `entry`=94324;
UPDATE `creature_template` SET `ScriptName`='npc_105155' WHERE `entry`=105155;