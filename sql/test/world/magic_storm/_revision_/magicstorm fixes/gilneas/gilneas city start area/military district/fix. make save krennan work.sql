-- fix - gameobject spell focus 301027 for save krennan
DELETE FROM `gameobject` WHERE `guid`=905000;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `SpawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `isActive`, `ScriptName`, `VerifiedBuild`) 
VALUES (905000, 301027, 654, 1, 1, 1, 0, 171, 0, -1, -1674.46, 1344.95, 15.1352, 0, 0, 0, 0, 0, 300, 0, 0, 1, '', 0);

DELETE FROM `gameobject_addon` WHERE `guid`=905000;
INSERT INTO `gameobject_addon` (`guid`, `parent_rotation0`, `parent_rotation1`, `parent_rotation2`, `parent_rotation3`, `invisibilityType`, `invisibilityValue`, `WorldEffectID`)
 VALUES (905000, 0, 0, 0, 1, 8, 1000, 0);
