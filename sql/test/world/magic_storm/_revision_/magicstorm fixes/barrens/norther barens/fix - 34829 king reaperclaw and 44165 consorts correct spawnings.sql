-- fix - 34829 king reaperclaw and 44165 consorts correct spawnings

DELETE FROM `creature` WHERE `guid`=303909;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `SpawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) 
VALUES (303909, 34829, 1, 17, 17, 1, 0, 0, 0, -1, 0, 0, -566.854, -3476.53, 92.0672, 3.73563, 120, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, '', 0);
DELETE FROM `creature` WHERE `guid`=303907;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `SpawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) 
VALUES (303907, 44165, 1, 17, 17, 1, 0, 0, 0, -1, 0, 0, -571.565, -3468.67, 91.664, 3.94106, 120, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, '', 0);
DELETE FROM `creature` WHERE `guid`=303908;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `SpawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) 
VALUES (303908, 44165, 1, 17, 17, 1, 0, 0, 0, -1, 0, 0, -561.91, -3485.16, 91.6903, 3.29309, 120, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, '', 0);
 
 -- remove extra escorts
 
DELETE FROM `creature` WHERE `guid`=263120;
DELETE FROM `creature` WHERE `guid`=263121;

