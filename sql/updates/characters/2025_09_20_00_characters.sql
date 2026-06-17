DROP TABLE IF EXISTS `guild_reputation`;

CREATE TABLE `guild_reputation` (
  `guid` int unsigned NOT NULL,
  `guild` int unsigned NOT NULL,
  `reputation` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;