-- fix - duskhaven questobject 196394 in phasegroup 385

DELETE FROM `gameobject` WHERE `id`=196394;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `SpawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `isActive`, `ScriptName`, `VerifiedBuild`) 
VALUES (51003240, 196394, 654, 0, 0, 1, 0, 0, 385, -1, -1926.27, 2408.62, 30.0234, 5.44543, 0, 0, -0.406736, 0.913545, 7200, 255, 1, 0, '', 26365);

-- fix - black gunpowder keg in phasegroup 385

DELETE FROM `gameobject` WHERE `id`=196403;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `SpawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `isActive`, `ScriptName`, `VerifiedBuild`) 
VALUES 
(51003243, 196403, 654, 4714, 4786, 1, 0, 0, 385, -1, -1904.02, 2312.95, 39.607, 0, 0, 0, 0, 1, 7200, 255, 1, 0, '', 26365),
(51003245, 196403, 654, 4714, 4786, 1, 0, 0, 385, -1, -1941.55, 2252.75, 35.7991, 0, 0, 0, 0, 1, 7200, 255, 1, 0, '', 26365),
(51003246, 196403, 654, 4714, 4786, 1, 0, 0, 385, -1, -1931.98, 2245.92, 35.8118, 0, 0, 0, 0, 1, 7200, 255, 1, 0, '', 26365),
(51003247, 196403, 654, 4714, 4786, 1, 0, 0, 385, -1, -1898.46, 2384.36, 30.1194, 0, 0, 0, 0, 1, 7200, 255, 1, 0, '', 26365),
(51003248, 196403, 654, 4714, 4786, 1, 0, 0, 385, -1, -1987.77, 2304.11, 30.5889, 0, 0, 0, 0, 1, 7200, 255, 1, 0, '', 26365),
(51003249, 196403, 654, 4714, 4786, 1, 0, 0, 385, -1, -1961.19, 2370.83, 29.094, 0, 0, 0, 0, 1, 7200, 255, 1, 0, '', 26365),
(51003250, 196403, 654, 4714, 4786, 1, 0, 0, 385, -1, -2007.88, 2287.72, 29.4369, 0, 0, 0, 0, 1, 7200, 255, 1, 0, '', 26365),
(51003251, 196403, 654, 4714, 4786, 1, 0, 0, 385, -1, -1942.48, 2404.08, 30.0043, 0, 0, 0, 0, 1, 7200, 255, 1, 0, '', 26365),
(51003252, 196403, 654, 4714, 4786, 1, 0, 0, 385, -1, -1978.85, 2383.12, 25.1076, 0, 0, 0, 0, 1, 7200, 255, 1, 0, '', 26365),
(51003253, 196403, 654, 4714, 4786, 1, 0, 0, 385, -1, -1931.51, 2407.5, 29.977, 0, 0, 0, 0, 1, 7200, 255, 1, 0, '', 26365);
