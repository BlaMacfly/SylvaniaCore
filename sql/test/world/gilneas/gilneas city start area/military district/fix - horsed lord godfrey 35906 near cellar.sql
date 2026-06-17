-- fix - horsed and phased lord godfrey 35906 near cellar 
DELETE FROM `creature_addon` WHERE `guid`=210115271;
DELETE FROM `creature_addon` WHERE `guid`=210115272;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `auras`) 
VALUES (210115271, 0, 2410, 0, 0, 0, 0, 0, 0, NULL),
 (210115272, 0, 2410, 0, 0, 0, 0, 0, 0, NULL);
DELETE FROM `creature` WHERE `guid`=210115271;
DELETE FROM `creature` WHERE `guid`=210115272;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `SpawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) 
VALUES (210115271, 35906, 654, 0, 0, 1, 0, 171, 0, -1, 0, 1, -1785.53, 1437.74, 20.2669, 6.02249, 300, 0, 0, 130, 115, 0, 0, 0, 0, 0, 0, '', 0),
 (210115272, 35906, 654, 0, 0, 1, 0, 172, 0, -1, 0, 1, -1785.82, 1437.63, 20.2474, 6.19842, 300, 0, 0, 130, 115, 0, 0, 0, 0, 0, 0, '', 0);
