DROP TABLE IF EXISTS `garrssion_mission_reward`;
CREATE TABLE `garrssion_mission_reward` (
  `MissionId` INT(11) NOT NULL,
  `RewardType` INT(11) NOT NULL DEFAULT '0',
  `RewardId` INT(11) NOT NULL DEFAULT '0',
  `RewardCount` INT(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`MissionId`, `RewardType`, `RewardId`, `RewardCount`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
