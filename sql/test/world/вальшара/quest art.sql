DELETE FROM `creature_template_scaling` WHERE `Entry` IN (109229, 113002, 113006, 113000, 95118, 95117, 94863, 95138, 106842, 110423, 110350);
INSERT INTO `creature_template_scaling` (`Entry`, `LevelScalingMin`, `LevelScalingMax`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `VerifiedBuild`) VALUES
(109229, 98, 110, 0, 0, 22566),
(113002, 98, 110, 0, 0, 22566),
(113006, 98, 110, 0, 0, 22566),
(113000, 98, 110, 0, 0, 22566),
(95118, 98, 110, 0, 0, 22566),
(95117, 100, 110, 0, 0, 22566),
(94863, 100, 110, 0, 0, 22566),
(95138, 98, 110, 0, 0, 22566),
(106842, 98, 110, 0, 0, 22566),
(110423, 100, 110, 0, 0, 22566),
(110350, 98, 110, 0, 0, 22566);


-- quest 42440
SET @CGUID = 441171;
DELETE FROM `creature` WHERE `guid` = @CGUID+0;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `PhaseId`, `PhaseGroup`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `VerifiedBuild`) VALUES
(@CGUID+0, 107607, 1220, 7558, 7710, 1, '0', 0, 0, 0, 3477.62, 5541.454, 323.3779, 0, 120, 0, 0, 0, 0, 0, 0, 0, 0, 22566); 

DELETE FROM `creature_addon` WHERE `guid` = @CGUID+0;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `auras`) VALUES
(@CGUID+0, 0, 0, 0, 1, 0, 0, 0, 0, ''); 

UPDATE `creature_template` SET `ScriptName`='npc_investigate_shrine_kill_credit_107607', `AIName`="" WHERE `entry`= 107607 ;

DELETE FROM `scene_template` WHERE `SceneId` = 1286;
INSERT INTO `scene_template` (`SceneId`, `Flags`, `ScriptPackageID`, `ScriptName`) VALUES (1286, 17, 1637, 'scene_druid_feral_investigate');

DELETE FROM `creature` WHERE `id` = 107593;

DELETE FROM `phase_area` WHERE `AreaId` = 8164 AND `PhaseId` = 6511;
INSERT INTO `phase_area` (`AreaId`, `PhaseId`, `Comment`) VALUES (8164, 6511, 'phase after quest 42440 complete');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 26 AND `SourceGroup` = 6511 AND `SourceEntry` = 8164;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES 
(26, 6511, 8164, 0, 0, 28, 0, 28598, 0, 0, 1, 0, 0, '', 'Set phase 6511 in area 8164 if quest 42440 not complete');


UPDATE `gameobject_template` SET `ScriptName`='go_ruined_switch' WHERE `entry`= 250638 ;
UPDATE `gameobject_template` SET `ScriptName`='go_platform' WHERE `entry`= 250824 ;

UPDATE `creature_template` SET `ScriptName`='npc_ravenous_withered_107790' WHERE `entry`=107790;
UPDATE `creature_template` SET `ScriptName`='npc_clear_platform_107937' WHERE `entry`=107937;
UPDATE `creature_template` SET `ScriptName`='npc_verstok_darkbough_108003' WHERE `entry`=108003;
UPDATE `creature_template` SET `ScriptName`='npc_webmistress_shinaris_108027' WHERE `entry`=108027;
UPDATE `creature_template` SET `ScriptName`='npc_verstok_darkbough_108053' WHERE `entry`=108053;
UPDATE `creature_template` SET `ScriptName`='npc_ebonfang_108115' WHERE `entry`=108115;

-- quest 42439
UPDATE `creature_template` SET `ScriptName`='npc_delandros_shimmermoon_107392' WHERE `entry`=107392;

-- Felflame Minion
SET @ENTRY := 107548; 
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`= @ENTRY ;
DELETE FROM `smart_scripts` WHERE (`entryorguid`=@ENTRY AND `source_type`=0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 0, 0, 0, 0, 0, 100, 0, 1500, 2000, 2000, 2500, '', 11, 180327, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "cast felfire bolt ");

-- wrathblade-invader
SET @ENTRY := 107551; 
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`= @ENTRY ;
DELETE FROM `smart_scripts` WHERE (`entryorguid`=@ENTRY AND `source_type`=0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 0, 0, 0, 0, 0, 100, 0, 4500, 5000, 8500, 10000, '', 11, 204082, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "cast flurry");


-- Quest 42438 seeds-of-renewal
SET @CGUID = 441768;
DELETE FROM `creature` WHERE `guid` BETWEEN @CGUID+0 AND @CGUID+2;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `PhaseId`, `PhaseGroup`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `VerifiedBuild`) VALUES
(@CGUID+0, 113000, 1220, 7558, 7710, 1, '0', 0, 0, 0, 3405.921, 5746.777, 309.3169, 5.766525, 120, 0, 0, 0, 0, 0, 0, 0, 0, 22566),
(@CGUID+1, 113006, 1220, 7558, 7710, 1, '0', 0, 0, 0, 3381.902, 5655.804, 311.8177, 0.8342341, 120, 0, 0, 0, 0, 0, 0, 0, 0, 22566),
(@CGUID+2, 113002, 1220, 7558, 7710, 1, '0', 0, 0, 0, 3559.406, 5693.792, 317.4271, 0.2906281, 120, 0, 0, 0, 0, 0, 0, 0, 0, 22566);

UPDATE `creature` SET `id`= 113006 WHERE `guid`= 280000910 ;

DELETE FROM `creature_addon` WHERE `guid` BETWEEN @CGUID+0 AND @CGUID+2;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `auras`) VALUES
(@CGUID+0, 0, 0, 0, 1, 0, 0, 0, 0, '29266'),
(@CGUID+1, 0, 0, 0, 1, 0, 0, 0, 0, '29266'), 
(@CGUID+2, 0, 0, 0, 1, 0, 0, 0, 0, '29266'); 

SET @ENTRY := 113000; 
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`= @ENTRY ;
DELETE FROM `smart_scripts` WHERE (`entryorguid`=@ENTRY AND `source_type`=0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 0, 0, 0, 73, 0, 100, 1, 0, 0, 0, 0, '', 41, 1000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "on npc_spellclick despawn");

SET @ENTRY := 113002; 
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`= @ENTRY ;
DELETE FROM `smart_scripts` WHERE (`entryorguid`=@ENTRY AND `source_type`=0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 0, 0, 0, 73, 0, 100, 1, 0, 0, 0, 0, '', 41, 1000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "on npc_spellclick despawn");

SET @ENTRY := 113006; 
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`= @ENTRY ;
DELETE FROM `smart_scripts` WHERE (`entryorguid`=@ENTRY AND `source_type`=0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 0, 0, 0, 73, 0, 100, 1, 0, 0, 0, 0, '', 41, 1000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "on npc_spellclick despawn");

UPDATE `creature_template` SET `InhabitType`=4 WHERE `entry`=107568; 
UPDATE `creature_template` SET `minlevel`=98, `maxlevel`=110, `npcflag`=16777216, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=537165824, `unit_flags2`=2049, `dynamicflags`=32 WHERE `entry`=113002;
UPDATE `creature_template` SET `minlevel`=98, `maxlevel`=110, `npcflag`=16777216, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=537165824, `unit_flags2`=2049, `dynamicflags`=32 WHERE `entry`=113006; 
UPDATE `creature_template` SET `minlevel`=98, `maxlevel`=110, `npcflag`=16777216, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=537165824, `unit_flags2`=2049, `dynamicflags`=32 WHERE `entry`=113000; 

DELETE FROM `phase_area` WHERE `AreaId` = 8164 AND `PhaseId` = 6511;
INSERT INTO `phase_area` (`AreaId`, `PhaseId`, `Comment`) VALUES (8164, 6511, 'phase after quest 42440 complete');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 26 AND `SourceGroup` = 6511 AND `SourceEntry` = 8164;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES 
(26, 6511, 8164, 0, 0, 28, 0, 28598, 0, 0, 1, 0, 0, '', 'Set phase 6511 in area 8164 if quest 42440 not complete');