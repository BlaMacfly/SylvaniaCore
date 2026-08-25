-- =====================================================================
-- Brasserie brune d'Orage et Temple du Serpent de jade :
-- AUCUNE rencontre de boss n'était déclarée.
--
-- SIGNALÉ EN JEU
-- « je n'ai plus les objectifs de boss à battre affichés, ce qui laisse
-- penser que le donjon est considéré comme fini au 1er boss ».
--
-- LA CAUSE
-- La table `instance_encounters` associe une rencontre officielle
-- (DungeonEncounter.db2) à la créature qui la valide. Sans ces lignes,
-- le cœur n'a rien à annoncer au client : aucun objectif de boss ne
-- s'affiche, et aucune progression n'est enregistrée.
--
-- Le script d'instance déclare pourtant bien ses trois rencontres
-- (MAX_ENCOUNTER 3 dans stormstout_brewery.h) — c'est la donnée qui
-- manquait, pas le code.
--
-- Ce n'est pas propre à la Brasserie : vérification faite, AUCUN donjon
-- de Pandarie n'a ses rencontres déclarées (Temple du Serpent de jade,
-- Passage des Voleurs de mort, Palais de Mogu'shan, Porte du Couchant,
-- Fosse aux serpents). La table contient bien 389 rencontres pour les
-- extensions précédentes : l'oubli est circonscrit à Pandarie.
--
-- On traite ici les deux donjons débogués récemment. Les autres suivront.
--
-- D'OÙ VIENNENT LES DONNÉES
-- Identifiants relevés dans `DungeonEncounter.db2` du build 7.3.5.26972,
-- filtré par MapID ; identifiants de donjon dans `LFGDungeons.db2`,
-- mode normal (DifficultyID 1).
--
--   carte 961 : 1412 Ook-Ook, 1413 Hoptallus, 1414 Yan-Zhu   — LFG 465
--   carte 960 : 1416 Liu Flameheart, 1417 Lorewalker Stonestep,
--               1418 Wise Mari, 1439 Sha of Doubt            — LFG 464
--
-- `creditType` 0 = ENCOUNTER_CREDIT_KILL_CREATURE.
-- `lastEncounterDungeon` n'est renseigné que sur le DERNIER boss de
-- chaque donjon : c'est lui qui déclenche la récompense de fin.
--
-- ⚠️ Cette table n'est lue qu'au démarrage : un redémarrage est
-- nécessaire, le rechargement à chaud ne suffit pas.
-- =====================================================================

DELETE FROM `instance_encounters`
 WHERE `entry` IN (1412,1413,1414,1416,1417,1418,1439);

INSERT INTO `instance_encounters`
 (`entry`,`creditType`,`creditEntry`,`lastEncounterDungeon`,`comment`) VALUES

-- ---------------------------------------------------------------
-- Brasserie brune d'Orage (carte 961)
-- ---------------------------------------------------------------
(1412, 0, 56637,   0, 'Ook-Ook - Brasserie brune d Orage'),
(1413, 0, 56717,   0, 'Hoptallus - Brasserie brune d Orage'),
(1414, 0, 59479, 465, 'Yan-Zhu the Uncasked - dernier boss de la Brasserie'),

-- ---------------------------------------------------------------
-- Temple du Serpent de jade (carte 960)
-- ---------------------------------------------------------------
(1418, 0, 56448,   0, 'Wise Mari - Temple du Serpent de jade'),
(1417, 0, 56843,   0, 'Lorewalker Stonestep - Temple du Serpent de jade'),
(1416, 0, 56732,   0, 'Liu Flameheart - Temple du Serpent de jade'),
(1439, 0, 56439, 464, 'Sha of Doubt - dernier boss du Temple');
