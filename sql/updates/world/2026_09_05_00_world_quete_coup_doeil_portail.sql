-- Quete 36382 "Coup d'oeil dans le portail" (Horde) : tout le cote Horde manquait.
--
-- Signalement joueur : impossible d'utiliser le telescope, et l'eclaireuse a cote attaque.
-- Cause : Scout Pazaztick (85249) et le telescope Horde (234619) n'ont AUCUN spawn en base.
-- Seule la paire Alliance existe (Scout Pazerp 85212 + telescope 234576, map 1190 area 6963).
-- Un joueur Horde qui prend la quete chez Rokhan arrive donc sur la paire Alliance :
--   - le telescope 234576 ne valide que l'objectif de la quete 36379 (Alliance) ;
--   - Scout Pazerp est en faction 84 (Hurlevent), donc hostile a la Horde et elle agresse.
-- Sur les royaumes officiels les deux paires cohabitent au meme endroit, separees par phasing.
-- La zone (map 1190) n'a aucun phasing chez nous : on partage donc le telescope existant.

-- 1) Les deux eclaireuses deviennent neutres. Ce sont des PNJ decoratifs (npcflag 0,
--    aucun gossip, aucun role de combat) : leur faction ne sert qu'a les faire agresser.
UPDATE `creature_template` SET `faction` = 35 WHERE `entry` IN (85212, 85249);

-- 2) Le telescope deja spawne sert aux deux factions.
--    Data1 = quete requise pour valider le goober : a 36379 il bloquait tout joueur Horde.
UPDATE `gameobject_template` SET `Data1` = 0 WHERE `entry` = 234576;
UPDATE `quest_objectives` SET `ObjectID` = 234576 WHERE `ID` = 274669 AND `QuestID` = 36382;

-- 3) Scout Pazaztick est spawnee a cote de Scout Pazerp (le journal de quete demande de la
--    trouver ; elle ne porte aucun objectif, c'est le telescope qui valide).
DELETE FROM `creature` WHERE `guid` = 290200757;
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`dynamicflags`,`ScriptName`,`movementmode`,`VerifiedBuild`) VALUES
(290200757, 85249, 1190, 4, 6963, '0', 0, 0, 0, -1, 0, 0, -11474.94, -3450.80, 32.7659, 2.03782, 120, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, '', 0, 0);
