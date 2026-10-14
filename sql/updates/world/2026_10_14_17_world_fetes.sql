-- Fetes et evenements recurrents : AUCUNE fete ne tournait depuis 2021.
-- Leur date de fin etait le 31/12/2020, et le moteur ne recalait pas leurs dates sur Holidays.db2.
-- Le moteur lit maintenant la phase suivie (holidayStage) et prend la date dans Holidays.db2, lignes hotfix comprises :
-- dates fixes tous les ans (Sanssaint le 18/10...), dates listees pour les fetes variables (Foire de Sombrelune, Jardin des nobles...).
ALTER TABLE `game_event` ADD COLUMN `holidayStage` TINYINT UNSIGNED NOT NULL DEFAULT 0 AFTER `holiday`;

UPDATE `game_event` SET `holidayStage` = 1 WHERE `eventEntry` IN (1, 2, 7, 8, 9, 10, 11, 12, 26, 50, 51, 72);
UPDATE `game_event` SET `holidayStage` = 2 WHERE `eventEntry` IN (3, 24);        -- Foire de Sombrelune, Fete des Brasseurs : la 2e phase
UPDATE `game_event` SET `holiday` = 479, `holidayStage` = 1 WHERE `eventEntry` = 23; -- montage de la Foire de Sombrelune

-- Evenements recurrents arretes le 31/12/2020 (fetes, Appels aux armes, Biere du mois, peche, Foire...) : prolonges
UPDATE `game_event` SET `end_time` = '2035-12-31 23:59:59'
WHERE `end_time` BETWEEN '2020-12-31 00:00:00' AND '2020-12-31 23:59:59' AND `occurence` > 0 AND `length` > 0;
UPDATE `game_event` SET `end_time` = '2035-12-31 23:59:59' WHERE `eventEntry` = 72;  -- feu d'artifice du 4 juillet (fin 2020-07-04)

-- Quetes de fete liees a la fois en permanence et par leur evenement : proposees en double pendant la fete et
-- toute l'annee ensuite. Comme sur le jeu officiel, seulement par leur evenement (Titans-Project 423df52).
DELETE s FROM `creature_queststarter` s
JOIN `game_event_creature_quest` e ON e.`id` = s.`id` AND e.`quest` = s.`quest`;
DELETE s FROM `gameobject_queststarter` s
JOIN `game_event_gameobject_quest` e ON e.`id` = s.`id` AND e.`quest` = s.`quest`;
-- Les badauds de fete (19169, 19175-19178, 20102) proposaient trois quetes de fete a chaque fete
INSERT IGNORE INTO `game_event_creature_quest` (`eventEntry`, `id`, `quest`)
SELECT CASE s.`quest` WHEN 11357 THEN 12 WHEN 11971 THEN 1 WHEN 14036 THEN 26 END, s.`id`, s.`quest`
FROM `creature_queststarter` s
WHERE s.`id` IN (19169, 19175, 19176, 19177, 19178, 20102) AND s.`quest` IN (11357, 11971, 14036);
DELETE FROM `creature_queststarter` WHERE `id` IN (19169, 19175, 19176, 19177, 19178, 20102) AND `quest` IN (11357, 11971, 14036);
