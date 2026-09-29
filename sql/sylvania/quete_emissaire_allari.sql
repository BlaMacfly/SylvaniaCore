-- =====================================================================
-- « Émissaire » (40760) — Allari la Dévoreuse d'âmes n'existait pas
-- =====================================================================
--
-- SIGNALÉ EN JEU : « je ne la vois pas, est-elle présente ? »
--
-- Non. La quête est donnée par Sylvanas et se rend à la créature 100873,
-- Allari the Souleater — qui n'avait AUCUNE ligne dans `creature`. Le
-- joueur terminait donc la quête sans jamais pouvoir la rendre, et la
-- suite, « Demons Among Us » (40607), restait hors d'atteinte.
--
-- Même défaut que le capitaine Russo : gabarit complet, drapeau de
-- donneur de quête en place, mais personne de posé sur la carte.
--
-- POSITION. Le point de rendu officiel, dans `quest_poi`, était
-- (1249, −4379) — à 3,6 mètres de la position d'origine de Sylvanas,
-- (1251, −4376). Les deux se tenaient donc côte à côte, ce que confirme
-- la chaîne : elle donne, Allari reçoit.
--
-- Sylvanas ayant été rapprochée d'Eitrigg (voir
-- quete_destin_horde_sylvanas.sql), Allari la suit. L'emplacement exact
-- a été relevé en jeu par l'utilisateur, au `.gps` : le sol y est donné
-- à 28,4326 pour une pose à 28,4307 — elle repose dessus au millimètre.
--
-- Le point d'intérêt est recalé du même mouvement, sans quoi la flèche
-- du journal renverrait à l'ancien emplacement.
--
-- Aucun menu de dialogue : le drapeau de donneur de quête suffit à
-- ouvrir le parchemin.
-- =====================================================================

DELETE FROM `creature` WHERE `guid` = 290300101;
INSERT INTO `creature`
  (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,
   `PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,
   `position_x`,`position_y`,`position_z`,`orientation`,
   `spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,
   `MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,
   `dynamicflags`,`ScriptName`,`movementmode`,`VerifiedBuild`)
VALUES
  (290300101, 100873, 1, 14, 4982, '0', 0,
   0, 0, -1, 0, 0,
   1340.488037, -4397.252441, 28.430696, 1.307685,
   300, 0, 0, 6472, 0,
   0, 0, 0, 0, 0,
   0, '', 0, 26972);

UPDATE `quest_poi_points` p
  JOIN `quest_poi` q ON q.`QuestID` = p.`QuestID` AND q.`Idx1` = p.`Idx1`
   SET p.`X` = 1340, p.`Y` = -4397
 WHERE p.`QuestID` = 40760 AND q.`ObjectiveIndex` = 32;
