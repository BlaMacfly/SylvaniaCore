-- fix for quest 11636 magic-carpet-ride
/*
SELECT * FROM creature_template WHERE entry IN (25459, 25460);
SELECT * FROM creature_template_addon WHERE entry IN (25459, 25460);
SELECT * FROM creature WHERE id IN (25459, 25460);
SELECT * FROM creature_addon WHERE guid IN (SELECT guid FROM creature WHERE id IN (25459, 25460));
SELECT * FROM smart_scripts WHERE entryorguid IN (25459, 25460, 2545900, 2546000, 2546001);
SELECT * FROM waypoints WHERE entry IN (25460);
*/
UPDATE `creature_template` SET `npcflag`='0', `speed_walk`='1', `speed_run`='1.42857', `unit_flags`='520', `flags_extra`='64' WHERE `entry`=25460;
UPDATE `creature_template` SET `flags_extra`='64' WHERE  `entry`=25459;

DELETE FROM `creature_addon` WHERE `guid` IN (SELECT guid FROM creature WHERE id IN (25459));
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES 
((SELECT guid FROM creature WHERE id IN (25459)), 0, 0, 0, 257, 0, '');

-- Yanni
SET @ENTRY := 25459;
SET @SOURCETYPE := 0;

DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=@SOURCETYPE;
UPDATE creature_template SET AIName="SmartAI" WHERE entry=@ENTRY LIMIT 1;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@ENTRY,@SOURCETYPE,0,0,62,0,100,0,9162,0,0,0,11,45600,0,0,0,0,0,7,0,0,0,0.0,0.0,0.0,0.0,"Yanni - On Gossip Option 0 Selected - Cast 'Call of the Carpet' (No Repeat)"),
(@ENTRY,@SOURCETYPE,1,0,62,0,100,512,9162,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0.0,0.0,0.0,0.0,"Yanni - On Gossip Option 0 Selected - Close Gossip (No Repeat)");

-- Amazing Flying Carpet
SET @ENTRY := 25460;
SET @SOURCETYPE := 0;

DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=@SOURCETYPE;
UPDATE creature_template SET AIName="SmartAI" WHERE entry=@ENTRY LIMIT 1;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@ENTRY,@SOURCETYPE,0,0,25,0,100,512,0,0,0,0,80,2546000,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Amazing Flying Carpet - On Reset - Run Script (No Repeat)"),
(@ENTRY,@SOURCETYPE,1,0,40,0,100,512,14,0,0,0,80,2546001,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Amazing Flying Carpet - On Waypoint 14 Reached - Run Script (No Repeat)");

-- Amazing Flying Carpet timed actionlist 1
SET @ENTRY := 2546000;
SET @SOURCETYPE := 9;

DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=@SOURCETYPE;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@ENTRY,@SOURCETYPE,0,0,0,0,100,512,100,100,0,0,53,1,25460,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Amazing Flying Carpet - On Script - Start Waypoint");

-- Amazing Flying Carpet timed actionlist 2
SET @ENTRY := 2546001;
SET @SOURCETYPE := 9;

DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=@SOURCETYPE;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@ENTRY,@SOURCETYPE,0,0,0,0,100,512,0,0,0,0,15,11636,0,0,0,0,0,23,0,0,0,0.0,0.0,0.0,0.0,"Amazing Flying Carpet - On Script - Quest Credit 'Magic Carpet Ride'"),
(@ENTRY,@SOURCETYPE,1,0,0,0,100,512,500,500,0,0,28,45602,0,0,0,0,0,23,0,0,0,0.0,0.0,0.0,0.0,"Amazing Flying Carpet - On Script - Remove Aura 'Ride Carpet'"),
(@ENTRY,@SOURCETYPE,2,0,0,0,100,512,100,100,0,0,28,46598,0,0,0,0,0,23,0,0,0,0.0,0.0,0.0,0.0,"Amazing Flying Carpet - On Script - Remove Aura 'Ride Vehicle Hardcoded'"),
(@ENTRY,@SOURCETYPE,3,0,0,0,100,512,200,200,0,0,41,200,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Amazing Flying Carpet - On Script - Despawn In 200 ms");

-- waypoints
DELETE FROM `waypoints` WHERE `entry`=25460;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `point_comment`) VALUES 
(25460, 1, 2751.96, 6133.51, 214.379, 'Start WP'),
(25460, 2, 2728.81, 6146.47, 213.573, ''),
(25460, 3, 2634.25, 6188.83, 185.907, ''),
(25460, 4, 2597.96, 6255.91, 159.712, ''),
(25460, 5, 2538.72, 6307.64, 138.99, ''),
(25460, 6, 2393.91, 6321.95, 85.7957, ''),
(25460, 7, 2420.33, 6461.6, 89.3512, ''),
(25460, 8, 2439.19, 6494.39, 84.9345, ''),
(25460, 9, 2496.37, 6496.77, 78.7679, ''),
(25460, 10, 2567.01, 6550.51, 79.9068, ''),
(25460, 11, 2652.55, 6572.07, 58.5456, ''),
(25460, 12, 2725.12, 6642.3, 41.5734, ''),
(25460, 13, 2773.24, 6694.34, 25.4901, ''),
(25460, 14, 2797.66, 6718.52, 9.21231, 'Run SmartAI script 2546001');

