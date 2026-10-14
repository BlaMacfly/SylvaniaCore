-- Table hotfix de ParagonReputation.db2, chargee depuis la renommee de parangon : vide, le fichier du client est lu tel quel.
CREATE TABLE IF NOT EXISTS `paragon_reputation` (
  `ID` int(10) unsigned NOT NULL DEFAULT '0',
  `LevelThreshold` int(11) NOT NULL DEFAULT '0',
  `QuestID` int(11) NOT NULL DEFAULT '0',
  `FactionID` int(11) NOT NULL DEFAULT '0',
  `VerifiedBuild` smallint(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
