-- Rollback de hov_boss_manquants.sql (2026-09-10)
DELETE FROM `creature` WHERE `guid` BETWEEN 290200801 AND 290200805;
DELETE FROM `creature_template_journal` WHERE `entry` = 95676;
