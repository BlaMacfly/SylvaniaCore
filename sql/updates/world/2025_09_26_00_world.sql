DROP TABLE IF EXISTS `spell_on_log_remove_aura`;
CREATE TABLE `spell_on_log_remove_aura` (
  `spell_id` INT UNSIGNED NOT NULL,
  `required_aura` INT UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`spell_id`, `required_aura`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;