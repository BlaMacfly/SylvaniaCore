-- Dalaran (Iles brisees) : 5 receveurs de quetes absents de partout, dont Lyndras (13 quetes de la couture Legion).
-- Pins Wowhead (etage 10) convertis par regression calibree sur 18 PNJ uniques deja places (residus < 5 m pour la
-- plupart) ; chaque apparition est a 5-8 m du point de remise officiel (quest_poi) ; Z d un voisin a moins de 7 m.
DELETE FROM `creature` WHERE `guid` BETWEEN 290401594 AND 290401598;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `PhaseId`, `PhaseGroup`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `MovementType`) VALUES
(290401594, 93967, 1220, 8445, 8445, '0', 0, 0, -767.85, 4585.10, 727.956, 0, 300, 0, 0),
(290401595, 96683, 1220, 8445, 8445, '0', 0, 0, -844.32, 4640.57, 749.342, 0, 300, 0, 0),
(290401596, 97429, 1220, 8445, 8445, '0', 0, 0, -747.58, 4552.87, 727.473, 0, 300, 0, 0),
(290401597, 100939, 1220, 8445, 8445, '0', 0, 0, -779.73, 4559.66, 727.502, 0, 300, 0, 0),
(290401598, 102570, 1220, 8445, 8445, '0', 0, 0, -837.75, 4328.67, 745.114, 0, 300, 0, 0);
