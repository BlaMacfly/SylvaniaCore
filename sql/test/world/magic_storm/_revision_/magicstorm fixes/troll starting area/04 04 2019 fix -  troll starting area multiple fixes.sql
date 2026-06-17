-- tikitargets atackable check 37989
UPDATE `creature_template` SET `npcflag`='0' WHERE  `entry`=38038;
UPDATE `creature_template` SET `npcflag`='0' WHERE  `entry`=38142;
UPDATE `creature_template` SET `npcflag`='1' WHERE  `entry`=39062;
UPDATE `creature` SET `npcflag`='0' WHERE  `id`=39062;

--  darkspear jailor 39062 broadcast_text reference 37885
DELETE FROM `gossip_menu_option` WHERE `MenuId`=10974 AND `OptionIndex`=0;
INSERT INTO `gossip_menu_option` (`MenuId`, `OptionIndex`, `OptionIcon`, `OptionText`, `OptionBroadcastTextId`, `OptionType`, `OptionNpcFlag`, `VerifiedBuild`) VALUES 
(10974, 0, 0, 'I\'m ready to face my challenge.', 37885, 1, 1, 0); -- broadcast_text 37885

-- darkspear jailor 39062 say option only if quest taken
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=10974;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES 
(15 , 10974 , 0 , 0 , 1 , 9 , 0 , 24754 , 0 , 0 , 0 , 0 , 0 , '' , 'Show gossip option only if quest proove pit 24754 is taken'),
(15 , 10974 , 0 , 0 , 2 , 9 , 0 , 24762 , 0 , 0 , 0 , 0 , 0 , '' , 'Show gossip option only if quest proove pit 24754 is taken'),
(15 , 10974 , 0 , 0 , 3 , 9 , 0 , 24774 , 0 , 0 , 0 , 0 , 0 , '' , 'Show gossip option only if quest proove pit 24754 is taken'),
(15 , 10974 , 0 , 0 , 4 , 9 , 0 , 24780 , 0 , 0 , 0 , 0 , 0 , '' , 'Show gossip option only if quest proove pit 24754 is taken'),
(15 , 10974 , 0 , 0 , 5 , 9 , 0 , 24786 , 0 , 0 , 0 , 0 , 0 , '' , 'Show gossip option only if quest proove pit 24754 is taken'),
(15 , 10974 , 0 , 0 , 6 , 9 , 0 , 31161 , 0 , 0 , 0 , 0 , 0 , '' , 'Show gossip option only if quest proove pit 24754 is taken'),
(15 , 10974 , 0 , 0 , 7 , 9 , 0 , 24642 , 0 , 0 , 0 , 0 , 0 , '' , 'Show gossip option only if quest proove pit 24754 is taken'),
(15 , 10974 , 0 , 0 , 8 , 9 , 0 , 24768 , 0 , 0 , 0 , 0 , 0 , '' , 'Show gossip option only if quest proove pit 24754 is taken'),
(15 , 10974 , 0 , 0 , 9 , 9 , 0 , 26276 , 0 , 0 , 0 , 0 , 0 , '' , 'Show gossip option only if quest proove pit 24754 is taken');

-- darkspear jailor 39062 sai
DELETE FROM `smart_scripts` WHERE `entryorguid`=39062;
DELETE FROM `smart_scripts` WHERE `entryorguid`=-251546;
DELETE FROM `smart_scripts` WHERE `entryorguid`=-251547;
INSERT INTO `smart_scripts` 
(`entryorguid`, `source_type`, `id`, `link`, 
`event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param_string`, 
`action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, 
`target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
-- darkspear jailor guid 251546
(-251546 , 0 , 0 , 1 , 62 , 0 , 100 , 0 , 10974 , 0 , 0 , 0 , '', 72 , 0 , 0 , 0 , 0 , 0 , 0 , 7 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 'Darkspear Jailor 1 - On Gossip Option - Close Gossip'),
(-251546 , 0 , 1 , 2 , 61 , 0 , 100 , 0 , 0 , 0 , 0 , 0 , '', 53 , 1 , 390620 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 'Darkspear Jailor 1 - Start Waipoints'),
(-251546 , 0 , 2 , 3 , 61 , 0 , 100 , 0 , 0 , 0 , 0 , 0 , '', 33 , 39062 , 0 , 0 , 0 , 0 , 0 , 7 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ,' Darkspear Jailor 1 - Update Quest'),
(-251546 , 0 , 3 , 4 , 61 , 0 , 100 , 0 , 0 , 0 , 0 , 0 , '', 81 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 'Darkspear Jailor 1 - Link - Remove Gossip Flag'),
(-251546 , 0 , 4 , 5 , 61 , 0 , 100 , 0 , 0 , 0 , 0 , 0 , '', 1 , 0 , 0 , 0 , 0 , 0 , 0 , 7 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ,'Darkspear Jailor 1 - Link - Remove Gossip Flag'),
(-251546 , 0 , 5 , 0 , 61 , 0 , 100 , 0 , 0 , 0 , 0 , 0 , '', 64 , 1 , 0 , 0 , 0 , 0 , 0 , 7 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 'Darkspear Jailor 1 - Link - Remove Gossip Flag '),
(-251546 , 0 , 6 , 0 , 40 , 0 , 100 , 0 , 2 , 390620 , 0 , 0 , '', 80 , 3906200 , 2 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 'Darkspear Jailor 1 - End Waipoints - Start Script 1'), 
(-251546 , 0 , 7 , 8 , 38 , 0 , 100 , 0 , 1 , 0 , 0 , 0 , '', 81 , 1 , 0 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 'Darkspear Jailor 1 - Update - Set Orientation 6,19592'),
(-251546 , 0 , 8 , 0 , 61 , 0 , 100 , 0 , 0 , 0 , 0 , 0 , '', 1 , 1 , 0 , 0 , 0 , 0 , 0 , 12 , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 'Darkspear Jailor 1 - Update - Set Orientation 6,19592'),
(-251546 , 0 , 9 , 0 , 60 , 0 , 100 , 0 , 0 , 0 , 2000 , 3000 , '', 66 , 2 , 0 , 0 , 0 , 0 , 0 , 8 , 0 , 0 , 0 , 0 , 0 , 0 , 1.85005 , 'Darkspear Jailor 1 - Update - Set Orientation 6,19592'),
-- darkspear jailor guid 251547
(-251547 , 0 , 0 , 1 , 62 , 0 , 100 , 0 , 10974 , 0 , 0 , 0 , '', 72 , 0 , 0 , 0 , 0 , 0 , 0 , 7 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 'Darkspear Jailor 2 - On Gossip Option - Close Gossip'),
(-251547 , 0 , 1 , 2 , 61 , 0 , 100 , 0 , 0 , 0 , 0 , 0 , '', 53 , 1 , 390622 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 'Darkspear Jailor 2 - Start Waipoints'),
(-251547 , 0 , 2 , 3 , 61 , 0 , 100 , 0 , 0 , 0 , 0 , 0 , '', 33 , 39062 , 0 , 0 , 0 , 0 , 0 , 7 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ,' Darkspear Jailor 2 - Update Quest'),
(-251547 , 0 , 3 , 4 , 61 , 0 , 100 , 0 , 0 , 0 , 0 , 0 , '', 81 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 'Darkspear Jailor 2 - Link - Remove Gossip Flag'),
(-251547 , 0 , 4 , 5 , 61 , 0 , 100 , 0 , 0 , 0 , 0 , 0 , '', 1 , 0 , 0 , 0 , 0 , 0 , 0 , 7 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ,'Darkspear Jailor 2 - Link - Remove Gossip Flag'),
(-251547 , 0 , 5 , 0 , 61 , 0 , 100 , 0 , 0 , 0 , 0 , 0 , '', 64 , 1 , 0 , 0 , 0 , 0 , 0 , 7 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 'Darkspear Jailor 2 - Link - Remove Gossip Flag '),
(-251547 , 0 , 6 , 0 , 40 , 0 , 100 , 0 , 2 , 390622 , 0 , 0 , '', 80 , 3906201 , 2 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 'Darkspear Jailor 2 - End Waipoints - Start Script 1'), 
(-251547 , 0 , 7 , 8 , 38 , 0 , 100 , 0 , 1 , 0 , 0 , 0 , '', 81 , 1 , 0 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 'Darkspear Jailor 2 - Update - Set Orientation 6,19592'),
(-251547 , 0 , 8 , 0 , 61 , 0 , 100 , 0 , 0 , 0 , 0 , 0 , '', 1 , 1 , 0 , 0 , 0 , 0 , 0 , 12 , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 'Darkspear Jailor 2 - Update - Set Orientation 6,19592'),
(-251547 , 0 , 9 , 0 , 60 , 0 , 100 , 0 , 0 , 0 , 2000 , 3000 , '', 66 , 2 , 0 , 0 , 0 , 0 , 0 , 8 , 0 , 0 , 0 , 0 , 0 , 0 , 6.19592 , 'Darkspear Jailor 2 - Update - Set Orientation 6,19592');

-- darkspear jailor 39062 called time action sai
DELETE FROM `smart_scripts` WHERE `entryorguid`=3906200;
DELETE FROM `smart_scripts` WHERE `entryorguid`=3906201;
INSERT INTO `smart_scripts` 
(`entryorguid`, `source_type`, `id`, `link`, 
`event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param_string`, 
`action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, 
`target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
-- darkspear jailor guid 251546
(3906200 , 9 , 0 , 0 , 0 , 0 , 100 , 0 , 150 , 500 , 0 , 0 , '', 9 , 0 , 0 , 0 , 0 , 0 , 0 , 15 , 201968 , 30 , 0 , 0 , 0 , 0 , 0 , 'Darkspear Jailor - Update - Activate Gameobject '),
(3906200 , 9 , 1 , 0 , 0 , 0 , 100 , 0 , 1000 , 1000 , 0 , 0 , '', 45 , 1 , 1 , 0 , 0 , 0 , 0 , 10 , 252672 , 38142 , 0 , 0 , 0 , 0 , 0 , 'Darkspear  Jailor  -  Update  -  Start  Script  (Naga)'), 
(3906200 , 9 , 2 , 0 , 0 , 0 , 100 , 0 , 0 , 0 , 0 , 0 , '', 53 , 0 , 390621 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 'Darkspear  Jailor  -  End  Waipoints  -  Start  Script  1 '),
-- darkspear jailor guid 251547
(3906201 , 9 , 0 , 0 , 0 , 0 , 100 , 0 , 150 , 500 , 0 , 0 , '', 9 , 0 , 0 , 0 , 0 , 0 , 0 , 15 , 201968 , 30 , 0 , 0 , 0 , 0 , 0 , 'Darkspear Jailor - Update - Activate Gameobject '),
(3906201 , 9 , 1 , 0 , 0 , 0 , 100 , 0 , 1000 , 1000 , 0 , 0 , '', 45 , 1 , 1 , 0 , 0 , 0 , 0 , 10 , 252630 , 38142 , 0 , 0 , 0 , 0 , 0 , 'Darkspear  Jailor  -  Update  -  Start  Script  (Naga)'), 
(3906201 , 9 , 2 , 0 , 0 , 0 , 100 , 0 , 0 , 0 , 0 , 0 , '', 53 , 0 , 390623 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 'Darkspear  Jailor  -  End  Waipoints  -  Start  Script  1 ');

-- darkspear jailor 39062 waypoints
DELETE FROM `waypoints` WHERE `entry`=39062;
DELETE FROM `waypoints` WHERE `entry`=390620;
DELETE FROM `waypoints` WHERE `entry`=390621;
DELETE FROM `waypoints` WHERE `entry`=390622;
DELETE FROM `waypoints` WHERE `entry`=390623;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `point_comment`) VALUES 
-- darkspear jailor guid 251546
(390620 , 1 , -1137.43 , -5430.57 , 13.640 , 'Darkspear Jailor 1 wp 1 middle to cage'),
(390620 , 2 , -1136.31 , -5417.10 , 13.270 , 'Darkspear Jailor 1 wp 2 near cage'),
(390621 , 1 , -1137.43 , -5430.57 , 13.640 , 'Darkspear Jailor 1 wp 1 middle from cage'),
(390621 , 2 , -1143.19 , -5429.96 , 13.9727 , 'Darkspear Jailor 1 wp 2 origin from cage'),
-- darkspear jailor guid 251547
(390622 , 1 , -1159.22 , -5519.43 , 12.128 , 'Darkspear Jailor 2 wp 1 middle to cage'),
(390622 , 2 , -1152.79 , -5519.02 , 11.984 , 'Darkspear Jailor 2 wp 2 near cage'),
(390623 , 1 , -1159.22 , -5519.43 , 12.128 , 'Darkspear Jailor 2 wp 1 middle from cage'),
(390623 , 2 , -1159.28 , -5530.03 , 11.9796 , 'Darkspear Jailor 2 wp 2 origin from cage');

-- Captive Spitescale Scout 38142 sai
DELETE FROM `smart_scripts` WHERE `entryorguid`=38142;
DELETE FROM `smart_scripts` WHERE `entryorguid`=-252672;
DELETE FROM `smart_scripts` WHERE `entryorguid`=-252630;
INSERT INTO `smart_scripts` 
(`entryorguid`, `source_type`, `id`, `link`, 
`event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param_string`, 
`action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, 
`target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
-- Captive Spitescale Scout 252672
(-252672 , 0 , 0 , 1 , 11 , 0 , 100 , 0 , 0 , 0 , 0 , 0 , '' , 18 , 898 , 0 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 'Captive Spitescale Scout - Link - Remove Flag Immune To Players'),
(-252672 , 0 , 1 , 0 , 61 , 0 , 100 , 0 , 0 , 0 , 0 , 0 , '' , 32 , 0 , 0 , 0 , 0 , 0 , 0 , 20 , 201968 , 30 , 0 , 0 , 0 , 0 , 0 , 'Captive Spitescale Scout - On Respawn - Reset Cage'),
(-252672 , 0 , 2 , 3 , 6 , 0 , 100 , 0 , 0 , 0 , 0 , 0 , '' , 45 , 1 , 0 , 0 , 0 , 0 , 0 , 19 , 39062 , 35 , 0 , 0 , 0 , 0 , 0 , 'Captive Spitescale Scout - On Death - Set Data 1-0 to Jailor'),
(-252672 , 0 , 3 , 0 , 61 , 0 , 100 , 0 , 0 , 0 , 0 , 0 , '' , 1 , 1 , 0 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 'Captive Spitescale Scout - On Death - Set Data 1-0 to Jailor'),
(-252672 , 0 , 4 , 0 , 38 , 0 , 100 , 0 , 1 , 1 , 0 , 0 , '' , 69 , 1 , 0 , 0 , 0 , 0 , 0 , 8 , 0 , 0 , 0 , -1145.49 , -5415.47 , 10.5983 , 5.067, 'Captive Spitescale Scout - Update - Move Forward'),
(-252672 , 0 , 5 , 6 , 34 , 0 , 100 , 0 , 8 , 1 , 0 , 0 , '' , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 'Captive Spitescale Scout - On Movement Inform - Say Line 0'),
(-252672 , 0 , 6 , 7 , 61 , 0 , 100 , 0 , 0 , 0 , 0 , 0 , '' , 19 , 898 , 0 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 'Captive Spitescale Scout - Update - Return Gossip Flag to Jailor'),
(-252672 , 0 , 7 , 0 , 61 , 0 , 100 , 0 , 0 , 0 , 0 , 0 , '' , 101 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 'Captive Spitescale Scout - Link - Set Home Pos'),
(-252672 , 0 , 8 , 0 , 11 , 0 , 100 , 0 , 0 , 0 , 0 , 0 , '' , 59 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 'Captive Spitescale Scout - Link - Set Home Pos'),
-- Captive Spitescale Scout 252630
(-252630 , 0 , 0 , 1 , 11 , 0 , 100 , 0 , 0 , 0 , 0 , 0 , '' , 18 , 898 , 0 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 'Captive Spitescale Scout - Link - Remove Flag Immune To Players'),
(-252630 , 0 , 1 , 0 , 61 , 0 , 100 , 0 , 0 , 0 , 0 , 0 , '' , 32 , 0 , 0 , 0 , 0 , 0 , 0 , 20 , 201968 , 30 , 0 , 0 , 0 , 0 , 0 , 'Captive Spitescale Scout - On Respawn - Reset Cage'),
(-252630 , 0 , 2 , 3 , 6 , 0 , 100 , 0 , 0 , 0 , 0 , 0 , '' , 45 , 1 , 0 , 0 , 0 , 0 , 0 , 19 , 39062 , 35 , 0 , 0 , 0 , 0 , 0 , 'Captive Spitescale Scout - On Death - Set Data 1-0 to Jailor'),
(-252630 , 0 , 3 , 0 , 61 , 0 , 100 , 0 , 0 , 0 , 0 , 0 , '' , 1 , 1 , 0 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 'Captive Spitescale Scout - On Death - Set Data 1-0 to Jailor'),
(-252630 , 0 , 4 , 0 , 38 , 0 , 100 , 0 , 1 , 1 , 0 , 0 , '' , 69 , 1 , 0 , 0 , 0 , 0 , 0 , 8 , 0 , 0 , 0 , -1146.75 , -5530.90 , 08.106 , 2.982, 'Captive Spitescale Scout - Update - Move Forward'),
(-252630 , 0 , 5 , 6 , 34 , 0 , 100 , 0 , 8 , 1 , 0 , 0 , '' , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 'Captive Spitescale Scout - On Movement Inform - Say Line 0'),
(-252630 , 0 , 6 , 7 , 61 , 0 , 100 , 0 , 0 , 0 , 0 , 0 , '' , 19 , 898 , 0 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 'Captive Spitescale Scout - Update - Return Gossip Flag to Jailor'),
(-252630 , 0 , 7 , 0 , 61 , 0 , 100 , 0 , 0 , 0 , 0 , 0 , '' , 101 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 'Captive Spitescale Scout - Link - Set Home Pos'),
(-252630 , 0 , 8 , 0 , 11 , 0 , 100 , 0 , 0 , 0 , 0 , 0 , '' , 59 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 'Captive Spitescale Scout - Link - Set Home Pos');

-- cleanup unneeded stuff
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

-- quest=25037 crab-fishin
DELETE FROM `quest_request_items` WHERE `ID`=25037;
INSERT INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) VALUES 
(25037, 0, 0, 0, 0, 'Da sea be offerin\' few boons as delicious as fresh crawler meat.', 26365);

DELETE FROM `quest_request_items_locale` WHERE `ID`=25037 AND `locale`='ruRU';
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES 
(25037, 'ruRU', 'Крабовое мясо – один из лучших даров моря.', 0);

-- corect order quest 26277 more then expected adn 25064 Moraya

/*
-- search for garrosh and voljin talk event

SELECT * FROM creature_template WHERE entry IN (38966, 38938, 38953);
SELECT * FROM smart_scripts WHERE entryorguid IN (38966, 38938, 38953, 3896600, 3893800, 3895300);
SELECT * FROM gossip_menu WHERE menuid IN (11127);
SELECT * FROM npc_text WHERE id IN (15468);
SELECT * FROM creature_text WHERE creatureid IN (38966, 38938, 38953);
SELECT * FROM gossip_menu_option WHERE menuid IN (11127);
SELECT * FROM hotfixes. broadcast_text WHERE id IN (38910, 38946);

SELECT * from quest_template where id IN (26277, 25064);
SELECT * from quest_template_addon where id IN (26277, 25064);
SELECT * from conditions where conditionvalue1 IN (26277);
*/

UPDATE `quest_template_addon` SET `PrevQuestID`='26277' WHERE  `ID`=25064;
UPDATE `quest_template` SET `RewardNextQuest`='25064' WHERE  `ID`=26277;

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=11127 AND `ConditionValue1`IN (26277, 24755, 24763, 24775, 24781, 24787, 31163, 24643, 24769);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES 
(15 , 11127 , 0 , 0 , 1 , 8 , 0 , 26277 , 0 , 0 , 0 , 0 , 0 , '' , 'Show gossip option only if quest 26277 is rewarded'),
(15 , 11127 , 0 , 0 , 2 , 8 , 0 , 24755 , 0 , 0 , 0 , 0 , 0 , '' , 'Show gossip option only if quest 26277 is rewarded'),
(15 , 11127 , 0 , 0 , 3 , 8 , 0 , 24763 , 0 , 0 , 0 , 0 , 0 , '' , 'Show gossip option only if quest 26277 is rewarded'),
(15 , 11127 , 0 , 0 , 4 , 8 , 0 , 24775 , 0 , 0 , 0 , 0 , 0 , '' , 'Show gossip option only if quest 26277 is rewarded'),
(15 , 11127 , 0 , 0 , 5 , 8 , 0 , 24781 , 0 , 0 , 0 , 0 , 0 , '' , 'Show gossip option only if quest 26277 is rewarded'),
(15 , 11127 , 0 , 0 , 6 , 8 , 0 , 24787 , 0 , 0 , 0 , 0 , 0 , '' , 'Show gossip option only if quest 26277 is rewarded'),
(15 , 11127 , 0 , 0 , 7 , 8 , 0 , 31163 , 0 , 0 , 0 , 0 , 0 , '' , 'Show gossip option only if quest 26277 is rewarded'),
(15 , 11127 , 0 , 0 , 8 , 8 , 0 , 24643 , 0 , 0 , 0 , 0 , 0 , '' , 'Show gossip option only if quest 26277 is rewarded'),
(15 , 11127 , 0 , 0 , 9 , 8 , 0 , 24769 , 0 , 0 , 0 , 0 , 0 , '' , 'Show gossip option only if quest 26277 is rewarded');

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (38966, 38938, 38953, 3896600, 3893800, 3895300);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`,`target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(38938, 0, 0, 0, 1, 0, 100, 513, 3000, 3000, 3000, 3000, '', 80, 3893800, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, ''),
(38953, 0, 0, 0, 1, 0, 100, 513, 13500, 13500, 13500, 13500, '', 80, 3895300, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, ''),
(38966, 0, 0, 0, 20, 0, 100, 512, 31163, 0, 0, 0, '', 80, 3896600, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, ''),
(38966, 0, 1, 0, 20, 0, 100, 512, 24755, 0, 0, 0, '', 80, 3896600, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, ''),
(38966, 0, 2, 0, 20, 0, 100, 512, 24763, 0, 0, 0, '', 80, 3896600, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, ''),
(38966, 0, 3, 0, 20, 0, 100, 512, 24775, 0, 0, 0, '', 80, 3896600, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, ''),
(38966, 0, 4, 0, 20, 0, 100, 512, 24781, 0, 0, 0, '', 80, 3896600, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, ''),
(38966, 0, 5, 0, 20, 0, 100, 512, 24787, 0, 0, 0, '', 80, 3896600, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, ''),
(38966, 0, 6, 0, 20, 0, 100, 512, 24643, 0, 0, 0, '', 80, 3896600, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, ''),
(38966, 0, 7, 0, 20, 0, 100, 512, 24769, 0, 0, 0, '', 80, 3896600, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, ''),
(38966, 0, 8, 0, 20, 0, 100, 512, 26277, 0, 0, 0, '', 80, 3896600, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, ''),
(3893800, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, '', 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, ''),
(3893800, 9, 1, 0, 0, 0, 100, 0, 28000, 28000, 0, 0, '', 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, ''),
(3893800, 9, 2, 0, 0, 0, 100, 0, 19000, 19000, 0, 0, '', 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, ''),
(3893800, 9, 3, 0, 0, 0, 100, 0, 65000, 65000, 0, 0, '', 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, ''),
(3893800, 9, 4, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, '', 41, 1000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, ''),
(3895300, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, '', 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, ''),
(3895300, 9, 1, 0, 0, 0, 100, 0, 11000, 11000, 0, 0, '', 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, ''),
(3895300, 9, 2, 0, 0, 0, 100, 0, 15000, 15000, 0, 0, '', 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, ''),
(3895300, 9, 3, 0, 0, 0, 100, 0, 25000, 25000, 0, 0, '', 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, ''),
(3895300, 9, 4, 0, 0, 0, 100, 0, 17000, 17000, 0, 0, '', 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, ''),
(3895300, 9, 5, 0, 0, 0, 100, 0, 15000, 15000, 0, 0, '', 1, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, ''),
(3895300, 9, 6, 0, 0, 0, 100, 0, 20000, 20000, 0, 0, '', 1, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, ''),
(3895300, 9, 7, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, '', 41, 1000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, ''),
(3896600, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, '', 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, ''),
(3896600, 9, 2, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, '', 12, 38938, 5, 3000, 0, 0, 0, 8, 0, 0, 0, -1321.64, -5610.25, 25.4541, 2.46091, ''),
(3896600, 9, 3, 0, 0, 0, 100, 0, 500, 500, 0, 0, '', 12, 38953, 5, 3000, 0, 0, 0, 8, 0, 0, 0, -1323.86, -5608.56, 25.4523, 5.48033, ''),
(3896600, 9, 4, 0, 0, 0, 100, 0, 122000, 122000, 0, 0, '', 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, ''),
(3896600, 9, 5, 0, 0, 0, 100, 0, 12000, 12000, 0, 0, '', 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, ''),
(3896600, 9, 6, 0, 0, 0, 100, 0, 15000, 15000, 0, 0, '', 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, '');


