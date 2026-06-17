DROP TABLE IF EXISTS `ai_talk_group`;
CREATE TABLE `ai_talk_group` (
  `cname` VARCHAR(255) NOT NULL,
  `reply` TEXT NOT NULL,
  PRIMARY KEY (`cname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `ai_talk_group_locale`;
CREATE TABLE `ai_talk_group_locale` (
  `cname` VARCHAR(255) NOT NULL,
  `locale` TINYINT NOT NULL,
  `reply` TEXT NOT NULL,
  PRIMARY KEY (`cname`, `locale`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Englische Defaults
DELETE FROM `ai_talk_group` WHERE `cname`='hello|hi|hey';
DELETE FROM `ai_talk_group` WHERE `cname`='bye|goodbye';
INSERT INTO `ai_talk_group` (`cname`, `reply`) VALUES
('hello|hi|hey', 'Hello group!'),
('bye|goodbye', 'See you later, group!');

-- Locales
DELETE FROM `ai_talk_group_locale` WHERE `cname`='hello|hi|hey' AND `locale`=3;
DELETE FROM `ai_talk_group_locale` WHERE `cname`='bye|goodbye' AND `locale`=3;
INSERT INTO `ai_talk_group_locale` (`cname`, `locale`, `reply`) VALUES
('hello|hi|hey', 3, 'Hallo Gruppe!'),
('bye|goodbye', 3, 'Bis später, Gruppe!');
