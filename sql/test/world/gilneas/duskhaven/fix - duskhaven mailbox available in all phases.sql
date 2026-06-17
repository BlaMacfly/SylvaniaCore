-- fix - duskhaven mailbox available in all phases

DELETE FROM `gameobject` WHERE `guid`=51003226;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `isActive`, `ScriptName`, `VerifiedBuild`) 
VALUES (51003226, 196846, 654, 0, 0, '0', 0, 0, 385, -1, -1902.33, 2275.4, 42.165, 0.767944, 0, 0, 0.374606, 0.927184, 7200, 255, 1, 0, '', 26365);
