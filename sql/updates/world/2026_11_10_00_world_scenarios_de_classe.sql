-- Scenarios de classe (armes prodigieuses, campagnes) : plusieurs classes partagent une carte.
-- Notre table ne gardait qu'un scenario par carte, souvent celui d'une autre classe (1539 : chasseur 972
-- pour tous ; 1611 : paladin 1092 ; 1579 : chasseur 1068) et 13 cartes n'en avaient aucun (1494 : mage).
-- Colonne `class` (0 = toute classe) et lignes de LegionCore (scenario_data.Class).
-- Carte 1533 : LegionCore laisse 988 et 1026 en "toute classe" ; attribues d'apres leurs etapes
-- (Scenario.db2 7.3.5) : 988 Ulthalesh = demoniste, 1026 Apocalypse = chevalier de la mort.
-- Scenario 0 = aucun scenario pour cette classe (chasseur de demons sur 1494, chasseur sur 1579).
ALTER TABLE `scenarios`
  ADD COLUMN `class` tinyint(3) unsigned NOT NULL DEFAULT 0 AFTER `difficulty`,
  DROP PRIMARY KEY,
  ADD PRIMARY KEY (`map`, `difficulty`, `class`);

DELETE FROM `scenarios` WHERE `map` IN (1489,1494,1495,1498,1511,1526,1528,1533,1536,1539,1541,1572,1579,1599,1600,1609,1611,1612,1616,1617,1621,1625);
INSERT INTO `scenarios` (`map`,`difficulty`,`class`,`scenario_A`,`scenario_H`,`zoneid`) VALUES
(1489,0,0,940,940,0),
(1489,0,1,1146,1146,0),
(1489,0,3,972,972,0),
(1489,0,5,1085,1085,0),
(1489,0,12,1145,1145,0),
(1494,0,3,1136,1136,0),
(1494,0,8,1034,1034,0),
(1494,0,12,0,0,0),
(1495,0,1,909,909,0),
(1495,0,2,1082,1082,0),
(1495,0,3,1068,1068,0),
(1498,0,12,900,900,0),
(1511,0,1,944,944,0),
(1511,0,3,973,973,0),
(1526,0,7,976,976,0),
(1528,0,10,983,983,0),
(1533,0,6,1026,1026,0),
(1533,0,9,988,988,0),
(1533,0,11,1014,1014,0),
(1536,0,11,990,990,0),
(1539,0,1,1037,1037,0),
(1539,0,2,1092,1092,0),
(1539,0,5,991,991,0),
(1541,8,10,1007,1007,0),
(1572,0,7,1038,1038,0),
(1579,0,1,1148,1148,0),
(1579,0,3,0,0,0),
(1599,0,11,1061,1061,0),
(1600,0,7,1066,1066,0),
(1609,0,3,1099,1099,0),
(1611,0,6,1157,1157,0),
(1612,0,11,1108,1108,0),
(1616,0,0,1221,1221,0),
(1616,0,8,1122,1122,0),
(1617,0,6,1134,1134,0),
(1621,0,12,1131,1131,0),
(1625,0,10,1137,1137,0);
