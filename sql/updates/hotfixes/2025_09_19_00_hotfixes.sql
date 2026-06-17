DROP TABLE IF EXISTS `adventure_map_poi`;
CREATE TABLE IF NOT EXISTS `adventure_map_poi` (
  `ID` int(10) unsigned NOT NULL DEFAULT '0',
  `Title` text,
  `Description` text,
  `WorldPosition1` float NOT NULL DEFAULT '0',
  `WorldPosition2` float NOT NULL DEFAULT '0',
  `Type` tinyint(4) NOT NULL DEFAULT '0',
  `PlayerConditionID` int(10) unsigned NOT NULL DEFAULT '0',
  `QuestID` int(11) NOT NULL DEFAULT '0',
  `LfgDungeonID` int(10) unsigned NOT NULL DEFAULT '0',
  `RewardItemID` int(11) NOT NULL DEFAULT '0',
  `UiTextureAtlasMemberID` int(10) unsigned NOT NULL DEFAULT '0',
  `UiTextureKitID` int(10) unsigned NOT NULL DEFAULT '0',
  `WorldMapAreaID` int(10) unsigned NOT NULL DEFAULT '0',
  `MapID` int(11) NOT NULL DEFAULT '0',
  `AreaTableID` int(10) unsigned NOT NULL DEFAULT '0',
  `VerifiedBuild` smallint(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DELETE FROM `adventure_map_poi`;
/*!40000 ALTER TABLE `adventure_map_poi` DISABLE KEYS */;
/*!40000 ALTER TABLE `adventure_map_poi` ENABLE KEYS */;

DROP TABLE IF EXISTS `adventure_map_poi_locale`;
CREATE TABLE IF NOT EXISTS `adventure_map_poi_locale` (
  `ID` int(10) unsigned NOT NULL DEFAULT '0',
  `locale` varchar(4) NOT NULL,
  `Title_lang` text,
  `Description_lang` text,
  `VerifiedBuild` smallint(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`,`locale`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DELETE FROM `adventure_map_poi_locale`;
/*!40000 ALTER TABLE `adventure_map_poi_locale` DISABLE KEYS */;
/*!40000 ALTER TABLE `adventure_map_poi_locale` ENABLE KEYS */;
