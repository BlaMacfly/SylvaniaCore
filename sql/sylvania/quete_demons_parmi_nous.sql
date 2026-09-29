-- =====================================================================
-- « Des démons parmi nous » (40607) — le marqueur de dialogue manquait
-- =====================================================================
--
-- Trouvé par l'audit systématique de la chaîne Horde, AVANT que le
-- joueur n'y arrive.
--
-- Le premier objectif, « Apprendre ce que sait Allari la Dévoreuse
-- d'âmes », est crédité par la créature 112731 — un marqueur invisible
-- qui n'avait aucune apparition, et qu'aucun script ne créditait. La
-- quête était donc impossible dès sa première ligne.
--
-- On applique le patron déjà en place sur les marqueurs de « Le destin
-- de la Horde » : apparition discrète et script « à vue hors combat »,
-- portée dix mètres, qui délivre le crédit à l'approche.
--
-- POSITION. Le point officiel, (1276, −4385), se tient à huit mètres du
-- point de la donneuse — Allari elle-même. Celle-ci ayant été posée à
-- l'emplacement relevé en jeu, le marqueur la suit : deux mètres et demi
-- d'elle, bien dans son rayon. Altitude relevée : 28,15. Le point
-- d'intérêt est recalé du même mouvement.
--
-- NE RÈGLE PAS le second objectif, « 12 démons abattus » : voir la note
-- de session, aucun démon n'existe en Durotar.
-- =====================================================================

DELETE FROM `creature` WHERE `guid` = 290300102;
INSERT INTO `creature`
  (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,
   `PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,
   `position_x`,`position_y`,`position_z`,`orientation`,
   `spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,
   `MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,
   `dynamicflags`,`ScriptName`,`movementmode`,`VerifiedBuild`)
VALUES
  (290300102, 112731, 1, 14, 4982, '0', 0,
   0, 0, -1, 0, 0,
   1338.500, -4399.000, 28.150, 1.3077,
   300, 0, 0, 1, 0,
   0, 0, 0, 0, 0,
   0, 'SmartAI', 0, 26972);

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 112731;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 112731 AND `source_type` = 0;
INSERT INTO `smart_scripts`
  (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,
   `event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,
   `action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,
   `action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,
   `target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`)
VALUES
  (112731, 0, 0, 0, 10, 0, 100, 0, 1, 10, 2000, 0,
   33, 112731, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0,
   'Proxy Parler a Allari - A vue hors combat - Credit (quete 40607)');

UPDATE `quest_poi_points` p
  JOIN `quest_poi` q ON q.`QuestID` = p.`QuestID` AND q.`Idx1` = p.`Idx1`
   SET p.`X` = 1339, p.`Y` = -4399
 WHERE p.`QuestID` = 40607 AND q.`ObjectiveIndex` IN (-1, 0);
