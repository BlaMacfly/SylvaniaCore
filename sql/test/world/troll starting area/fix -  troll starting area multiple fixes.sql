-- tikitargets atackable check 37989
UPDATE `creature_template` SET `npcflag`='0' WHERE  `entry`=38038;
UPDATE `creature_template` SET `npcflag`='0' WHERE  `entry`=38142;
UPDATE `creature_template` SET `npcflag`='1' WHERE  `entry`=39062;

-- darkspear jailor 39062 say option only if quest taken
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=10974 AND `ConditionTypeOrReference`=9 AND `ConditionValue1` IN (24754, 24762, 24774, 24780, 24786, 31161, 24642, 24768, 26276);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES 
(15 , 10974 , 0 , 0 , 0 , 9 , 0 , 24754 , 0 , 0 , 0 , 0 , 0 , '' , 'Show gossip option only if quest proove pit 24754 is incomplete'),
(15 , 10974 , 0 , 0 , 0 , 9 , 0 , 24762 , 0 , 0 , 0 , 0 , 0 , '' , 'Show gossip option only if quest proove pit 24754 is incomplete'),
(15 , 10974 , 0 , 0 , 0 , 9 , 0 , 24774 , 0 , 0 , 0 , 0 , 0 , '' , 'Show gossip option only if quest proove pit 24754 is incomplete'),
(15 , 10974 , 0 , 0 , 0 , 9 , 0 , 24780 , 0 , 0 , 0 , 0 , 0 , '' , 'Show gossip option only if quest proove pit 24754 is incomplete'),
(15 , 10974 , 0 , 0 , 0 , 9 , 0 , 24786 , 0 , 0 , 0 , 0 , 0 , '' , 'Show gossip option only if quest proove pit 24754 is incomplete'),
(15 , 10974 , 0 , 0 , 0 , 9 , 0 , 31161 , 0 , 0 , 0 , 0 , 0 , '' , 'Show gossip option only if quest proove pit 24754 is incomplete'),
(15 , 10974 , 0 , 0 , 0 , 9 , 0 , 24642 , 0 , 0 , 0 , 0 , 0 , '' , 'Show gossip option only if quest proove pit 24754 is incomplete'),
(15 , 10974 , 0 , 0 , 0 , 9 , 0 , 24768 , 0 , 0 , 0 , 0 , 0 , '' , 'Show gossip option only if quest proove pit 24754 is incomplete'),
(15 , 10974 , 0 , 0 , 0 , 9 , 0 , 26276 , 0 , 0 , 0 , 0 , 0 , '' , 'Show gossip option only if quest proove pit 24754 is incomplete');

-- darkspear jailor 39062 sai
DELETE FROM `smart_scripts` WHERE `entryorguid`=39062;
DELETE FROM `smart_scripts` WHERE `entryorguid`=-251546;
INSERT INTO `smart_scripts` 
(`entryorguid`, `source_type`, `id`, `link`, 
`event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param_string`, 
`action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, 
`target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(39062 , 0 , 0 , 1 , 62 , 0 , 100 , 0 , 10974 , 0 , 0 , 0 , '', 72 , 0 , 0 , 0 , 0 , 0 , 0 , 7 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 'Darkspear Jailor - On Gossip Option - Close Gossip'),
(39062 , 0 , 1 , 2 , 61 , 0 , 100 , 0 , 0 , 0 , 0 , 0 , '', 53 , 1 , 39062 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 'Darkspear Jailor - Start Waipoints'),
(39062 , 0 , 2 , 3 , 61 , 0 , 100 , 0 , 0 , 0 , 0 , 0 , '', 33 , 39062 , 0 , 0 , 0 , 0 , 0 , 7 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ,' Darkspear Jailor - Update Quest'),
(39062 , 0 , 3 , 4 , 61 , 0 , 100 , 0 , 0 , 0 , 0 , 0 , '', 81 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 'Darkspear Jailor - Link - Remove Gossip Flag'),
(39062 , 0 , 4 , 5 , 61 , 0 , 100 , 0 , 0 , 0 , 0 , 0 , '', 1 , 0 , 0 , 0 , 0 , 0 , 0 , 7 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ,'Darkspear Jailor - Link - Remove Gossip Flag'),
(39062 , 0 , 5 , 0 , 61 , 0 , 100 , 0 , 0 , 0 , 0 , 0 , '', 64 , 1 , 0 , 0 , 0 , 0 , 0 , 7 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 'Darkspear Jailor - Link - Remove Gossip Flag '),
(39062 , 0 , 6 , 0 , 40 , 0 , 100 , 0 , 2 , 39062 , 0 , 0 , '', 80 , 3906200 , 2 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 'Darkspear Jailor - End Waipoints - Start Script 1'), 
(39062 , 0 , 7 , 8 , 38 , 0 , 100 , 0 , 1 , 0 , 0 , 0 , '', 81 , 1 , 0 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 'Darkspear Jailor - Update - Set Orientation 6,19592'),
(39062 , 0 , 8 , 0 , 61 , 0 , 100 , 0 , 0 , 0 , 0 , 0 , '', 1 , 1 , 0 , 0 , 0 , 0 , 0 , 12 , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 'Darkspear Jailor - Update - Set Orientation 6,19592'),
(39062 , 0 , 9 , 0 , 60 , 0 , 100 , 0 , 0 , 0 , 2000 , 3000 , '', 66 , 2 , 0 , 0 , 0 , 0 , 0 , 8 , 0 , 0 , 0 , 0 , 0 , 0 , 1.85005 , 'Darkspear Jailor - Update - Set Orientation 6,19592');

-- darkspear jailor 39062 called time action sai
DELETE FROM `smart_scripts` WHERE `entryorguid`=3906200;
INSERT INTO `smart_scripts` 
(`entryorguid`, `source_type`, `id`, `link`, 
`event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param_string`, 
`action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, 
`target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3906200 , 9 , 0 , 0 , 0 , 0 , 100 , 0 , 150 , 500 , 0 , 0 , '', 9 , 0 , 0 , 0 , 0 , 0 , 0 , 15 , 201968 , 30 , 0 , 0 , 0 , 0 , 0 , 'Darkspear Jailor - Update - Activate Gameobject '),
(3906200 , 9 , 1 , 0 , 0 , 0 , 100 , 0 , 1000 , 1000 , 0 , 0 , '', 45 , 1 , 1 , 0 , 0 , 0 , 0 , 10 , 252672 , 38142 , 0 , 0 , 0 , 0 , 0 , 'Darkspear  Jailor  -  Update  -  Start  Script  (Naga)'), 
(3906200 , 9 , 2 , 0 , 0 , 0 , 100 , 0 , 0 , 0 , 0 , 0 , '', 53 , 0 , 390620 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 'Darkspear  Jailor  -  End  Waipoints  -  Start  Script  1 ');

-- DELETE FROM `smart_scripts` WHERE `entryorguid`=-251547;
-- INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
-- (-251547, 0, 0, 0, 62, 0, 100, 0, 10974, 0, 0, 0, '', 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, ''),
-- (-251547, 0, 1, 0, 62, 0, 100, 512, 10974, 0, 0, 0, '', 33, 39062, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, ''),
-- (-251547, 0, 2, 0, 62, 0, 100, 0, 10974, 0, 0, 0, '', 69, 3, 0, 0, 0, 0, 0, 8, 0, 0, 0, -1155.06, -5516.47, 12.104, 5.451, ''),
-- (-251547, 0, 3, 0, 34, 0, 100, 512, 8, 3, 0, 0, '', 9, 0, 0, 0, 0, 0, 0, 15, 201968, 30, 0, 0, 0, 0, 0, '');


-- darkspear jailor 39062 waypoints
DELETE FROM `waypoints` WHERE `entry`=39062;
DELETE FROM `waypoints` WHERE `entry`=390620;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `point_comment`) VALUES 
(39062 , 1 , -1137.32 , -5429.09 , 13.8884 , 'Darkspear Jailor wp 1 on template'),
(39062 , 2 , -1136.26 , -5416.38 , 13.2695 , 'Darkspear Jailor wp 2 on template'),
(390620 , 1 , -1137.02 , -5428.9 , 13.6873 , 'Darkspear Jailor wp 1'),
(390620 , 2 , -1143.19 , -5429.96 , 13.9727 , 'Darkspear Jailor wp 2'),
(390620 , 3 , -1143.38 , -5429.88 , 13.8519 , 'Darkspear Jailor wp 3');


-- Captive Spitescale Scout 38142 sai
DELETE FROM `smart_scripts` WHERE `entryorguid`=38142;
INSERT INTO `smart_scripts` 
(`entryorguid`, `source_type`, `id`, `link`, 
`event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param_string`, 
`action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, 
`target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(38142 , 0 , 0 , 1 , 11 , 0 , 100 , 0 , 0 , 0 , 0 , 0 , '' , 18 , 898 , 0 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 'Captive Spitescale Scout - Link - Remove Flag Immune To Players'),
(38142 , 0 , 1 , 0 , 61 , 0 , 100 , 0 , 0 , 0 , 0 , 0 , '' , 32 , 0 , 0 , 0 , 0 , 0 , 0 , 20 , 201968 , 30 , 0 , 0 , 0 , 0 , 0 , 'Captive Spitescale Scout - On Respawn - Reset Cage'),
(38142 , 0 , 2 , 3 , 6 , 0 , 100 , 0 , 0 , 0 , 0 , 0 , '' , 45 , 1 , 0 , 0 , 0 , 0 , 0 , 19 , 39062 , 35 , 0 , 0 , 0 , 0 , 0 , 'Captive Spitescale Scout - On Death - Set Data 1-0 to Jailor'),
(38142 , 0 , 3 , 0 , 61 , 0 , 100 , 0 , 0 , 0 , 0 , 0 , '' , 1 , 1 , 0 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 'Captive Spitescale Scout - On Death - Set Data 1-0 to Jailor'),
(38142 , 0 , 4 , 0 , 38 , 0 , 100 , 0 , 1 , 1 , 0 , 0 , '' , 69 , 1 , 0 , 0 , 0 , 0 , 0 , 8 , 0 , 0 , 0 , -1145.49 , -5415.47 , 10.5983 , 0, 'Captive Spitescale Scout - Update - Move Forward'),
(38142 , 0 , 5 , 6 , 34 , 0 , 100 , 0 , 8 , 1 , 0 , 0 , '' , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 'Captive Spitescale Scout - On Movement Inform - Say Line 0'),
(38142 , 0 , 6 , 7 , 61 , 0 , 100 , 0 , 0 , 0 , 0 , 0 , '' , 19 , 898 , 0 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 'Captive Spitescale Scout - Update - Return Gossip Flag to Jailor'),
(38142 , 0 , 7 , 0 , 61 , 0 , 100 , 0 , 0 , 0 , 0 , 0 , '' , 101 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 'Captive Spitescale Scout - Link - Set Home Pos'),
(38142 , 0 , 8 , 0 , 11 , 0 , 100 , 0 , 0 , 0 , 0 , 0 , '' , 59 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 'Captive Spitescale Scout - Link - Set Home Pos');
-- (38142 , 0 , 9 , 0 , 0 , 0 , 100 , 1 , 1000 , 1000 , 2000 , 2000, '' , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 'Captive Spitescale Scout - in combat update - Say Line 0');

-- cleanup unneeded stuff
DELETE FROM `waypoints` WHERE `entry`=2515460;
DELETE FROM `smart_scripts` WHERE `entryorguid`=-25154600;
DELETE FROM `smart_scripts` WHERE `entryorguid`=25154600;
DELETE FROM `smart_scripts` WHERE `entryorguid`=-251546;
DELETE FROM `creature_queststarter` WHERE `id` IN (39062) AND `quest` IN (24754, 24762, 24774, 24780, 24786, 31161, 24642, 24768, 26276);

-- gossip corections troll starting area
DELETE FROM `gossip_menu_option` WHERE `MenuId`IN (11127, 11131) AND `OptionIndex`=0;
INSERT INTO `gossip_menu_option` (`MenuId`, `OptionIndex`, `OptionIcon`, `OptionText`, `OptionBroadcastTextId`, `OptionType`, `OptionNpcFlag`, `VerifiedBuild`) VALUES 
(11127, 0, 0, 'You spoke of communing with Thrall?  Did I miss it?', 38946, 1, 1, 0),
(11131, 0, 0, 'Yes.  Do you have a raptor that can take me there?', 38979, 1, 1, 0);

UPDATE `creature_template_addon` SET `bytes2`='1', `auras`='' WHERE  `entry`=38442;

DELETE FROM `quest_offer_reward` WHERE `ID`=25073;
INSERT INTO `quest_offer_reward` 
(`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES 
(25073, 0, 0, 0, 0, 0, 0, 0, 0, 'Welcome, young $R.

Ya come highly recommended, mon. It\'s nice ta finally be meetin\' ya in person.', 0);

