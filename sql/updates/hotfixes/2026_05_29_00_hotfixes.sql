DROP TABLE IF EXISTS `character_loadout`;

CREATE TABLE `character_loadout` (
  `ID` int NOT NULL DEFAULT '0',
  `RaceMask` bigint NOT NULL DEFAULT '0',
  `ChrClassID` tinyint unsigned NOT NULL DEFAULT '0',
  `Purpose` tinyint unsigned NOT NULL DEFAULT '0',
  `VerifiedBuild` smallint NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS `character_loadout_item`;

CREATE TABLE `character_loadout_item` (
  `ID` int NOT NULL DEFAULT '0',
  `ItemID` int NOT NULL DEFAULT '0',
  `CharacterLoadoutID` smallint unsigned NOT NULL DEFAULT '0',
  `VerifiedBuild` smallint NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;