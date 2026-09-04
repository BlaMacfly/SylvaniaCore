-- =====================================================================
-- Rivage brisé — armer les alliés
--
-- SIGNALÉ EN JEU : « les PNJ ne portent encore aucune arme ».
--
-- L'état de fourreau ne suffisait pas : il n'y avait rien à
-- dégainer. Sur les 51 entrées alliées de la carte, seules QUATRE
-- avaient un équipement défini — les 47 autres n'ont jamais eu
-- d'arme, ni en base ni sur leur modèle.
--
-- Source : creature_equip_template du dump de référence
-- dufernst/LegionCore-7.3.5, qui les renseigne. 30 équipements
-- pour autant d'entrées.
--
-- Les spawns de la carte qui n'en portaient aucun se voient
-- attribuer le jeu numéro 1 de leur entrée, quand il existe.
-- =====================================================================

INSERT INTO `creature_equip_template` (`CreatureID`,`ID`,`ItemID1`,`ItemID2`,`ItemID3`) VALUES (90708,1,140776,0,0) ON DUPLICATE KEY UPDATE `ItemID1`=VALUES(`ItemID1`), `ItemID2`=VALUES(`ItemID2`), `ItemID3`=VALUES(`ItemID3`);
INSERT INTO `creature_equip_template` (`CreatureID`,`ID`,`ItemID1`,`ItemID2`,`ItemID3`) VALUES (90709,1,2179,0,0) ON DUPLICATE KEY UPDATE `ItemID1`=VALUES(`ItemID1`), `ItemID2`=VALUES(`ItemID2`), `ItemID3`=VALUES(`ItemID3`);
INSERT INTO `creature_equip_template` (`CreatureID`,`ID`,`ItemID1`,`ItemID2`,`ItemID3`) VALUES (90710,1,58367,0,0) ON DUPLICATE KEY UPDATE `ItemID1`=VALUES(`ItemID1`), `ItemID2`=VALUES(`ItemID2`), `ItemID3`=VALUES(`ItemID3`);
INSERT INTO `creature_equip_template` (`CreatureID`,`ID`,`ItemID1`,`ItemID2`,`ItemID3`) VALUES (90711,1,140777,0,0) ON DUPLICATE KEY UPDATE `ItemID1`=VALUES(`ItemID1`), `ItemID2`=VALUES(`ItemID2`), `ItemID3`=VALUES(`ItemID3`);
INSERT INTO `creature_equip_template` (`CreatureID`,`ID`,`ItemID1`,`ItemID2`,`ItemID3`) VALUES (90712,1,140546,0,0) ON DUPLICATE KEY UPDATE `ItemID1`=VALUES(`ItemID1`), `ItemID2`=VALUES(`ItemID2`), `ItemID3`=VALUES(`ItemID3`);
INSERT INTO `creature_equip_template` (`CreatureID`,`ID`,`ItemID1`,`ItemID2`,`ItemID3`) VALUES (90713,1,45899,0,0) ON DUPLICATE KEY UPDATE `ItemID1`=VALUES(`ItemID1`), `ItemID2`=VALUES(`ItemID2`), `ItemID3`=VALUES(`ItemID3`);
INSERT INTO `creature_equip_template` (`CreatureID`,`ID`,`ItemID1`,`ItemID2`,`ItemID3`) VALUES (90714,1,139131,0,12869) ON DUPLICATE KEY UPDATE `ItemID1`=VALUES(`ItemID1`), `ItemID2`=VALUES(`ItemID2`), `ItemID3`=VALUES(`ItemID3`);
INSERT INTO `creature_equip_template` (`CreatureID`,`ID`,`ItemID1`,`ItemID2`,`ItemID3`) VALUES (90716,1,53096,0,11587) ON DUPLICATE KEY UPDATE `ItemID1`=VALUES(`ItemID1`), `ItemID2`=VALUES(`ItemID2`), `ItemID3`=VALUES(`ItemID3`);
INSERT INTO `creature_equip_template` (`CreatureID`,`ID`,`ItemID1`,`ItemID2`,`ItemID3`) VALUES (90717,1,139132,0,0) ON DUPLICATE KEY UPDATE `ItemID1`=VALUES(`ItemID1`), `ItemID2`=VALUES(`ItemID2`), `ItemID3`=VALUES(`ItemID3`);
INSERT INTO `creature_equip_template` (`CreatureID`,`ID`,`ItemID1`,`ItemID2`,`ItemID3`) VALUES (91353,1,45726,0,45727) ON DUPLICATE KEY UPDATE `ItemID1`=VALUES(`ItemID1`), `ItemID2`=VALUES(`ItemID2`), `ItemID3`=VALUES(`ItemID3`);
INSERT INTO `creature_equip_template` (`CreatureID`,`ID`,`ItemID1`,`ItemID2`,`ItemID3`) VALUES (91949,1,0,0,0) ON DUPLICATE KEY UPDATE `ItemID1`=VALUES(`ItemID1`), `ItemID2`=VALUES(`ItemID2`), `ItemID3`=VALUES(`ItemID3`);
INSERT INTO `creature_equip_template` (`CreatureID`,`ID`,`ItemID1`,`ItemID2`,`ItemID3`) VALUES (91951,1,13262,0,0) ON DUPLICATE KEY UPDATE `ItemID1`=VALUES(`ItemID1`), `ItemID2`=VALUES(`ItemID2`), `ItemID3`=VALUES(`ItemID3`);
INSERT INTO `creature_equip_template` (`CreatureID`,`ID`,`ItemID1`,`ItemID2`,`ItemID3`) VALUES (92074,1,73008,0,0) ON DUPLICATE KEY UPDATE `ItemID1`=VALUES(`ItemID1`), `ItemID2`=VALUES(`ItemID2`), `ItemID3`=VALUES(`ItemID3`);
INSERT INTO `creature_equip_template` (`CreatureID`,`ID`,`ItemID1`,`ItemID2`,`ItemID3`) VALUES (92122,1,0,0,0) ON DUPLICATE KEY UPDATE `ItemID1`=VALUES(`ItemID1`), `ItemID2`=VALUES(`ItemID2`), `ItemID3`=VALUES(`ItemID3`);
INSERT INTO `creature_equip_template` (`CreatureID`,`ID`,`ItemID1`,`ItemID2`,`ItemID3`) VALUES (92586,1,0,0,0) ON DUPLICATE KEY UPDATE `ItemID1`=VALUES(`ItemID1`), `ItemID2`=VALUES(`ItemID2`), `ItemID3`=VALUES(`ItemID3`);
INSERT INTO `creature_equip_template` (`CreatureID`,`ID`,`ItemID1`,`ItemID2`,`ItemID3`) VALUES (93704,1,13631,0,0) ON DUPLICATE KEY UPDATE `ItemID1`=VALUES(`ItemID1`), `ItemID2`=VALUES(`ItemID2`), `ItemID3`=VALUES(`ItemID3`);
INSERT INTO `creature_equip_template` (`CreatureID`,`ID`,`ItemID1`,`ItemID2`,`ItemID3`) VALUES (94209,1,1899,0,117413) ON DUPLICATE KEY UPDATE `ItemID1`=VALUES(`ItemID1`), `ItemID2`=VALUES(`ItemID2`), `ItemID3`=VALUES(`ItemID3`);
INSERT INTO `creature_equip_template` (`CreatureID`,`ID`,`ItemID1`,`ItemID2`,`ItemID3`) VALUES (94223,1,40595,0,40596) ON DUPLICATE KEY UPDATE `ItemID1`=VALUES(`ItemID1`), `ItemID2`=VALUES(`ItemID2`), `ItemID3`=VALUES(`ItemID3`);
INSERT INTO `creature_equip_template` (`CreatureID`,`ID`,`ItemID1`,`ItemID2`,`ItemID3`) VALUES (97496,1,45726,0,45727) ON DUPLICATE KEY UPDATE `ItemID1`=VALUES(`ItemID1`), `ItemID2`=VALUES(`ItemID2`), `ItemID3`=VALUES(`ItemID3`);
INSERT INTO `creature_equip_template` (`CreatureID`,`ID`,`ItemID1`,`ItemID2`,`ItemID3`) VALUES (97502,1,40595,0,40596) ON DUPLICATE KEY UPDATE `ItemID1`=VALUES(`ItemID1`), `ItemID2`=VALUES(`ItemID2`), `ItemID3`=VALUES(`ItemID3`);
INSERT INTO `creature_equip_template` (`CreatureID`,`ID`,`ItemID1`,`ItemID2`,`ItemID3`) VALUES (97503,1,1899,0,117413) ON DUPLICATE KEY UPDATE `ItemID1`=VALUES(`ItemID1`), `ItemID2`=VALUES(`ItemID2`), `ItemID3`=VALUES(`ItemID3`);
INSERT INTO `creature_equip_template` (`CreatureID`,`ID`,`ItemID1`,`ItemID2`,`ItemID3`) VALUES (97521,1,140546,0,0) ON DUPLICATE KEY UPDATE `ItemID1`=VALUES(`ItemID1`), `ItemID2`=VALUES(`ItemID2`), `ItemID3`=VALUES(`ItemID3`);
INSERT INTO `creature_equip_template` (`CreatureID`,`ID`,`ItemID1`,`ItemID2`,`ItemID3`) VALUES (97525,1,12754,0,0) ON DUPLICATE KEY UPDATE `ItemID1`=VALUES(`ItemID1`), `ItemID2`=VALUES(`ItemID2`), `ItemID3`=VALUES(`ItemID3`);
INSERT INTO `creature_equip_template` (`CreatureID`,`ID`,`ItemID1`,`ItemID2`,`ItemID3`) VALUES (97526,1,5286,0,5286) ON DUPLICATE KEY UPDATE `ItemID1`=VALUES(`ItemID1`), `ItemID2`=VALUES(`ItemID2`), `ItemID3`=VALUES(`ItemID3`);
INSERT INTO `creature_equip_template` (`CreatureID`,`ID`,`ItemID1`,`ItemID2`,`ItemID3`) VALUES (97527,1,2176,0,0) ON DUPLICATE KEY UPDATE `ItemID1`=VALUES(`ItemID1`), `ItemID2`=VALUES(`ItemID2`), `ItemID3`=VALUES(`ItemID3`);
INSERT INTO `creature_equip_template` (`CreatureID`,`ID`,`ItemID1`,`ItemID2`,`ItemID3`) VALUES (97528,1,2176,0,0) ON DUPLICATE KEY UPDATE `ItemID1`=VALUES(`ItemID1`), `ItemID2`=VALUES(`ItemID2`), `ItemID3`=VALUES(`ItemID3`);
INSERT INTO `creature_equip_template` (`CreatureID`,`ID`,`ItemID1`,`ItemID2`,`ItemID3`) VALUES (110941,1,40595,0,40596) ON DUPLICATE KEY UPDATE `ItemID1`=VALUES(`ItemID1`), `ItemID2`=VALUES(`ItemID2`), `ItemID3`=VALUES(`ItemID3`);
INSERT INTO `creature_equip_template` (`CreatureID`,`ID`,`ItemID1`,`ItemID2`,`ItemID3`) VALUES (112879,1,73008,0,0) ON DUPLICATE KEY UPDATE `ItemID1`=VALUES(`ItemID1`), `ItemID2`=VALUES(`ItemID2`), `ItemID3`=VALUES(`ItemID3`);
INSERT INTO `creature_equip_template` (`CreatureID`,`ID`,`ItemID1`,`ItemID2`,`ItemID3`) VALUES (112920,1,0,0,0) ON DUPLICATE KEY UPDATE `ItemID1`=VALUES(`ItemID1`), `ItemID2`=VALUES(`ItemID2`), `ItemID3`=VALUES(`ItemID3`);
INSERT INTO `creature_equip_template` (`CreatureID`,`ID`,`ItemID1`,`ItemID2`,`ItemID3`) VALUES (112921,1,0,0,0) ON DUPLICATE KEY UPDATE `ItemID1`=VALUES(`ItemID1`), `ItemID2`=VALUES(`ItemID2`), `ItemID3`=VALUES(`ItemID3`);

UPDATE `creature` c
  JOIN `creature_equip_template` e ON e.`CreatureID` = c.`id` AND e.`ID` = 1
   SET c.`equipment_id` = 1
 WHERE c.`map` = 1460 AND c.`equipment_id` = 0;
