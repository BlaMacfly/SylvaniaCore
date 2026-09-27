-- =====================================================================
-- Rivage brise, phase 7 : le pont de glace de Jaina.
--
-- VERIFIE SUR LA VIDEO : au bord du gouffre, Gelbin demande « Comment
-- est-ce qu'on va traverser ? », Jaina repond « Je m'en occupe » et gele
-- un passage. Le joueur le franchit a pied vers les Abords du tombeau.
--
-- Le modele officiel est identifie :
--   world/expansion06/doodads/brokenshore/7bs_brokenshore_icebridge01.m2
--   FileDataID 1349000, GameObjectDisplayInfo 35871
--
-- MESURE DECISIVE : ce modele ne porte AUCUNE collision -- zero triangle,
-- zero sommet, zero normale, lu directement dans son en-tete M2. Une
-- re-extraction des vmaps ne produirait donc rien : il n'y a rien a
-- extraire. Blizzard fait necessairement traverser ses joueurs autrement,
-- par du sol invisible ou un deplacement scripte.
--
-- On pose donc le visuel officiel, et dessous un plancher fait de
-- barrieres invisibles (affichage 6391), dont la collision, elle, est
-- bien presente dans notre index GameObjectModels.dtree.
--
-- Bords releves en jeu :
--   proche  (1415.93, 2134.50, 21.87)
--   lointain (1423.95, 2086.79, 35.86)
-- soit 48,38 m de portee et 13,98 m de denivele -- une pente de 16,1
-- degres, reprise dans le quaternion des dalles.
-- =====================================================================

DELETE FROM `gameobject_template` WHERE `entry` IN (1000200, 1000201);
INSERT INTO `gameobject_template`
  (`entry`,`type`,`displayId`,`name`,`IconName`,`castBarCaption`,`unk1`,`size`,`ScriptName`) VALUES
(1000200, 5, 35871, 'Pont de glace', '', '', '', 1,   ''),
(1000201, 5,  6391, 'Plancher du pont de glace', '', '', '', 4.5, '');

DELETE FROM `gameobject` WHERE `guid` BETWEEN 210300200 AND 210300210;
INSERT INTO `gameobject`
  (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,
   `position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,
   `spawntimesecs`,`animprogress`,`state`,`isActive`,`ScriptName`,`VerifiedBuild`) VALUES
-- Le visuel, au milieu du gouffre, couche dans son axe.
(210300200, 1000200, 1460, 0, 0, '12', 0, 0, 0, -1,
 1419.938, 2110.647, 28.866, 4.8789, 0, 0, 0.638140, 0.769920, 300, 100, 1, 0, '', 0),
-- Trois files de plancher invisible, inclinees a 16 degres.
(210300201, 1000201, 1460, 0, 0, '12', 0, 0, 0, -1,
 1417.7679, 2110.2824, 28.8663, 0.1665, -0.011658, 0.139734, 0.082323, 0.986692, 300, 100, 1, 0, '', 0),
(210300202, 1000201, 1460, 0, 0, '12', 0, 0, 0, -1,
 1419.9375, 2110.6470, 28.8663, 0.1665, -0.011658, 0.139734, 0.082323, 0.986692, 300, 100, 1, 0, '', 0),
(210300203, 1000201, 1460, 0, 0, '12', 0, 0, 0, -1,
 1422.1071, 2111.0115, 28.8663, 0.1665, -0.011658, 0.139734, 0.082323, 0.986692, 300, 100, 1, 0, '', 0);
