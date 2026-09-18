-- Retour aux valeurs relevees le 18/09/2026 avant rhyolith_carcasses.sql.
UPDATE `creature_template` SET `HealthModifier` = 234.624, `lootid` = 53772 WHERE `entry` = 53772;
UPDATE `creature_template` SET `lootid` = 0, `unit_flags2` = 2048 WHERE `entry` IN (54192, 54199);
