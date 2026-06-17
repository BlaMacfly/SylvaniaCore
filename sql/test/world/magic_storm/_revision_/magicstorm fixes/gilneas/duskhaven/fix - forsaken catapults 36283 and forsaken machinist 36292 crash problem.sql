-- fix - forsaken catapults 36283 and forsaken machinist 36292 crash problem npc_forsaken_catapult_36283

UPDATE `creature_template` SET `minlevel`='6', `maxlevel`='8', `unit_flags`='33554688', `unit_flags2`='4196352', `scriptname`='npc_forsaken_catapult_36283'  WHERE  `entry`=36283;
UPDATE `creature_template_addon` SET `auras`='46598' WHERE `entry`=36292; -- remove aura 46598
UPDATE `creature_template` SET `modelid1`='20570', `modelid2`='11686', `unit_flags2`='4196352' WHERE  `entry`=36286;

delete from creature_addon WHERE guid IN (SELECT guid from creature where id=36292); 
delete from creature_addon WHERE guid IN (SELECT guid from creature where id=36283);
delete from creature where id=36292; 
delete from creature where id=36283;

DELETE FROM `spell_script_names` WHERE `spell_id`=68591 AND `ScriptName`='spell_fire_boulder_68591';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (68591, 'spell_fire_boulder_68591');

DELETE FROM `creature` WHERE `guid` IN (801563, 801572, 801579, 801602, 801614, 801623, 801641);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `SpawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) 
VALUES 
(801563, 36283, 654, 4714, 5720, 0, 0, 182, 0, -1, 0, 0, -2045.32, 2546.75, -1.92262, 0.20944, 300, 0, 0, 1227, 0, 0, 0, 0, 0, 0, 0, '', 25549), 
(801572, 36283, 654, 4714, 5720, 0, 0, 182, 0, -1, 0, 0, -2046.31, 2649.22, -1.76595, 5.77704, 300, 0, 0, 1227, 0, 0, 0, 0, 0, 0, 0, '', 25549), 
(801579, 36283, 654, 4714, 5720, 0, 0, 182, 0, -1, 0, 0, -1980.61, 2659.99, -1.49026, 4.93928, 300, 0, 0, 1227, 0, 0, 0, 0, 0, 0, 0, '', 25549), 
(801602, 36283, 654, 4714, 5720, 0, 0, 182, 0, -1, 0, 0, -2075.63, 2598.75, 5.37452, 6.05629, 300, 0, 0, 1227, 0, 0, 0, 0, 0, 0, 0, '', 25549), 
(801614, 36283, 654, 4714, 5720, 0, 0, 182, 0, -1, 0, 0, -2034.72, 2593.39, 0.846607, 5.96903, 300, 0, 0, 1227, 0, 0, 0, 0, 0, 0, 0, '', 25549), 
(801623, 36283, 654, 4714, 5720, 0, 0, 182, 0, -1, 0, 0, -2016.28, 2614.13, -2.23492, 5.67232, 300, 0, 0, 1227, 0, 0, 0, 0, 0, 0, 0, '', 25549), 
(801641, 36283, 654, 4714, 5720, 0, 0, 182, 0, -1, 0, 0, -2088.27, 2508.21, 1.87732, 6.02139, 300, 0, 0, 1227, 0, 0, 0, 0, 0, 0, 0, '', 25549);

DELETE FROM `creature_addon` WHERE `guid` IN (801563, 801572, 801579, 801602, 801614, 801623, 801641);
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `auras`) 
VALUES
(801563, 0, 0, 0, 1, 0, 0, 0, 0, ''), 
(801572, 0, 0, 0, 1, 0, 0, 0, 0, ''), 
(801579, 0, 0, 0, 1, 0, 0, 0, 0, ''), 
(801602, 0, 0, 0, 1, 0, 0, 0, 0, ''), 
(801614, 0, 0, 0, 1, 0, 0, 0, 0, ''), 
(801623, 0, 0, 0, 1, 0, 0, 0, 0, ''), 
(801641, 0, 0, 0, 1, 0, 0, 0, 0, '');

DELETE FROM `creature_text` WHERE `CreatureID`=36283 AND `GroupID`=0 AND `ID`=0;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) 
VALUES 
(36283, 0, 0, 'You must return to the Duskmist Shore!', 42, 0, 100, 0, 0, 0, 50651, 0, 'Forsaken Catapult to Player');
 
DELETE FROM `vehicle_template_accessory` WHERE `entry`=36283 AND `seat_id`=2;
INSERT INTO `vehicle_template_accessory` (`entry`, `accessory_entry`, `seat_id`, `minion`, `description`, `summontype`, `summontimer`) 
VALUES 
(36283, 36292, 2, 1, '36283 - 36292', 6, 30000);

DELETE FROM `npc_spellclick_spells` WHERE `npc_entry`=36283 AND `spell_id`=69434;
INSERT INTO `npc_spellclick_spells` (`npc_entry`, `spell_id`, `cast_flags`, `user_type`) 
VALUES 
(36283, 69434, 1, 0);

DELETE FROM `creature` WHERE `id` IN (36286) AND map=654;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `SpawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) 
VALUES 
(801624, 36286, 654, 4714, 4714, 0, 0, 182, 0, -1, 0, 0, -2101.91, 2688.91, 19.3181, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 25549),
(801622, 36286, 654, 4714, 4793, 0, 0, 182, 0, -1, 0, 0, -1918.36, 2578.03, 1.59042, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 25549),
(801617, 36286, 654, 4714, 4714, 0, 0, 182, 0, -1, 0, 0, -2137.02, 2655.3, 20.1049, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 25549),
(801607, 36286, 654, 4714, 5720, 0, 0, 182, 0, -1, 0, 0, -2127.53, 2664.09, 8.33806, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 25549),
(801605, 36286, 654, 4714, 4793, 0, 0, 182, 0, -1, 0, 0, -1934, 2565.76, 24.5374, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 25549),
(801598, 36286, 654, 4714, 4793, 0, 0, 182, 0, -1, 0, 0, -1939.78, 2562.5, 14.4454, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 25549),
(801597, 36286, 654, 4714, 4792, 0, 0, 182, 0, -1, 0, 0, -1858.74, 2560.08, 15.8903, 4.2586, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 25549),
(801595, 36286, 654, 4714, 4714, 0, 0, 182, 0, -1, 0, 0, -2238.09, 2557.53, 20.4911, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 25549),
(801594, 36286, 654, 4714, 4792, 0, 0, 182, 0, -1, 0, 0, -1865.78, 2545.12, 31.4739, 4.2586, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 25549),
(801590, 36286, 654, 4714, 4714, 0, 0, 182, 0, -1, 0, 0, -2202.28, 2589.49, 19.6422, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 25549),
(801589, 36286, 654, 4714, 4793, 0, 0, 182, 0, -1, 0, 0, -1921.34, 2557.3, 30.927, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 25549),
(801587, 36286, 654, 4714, 4793, 0, 0, 182, 0, -1, 0, 0, -1945.19, 2524.12, 1.48521, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 25549),
(801584, 36286, 654, 4714, 4792, 0, 0, 182, 0, -1, 0, 0, -1853.79, 2553.17, 12.6827, 4.2586, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 25549),
(801583, 36286, 654, 4714, 4714, 0, 0, 182, 0, -1, 0, 0, -2229.24, 2565.48, 8.74696, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 25549),
(801582, 36286, 654, 4714, 4793, 0, 0, 182, 0, -1, 0, 0, -1914.4, 2517.61, 2.25322, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 25549),
(801577, 36286, 654, 4714, 4714, 0, 0, 182, 0, -1, 0, 0, -2215.69, 2580.56, 14.6174, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 25549),
(801575, 36286, 654, 4714, 4793, 0, 0, 182, 0, -1, 0, 0, -1935.31, 2556.95, 21.4788, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 25549),
(801571, 36286, 654, 4714, 4714, 0, 0, 182, 0, -1, 0, 0, -2149.62, 2644.01, 26.5928, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 25549),
(801570, 36286, 654, 4714, 4792, 0, 0, 182, 0, -1, 0, 0, -1893.56, 2561.07, 1.55054, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 25549),
(804880, 36286, 654, 4714, 4714, 0, 0, 182, 0, -1, 0, 0, -2114.29, 2679.66, 14.2676, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 25549);

DELETE FROM `creature_addon` WHERE `guid` IN (select guid FROM `creature` WHERE `id` IN (36286) AND map=654);
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `auras`) 
VALUES 
(801624, 0, 0, 0, 1, 0, 0, 0, 0, ''),
(801622, 0, 0, 0, 1, 0, 0, 0, 0, ''),
(801617, 0, 0, 0, 1, 0, 0, 0, 0, ''),
(801607, 0, 0, 0, 1, 0, 0, 0, 0, ''),
(801605, 0, 0, 0, 1, 0, 0, 0, 0, ''),
(801598, 0, 0, 0, 1, 0, 0, 0, 0, ''),
(801597, 0, 0, 0, 1, 0, 0, 0, 0, ''),
(801595, 0, 0, 0, 1, 0, 0, 0, 0, ''),
(801594, 0, 0, 0, 1, 0, 0, 0, 0, ''),
(801590, 0, 0, 0, 1, 0, 0, 0, 0, ''),
(801589, 0, 0, 0, 1, 0, 0, 0, 0, ''),
(801587, 0, 0, 0, 1, 0, 0, 0, 0, ''),
(801584, 0, 0, 0, 1, 0, 0, 0, 0, ''),
(801583, 0, 0, 0, 1, 0, 0, 0, 0, ''),
(801582, 0, 0, 0, 1, 0, 0, 0, 0, ''),
(801577, 0, 0, 0, 1, 0, 0, 0, 0, ''),
(801575, 0, 0, 0, 1, 0, 0, 0, 0, ''),
(801571, 0, 0, 0, 1, 0, 0, 0, 0, ''),
(801570, 0, 0, 0, 1, 0, 0, 0, 0, ''),
(804880, 0, 0, 0, 1, 0, 0, 0, 0, '');
