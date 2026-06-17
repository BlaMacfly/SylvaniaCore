DROP TABLE IF EXISTS `character_garrison_missions`;
CREATE TABLE `character_garrison_missions` (
  `dbId` bigint(20) unsigned NOT NULL,
  `guid` bigint(20) unsigned NOT NULL,
  `garrison_type` tinyint(3) unsigned NOT NULL,
  `missionId` int(10) unsigned NOT NULL,
  `offerTime` int(10) unsigned NOT NULL,
  `startTime` int(10) unsigned NOT NULL,
  `status` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`dbId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
