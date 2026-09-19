-- Silithus, etapes 1 et 2 : les PNJ de service et leurs doubles dans La Plaie.
--
-- Constat en jeu (Taelia, niveau 110, phase 2407) : les PNJ laisses sans phase
-- flottent dans La Plaie, parce que leur position est calee sur l'ancien terrain.
-- Releve a l'atterrissage, a quatre metres du point de chute :
--     Cloud Skydancer   180 m au-dessus du joueur
--     Vish Kozus        219 m
--     17 objets du monde entre 142 et 193 m
-- Les Cenarion Hold Infantry, eux, etaient bien invisibles : le phasage marche.
--
-- 1. Les 145 PNJ de service et les 785 objets du monde rejoignent l'ancienne zone.
-- 2. Les PNJ indispensables -- maitres de vol et guerisseurs d'esprit -- sont
--    DOUBLES en phase 2407, a la meme position mais au Z de la carte 1817. Sans
--    eux, un joueur de La Plaie n'aurait ni vol ni resurrection : le contenu
--    recolte pour la zone ne compte que deux marchands.
--    terrainSwapMap = 1817 pour que le serveur leur calcule la bonne aire.
--
-- Annulation : /home/ubuntu/db-backups/silithus-service-*.sql

UPDATE `creature`   SET `PhaseId` = 2392 WHERE `map` = 1 AND `zoneId` = 1377 AND `PhaseId` = 0;
UPDATE `gameobject` SET `PhaseId` = 2392 WHERE `map` = 1 AND `zoneId` = 1377 AND `PhaseId` = 0;

INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`ScriptName`,`VerifiedBuild`) VALUES
(290201812,39660,1,1377,0,'0',0,2407,0,1817,-6442.0000,-290.0000,4.0632,0.7170,300,0,0,0,0,0,'',0),
(290201813,39660,1,1377,0,'0',0,2407,0,1817,-6824.0000,892.7160,-94.9932,3.0620,300,0,0,0,0,0,'',0),
(290201814,15177,1,1377,0,'0',0,2407,0,1817,-6758.5500,775.5940,-90.1552,3.9794,300,0,0,0,0,0,'',0),
(290201815,15178,1,1377,0,'0',0,2407,0,1817,-6810.2000,841.7040,-92.9743,4.8171,300,0,0,0,0,0,'',0),
(290201816,39660,1,1377,0,'0',0,2407,0,1817,-7988.4900,1557.9600,5.1522,3.1067,300,0,0,0,0,0,'',0),
(290201817,39660,1,1377,0,'0',0,2407,0,1817,-6440.7000,-289.1450,4.2290,0.8869,300,0,0,0,0,0,'',0),
(290201818,39660,1,1377,0,'0',0,2407,0,1817,-6823.6700,892.9060,-95.0024,3.0593,300,0,0,0,0,0,'',0),
(290201819,39660,1,1377,0,'0',0,2407,0,1817,-7059.6500,1287.7400,-90.9595,0.2044,300,0,0,0,0,0,'',0),
(290201820,39660,1,1377,0,'0',0,2407,0,1817,-8026.6500,1602.0600,6.5689,3.5204,300,0,0,0,0,0,'',0),
(290201821,39660,1,1377,0,'0',0,2407,0,1817,-7972.5100,787.3310,7.0973,5.5354,300,0,0,0,0,0,'',0);
