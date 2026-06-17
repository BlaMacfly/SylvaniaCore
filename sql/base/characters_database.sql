/*
SQLyog Community v13.1.9 (64 bit)
MySQL - 5.7.40-log : Database - characters
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

/*Table structure for table `account_data` */

DROP TABLE IF EXISTS `account_data`;

CREATE TABLE `account_data` (
  `accountId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Account Identifier',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `time` int(10) unsigned NOT NULL DEFAULT '0',
  `data` blob NOT NULL,
  PRIMARY KEY (`accountId`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `account_data` */

LOCK TABLES `account_data` WRITE;

UNLOCK TABLES;

/*Table structure for table `account_instance_times` */

DROP TABLE IF EXISTS `account_instance_times`;

CREATE TABLE `account_instance_times` (
  `accountId` int(10) unsigned NOT NULL,
  `instanceId` int(10) unsigned NOT NULL DEFAULT '0',
  `releaseTime` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`accountId`,`instanceId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `account_instance_times` */

LOCK TABLES `account_instance_times` WRITE;

UNLOCK TABLES;

/*Table structure for table `account_tutorial` */

DROP TABLE IF EXISTS `account_tutorial`;

CREATE TABLE `account_tutorial` (
  `accountId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Account Identifier',
  `tut0` int(10) unsigned NOT NULL DEFAULT '0',
  `tut1` int(10) unsigned NOT NULL DEFAULT '0',
  `tut2` int(10) unsigned NOT NULL DEFAULT '0',
  `tut3` int(10) unsigned NOT NULL DEFAULT '0',
  `tut4` int(10) unsigned NOT NULL DEFAULT '0',
  `tut5` int(10) unsigned NOT NULL DEFAULT '0',
  `tut6` int(10) unsigned NOT NULL DEFAULT '0',
  `tut7` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`accountId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `account_tutorial` */

LOCK TABLES `account_tutorial` WRITE;

UNLOCK TABLES;

/*Table structure for table `arena_team` */

DROP TABLE IF EXISTS `arena_team`;

CREATE TABLE `arena_team` (
  `arenaTeamId` int(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(24) NOT NULL,
  `captainGuid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `rating` smallint(5) unsigned NOT NULL DEFAULT '0',
  `seasonGames` smallint(5) unsigned NOT NULL DEFAULT '0',
  `seasonWins` smallint(5) unsigned NOT NULL DEFAULT '0',
  `weekGames` smallint(5) unsigned NOT NULL DEFAULT '0',
  `weekWins` smallint(5) unsigned NOT NULL DEFAULT '0',
  `rank` int(10) unsigned NOT NULL DEFAULT '0',
  `backgroundColor` int(10) unsigned NOT NULL DEFAULT '0',
  `emblemStyle` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `emblemColor` int(10) unsigned NOT NULL DEFAULT '0',
  `borderStyle` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `borderColor` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`arenaTeamId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `arena_team` */

LOCK TABLES `arena_team` WRITE;

UNLOCK TABLES;

/*Table structure for table `arena_team_member` */

DROP TABLE IF EXISTS `arena_team_member`;

CREATE TABLE `arena_team_member` (
  `arenaTeamId` int(10) unsigned NOT NULL DEFAULT '0',
  `guid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `weekGames` smallint(5) unsigned NOT NULL DEFAULT '0',
  `weekWins` smallint(5) unsigned NOT NULL DEFAULT '0',
  `seasonGames` smallint(5) unsigned NOT NULL DEFAULT '0',
  `seasonWins` smallint(5) unsigned NOT NULL DEFAULT '0',
  `personalRating` smallint(5) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`arenaTeamId`,`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `arena_team_member` */

LOCK TABLES `arena_team_member` WRITE;

UNLOCK TABLES;

/*Table structure for table `auctionhouse` */

DROP TABLE IF EXISTS `auctionhouse`;

CREATE TABLE `auctionhouse` (
  `id` int(10) unsigned NOT NULL DEFAULT '0',
  `auctioneerguid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `itemguid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `itemowner` bigint(20) unsigned NOT NULL DEFAULT '0',
  `buyoutprice` bigint(20) unsigned NOT NULL DEFAULT '0',
  `time` int(10) unsigned NOT NULL DEFAULT '0',
  `buyguid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `lastbid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `startbid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `deposit` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `item_guid` (`itemguid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `auctionhouse` */

LOCK TABLES `auctionhouse` WRITE;

UNLOCK TABLES;

/*Table structure for table `blackmarket_auctions` */

DROP TABLE IF EXISTS `blackmarket_auctions`;

CREATE TABLE `blackmarket_auctions` (
  `marketId` int(10) NOT NULL DEFAULT '0',
  `currentBid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `time` int(10) NOT NULL DEFAULT '0',
  `numBids` int(10) NOT NULL DEFAULT '0',
  `bidder` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`marketId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `blackmarket_auctions` */

LOCK TABLES `blackmarket_auctions` WRITE;

insert  into `blackmarket_auctions`(`marketId`,`currentBid`,`time`,`numBids`,`bidder`) values 
(5,0,1753042936,0,0),
(13,0,1753042936,0,0),
(23,0,1753042936,0,0),
(32,0,1753042936,0,0),
(39,0,1753042936,0,0),
(44,0,1753042936,0,0),
(47,0,1753042936,0,0),
(59,0,1753042936,0,0),
(61,0,1753042936,0,0),
(63,0,1753042936,0,0),
(64,0,1753042936,0,0),
(82,0,1753042936,0,0);

UNLOCK TABLES;

/*Table structure for table `bugreport` */

DROP TABLE IF EXISTS `bugreport`;

CREATE TABLE `bugreport` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Identifier',
  `type` longtext NOT NULL,
  `content` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Debug System';

/*Data for the table `bugreport` */

LOCK TABLES `bugreport` WRITE;

UNLOCK TABLES;

/*Table structure for table `calendar_events` */

DROP TABLE IF EXISTS `calendar_events`;

CREATE TABLE `calendar_events` (
  `EventID` bigint(20) unsigned NOT NULL DEFAULT '0',
  `Owner` bigint(20) unsigned NOT NULL DEFAULT '0',
  `Title` varchar(255) NOT NULL DEFAULT '',
  `Description` varchar(255) NOT NULL DEFAULT '',
  `EventType` tinyint(1) unsigned NOT NULL DEFAULT '4',
  `TextureID` int(10) NOT NULL DEFAULT '-1',
  `Date` int(10) unsigned NOT NULL DEFAULT '0',
  `Flags` int(10) unsigned NOT NULL DEFAULT '0',
  `LockDate` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`EventID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `calendar_events` */

LOCK TABLES `calendar_events` WRITE;

UNLOCK TABLES;

/*Table structure for table `calendar_invites` */

DROP TABLE IF EXISTS `calendar_invites`;

CREATE TABLE `calendar_invites` (
  `InviteID` bigint(20) unsigned NOT NULL DEFAULT '0',
  `EventID` bigint(20) unsigned NOT NULL DEFAULT '0',
  `Invitee` bigint(20) unsigned NOT NULL DEFAULT '0',
  `Sender` bigint(20) unsigned NOT NULL DEFAULT '0',
  `Status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `ResponseTime` int(10) unsigned NOT NULL DEFAULT '0',
  `ModerationRank` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `Note` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`InviteID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `calendar_invites` */

LOCK TABLES `calendar_invites` WRITE;

UNLOCK TABLES;

/*Table structure for table `channels` */

DROP TABLE IF EXISTS `channels`;

CREATE TABLE `channels` (
  `name` varchar(128) NOT NULL,
  `team` int(10) unsigned NOT NULL,
  `announce` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `ownership` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `password` varchar(32) DEFAULT NULL,
  `bannedList` text,
  `lastUsed` int(10) unsigned NOT NULL,
  PRIMARY KEY (`name`,`team`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Channel System';

/*Data for the table `channels` */

LOCK TABLES `channels` WRITE;

UNLOCK TABLES;

/*Table structure for table `character_account_data` */

DROP TABLE IF EXISTS `character_account_data`;

CREATE TABLE `character_account_data` (
  `guid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `time` int(10) unsigned NOT NULL DEFAULT '0',
  `data` blob NOT NULL,
  PRIMARY KEY (`guid`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `character_account_data` */

LOCK TABLES `character_account_data` WRITE;

UNLOCK TABLES;

/*Table structure for table `character_achievement` */

DROP TABLE IF EXISTS `character_achievement`;

CREATE TABLE `character_achievement` (
  `guid` bigint(20) unsigned NOT NULL,
  `achievement` int(10) unsigned NOT NULL,
  `date` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`,`achievement`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `character_achievement` */

LOCK TABLES `character_achievement` WRITE;

UNLOCK TABLES;

/*Table structure for table `character_achievement_progress` */

DROP TABLE IF EXISTS `character_achievement_progress`;

CREATE TABLE `character_achievement_progress` (
  `guid` bigint(20) unsigned NOT NULL,
  `criteria` int(10) unsigned NOT NULL,
  `counter` bigint(20) unsigned NOT NULL,
  `date` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`,`criteria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `character_achievement_progress` */

LOCK TABLES `character_achievement_progress` WRITE;

UNLOCK TABLES;

/*Table structure for table `character_action` */

DROP TABLE IF EXISTS `character_action`;

CREATE TABLE `character_action` (
  `guid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `spec` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `button` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `action` int(10) unsigned NOT NULL DEFAULT '0',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`,`spec`,`button`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `character_action` */

LOCK TABLES `character_action` WRITE;

UNLOCK TABLES;

/*Table structure for table `character_archaeology_branchs` */

DROP TABLE IF EXISTS `character_archaeology_branchs`;

CREATE TABLE `character_archaeology_branchs` (
  `guid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `projectId` smallint(5) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`,`projectId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `character_archaeology_branchs` */

LOCK TABLES `character_archaeology_branchs` WRITE;

UNLOCK TABLES;

/*Table structure for table `character_archaeology_digsites` */

DROP TABLE IF EXISTS `character_archaeology_digsites`;

CREATE TABLE `character_archaeology_digsites` (
  `guid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `digsiteId` smallint(5) unsigned NOT NULL DEFAULT '0',
  `point_x` float DEFAULT '0',
  `point_y` float DEFAULT '0',
  `count` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`,`digsiteId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `character_archaeology_digsites` */

LOCK TABLES `character_archaeology_digsites` WRITE;

UNLOCK TABLES;

/*Table structure for table `character_archaeology_history` */

DROP TABLE IF EXISTS `character_archaeology_history`;

CREATE TABLE `character_archaeology_history` (
  `guid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `time` smallint(5) unsigned NOT NULL DEFAULT '0',
  `projectId` int(10) unsigned NOT NULL DEFAULT '0',
  `count` smallint(5) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`,`projectId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `character_archaeology_history` */

LOCK TABLES `character_archaeology_history` WRITE;

UNLOCK TABLES;

/*Table structure for table `character_arena_data` */

DROP TABLE IF EXISTS `character_arena_data`;

CREATE TABLE `character_arena_data` (
  `guid` bigint(20) unsigned NOT NULL,
  `slot` tinyint(3) unsigned NOT NULL,
  `rating` int(10) unsigned NOT NULL DEFAULT '0',
  `bestRatingOfWeek` int(10) unsigned NOT NULL DEFAULT '0',
  `bestRatingOfSeason` int(10) unsigned NOT NULL DEFAULT '0',
  `matchMakerRating` int(10) unsigned NOT NULL DEFAULT '0',
  `weekGames` int(10) unsigned NOT NULL DEFAULT '0',
  `weekWins` int(10) unsigned NOT NULL DEFAULT '0',
  `prevWeekGames` int(10) unsigned NOT NULL DEFAULT '0',
  `prevWeekWins` int(10) unsigned NOT NULL DEFAULT '0',
  `seasonGames` int(10) unsigned NOT NULL DEFAULT '0',
  `seasonWins` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`,`slot`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `character_arena_data` */

LOCK TABLES `character_arena_data` WRITE;

UNLOCK TABLES;

/*Table structure for table `character_aura` */

DROP TABLE IF EXISTS `character_aura`;

CREATE TABLE `character_aura` (
  `guid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier',
  `casterGuid` binary(16) NOT NULL COMMENT 'Full Global Unique Identifier',
  `itemGuid` binary(16) NOT NULL,
  `spell` int(10) unsigned NOT NULL,
  `effectMask` int(10) unsigned NOT NULL,
  `recalculateMask` int(10) unsigned NOT NULL DEFAULT '0',
  `stackCount` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `maxDuration` int(11) NOT NULL DEFAULT '0',
  `remainTime` int(11) NOT NULL DEFAULT '0',
  `remainCharges` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `castItemLevel` int(11) NOT NULL DEFAULT '-1',
  PRIMARY KEY (`guid`,`casterGuid`,`itemGuid`,`spell`,`effectMask`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Player System';

/*Data for the table `character_aura` */

LOCK TABLES `character_aura` WRITE;

UNLOCK TABLES;

/*Table structure for table `character_aura_effect` */

DROP TABLE IF EXISTS `character_aura_effect`;

CREATE TABLE `character_aura_effect` (
  `guid` bigint(20) unsigned NOT NULL,
  `casterGuid` binary(16) NOT NULL COMMENT 'Full Global Unique Identifier',
  `itemGuid` binary(16) NOT NULL,
  `spell` int(10) unsigned NOT NULL,
  `effectMask` int(10) unsigned NOT NULL,
  `effectIndex` tinyint(3) unsigned NOT NULL,
  `amount` int(11) NOT NULL DEFAULT '0',
  `baseAmount` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`,`casterGuid`,`itemGuid`,`spell`,`effectMask`,`effectIndex`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Player System';

/*Data for the table `character_aura_effect` */

LOCK TABLES `character_aura_effect` WRITE;

UNLOCK TABLES;

/*Table structure for table `character_banned` */

DROP TABLE IF EXISTS `character_banned`;

CREATE TABLE `character_banned` (
  `guid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier',
  `bandate` int(10) unsigned NOT NULL DEFAULT '0',
  `unbandate` int(10) unsigned NOT NULL DEFAULT '0',
  `bannedby` varchar(50) NOT NULL,
  `banreason` varchar(255) NOT NULL,
  `active` tinyint(3) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`guid`,`bandate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Ban List';

/*Data for the table `character_banned` */

LOCK TABLES `character_banned` WRITE;

UNLOCK TABLES;

/*Table structure for table `character_battleground_data` */

DROP TABLE IF EXISTS `character_battleground_data`;

CREATE TABLE `character_battleground_data` (
  `guid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier',
  `instanceId` int(10) unsigned NOT NULL COMMENT 'Instance Identifier',
  `team` smallint(5) unsigned NOT NULL,
  `joinX` float NOT NULL DEFAULT '0',
  `joinY` float NOT NULL DEFAULT '0',
  `joinZ` float NOT NULL DEFAULT '0',
  `joinO` float NOT NULL DEFAULT '0',
  `joinMapId` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Map Identifier',
  `taxiStart` int(10) unsigned NOT NULL DEFAULT '0',
  `taxiEnd` int(10) unsigned NOT NULL DEFAULT '0',
  `mountSpell` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Player System';

/*Data for the table `character_battleground_data` */

LOCK TABLES `character_battleground_data` WRITE;

UNLOCK TABLES;

/*Table structure for table `character_battleground_random` */

DROP TABLE IF EXISTS `character_battleground_random`;

CREATE TABLE `character_battleground_random` (
  `guid` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `character_battleground_random` */

LOCK TABLES `character_battleground_random` WRITE;

UNLOCK TABLES;

/*Table structure for table `character_cuf_profiles` */

DROP TABLE IF EXISTS `character_cuf_profiles`;

CREATE TABLE `character_cuf_profiles` (
  `guid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Character Guid',
  `id` tinyint(3) unsigned NOT NULL COMMENT 'Profile Id (0-4)',
  `name` varchar(12) NOT NULL COMMENT 'Profile Name',
  `frameHeight` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Profile Frame Height',
  `frameWidth` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Profile Frame Width',
  `sortBy` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Frame Sort By',
  `healthText` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Frame Health Text',
  `boolOptions` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Many Configurable Bool Options',
  `topPoint` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Frame top alignment',
  `bottomPoint` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Frame bottom alignment',
  `leftPoint` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Frame left alignment',
  `topOffset` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Frame position offset from top',
  `bottomOffset` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Frame position offset from bottom',
  `leftOffset` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Frame position offset from left',
  PRIMARY KEY (`guid`,`id`),
  KEY `index` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `character_cuf_profiles` */

LOCK TABLES `character_cuf_profiles` WRITE;

UNLOCK TABLES;

/*Table structure for table `character_currency` */

DROP TABLE IF EXISTS `character_currency`;

CREATE TABLE `character_currency` (
  `CharacterGuid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `Currency` smallint(5) unsigned NOT NULL,
  `Quantity` int(10) unsigned NOT NULL,
  `WeeklyQuantity` int(10) unsigned NOT NULL,
  `TrackedQuantity` int(10) unsigned NOT NULL,
  `Flags` tinyint(3) unsigned NOT NULL,
  `WeekCap` int(10) unsigned NOT NULL,
  PRIMARY KEY (`CharacterGuid`,`Currency`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `character_currency` */

LOCK TABLES `character_currency` WRITE;

UNLOCK TABLES;

/*Table structure for table `character_declinedname` */

DROP TABLE IF EXISTS `character_declinedname`;

CREATE TABLE `character_declinedname` (
  `guid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier',
  `genitive` varchar(15) NOT NULL DEFAULT '',
  `dative` varchar(15) NOT NULL DEFAULT '',
  `accusative` varchar(15) NOT NULL DEFAULT '',
  `instrumental` varchar(15) NOT NULL DEFAULT '',
  `prepositional` varchar(15) NOT NULL DEFAULT '',
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `character_declinedname` */

LOCK TABLES `character_declinedname` WRITE;

UNLOCK TABLES;

/*Table structure for table `character_equipmentsets` */

DROP TABLE IF EXISTS `character_equipmentsets`;

CREATE TABLE `character_equipmentsets` (
  `guid` bigint(20) NOT NULL DEFAULT '0',
  `setguid` bigint(20) NOT NULL AUTO_INCREMENT,
  `setindex` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `name` varchar(31) NOT NULL,
  `iconname` varchar(100) NOT NULL,
  `ignore_mask` int(11) unsigned NOT NULL DEFAULT '0',
  `AssignedSpecIndex` int(11) NOT NULL DEFAULT '-1',
  `item0` bigint(20) unsigned NOT NULL DEFAULT '0',
  `item1` bigint(20) unsigned NOT NULL DEFAULT '0',
  `item2` bigint(20) unsigned NOT NULL DEFAULT '0',
  `item3` bigint(20) unsigned NOT NULL DEFAULT '0',
  `item4` bigint(20) unsigned NOT NULL DEFAULT '0',
  `item5` bigint(20) unsigned NOT NULL DEFAULT '0',
  `item6` bigint(20) unsigned NOT NULL DEFAULT '0',
  `item7` bigint(20) unsigned NOT NULL DEFAULT '0',
  `item8` bigint(20) unsigned NOT NULL DEFAULT '0',
  `item9` bigint(20) unsigned NOT NULL DEFAULT '0',
  `item10` bigint(20) unsigned NOT NULL DEFAULT '0',
  `item11` bigint(20) unsigned NOT NULL DEFAULT '0',
  `item12` bigint(20) unsigned NOT NULL DEFAULT '0',
  `item13` bigint(20) unsigned NOT NULL DEFAULT '0',
  `item14` bigint(20) unsigned NOT NULL DEFAULT '0',
  `item15` bigint(20) unsigned NOT NULL DEFAULT '0',
  `item16` bigint(20) unsigned NOT NULL DEFAULT '0',
  `item17` bigint(20) unsigned NOT NULL DEFAULT '0',
  `item18` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`setguid`),
  UNIQUE KEY `idx_set` (`guid`,`setguid`,`setindex`),
  KEY `Idx_setindex` (`setindex`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `character_equipmentsets` */

LOCK TABLES `character_equipmentsets` WRITE;

UNLOCK TABLES;

/*Table structure for table `character_fishingsteps` */

DROP TABLE IF EXISTS `character_fishingsteps`;

CREATE TABLE `character_fishingsteps` (
  `guid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier',
  `fishingSteps` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `character_fishingsteps` */

LOCK TABLES `character_fishingsteps` WRITE;

UNLOCK TABLES;

/*Table structure for table `character_garrison` */

DROP TABLE IF EXISTS `character_garrison`;

CREATE TABLE `character_garrison` (
  `guid` bigint(20) unsigned NOT NULL,
  `type` tinyint(3) unsigned NOT NULL,
  `siteLevelId` int(10) unsigned NOT NULL DEFAULT '0',
  `followerActivationsRemainingToday` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `character_garrison` */

LOCK TABLES `character_garrison` WRITE;

UNLOCK TABLES;

/*Table structure for table `character_garrison_blueprints` */

DROP TABLE IF EXISTS `character_garrison_blueprints`;

CREATE TABLE `character_garrison_blueprints` (
  `guid` bigint(20) unsigned NOT NULL,
  `garrison_type` tinyint(3) unsigned NOT NULL,
  `buildingId` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`,`garrison_type`,`buildingId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `character_garrison_blueprints` */

LOCK TABLES `character_garrison_blueprints` WRITE;

UNLOCK TABLES;

/*Table structure for table `character_garrison_buildings` */

DROP TABLE IF EXISTS `character_garrison_buildings`;

CREATE TABLE `character_garrison_buildings` (
  `guid` bigint(20) unsigned NOT NULL,
  `garrison_type` tinyint(3) unsigned NOT NULL,
  `plotInstanceId` int(10) unsigned NOT NULL DEFAULT '0',
  `buildingId` int(10) unsigned NOT NULL DEFAULT '0',
  `timeBuilt` bigint(20) unsigned NOT NULL,
  `active` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`,`garrison_type`,`plotInstanceId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `character_garrison_buildings` */

LOCK TABLES `character_garrison_buildings` WRITE;

UNLOCK TABLES;

/*Table structure for table `character_garrison_follower_abilities` */

DROP TABLE IF EXISTS `character_garrison_follower_abilities`;

CREATE TABLE `character_garrison_follower_abilities` (
  `dbId` bigint(20) unsigned NOT NULL,
  `abilityId` int(10) unsigned NOT NULL,
  `slot` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`dbId`,`abilityId`,`slot`),
  CONSTRAINT `fk_foll_dbid` FOREIGN KEY (`dbId`) REFERENCES `character_garrison_followers` (`dbId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `character_garrison_follower_abilities` */

LOCK TABLES `character_garrison_follower_abilities` WRITE;

UNLOCK TABLES;

/*Table structure for table `character_garrison_followers` */

DROP TABLE IF EXISTS `character_garrison_followers`;

CREATE TABLE `character_garrison_followers` (
  `dbId` bigint(20) unsigned NOT NULL,
  `guid` bigint(20) unsigned NOT NULL,
  `garrison_type` tinyint(3) unsigned NOT NULL,
  `followerId` int(10) unsigned NOT NULL,
  `quality` int(10) unsigned NOT NULL DEFAULT '2',
  `level` int(10) unsigned NOT NULL DEFAULT '90',
  `itemLevelWeapon` int(10) unsigned NOT NULL DEFAULT '600',
  `itemLevelArmor` int(10) unsigned NOT NULL DEFAULT '600',
  `xp` int(10) unsigned NOT NULL DEFAULT '0',
  `currentBuilding` int(10) unsigned NOT NULL DEFAULT '0',
  `currentMission` int(10) unsigned NOT NULL DEFAULT '0',
  `status` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`dbId`),
  UNIQUE KEY `idx_guid_id` (`guid`,`followerId`),
  CONSTRAINT `fk_foll_owner` FOREIGN KEY (`guid`) REFERENCES `characters` (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `character_garrison_followers` */

LOCK TABLES `character_garrison_followers` WRITE;

UNLOCK TABLES;

/*Table structure for table `character_garrison_mission_rewards` */

DROP TABLE IF EXISTS `character_garrison_mission_rewards`;

CREATE TABLE `character_garrison_mission_rewards` (
  `dbId` int(10) unsigned NOT NULL,
  `type` tinyint(3) unsigned NOT NULL,
  `itemId` int(10) NOT NULL DEFAULT '0',
  `itemQuantity` int(10) unsigned NOT NULL DEFAULT '0',
  `currencyId` int(10) NOT NULL DEFAULT '0',
  `currencyQuantity` int(10) unsigned NOT NULL DEFAULT '0',
  `FollowerXP` int(10) unsigned NOT NULL DEFAULT '0',
  `BonusAbilityId` int(10) unsigned NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `character_garrison_mission_rewards` */

LOCK TABLES `character_garrison_mission_rewards` WRITE;

UNLOCK TABLES;

/*Table structure for table `character_garrison_missions` */

DROP TABLE IF EXISTS `character_garrison_missions`;

CREATE TABLE `character_garrison_missions` (
  `dbId` bigint(20) unsigned NOT NULL,
  `guid` bigint(20) unsigned NOT NULL,
  `garrison_type` tinyint(3) unsigned NOT NULL,
  `missionId` int(10) unsigned NOT NULL,
  `offerTime` int(10) NOT NULL,
  `startTime` int(10) NOT NULL,
  `status` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`dbId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `character_garrison_missions` */

LOCK TABLES `character_garrison_missions` WRITE;

UNLOCK TABLES;

/*Table structure for table `character_gifts` */

DROP TABLE IF EXISTS `character_gifts`;

CREATE TABLE `character_gifts` (
  `guid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `item_guid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `entry` int(10) unsigned NOT NULL DEFAULT '0',
  `flags` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`item_guid`),
  KEY `idx_guid` (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `character_gifts` */

LOCK TABLES `character_gifts` WRITE;

UNLOCK TABLES;

/*Table structure for table `character_glyphs` */

DROP TABLE IF EXISTS `character_glyphs`;

CREATE TABLE `character_glyphs` (
  `guid` bigint(20) unsigned NOT NULL,
  `talentGroup` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `glyphId` smallint(5) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`,`talentGroup`,`glyphId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `character_glyphs` */

LOCK TABLES `character_glyphs` WRITE;

UNLOCK TABLES;

/*Table structure for table `character_homebind` */

DROP TABLE IF EXISTS `character_homebind`;

CREATE TABLE `character_homebind` (
  `guid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier',
  `mapId` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Map Identifier',
  `zoneId` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Zone Identifier',
  `posX` float NOT NULL DEFAULT '0',
  `posY` float NOT NULL DEFAULT '0',
  `posZ` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Player System';

/*Data for the table `character_homebind` */

LOCK TABLES `character_homebind` WRITE;

UNLOCK TABLES;

/*Table structure for table `character_instance` */

DROP TABLE IF EXISTS `character_instance`;

CREATE TABLE `character_instance` (
  `guid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `instance` int(10) unsigned NOT NULL DEFAULT '0',
  `permanent` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `extendState` tinyint(2) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`guid`,`instance`),
  KEY `instance` (`instance`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `character_instance` */

LOCK TABLES `character_instance` WRITE;

UNLOCK TABLES;

/*Table structure for table `character_inventory` */

DROP TABLE IF EXISTS `character_inventory`;

CREATE TABLE `character_inventory` (
  `guid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier',
  `bag` bigint(20) unsigned NOT NULL DEFAULT '0',
  `slot` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `item` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Item Global Unique Identifier',
  PRIMARY KEY (`item`),
  UNIQUE KEY `guid` (`guid`,`bag`,`slot`),
  KEY `idx_guid` (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Player System';

/*Data for the table `character_inventory` */

LOCK TABLES `character_inventory` WRITE;

UNLOCK TABLES;

/*Table structure for table `character_pet` */

DROP TABLE IF EXISTS `character_pet`;

CREATE TABLE `character_pet` (
  `id` int(10) unsigned NOT NULL DEFAULT '0',
  `entry` int(10) unsigned NOT NULL DEFAULT '0',
  `owner` bigint(10) unsigned NOT NULL DEFAULT '0',
  `modelid` int(10) unsigned DEFAULT '0',
  `CreatedBySpell` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `PetType` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `level` smallint(5) unsigned NOT NULL DEFAULT '1',
  `exp` int(10) unsigned NOT NULL DEFAULT '0',
  `Reactstate` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `name` varchar(21) NOT NULL DEFAULT 'Pet',
  `renamed` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `active` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `slot` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `curhealth` int(10) unsigned NOT NULL DEFAULT '1',
  `curmana` int(10) unsigned NOT NULL DEFAULT '0',
  `savetime` int(10) unsigned NOT NULL DEFAULT '0',
  `abdata` text,
  `specialization` smallint(5) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `owner` (`owner`),
  KEY `idx_slot` (`slot`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Pet System';

/*Data for the table `character_pet` */

LOCK TABLES `character_pet` WRITE;

UNLOCK TABLES;

/*Table structure for table `character_pet_declinedname` */

DROP TABLE IF EXISTS `character_pet_declinedname`;

CREATE TABLE `character_pet_declinedname` (
  `id` int(10) unsigned NOT NULL DEFAULT '0',
  `owner` int(10) unsigned NOT NULL DEFAULT '0',
  `genitive` varchar(12) NOT NULL DEFAULT '',
  `dative` varchar(12) NOT NULL DEFAULT '',
  `accusative` varchar(12) NOT NULL DEFAULT '',
  `instrumental` varchar(12) NOT NULL DEFAULT '',
  `prepositional` varchar(12) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `owner_key` (`owner`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `character_pet_declinedname` */

LOCK TABLES `character_pet_declinedname` WRITE;

UNLOCK TABLES;

/*Table structure for table `character_pvp_talent` */

DROP TABLE IF EXISTS `character_pvp_talent`;

CREATE TABLE `character_pvp_talent` (
  `Guid` bigint(20) unsigned NOT NULL,
  `TalentID` mediumint(8) unsigned NOT NULL,
  `TalentGroup` tinyint(3) unsigned NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `character_pvp_talent` */

LOCK TABLES `character_pvp_talent` WRITE;

UNLOCK TABLES;

/*Table structure for table `character_queststatus` */

DROP TABLE IF EXISTS `character_queststatus`;

CREATE TABLE `character_queststatus` (
  `guid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `quest` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `timer` int(10) unsigned NOT NULL DEFAULT '0',
  `explored` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`,`quest`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Player System';

/*Data for the table `character_queststatus` */

LOCK TABLES `character_queststatus` WRITE;

UNLOCK TABLES;

/*Table structure for table `character_queststatus_daily` */

DROP TABLE IF EXISTS `character_queststatus_daily`;

CREATE TABLE `character_queststatus_daily` (
  `guid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier',
  `quest` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Quest Identifier',
  `time` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`,`quest`),
  KEY `idx_guid` (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Player System';

/*Data for the table `character_queststatus_daily` */

LOCK TABLES `character_queststatus_daily` WRITE;

UNLOCK TABLES;

/*Table structure for table `character_queststatus_monthly` */

DROP TABLE IF EXISTS `character_queststatus_monthly`;

CREATE TABLE `character_queststatus_monthly` (
  `guid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier',
  `quest` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Quest Identifier',
  PRIMARY KEY (`guid`,`quest`),
  KEY `idx_guid` (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Player System';

/*Data for the table `character_queststatus_monthly` */

LOCK TABLES `character_queststatus_monthly` WRITE;

UNLOCK TABLES;

/*Table structure for table `character_queststatus_objectives` */

DROP TABLE IF EXISTS `character_queststatus_objectives`;

CREATE TABLE `character_queststatus_objectives` (
  `guid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `quest` int(10) unsigned NOT NULL DEFAULT '0',
  `objective` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `data` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`,`quest`,`objective`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Player System';

/*Data for the table `character_queststatus_objectives` */

LOCK TABLES `character_queststatus_objectives` WRITE;

UNLOCK TABLES;

/*Table structure for table `character_queststatus_objectives_criteria` */

DROP TABLE IF EXISTS `character_queststatus_objectives_criteria`;

CREATE TABLE `character_queststatus_objectives_criteria` (
  `guid` bigint(20) unsigned NOT NULL,
  `questObjectiveId` int(10) unsigned NOT NULL,
  PRIMARY KEY (`guid`,`questObjectiveId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Player System';

/*Data for the table `character_queststatus_objectives_criteria` */

LOCK TABLES `character_queststatus_objectives_criteria` WRITE;

UNLOCK TABLES;

/*Table structure for table `character_queststatus_objectives_criteria_progress` */

DROP TABLE IF EXISTS `character_queststatus_objectives_criteria_progress`;

CREATE TABLE `character_queststatus_objectives_criteria_progress` (
  `guid` bigint(20) unsigned NOT NULL,
  `criteriaId` int(10) unsigned NOT NULL,
  `counter` bigint(20) unsigned NOT NULL,
  `date` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`,`criteriaId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Player System';

/*Data for the table `character_queststatus_objectives_criteria_progress` */

LOCK TABLES `character_queststatus_objectives_criteria_progress` WRITE;

UNLOCK TABLES;

/*Table structure for table `character_queststatus_rewarded` */

DROP TABLE IF EXISTS `character_queststatus_rewarded`;

CREATE TABLE `character_queststatus_rewarded` (
  `guid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier',
  `quest` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Quest Identifier',
  `active` tinyint(10) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`guid`,`quest`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Player System';

/*Data for the table `character_queststatus_rewarded` */

LOCK TABLES `character_queststatus_rewarded` WRITE;

UNLOCK TABLES;

/*Table structure for table `character_queststatus_seasonal` */

DROP TABLE IF EXISTS `character_queststatus_seasonal`;

CREATE TABLE `character_queststatus_seasonal` (
  `guid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier',
  `quest` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Quest Identifier',
  `event` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Event Identifier',
  PRIMARY KEY (`guid`,`quest`),
  KEY `idx_guid` (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Player System';

/*Data for the table `character_queststatus_seasonal` */

LOCK TABLES `character_queststatus_seasonal` WRITE;

UNLOCK TABLES;

/*Table structure for table `character_queststatus_weekly` */

DROP TABLE IF EXISTS `character_queststatus_weekly`;

CREATE TABLE `character_queststatus_weekly` (
  `guid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier',
  `quest` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Quest Identifier',
  PRIMARY KEY (`guid`,`quest`),
  KEY `idx_guid` (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Player System';

/*Data for the table `character_queststatus_weekly` */

LOCK TABLES `character_queststatus_weekly` WRITE;

UNLOCK TABLES;

/*Table structure for table `character_recovery` */

DROP TABLE IF EXISTS `character_recovery`;

CREATE TABLE `character_recovery` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `delivered` tinyint(1) DEFAULT '0',
  `account` int(11) unsigned NOT NULL,
  `race` int(11) unsigned NOT NULL,
  `class` int(11) unsigned NOT NULL,
  `level` int(11) unsigned NOT NULL,
  `skill1` int(11) NOT NULL DEFAULT '0',
  `skill1_value` int(11) NOT NULL DEFAULT '0',
  `skill2` int(11) NOT NULL DEFAULT '0',
  `skill2_value` int(11) NOT NULL DEFAULT '0',
  `items` text NOT NULL,
  `spells` text NOT NULL,
  `at_login` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `character_recovery` */

LOCK TABLES `character_recovery` WRITE;

UNLOCK TABLES;

/*Table structure for table `character_reputation` */

DROP TABLE IF EXISTS `character_reputation`;

CREATE TABLE `character_reputation` (
  `guid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier',
  `faction` smallint(5) unsigned NOT NULL DEFAULT '0',
  `standing` int(11) NOT NULL DEFAULT '0',
  `flags` smallint(5) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`,`faction`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Player System';

/*Data for the table `character_reputation` */

LOCK TABLES `character_reputation` WRITE;

UNLOCK TABLES;

/*Table structure for table `character_shop` */

DROP TABLE IF EXISTS `character_shop`;

CREATE TABLE `character_shop` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `guid` bigint(20) NOT NULL,
  `type` tinyint(3) NOT NULL,
  `itemId` int(10) NOT NULL DEFAULT '0',
  `itemCount` int(10) NOT NULL DEFAULT '0',
  `delivered` tinyint(3) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `character_shop` */

LOCK TABLES `character_shop` WRITE;

UNLOCK TABLES;

/*Table structure for table `character_skills` */

DROP TABLE IF EXISTS `character_skills`;

CREATE TABLE `character_skills` (
  `guid` bigint(20) unsigned NOT NULL COMMENT 'Global Unique Identifier',
  `skill` smallint(5) unsigned NOT NULL,
  `value` smallint(5) unsigned NOT NULL,
  `max` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`guid`,`skill`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Player System';

/*Data for the table `character_skills` */

LOCK TABLES `character_skills` WRITE;

UNLOCK TABLES;

/*Table structure for table `character_social` */

DROP TABLE IF EXISTS `character_social`;

CREATE TABLE `character_social` (
  `guid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Character Global Unique Identifier',
  `friend` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Friend Global Unique Identifier',
  `flags` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Friend Flags',
  `note` varchar(48) NOT NULL DEFAULT '' COMMENT 'Friend Note',
  PRIMARY KEY (`guid`,`friend`,`flags`),
  KEY `friend` (`friend`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Player System';

/*Data for the table `character_social` */

LOCK TABLES `character_social` WRITE;

UNLOCK TABLES;

/*Table structure for table `character_spell` */

DROP TABLE IF EXISTS `character_spell`;

CREATE TABLE `character_spell` (
  `guid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier',
  `spell` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Spell Identifier',
  `active` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `disabled` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`,`spell`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Player System';

/*Data for the table `character_spell` */

LOCK TABLES `character_spell` WRITE;

UNLOCK TABLES;

/*Table structure for table `character_spell_charges` */

DROP TABLE IF EXISTS `character_spell_charges`;

CREATE TABLE `character_spell_charges` (
  `guid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier, Low part',
  `categoryId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'SpellCategory.dbc Identifier',
  `rechargeStart` int(10) unsigned NOT NULL DEFAULT '0',
  `rechargeEnd` int(10) unsigned NOT NULL DEFAULT '0',
  KEY `idx_guid` (`guid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `character_spell_charges` */

LOCK TABLES `character_spell_charges` WRITE;

UNLOCK TABLES;

/*Table structure for table `character_spell_cooldown` */

DROP TABLE IF EXISTS `character_spell_cooldown`;

CREATE TABLE `character_spell_cooldown` (
  `guid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier, Low part',
  `spell` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Spell Identifier',
  `item` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Item Identifier',
  `time` int(10) unsigned NOT NULL DEFAULT '0',
  `categoryId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Spell category Id',
  `categoryEnd` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`,`spell`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `character_spell_cooldown` */

LOCK TABLES `character_spell_cooldown` WRITE;

UNLOCK TABLES;

/*Table structure for table `character_stats` */

DROP TABLE IF EXISTS `character_stats`;

CREATE TABLE `character_stats` (
  `guid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier, Low part',
  `maxhealth` int(10) unsigned NOT NULL DEFAULT '0',
  `maxpower1` int(10) unsigned NOT NULL DEFAULT '0',
  `maxpower2` int(10) unsigned NOT NULL DEFAULT '0',
  `maxpower3` int(10) unsigned NOT NULL DEFAULT '0',
  `maxpower4` int(10) unsigned NOT NULL DEFAULT '0',
  `maxpower5` int(10) unsigned NOT NULL DEFAULT '0',
  `maxpower6` int(10) unsigned NOT NULL DEFAULT '0',
  `strength` int(10) unsigned NOT NULL DEFAULT '0',
  `agility` int(10) unsigned NOT NULL DEFAULT '0',
  `stamina` int(10) unsigned NOT NULL DEFAULT '0',
  `intellect` int(10) unsigned NOT NULL DEFAULT '0',
  `armor` int(10) unsigned NOT NULL DEFAULT '0',
  `resHoly` int(10) unsigned NOT NULL DEFAULT '0',
  `resFire` int(10) unsigned NOT NULL DEFAULT '0',
  `resNature` int(10) unsigned NOT NULL DEFAULT '0',
  `resFrost` int(10) unsigned NOT NULL DEFAULT '0',
  `resShadow` int(10) unsigned NOT NULL DEFAULT '0',
  `resArcane` int(10) unsigned NOT NULL DEFAULT '0',
  `blockPct` float unsigned NOT NULL DEFAULT '0',
  `dodgePct` float unsigned NOT NULL DEFAULT '0',
  `parryPct` float unsigned NOT NULL DEFAULT '0',
  `critPct` float unsigned NOT NULL DEFAULT '0',
  `rangedCritPct` float unsigned NOT NULL DEFAULT '0',
  `spellCritPct` float unsigned NOT NULL DEFAULT '0',
  `attackPower` int(10) unsigned NOT NULL DEFAULT '0',
  `rangedAttackPower` int(10) unsigned NOT NULL DEFAULT '0',
  `spellPower` int(10) unsigned NOT NULL DEFAULT '0',
  `resilience` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `character_stats` */

LOCK TABLES `character_stats` WRITE;

UNLOCK TABLES;

/*Table structure for table `character_talent` */

DROP TABLE IF EXISTS `character_talent`;

CREATE TABLE `character_talent` (
  `guid` bigint(20) unsigned NOT NULL,
  `talentId` mediumint(8) unsigned NOT NULL,
  `talentGroup` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`,`talentId`,`talentGroup`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `character_talent` */

LOCK TABLES `character_talent` WRITE;

UNLOCK TABLES;

/*Table structure for table `character_transmog_outfits` */

DROP TABLE IF EXISTS `character_transmog_outfits`;

CREATE TABLE `character_transmog_outfits` (
  `guid` bigint(20) NOT NULL DEFAULT '0',
  `setguid` bigint(20) NOT NULL AUTO_INCREMENT,
  `setindex` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `name` varchar(128) NOT NULL,
  `iconname` varchar(256) NOT NULL,
  `ignore_mask` int(11) NOT NULL DEFAULT '0',
  `appearance0` int(10) NOT NULL DEFAULT '0',
  `appearance1` int(10) NOT NULL DEFAULT '0',
  `appearance2` int(10) NOT NULL DEFAULT '0',
  `appearance3` int(10) NOT NULL DEFAULT '0',
  `appearance4` int(10) NOT NULL DEFAULT '0',
  `appearance5` int(10) NOT NULL DEFAULT '0',
  `appearance6` int(10) NOT NULL DEFAULT '0',
  `appearance7` int(10) NOT NULL DEFAULT '0',
  `appearance8` int(10) NOT NULL DEFAULT '0',
  `appearance9` int(10) NOT NULL DEFAULT '0',
  `appearance10` int(10) NOT NULL DEFAULT '0',
  `appearance11` int(10) NOT NULL DEFAULT '0',
  `appearance12` int(10) NOT NULL DEFAULT '0',
  `appearance13` int(10) NOT NULL DEFAULT '0',
  `appearance14` int(10) NOT NULL DEFAULT '0',
  `appearance15` int(10) NOT NULL DEFAULT '0',
  `appearance16` int(10) NOT NULL DEFAULT '0',
  `appearance17` int(10) NOT NULL DEFAULT '0',
  `appearance18` int(10) NOT NULL DEFAULT '0',
  `mainHandEnchant` int(10) NOT NULL DEFAULT '0',
  `offHandEnchant` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`setguid`),
  UNIQUE KEY `idx_set` (`guid`,`setguid`,`setindex`),
  KEY `Idx_setindex` (`setindex`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `character_transmog_outfits` */

LOCK TABLES `character_transmog_outfits` WRITE;

UNLOCK TABLES;

/*Table structure for table `character_void_storage` */

DROP TABLE IF EXISTS `character_void_storage`;

CREATE TABLE `character_void_storage` (
  `itemId` bigint(20) unsigned NOT NULL,
  `playerGuid` bigint(20) unsigned NOT NULL,
  `itemEntry` mediumint(8) unsigned NOT NULL,
  `slot` tinyint(3) unsigned NOT NULL,
  `creatorGuid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `randomPropertyType` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `randomProperty` int(10) unsigned NOT NULL DEFAULT '0',
  `suffixFactor` int(10) unsigned NOT NULL DEFAULT '0',
  `upgradeId` int(10) unsigned NOT NULL DEFAULT '0',
  `fixedScalingLevel` int(10) unsigned DEFAULT '0',
  `artifactKnowledgeLevel` int(10) unsigned DEFAULT '0',
  `challengeId` int(10) unsigned NOT NULL DEFAULT '0',
  `challengeLevel` int(10) unsigned NOT NULL DEFAULT '0',
  `challengeAffix1` int(10) unsigned NOT NULL DEFAULT '0',
  `challengeAffix2` int(10) unsigned NOT NULL DEFAULT '0',
  `challengeAffix3` int(10) unsigned NOT NULL DEFAULT '0',
  `challengeIsCharged` int(10) unsigned NOT NULL DEFAULT '0',
  `context` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `bonusListIDs` text,
  PRIMARY KEY (`itemId`),
  UNIQUE KEY `idx_player_slot` (`playerGuid`,`slot`),
  KEY `idx_player` (`playerGuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `character_void_storage` */

LOCK TABLES `character_void_storage` WRITE;

UNLOCK TABLES;

/*Table structure for table `character_world_quest` */

DROP TABLE IF EXISTS `character_world_quest`;

CREATE TABLE `character_world_quest` (
  `guid` bigint(20) unsigned NOT NULL,
  `questId` int(10) unsigned NOT NULL,
  `lastupdate` int(10) unsigned NOT NULL,
  `timer` int(10) unsigned NOT NULL,
  `variableID` int(10) unsigned NOT NULL,
  `value` int(10) NOT NULL,
  PRIMARY KEY (`guid`,`questId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `character_world_quest` */

LOCK TABLES `character_world_quest` WRITE;

UNLOCK TABLES;

/*Table structure for table `characters` */

DROP TABLE IF EXISTS `characters`;

CREATE TABLE `characters` (
  `guid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier',
  `account` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Account Identifier',
  `name` varchar(12) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `slot` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `race` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `class` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `gender` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `level` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `xp` int(10) unsigned NOT NULL DEFAULT '0',
  `money` bigint(20) unsigned NOT NULL DEFAULT '0',
  `skin` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `face` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `hairStyle` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `hairColor` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `facialStyle` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `customDisplay1` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `customDisplay2` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `customDisplay3` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `inventorySlots` tinyint(3) unsigned NOT NULL DEFAULT '16',
  `bankSlots` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `restState` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `playerFlags` int(10) unsigned NOT NULL DEFAULT '0',
  `playerFlagsEx` int(10) unsigned NOT NULL DEFAULT '0',
  `position_x` float NOT NULL DEFAULT '0',
  `position_y` float NOT NULL DEFAULT '0',
  `position_z` float NOT NULL DEFAULT '0',
  `map` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Map Identifier',
  `instance_id` int(10) unsigned NOT NULL DEFAULT '0',
  `dungeonDifficulty` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `raidDifficulty` tinyint(3) unsigned NOT NULL DEFAULT '14',
  `legacyRaidDifficulty` tinyint(3) unsigned NOT NULL DEFAULT '3',
  `orientation` float NOT NULL DEFAULT '0',
  `taximask` text NOT NULL,
  `online` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `cinematic` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `totaltime` int(10) unsigned NOT NULL DEFAULT '0',
  `leveltime` int(10) unsigned NOT NULL DEFAULT '0',
  `logout_time` int(10) unsigned NOT NULL DEFAULT '0',
  `is_logout_resting` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `rest_bonus` float NOT NULL DEFAULT '0',
  `resettalents_cost` int(10) unsigned NOT NULL DEFAULT '0',
  `resettalents_time` int(10) unsigned NOT NULL DEFAULT '0',
  `primarySpecialization` int(10) unsigned NOT NULL DEFAULT '0',
  `trans_x` float NOT NULL DEFAULT '0',
  `trans_y` float NOT NULL DEFAULT '0',
  `trans_z` float NOT NULL DEFAULT '0',
  `trans_o` float NOT NULL DEFAULT '0',
  `transguid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `extra_flags` smallint(5) unsigned NOT NULL DEFAULT '0',
  `stable_slots` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `at_login` smallint(5) unsigned NOT NULL DEFAULT '0',
  `zone` smallint(5) unsigned NOT NULL DEFAULT '0',
  `death_expire_time` int(10) unsigned NOT NULL DEFAULT '0',
  `taxi_path` text,
  `totalKills` int(10) unsigned NOT NULL DEFAULT '0',
  `todayKills` smallint(5) unsigned NOT NULL DEFAULT '0',
  `yesterdayKills` smallint(5) unsigned NOT NULL DEFAULT '0',
  `chosenTitle` int(10) unsigned NOT NULL DEFAULT '0',
  `watchedFaction` int(10) unsigned NOT NULL DEFAULT '0',
  `drunk` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `health` int(10) unsigned NOT NULL DEFAULT '0',
  `power1` int(10) unsigned NOT NULL DEFAULT '0',
  `power2` int(10) unsigned NOT NULL DEFAULT '0',
  `power3` int(10) unsigned NOT NULL DEFAULT '0',
  `power4` int(10) unsigned NOT NULL DEFAULT '0',
  `power5` int(10) unsigned NOT NULL DEFAULT '0',
  `power6` int(10) unsigned NOT NULL DEFAULT '0',
  `latency` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `activeTalentGroup` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `lootSpecId` int(10) unsigned NOT NULL DEFAULT '0',
  `exploredZones` longtext,
  `equipmentCache` longtext,
  `knownTitles` longtext,
  `actionBars` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `grantableLevels` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `xpRate` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `deleteInfos_Account` int(10) unsigned DEFAULT NULL,
  `deleteInfos_Name` varchar(12) DEFAULT NULL,
  `deleteDate` int(10) unsigned DEFAULT NULL,
  `honor` int(10) unsigned NOT NULL DEFAULT '0',
  `honorLevel` int(10) unsigned NOT NULL DEFAULT '1',
  `prestigeLevel` int(10) unsigned NOT NULL DEFAULT '0',
  `honorRestState` tinyint(3) unsigned NOT NULL DEFAULT '2',
  `honorRestBonus` float NOT NULL DEFAULT '0',
  `lastLoginBuild` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`),
  KEY `idx_account` (`account`),
  KEY `idx_online` (`online`),
  KEY `idx_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Player System';

/*Data for the table `characters` */

LOCK TABLES `characters` WRITE;

UNLOCK TABLES;

/*Table structure for table `corpse` */

DROP TABLE IF EXISTS `corpse`;

CREATE TABLE `corpse` (
  `guid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Character Global Unique Identifier',
  `posX` float NOT NULL DEFAULT '0',
  `posY` float NOT NULL DEFAULT '0',
  `posZ` float NOT NULL DEFAULT '0',
  `orientation` float NOT NULL DEFAULT '0',
  `mapId` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Map Identifier',
  `displayId` int(10) unsigned NOT NULL DEFAULT '0',
  `itemCache` text NOT NULL,
  `bytes1` int(10) unsigned NOT NULL DEFAULT '0',
  `bytes2` int(10) unsigned NOT NULL DEFAULT '0',
  `flags` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `dynFlags` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `time` int(10) unsigned NOT NULL DEFAULT '0',
  `corpseType` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `instanceId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Instance Identifier',
  PRIMARY KEY (`guid`),
  KEY `idx_type` (`corpseType`),
  KEY `idx_instance` (`instanceId`),
  KEY `idx_time` (`time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Death System';

/*Data for the table `corpse` */

LOCK TABLES `corpse` WRITE;

UNLOCK TABLES;

/*Table structure for table `corpse_phases` */

DROP TABLE IF EXISTS `corpse_phases`;

CREATE TABLE `corpse_phases` (
  `OwnerGuid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `PhaseId` int(10) unsigned NOT NULL,
  PRIMARY KEY (`OwnerGuid`,`PhaseId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `corpse_phases` */

LOCK TABLES `corpse_phases` WRITE;

UNLOCK TABLES;

/*Table structure for table `creature_respawn` */

DROP TABLE IF EXISTS `creature_respawn`;

CREATE TABLE `creature_respawn` (
  `guid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier',
  `respawnTime` int(10) unsigned NOT NULL DEFAULT '0',
  `mapId` smallint(10) unsigned NOT NULL DEFAULT '0',
  `instanceId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Instance Identifier',
  PRIMARY KEY (`guid`,`instanceId`),
  KEY `idx_instance` (`instanceId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Grid Loading System';

/*Data for the table `creature_respawn` */

LOCK TABLES `creature_respawn` WRITE;

UNLOCK TABLES;

/*Table structure for table `game_event_condition_save` */

DROP TABLE IF EXISTS `game_event_condition_save`;

CREATE TABLE `game_event_condition_save` (
  `eventEntry` tinyint(3) unsigned NOT NULL,
  `condition_id` int(10) unsigned NOT NULL DEFAULT '0',
  `done` float DEFAULT '0',
  PRIMARY KEY (`eventEntry`,`condition_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `game_event_condition_save` */

LOCK TABLES `game_event_condition_save` WRITE;

UNLOCK TABLES;

/*Table structure for table `game_event_save` */

DROP TABLE IF EXISTS `game_event_save`;

CREATE TABLE `game_event_save` (
  `eventEntry` tinyint(3) unsigned NOT NULL,
  `state` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `next_start` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`eventEntry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `game_event_save` */

LOCK TABLES `game_event_save` WRITE;

UNLOCK TABLES;

/*Table structure for table `gameobject_respawn` */

DROP TABLE IF EXISTS `gameobject_respawn`;

CREATE TABLE `gameobject_respawn` (
  `guid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier',
  `respawnTime` int(10) unsigned NOT NULL DEFAULT '0',
  `mapId` smallint(10) unsigned NOT NULL DEFAULT '0',
  `instanceId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Instance Identifier',
  PRIMARY KEY (`guid`,`instanceId`),
  KEY `idx_instance` (`instanceId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Grid Loading System';

/*Data for the table `gameobject_respawn` */

LOCK TABLES `gameobject_respawn` WRITE;

UNLOCK TABLES;

/*Table structure for table `gm_bug` */

DROP TABLE IF EXISTS `gm_bug`;

CREATE TABLE `gm_bug` (
  `id` int(10) unsigned NOT NULL,
  `playerGuid` bigint(20) unsigned NOT NULL,
  `note` text NOT NULL,
  `createTime` int(10) unsigned NOT NULL DEFAULT '0',
  `mapId` smallint(5) unsigned NOT NULL DEFAULT '0',
  `posX` float NOT NULL DEFAULT '0',
  `posY` float NOT NULL DEFAULT '0',
  `posZ` float NOT NULL DEFAULT '0',
  `facing` float NOT NULL DEFAULT '0',
  `closedBy` bigint(20) NOT NULL DEFAULT '0',
  `assignedTo` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'GUID of admin to whom ticket is assigned',
  `comment` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `gm_bug` */

LOCK TABLES `gm_bug` WRITE;

UNLOCK TABLES;

/*Table structure for table `gm_complaint` */

DROP TABLE IF EXISTS `gm_complaint`;

CREATE TABLE `gm_complaint` (
  `id` int(10) unsigned NOT NULL,
  `playerGuid` bigint(20) unsigned NOT NULL,
  `note` text NOT NULL,
  `createTime` int(10) unsigned NOT NULL DEFAULT '0',
  `mapId` smallint(5) unsigned NOT NULL DEFAULT '0',
  `posX` float NOT NULL DEFAULT '0',
  `posY` float NOT NULL DEFAULT '0',
  `posZ` float NOT NULL DEFAULT '0',
  `facing` float NOT NULL DEFAULT '0',
  `targetCharacterGuid` bigint(20) unsigned NOT NULL,
  `complaintType` smallint(5) unsigned NOT NULL,
  `reportLineIndex` int(10) NOT NULL,
  `closedBy` bigint(20) NOT NULL DEFAULT '0',
  `assignedTo` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'GUID of admin to whom ticket is assigned',
  `comment` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `gm_complaint` */

LOCK TABLES `gm_complaint` WRITE;

UNLOCK TABLES;

/*Table structure for table `gm_complaint_chatlog` */

DROP TABLE IF EXISTS `gm_complaint_chatlog`;

CREATE TABLE `gm_complaint_chatlog` (
  `complaintId` int(10) unsigned NOT NULL,
  `lineId` int(10) unsigned NOT NULL,
  `timestamp` int(10) unsigned NOT NULL,
  `text` text NOT NULL,
  PRIMARY KEY (`complaintId`,`lineId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `gm_complaint_chatlog` */

LOCK TABLES `gm_complaint_chatlog` WRITE;

UNLOCK TABLES;

/*Table structure for table `gm_suggestion` */

DROP TABLE IF EXISTS `gm_suggestion`;

CREATE TABLE `gm_suggestion` (
  `id` int(10) unsigned NOT NULL,
  `playerGuid` bigint(20) unsigned NOT NULL,
  `note` text NOT NULL,
  `createTime` int(10) unsigned NOT NULL DEFAULT '0',
  `mapId` smallint(5) unsigned NOT NULL DEFAULT '0',
  `posX` float NOT NULL DEFAULT '0',
  `posY` float NOT NULL DEFAULT '0',
  `posZ` float NOT NULL DEFAULT '0',
  `facing` float NOT NULL DEFAULT '0',
  `closedBy` bigint(20) NOT NULL DEFAULT '0',
  `assignedTo` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'GUID of admin to whom ticket is assigned',
  `comment` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `gm_suggestion` */

LOCK TABLES `gm_suggestion` WRITE;

UNLOCK TABLES;

/*Table structure for table `group_instance` */

DROP TABLE IF EXISTS `group_instance`;

CREATE TABLE `group_instance` (
  `guid` int(10) unsigned NOT NULL DEFAULT '0',
  `instance` int(10) unsigned NOT NULL DEFAULT '0',
  `permanent` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`,`instance`),
  KEY `instance` (`instance`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `group_instance` */

LOCK TABLES `group_instance` WRITE;

UNLOCK TABLES;

/*Table structure for table `group_member` */

DROP TABLE IF EXISTS `group_member`;

CREATE TABLE `group_member` (
  `guid` int(10) unsigned NOT NULL,
  `memberGuid` bigint(20) unsigned NOT NULL,
  `memberFlags` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `subgroup` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `roles` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`memberGuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Groups';

/*Data for the table `group_member` */

LOCK TABLES `group_member` WRITE;

UNLOCK TABLES;

/*Table structure for table `groups` */

DROP TABLE IF EXISTS `groups`;

CREATE TABLE `groups` (
  `guid` int(10) unsigned NOT NULL,
  `leaderGuid` bigint(20) unsigned NOT NULL,
  `lootMethod` tinyint(3) unsigned NOT NULL,
  `looterGuid` bigint(20) unsigned NOT NULL,
  `lootThreshold` tinyint(3) unsigned NOT NULL,
  `icon1` binary(16) NOT NULL,
  `icon2` binary(16) NOT NULL,
  `icon3` binary(16) NOT NULL,
  `icon4` binary(16) NOT NULL,
  `icon5` binary(16) NOT NULL,
  `icon6` binary(16) NOT NULL,
  `icon7` binary(16) NOT NULL,
  `icon8` binary(16) NOT NULL,
  `groupType` tinyint(3) unsigned NOT NULL,
  `difficulty` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `raidDifficulty` tinyint(3) unsigned NOT NULL DEFAULT '14',
  `legacyRaidDifficulty` tinyint(3) unsigned NOT NULL DEFAULT '3',
  `masterLooterGuid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`guid`),
  KEY `leaderGuid` (`leaderGuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Groups';

/*Data for the table `groups` */

LOCK TABLES `groups` WRITE;

UNLOCK TABLES;

/*Table structure for table `guild` */

DROP TABLE IF EXISTS `guild`;

CREATE TABLE `guild` (
  `guildid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `name` varchar(24) NOT NULL DEFAULT '',
  `leaderguid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `EmblemStyle` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `EmblemColor` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `BorderStyle` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `BorderColor` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `BackgroundColor` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `info` varchar(500) NOT NULL DEFAULT '',
  `motd` varchar(128) NOT NULL DEFAULT '',
  `createdate` int(10) unsigned NOT NULL DEFAULT '0',
  `BankMoney` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guildid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Guild System';

/*Data for the table `guild` */

LOCK TABLES `guild` WRITE;

UNLOCK TABLES;

/*Table structure for table `guild_achievement` */

DROP TABLE IF EXISTS `guild_achievement`;

CREATE TABLE `guild_achievement` (
  `guildId` bigint(20) unsigned NOT NULL,
  `achievement` int(10) unsigned NOT NULL,
  `date` int(10) unsigned NOT NULL DEFAULT '0',
  `guids` text NOT NULL,
  PRIMARY KEY (`guildId`,`achievement`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `guild_achievement` */

LOCK TABLES `guild_achievement` WRITE;

UNLOCK TABLES;

/*Table structure for table `guild_achievement_progress` */

DROP TABLE IF EXISTS `guild_achievement_progress`;

CREATE TABLE `guild_achievement_progress` (
  `guildId` bigint(20) unsigned NOT NULL,
  `criteria` int(10) unsigned NOT NULL,
  `counter` bigint(20) unsigned NOT NULL,
  `date` int(10) unsigned NOT NULL DEFAULT '0',
  `completedGuid` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guildId`,`criteria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `guild_achievement_progress` */

LOCK TABLES `guild_achievement_progress` WRITE;

UNLOCK TABLES;

/*Table structure for table `guild_bank_eventlog` */

DROP TABLE IF EXISTS `guild_bank_eventlog`;

CREATE TABLE `guild_bank_eventlog` (
  `guildid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Guild Identificator',
  `LogGuid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Log record identificator - auxiliary column',
  `TabId` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Guild bank TabId',
  `EventType` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Event type',
  `PlayerGuid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `ItemOrMoney` bigint(20) unsigned NOT NULL DEFAULT '0',
  `ItemStackCount` smallint(5) unsigned NOT NULL DEFAULT '0',
  `DestTabId` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Destination Tab Id',
  `TimeStamp` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Event UNIX time',
  PRIMARY KEY (`guildid`,`LogGuid`,`TabId`),
  KEY `guildid_key` (`guildid`),
  KEY `Idx_PlayerGuid` (`PlayerGuid`),
  KEY `Idx_LogGuid` (`LogGuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `guild_bank_eventlog` */

LOCK TABLES `guild_bank_eventlog` WRITE;

UNLOCK TABLES;

/*Table structure for table `guild_bank_item` */

DROP TABLE IF EXISTS `guild_bank_item`;

CREATE TABLE `guild_bank_item` (
  `guildid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `TabId` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `SlotId` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `item_guid` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guildid`,`TabId`,`SlotId`),
  KEY `guildid_key` (`guildid`),
  KEY `Idx_item_guid` (`item_guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `guild_bank_item` */

LOCK TABLES `guild_bank_item` WRITE;

UNLOCK TABLES;

/*Table structure for table `guild_bank_right` */

DROP TABLE IF EXISTS `guild_bank_right`;

CREATE TABLE `guild_bank_right` (
  `guildid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `TabId` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `rid` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `gbright` tinyint(3) NOT NULL DEFAULT '0',
  `SlotPerDay` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`guildid`,`TabId`,`rid`),
  KEY `guildid_key` (`guildid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `guild_bank_right` */

LOCK TABLES `guild_bank_right` WRITE;

UNLOCK TABLES;

/*Table structure for table `guild_bank_tab` */

DROP TABLE IF EXISTS `guild_bank_tab`;

CREATE TABLE `guild_bank_tab` (
  `guildid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `TabId` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `TabName` varchar(16) NOT NULL DEFAULT '',
  `TabIcon` varchar(100) NOT NULL DEFAULT '',
  `TabText` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`guildid`,`TabId`),
  KEY `guildid_key` (`guildid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `guild_bank_tab` */

LOCK TABLES `guild_bank_tab` WRITE;

UNLOCK TABLES;

/*Table structure for table `guild_eventlog` */

DROP TABLE IF EXISTS `guild_eventlog`;

CREATE TABLE `guild_eventlog` (
  `guildid` bigint(20) unsigned NOT NULL COMMENT 'Guild Identificator',
  `LogGuid` int(10) unsigned NOT NULL COMMENT 'Log record identificator - auxiliary column',
  `EventType` tinyint(3) unsigned NOT NULL COMMENT 'Event type',
  `PlayerGuid1` bigint(20) unsigned NOT NULL COMMENT 'Player 1',
  `PlayerGuid2` bigint(20) unsigned NOT NULL COMMENT 'Player 2',
  `NewRank` tinyint(3) unsigned NOT NULL COMMENT 'New rank(in case promotion/demotion)',
  `TimeStamp` int(10) unsigned NOT NULL COMMENT 'Event UNIX time',
  PRIMARY KEY (`guildid`,`LogGuid`),
  KEY `Idx_PlayerGuid1` (`PlayerGuid1`),
  KEY `Idx_PlayerGuid2` (`PlayerGuid2`),
  KEY `Idx_LogGuid` (`LogGuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Guild Eventlog';

/*Data for the table `guild_eventlog` */

LOCK TABLES `guild_eventlog` WRITE;

UNLOCK TABLES;

/*Table structure for table `guild_finder_applicant` */

DROP TABLE IF EXISTS `guild_finder_applicant`;

CREATE TABLE `guild_finder_applicant` (
  `guildId` bigint(20) unsigned NOT NULL DEFAULT '0',
  `playerGuid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `availability` tinyint(3) unsigned DEFAULT '0',
  `classRole` tinyint(3) unsigned DEFAULT '0',
  `interests` tinyint(3) unsigned DEFAULT '0',
  `comment` varchar(255) DEFAULT NULL,
  `submitTime` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`guildId`,`playerGuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `guild_finder_applicant` */

LOCK TABLES `guild_finder_applicant` WRITE;

UNLOCK TABLES;

/*Table structure for table `guild_finder_guild_settings` */

DROP TABLE IF EXISTS `guild_finder_guild_settings`;

CREATE TABLE `guild_finder_guild_settings` (
  `guildId` bigint(20) unsigned NOT NULL,
  `availability` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `classRoles` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `interests` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `level` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `listed` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `comment` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`guildId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `guild_finder_guild_settings` */

LOCK TABLES `guild_finder_guild_settings` WRITE;

UNLOCK TABLES;

/*Table structure for table `guild_member` */

DROP TABLE IF EXISTS `guild_member`;

CREATE TABLE `guild_member` (
  `guildid` bigint(20) unsigned NOT NULL COMMENT 'Guild Identificator',
  `guid` bigint(20) unsigned NOT NULL,
  `rank` tinyint(3) unsigned NOT NULL,
  `pnote` varchar(31) NOT NULL DEFAULT '',
  `offnote` varchar(31) NOT NULL DEFAULT '',
  UNIQUE KEY `guid_key` (`guid`),
  KEY `guildid_key` (`guildid`),
  KEY `guildid_rank_key` (`guildid`,`rank`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Guild System';

/*Data for the table `guild_member` */

LOCK TABLES `guild_member` WRITE;

UNLOCK TABLES;

/*Table structure for table `guild_member_withdraw` */

DROP TABLE IF EXISTS `guild_member_withdraw`;

CREATE TABLE `guild_member_withdraw` (
  `guid` bigint(20) unsigned NOT NULL,
  `tab0` int(10) unsigned NOT NULL DEFAULT '0',
  `tab1` int(10) unsigned NOT NULL DEFAULT '0',
  `tab2` int(10) unsigned NOT NULL DEFAULT '0',
  `tab3` int(10) unsigned NOT NULL DEFAULT '0',
  `tab4` int(10) unsigned NOT NULL DEFAULT '0',
  `tab5` int(10) unsigned NOT NULL DEFAULT '0',
  `tab6` int(10) unsigned NOT NULL DEFAULT '0',
  `tab7` int(10) unsigned NOT NULL DEFAULT '0',
  `money` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Guild Member Daily Withdraws';

/*Data for the table `guild_member_withdraw` */

LOCK TABLES `guild_member_withdraw` WRITE;

UNLOCK TABLES;

/*Table structure for table `guild_newslog` */

DROP TABLE IF EXISTS `guild_newslog`;

CREATE TABLE `guild_newslog` (
  `guildid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Guild Identificator',
  `LogGuid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Log record identificator - auxiliary column',
  `EventType` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Event type',
  `PlayerGuid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `Flags` int(10) unsigned NOT NULL DEFAULT '0',
  `Value` int(10) unsigned NOT NULL DEFAULT '0',
  `TimeStamp` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Event UNIX time',
  PRIMARY KEY (`guildid`,`LogGuid`),
  KEY `guildid_key` (`guildid`),
  KEY `Idx_PlayerGuid` (`PlayerGuid`),
  KEY `Idx_LogGuid` (`LogGuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `guild_newslog` */

LOCK TABLES `guild_newslog` WRITE;

UNLOCK TABLES;

/*Table structure for table `guild_rank` */

DROP TABLE IF EXISTS `guild_rank`;

CREATE TABLE `guild_rank` (
  `guildid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `rid` tinyint(3) unsigned NOT NULL,
  `rname` varchar(20) NOT NULL DEFAULT '',
  `rights` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `BankMoneyPerDay` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guildid`,`rid`),
  KEY `Idx_rid` (`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Guild System';

/*Data for the table `guild_rank` */

LOCK TABLES `guild_rank` WRITE;

UNLOCK TABLES;

/*Table structure for table `instance` */

DROP TABLE IF EXISTS `instance`;

CREATE TABLE `instance` (
  `id` int(10) unsigned NOT NULL DEFAULT '0',
  `map` smallint(5) unsigned NOT NULL DEFAULT '0',
  `resettime` int(10) unsigned NOT NULL DEFAULT '0',
  `difficulty` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `completedEncounters` int(10) unsigned NOT NULL DEFAULT '0',
  `data` tinytext NOT NULL,
  `entranceId` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `map` (`map`),
  KEY `resettime` (`resettime`),
  KEY `difficulty` (`difficulty`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `instance` */

LOCK TABLES `instance` WRITE;

UNLOCK TABLES;

/*Table structure for table `instance_reset` */

DROP TABLE IF EXISTS `instance_reset`;

CREATE TABLE `instance_reset` (
  `mapid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `difficulty` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `resettime` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`mapid`,`difficulty`),
  KEY `difficulty` (`difficulty`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `instance_reset` */

LOCK TABLES `instance_reset` WRITE;

insert  into `instance_reset`(`mapid`,`difficulty`,`resettime`) values 
(33,2,1426996800),
(36,2,1426996800),
(249,3,1427515200),
(249,4,1427515200),
(269,2,1426996800),
(409,9,1427515200),
(469,9,1427515200),
(509,3,1427169600),
(531,9,1427515200),
(532,3,1427515200),
(533,3,1427515200),
(533,4,1427515200),
(534,4,1427515200),
(540,2,1426996800),
(542,2,1426996800),
(543,2,1426996800),
(544,4,1427515200),
(545,2,1426996800),
(546,2,1426996800),
(547,2,1426996800),
(548,4,1427515200),
(550,4,1427515200),
(552,2,1426996800),
(553,2,1426996800),
(554,2,1426996800),
(555,2,1426996800),
(556,2,1426996800),
(557,2,1426996800),
(558,2,1426996800),
(560,2,1426996800),
(564,4,1427515200),
(565,4,1427515200),
(568,2,1426996800),
(574,2,1426996800),
(575,2,1426996800),
(576,2,1426996800),
(578,2,1426996800),
(580,4,1427515200),
(585,2,1426996800),
(595,2,1426996800),
(598,2,1426996800),
(599,2,1426996800),
(600,2,1426996800),
(601,2,1426996800),
(602,2,1426996800),
(603,3,1427515200),
(603,4,1427515200),
(604,2,1426996800),
(608,2,1426996800),
(615,3,1427515200),
(615,4,1427515200),
(616,3,1427515200),
(616,4,1427515200),
(619,2,1426996800),
(624,3,1427515200),
(624,4,1427515200),
(631,3,1427515200),
(631,4,1427515200),
(631,5,1427515200),
(631,6,1427515200),
(632,2,1426996800),
(643,2,1426996800),
(644,2,1426996800),
(645,2,1426996800),
(649,3,1427515200),
(649,4,1427515200),
(649,5,1427515200),
(649,6,1427515200),
(650,2,1426996800),
(657,2,1426996800),
(658,2,1426996800),
(668,2,1426996800),
(669,3,1427515200),
(669,4,1427515200),
(669,5,1427515200),
(669,6,1427515200),
(670,2,1426996800),
(671,3,1427515200),
(671,4,1427515200),
(671,5,1427515200),
(671,6,1427515200),
(720,3,1427515200),
(720,4,1427515200),
(720,5,1427515200),
(720,6,1427515200),
(724,3,1427515200),
(724,4,1427515200),
(724,5,1427515200),
(724,6,1427515200),
(725,2,1426996800),
(754,3,1427515200),
(754,4,1427515200),
(754,5,1427515200),
(754,6,1427515200),
(755,2,1426996800),
(757,3,1427515200),
(757,4,1427515200),
(757,5,1427515200),
(757,6,1427515200),
(859,2,1426996800),
(938,2,1426996800),
(939,2,1426996800),
(940,2,1426996800),
(959,2,1426996800),
(960,2,1426996800),
(961,2,1426996800),
(962,2,1426996800),
(967,3,1427515200),
(967,4,1427515200),
(967,5,1427515200),
(967,6,1427515200),
(994,2,1426996800),
(996,3,1427515200),
(996,4,1427515200),
(996,5,1427515200),
(996,6,1427515200),
(1001,2,1426996800),
(1004,2,1426996800),
(1007,2,1426996800),
(1008,3,1427515200),
(1008,4,1427515200),
(1008,5,1427515200),
(1008,6,1427515200),
(1009,3,1427515200),
(1009,4,1427515200),
(1009,5,1427515200),
(1009,6,1427515200),
(1011,2,1426996800),
(1098,3,1427515200),
(1098,4,1427515200),
(1098,5,1427515200),
(1098,6,1427515200),
(1136,14,1427515200),
(1136,15,1427515200),
(1136,16,1427515200),
(1175,2,1426996800),
(1176,2,1426996800),
(1182,2,1426996800),
(1195,2,1426996800),
(1205,14,1427515200),
(1205,15,1427515200),
(1205,16,1427515200),
(1208,2,1426996800),
(1209,2,1426996800),
(1228,14,1427515200),
(1228,15,1427515200),
(1228,16,1427515200),
(1279,2,1426996800),
(1358,2,1426996800);

UNLOCK TABLES;

/*Table structure for table `instance_scenario_progress` */

DROP TABLE IF EXISTS `instance_scenario_progress`;

CREATE TABLE `instance_scenario_progress` (
  `id` int(10) unsigned NOT NULL,
  `criteria` int(10) unsigned NOT NULL,
  `counter` bigint(20) unsigned NOT NULL,
  `date` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`criteria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `instance_scenario_progress` */

LOCK TABLES `instance_scenario_progress` WRITE;

UNLOCK TABLES;

/*Table structure for table `item_instance` */

DROP TABLE IF EXISTS `item_instance`;

CREATE TABLE `item_instance` (
  `guid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `itemEntry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `owner_guid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `creatorGuid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `giftCreatorGuid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `count` int(10) unsigned NOT NULL DEFAULT '1',
  `duration` int(10) NOT NULL DEFAULT '0',
  `charges` tinytext,
  `flags` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `enchantments` text NOT NULL,
  `randomPropertyType` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `randomPropertyId` int(10) unsigned NOT NULL DEFAULT '0',
  `durability` smallint(5) unsigned NOT NULL DEFAULT '0',
  `playedTime` int(10) unsigned NOT NULL DEFAULT '0',
  `text` text,
  `transmogrification` int(10) unsigned NOT NULL DEFAULT '0',
  `upgradeId` int(10) unsigned NOT NULL DEFAULT '0',
  `enchantIllusion` int(10) unsigned NOT NULL DEFAULT '0',
  `battlePetSpeciesId` int(10) unsigned NOT NULL DEFAULT '0',
  `battlePetBreedData` int(10) unsigned NOT NULL DEFAULT '0',
  `battlePetLevel` smallint(5) unsigned NOT NULL DEFAULT '0',
  `battlePetDisplayId` int(10) unsigned NOT NULL DEFAULT '0',
  `context` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `bonusListIDs` text,
  PRIMARY KEY (`guid`),
  KEY `idx_owner_guid` (`owner_guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Item System';

/*Data for the table `item_instance` */

LOCK TABLES `item_instance` WRITE;

UNLOCK TABLES;

/*Table structure for table `item_instance_artifact` */

DROP TABLE IF EXISTS `item_instance_artifact`;

CREATE TABLE `item_instance_artifact` (
  `itemGuid` bigint(20) unsigned NOT NULL,
  `xp` bigint(20) unsigned NOT NULL DEFAULT '0',
  `artifactAppearanceId` int(10) unsigned NOT NULL DEFAULT '0',
  `artifactTierId` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`itemGuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `item_instance_artifact` */

LOCK TABLES `item_instance_artifact` WRITE;

UNLOCK TABLES;

/*Table structure for table `item_instance_artifact_powers` */

DROP TABLE IF EXISTS `item_instance_artifact_powers`;

CREATE TABLE `item_instance_artifact_powers` (
  `itemGuid` bigint(20) unsigned NOT NULL,
  `artifactPowerId` int(10) unsigned NOT NULL,
  `purchasedRank` tinyint(3) unsigned DEFAULT '0',
  PRIMARY KEY (`itemGuid`,`artifactPowerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `item_instance_artifact_powers` */

LOCK TABLES `item_instance_artifact_powers` WRITE;

UNLOCK TABLES;

/*Table structure for table `item_instance_gems` */

DROP TABLE IF EXISTS `item_instance_gems`;

CREATE TABLE `item_instance_gems` (
  `itemGuid` bigint(20) unsigned NOT NULL,
  `gemItemId1` int(10) unsigned NOT NULL DEFAULT '0',
  `gemBonuses1` text,
  `gemContext1` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `gemScalingLevel1` int(10) unsigned NOT NULL DEFAULT '0',
  `gemItemId2` int(10) unsigned NOT NULL DEFAULT '0',
  `gemBonuses2` text,
  `gemContext2` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `gemScalingLevel2` int(10) unsigned NOT NULL DEFAULT '0',
  `gemItemId3` int(10) unsigned NOT NULL DEFAULT '0',
  `gemBonuses3` text,
  `gemContext3` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `gemScalingLevel3` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`itemGuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `item_instance_gems` */

LOCK TABLES `item_instance_gems` WRITE;

UNLOCK TABLES;

/*Table structure for table `item_instance_modifiers` */

DROP TABLE IF EXISTS `item_instance_modifiers`;

CREATE TABLE `item_instance_modifiers` (
  `itemGuid` bigint(20) unsigned NOT NULL,
  `fixedScalingLevel` int(10) unsigned DEFAULT '0',
  `artifactKnowledgeLevel` int(10) unsigned DEFAULT '0',
  `challengeId` int(10) unsigned NOT NULL DEFAULT '0',
  `challengeLevel` int(10) unsigned NOT NULL DEFAULT '0',
  `challengeAffix1` int(10) unsigned NOT NULL DEFAULT '0',
  `challengeAffix2` int(10) unsigned NOT NULL DEFAULT '0',
  `challengeAffix3` int(10) unsigned NOT NULL DEFAULT '0',
  `challengeIsCharged` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`itemGuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `item_instance_modifiers` */

LOCK TABLES `item_instance_modifiers` WRITE;

UNLOCK TABLES;

/*Table structure for table `item_instance_transmog` */

DROP TABLE IF EXISTS `item_instance_transmog`;

CREATE TABLE `item_instance_transmog` (
  `itemGuid` bigint(20) unsigned NOT NULL,
  `itemModifiedAppearanceAllSpecs` int(11) NOT NULL DEFAULT '0',
  `itemModifiedAppearanceSpec1` int(11) NOT NULL DEFAULT '0',
  `itemModifiedAppearanceSpec2` int(11) NOT NULL DEFAULT '0',
  `itemModifiedAppearanceSpec3` int(11) NOT NULL DEFAULT '0',
  `itemModifiedAppearanceSpec4` int(11) NOT NULL DEFAULT '0',
  `spellItemEnchantmentAllSpecs` int(11) NOT NULL DEFAULT '0',
  `spellItemEnchantmentSpec1` int(11) NOT NULL DEFAULT '0',
  `spellItemEnchantmentSpec2` int(11) NOT NULL DEFAULT '0',
  `spellItemEnchantmentSpec3` int(11) NOT NULL DEFAULT '0',
  `spellItemEnchantmentSpec4` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`itemGuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `item_instance_transmog` */

LOCK TABLES `item_instance_transmog` WRITE;

UNLOCK TABLES;

/*Table structure for table `item_loot_items` */

DROP TABLE IF EXISTS `item_loot_items`;

CREATE TABLE `item_loot_items` (
  `container_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'guid of container (item_instance.guid)',
  `item_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'loot item entry (item_instance.itemEntry)',
  `item_count` int(10) NOT NULL DEFAULT '0' COMMENT 'stack size',
  `follow_rules` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'follow loot rules',
  `ffa` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'free-for-all',
  `blocked` tinyint(1) NOT NULL DEFAULT '0',
  `counted` tinyint(1) NOT NULL DEFAULT '0',
  `under_threshold` tinyint(1) NOT NULL DEFAULT '0',
  `needs_quest` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'quest drop',
  `rnd_type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'random enchantment type',
  `rnd_prop` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'random enchantment added when originally rolled',
  `rnd_suffix` int(10) NOT NULL DEFAULT '0' COMMENT 'random suffix added when originally rolled',
  `context` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `bonus_list_ids` text COMMENT 'Space separated list of bonus list ids',
  PRIMARY KEY (`container_id`,`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `item_loot_items` */

LOCK TABLES `item_loot_items` WRITE;

UNLOCK TABLES;

/*Table structure for table `item_loot_money` */

DROP TABLE IF EXISTS `item_loot_money`;

CREATE TABLE `item_loot_money` (
  `container_id` bigint(20) NOT NULL DEFAULT '0' COMMENT 'guid of container (item_instance.guid)',
  `money` int(10) NOT NULL DEFAULT '0' COMMENT 'money loot (in copper)',
  PRIMARY KEY (`container_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `item_loot_money` */

LOCK TABLES `item_loot_money` WRITE;

UNLOCK TABLES;

/*Table structure for table `item_refund_instance` */

DROP TABLE IF EXISTS `item_refund_instance`;

CREATE TABLE `item_refund_instance` (
  `item_guid` bigint(20) unsigned NOT NULL COMMENT 'Item GUID',
  `player_guid` bigint(20) unsigned NOT NULL COMMENT 'Player GUID',
  `paidMoney` bigint(20) unsigned NOT NULL DEFAULT '0',
  `paidExtendedCost` smallint(5) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`item_guid`,`player_guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Item Refund System';

/*Data for the table `item_refund_instance` */

LOCK TABLES `item_refund_instance` WRITE;

UNLOCK TABLES;

/*Table structure for table `item_soulbound_trade_data` */

DROP TABLE IF EXISTS `item_soulbound_trade_data`;

CREATE TABLE `item_soulbound_trade_data` (
  `itemGuid` bigint(20) unsigned NOT NULL COMMENT 'Item GUID',
  `allowedPlayers` text NOT NULL COMMENT 'Space separated GUID list of players who can receive this item in trade',
  PRIMARY KEY (`itemGuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Item Refund System';

/*Data for the table `item_soulbound_trade_data` */

LOCK TABLES `item_soulbound_trade_data` WRITE;

UNLOCK TABLES;

/*Table structure for table `lfg_data` */

DROP TABLE IF EXISTS `lfg_data`;

CREATE TABLE `lfg_data` (
  `guid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier',
  `dungeon` int(10) unsigned NOT NULL DEFAULT '0',
  `state` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='LFG Data';

/*Data for the table `lfg_data` */

LOCK TABLES `lfg_data` WRITE;

UNLOCK TABLES;

/*Table structure for table `log_gm` */

DROP TABLE IF EXISTS `log_gm`;

CREATE TABLE `log_gm` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `gm_account_id` bigint(20) DEFAULT NULL,
  `gm_account_name` blob,
  `gm_character_id` bigint(20) DEFAULT NULL,
  `gm_character_name` blob,
  `gm_ip` text,
  `target_account_id` bigint(20) DEFAULT NULL,
  `target_account_name` blob,
  `target_character_id` bigint(20) DEFAULT NULL,
  `target_character_name` blob,
  `target_ip` text,
  `command` blob,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `log_gm` */

LOCK TABLES `log_gm` WRITE;

UNLOCK TABLES;

/*Table structure for table `mail` */

DROP TABLE IF EXISTS `mail`;

CREATE TABLE `mail` (
  `id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Identifier',
  `messageType` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `stationery` tinyint(3) NOT NULL DEFAULT '41',
  `mailTemplateId` smallint(5) unsigned NOT NULL DEFAULT '0',
  `sender` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Character Global Unique Identifier',
  `receiver` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Character Global Unique Identifier',
  `subject` longtext,
  `body` longtext,
  `has_items` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `expire_time` int(10) unsigned NOT NULL DEFAULT '0',
  `deliver_time` int(10) unsigned NOT NULL DEFAULT '0',
  `money` bigint(20) unsigned NOT NULL DEFAULT '0',
  `cod` bigint(20) unsigned NOT NULL DEFAULT '0',
  `checked` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_receiver` (`receiver`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Mail System';

/*Data for the table `mail` */

LOCK TABLES `mail` WRITE;

UNLOCK TABLES;

/*Table structure for table `mail_items` */

DROP TABLE IF EXISTS `mail_items`;

CREATE TABLE `mail_items` (
  `mail_id` int(10) unsigned NOT NULL DEFAULT '0',
  `item_guid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `receiver` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Character Global Unique Identifier',
  PRIMARY KEY (`item_guid`),
  KEY `idx_receiver` (`receiver`),
  KEY `idx_mail_id` (`mail_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `mail_items` */

LOCK TABLES `mail_items` WRITE;

UNLOCK TABLES;

/*Table structure for table `pet_aura` */

DROP TABLE IF EXISTS `pet_aura`;

CREATE TABLE `pet_aura` (
  `guid` int(10) unsigned NOT NULL COMMENT 'Global Unique Identifier',
  `casterGuid` binary(16) NOT NULL COMMENT 'Full Global Unique Identifier',
  `spell` int(10) unsigned NOT NULL,
  `effectMask` int(10) unsigned NOT NULL,
  `recalculateMask` int(10) unsigned NOT NULL DEFAULT '0',
  `stackCount` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `maxDuration` int(11) NOT NULL DEFAULT '0',
  `remainTime` int(11) NOT NULL DEFAULT '0',
  `remainCharges` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`,`spell`,`effectMask`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Pet System';

/*Data for the table `pet_aura` */

LOCK TABLES `pet_aura` WRITE;

UNLOCK TABLES;

/*Table structure for table `pet_aura_effect` */

DROP TABLE IF EXISTS `pet_aura_effect`;

CREATE TABLE `pet_aura_effect` (
  `guid` int(10) unsigned NOT NULL COMMENT 'Global Unique Identifier',
  `casterGuid` binary(16) NOT NULL COMMENT 'Full Global Unique Identifier',
  `spell` int(10) unsigned NOT NULL,
  `effectMask` int(10) unsigned NOT NULL,
  `effectIndex` tinyint(3) unsigned NOT NULL,
  `amount` int(11) NOT NULL DEFAULT '0',
  `baseAmount` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`,`casterGuid`,`spell`,`effectMask`,`effectIndex`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Pet System';

/*Data for the table `pet_aura_effect` */

LOCK TABLES `pet_aura_effect` WRITE;

UNLOCK TABLES;

/*Table structure for table `pet_spell` */

DROP TABLE IF EXISTS `pet_spell`;

CREATE TABLE `pet_spell` (
  `guid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier',
  `spell` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Spell Identifier',
  `active` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`,`spell`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Pet System';

/*Data for the table `pet_spell` */

LOCK TABLES `pet_spell` WRITE;

UNLOCK TABLES;

/*Table structure for table `pet_spell_charges` */

DROP TABLE IF EXISTS `pet_spell_charges`;

CREATE TABLE `pet_spell_charges` (
  `guid` int(10) unsigned NOT NULL,
  `categoryId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'SpellCategory.dbc Identifier',
  `rechargeStart` int(10) unsigned NOT NULL DEFAULT '0',
  `rechargeEnd` int(10) unsigned NOT NULL DEFAULT '0',
  KEY `idx_guid` (`guid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `pet_spell_charges` */

LOCK TABLES `pet_spell_charges` WRITE;

UNLOCK TABLES;

/*Table structure for table `pet_spell_cooldown` */

DROP TABLE IF EXISTS `pet_spell_cooldown`;

CREATE TABLE `pet_spell_cooldown` (
  `guid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier, Low part',
  `spell` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Spell Identifier',
  `time` int(10) unsigned NOT NULL DEFAULT '0',
  `categoryId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Spell category Id',
  `categoryEnd` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`,`spell`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `pet_spell_cooldown` */

LOCK TABLES `pet_spell_cooldown` WRITE;

UNLOCK TABLES;

/*Table structure for table `petition` */

DROP TABLE IF EXISTS `petition`;

CREATE TABLE `petition` (
  `ownerguid` bigint(20) unsigned NOT NULL,
  `petitionguid` bigint(20) unsigned DEFAULT '0',
  `name` varchar(24) NOT NULL,
  PRIMARY KEY (`ownerguid`),
  UNIQUE KEY `index_ownerguid_petitionguid` (`ownerguid`,`petitionguid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Guild System';

/*Data for the table `petition` */

LOCK TABLES `petition` WRITE;

UNLOCK TABLES;

/*Table structure for table `petition_sign` */

DROP TABLE IF EXISTS `petition_sign`;

CREATE TABLE `petition_sign` (
  `ownerguid` bigint(20) unsigned NOT NULL,
  `petitionguid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `playerguid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `player_account` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`petitionguid`,`playerguid`),
  KEY `Idx_playerguid` (`playerguid`),
  KEY `Idx_ownerguid` (`ownerguid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Guild System';

/*Data for the table `petition_sign` */

LOCK TABLES `petition_sign` WRITE;

UNLOCK TABLES;

/*Table structure for table `pool_quest_save` */

DROP TABLE IF EXISTS `pool_quest_save`;

CREATE TABLE `pool_quest_save` (
  `pool_id` int(10) unsigned NOT NULL DEFAULT '0',
  `quest_id` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`pool_id`,`quest_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `pool_quest_save` */

LOCK TABLES `pool_quest_save` WRITE;

insert  into `pool_quest_save`(`pool_id`,`quest_id`) values 
(346,29345),
(347,26588),
(348,25155),
(349,25162),
(350,26420),
(351,26190),
(352,29355),
(353,29342),
(354,29365),
(355,29332),
(356,29320),
(357,29313),
(358,29323),
(359,11381),
(360,11665),
(361,13833),
(362,13102),
(363,12960),
(364,31335);

UNLOCK TABLES;

/*Table structure for table `pvpstats_battlegrounds` */

DROP TABLE IF EXISTS `pvpstats_battlegrounds`;

CREATE TABLE `pvpstats_battlegrounds` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `winner_faction` tinyint(4) NOT NULL,
  `bracket_id` tinyint(3) unsigned NOT NULL,
  `type` tinyint(3) unsigned NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `pvpstats_battlegrounds` */

LOCK TABLES `pvpstats_battlegrounds` WRITE;

UNLOCK TABLES;

/*Table structure for table `pvpstats_players` */

DROP TABLE IF EXISTS `pvpstats_players`;

CREATE TABLE `pvpstats_players` (
  `battleground_id` bigint(20) unsigned NOT NULL,
  `character_guid` bigint(20) unsigned NOT NULL,
  `winner` bit(1) NOT NULL,
  `score_killing_blows` int(10) unsigned NOT NULL,
  `score_deaths` int(10) unsigned NOT NULL,
  `score_honorable_kills` int(10) unsigned NOT NULL,
  `score_bonus_honor` int(10) unsigned NOT NULL,
  `score_damage_done` int(10) unsigned NOT NULL,
  `score_healing_done` int(10) unsigned NOT NULL,
  `attr_1` int(10) unsigned NOT NULL,
  `attr_2` int(10) unsigned NOT NULL,
  `attr_3` int(10) unsigned NOT NULL,
  `attr_4` int(10) unsigned NOT NULL,
  `attr_5` int(10) unsigned NOT NULL,
  PRIMARY KEY (`battleground_id`,`character_guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `pvpstats_players` */

LOCK TABLES `pvpstats_players` WRITE;

UNLOCK TABLES;

/*Table structure for table `quest_tracker` */

DROP TABLE IF EXISTS `quest_tracker`;

CREATE TABLE `quest_tracker` (
  `id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `character_guid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `quest_accept_time` datetime NOT NULL,
  `quest_complete_time` datetime DEFAULT NULL,
  `quest_abandon_time` datetime DEFAULT NULL,
  `completed_by_gm` tinyint(1) NOT NULL DEFAULT '0',
  `core_hash` varchar(120) NOT NULL DEFAULT '0',
  `core_revision` varchar(120) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`character_guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `quest_tracker` */

LOCK TABLES `quest_tracker` WRITE;

UNLOCK TABLES;

/*Table structure for table `reserved_name` */

DROP TABLE IF EXISTS `reserved_name`;

CREATE TABLE `reserved_name` (
  `name` varchar(12) NOT NULL DEFAULT '',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Player Reserved Names';

/*Data for the table `reserved_name` */

LOCK TABLES `reserved_name` WRITE;

UNLOCK TABLES;

/*Table structure for table `updates` */

DROP TABLE IF EXISTS `updates`;

CREATE TABLE `updates` (
  `name` varchar(200) NOT NULL COMMENT 'filename with extension of the update.',
  `hash` char(40) DEFAULT '' COMMENT 'sha1 hash of the sql file.',
  `state` enum('RELEASED','ARCHIVED') NOT NULL DEFAULT 'RELEASED' COMMENT 'defines if an update is released or archived.',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'timestamp when the query was applied.',
  `speed` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'time the query takes to apply in ms.',
  PRIMARY KEY (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='List of all applied updates in this database.';

/*Data for the table `updates` */

LOCK TABLES `updates` WRITE;

UNLOCK TABLES;

/*Table structure for table `updates_include` */

DROP TABLE IF EXISTS `updates_include`;

CREATE TABLE `updates_include` (
  `path` varchar(200) NOT NULL COMMENT 'directory to include. $ means relative to the source directory.',
  `state` enum('RELEASED','ARCHIVED') NOT NULL DEFAULT 'RELEASED' COMMENT 'defines if the directory contains released or archived updates.',
  PRIMARY KEY (`path`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='List of directories where we want to include sql updates.';

/*Data for the table `updates_include` */

LOCK TABLES `updates_include` WRITE;

insert  into `updates_include`(`path`,`state`) values 
('$/sql/updates/characters','RELEASED'),
('$/sql/old/7/characters/2025','ARCHIVED');

UNLOCK TABLES;

/*Table structure for table `warden_action` */

DROP TABLE IF EXISTS `warden_action`;

CREATE TABLE `warden_action` (
  `wardenId` smallint(5) unsigned NOT NULL,
  `action` tinyint(3) unsigned DEFAULT NULL,
  PRIMARY KEY (`wardenId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `warden_action` */

LOCK TABLES `warden_action` WRITE;

UNLOCK TABLES;

/*Table structure for table `world_quest` */

DROP TABLE IF EXISTS `world_quest`;

CREATE TABLE `world_quest` (
  `id` int(10) unsigned NOT NULL,
  `rewardid` int(10) unsigned NOT NULL,
  `starttime` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `world_quest` */

LOCK TABLES `world_quest` WRITE;

UNLOCK TABLES;

/*Table structure for table `worldstates` */

DROP TABLE IF EXISTS `worldstates`;

CREATE TABLE `worldstates` (
  `entry` int(10) unsigned NOT NULL DEFAULT '0',
  `value` int(10) unsigned NOT NULL DEFAULT '0',
  `comment` tinytext,
  PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Variable Saves';

/*Data for the table `worldstates` */

LOCK TABLES `worldstates` WRITE;

insert  into `worldstates`(`entry`,`value`,`comment`) values 
(1,0,NULL),
(2,0,NULL),
(3,0,NULL),
(4,0,NULL),
(5,0,NULL),
(6,0,NULL),
(7,0,NULL),
(8,0,NULL),
(9,0,NULL),
(10,0,NULL),
(11,0,NULL),
(12,0,NULL),
(13,0,NULL),
(14,0,NULL),
(15,0,NULL),
(16,0,NULL),
(17,0,NULL),
(18,0,NULL),
(19,0,NULL),
(20,0,NULL),
(21,0,NULL),
(22,0,NULL),
(23,0,NULL),
(24,0,NULL),
(25,0,NULL),
(26,0,NULL),
(27,0,NULL),
(28,0,NULL),
(29,0,NULL),
(30,0,NULL),
(31,0,NULL),
(32,0,NULL),
(33,0,NULL),
(34,0,NULL),
(35,0,NULL),
(36,0,NULL),
(37,0,NULL),
(38,0,NULL),
(39,0,NULL),
(40,0,NULL),
(41,0,NULL),
(42,0,NULL),
(43,0,NULL),
(44,0,NULL),
(45,0,NULL),
(46,0,NULL),
(47,0,NULL),
(48,0,NULL),
(49,0,NULL),
(50,0,NULL),
(51,0,NULL),
(52,0,NULL),
(53,0,NULL),
(54,0,NULL),
(55,0,NULL),
(56,0,NULL),
(57,0,NULL),
(58,0,NULL),
(59,0,NULL),
(60,0,NULL),
(61,0,NULL),
(62,0,NULL),
(63,0,NULL),
(64,0,NULL),
(65,0,NULL),
(66,0,NULL),
(67,0,NULL),
(68,0,NULL),
(69,0,NULL),
(70,0,NULL),
(71,0,NULL),
(72,0,NULL),
(73,0,NULL),
(74,0,NULL),
(75,0,NULL),
(76,0,NULL),
(77,0,NULL),
(78,0,NULL),
(79,0,NULL),
(80,0,NULL),
(81,0,NULL),
(82,0,NULL),
(83,0,NULL),
(84,0,NULL),
(85,0,NULL),
(86,0,NULL),
(87,0,NULL),
(88,0,NULL),
(89,0,NULL),
(90,0,NULL),
(91,0,NULL),
(92,0,NULL),
(93,0,NULL),
(94,0,NULL),
(95,0,NULL),
(96,0,NULL),
(97,0,NULL),
(98,0,NULL),
(99,0,NULL),
(100,0,NULL),
(101,0,NULL),
(102,0,NULL),
(103,0,NULL),
(3781,9000000,NULL),
(3801,0,NULL),
(3802,1,NULL),
(5332,600000,NULL),
(5334,1,NULL),
(5344,0,NULL),
(5384,0,NULL),
(5385,1,NULL),
(5387,1,NULL),
(5546,0,NULL),
(5547,0,NULL),
(20001,1753502400,'NextArenaPointDistributionTime'),
(20002,1753561326,'NextWeeklyQuestResetTime'),
(20003,1752984000,'NextBGRandomDailyResetTime'),
(20004,0,'cleaning_flags'),
(20006,1752984000,NULL),
(20007,1753999200,NULL),
(20050,1,NULL);

UNLOCK TABLES;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
