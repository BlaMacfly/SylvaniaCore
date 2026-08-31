-- =====================================================================
-- Assaut du Rivage brisé — le donneur manquant de « Begin the Assault »
--
-- La quête 45102 n'avait NI donneur NI receveur en base : introuvable en
-- jeu, quoi qu'on fasse. C'était l'une des trois quêtes sans donneur
-- relevées à l'audit du 23/08.
--
-- Le dump de référence (dufernst/LegionCore-7.3.5) donne pour elle
-- l'archimage Khadgar 116302, à la fois donneur et receveur. Ce PNJ est
-- DÉJÀ posé chez nous, sur la carte 1220 à (-1628, 3194) — exactement
-- les coordonnées de la référence — et porte déjà le drapeau de donneur
-- de quêtes (npcflag 3). Rien à faire apparaître : seule la déclaration
-- manquait.
--
-- 46734 reçoit aussi 116302, comme dans la référence, en plus du 86563
-- déjà déclaré chez nous. Deux points d'accès, aucun conflit.
--
-- Rappel de la chaîne, pour mémoire :
--   46730 « Armies of Legionfall »      86563  (déjà câblée)
--   45102 « Begin the Assault »        116302  (posée ici)
--   46734 « Assault on Broken Shore »   86563 + 116302
-- =====================================================================

DELETE FROM `creature_queststarter` WHERE `quest` = 45102 AND `id` = 116302;
DELETE FROM `creature_questender`   WHERE `quest` = 45102 AND `id` = 116302;
DELETE FROM `creature_queststarter` WHERE `quest` = 46734 AND `id` = 116302;
DELETE FROM `creature_questender`   WHERE `quest` = 46734 AND `id` = 116302;

INSERT INTO `creature_queststarter` (`id`,`quest`) VALUES (116302, 45102), (116302, 46734);
INSERT INTO `creature_questender`   (`id`,`quest`) VALUES (116302, 45102), (116302, 46734);
