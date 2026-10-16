-- Conditions qui exigeaient une quete DEPRECATED (impossible a prendre depuis Cataclysm), donc jamais remplies.
-- 1. Butin : les Plumes de coiffe Mort-bois (21377) exigeaient Timbermaw Ally 8460 rendue, les Perles d'esprit Tombe-hiver
--    (21383) Winterfall Activity 8464 rendue : « Feathers for Nafien / Grazle » (28395 / 28396) et « Winterfall Activity » /
--    « More Beads for Salfa » (28522 / 28523), les quetes actives qui les demandent, etaient impossibles. Ce sont des objets
--    de quete (classe 12) : on retire la condition morte et on les fait tomber pour qui a une quete qui les demande.
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 1 AND `SourceEntry` = 21377 AND `ConditionTypeOrReference` = 8 AND `ConditionValue1` = 8460;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 1 AND `SourceEntry` = 21383 AND `ConditionTypeOrReference` = 8 AND `ConditionValue1` = 8464;
UPDATE `creature_loot_template` SET `QuestRequired` = 1 WHERE `Item` IN (21377, 21383);
-- 2. Ile d Alcaz : l option de vol de Cassa Crimsonwing et l aura de la zone attendaient Survey Alcaz Island 11142 ;
--    la quete active est 27239 (donnee par Jaina Proudmoore).
UPDATE `conditions` SET `ConditionValue1` = 27239, `Comment` = 'Cassa Crimsonwing - option 0 si Survey Alcaz Island 27239 prise' WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = 8782 AND `ConditionTypeOrReference` = 9 AND `ConditionValue1` = 11142;
UPDATE `spell_area` SET `quest_start` = 27239 WHERE `spell` = 42316 AND `area` = 2079 AND `quest_start` = 11142;
