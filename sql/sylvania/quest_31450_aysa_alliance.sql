-- =====================================================================
-- Quête 31450 « Un nouveau destin » — branche ALLIANCE absente
--
-- Symptôme : la quête passe en « à rendre » mais le PNJ récepteur est
-- introuvable à l'endroit indiqué par la carte, à Hurlevent.
--
-- Cause : la quête 31450 se rend à Aysa Poète des Nuages (60566) côté
-- Alliance, ou à Ji Patte-de-Feu (60570) côté Horde. La branche Horde est
-- complète ; la branche Alliance n'existe pas :
--   * Aysa 60566 n'a AUCUN spawn — ni chez nous, ni dans la base mondiale
--     officielle TrinityCore 7.3.5 (vérifié dans DB_world_735.02.sql, où
--     l'entrée n'apparaît qu'en creature_template, creature_questender et
--     creature_queststarter). C'est une lacune amont, pas une corruption.
--   * Aucune ligne `phase_area` ni `conditions` pour la zone d'Elwynn : le
--     pendant Horde en possède (aire 14 Durotar, phases 1164 et 1165).
-- Conséquence : la quête 31450 est indéfiniment bloquée pour tout pandaren
-- ayant choisi l'Alliance, et la suivante — 30987 « Rejoindre l'Alliance »,
-- également donnée par Aysa 60566 — est inatteignable.
--
-- POSITION : relevée, pas inventée.
--   * `quest_poi_points` de la quête 31450 (données client, VerifiedBuild
--     22908) donne 4 points : 2 au temple sur l'île, (1364,-4373) pour la
--     Horde et (-9118,392) pour l'Alliance.
--   * Ce POI Horde correspond au mètre près au spawn réel de Ji
--     (1363.75, -4372.51) : le POI EST la position du PNJ. On applique donc
--     le POI Alliance tel quel.
--   * Altitude : sol relevé à 91.997 et 91.742 sur les deux spawns
--     permanents les plus proches (7 et 8 m) ; le point d'arrivée du sort de
--     téléportation 116957 (-9128.09, 388.54, 91.163) confirme le niveau.
--   * Seule l'orientation n'est issue d'aucun relevé : 3.47 rad, calculée
--     pour qu'Aysa fasse face au point d'arrivée du joueur.
--
-- PHASE : transposition stricte du mécanisme Horde. La phase 1164 est
-- déclarée sur l'aire 12 (Forêt d'Elwynn) — `PhasingHandler::OnAreaChange`
-- remonte les aires parentes, ce qui couvre la sous-aire 7486 où se trouve
-- le point d'arrivée. Conditions identiques à Durotar, avec la quête
-- Alliance 30987 à la place de la Horde 31012 : Aysa n'apparaît qu'entre la
-- complétion de 31450 et la prise de 30987.
--
-- Nécessite un redémarrage (spawns, phase_area et conditions sont lus au
-- démarrage).
-- =====================================================================

DELETE FROM `creature` WHERE `guid`=290000005;
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`PhaseId`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`MovementType`) VALUES
(290000005,60566,0,0,0,'0',1164,-9118.0,392.0,91.9,3.47,120,0);

DELETE FROM `phase_area` WHERE `AreaId`=12 AND `PhaseId`=1164;
INSERT INTO `phase_area` (`AreaId`,`PhaseId`,`Comment`) VALUES
(12,1164,'Elwynn Forest - after quest 31450 complete and before quest 30987 taken');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=26 AND `SourceGroup`=1164 AND `SourceEntry`=12;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(26,1164,12,0,0,47,0,30987,74,0,1,0,0,'','Elwynn Forest Phase 1164 when Quest 30987 not incomplete, not complete and not rewarded'),
(26,1164,12,0,0,47,0,31450,66,0,0,0,0,'','Elwynn Forest Phase 1164 when Quest 31450 complete or rewarded');
