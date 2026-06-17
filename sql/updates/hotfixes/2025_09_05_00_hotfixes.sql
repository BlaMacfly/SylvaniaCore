DROP TABLE IF EXISTS `chr_shipment`;
CREATE TABLE `chr_shipment` (
  `ID` int(11) unsigned NOT NULL DEFAULT '0',
  `TreasureID` int(11) unsigned NOT NULL DEFAULT '0',
  `Duration` int(11) unsigned NOT NULL DEFAULT '0',
  `SpellID` int(11) unsigned NOT NULL DEFAULT '0',
  `DummyItemID` int(11) unsigned NOT NULL DEFAULT '0',
  `OnCompleteSpellID` int(11) unsigned NOT NULL DEFAULT '0',
  `ContainerID` smallint(6) unsigned NOT NULL DEFAULT '0',
  `GarrFollowerID` smallint(6) unsigned NOT NULL DEFAULT '0',
  `MaxShipments` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Flags` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `chr_shipment_container`;
CREATE TABLE `chr_shipment_container` (
  `ID` int(11) unsigned NOT NULL DEFAULT '0',
  `PendingText_Lang` text,
  `Description_Lang` text,
  `WorkingSpellVisualID` int(11) unsigned NOT NULL DEFAULT '0',
  `UiTextureKitID` smallint(6) NOT NULL DEFAULT '0',
  `WorkingDisplayInfoID` smallint(6) NOT NULL DEFAULT '0',
  `SmallDisplayInfoID` smallint(6) NOT NULL DEFAULT '0',
  `MediumDisplayInfoID` smallint(6) NOT NULL DEFAULT '0',
  `LargeDisplayInfoID` smallint(6) NOT NULL DEFAULT '0',
  `CrossFactionID` smallint(6) NOT NULL DEFAULT '0',
  `BaseCapacity` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `GarrBuildingType` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `GarrTypeID` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `MediumThreshold` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `LargeThreshold` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Faction` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `CompleteSpellVisualID` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `chr_shipment_container_locale`;
CREATE TABLE `chr_shipment_container_locale` (
  `ID` int(11) unsigned NOT NULL DEFAULT '0',
  `locale` varchar(4) NOT NULL,
  `PendingText_Lang` text,
  `Description_Lang` text,
  PRIMARY KEY (`ID`,`locale`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
