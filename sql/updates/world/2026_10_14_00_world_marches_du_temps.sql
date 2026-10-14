-- DB/Events: Marches du temps (Timewalking), une extension par semaine, dans l'ordre de sortie (d'apres Titans-Project 6ef35864).
-- Les quatre evenements (100 a 103) commencaient le meme jour et duraient 30 jours sur 60 : les quatre extensions ouvertes
-- ensemble un mois, puis aucune le mois suivant. Desormais chacune dure une semaine, du reset du mercredi 6 h, toutes les
-- quatre semaines : BC, WotLK, Cataclysm, Pandarie, sans interruption. (Les dates suivent des minutes fixes : apres un
-- changement d'heure, le passage se fait une heure plus tot ou plus tard.)
UPDATE `game_event` SET `start_time` = '2026-10-14 06:00:00', `occurence` = 40320, `length` = 10080 WHERE `eventEntry` = 100; -- Timewalker BC
UPDATE `game_event` SET `start_time` = '2026-10-21 06:00:00', `occurence` = 40320, `length` = 10080 WHERE `eventEntry` = 101; -- Timewalker WotLK
UPDATE `game_event` SET `start_time` = '2026-10-28 06:00:00', `occurence` = 40320, `length` = 10080 WHERE `eventEntry` = 102; -- Timewalker Cataclysm
UPDATE `game_event` SET `start_time` = '2026-11-04 06:00:00', `occurence` = 40320, `length` = 10080 WHERE `eventEntry` = 103; -- Timewalker MoP

-- L'Archimage Timear (Dalaran) proposait en permanence la quete hebdomadaire de BC et jamais les trois autres : chacune est
-- proposee pendant la semaine de son extension (quetes a objectif d'arbre de criteres : cinq donjons des Marches du temps).
DELETE FROM `creature_queststarter` WHERE `id` = 111246 AND `quest` IN (44164, 44166, 44167, 45799);
DELETE FROM `game_event_creature_quest` WHERE `id` = 111246 AND `quest` IN (44164, 44166, 44167, 45799);
INSERT INTO `game_event_creature_quest` (`eventEntry`, `id`, `quest`) VALUES
(100, 111246, 44164),
(101, 111246, 44166),
(102, 111246, 44167),
(103, 111246, 45799);
DELETE FROM `creature_questender` WHERE `id` = 111246 AND `quest` = 45799;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (111246, 45799);
