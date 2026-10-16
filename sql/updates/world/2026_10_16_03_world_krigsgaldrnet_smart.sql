-- Scripts SmartAI et textes officiels repris d AshamaneCore (ajouts purs : aucune de nos lignes n est retiree, mesure
-- par application sur copie). Tables indexees par entree / quete uniquement.

-- AshamaneCore 27b490774b : DB/Creature: Bodley
-- 
DELETE FROM `gossip_menu_option` WHERE `MenuId` IN (57006, 57015, 57018, 57007, 57008, 57009, 57010, 57011);
INSERT INTO `gossip_menu_option` (`MenuId`, `OptionIndex`, `OptionIcon`, `OptionText`, `OptionType`, `OptionNpcFlag`, `OptionBroadcastTextID`) VALUES
(57015, 0, 0, "Yes I checked, I'm missing the top piece!", 1, 1, 11778),
(57015, 1, 0, "Yes I checked, I'm missing the left piece!", 1, 1, 11780),
(57006, 0, 0, "I lost Lord Valthalak's Amulet!", 1, 1, 11773),
(57006, 1, 0, "I lost a piece of Lord Valthalak's Amulet!", 1, 1, 11776),
(57006, 2, 0,"I've misplaced the Brazier of Beckoning!", 1, 1, 11784),
(57006, 3, 0,"Bodley, tell me what's going on.", 1, 1, 11915),
(57018, 0, 0,"Yes, please summon it back!", 1, 1, 11786),
(57007, 0, 0,"You were telling me about The Veiled Blade and how you took the wrong mission.", 1, 1, 11917),
(57008, 0, 0,"No, no, please continue... it's just that the air up here is so, um, smoky.", 1, 1, 11919),
(57009, 0, 0,"Please continue, Bodley.", 1, 1, 11921),
(57010, 0, 0,"I thought you were almost done?", 1, 1, 11923),
(57011, 0, 0,"What happened to your mercenary company, The Veiled Blade?", 1, 1, 11925);

DELETE FROM `gossip_menu_option_action` WHERE `MenuId` IN (57006, 57015, 57018, 57007, 57008, 57009, 57010, 57011);
INSERT INTO `gossip_menu_option_action` (`MenuId`, `OptionIndex`, `ActionMenuId`, `ActionPoiId`) VALUES 
(57015, 0, 57016, 0),
(57015, 1, 57017, 0),
(57006, 0, 57014, 0),
(57006, 1, 57015, 0),
(57006, 2, 57018, 0),
(57006, 3, 57007, 0),
(57018, 0, 57019, 0),
(57007, 0, 57008, 0),
(57008, 0, 57009, 0),
(57009, 0, 57010, 0),
(57010, 0, 57011, 0),
(57011, 0, 57012, 0);

UPDATE `creature_template` SET `gossip_menu_id`=57006, `AIName`='SmartAI', `npcflag`=3 WHERE `entry`=16033;
DELETE FROM `gossip_menu` WHERE `MenuId` BETWEEN 57006 AND 57019;
INSERT INTO `gossip_menu` (`MenuId`,`TextId`) VALUES (57006,50002),(57007,50003),(57008,50004),(57009,50005),(57010,50006),(57011,50007),(57012,50008),(57006,50009),(57014,50010),(57015,50011),(57016,50012),(57017,50013),(57018,50014),(57019,50015);

DELETE FROM `npc_text` WHERE `ID` BETWEEN 50002 AND 50015;
INSERT INTO `npc_text` (`ID`, `Probability0`, `BroadcastTextID0`, `VerifiedBuild`) VALUES 
(50002, 1, 11772, 0),
(50003, 1, 11916, 0),
(50004, 1, 11918, 0),
(50005, 1, 11920, 0),
(50006, 1, 11922, 0),
(50007, 1, 11924, 0),
(50008, 1, 11926, 0),
(50009, 1, 11830, 0),
(50010, 1, 11774, 0),
(50011, 1, 11777, 0),
(50012, 1, 11779, 0),
(50013, 1, 11781, 0),
(50014, 1, 11785, 0),
(50015, 1, 11787, 0);

DELETE FROM `smart_scripts` WHERE `entryorguid`=16033 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(16033, 0, 0, 0, 62, 0, 100, 0, 57015, 0, 0, 0, 11, 27544, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Bodley - On Gossip Select - Cast Add Item Left'),
(16033, 0, 1, 0, 62, 0, 100, 0, 57015, 1, 0, 0, 11, 27542, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Bodley - On Gossip Select - Cast Add Item Top'),
(16033, 0, 2, 0, 62, 0, 100, 0, 57018, 0, 0, 0, 11, 27566, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Bodley - On Gossip Select - Cast Add Item Brasero'),
(16033, 0, 3, 0, 62, 0, 100, 0, 57006, 3, 0, 0, 11, 27537, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Bodley - On Gossip Select - Cast Add Item Amulette');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup` IN (57006,57015);
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=14 AND `SourceGroup` IN (57006);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(15, 57006, 1, 0, 0, 8, 0, 8966, 0, 0, 0, 0, '', 'Requires Quest Rewarded'),
(15, 57006, 1, 0, 0, 8, 0, 8995, 0, 0, 1, 0, '', 'Requires Quest Not Rewarded'),
(15, 57006, 1, 0, 0, 2, 0, 21984, 1, 0, 1, 0, '', 'Requires Missing Item'),
(15, 57006, 1, 0, 1, 8, 0, 8967, 0, 0, 0, 0, '', 'Requires Quest Rewarded'),
(15, 57006, 1, 0, 1, 8, 0, 8995, 0, 0, 1, 0, '', 'Requires Quest Not Rewarded'),
(15, 57006, 1, 0, 1, 2, 0, 21984, 1, 0, 1, 0, '', 'Requires Missing Item'),
(15, 57006, 1, 0, 2, 8, 0, 8968, 0, 0, 0, 0, '', 'Requires Quest Rewarded'),
(15, 57006, 1, 0, 2, 8, 0, 8995, 0, 0, 1, 0, '', 'Requires Quest Not Rewarded'),
(15, 57006, 1, 0, 2, 2, 0, 21984, 1, 0, 1, 0, '', 'Requires Missing Item'),
(15, 57006, 1, 0, 3, 8, 0, 8969, 0, 0, 0, 0, '', 'Requires Quest Rewarded'),
(15, 57006, 1, 0, 3, 8, 0, 8995, 0, 0, 1, 0, '', 'Requires Quest Not Rewarded'),
(15, 57006, 1, 0, 3, 2, 0, 21984, 1, 0, 1, 0, '', 'Requires Missing Item'),
(15, 57006, 1, 0, 4, 8, 0, 9015, 0, 0, 0, 0, '', 'Requires Quest Rewarded'),
(15, 57006, 1, 0, 4, 8, 0, 8995, 0, 0, 1, 0, '', 'Requires Quest Not Rewarded'),
(15, 57006, 1, 0, 4, 2, 0, 22047, 1, 0, 1, 0, '', 'Requires Missing Item'),
(15, 57006, 0, 0, 0, 8, 0, 8994, 0, 0, 0, 0, '', 'Requires Quest Rewarded'),
(15, 57006, 0, 0, 0, 8, 0, 8995, 0, 0, 1, 0, '', 'Requires Quest Not Rewarded'),
(15, 57006, 0, 0, 0, 2, 0, 22048, 1, 0, 1, 0, '', 'Requires Missing Item'),
(15, 57006, 2, 0, 0, 8, 0, 8995, 0, 0, 0, 0, '', 'Requires Quest Rewarded'),
(15, 57006, 2, 0, 0, 2, 0, 22056, 1, 0, 1, 0, '', 'Requires Missing Item'),
(15, 57015, 1, 0, 0, 8, 0, 8966, 0, 0, 0, 0, '', 'Requires Quest Rewarded'),
(15, 57015, 1, 0, 0, 8, 0, 8995, 0, 0, 1, 0, '', 'Requires Quest Not Rewarded'),
(15, 57015, 1, 0, 0, 2, 0, 21984, 1, 0, 1, 0, '', 'Requires Missing Item'),
(15, 57015, 1, 0, 1, 8, 0, 8967, 0, 0, 0, 0, '', 'Requires Quest Rewarded'),
(15, 57015, 1, 0, 1, 8, 0, 8995, 0, 0, 1, 0, '', 'Requires Quest Not Rewarded'),
(15, 57015, 1, 0, 1, 2, 0, 21984, 1, 0, 1, 0, '', 'Requires Missing Item'),
(15, 57015, 1, 0, 2, 8, 0, 8968, 0, 0, 0, 0, '', 'Requires Quest Rewarded'),
(15, 57015, 1, 0, 2, 8, 0, 8995, 0, 0, 1, 0, '', 'Requires Quest Not Rewarded'),
(15, 57015, 1, 0, 2, 2, 0, 21984, 1, 0, 1, 0, '', 'Requires Missing Item'),
(15, 57015, 1, 0, 3, 8, 0, 8969, 0, 0, 0, 0, '', 'Requires Quest Rewarded'),
(15, 57015, 1, 0, 3, 8, 0, 8995, 0, 0, 1, 0, '', 'Requires Quest Not Rewarded'),
(15, 57015, 1, 0, 3, 2, 0, 21984, 1, 0, 1, 0, '', 'Requires Missing Item'),
(15, 57015, 0, 0, 4, 8, 0, 9015, 0, 0, 0, 0, '', 'Requires Quest Rewarded'),
(15, 57015, 0, 0, 4, 8, 0, 8995, 0, 0, 1, 0, '', 'Requires Quest Not Rewarded'),
(15, 57015, 0, 0, 4, 2, 0, 22047, 1, 0, 1, 0, '', 'Requires Missing Item'),
(14, 57006, 50009, 0, 0, 8, 0, 8997, 0, 0, 0, 0, '', 'Requires Quest Rewarded'),
(14, 57006, 50009, 0, 1, 8, 0, 8998, 0, 0, 0, 0, '', 'Requires Quest Rewarded');

-- AshamaneCore 07402c540a : DB/Creature: Son of Hodir
-- 
-- Son of Hodir SAI -- Add OOC Emote
SET @ENTRY := 29809;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,1,0,100,0,3000,30000,30000,30000,11,55524,0,0,0,0,0,1,0,0,0,0,0,0,0,"Son of Hodir - Out of Combat - Cast 'Hurl Ice Club2'");

-- AshamaneCore 27a785965e : DB/Quest: The Last of Her Kind
-- [Quest][WotlK] The Last of Her Kind
-- Harnessed Icemaw Matriarch SAI
SET @ENTRY := 30468;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0 AND `id`=4;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,4,0,28,0,100,0,0,0,0,0,41,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Harnessed Icemaw Matriarch - On Passenger Removed - Despawn Instant");

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=18 AND `SourceGroup`=29563 AND `SourceEntry`=56795;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES 
(18, 29563, 56795, 0, 0, 9, 0, 12983, 0, 0, 0, 0, 0, '', 'Required quest \'The Last of Her Kind\' active for spellclick');

-- AshamaneCore ab9bf1f66b : DB/Creature: Katherine Lee
-- Katherine Lee SAI
SET @ENTRY := 28705;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0 AND `id`=5;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,5,0,64,0,100,0,0,0,0,0,54,180000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Katherine Lee - On Gossip Hello - Pause Waypoint");

-- AshamaneCore 3b40c98da7 : DB/SAI: Altered Beast Closes #12770
--
SET @ENTRY := 49161;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ENTRY, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 3, 49162, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Altered Beast - On Aggro - Morph'),
(@ENTRY, 0, 1, 0, 7, 0, 100, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Altered Beast - On Evade - DeMorph');

-- AshamaneCore 9e904d0bbb : DB/Quest: The Battle Must Go On
-- 
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (23310) AND source_type=0 AND id=4;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(23310,0,4,0,11,0,100,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Fel Portal Alarm - On respawn - set event phase 1");
UPDATE `smart_scripts` SET `event_phase_mask`=64 WHERE `entryorguid` IN (23310) AND `source_type`=0 AND `id` IN (2,3);
UPDATE `smart_scripts` SET `event_param3`=1000, `event_param4`=1000 WHERE `entryorguid` IN (23310) AND `source_type`=0 AND `id`=2;
UPDATE `smart_scripts` SET `event_param1`=0, `event_param2`=0, action_param1=1 WHERE `entryorguid` IN (23310) AND `source_type`=0 AND `id`=3; 
UPDATE `smart_scripts` SET `event_phase_mask`=63 WHERE `entryorguid` IN (23310) AND `source_type`=0 AND `id`=1;

-- AshamaneCore 64d7837c6d : DB/Quest Fungal Spores
-- Fungal Spores -- http://wotlk.openwow.com/quest=848
-- Apothecary Helbrim SAI
SET @ENTRY := 3390;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,1,20,0,100,0,848,0,0,0,80,@ENTRY*100+00,2,0,0,0,0,1,0,0,0,0,0,0,0,"Apothecary Helbrim - On Quest 'Fungal Spores' Finished - Run Script"),
(@ENTRY,0,1,0,61,0,100,0,848,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0,0,0,0,"Apothecary Helbrim - On Quest 'Fungal Spores' Finished - Store Targetlist");

-- Actionlist SAI
SET @ENTRY := 339000;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,9,0,0,0,0,100,0,0,0,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,4.72937,"Apothecary Helbrim - On Script - Set Orientation 4.72937"),
(@ENTRY,9,1,0,0,0,100,0,2000,2000,0,0,1,0,4000,0,0,0,0,1,0,0,0,0,0,0,0,"Apothecary Helbrim - On Script - Say Line 0"),
(@ENTRY,9,2,0,0,0,100,0,4000,4000,0,0,66,0,0,0,0,0,0,12,1,0,0,0,0,0,0,"Apothecary Helbrim - On Script - Set Orientation Store Target"),
(@ENTRY,9,3,0,0,0,100,0,0,0,0,0,82,2,0,0,0,0,0,8,0,0,0,0,0,0,4.72937,"Apothecary Helbrim - On Script - Add Npc Flag Questgiver"),
(@ENTRY,9,4,0,0,0,100,0,0,0,0,0,1,1,6000,0,0,0,0,12,1,0,0,0,0,0,0,"Apothecary Helbrim - On Script - Say Line 1");

DELETE FROM `creature_text` WHERE `CreatureID`=3390;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `comment`) VALUES 
(3390, 0, 0, '%s places the spores within his alchemical instruments...', 16, 0, 100, 0, 0, 0, 1076, 'Apothecary Helbrim'),
(3390, 1, 0, 'Ah, good.  These spores have rendered nicely.  Thank you, $n.', 12, 0, 100, 0, 0, 0, 1077, 'Apothecary Helbrim');

-- AshamaneCore 41e6884caf : DB/Quest: Fungal Spores
-- Actionlist SAI
SET @ENTRY := 339000;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,9,0,0,0,0,100,0,0,0,0,0,83,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"Apothecary Helbrim - On Script - Remove Npc Flag Questgiver"),
(@ENTRY,9,1,0,0,0,100,0,0,0,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,4.72937,"Apothecary Helbrim - On Script - Set Orientation 4.72937"),
(@ENTRY,9,2,0,0,0,100,0,2000,2000,0,0,1,0,4000,0,0,0,0,1,0,0,0,0,0,0,0,"Apothecary Helbrim - On Script - Say Line 0"),
(@ENTRY,9,3,0,0,0,100,0,4000,4000,0,0,66,0,0,0,0,0,0,12,1,0,0,0,0,0,0,"Apothecary Helbrim - On Script - Set Orientation Store Target"),
(@ENTRY,9,4,0,0,0,100,0,0,0,0,0,1,1,6000,0,0,0,0,12,1,0,0,0,0,0,0,"Apothecary Helbrim - On Script - Say Line 1"),
(@ENTRY,9,5,0,0,0,100,0,0,0,0,0,82,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"Apothecary Helbrim - On Script - Add Npc Flag Questgiver"),
(@ENTRY,9,6,0,0,0,100,0,3000,3000,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,6.23082,"Apothecary Helbrim - On Script - Set Orientation 6.23082");

-- AshamaneCore bbb0d47a47 : DB/Quest: Grime-Encrusted Object + The Sparklematic 5200
-- The Sparklematic 5200 SAI
SET @ENTRY := 142487;
UPDATE `gameobject_template` SET `AIName`="SmartGameObjectAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=1;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,1,0,0,20,0,100,0,0,0,0,0,93,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"The Sparklematic 5200 - On Quest Finished - Send Custom Animation 0");

-- The Sparklematic 5200 SAI
SET @ENTRY := 175084;
UPDATE `gameobject_template` SET `AIName`="SmartGameObjectAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=1;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,1,0,0,20,0,100,0,0,0,0,0,93,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"The Sparklematic 5200 - On Quest Finished - Send Custom Animation 0");

-- The Sparklematic 5200 SAI
SET @ENTRY := 175085;
UPDATE `gameobject_template` SET `AIName`="SmartGameObjectAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=1;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,1,0,0,20,0,100,0,0,0,0,0,93,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"The Sparklematic 5200 - On Quest Finished - Send Custom Animation 0");

UPDATE `creature_loot_template` SET `QuestRequired`=0 WHERE `Item`=9308;

-- AshamaneCore c9a8e87de7 : DB/Creature: Jessera of Mac'Aree + Messenger Hermesius
-- Jessera of Mac'Aree SAI
SET @ENTRY := 17663;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,1,0,100,0,60000,60000,60000,60000,1,0,10000,0,0,0,0,1,0,0,0,0,0,0,0,"Jessera of Mac'Aree - Out of Combat - Say Line 0");

DELETE FROM `creature_text` WHERE `CreatureID`=17663;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `comment`) VALUES 
(17663, 0, 0, 'If only I could get back to the mushroom thicket. I have not seen such a mature cluster in my lifetime!', 12, 7, 100, 0, 0, 0, 14269, 'Jessera of Mac''Aree');

-- Messenger Hermesius SAI
SET @ENTRY := 17703;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,1,0,100,0,20000,25000,20000,25000,1,0,5000,0,0,0,0,1,0,0,0,0,0,0,0,"Messenger Hermesius - Out of Combat - Say Line 0");

DELETE FROM `creature_text` WHERE `CreatureID`=17703;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `comment`) VALUES 
(17703, 0, 0, 'Don\'t you people ever check the mail?', 12, 7, 100, 0, 0, 0, 14328, 'Messenger Hermesius'),
(17703, 0, 1, 'How am I expected to deliver all of these messages?', 12, 7, 100, 0, 0, 0, 14329, 'Messenger Hermesius'),
(17703, 0, 2, 'I need to be re-assigned. This job is pushing me over the edge...', 12, 7, 100, 0, 0, 0, 14330, 'Messenger Hermesius'),
(17703, 0, 3, 'He thinks he''s so damned important. Always pushing me around... I''ll show him. I''ll show all of them!', 12, 7, 100, 0, 0, 0, 14332, 'Messenger Hermesius'),
(17703, 0, 4, 'One of these days I''m going to bust out the crystalline doomhammer and go positively orc on this town. Then they''ll be sorry...', 12, 7, 100, 0, 0, 0, 14331, 'Messenger Hermesius');

-- AshamaneCore 361f7603e0 : DB/Creature: Warden Nork Bloodfrenzy & Son
-- Warden Nork Bloodfrenzy SAI
SET @ENTRY := 25379;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0 AND `id`=4;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,4,0,1,0,100,0,10000,10000,470000,470000,80,@ENTRY*100+00,0,0,0,0,0,1,0,0,0,0,0,0,0,"Warden Nork Bloodfrenzy - Out of Combat - Run Script");

-- Actionlist SAI
SET @ENTRY := 2537900;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,9,0,0,0,0,100,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Warden Nork Bloodfrenzy - On Script - Set Active On"),
(@ENTRY,9,1,0,0,0,100,0,2000,2000,0,0,1,1,3000,0,0,0,0,1,0,0,0,0,0,0,0,"Warden Nork Bloodfrenzy - On Script - Say Line 1"),
(@ENTRY,9,2,0,0,0,100,0,3000,3000,0,0,1,0,10000,0,0,0,0,10,125421,25426,0,0,0,0,0,"Warden Nork Bloodfrenzy - On Script - Say Line 0"),
(@ENTRY,9,3,0,0,0,100,0,8000,8000,0,0,5,11,0,0,0,0,0,1,0,0,0,0,0,0,0,"Warden Nork Bloodfrenzy - On Script - Play Emote 11"),
(@ENTRY,9,4,0,0,0,100,0,2000,2000,0,0,1,2,1000,0,0,0,0,1,0,0,0,0,0,0,0,"Warden Nork Bloodfrenzy - On Script - Say Line 2"),
(@ENTRY,9,5,0,0,0,100,0,1000,1000,0,0,1,3,5000,0,0,0,0,1,0,0,0,0,0,0,0,"Warden Nork Bloodfrenzy - On Script - Say Line 3"),
(@ENTRY,9,6,0,0,0,100,0,5000,5000,0,0,1,1,6000,0,0,0,0,10,125421,25426,0,0,0,0,0,"Warden Nork Bloodfrenzy - On Script - Say Line 1"),
(@ENTRY,9,7,0,0,0,100,0,6000,6000,0,0,1,4,3000,0,0,0,0,1,0,0,0,0,0,0,0,"Warden Nork Bloodfrenzy - On Script - Say Line 4"),
(@ENTRY,9,8,0,0,0,100,0,3000,3000,0,0,1,5,10000,0,0,0,0,1,0,0,0,0,0,0,0,"Warden Nork Bloodfrenzy - On Script - Say Line 5"),
(@ENTRY,9,9,0,0,0,100,0,5000,5000,0,0,5,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Warden Nork Bloodfrenzy - On Script - Play Emote 1"),
(@ENTRY,9,10,0,0,0,100,0,5000,5000,0,0,1,2,8000,0,0,0,0,10,125421,25426,0,0,0,0,0,"Warden Nork Bloodfrenzy - On Script - Say Line 2"),
(@ENTRY,9,11,0,0,0,100,0,8000,8000,0,0,1,6,9000,0,0,0,0,1,0,0,0,0,0,0,0,"Warden Nork Bloodfrenzy - On Script - Say Line 6"),
(@ENTRY,9,12,0,0,0,100,0,5000,5000,0,0,5,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Warden Nork Bloodfrenzy - On Script - Play Emote 1"),
(@ENTRY,9,13,0,0,0,100,0,4000,4000,0,0,1,7,5000,0,0,0,0,1,0,0,0,0,0,0,0,"Warden Nork Bloodfrenzy - On Script - Say Line 7"),
(@ENTRY,9,14,0,0,0,100,0,5000,5000,0,0,1,8,7000,0,0,0,0,1,0,0,0,0,0,0,0,"Warden Nork Bloodfrenzy - On Script - Say Line 8"),
(@ENTRY,9,15,0,0,0,100,0,7000,7000,0,0,1,3,3000,0,0,0,0,10,125421,25426,0,0,0,0,0,"Warden Nork Bloodfrenzy - On Script - Say Line 3"),
(@ENTRY,9,16,0,0,0,100,0,3000,3000,0,0,1,4,5000,0,0,0,0,10,125421,25426,0,0,0,0,0,"Warden Nork Bloodfrenzy - On Script - Say Line 4"),
(@ENTRY,9,17,0,0,0,100,0,5000,5000,0,0,1,5,3000,0,0,0,0,10,125421,25426,0,0,0,0,0,"Warden Nork Bloodfrenzy - On Script - Say Line 5"),
(@ENTRY,9,18,0,0,0,100,0,3000,3000,0,0,1,6,5000,0,0,0,0,10,125421,25426,0,0,0,0,0,"Warden Nork Bloodfrenzy - On Script - Say Line 6"),
(@ENTRY,9,19,0,0,0,100,0,5000,5000,0,0,1,9,2000,0,0,0,0,1,0,0,0,0,0,0,0,"Warden Nork Bloodfrenzy - On Script - Say Line 9"),
(@ENTRY,9,20,0,0,0,100,0,2000,2000,0,0,1,10,7000,0,0,0,0,1,0,0,0,0,0,0,0,"Warden Nork Bloodfrenzy - On Script - Say Line 10"),
(@ENTRY,9,21,0,0,0,100,0,4000,4000,0,0,5,15,0,0,0,0,0,1,0,0,0,0,0,0,0,"Warden Nork Bloodfrenzy - On Script - Play Emote 15"),
(@ENTRY,9,22,0,0,0,100,0,3000,3000,0,0,1,11,6000,0,0,0,0,1,0,0,0,0,0,0,0,"Warden Nork Bloodfrenzy - On Script - Say Line 11"),
(@ENTRY,9,23,0,0,0,100,0,3000,3000,0,0,5,5,0,0,0,0,0,1,0,0,0,0,0,0,0,"Warden Nork Bloodfrenzy - On Script - Play Emote 5"),
(@ENTRY,9,24,0,0,0,100,0,2000,2000,0,0,48,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Warden Nork Bloodfrenzy - On Script - Set Active Off");

DELETE FROM `creature_text` WHERE `CreatureID`=25379 AND `GroupID` >=1;
DELETE FROM `creature_text` WHERE `CreatureID`=25426;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `comment`) VALUES 
-- Warden Nork Bloodfrenzy
(25379, 1, 0, 'Look at \'em, Ug. You know what those are?', 12, 1, 100, 25, 0, 0, 24631, 'Warden Nork Bloodfrenzy'),
(25379, 2, 0, 'Those...', 12, 1, 100, 25, 0, 0, 24633, 'Warden Nork Bloodfrenzy'),
(25379, 3, 0, 'Those are cowards.', 12, 1, 100, 1, 0, 0, 24634, 'Warden Nork Bloodfrenzy'),
(25379, 4, 0, '%s shakes his head.', 16, 1, 100, 274, 0, 0, 24636, 'Warden Nork Bloodfrenzy'),
(25379, 5, 0, 'No, blood of my blood, they are soldiers of the Alliance. Our sworn enemies.', 12, 1, 100, 1, 0, 0, 24637, 'Warden Nork Bloodfrenzy'),
(25379, 6, 0, 'They are here because they do not wish to defend their homes... their families...', 12, 1, 100, 1, 0, 0, 24639, 'Warden Nork Bloodfrenzy'),
(25379, 7, 0, 'They have given up and surrendered - willingly - to us.', 12, 1, 100, 1, 0, 0, 24640, 'Warden Nork Bloodfrenzy'),
(25379, 8, 0, 'Ug\'thor, they are afraid to die.', 12, 1, 100, 1, 0, 0, 24641, 'Warden Nork Bloodfrenzy'),
(25379, 9, 0, '%s laughs.', 16, 1, 100, 11, 0, 0, 24646, 'Warden Nork Bloodfrenzy'),
(25379, 10, 0, 'That\'s right, Ug. Victory or death!', 12, 1, 100, 273, 0, 0, 24647, 'Warden Nork Bloodfrenzy'),
(25379, 11, 0, '[In Broken Common] Hear boy, cowards? Boy die! Boy die for freedom!', 12, 0, 100, 273, 0, 0, 24648, 'Warden Nork Bloodfrenzy'),
-- Ug''thor Bloodfrenzy
(25426, 0, 0, 'No, popo. They look kind of like the pigs. Are they pigs?', 12, 1, 100, 1, 0, 0, 24632, 'Ug''thor Bloodfrenzy'),
(25426, 1, 0, 'Are they cowardly pigs, popo?', 12, 1, 100, 1, 0, 0, 24635, 'Ug''thor Bloodfrenzy'),
(25426, 2, 0, 'But popo, what are they afraid of? Why are they here?', 12, 1, 100, 1, 0, 0, 24638, 'Ug''thor Bloodfrenzy'),
(25426, 3, 0, '%s scratches his head.', 16, 1, 100, 0, 0, 0, 24642, 'Ug''thor Bloodfrenzy'),
(25426, 4, 0, 'I... I don\'t understand, popo.', 12, 1, 100, 1, 0, 0, 24643, 'Ug''thor Bloodfrenzy'),
(25426, 5, 0, '%s puffs out his chest and stands on his tip-toes.', 16, 1, 100, 0, 0, 0, 24644, 'Ug''thor Bloodfrenzy'),
(25426, 6, 0, 'Lok\'tar ogar, popo!', 12, 1, 100, 1, 0, 0, 24645, 'Ug''thor Bloodfrenzy');

-- AshamaneCore 98e721c5db : DB/Creature: Torseg the Exiled
-- Torseg the Exiled SAI
SET @ENTRY := 29350;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0 AND `id`>=2;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,2,0,25,0,100,0,0,0,0,0,90,3,0,0,0,0,0,1,0,0,0,0,0,0,0,"Torseg the Exiled - On Reset - Set Flag Standstate Sleep"),
(@ENTRY,0,3,0,4,0,100,0,0,0,0,0,91,3,0,0,0,0,0,1,0,0,0,0,0,0,0,"Torseg the Exiled - On Aggro - Remove Flag Standstate Sleep");

-- AshamaneCore a151dcd3e9 : DB/SAI: Vindicator Maraad.
-- Maraad
SET @ENTRY := 79470;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = @ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ENTRY, 0, 0, 0, 19, 0, 100, 0, 34583, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Quest Taken - Say First Line');

-- AshamaneCore 9f19aa716f : DB/SAI: Portal Effect Bunny.
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=79429;
DELETE FROM `smart_scripts` WHERE `entryorguid`=79429 AND `source_type`=0 AND `id`=0 AND `link`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(79429, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, '', 3, 0, 55085, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Respawn - Morph to ModelId 55085');

-- AshamaneCore 925790f038 : DB/Item: Improved Land Mines
-- Improved Land Mine SAI
SET @ENTRY := 29475;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,25,0,100,0,0,0,0,0,89,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Improved Land Mine - On Reset - Start Random Movement"),
(@ENTRY,0,1,2,60,0,100,0,0,0,1000,1000,11,54537,0,0,0,0,0,1,0,0,0,0,0,0,0,"Improved Land Mine - On Update - Cast 'Detonation'"),
(@ENTRY,0,2,0,61,0,100,0,0,0,1000,1000,41,500,0,0,0,0,0,1,0,0,0,0,0,0,0,"Improved Land Mine - On Update - Despawn In 500 ms"),
(@ENTRY,0,3,0,5,0,100,0,0,0,0,29618,33,29618,0,0,0,0,0,21,50,0,0,0,0,0,0,"Improved Land Mine - On Killed Unit - Update Quest Kill Credit for 'A Delicate Touch' or 'Overstock'"),
(@ENTRY,0,4,0,5,0,100,0,0,0,0,29619,33,29618,0,0,0,0,0,21,50,0,0,0,0,0,0,"Improved Land Mine - On Killed Unit - Update Quest Kill Credit for 'A Delicate Touch' or 'Overstock'");
--

-- AshamaneCore f2c49d5eef : DB/SAI: Restore some deleted SAI scripts
-- 
DELETE FROM `smart_scripts` WHERE `entryorguid`=17101 AND `source_type`=0 AND `id`=2;
DELETE FROM `smart_scripts` WHERE `entryorguid`=17215 AND `source_type`=0 AND `id` IN (2, 3, 4);
DELETE FROM `smart_scripts` WHERE `entryorguid`=17214 AND `source_type`=0 AND `id`=1;
DELETE FROM `smart_scripts` WHERE `entryorguid`=17242 AND `source_type`=0 AND `id` IN (1, 2, 3);
DELETE FROM `smart_scripts` WHERE `entryorguid`=17117 AND `source_type`=0 AND `id` IN (2, 3);
DELETE FROM `smart_scripts` WHERE `entryorguid`=17241 AND `source_type`=0 AND `id`=1;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17101, 0, 2, 0, 20, 0, 100, 0, 9452, 0, 0, 0, 5, 24, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Diktynna - On Quest 'Red Snapper - Very Tasty!' Rewarded - Play Emote 24"),
(17215, 0, 2, 0, 38, 0, 100, 512, 1, 1, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Daedal - On Data Set 1 1- Set NPC Flags"),
(17215, 0, 3, 0, 38, 0, 100, 512, 2, 2, 0, 0, 81, 83, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Daedal - On Data Set 2 2- Set NPC Flags"),
(17215, 0, 4, 0, 20, 0, 100, 512, 9473, 2, 0, 0, 80, 1721500, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Daedal - On Quest 'An Alternative Alternative' Rewarded - Run Script"),
(17214, 0, 1, 0, 20, 0, 100, 512, 9463, 2, 0, 0, 80, 1721400, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Anchorite Fateema - On Quest 'Medicinal Purposes' Rewarded - Run Script"),
(17242, 0, 1, 0, 38, 0, 100, 512, 1, 1, 0, 0, 53, 0, 1724200, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Archaeologist Adamant Ironheart - On Data Set 1 1- Start WP (Path 1)"),
(17242, 0, 2, 0, 38, 0, 100, 512, 2, 2, 0, 0, 53, 0, 1724201, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Archaeologist Adamant Ironheart - On Data Set 2 2- Start WP (Path 2)"),
(17242, 0, 3, 0, 40, 0, 100, 512, 1, 1724201, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 6.26573, "Archaeologist Adamant Ironheart - On Reached WP1 (Path 2) - Set Orientation"),
(17117, 0, 2, 0, 38, 0, 100, 512, 1, 1, 0, 0, 91, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Injured Night Elf Priestess - On Data Set 1 1 - Set Bytes 1"),
(17117, 0, 3, 0, 38, 0, 100, 512, 2, 2, 0, 0, 90, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Injured Night Elf Priestess - On Data Set 2 2 - Set Bytes 1"),
(17241, 0, 1, 0, 20, 0, 100, 512, 9514, 0, 0, 0, 80, 1724100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Priestess Kyleen Il'dinare - On Quest 'Rune Covered Tablet' Rewarded - Run Script");

-- AshamaneCore d813ad50d1 : DB: RP event for Dame Auriferous, High Executor Mavren, Advisor Valwyn and Deathstalker Maltendis
-- Tranquillien RP event
SET @AURIFEROUS :=16231;
SET @SCRIPT := 1623100;
SET @MALTENDIS :=16251;
SET @MAVREN := 16252;
SET @VALWYN := 16289;

UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry` IN (@AURIFEROUS, @MAVREN, @VALWYN, @MALTENDIS);
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@AURIFEROUS, @SCRIPT, @MAVREN, @VALWYN, @MALTENDIS);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@AURIFEROUS,0,  0, 0, 1, 0, 100, 0, 10000, 60000, 580000, 620000, 80, @SCRIPT, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Dame Aureous - Out Of Combat - Run Script"),
(@SCRIPT,    9,  0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, @VALWYN, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Talk 0 (Advisor Valwyn)"),
(@SCRIPT,    9,  1, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Talk 0"),
(@SCRIPT,    9,  2, 0, 0, 0, 100, 0, 60000, 70000, 0, 0, 66, 0, 0, 0, 0, 0, 0, 19, @MAVREN, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Face High Executor Mavren"),
(@SCRIPT,    9,  3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Talk 1"),
(@SCRIPT,    9,  4, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, @MAVREN, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Set Data 1 1 (High Executor Mavren)"),
(@SCRIPT,    9,  5, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, @MALTENDIS, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Talk 0 (Deathstalker Maltendis)"),
(@SCRIPT,    9,  6, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 66, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Reset Orientation"),
(@SCRIPT,    9,  7, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, @MAVREN, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Talk 0 (High Executor Mavren)"),
(@SCRIPT,    9,  8, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 19, @VALWYN, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Talk 1 (Advisor Valwyn)"),
(@SCRIPT,    9,  9, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 45, 2, 2, 0, 0, 0, 0, 19, @MAVREN, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Set Data 2 2 (High Executor Mavren)"),
(@SCRIPT,    9, 10, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Talk 2"),
(@SCRIPT,    9, 11, 0, 0, 0, 100, 0, 50000, 70000, 0, 0, 66, 0, 0, 0, 0, 0, 0, 19, @MAVREN, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Face High Executor Mavren"),
(@SCRIPT,    9, 12, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Talk 3"),
(@SCRIPT,    9, 13, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, @MAVREN, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Set Data 1 1 (High Executor Mavren)"),
(@SCRIPT,    9, 14, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, @MALTENDIS, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Talk 0 (Deathstalker Maltendis)"),
(@SCRIPT,    9, 15, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 66, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Reset Orientation"),
(@SCRIPT,    9, 16, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 19, @MAVREN, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Talk 1 (High Executor Mavren)"),
(@SCRIPT,    9, 17, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 19, @VALWYN, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Talk 1 (Advisor Valwyn)"),
(@SCRIPT,    9, 18, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 45, 2, 2, 0, 0, 0, 0, 19, @MAVREN, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Set Data 2 2 (High Executor Mavren"),
(@SCRIPT,    9, 19, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Talk 4"),
(@SCRIPT,    9, 20, 0, 0, 0, 100, 0, 50000, 70000, 0, 0, 66, 0, 0, 0, 0, 0, 0, 19, @MAVREN, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Face High Executor Mavren"),
(@SCRIPT,    9, 21, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Talk 5"),
(@SCRIPT,    9, 22, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, @MAVREN, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Set Data 1 1 (High Executor Mavren)"),
(@SCRIPT,    9, 23, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, @MALTENDIS, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Talk 0 (Deathstalker Maltendis)"),
(@SCRIPT,    9, 24, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 66, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Reset Orientation"),
(@SCRIPT,    9, 25, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 19, @MAVREN, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Talk 2 (High Executor Mavren)"),
(@SCRIPT,    9, 26, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 19, @VALWYN, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Talk 1 (Advisor Valwyn)"),
(@SCRIPT,    9, 27, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 45, 2, 2, 0, 0, 0, 0, 19, @MAVREN, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Set Data 2 2 (High Executor Mavren"),
(@SCRIPT,    9, 28, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 1, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Talk 6"),
(@SCRIPT,    9, 29, 0, 0, 0, 100, 0, 150000, 190000, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, @MALTENDIS, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Set Data 1 1 (Deathstalker Maltendis)"),
(@SCRIPT,    9, 30, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 19, @MALTENDIS, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Talk 1 (Deathstalker Maltendis)"),
(@SCRIPT,    9, 31, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, @VALWYN, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Set Data 1 1 (Advisor Valwyn)"),
(@SCRIPT,    9, 32, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 19, @VALWYN, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Talk 2 (Advisor Valwyn)"),
(@SCRIPT,    9, 33, 0, 0, 0, 100, 0, 0, 0, 0, 0, 45, 2, 2, 0, 0, 0, 0, 19, @MALTENDIS, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Set Data 2 2 (Deathstalker Maltendis)"),
(@SCRIPT,    9, 34, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 45, 2, 2, 0, 0, 0, 0, 19, @VALWYN, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Set Data 2 2 (Advisor Valwyn)"),
(@SCRIPT,    9, 35, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 45, 3, 3, 0, 0, 0, 0, 19, @MALTENDIS, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Set Data 3 3 (Deathstalker Maltendis)"),
(@VALWYN,    0, 0, 0, 38, 0, 100, 0, 1, 1, 1000, 1000, 66, 0, 0, 0, 0, 0, 0, 19, @MALTENDIS, 0, 0, 0, 0, 0, 0, "Advisor Valwyn - On Data 1 1 Set - Face Deathstalker Maltendis"),
(@VALWYN,    0, 1, 0, 38, 0, 100, 0, 2, 2, 1000, 1000, 66, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Advisor Valwyn - On Data 2 2 Set - Reset Orientation"),
(@MAVREN,    0, 0, 0, 38, 0, 100, 0, 1, 1, 1000, 1000, 66, 0, 0, 0, 0, 0, 0, 19, 16231, 0, 0, 0, 0, 0, 0, "High Executor Mavren - On Data 1 1 Set - Face Dame Auriferious"),
(@MAVREN,    0, 1, 0, 38, 0, 100, 0, 2, 2, 1000, 1000, 66, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "High Executor Mavren - On Data 2 2 Set - Reset Orientation"),
(@MALTENDIS, 0, 0, 0, 38, 0, 100, 0, 1, 1, 1000, 1000, 66, 0, 0, 0, 0, 0, 0, 19, @VALWYN, 0, 0, 0, 0, 0, 0, "Deathstalker Maltendis - On Data 1 1 Set - Face Advisor Valwyn"),
(@MALTENDIS, 0, 1, 0, 38, 0, 100, 0, 2, 2, 1000, 1000, 5, 153, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Deathstalker Maltendis - On Data 2 2 Set - Emote Laugh"),
(@MALTENDIS, 0, 2, 0, 38, 0, 100, 0, 3, 3, 1000, 1000, 66, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Deathstalker Maltendis - On Data 3 3 Set - Reset Orientation");

DELETE FROM `creature_text` WHERE `CreatureId` IN (@AURIFEROUS, @MAVREN, @VALWYN, @MALTENDIS);
INSERT INTO `creature_text` (`CreatureId`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`BroadcastTextId`,`TextRange`,`comment`) VALUES
(@AURIFEROUS, 0, 0, "%s nods her head yes at what her advisor has to say.", 16, 0, 100, 273, 0, 0, 13362, 0, "Dame Auriferous"),
(@AURIFEROUS, 0, 1, "%s disagrees with whatever it is that Valwyn has whispered to her.", 16, 0, 100, 274, 0, 0, 13363, 0, "Dame Auriferous"),
(@AURIFEROUS, 0, 2, "%s seems nonplussed by whatever it is that her advisor has whispered in her ear.", 16, 0, 100, 6, 0, 0, 13365, 0, "Dame Auriferous"),
(@AURIFEROUS, 1, 0, "Executor, your direct assault approach will cost us more lives than I am comfortable with. A more nuanced strategy is called for; one that involves us reclaiming the surrounding territory, starting with the villages so as to cut off all points of reinforcement to Deatholme.", 12, 1, 100, 0, 0, 0, 12552, 0, "Dame Auriferous"),
(@AURIFEROUS, 2, 0, "I hear what you are saying, Mavren. Nevertheless, the final decision is mine. I appreciate your assistance, but the majority of the lives on the line are blood elf. I will not have those lives carelessly thrown away!", 12, 1, 100, 0, 0, 0, 12571, 0, "Dame Auriferous"),
(@AURIFEROUS, 3, 0, "How long until Forsaken reinforcements arrive? Our position here is tenuous. Your Lady promised us more soldiers. We must be able to concentrate solely on Deatholme and the Scourge!", 12, 1, 100, 0, 0, 0, 12557, 0, "Dame Auriferous"),
(@AURIFEROUS, 4, 0, "Mavren, I don't want excuses, I want results! The Farstriders aren't available and we've received all that we're going to get from Silvermoon for now. I cannot ignore the Shadowpine trolls and Zul'Aman... they're arrayed across our eastern border!", 12, 1, 100, 0, 0, 0, 12572, 0, "Dame Auriferous"),
(@AURIFEROUS, 5, 0, "No, I was right to begin with. Deatholme must come last. We must secure all of the Ghostlands first. I will not commit the forces here to a battle against Dar'khan with enemies to our flank and rear!", 12, 1, 100, 0, 0, 0, 12562, 0, "Dame Auriferous"),
(@AURIFEROUS, 6, 0, "Disagree with me all you like, High Executor. I will weigh your counsel, and then we will take the steps to free all of Quel'Thalas as I deem necessary. We shall continue this discussion anon.", 12, 1, 100, 0, 0, 0, 12573, 0, "Dame Auriferous"),
(@MAVREN,     0, 0, "With all due respect, milady, you have not fought the Scourge as I have. The Lady appointed me to assist you in defeating Dar'khan because of that, and you would do well to consider what I have to say.", 12, 1, 100, 0, 0, 0, 12553, 0, "High Executor Mavren"),
(@MAVREN,     0, 1, "I strongly disagree. Dar'khan is not going to get reinforcements because he'll be bottlenecked. Deatholme has only one way in and out. Your traitor was a fool to corner himself there, and I intend to exploit that weakness!", 12, 1, 100, 0, 0, 0, 12554, 0, "High Executor Mavren"),
(@MAVREN,     0, 2, "This is war, Dame Auriferous, and in any war lives will be lost! The only areas that we need to secure are the two ziggurats. We will turtle in and take the Tower of the Damned and its master by brute force. Then you will have your Quel'Thalas.", 12, 1, 100, 0, 0, 0, 12555, 0, "High Executor Mavren"),
(@MAVREN,     0, 3, "And if your Farstriders were here to reinforce us, I might agree. But, they are busying themselves instead with the Shadowpine trolls on your eastern border. The longer we wait for them, the stronger the Scourge will become.", 12, 1, 100, 0, 0, 0, 12556, 0, "High Executor Mavren"),
(@MAVREN,     1, 0, "I believe that you're making my argument for me, but yes it would be nice if we had more reinforcements. I would counter that it would be faster to pull the Farstriders from their senseless skirmishing with the trolls.", 12, 1, 100, 0, 0, 0, 12558, 0, "High Executor Mavren"),
(@MAVREN,     1, 1, "Dame Auriferous, we are the reinforcements. It may come to pass that The Lady will send more men in time. Better that you convince Silvermoon City to muster all of its forces and put them at our disposal here.", 12, 1, 100, 0, 0, 0, 12559, 0, "High Executor Mavren"),
(@MAVREN,     1, 2, "You are correct; we must concentrate on the Scourge. Ignore the trolls and the villages, and focus our attentions on Deatholme! With Dar'khan defeated you will find that the rest of the Scourge 'body' will fall quickly, lacking their 'head'.", 12, 1, 100, 0, 0, 0, 12560, 0, "High Executor Mavren"),
(@MAVREN,     1, 3, "Forsaken reinforcements? Undercity is stretched thin with the Scourge on all sides. No, this will be a matter largely dealt with by the blood elves. We Forsaken are here as backup and advisors.", 12, 1, 100, 0, 0, 0, 12561, 0, "High Executor Mavren"),
(@MAVREN,     2, 0, "Again I strongly disagree with your view of the strategic situation. Your plan will spread our forces too thin. It will leave us with only a small force to assault Deatholme. I cannot in good conscience execute such a strategy.", 12, 1, 100, 0, 0, 0, 12567, 0, "High Executor Mavren"),
(@MAVREN,     2, 1, "Spread throughout the Ghostlands, our forces will be of little use in an assault on Deatholme. No, milady, I am here to kill Dar'khan and that is what I intend to do!", 12, 1, 100, 0, 0, 0, 12568, 0, "High Executor Mavren"),
(@MAVREN,     2, 2, "We've been over this before. Only a focused assault upon Deatholme will meet with success. These other targets are distractions that we can ill afford. I suggest that you inform your Captain Helios that he is to leave off his campaign against the Shadowpine trolls and focus solely on the Scourge.", 12, 1, 100, 0, 0, 0, 12569, 0, "High Executor Mavren"),
(@MAVREN,     2, 3, "Perhaps we should let the matter rest for the time being until your chef has prepared your meal? You look a bit piqued if you don't mind my saying. We can resume our discussion when you are feeling more yourself.", 12, 1, 100, 0, 0, 0, 12570, 0, "High Executor Mavren"),
(@VALWYN,     0, 0, "%s whispers something in the Dame's ear.", 16, 0, 100, 0, 0, 0, 13361, 0, "Advisor Valwyn"),
(@VALWYN,     1, 0, "%s looks appalled at the Executor's tone!", 16, 0, 100, 0, 0, 0, 12574, 0, "Advisor Valwyn"),
(@VALWYN,     1, 1, "%s tries to busy herself with other matters.", 16, 0, 100, 0, 0, 0, 12575, 0, "Advisor Valwyn"),
(@VALWYN,     1, 2, "%s glares daggers in the direction of High Executor Mavren and Deathstalker Maltendis.", 16, 0, 100, 0, 0, 0, 12576, 0, "Advisor Valwyn"),
(@VALWYN,     1, 3, "%s lifts her nose and sniffs in response to the High Executor's reply.", 16, 0, 100, 0, 0, 0, 12577, 0, "Advisor Valwyn"),
(@VALWYN,     1, 4, "%s shakes her head in disbelief at what she is hearing out of the Forsaken's mouth.", 16, 0, 100, 0, 0, 0, 12578, 0, "Advisor Valwyn"),
(@VALWYN,     1, 5, "%s blanches as much of the blood drains from her face.", 16, 0, 100, 0, 0, 0, 12579, 0, "Advisor Valwyn"),
(@VALWYN,     1, 6, "%s reddens furiously at what she is hearing in response to her lady's question.", 16, 0, 100, 0, 0, 0, 12580, 0, "Advisor Valwyn"),
(@VALWYN,     1, 7, "%s concentrates on the wall opposite her, clearly ignoring the looks of the Executor and his assistant.", 16, 0, 100, 0, 0, 0, 12581, 0, "Advisor Valwyn"),
(@VALWYN,     2, 0, "%s looks disgusted at the deathstalker's flirtations.", 16, 0, 100, 274, 0, 0, 13367, 0, "Advisor Valwyn"),
(@MALTENDIS,  0, 0, "%s nods in agreement.", 16, 0, 100, 0, 0, 0, 12582, 0, "Deathstalker Maltendis"),
(@MALTENDIS,  0, 1, "%s opens his mouth as if to add something, and then apparently thinks the better of it.", 16, 0, 100, 0, 0, 0, 12583, 0, "Deathstalker Maltendis"),
(@MALTENDIS,  0, 2, "%s looks over at Advisor Valwyn with a smirk on his face.", 16, 0, 100, 0, 0, 0, 12584, 0, "Deathstalker Maltendis"),
(@MALTENDIS,  0, 3, "%s grins at the High Executor's words.", 16, 0, 100, 0, 0, 0, 12585, 0, "Deathstalker Maltendis"),
(@MALTENDIS,  0, 4, "%s appears bored with the whole discussion.", 16, 0, 100, 0, 0, 0, 12586, 0, "Deathstalker Maltendis"),
(@MALTENDIS,  0, 5, "%s winks slyly at Advisor Valwyn.", 16, 0, 100, 0, 0, 0, 12587, 0, "Deathstalker Maltendis"),
(@MALTENDIS,  0, 6, "%s fidgets with his armor, clearly uncomfortable at the tone of the discussion.", 16, 0, 100, 0, 0, 0, 12588, 0, "Deathstalker Maltendis"),
(@MALTENDIS,  0, 7, "%s looks like he'd rather be anywhere else but here.", 16, 0, 100, 0, 0, 0, 12589, 0, "Deathstalker Maltendis"),
(@MALTENDIS,  1, 0, "%s turns to Advisor Valwyn and winks lasciviously in her direction.", 16, 0, 100, 2, 0, 0, 13366, 0, "Deathstalker Maltendis");

-- AshamaneCore 5ef6a271fc : DB/Creature: R-3D0
SET @R3D0 := 21690;

UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@R3D0;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@R3D0, @R3D0*100);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@R3D0, 0, 0, 0, 64, 0, 100, 0, 0, 0, 0, 0, 80, 2169000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "R-3D0 - On Gossip Hello - Call Actionlist"),
(@R3D0*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 91, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "R-3D0 - On Script - Remove Standstate Sleep"),
(@R3D0*100, 9, 1, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "R-3D0 - On Script - Talk"),
(@R3D0*100, 9, 2, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 90, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "R-3D0 - On Gossip Hello - Set Standstate Sleep");

DELETE FROM `creature_text` WHERE `CreatureId`=@R3D0;
INSERT INTO `creature_text` (`CreatureId`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(@R3D0, 0, 0, "WARNING!  WARNING!  AWAY HOSTILE BEINGS!  DO NOT HEAD UP THE RIDGE TO TOSHLEY'S STATION!", 12, 0, 100, 35, 0, 0, 19311, 0, "R-3D0");

-- AshamaneCore d672389ef0 : DB/Creature: Hargin Mundar
-- 
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=1476;
DELETE FROM `smart_scripts` WHERE `entryorguid`=1476;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1476, 0, 0, 0, 1, 0, 100, 0, 5000, 30000, 300000, 600000, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Hargin Mundar - Out Of Combat - Talk"),
(1476, 0, 1, 2, 1, 0, 100, 0, 35000, 45000, 300000, 600000, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Hargin Mundar - Out Of Combat - Talk"),
(1476, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 41995, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Hargin Mundar - Out Of Combat - Cast Vomit");

DELETE FROM `creature_text` WHERE `CreatureId`=1476;
INSERT INTO `creature_text` (`CreatureId`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(1476, 0, 0, "Stormy seas out there.  The sea spirits must be restless....hic!", 12, 6, 100, 0, 0, 0, 318, 0, "Hargin Mundar"),
(1476, 0, 1, "I saw a Sea Giant once.  It's not something I would care to see again.  Burp!", 12, 6, 100, 0, 0, 0, 319, 0, "Hargin Mundar"),
(1476, 0, 2, "I'd go out and clear out some of those gnolls, but this leg has seen better days and I am afraid I'd just wind up dead.", 12, 6, 100, 0, 0, 0, 320, 0, "Hargin Mundar"),
(1476, 0, 3, "Watch your step out there.  Many an adventure seeker has not returned from the marsh.  hic!", 12, 6, 100, 0, 0, 0, 321, 0, "Hargin Mundar"),
(1476, 1, 0, "Huuup...Huuup...Bleeeeehh!", 12, 0, 100, 0, 0, 0, 397, 0, "Hargin Mundar");

