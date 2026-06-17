INSERT INTO `gossip_menu_option` (`MenuId`, `OptionIndex`, `OptionIcon`, `OptionText`, `OptionBroadcastTextId`) VALUES
(100192, 0, 0, 'Мы снова будем пить из колодца', 0);

UPDATE `creature_template` SET `gossip_menu_id`=100192, `ScriptName`='' WHERE `entry`=100192; 

UPDATE  `gossip_menu_option` SET `OptionType`=1, `OptionNpcFlag`=1, `VerifiedBuild`=26124 WHERE (`MenuId`=100192 AND `OptionIndex`=0);

INSERT INTO `gossip_menu_option` (`MenuId`, `OptionIndex`, `OptionIcon`, `OptionText`, `OptionBroadcastTextId`) VALUES
(100192, 0, 0, 'Мы снова будем пить из колодца', 0);



quest 42792
UPDATE `creature_template` SET `gossip_menu_id`=107350 WHERE `entry`=107350; 
INSERT INTO `gossip_menu_option` (`MenuId`, `OptionIndex`, `OptionIcon`, `OptionText`, `OptionBroadcastTextId`) VALUES
(107350, 0, 0, 'The owl hoots at dusk.', 0);
UPDATE  `gossip_menu_option` SET `OptionType`=1, `OptionNpcFlag`=1, `VerifiedBuild`=26124 WHERE (`MenuId`=107350 AND `OptionIndex`=0);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `comment`) VALUES
(107350, 0, 0, 'Say no more', 12, 0, 100, 0, 0, 0, 0, '');

UPDATE `creature_template` SET `gossip_menu_id`=107349 WHERE `entry`=107349; 
INSERT INTO `gossip_menu_option` (`MenuId`, `OptionIndex`, `OptionIcon`, `OptionText`, `OptionBroadcastTextId`) VALUES
(107349, 0, 0, 'The saber prowls the palza.', 0);
UPDATE  `gossip_menu_option` SET `OptionType`=1, `OptionNpcFlag`=1, `VerifiedBuild`=26124 WHERE (`MenuId`=107349 AND `OptionIndex`=0);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `comment`) VALUES
(107349, 0, 0, 'Very well', 12, 0, 100, 0, 0, 0, 0, '');


UPDATE `creature_template` SET `gossip_menu_id`=107348 WHERE `entry`=107348; 
INSERT INTO `gossip_menu_option` (`MenuId`, `OptionIndex`, `OptionIcon`, `OptionText`, `OptionBroadcastTextId`) VALUES
(107348, 0, 0, 'The cruel cpskmaster has breathed hes last.', 0);
UPDATE  `gossip_menu_option` SET `OptionType`=1, `OptionNpcFlag`=1, `VerifiedBuild`=26124 WHERE (`MenuId`=107348 AND `OptionIndex`=0);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `comment`) VALUES
(107348, 0, 0, 'Understood', 12, 0, 100, 0, 0, 0, 0, '');

UPDATE `creature_template` SET `gossip_menu_id`=107225 WHERE `entry`=107225; 
INSERT INTO `gossip_menu_option` (`MenuId`, `OptionIndex`, `OptionIcon`, `OptionText`, `OptionBroadcastTextId`) VALUES
(107225, 0, 0, '<Show your Sigill.>', 0);
UPDATE  `gossip_menu_option` SET `OptionType`=1, `OptionNpcFlag`=1, `VerifiedBuild`=26124 WHERE (`MenuId`=107225 AND `OptionIndex`=0);
