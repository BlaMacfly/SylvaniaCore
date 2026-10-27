-- Taux de reputation personnel choisi aupres de Klauss (npc_rate_xp_modifier) : 0 = taux du royaume (Rate.Reputation.Gain).
ALTER TABLE `characters` ADD COLUMN `repRate` TINYINT UNSIGNED NOT NULL DEFAULT 0 AFTER `xpRate`;
