-- =====================================================================
-- Salles des Valeureux (carte 1477) : les 3 boss absents
--
-- Constat du 2026-09-10 : Hymdall, Fenryr et les quatre Rois valarjar
-- sont bien posés, mais Hyrja, le Roi-dieu Skovald et Odyn n'existent
-- nulle part dans `creature` — donc le donjon s'arrête après Fenryr.
-- Leurs modèles, factions, drapeaux, scripts et tables de butin sont
-- pourtant tous en base : il ne manquait que les apparitions.
--
-- Positions : Odyn est repris tel quel du script (boss_odyn.cpp,
-- SetHomePosition 2402.76 / 528.64 / 748.99) ; Skovald est placé dans le
-- hall d'Odyn, à l'intérieur de la porte 246145 (2520.3 / 529.0 / 749.0)
-- dont il commande la fermeture ; Hyrja et ses deux acolytes sont posés
-- au-delà de la porte de sa salle (245702, 3196.2 / 371.3 / 655.4), sur
-- l'axe d'entrée. La position de Hyrja est la seule estimée : si elle
-- flotte ou s'enfonce, corriger le seul Z avec un UPDATE.
--
-- Odyn a `lootid = 0` : sa ligne de Guide d'aventure est ajoutée ici
-- (rencontre 1489, 17 objets officiels). Hyrja et Skovald ont déjà leurs
-- tables de butin, on n'y touche pas.
-- =====================================================================

DELETE FROM `creature` WHERE `guid` BETWEEN 290200801 AND 290200805;
INSERT INTO `creature`
    (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,
     `terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,
     `spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,
     `npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`dynamicflags`,`ScriptName`,`movementmode`,`VerifiedBuild`) VALUES
(290200801, 95833, 1477, 7672, 7672, '1,2,8,23', 0,0,0, -1, 0,0, 3175.00,  350.00, 655.40, 0.79, 7200,0,0,0,0,0, 0,0,0,0,0, '', 0, 0), -- Hyrja
(290200802, 97202, 1477, 7672, 7672, '1,2,8,23', 0,0,0, -1, 0,0, 3166.50,  358.50, 655.40, 0.79, 7200,0,0,0,0,0, 0,0,0,0,0, '', 0, 0), -- Olmyr the Enlightened
(290200803, 97219, 1477, 7672, 7672, '1,2,8,23', 0,0,0, -1, 0,0, 3183.50,  341.50, 655.40, 0.79, 7200,0,0,0,0,0, 0,0,0,0,0, '', 0, 0), -- Solsten
(290200804, 95675, 1477, 7672, 7672, '1,2,8,23', 0,0,0, -1, 0,0, 2500.00,  529.00, 749.00, 0.00, 7200,0,0,0,0,0, 0,0,0,0,0, '', 0, 0), -- God-King Skovald
(290200805, 95676, 1477, 7672, 7672, '1,2,8,23', 0,0,0, -1, 0,0, 2402.76,  528.64, 748.99, 0.00, 7200,0,0,0,0,0, 0,0,0,0,0, '', 0, 0); -- Odyn

-- Odyn n'a aucune table de butin : on le branche sur le Guide d'aventure
DELETE FROM `creature_template_journal` WHERE `entry` = 95676;
INSERT INTO `creature_template_journal` (`entry`,`JournalEncounterID`) VALUES (95676, 1489);
