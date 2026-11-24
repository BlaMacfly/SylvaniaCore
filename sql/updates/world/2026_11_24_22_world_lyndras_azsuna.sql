-- Couture : Lyndras (93967) recoit « Consult the Locals » (38946) et donne « Runic Catgut », « Hard Times » et
-- « So You Think You Can Sew » (38947-38949) en Azsuna (reperes de quete TDB : 282, 5876). Il n'avait aucune apparition
-- en Azsuna : seulement celle posee a Dalaran le 17/10 d'apres Wowhead, sans phase, donc visible en permanence et dans
-- le mur de l'atelier. Son apparition de Dalaran est deja fournie par LegionCore (phase 7000, selon l'avancee de la
-- chaine a partir de 38950). On retire celle de Wowhead et on pose celle d'Azsuna de LegionCore.
DELETE FROM `creature` WHERE `guid`=290401594 AND `id`=93967;

SET @C := (SELECT MAX(guid) FROM creature);
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`dynamicflags`,`ScriptName`,`VerifiedBuild`) VALUES
(@C+1,93967,1220,7334,8418,'0',0,0,0,-1,0,0,274.849,5872.9,15.9844,3.5695,300,0,0,0,0,0,0,0,0,0,0,'',0);
