-- =====================================================================
-- « Fin prêts » Horde : les trois objets d'objectif.
--
-- SIGNALE EN JEU : « les PNJ du duel ne sont pas cliquables, donc le
-- combat n'est pas possible », puis « côté Alliance ça marche, tu n'as
-- qu'à copier chez eux ».
--
-- C'était le bon conseil, et il a corrigé deux erreurs de ma part.
--
-- PREMIÈRE ERREUR. J'avais donné aux treize recrues le menu 19861 en
-- croyant qu'il servait aux quatre objectifs. Il ne contient qu'une
-- option -- « Let's duel. » -- et les vingt-deux recrues de Hurlevent le
-- portent aussi : ce sont TOUTES des partenaires d'entraînement. Le
-- menu était donc le bon, mais pour un seul des quatre objectifs.
--
-- SECONDE ERREUR. J'avais conclu que les trois autres objectifs
-- venaient des scripts gob_q42782 / gob_qq42782 / gob_qqq42782, qui ne
-- sont attachés à rien. Ils castent bien les trois sorts de crédit,
-- mais ils ne servent pas : les objets s'en chargent eux-mêmes.
--
-- Relevé aux positions officielles de la quête Alliance :
--
--   Keg of Armor Polish     (251195)  Data10 = 215387  armure
--   Light-Infused Crystals  (251234)  Data10 = 215598  arme
--   Baked Fish              (251250)  Data10 = 215607  repas
--
-- Ce sont des « goober » de type 10 : le sort est dans leurs propres
-- données, sans script, et Data2 vaut 0 -- aucune quête exigée. Ils
-- fonctionnent donc pour les deux factions sans rien modifier.
--
-- On les repose aux positions Horde, relevées en jeu par l'utilisateur
-- sur les marqueurs de sa minicarte.
-- =====================================================================

DELETE FROM `gameobject` WHERE `guid` BETWEEN 210300250 AND 210300260;

INSERT INTO `gameobject`
  (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,
   `position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,
   `spawntimesecs`,`animprogress`,`state`,`isActive`,`ScriptName`,`VerifiedBuild`) VALUES
-- armure
(210300250, 251195, 1, 14, 4982, '0', 0, 0, 0, -1, 1303.472, -4581.246, 23.110, 4.5619, 0, 0, -0.353208, -0.935545, 120, 100, 1, 0, '', 0),
(210300251, 251195, 1, 14, 4982, '0', 0, 0, 0, -1, 1301.900, -4583.100, 23.000, 4.5619, 0, 0, -0.353208, -0.935545, 120, 100, 1, 0, '', 0),
-- arme
(210300252, 251234, 1, 14, 4982, '0', 0, 0, 0, -1, 1372.291, -4668.044, 27.403, 4.1182, 0, 0, -0.868186, 0.496240, 120, 100, 1, 0, '', 0),
(210300253, 251234, 1, 14, 4982, '0', 0, 0, 0, -1, 1374.100, -4670.200, 27.600, 4.1182, 0, 0, -0.868186, 0.496240, 120, 100, 1, 0, '', 0),
-- repas
(210300254, 251250, 1, 14, 4982, '0', 0, 0, 0, -1, 1320.847, -4478.394, 24.188, 4.1967, 0, 0, -0.868186, 0.496240, 120, 100, 1, 0, '', 0),
(210300255, 251250, 1, 14, 4982, '0', 0, 0, 0, -1, 1319.100, -4480.300, 24.100, 4.1967, 0, 0, -0.868186, 0.496240, 120, 100, 1, 0, '', 0);
