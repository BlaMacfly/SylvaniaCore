-- Gossip: the friendship reputation a creature's gossip window shows (Sunsong Ranch farmers).
CREATE TABLE IF NOT EXISTS `gossip_menu_addon` (
  `MenuID` INT UNSIGNED NOT NULL DEFAULT 0,
  `FriendshipFactionID` INT NOT NULL DEFAULT 0,
  `VerifiedBuild` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`MenuID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DELETE FROM `gossip_menu_addon` WHERE `MenuID` IN (13332, 13338, 13470, 13475, 13486, 13574, 13593, 13594, 13595);
INSERT INTO `gossip_menu_addon` (`MenuID`, `FriendshipFactionID`, `VerifiedBuild`) VALUES
(13332, 1283, 26972), (13338, 1279, 26972), (13470, 1281, 26972), (13475, 1281, 26972), (13486, 1275, 26972),
(13574, 1282, 26972), (13593, 1280, 26972), (13594, 1277, 26972), (13595, 1276, 26972);
