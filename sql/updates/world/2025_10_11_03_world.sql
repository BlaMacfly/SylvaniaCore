DROP TABLE IF EXISTS `spell_bonus_data`;
CREATE TABLE IF NOT EXISTS `spell_bonus_data` (
  `spell_id` INT UNSIGNED NOT NULL,
  `ap_coeff` FLOAT NOT NULL DEFAULT 0,
  `sp_coeff` FLOAT NOT NULL DEFAULT 0,
  PRIMARY KEY (`spell_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
