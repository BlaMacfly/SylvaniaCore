DELETE FROM `garrison_scripts` WHERE `GarSiteLevelId` IN (560,584);
INSERT INTO `garrison_scripts` (`GarSiteLevelId`, `ScriptName`) VALUES
(560, 'class_hall_legion'),
(584, 'class_hall_legion');