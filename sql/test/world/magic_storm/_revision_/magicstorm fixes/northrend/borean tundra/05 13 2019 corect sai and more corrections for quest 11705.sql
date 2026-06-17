-- Varidus the Flenser 25618 sai
SET @ENTRY := 25618;
SET @SOURCETYPE := 0;

DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=@SOURCETYPE;
UPDATE creature_template SET AIName="SmartAI" WHERE entry=@ENTRY LIMIT 1;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@ENTRY,@SOURCETYPE,0,1,38,0,100,0,25729,0,0,0,80,2561800,2,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"On Data Set - Script9"),
(@ENTRY,@SOURCETYPE,1,0,61,0,100,0,0,0,0,0,18,770,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"On Data Set - Set Flag"),
(@ENTRY,@SOURCETYPE,2,0,0,0,100,0,5000,5000,10000,10000,11,32711,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"IC Update - Cast Spell Shadow Nova"),
(@ENTRY,@SOURCETYPE,3,4,6,0,100,0,0,0,0,0,15,11705,0,0,0,0,0,18,40,0,0,0.0,0.0,0.0,0.0,"On Death - Area Explored"),
(@ENTRY,@SOURCETYPE,4,0,61,0,100,0,0,0,0,0,45,1,1,0,0,0,0,19,25729,40,0,0.0,0.0,0.0,0.0,"On Death - Set Data");

-- Varidus the Flenser 25618 called actionlist 2561800
SET @ENTRY := 2561800;
SET @SOURCETYPE := 9;

DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=@SOURCETYPE;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@ENTRY,@SOURCETYPE,0,0,0,0,100,0,0,0,0,0,11,45908,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Script9 - Cast Spell"),
(@ENTRY,@SOURCETYPE,1,0,0,0,100,0,0,0,0,0,59,0,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Script9 - Set Run"),
(@ENTRY,@SOURCETYPE,2,0,0,0,100,0,0,0,0,0,69,0,0,0,0,0,0,8,0,0,0,3125.0,6534.0,80.1,0.0,"Script9 - Move to Pos"),
(@ENTRY,@SOURCETYPE,3,0,0,0,100,0,6000,6000,0,0,66,0,0,0,0,0,0,8,0,0,0,0.0,0.0,0.0,4.11,"Script9 - Set Orientation"),
(@ENTRY,@SOURCETYPE,4,0,0,0,100,0,32000,32000,0,0,1,0,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Script9 - Talk"),
(@ENTRY,@SOURCETYPE,5,0,0,0,100,0,4000,4000,0,0,66,0,0,0,0,0,0,8,0,0,0,0.0,0.0,0.0,1.52,"Script9 - Set Orientation"),
(@ENTRY,@SOURCETYPE,6,0,0,0,100,0,1000,1000,0,0,1,1,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Script9 - Talk"),
(@ENTRY,@SOURCETYPE,7,0,0,0,100,0,0,0,0,0,101,0,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Script9 - Set Home Position"),
(@ENTRY,@SOURCETYPE,8,0,0,0,100,0,3000,3000,0,0,11,45923,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Script9 - Cast Spell"),
(@ENTRY,@SOURCETYPE,9,0,0,0,100,0,1000,1000,0,0,12,25730,4,120000,0,0,0,8,0,0,0,3149.0,6527.0,80.84,2.6,"Script9 - Summon Creature"),
(@ENTRY,@SOURCETYPE,10,0,0,0,100,0,8000,8000,0,0,1,2,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Script9 - Talk"),
(@ENTRY,@SOURCETYPE,11,0,0,0,100,0,4000,4000,0,0,1,3,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Script9 - Talk"),
(@ENTRY,@SOURCETYPE,12,0,0,0,100,0,4000,4000,0,0,1,4,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Script9 - Talk"),
(@ENTRY,@SOURCETYPE,13,0,0,0,100,0,4000,4000,0,0,1,5,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Script9 - Talk"),
(@ENTRY,@SOURCETYPE,14,0,0,0,100,0,7000,7000,0,0,1,6,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Script9 - Talk"),
(@ENTRY,@SOURCETYPE,15,0,0,0,100,0,9000,9000,0,0,1,7,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Script9 - Talk"),
(@ENTRY,@SOURCETYPE,16,0,0,0,100,0,20000,20000,0,0,1,8,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Script9 - Talk"),
(@ENTRY,@SOURCETYPE,17,0,0,0,100,0,10000,10000,0,0,1,9,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Script9 - Talk"),
(@ENTRY,@SOURCETYPE,18,0,0,0,100,0,2000,2000,0,0,1,10,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Script9 - Talk"),
(@ENTRY,@SOURCETYPE,19,0,0,0,100,0,2000,2000,0,0,19,770,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Script9 - Remove Flags"),
(@ENTRY,@SOURCETYPE,20,0,0,0,100,0,1000,1000,0,0,28,0,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Script9 - Remove all auras"),
(@ENTRY,@SOURCETYPE,21,0,0,0,100,0,0,0,0,0,11,50329,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Script9 - Cast Spell"),
(@ENTRY,@SOURCETYPE,22,0,0,0,100,0,0,0,0,0,19,770,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Script9 - Remove Flags"),
(@ENTRY,@SOURCETYPE,23,0,0,0,100,0,2000,2000,0,0,49,0,0,0,0,0,0,19,25751,30,0,0.0,0.0,0.0,0.0,"Script9 - Attack Start"),
(@ENTRY,@SOURCETYPE,24,0,0,0,100,0,100000,100000,0,0,41,0,0,0,0,0,0,19,25729,100,0,0.0,0.0,0.0,0.0,"Script9 - Fail Check"),
(@ENTRY,@SOURCETYPE,25,0,0,0,100,0,0,0,0,0,41,0,0,0,0,0,0,19,25751,100,0,0.0,0.0,0.0,0.0,"Script9 - Fail Check"),
(@ENTRY,@SOURCETYPE,26,0,0,0,100,0,0,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Script9 - Fail Check");

-- Shadowstalker Getry 25729 sai
SET @ENTRY := 25729;
SET @SOURCETYPE := 0;

DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=@SOURCETYPE;
UPDATE `creature_template` SET AIName="SmartAI" WHERE entry=@ENTRY LIMIT 1;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@ENTRY,@SOURCETYPE,0,1,19,0,100,0,11705,0,0,0,53,0,25729,0,0,0,0,7,0,0,0,0.0,0.0,0.0,0.0,"On Quest Accept - WP Start"),
(@ENTRY,@SOURCETYPE,1,2,61,0,100,0,0,0,0,0,1,0,0,0,0,0,0,7,0,0,0,0.0,0.0,0.0,0.0,"On Quest Accept - Talk"),
(@ENTRY,@SOURCETYPE,2,0,61,0,100,0,0,0,0,0,45,25729,0,0,0,0,0,19,25618,150,0,0.0,0.0,0.0,0.0,"On Quest Accept - Set Data"),
(@ENTRY,@SOURCETYPE,3,0,40,0,100,0,1,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"On WP Reach - Say Text"),
(@ENTRY,@SOURCETYPE,4,5,40,0,100,0,14,0,0,0,11,58506,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"On WP Reach - Cast Spell"),
(@ENTRY,@SOURCETYPE,5,0,61,0,100,0,0,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"On WP Reach - Set Passive"),
(@ENTRY,@SOURCETYPE,6,7,8,0,100,0,45923,0,0,0,28,58506,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"On Spell Hit - Remove Aura"),
(@ENTRY,@SOURCETYPE,7,8,61,0,100,0,45923,0,0,0,101,0,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"On Spell Hit - Set Home Position"),
(@ENTRY,@SOURCETYPE,8,0,61,0,100,0,0,0,0,0,80,2572901,2,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"On Spell Hit - Script9"),
(@ENTRY,@SOURCETYPE,9,0,38,0,100,0,1,1,0,0,80,2572900,2,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"On Set Data - Script9");

-- En'kilah Necrolord 25730 sai
SET @ENTRY := 25730;
SET @SOURCETYPE := 0;

DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=@SOURCETYPE;
UPDATE creature_template SET AIName="SmartAI" WHERE entry=@ENTRY LIMIT 1;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@ENTRY,@SOURCETYPE,0,0,37,0,100,0,0,0,0,0,80,2573000,2,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"On AI Init - Script9"),
(@ENTRY,@SOURCETYPE,1,0,0,0,100,0,5000,5000,10000,10000,11,24573,0,0,0,0,0,2,0,0,0,0.0,0.0,0.0,0.0,"IC Update - Cast Spell Mortal Strike"),
(@ENTRY,@SOURCETYPE,2,0,0,0,100,0,2000,2000,11000,11000,11,16044,0,0,0,0,0,2,0,0,0,0.0,0.0,0.0,0.0,"IC Update - Cast Spell Cleave"),
(@ENTRY,@SOURCETYPE,3,0,0,0,100,0,10000,10000,30000,40000,11,41097,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"IC Update - Cast Spell Whirlwind");