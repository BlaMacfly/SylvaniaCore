-- Plafond de monnaie releve par des sorts (SPELL_EFFECT_INCREASE_CURRENCY_CAP) : Mana ancien de Suramar (+100 a +300 par quete ou objet).
ALTER TABLE `character_currency` ADD COLUMN `IncreasedCap` INT UNSIGNED NOT NULL DEFAULT 0 AFTER `WeekCap`;
