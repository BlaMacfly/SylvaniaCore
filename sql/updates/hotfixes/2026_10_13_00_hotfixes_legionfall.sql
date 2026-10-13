-- Hotfix tables of the Legionfall DB2 stores (Contribution, ManagedWorldState, ManagedWorldStateBuff, ManagedWorldStateInput), loaded since the
-- construction of the Broken Shore buildings: empty, the client files are read as they are.
CREATE TABLE IF NOT EXISTS `contribution` (
  `Description` text,
  `Name` text,
  `ID` int(10) unsigned NOT NULL DEFAULT '0',
  `ManagedWorldStateInputID` int(11) NOT NULL DEFAULT '0',
  `UiTextureAtlasMemberID1` int(11) NOT NULL DEFAULT '0',
  `UiTextureAtlasMemberID2` int(11) NOT NULL DEFAULT '0',
  `UiTextureAtlasMemberID3` int(11) NOT NULL DEFAULT '0',
  `UiTextureAtlasMemberID4` int(11) NOT NULL DEFAULT '0',
  `OrderIndex` int(11) NOT NULL DEFAULT '0',
  `VerifiedBuild` smallint(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `contribution_locale` (
  `ID` int(10) unsigned NOT NULL DEFAULT '0',
  `locale` varchar(4) NOT NULL,
  `Description_lang` text,
  `Name_lang` text,
  `VerifiedBuild` smallint(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`,`locale`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `managed_world_state` (
  `CurrentStageWorldStateID` int(11) NOT NULL DEFAULT '0',
  `ProgressWorldStateID` int(11) NOT NULL DEFAULT '0',
  `UpTimeSecs` int(11) NOT NULL DEFAULT '0',
  `DownTimeSecs` int(11) NOT NULL DEFAULT '0',
  `OccurrencesWorldStateID` int(11) NOT NULL DEFAULT '0',
  `AccumulationStateTargetValue` int(11) NOT NULL DEFAULT '0',
  `DepletionStateTargetValue` int(11) NOT NULL DEFAULT '0',
  `AccumulationAmountPerMinute` int(11) NOT NULL DEFAULT '0',
  `DepletionAmountPerMinute` int(11) NOT NULL DEFAULT '0',
  `ID` int(10) unsigned NOT NULL DEFAULT '0',
  `VerifiedBuild` smallint(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `managed_world_state_input` (
  `ID` int(10) unsigned NOT NULL DEFAULT '0',
  `ManagedWorldStateID` int(11) NOT NULL DEFAULT '0',
  `QuestID` int(11) NOT NULL DEFAULT '0',
  `ValidInputConditionID` int(11) NOT NULL DEFAULT '0',
  `VerifiedBuild` smallint(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `managed_world_state_buff` (
  `ID` int(10) unsigned NOT NULL DEFAULT '0',
  `OccurrenceValue` int(10) unsigned NOT NULL DEFAULT '0',
  `BuffSpellID` int(11) NOT NULL DEFAULT '0',
  `PlayerConditionID` int(11) NOT NULL DEFAULT '0',
  `ManagedWorldStateID` int(11) NOT NULL DEFAULT '0',
  `VerifiedBuild` smallint(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
