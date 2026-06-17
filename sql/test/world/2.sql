DELETE FROM `gameobject_template` WHERE `entry` IN (2513138, 2513139, 2513140, 2513141, 2513142, 2513143);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `RequiredLevel`, `AIName`, `ScriptName`, `VerifiedBuild`) VALUES
(2513138, 8, 0, 'Alard\'s Forge (Spellfocus)', '', '', '', 1, 1862, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 22566),
(2513139, 8, 0, 'Alard\'s Anvil (Spellfocus)', '', '', '', 1, 1861, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 22566),
(2513140, 8, 0, 'Namha\'s Workbench (Spellfocus)', '', '', '', 1, 1863, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 22566),
(2513141, 8, 0, 'Greenhoof\'s Anvil (Spellfocus)', '', '', '', 1, 1870, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 22566),
(2513142, 8, 0, 'Greenhoof\'s Forge (Spellfocus)', '', '', '', 1, 1869, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 22566),
(2513143, 8, 0, 'Alard\'s Quenching Trough (Spellfocus)', '', '', '', 1, 1865, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 22566);
 
SET @OGUID := SELECT MAX(guid) FROM gameobject + 1;
 
DELETE FROM `gameobject` WHERE `id` IN (2513138, 2513139, 2513140, 2513141, 2513142, 2513143);
DELETE FROM `gameobject` WHERE `guid` BETWEEN @OGUID+0 AND @OGUID+8;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `PhaseId`, `PhaseGroup`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`) VALUES
(280000630, 2513138, 1220, 0, 0, 3, 0, 0, -737.111, 4511.58, 731.991, 3.9555, 0, 0, -0.91833, 0.395815, 120, 255, 1, 22522),
(280000631, 2513138, 1220, 0, 0, 3, 0, 0, -745.526, 4500.28, 731.974, 0.820489, 0, 0, 0.398833, 0.917023, 120, 255, 1, 22522),
(280000632, 2513139, 1220, 0, 0, 3, 0, 0, -743.406, 4502.72, 730.997, 5.55574, 0, 0, -0.355754, 0.93458, 120, 255, 1, 22522),
(280000633, 2513140, 1220, 0, 0, 3, 0, 0, -740.684, 4496.64, 730.997, 5.54086, 0, 0, -0.362699, 0.931907, 120, 255, 1, 22522),
(280000634, 2513141, 1220, 0, 0, 3, 0, 0, 2984.94, 3809.28, 1348.04, 5.138, 0, 0, -0.541811, 0.8405, 300, 255, 1, 22995),
(280000635, 2513141, 1220, 0, 0, 3, 0, 0, 2990.53, 3805.8, 1347.61, 5.138, 0, 0, -0.541811, 0.8405, 300, 255, 1, 22995),
(280000636, 2513141, 1220, 0, 0, 3, 0, 0, 2978.79, 3810.55, 1347.51, 5.138, 0, 0, -0.541811, 0.8405, 300, 255, 1, 22995),
(280000637, 2513142, 1220, 0, 0, 3, 0, 0, 2968.32, 3800.87, 1347.63, 0, 0, 0, 0, 1, 300, 255, 1, 22995),
(280000638, 2513143, 1220, 0, 0, 3, 0, 0, -747.295, 4505.16, 730.997, 3.95206, 0, 0, -0.91901, 0.394234, 120, 255, 1, 22522);

DELETE FROM `gameobject` WHERE `guid` = 586131;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `PhaseId`, `PhaseGroup`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`) VALUES
(280000639, 2589686, 1220, 0, 0, 0, 0, 0, -747.295, 4505.16, 730.997, 3.95206, 0, 0, 0.91901, -0.394234, 7200, 255, 1, 22522);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` = 184691;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 184691, 0, 0, 31, 0, 3, 92438, 0, 0, 0, 0, '', 'Implicit target 92438 for spell 184691');
 
SET @OGUID := SELECT MAX(guid) FROM gameobject + 1;
 
DELETE FROM `gameobject_template` WHERE `entry` = 2589686;
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `RequiredLevel`, `AIName`, `ScriptName`, `VerifiedBuild`) VALUES
(2589686, 8, 0, 'Alard\'s Quenching Trough Freeze (Spellfocus)', '', '', '', 1, 1867, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 22566);

DELETE FROM `gameobject_template` WHERE `entry` = 2589687;
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `RequiredLevel`, `AIName`, `ScriptName`, `VerifiedBuild`) VALUES
(2589687, 8, 0, 'Alard\'s Whetstone (Spellfocus)', '', '', '', 1, 1868, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 22566);

DELETE FROM `gameobject` WHERE `guid` = 586133;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `PhaseId`, `PhaseGroup`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`) VALUES
(280000640, 2589687, 1220, 0, 0, 0, 0, 0, -742.863, 4512.27, 730.997, 0.819432, 0, 0, 0.398349, 0.917234, 300, 255, 1, 22995); 