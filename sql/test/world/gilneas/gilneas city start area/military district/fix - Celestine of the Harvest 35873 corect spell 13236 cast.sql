-- fix - Celestine of the Harvest 35873 and 44459 corect spell 13236 cast

UPDATE `creature_template` SET `AIName`='SmartAI', `scriptname`='' WHERE entry=35873;
DELETE FROM `smart_scripts` WHERE `entryorguid`=35873 AND `id`=0 AND `source_type`=0 LIMIT 1;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) 
VALUES (35873,0,0,0,1,0,100,257,500,500,500,500,11,13236,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Cast nature channeling");

UPDATE `creature_template` SET `AIName`='SmartAI', `scriptname`='' WHERE entry=44459;
DELETE FROM `smart_scripts` WHERE `entryorguid`=44459 AND `id`=0 AND `source_type`=0 LIMIT 1;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) 
VALUES (44459,0,0,0,1,0,100,257,500,500,500,500,11,13236,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Cast nature channeling");

UPDATE `world`.`creature_template` SET `gossip_menu_id`='14290', `BaseAttackTime`='2000' WHERE  `entry`=44459;

DELETE FROM `creature` WHERE `guid`=20556963;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `SpawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) 
VALUES (20556963, 44459, 654, 4755, 4758, 1, 0, 172, 0, -1, 0, 0, -1764.99, 1658.86, 20.9935, 5.44543, 120, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 25383);

-- fix - Vitus Darkwalker 35869 and 44469 corect spell 45104 cast

UPDATE `creature_template` SET `AIName`='SmartAI', `scriptname`='' WHERE entry=35869;
DELETE FROM `smart_scripts` WHERE `entryorguid`=35869 AND `source_type`=0 AND `id`=0 AND `link`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) 
VALUES (35869, 0, 0, 0, 1, 0, 100, 257, 500, 500, 500, 500, '', 11, 45104, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cast shadow channelling');

UPDATE `creature_template` SET `AIName`='SmartAI', `scriptname`='' WHERE entry=44469;
DELETE FROM `smart_scripts` WHERE `entryorguid`=44469 AND `source_type`=0 AND `id`=0 AND `link`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) 
VALUES (44469, 0, 0, 0, 1, 0, 100, 257, 500, 500, 500, 500, '', 11, 45104, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cast shadow channelling');

DELETE FROM `creature` WHERE `guid`=20556950;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `SpawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) 
VALUES (20556950, 44469, 654, 4755, 4758, 1, 0, 172, 0, -1, 0, 0, -1745.82, 1633.39, 20.5625, 1.6057, 120, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 25383);
