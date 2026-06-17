-- Englische Standard-Tabelle
DROP TABLE IF EXISTS `ai_talk_whisper`;
CREATE TABLE IF NOT EXISTS `ai_talk_whisper` (
    `cname` VARCHAR(255) NOT NULL,
    `reply` TEXT NOT NULL,
    PRIMARY KEY (`cname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DELETE FROM `ai_talk_whisper` WHERE `cname`='hello|hi|hey';
DELETE FROM `ai_talk_whisper` WHERE `cname`='bye|goodbye|see you';
INSERT INTO `ai_talk_whisper` (`cname`, `reply`) VALUES
('hello|hi|hey', 'Hello there!'),
('bye|goodbye|see you', 'Goodbye! Take care!');

-- Locale-Tabelle für alle anderen Sprachen
DROP TABLE IF EXISTS `ai_talk_whisper_locale`;
CREATE TABLE IF NOT EXISTS `ai_talk_whisper_locale` (
    `cname` VARCHAR(255) NOT NULL,
    `locale` TINYINT NOT NULL, -- siehe LocaleConstant
    `reply` TEXT NOT NULL,
    PRIMARY KEY (`cname`, `locale`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Beispiel für Deutsch (LOCALE_deDE = 3)
DELETE FROM `ai_talk_whisper_locale` WHERE `cname`='hello|hi|hey' AND `locale`=3;
DELETE FROM `ai_talk_whisper_locale` WHERE `cname`='bye|goodbye|see you'AND `locale`=3;
INSERT INTO `ai_talk_whisper_locale` (`cname`, `locale`, `reply`) VALUES
('hello|hi|hey', 3, 'Hallo!'),
('bye|goodbye|see you', 3, 'Auf Wiedersehen!');

-- Beispiel für Französisch (LOCALE_frFR = 2)
DELETE FROM `ai_talk_whisper_locale` WHERE `cname`='hello|hi|hey' AND `locale`=2;
DELETE FROM `ai_talk_whisper_locale` WHERE `cname`='bye|goodbye|see you' AND `locale`=2;
INSERT INTO `ai_talk_whisper_locale` (`cname`, `locale`, `reply`) VALUES
('hello|hi|hey', 2, 'Bonjour!'),
('bye|goodbye|see you', 2, 'Au revoir!');
