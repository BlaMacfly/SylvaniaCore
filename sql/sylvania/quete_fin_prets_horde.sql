-- =====================================================================
-- « Fin prêts » (To Be Prepared) : la version Horde n'existait pas.
--
-- SIGNALE EN JEU : « la quête Fin prêts côté Horde ne marche pas, les
-- gameobject ne sont pas interactifs ».
--
-- Ce n'était pas un défaut d'interaction : il n'y avait RIEN. Un
-- « .gobject near 10 » du joueur renvoyait zéro, et la recherche a
-- confirmé qu'aucune recrue Horde n'était posée.
--
-- Les deux quêtes -- 42782 Alliance, 44281 Horde -- ont pourtant des
-- objectifs IDENTIQUES : mêmes quatre crédits (108787 armure astiquée,
-- 108788 arme renforcée, 108789 dernier repas, 108722 duel). Seul le
-- lieu change : le Vieux quartier de Hurlevent contre le Blocus de
-- Dranosh'ar.
--
-- Côté Alliance, vingt-deux recrues portent le menu 19861 et le script
-- npc_q42782, et sont posées en haie près du Recruteur Lee.
--
-- Côté Horde, les gabarits EXISTAIENT -- bloc contigu 113539 à 113551,
-- treize recrues nommées sur le wiki officiel : Orgek Ironhand pour
-- l'armure, Seleria Dawncaller pour l'arme, Liu-So pour le repas. Mais
-- sans menu de dialogue, sans script et sans une seule apparition.
--
-- On les configure comme leurs homologues et on les pose en arc devant
-- Holgar Hachetempête (1352.5, -4396.5, 29.2), le donneur de la quête.
-- Les altitudes sont lues dans les fichiers .map du serveur, pas
-- estimées : le sol sous Holgar y donne 29,13 pour un PNJ posé à 29,2.
--
-- Corrige au passage un défaut côté Alliance : Ramall Trueoak (108722)
-- porte le bon menu mais aucun script, alors que son entrée EST le
-- crédit du duel. L'objectif d'échauffement ne pouvait pas se valider.
-- =====================================================================

SET @G := 290203300;

UPDATE `creature_template`
   SET `gossip_menu_id` = 19861,
       `ScriptName` = 'npc_q42782'
 WHERE `entry` BETWEEN 113539 AND 113551;

UPDATE `creature_template`
   SET `ScriptName` = 'npc_q42782'
 WHERE `entry` = 108722;

DELETE FROM `creature` WHERE `guid` BETWEEN @G AND @G+20;

INSERT INTO `creature`
  (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,
   `position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`MovementType`) VALUES
(@G+0,  113539, 1, 14, 4982, '0', 0, 0, 0, 1358.500, -4406.892, 28.678, 2.0944, 300, 0, 0),
(@G+1,  113540, 1, 14, 4982, '0', 0, 0, 0, 1360.213, -4405.693, 28.823, 2.2689, 300, 0, 0),
(@G+2,  113541, 1, 14, 4982, '0', 0, 0, 0, 1361.693, -4404.213, 28.958, 2.4435, 300, 0, 0),
(@G+3,  113542, 1, 14, 4982, '0', 0, 0, 0, 1362.892, -4402.500, 29.084, 2.6180, 300, 0, 0),
(@G+4,  113543, 1, 14, 4982, '0', 0, 0, 0, 1363.776, -4400.604, 29.203, 2.7925, 300, 0, 0),
(@G+5,  113544, 1, 14, 4982, '0', 0, 0, 0, 1364.318, -4398.584, 29.207, 2.9671, 300, 0, 0),
(@G+6,  113545, 1, 14, 4982, '0', 0, 0, 0, 1364.500, -4396.500, 29.137, 3.1416, 300, 0, 0),
(@G+7,  113546, 1, 14, 4982, '0', 0, 0, 0, 1364.318, -4394.416, 28.824, 3.3161, 300, 0, 0),
(@G+8,  113547, 1, 14, 4982, '0', 0, 0, 0, 1363.776, -4392.396, 28.547, 3.4907, 300, 0, 0),
(@G+9,  113548, 1, 14, 4982, '0', 0, 0, 0, 1362.892, -4390.500, 27.898, 3.6652, 300, 0, 0),
(@G+10, 113549, 1, 14, 4982, '0', 0, 0, 0, 1361.693, -4388.787, 26.928, 3.8397, 300, 0, 0),
(@G+11, 113550, 1, 14, 4982, '0', 0, 0, 0, 1360.213, -4387.307, 26.090, 4.0143, 300, 0, 0),
(@G+12, 113551, 1, 14, 4982, '0', 0, 0, 0, 1358.500, -4386.108, 26.129, 4.1888, 300, 0, 0);
