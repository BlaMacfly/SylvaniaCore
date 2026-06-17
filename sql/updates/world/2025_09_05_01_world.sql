DROP TABLE IF EXISTS `garrison_plot_class_hall`;
CREATE TABLE `garrison_plot_class_hall` (
  `garrPlotInstanceId` int(10) unsigned NOT NULL,
  `creatureId` int(10) unsigned NOT NULL DEFAULT '0',
  `gameobjectId` int(10) unsigned NOT NULL DEFAULT '0',
  `posX` float NOT NULL DEFAULT '0',
  `posY` float NOT NULL DEFAULT '0',
  `posZ` float NOT NULL DEFAULT '0',
  `posO` float NOT NULL DEFAULT '0',
  `workDisplayId` int(10) unsigned NOT NULL DEFAULT '0',
  `completeDisplayId` int(10) unsigned NOT NULL DEFAULT '0',
  `animKitId` smallint(5) unsigned NOT NULL DEFAULT '1696',
  PRIMARY KEY (`garrPlotInstanceId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DELETE FROM `garrison_plot_class_hall` WHERE `creatureId` IN ('106442','108393');
INSERT INTO `garrison_plot_class_hall` (`garrPlotInstanceId`, `creatureId`, `gameobjectId`, `posX`, `posY`, `posZ`, `posO`, `workDisplayId`, `completeDisplayId`, `animKitId`) VALUES 
(1, 106442, 250886, 4074.46, 7443.43, 44.6005, 0.29388, 9510, 35171, 1696),
(2, 108393, 250872, 4128.85, 7465.69, 48.8165, 3.62347, 9510, 35171, 1696);