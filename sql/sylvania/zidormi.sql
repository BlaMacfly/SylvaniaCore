-- Zidormi : le second guide temporel de Silithus.
--
-- C'est lui que les joueurs connaissent -- a l'entree de la zone, la ou l'on arrive
-- d'Un'Goro. Son gabarit existait sans spawn, sans script, sans npcflag.
--
-- Position croisee entre deux sources concordantes :
--   Wowhead, pin [78.8, 22] avec uiMapPhaseId 9491  -> -6468.3 / -214.6
--   Z code en dur dans l'ancien npc_zidormi_128607  -> -6467.526 / -219.9097 / 5.90872
-- Les deux ne different que de 5,4 m, sous la precision d'un pin. On retient la
-- seconde, qui porte un Z et une orientation, donc vient d'un releve reel. Controle :
-- le terrain y vaut 5.02 sur la carte 1 comme sur la 1817, soit 89 cm sous le Z code
-- en dur -- la hauteur normale d'un PNJ. Pas de dalle a cet endroit, contrairement a
-- Rhonormu.
--
-- Meme script que Rhonormu : le mecanisme est identique, seule l'entree change.
-- Hors phase, comme lui : un guide temporel doit etre visible des deux cotes, sinon
-- le voyage serait a sens unique.
--
-- Annulation : DELETE FROM creature WHERE guid = 290203200;
--              UPDATE creature_template SET ScriptName='', npcflag=0 WHERE entry=128607;

UPDATE `creature_template`
   SET `ScriptName` = 'npc_silithus_guide_temporel',
       `npcflag`    = 1
 WHERE `entry` = 128607;

UPDATE `creature_template`
   SET `ScriptName` = 'npc_silithus_guide_temporel'
 WHERE `entry` = 133263;

DELETE FROM `creature` WHERE `guid` = 290203200;
INSERT INTO `creature`
 (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,
  `terrainSwapMap`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,
  `currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`ScriptName`,`VerifiedBuild`) VALUES
(290203200, 128607, 1, 1377, 0, '0', 0, 0, 0, -1,
 -6467.526, -219.9097, 5.90872, 2.209932, 300, 0, 0, 0, 0, 0, '', 0);
-- le spawn en phase 2407 issu de la recolte fait doublon avec celui-ci,
-- et surtout il est phase : il disparaitrait des que le joueur remonte le temps.
DELETE FROM `creature` WHERE `guid` = 290202167;
