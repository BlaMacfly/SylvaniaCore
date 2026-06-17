/*Table structure for table `challenge` */

DROP TABLE IF EXISTS `challenge`;

CREATE TABLE `challenge` (
  `ID` int(11) NOT NULL,
  `GuildID` bigint(20) NOT NULL DEFAULT '0',
  `MapID` mediumint(9) NOT NULL DEFAULT '0',
  `ChallengeID` mediumint(6) NOT NULL DEFAULT '0',
  `RecordTime` int(11) NOT NULL DEFAULT '0',
  `Date` int(11) NOT NULL DEFAULT '0',
  `ChallengeLevel` smallint(6) NOT NULL DEFAULT '0',
  `TimerLevel` smallint(6) NOT NULL DEFAULT '0',
  `Affixes` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `ChestID` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`) USING BTREE,
  KEY `mapID` (`MapID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

/*Data for the table `challenge` */

/*Table structure for table `challenge_key` */

DROP TABLE IF EXISTS `challenge_key`;

CREATE TABLE `challenge_key` (
  `guid` int(10) NOT NULL DEFAULT '0',
  `ID` mediumint(6) unsigned NOT NULL DEFAULT '0',
  `Level` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Affix` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Affix1` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Affix2` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `KeyIsCharded` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `timeReset` int(10) unsigned NOT NULL DEFAULT '0',
  `InstanceID` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`) USING BTREE,
  KEY `guid` (`guid`) USING BTREE,
  KEY `timeReset` (`timeReset`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

/*Data for the table `challenge_key` */

/*Table structure for table `challenge_member` */

DROP TABLE IF EXISTS `challenge_member`;

CREATE TABLE `challenge_member` (
  `id` int(11) NOT NULL,
  `member` bigint(20) NOT NULL DEFAULT '0',
  `specID` mediumint(6) NOT NULL DEFAULT '0',
  `ChallengeLevel` smallint(6) NOT NULL DEFAULT '0',
  `Date` int(10) NOT NULL DEFAULT '0',
  `ChestID` int(10) NOT NULL DEFAULT '0',
  KEY `id` (`id`,`member`) USING BTREE,
  KEY `member` (`member`) USING BTREE,
  KEY `Date` (`Date`) USING BTREE,
  KEY `ChallengeLevel` (`ChallengeLevel`) USING BTREE,
  KEY `ChestID` (`ChestID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT;

/*Data for the table `challenge_member` */

/*Table structure for table `challenge_oplote_loot` */

DROP TABLE IF EXISTS `challenge_oplote_loot`;

CREATE TABLE `challenge_oplote_loot` (
  `guid` int(10) NOT NULL DEFAULT '0',
  `chestListID` varchar(150) NOT NULL DEFAULT '',
  `date` int(10) NOT NULL DEFAULT '0',
  `ChallengeLevel` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

/*Data for the table `challenge_oplote_loot` */
