-- Klauss (npc_rate_xp_modifier) regle desormais aussi le taux de reputation.
UPDATE `creature_template` SET `subname`='Sélecteur de taux' WHERE `entry`=1000000;
UPDATE `creature_template_locale` SET `Title`='Sélecteur de taux' WHERE `entry`=1000000 AND `locale`='frFR';
