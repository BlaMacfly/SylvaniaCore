CREATE TABLE IF NOT EXISTS `archaeology_digsite_limits` (
  `digsiteId` SMALLINT UNSIGNED NOT NULL,
  `maxFinds`  TINYINT  UNSIGNED NOT NULL DEFAULT 3,
  `comment`   VARCHAR(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`digsiteId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `archaeology_digsite_limits` (`digsiteId`, `maxFinds`, `comment`) VALUES
(384, 6, 'Dwarf'),
(398, 3, 'Draenei'),
(393, 6, 'Fossil'),
(394, 6, 'Night Elf'),
(400, 3, 'Nerubian'),
(397, 6, 'Orc'),
(401, 6, 'Tol\'vir'),
(385, 6, 'Troll'),
(399, 6, 'Vrykul'),
(754, 6, 'Mantid'),
(676, 3, 'Pandaren'),
(677, 3, 'Mogu'),
(829, 6, 'Arakkoa'),
(821, 6, 'Draenor Clans'),
(828, 6, 'Ogre'),
(1172, 6, 'Highborne'),
(1173, 6, 'Highmountain Tauren'),
(1174, 6, 'Demonic');