-- Table hotfix de GarrItemLevelUpgradeData.db2, chargee pour la montee du niveau d'objet des champions : vide, le fichier du client est lu tel quel.
CREATE TABLE IF NOT EXISTS `garr_item_level_upgrade_data` (
  `ID` int(10) unsigned NOT NULL DEFAULT '0',
  `Operation` int(11) NOT NULL DEFAULT '0',
  `MinItemLevel` int(11) NOT NULL DEFAULT '0',
  `MaxItemLevel` int(11) NOT NULL DEFAULT '0',
  `FollowerTypeID` int(11) NOT NULL DEFAULT '0',
  `VerifiedBuild` smallint(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
