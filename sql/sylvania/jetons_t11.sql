-- =====================================================================
-- Jetons de tier 11 : l'echange normal n'existait pas.
--
-- SIGNALE PAR UN JOUEUR : « tous les jetons du jeu sont bugues, quand on
-- clique dessus pour le creer il ne donne pas la piece d'armure ».
--
-- MESURE. Les deux intendants officiels existent bien chez nous et sont
-- poses -- Toren Landow (58154) a Hurlevent, Rugok (58155) a Orgrimmar,
-- « Intendant de la justice d'antan » -- avec 295 articles chacun. Mais
-- aucune de leurs lignes n'emploie les couts etendus des jetons NORMAUX.
--
-- Les six couts sont pourtant definis dans les donnees du client :
--     3043/3044/3045 -> Manteau de l'Oublie (Vainqueur/Conquerant/Protecteur)
--     3049/3050/3051 -> Casque de l'Oublie   (idem)
--
-- Et leurs voisins immediats, eux, SONT cables :
--     3046/3047/3048 -> Epaulieres (heroique, 372)
--     3052/3054/3055 -> Couronne   (heroique, 372)
--
-- Autrement dit : la tier 11 HEROIQUE a ete posee, la NORMALE oubliee.
-- Or Al'Akir en mode normal ne lache que Casque et Manteau -- exactement
-- les six manquants. Le joueur ne pouvait echanger aucun de ses jetons.
--
-- Les correspondances viennent des ensembles officiels (ItemSet, build
-- 7.3.5.26972), piece par piece : sept ensembles pour le Vainqueur
-- (chevalier de la mort, druide, mage, voleur), six pour le Conquerant
-- (paladin, pretre, demoniste), six pour le Protecteur (guerrier,
-- chasseur, chaman). Les tetes et les epaules ont ete identifiees par
-- leur nom, et recoupees une a une avec ce que les intendants vendent
-- deja en version heroique.
-- =====================================================================

-- Toren Landow, Hurlevent
DELETE FROM `npc_vendor` WHERE `entry` = 58154 AND `ExtendedCost` IN (3043,3044,3045,3049,3050,3051);
INSERT INTO `npc_vendor`
  (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`OverrideGoldCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(58154, 3, 60341, 0, 0, 3049, -1, 1, NULL, 0, 0, 0),
(58154, 3, 60351, 0, 0, 3049, -1, 1, NULL, 0, 0, 0),
(58154, 3, 60286, 0, 0, 3049, -1, 1, NULL, 0, 0, 0),
(58154, 3, 60277, 0, 0, 3049, -1, 1, NULL, 0, 0, 0),
(58154, 3, 60282, 0, 0, 3049, -1, 1, NULL, 0, 0, 0),
(58154, 3, 60243, 0, 0, 3049, -1, 1, NULL, 0, 0, 0),
(58154, 3, 60299, 0, 0, 3049, -1, 1, NULL, 0, 0, 0),
(58154, 3, 60346, 0, 0, 3050, -1, 1, NULL, 0, 0, 0),
(58154, 3, 60359, 0, 0, 3050, -1, 1, NULL, 0, 0, 0),
(58154, 3, 60356, 0, 0, 3050, -1, 1, NULL, 0, 0, 0),
(58154, 3, 60258, 0, 0, 3050, -1, 1, NULL, 0, 0, 0),
(58154, 3, 60256, 0, 0, 3050, -1, 1, NULL, 0, 0, 0),
(58154, 3, 60249, 0, 0, 3050, -1, 1, NULL, 0, 0, 0),
(58154, 3, 60303, 0, 0, 3051, -1, 1, NULL, 0, 0, 0),
(58154, 3, 60308, 0, 0, 3051, -1, 1, NULL, 0, 0, 0),
(58154, 3, 60320, 0, 0, 3051, -1, 1, NULL, 0, 0, 0),
(58154, 3, 60315, 0, 0, 3051, -1, 1, NULL, 0, 0, 0),
(58154, 3, 60325, 0, 0, 3051, -1, 1, NULL, 0, 0, 0),
(58154, 3, 60328, 0, 0, 3051, -1, 1, NULL, 0, 0, 0),
(58154, 3, 60343, 0, 0, 3043, -1, 1, NULL, 0, 0, 0),
(58154, 3, 60353, 0, 0, 3043, -1, 1, NULL, 0, 0, 0),
(58154, 3, 60289, 0, 0, 3043, -1, 1, NULL, 0, 0, 0),
(58154, 3, 60279, 0, 0, 3043, -1, 1, NULL, 0, 0, 0),
(58154, 3, 60284, 0, 0, 3043, -1, 1, NULL, 0, 0, 0),
(58154, 3, 60246, 0, 0, 3043, -1, 1, NULL, 0, 0, 0),
(58154, 3, 60302, 0, 0, 3043, -1, 1, NULL, 0, 0, 0),
(58154, 3, 60348, 0, 0, 3044, -1, 1, NULL, 0, 0, 0),
(58154, 3, 60362, 0, 0, 3044, -1, 1, NULL, 0, 0, 0),
(58154, 3, 60358, 0, 0, 3044, -1, 1, NULL, 0, 0, 0),
(58154, 3, 60262, 0, 0, 3044, -1, 1, NULL, 0, 0, 0),
(58154, 3, 60253, 0, 0, 3044, -1, 1, NULL, 0, 0, 0),
(58154, 3, 60252, 0, 0, 3044, -1, 1, NULL, 0, 0, 0),
(58154, 3, 60306, 0, 0, 3045, -1, 1, NULL, 0, 0, 0),
(58154, 3, 60311, 0, 0, 3045, -1, 1, NULL, 0, 0, 0),
(58154, 3, 60322, 0, 0, 3045, -1, 1, NULL, 0, 0, 0),
(58154, 3, 60317, 0, 0, 3045, -1, 1, NULL, 0, 0, 0),
(58154, 3, 60327, 0, 0, 3045, -1, 1, NULL, 0, 0, 0),
(58154, 3, 60331, 0, 0, 3045, -1, 1, NULL, 0, 0, 0);

-- Rugok, Orgrimmar
DELETE FROM `npc_vendor` WHERE `entry` = 58155 AND `ExtendedCost` IN (3043,3044,3045,3049,3050,3051);
INSERT INTO `npc_vendor`
  (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`OverrideGoldCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(58155, 3, 60341, 0, 0, 3049, -1, 1, NULL, 0, 0, 0),
(58155, 3, 60351, 0, 0, 3049, -1, 1, NULL, 0, 0, 0),
(58155, 3, 60286, 0, 0, 3049, -1, 1, NULL, 0, 0, 0),
(58155, 3, 60277, 0, 0, 3049, -1, 1, NULL, 0, 0, 0),
(58155, 3, 60282, 0, 0, 3049, -1, 1, NULL, 0, 0, 0),
(58155, 3, 60243, 0, 0, 3049, -1, 1, NULL, 0, 0, 0),
(58155, 3, 60299, 0, 0, 3049, -1, 1, NULL, 0, 0, 0),
(58155, 3, 60346, 0, 0, 3050, -1, 1, NULL, 0, 0, 0),
(58155, 3, 60359, 0, 0, 3050, -1, 1, NULL, 0, 0, 0),
(58155, 3, 60356, 0, 0, 3050, -1, 1, NULL, 0, 0, 0),
(58155, 3, 60258, 0, 0, 3050, -1, 1, NULL, 0, 0, 0),
(58155, 3, 60256, 0, 0, 3050, -1, 1, NULL, 0, 0, 0),
(58155, 3, 60249, 0, 0, 3050, -1, 1, NULL, 0, 0, 0),
(58155, 3, 60303, 0, 0, 3051, -1, 1, NULL, 0, 0, 0),
(58155, 3, 60308, 0, 0, 3051, -1, 1, NULL, 0, 0, 0),
(58155, 3, 60320, 0, 0, 3051, -1, 1, NULL, 0, 0, 0),
(58155, 3, 60315, 0, 0, 3051, -1, 1, NULL, 0, 0, 0),
(58155, 3, 60325, 0, 0, 3051, -1, 1, NULL, 0, 0, 0),
(58155, 3, 60328, 0, 0, 3051, -1, 1, NULL, 0, 0, 0),
(58155, 3, 60343, 0, 0, 3043, -1, 1, NULL, 0, 0, 0),
(58155, 3, 60353, 0, 0, 3043, -1, 1, NULL, 0, 0, 0),
(58155, 3, 60289, 0, 0, 3043, -1, 1, NULL, 0, 0, 0),
(58155, 3, 60279, 0, 0, 3043, -1, 1, NULL, 0, 0, 0),
(58155, 3, 60284, 0, 0, 3043, -1, 1, NULL, 0, 0, 0),
(58155, 3, 60246, 0, 0, 3043, -1, 1, NULL, 0, 0, 0),
(58155, 3, 60302, 0, 0, 3043, -1, 1, NULL, 0, 0, 0),
(58155, 3, 60348, 0, 0, 3044, -1, 1, NULL, 0, 0, 0),
(58155, 3, 60362, 0, 0, 3044, -1, 1, NULL, 0, 0, 0),
(58155, 3, 60358, 0, 0, 3044, -1, 1, NULL, 0, 0, 0),
(58155, 3, 60262, 0, 0, 3044, -1, 1, NULL, 0, 0, 0),
(58155, 3, 60253, 0, 0, 3044, -1, 1, NULL, 0, 0, 0),
(58155, 3, 60252, 0, 0, 3044, -1, 1, NULL, 0, 0, 0),
(58155, 3, 60306, 0, 0, 3045, -1, 1, NULL, 0, 0, 0),
(58155, 3, 60311, 0, 0, 3045, -1, 1, NULL, 0, 0, 0),
(58155, 3, 60322, 0, 0, 3045, -1, 1, NULL, 0, 0, 0),
(58155, 3, 60317, 0, 0, 3045, -1, 1, NULL, 0, 0, 0),
(58155, 3, 60327, 0, 0, 3045, -1, 1, NULL, 0, 0, 0),
(58155, 3, 60331, 0, 0, 3045, -1, 1, NULL, 0, 0, 0);

