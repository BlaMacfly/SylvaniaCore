-- fix - kezan troll 34830 2 spawn fixes for area and zone

DELETE FROM `creature` WHERE `guid`=21014229;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `Spawndifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) 
VALUES (21014229, 34830, 648, 4737, 4766, 1, 0, 169, 0, -1, 0, 0, -8439.39, 1213.82, 45.254, 4.06662, 120, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 15595);
DELETE FROM `creature` WHERE `guid`=21014226;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `Spawndifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) 
VALUES (21014226, 34830, 648, 4737, 4766, 1, 0, 169, 0, -1, 0, 0, -8471.5, 1217.07, 46.223, 5.63741, 120, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 15595);
