DROP TABLE IF EXISTS `adventure_map_ui`;
CREATE TABLE IF NOT EXISTS `adventure_map_ui` (
  `creatureId` int(10) unsigned NOT NULL,
  `uiMapId` int(10) unsigned NOT NULL,
  PRIMARY KEY (`creatureId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DELETE FROM `adventure_map_ui`;
/*!40000 ALTER TABLE `adventure_map_ui` DISABLE KEYS */;
/*!40000 ALTER TABLE `adventure_map_ui` ENABLE KEYS */;
