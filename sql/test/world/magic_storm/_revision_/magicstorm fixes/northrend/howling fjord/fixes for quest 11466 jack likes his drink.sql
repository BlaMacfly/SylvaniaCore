--  fixes for quest 11466 jack likes his drink
/*
SELECT * FROM creature_template WHERE entry IN (24639, 24788, 24642);
SELECT * FROM creature_template_addon WHERE entry IN (24639, 24788, 24642);
SELECT * FROM creature WHERE id IN (24639, 24788, 24642);
SELECT * FROM creature_addon WHERE guid IN (SELECT guid FROM creature WHERE id IN (24639, 24788, 24642));
SELECT * FROM smart_scripts where entryorguid IN (24639, 24788, 24642, 2463900, 2463901, 2478800);
SELECT * FROM gossip_menu WHERE menuid IN (9013, 9014, 9015,9016);
SELECT * FROM gossip_menu_option WHERE menuid IN (9013, 9014, 9015, 9016);
SELECT * FROM gossip_menu_option_action WHERE menuid IN (9013, 9014, 9015, 9016);
SELECT * FROM gossip_menu_option_box WHERE menuid IN (9013, 9014, 9015, 9016);
SELECT * FROM npc_text WHERE id IN (12178, 12180, 12179, 12181);
SELECT * from hotfixes.broadcast_text WHERE id IN (23826, 23828, 23824, 23829, 23827, 35222, 23836);
SELECT * FROM waypoints WHERE entry IN (24639, 246390);
*/
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE  `entry`=24642;
UPDATE `creature_template` SET `npcflag`='0' WHERE  `entry`=24788;
UPDATE `creature_template` SET `flags_extra`='64' WHERE  `entry`=24639;

DELETE FROM `creature_template_addon` WHERE `entry`=24642;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `auras`) VALUES 
(24642, 0, 0, 0, 0, 0, 0, 0, 0, '');

DELETE FROM `gossip_menu_option_action` WHERE `menuid` in (9016);
INSERT INTO `gossip_menu_option_action` (`MenuId`, `ActionMenuId`) VALUES ('9016', '10604');

DELETE FROM `gossip_menu_option_box` WHERE  `MenuId`=9016 AND `OptionIndex`=0;
DELETE FROM `gossip_menu_option_box` WHERE `MenuId`=9014 AND `OptionIndex`=0;
INSERT INTO `gossip_menu_option_box` (`MenuId`, `OptionIndex`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextId`) VALUES 
(9014, 0, 0, 10000, 'Do you really want to bribe Olga?', 25743);

DELETE FROM `creature_addon` WHERE `guid`=106233;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES 
(106233, 0, 0, 0, 1, 0, NULL);

DELETE FROM `gossip_menu` WHERE `MenuId`=9016 AND `TextId`=12181;
INSERT INTO `gossip_menu` (`MenuId`, `TextId`, `VerifiedBuild`) VALUES (9016, 12181, 0);

DELETE FROM `gossip_menu_option` WHERE `MenuId`=9016 AND `OptionIndex`=0;
INSERT INTO `gossip_menu_option` (`MenuId`, `OptionIndex`, `OptionIcon`, `OptionText`, `OptionBroadcastTextId`, `OptionType`, `OptionNpcFlag`, `VerifiedBuild`) VALUES 
(9016, 0, 0, '\'What are Synthebrew Goggles?\'', 35222, 1, 1, 0);

DELETE FROM `gossip_menu_option_action` WHERE `MenuId`=9016 AND `OptionIndex`=0;
INSERT INTO `gossip_menu_option_action` (`MenuId`, `OptionIndex`, `ActionMenuId`, `ActionPoiId`) VALUES 
(9016, 0, 10604, 0);

DELETE FROM `npc_text` WHERE `ID`=12181;
INSERT INTO `npc_text` (`ID`, `Probability0`, `Probability1`, `Probability2`, `Probability3`, `Probability4`, `Probability5`, `Probability6`, `Probability7`, `BroadcastTextID0`, `BroadcastTextID1`, `BroadcastTextID2`, `BroadcastTextID3`, `BroadcastTextID4`, `BroadcastTextID5`, `BroadcastTextID6`, `BroadcastTextID7`, `VerifiedBuild`) VALUES 
(12181, 1, 0, 0, 0, 0, 0, 0, 0, 23836, 0, 0, 0, 0, 0, 0, 0, -12340);

-- Drunken Northsea Pirate sai
SET @ENTRY := 24642;
SET @SOURCETYPE := 0;

DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=@SOURCETYPE;
UPDATE creature_template SET AIName="SmartAI" WHERE entry=@ENTRY LIMIT 1;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@ENTRY,@SOURCETYPE,0,0,1,0,50,0,0,45000,90000,180000,1,0,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Drunken Northsea Pirate - OOC  - Say");

-- Olga, the Scalawag Wench
SET @ENTRY := 24639;
SET @SOURCETYPE := 0;

DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=@SOURCETYPE;
UPDATE creature_template SET AIName="SmartAI" WHERE entry=@ENTRY LIMIT 1;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@ENTRY,@SOURCETYPE,0,0,62,0,100,512,9014,0,0,0,80,2463900,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Olga, the Scalawag Wench - On Gossip Option 0 Selected - Run Script"),
(@ENTRY,@SOURCETYPE,1,0,40,0,100,512,2,24639,0,0,80,2463901,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Olga, the Scalawag Wench - On Waypoint 2 Reached - Run Script"),
(@ENTRY,@SOURCETYPE,2,0,38,0,100,512,3,3,0,0,53,0,246390,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Olga, the Scalawag Wench - On Data Set 3 3 - Start Waypoint"),
(@ENTRY,@SOURCETYPE,3,0,40,0,100,512,3,246390,0,0,66,5,0,0,0,0,0,8,0,0,0,0.0,0.0,0.0,0.0,"Olga, the Scalawag Wench - On Waypoint 3 (Return) Reached - Set Orientation"),
(@ENTRY,@SOURCETYPE,4,5,38,0,100,512,4,4,0,0,45,1,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Olga, the Scalawag Wench - On Data set 4 4 - Set Data 1 0"),
(@ENTRY,@SOURCETYPE,5,0,61,0,100,512,0,0,0,0,81,3,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Olga, the Scalawag Wench - On Data set 4 4 - Set NPC Flags");

-- Jack Adams
SET @ENTRY := 24788;
SET @SOURCETYPE := 0;

DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=@SOURCETYPE;
UPDATE creature_template SET AIName="SmartAI" WHERE entry=@ENTRY LIMIT 1;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@ENTRY,@SOURCETYPE,0,0,25,0,100,1,0,0,0,0,5,10,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Jack Adams - Out of Combat - Play Emote 10"),
(@ENTRY,@SOURCETYPE,1,2,38,0,100,0,1,1,0,0,1,0,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Jack Adams - On Data Set 1 1 - Say Line 0"),
(@ENTRY,@SOURCETYPE,2,0,61,0,100,512,0,0,0,0,2,35,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Jack Adams - On Data Set 1 1 - Set Faction 35"),
(@ENTRY,@SOURCETYPE,3,4,62,0,100,512,9013,0,0,0,56,34116,1,0,0,0,0,7,0,0,0,0.0,0.0,0.0,0.0,"Jack Adams - On Gossip Option 0 Selected - Add Item 'Jack Adams' Debt' 1 Time"),
(@ENTRY,@SOURCETYPE,4,5,61,0,100,512,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0.0,0.0,0.0,0.0,"Jack Adams - On Gossip Option 0 Selected - Close Gossip"),
(@ENTRY,@SOURCETYPE,5,6,61,0,100,512,0,0,0,0,81,0,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Jack Adams - On Gossip Option 0 Selected - Set Npc Flag "),
(@ENTRY,@SOURCETYPE,6,0,61,0,100,512,0,0,0,0,45,3,3,0,0,0,0,19,24639,0,0,0.0,0.0,0.0,0.0,"Jack Adams - On Gossip Option 0 Selected - Set Data 3 3"),
(@ENTRY,@SOURCETYPE,7,0,38,0,100,512,2,2,0,0,80,2478800,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Jack Adams - On Data Set 2 2 - Run Script"),
(@ENTRY,@SOURCETYPE,8,9,25,0,100,512,0,0,0,0,28,29266,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Jack Adams - On Reset - Remove permanent feign death"),
(@ENTRY,@SOURCETYPE,9,0,61,0,100,512,0,0,0,0,45,4,4,0,0,0,0,19,24639,0,0,0.0,0.0,0.0,0.0,"Jack Adams - On Reset - Set Data 4 4"),
(@ENTRY,@SOURCETYPE,10,0,63,0,100,0,0,0,0,0,81,0,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Jack Adams - On just created - Remove NPC Flags Gossip");

-- Olga, the Scalawag Wench actionlist 1
SET @ENTRY := 2463900;
SET @SOURCETYPE := 9;

DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=@SOURCETYPE;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@ENTRY,@SOURCETYPE,0,0,0,0,100,0,0,0,0,0,53,0,24639,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Olga, the Scalawag Wench - On Script - Start Waypoint"),
(@ENTRY,@SOURCETYPE,1,0,0,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0.0,0.0,0.0,0.0,"Olga, the Scalawag Wench - On Script - Close Gossip"),
(@ENTRY,@SOURCETYPE,2,0,0,0,100,0,0,0,0,0,1,0,0,0,0,0,0,7,0,0,0,0.0,0.0,0.0,0.0,"Olga, the Scalawag Wench - On Script - Say Line 0"),
(@ENTRY,@SOURCETYPE,3,0,0,0,100,0,0,0,0,0,81,0,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Olga, the Scalawag Wench - On Script - Set Npc Flag ");

-- Olga, the Scalawag Wench actionlist 2
SET @ENTRY := 2463901;
SET @SOURCETYPE := 9;

DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=@SOURCETYPE;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@ENTRY,@SOURCETYPE,0,0,0,0,100,0,0,0,0,0,66,0,0,0,0,0,0,11,24788,15,0,0.0,0.0,0.0,0.0,"Olga, the Scalawag Wench - On Script - Set Orientation Closest Creature 'Jack Adams'"),
(@ENTRY,@SOURCETYPE,1,0,0,0,100,0,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Olga, the Scalawag Wench - On Script - Say Line 1"),
(@ENTRY,@SOURCETYPE,2,0,0,0,100,0,3000,3000,0,0,45,1,1,0,0,0,0,19,24788,0,0,0.0,0.0,0.0,0.0,"Olga, the Scalawag Wench - On Script - Set Data 1 1"),
(@ENTRY,@SOURCETYPE,3,0,0,0,100,0,3000,3000,0,0,1,2,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Olga, the Scalawag Wench - On Script - Say Line 2"),
(@ENTRY,@SOURCETYPE,4,0,0,0,100,0,4000,4000,0,0,45,2,2,0,0,0,0,19,24788,0,0,0.0,0.0,0.0,0.0,"Olga, the Scalawag Wench - On Script - Set Data 2 2");

-- Jack Adams actionlist 1
SET @ENTRY := 2478800;
SET @SOURCETYPE := 9;

DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=@SOURCETYPE;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@ENTRY,@SOURCETYPE,0,0,0,0,100,0,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Jack Adams - On Script - Say Line 1"),
(@ENTRY,@SOURCETYPE,1,0,0,0,100,0,0,0,0,0,5,26,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Jack Adams - On Script - Play Emote 26"),
(@ENTRY,@SOURCETYPE,2,0,0,0,100,0,2000,2000,0,0,5,16,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Jack Adams - On Script - Play Emote 16"),
(@ENTRY,@SOURCETYPE,3,0,0,0,100,0,4000,4000,0,0,5,7,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Jack Adams - On Script - Play Emote 7"),
(@ENTRY,@SOURCETYPE,4,0,0,0,100,0,4000,4000,0,0,1,2,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Jack Adams - On Script - Say Line 2"),
(@ENTRY,@SOURCETYPE,5,0,0,0,100,0,4000,4000,0,0,11,43391,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Jack Adams - On Script - Cast 'Vomit'"),
(@ENTRY,@SOURCETYPE,6,0,0,0,100,0,3000,3000,0,0,11,29266,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Jack Adams - On Script - Cast 'Permanent Feign Death'"),
(@ENTRY,@SOURCETYPE,7,0,0,0,100,0,0,0,0,0,81,1,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Jack Adams - On Script - Set Npc Flag Gossip"),
(@ENTRY,@SOURCETYPE,8,0,0,0,100,0,0,0,0,0,41,30000,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Jack Adams - On Script - Despawn In 30000 ms");
