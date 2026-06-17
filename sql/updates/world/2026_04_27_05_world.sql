-- --------------------------------------------------------
-- Dock Ramp / Stormwind Harbor Legion Intro
-- --------------------------------------------------------

DELETE FROM `gameobject_template`
WHERE `entry` = 251345;

INSERT INTO `gameobject_template` (
    `entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`,
    `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`,
    `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`,
    `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`,
    `Data30`, `Data31`, `Data32`, `RequiredLevel`, `AIName`, `ScriptName`, `VerifiedBuild`
) VALUES (
    251345, 5, 9288, 'Dock Ramp', '', '', '', 1,
    0, 0, 0, 1, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, '', '', 26972
);

DELETE FROM `gameobject`
WHERE `guid` = 410316;

INSERT INTO `gameobject` (
    `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`,
    `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`,
    `position_x`, `position_y`, `position_z`, `orientation`,
    `rotation0`, `rotation1`, `rotation2`, `rotation3`,
    `spawntimesecs`, `animprogress`, `state`, `isActive`, `ScriptName`, `VerifiedBuild`
) VALUES (
    410316, 251345, 0, 1519, 4411, '0',
    0, 6666, 0, -1,
    -8319.99, 1388.97, 5.73282, 4.7,
    0, 0, 0.711473, -0.702714,
    180, 255, 1, 0, '', 26972
);