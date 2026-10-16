-- Scripts SmartAI repris d AshamaneCore qui REMPLACENT les notres : entrees jamais retouchees par nos correctifs,
-- aucun script indexe par GUID d apparition (verifie par application sur copie).

-- AshamaneCore 1b4a3da5a7 : DB/SAI: Wenikee Boltbucket - Improve Questendscript for 'Nugget Slugs'
-- [Q] Nugget Slugs -- http://wotlk.openwow.com/quest=3922
-- Actionlist SAI
SET @ENTRY := 931600;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,9,0,0,0,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Wenikee Boltbucket - On Script - Say Line 0"),
(@ENTRY,9,1,0,0,0,100,0,0,0,0,0,70,7,0,0,0,0,0,14,6579,162024,0,0,0,0,0,"Wenikee Boltbucket - On Script - Respawn Closest Gameobject 'Samophlange'"),
(@ENTRY,9,2,0,0,0,100,0,1000,1000,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,0.725311,"Wenikee Boltbucket - On Script - Set Orientation 0.725311"),
(@ENTRY,9,3,0,0,0,100,0,1000,1000,0,0,17,173,0,0,0,0,0,1,0,0,0,0,0,0,0,"Wenikee Boltbucket - On Script - Set Emote State 173"),
(@ENTRY,9,4,0,0,0,100,0,4000,4000,0,0,17,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Wenikee Boltbucket - On Script - Set Emote State 0"),
(@ENTRY,9,5,0,0,0,100,0,1000,1000,0,0,11,13727,0,0,0,0,0,1,0,0,0,0,0,0,0,"Wenikee Boltbucket - On Script - Cast 'Break Samophlange'"),
(@ENTRY,9,6,0,0,0,100,0,1000,1000,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,2.72271,"Wenikee Boltbucket - On Script - Set Orientation 2.72271"),
(@ENTRY,9,7,0,0,0,100,0,1000,1000,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Wenikee Boltbucket - On Script - Say Line 1");

-- AshamaneCore 1e819fcfd2 : DB/Creature: Levixus
-- Levixus SAI
SET @ENTRY := 19847;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,11,0,100,1,0,0,0,0,11,24313,0,0,0,0,0,1,0,0,0,0,0,0,0,"Levixus - On Respawn - Cast 'Shade' (No Repeat)"),
(@ENTRY,0,1,0,0,0,100,0,3000,7000,13000,17000,11,11443,0,0,0,0,0,2,0,0,0,0,0,0,0,"Levixus - In Combat - Cast 'Cripple'"),
(@ENTRY,0,2,0,0,0,100,0,9000,14000,13000,17000,11,7645,1,0,0,0,0,6,0,0,0,0,0,0,0,"Levixus - In Combat - Cast 'Dominate Mind'"),
(@ENTRY,0,3,0,0,0,100,0,10000,13000,18000,22000,11,38939,1,0,0,0,0,2,0,0,0,0,0,0,0,"Levixus - In Combat - Cast 'Inferno'"),
(@ENTRY,0,4,0,1,0,100,0,0,0,20000,20000,80,@ENTRY*100+00,2,0,0,0,0,1,0,0,0,0,0,0,0,"Levixus - Out of Combat - Run Script");

-- Actionlist SAI
SET @ENTRY := 1984700;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,9,0,0,0,0,100,0,1000,1000,0,0,1,0,1000,0,0,0,0,1,0,0,0,0,0,0,0,"Levixus - On Script - Say Line 0"),
(@ENTRY,9,1,0,0,0,100,0,1000,1000,0,0,1,1,8000,0,0,0,0,1,0,0,0,0,0,0,0,"Levixus - On Script - Say Line 1"),
(@ENTRY,9,2,0,0,0,100,0,8000,8000,0,0,1,0,1000,0,0,0,0,1,0,0,0,0,0,0,0,"Levixus - On Script - Say Line 0"),
(@ENTRY,9,3,0,0,0,100,0,1000,1000,0,0,1,1,5000,0,0,0,0,1,0,0,0,0,0,0,0,"Levixus - On Script - Say Line 1");

DELETE FROM `creature_text` WHERE `CreatureID`=19847;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `comment`) VALUES 
(19847, 0, 0, '%s reads from the book of the dead.', 16, 0, 100, 0, 0, 0, 17446, 'Levixus'),
-- 
(19847, 1, 0, 'Shane Dabiri, Lee, Alex T., Rob F., J. A. B.,  A. Mayberry!', 12, 8, 100, 15, 0, 0, 17454, 'Levixus'),
(19847, 1, 1, 'Jeffrey Kaplan! Tom Chilton! Rob Pardo!', 12, 8, 100, 15, 0, 0, 17447, 'Levixus'),
(19847, 1, 2, 'Justin Thavirat! Roman Kenney! Our entire awesome art and animation team!', 12, 8, 100, 15, 0, 0, 17448, 'Levixus'),
(19847, 1, 3, 'Kevin Jordan and Jonathan LeCraft!', 12, 8, 100, 15, 0, 0, 17453, 'Levixus'),
(19847, 1, 4, 'CHRIS METZEN!', 12, 8, 100, 15, 0, 0, 17449, 'Levixus'),
(19847, 1, 5, 'Pat Nagle! World design team! Cory Stockton, Paul C., Jim Chadwick, Staats, Ed Hanes, Morris, Gotcher, Jesse!, Sarah B., Victor C., Dave A.! All of our amazing exterior artists!', 12, 8, 100, 15, 0, 0, 17450, 'Levixus'),
(19847, 1, 6, 'Scott Mercer! Geoff, Wyatt, Joe, Travis, Kris, Steven! Brazie!', 12, 8, 100, 15, 0, 0, 17451, 'Levixus'),
(19847, 1, 7, 'Luis, Brianna and Eric! Blizzard QA team! Of course our fans!', 12, 8, 100, 15, 0, 0, 17452, 'Levixus');

-- AshamaneCore a754e8ab5b : DB/Creature: Eye of the Citadel
-- Levixus SAI
SET @ENTRY := 19847;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,11,0,100,1,0,0,0,0,11,24313,0,0,0,0,0,1,0,0,0,0,0,0,0,"Levixus - On Respawn - Cast 'Shade' (No Repeat)"),
(@ENTRY,0,1,0,0,0,100,0,3000,7000,13000,17000,11,11443,0,0,0,0,0,2,0,0,0,0,0,0,0,"Levixus - In Combat - Cast 'Cripple'"),
(@ENTRY,0,2,0,0,0,100,0,9000,14000,13000,17000,11,7645,1,0,0,0,0,6,0,0,0,0,0,0,0,"Levixus - In Combat - Cast 'Dominate Mind'"),
(@ENTRY,0,3,0,0,0,100,0,10000,13000,18000,22000,11,38939,1,0,0,0,0,2,0,0,0,0,0,0,0,"Levixus - In Combat - Cast 'Inferno'"),
(@ENTRY,0,4,0,1,0,100,0,0,0,20000,20000,80,@ENTRY*100+00,2,0,0,0,0,1,0,0,0,0,0,0,0,"Levixus - Out of Combat - Run Script");

-- Actionlist SAI
SET @ENTRY := 1984700;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,9,0,0,0,0,100,0,1000,1000,0,0,1,0,1000,0,0,0,0,1,0,0,0,0,0,0,0,"Levixus - On Script - Say Line 0"),
(@ENTRY,9,1,0,0,0,100,0,1000,1000,0,0,1,1,8000,0,0,0,0,1,0,0,0,0,0,0,0,"Levixus - On Script - Say Line 1"),
(@ENTRY,9,2,0,0,0,100,0,8000,8000,0,0,1,0,1000,0,0,0,0,1,0,0,0,0,0,0,0,"Levixus - On Script - Say Line 0"),
(@ENTRY,9,3,0,0,0,100,0,1000,1000,0,0,1,1,5000,0,0,0,0,1,0,0,0,0,0,0,0,"Levixus - On Script - Say Line 1");

DELETE FROM `creature_text` WHERE `CreatureID`=19847;
INSERT INTO `creature_text` (`CreatureID`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `BroadcastTextId`, `comment`) VALUES 
(19847, 0, 0, '%s reads from the book of the dead.', 16, 0, 100, 0, 0, 0, 17446, 'Levixus'),
(19847, 1, 0, 'Shane Dabiri, Lee, Alex T., Rob F., J. A. B.,  A. Mayberry!', 12, 8, 100, 15, 0, 0, 17454, 'Levixus'),
(19847, 1, 1, 'Jeffrey Kaplan! Tom Chilton! Rob Pardo!', 12, 8, 100, 15, 0, 0, 17447, 'Levixus'),
(19847, 1, 2, 'Justin Thavirat! Roman Kenney! Our entire awesome art and animation team!', 12, 8, 100, 15, 0, 0, 17448, 'Levixus'),
(19847, 1, 3, 'Kevin Jordan and Jonathan LeCraft!', 12, 8, 100, 15, 0, 0, 17453, 'Levixus'),
(19847, 1, 4, 'CHRIS METZEN!', 12, 8, 100, 15, 0, 0, 17449, 'Levixus'),
(19847, 1, 5, 'Pat Nagle! World design team! Cory Stockton, Paul C., Jim Chadwick, Staats, Ed Hanes, Morris, Gotcher, Jesse!, Sarah B., Victor C., Dave A.! All of our amazing exterior artists!', 12, 8, 100, 15, 0, 0, 17450, 'Levixus'),
(19847, 1, 6, 'Scott Mercer! Geoff, Wyatt, Joe, Travis, Kris, Steven! Brazie!', 12, 8, 100, 15, 0, 0, 17451, 'Levixus'),
(19847, 1, 7, 'Luis, Brianna and Eric! Blizzard QA team! Of course our fans!', 12, 8, 100, 15, 0, 0, 17452, 'Levixus');

-- AshamaneCore 4ae63a517d : DB/Creature: Chancellor Bloodleaf
-- Chancellor Bloodleaf -- http://wotlk.openwow.com/npc=22012
-- Chancellor Bloodleaf SAI
SET @ENTRY := 22012;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,1,0,100,0,15000,15000,130000,130000,80,@ENTRY*100+00,0,0,0,0,0,1,0,0,0,0,0,0,0,"Chancellor Bloodleaf - Out of Combat - Run Script"),
(@ENTRY,0,1,0,0,0,100,0,5000,6000,5000,6000,11,34517,0,0,0,0,0,1,0,0,0,0,0,0,0,"Chancellor Bloodleaf - In Combat - Cast 'Arcane Explosion'");

-- Actionlist SAI
SET @ENTRY := 2201200;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,9,0,0,0,0,100,0,1000,1000,0,0,1,0,8000,0,0,0,0,1,0,0,0,0,0,0,0,"Chancellor Bloodleaf - On Script - Say Line 0"),
(@ENTRY,9,1,0,0,0,100,0,1000,1000,0,0,5,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Chancellor Bloodleaf - On Script - Play Emote 1"),
(@ENTRY,9,2,0,0,0,100,0,9000,9000,0,0,1,0,6000,0,0,0,0,10,77086,22011,0,0,0,0,0,"Chancellor Bloodleaf - On Script - Say Line 0"),
(@ENTRY,9,3,0,0,0,100,0,6000,6000,0,0,1,1,7000,0,0,0,0,1,0,0,0,0,0,0,0,"Chancellor Bloodleaf - On Script - Say Line 1"),
(@ENTRY,9,4,0,0,0,100,0,1000,1000,0,0,5,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Chancellor Bloodleaf - On Script - Play Emote 1"),
(@ENTRY,9,5,0,0,0,100,0,6000,6000,0,0,1,2,6000,0,0,0,0,1,0,0,0,0,0,0,0,"Chancellor Bloodleaf - On Script - Say Line 2");

DELETE FROM `creature_text` WHERE `CreatureID` IN (22011, 22012);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `comment`) VALUES 
-- Corok the Mighty 
(22011, 0, 0, 'And... if we do not?', 12, 0, 100, 0, 0, 0, 19695, 'Corok the Mighty'),
-- Chancellor Bloodleaf
(22012, 0, 0, 'Lend us the strength of the giants of Shadowmoon, Corok. The master is a just ruler. He will be sure to take care of those that assisted in subduing the dissidents of this world.', 12, 0, 100, 0, 0, 0, 19693, 'Chancellor Bloodleaf'),
(22012, 1, 0, 'Then you become enemies of my lord, Illidan. Enemies of Illidan are destroyed. Are your giants able to withstand an attack from the forces of Eclipse Point?', 12, 0, 100, 0, 0, 0, 19696, 'Chancellor Bloodleaf'),
(22012, 2, 0, 'No... I did not think so...', 12, 0, 100, 0, 0, 0, 19697, 'Chancellor Bloodleaf');

-- AshamaneCore 5f74ee7109 : DB/SAI: Underbog
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=17734;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17734, 0, 0, 0, 9, 0, 100, 6, 0, 10, 10500, 20000, 11, 25778, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Underbog Lord - On Target within 10 yards range - Cast \'Knock Away\' '),
(17734, 0, 1, 0, 0, 0, 100, 6, 7100, 7100, 12000, 16000, 11, 32065, 33, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Underbog Lord - In Combat - Cast \'Fungal Decay\''),
(17734, 0, 2, 0, 2, 0, 100, 6, 10000, 10000, 10000, 12000, 11, 40318, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Underbog Lord - IC - Cast \'Growth\' '),
(17734, 0, 3, 4, 2, 0, 100, 7, 0, 30, 0, 0, 11, 8599, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Underbog Lord - Between 0-30% Health - Cast \'Enrage\' (No Repeat) '),
(17734, 0, 4, 0, 61, 0, 100, 7, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Underbog Lord - Between 0-30% Health - Say Line 0 (No Repeat) (Dungeon)'); 
UPDATE `creature_template` SET `gossip_menu_id`='7520' WHERE `entry`=22938;

-- AshamaneCore efee4e651f : DB: Fix Some DB errors
-- 
UPDATE `smart_scripts` SET `action_type`=11, `action_param1`=54693, `action_param2`=1 WHERE `entryorguid` IN(29475) AND `id` IN (3,4) AND `source_type`=0;
-- UPDATE `smart_scripts` SET `event_flags`=1 WHERE `entryorguid` IN (15069) AND `source_type`=0 AND `id`=1;
UPDATE `smart_scripts` SET `event_flags`=1 WHERE `entryorguid` IN (15146) AND `source_type`=0 AND `id`=3;
UPDATE `smart_scripts` SET `event_flags`=1 WHERE `entryorguid` IN (15281) AND `source_type`=0 AND `id` IN (0,5);
UPDATE `smart_scripts` SET `event_flags`=1 WHERE `entryorguid` IN (15401) AND `source_type`=0 AND `id` IN (0,5);
UPDATE `smart_scripts` SET `event_flags`=1 WHERE `entryorguid` IN (15405) AND `source_type`=0 AND `id` IN (0,5,12);
-- UPDATE `smart_scripts` SET `event_flags`=1 WHERE `entryorguid` IN (15416) AND `source_type`=0 AND `id` IN (4);
UPDATE `smart_scripts` SET `event_flags`=1 WHERE `entryorguid` IN (15417) AND `source_type`=0 AND `id` IN (0,5);
UPDATE `smart_scripts` SET `event_flags`=1 WHERE `entryorguid` IN (15418) AND `source_type`=0 AND `id` IN (0,5,12);
UPDATE `smart_scripts` SET `event_flags`=1 WHERE `entryorguid` IN (15641) AND `source_type`=0 AND `id`=0;
UPDATE `smart_scripts` SET `event_param3`=2000, `event_param4`=2000 WHERE `entryorguid`=15641 AND `source_type`=0 AND `id` IN (6,8,11);
UPDATE `smart_scripts` SET `event_param3`=2000, `event_param4`=2000 WHERE `entryorguid` IN (15970,15971) AND `source_type`=0 AND `id` IN (0,5);
UPDATE `smart_scripts` SET `event_type`=25 WHERE `entryorguid` IN (16017) AND `source_type`=0 AND `id`=0;
UPDATE `smart_scripts` SET `event_param3`=1000, `event_param4`=1000 WHERE `entryorguid`=16024 AND `source_type`=0 AND `id` IN (0);
UPDATE `smart_scripts` SET `event_flags`=1 WHERE `entryorguid` IN (16204) AND `source_type`=0 AND `id` IN (0,5);
UPDATE `smart_scripts` SET `event_flags`=1 WHERE `entryorguid` IN (16249) AND `source_type`=0 AND `id` IN (0,5);
UPDATE `smart_scripts` SET `event_param3`=2000, `event_param4`=2000 WHERE `entryorguid` IN (16294) AND `source_type`=0 AND `id` IN (4,11);
UPDATE `smart_scripts` SET `event_param3`=2000, `event_param4`=2000 WHERE `entryorguid` IN (16307) AND `source_type`=0 AND `id` IN (0,5);
UPDATE `smart_scripts` SET `event_param3`=2000, `event_param4`=2000 WHERE `entryorguid` IN (16308) AND `source_type`=0 AND `id` IN (0,5);
UPDATE `smart_scripts` SET `event_param3`=2000, `event_param4`=2000 WHERE `entryorguid` IN (16311) AND `source_type`=0 AND `id` IN (0,5);
UPDATE `smart_scripts` SET `event_param3`=2000, `event_param4`=2000 WHERE `entryorguid` IN (16318) AND `source_type`=0 AND `id` IN (0,5);
UPDATE `smart_scripts` SET `event_param3`=2000, `event_param4`=2000 WHERE `entryorguid` IN (16329) AND `source_type`=0 AND `id` IN (0,5);

