DROP TABLE IF EXISTS `chr_class_ui_display`;
CREATE TABLE `chr_class_ui_display` (
  `ID` int NOT NULL DEFAULT '0',
  `ChrClassesID` tinyint unsigned NOT NULL DEFAULT '0',
  `AdvGuidePlayerConditionID` int unsigned NOT NULL DEFAULT '0',
  `SplashPlayerConditionID` int unsigned NOT NULL DEFAULT '0',
  `VerifiedBuild` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`,`VerifiedBuild`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
