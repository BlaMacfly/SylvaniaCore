-- Scenarios of Legion dungeons and of the scenario maps without one
-- Dungeons: the boss tracker scenarios of LegionCore-Reforged scenario_data (difficulty 0 = any difficulty).
-- Eye of Azshara and Darkheart Thicket ran their keystone scenario on every difficulty: the keystone
-- scenarios are now started with the key (ScenarioMgr::CreateChallengeScenario).
-- Black Rook Hold (1023) and The Arcway (967) keep out: their difficulties are steps of one scenario.
DELETE FROM `scenarios` WHERE `map` IN (1456, 1466) AND `class` = 0;
DELETE FROM `scenarios` WHERE `map` IN (1458, 1477, 1492, 1493, 1571, 1677, 1753);
INSERT INTO `scenarios` (`map`, `difficulty`, `class`, `scenario_A`, `scenario_H`, `zoneid`) VALUES
(1456, 0, 0, 1254, 1254, 0),  -- Eye of Azshara
(1466, 0, 0, 978, 978, 0),    -- Darkheart Thicket
(1458, 0, 0, 942, 942, 0),    -- Neltharion's Lair
(1458, 23, 0, 1257, 1257, 0),
(1477, 0, 0, 929, 929, 0),    -- Halls of Valor
(1477, 2, 0, 932, 932, 0),
(1477, 23, 0, 1255, 1255, 0),
(1492, 0, 0, 992, 992, 0),    -- Maw of Souls
(1493, 0, 0, 1005, 1005, 0),  -- Vault of the Wardens
(1493, 23, 0, 1258, 1258, 0),
(1571, 0, 0, 1050, 1050, 0),  -- Court of Stars
(1571, 23, 0, 1252, 1252, 0),
(1677, 0, 0, 1321, 1321, 0),  -- Cathedral of Eternal Night
(1753, 2, 0, 1352, 1352, 0),  -- Seat of the Triumvirate
(1753, 23, 0, 1354, 1354, 0);

-- Scenario maps: LFGDungeons.ScenarioID of the 7.3.5 client, one scenario per map and faction
-- (agrees with LegionCore-Reforged where it has the map). The Might of the Alliance / of the Horde share map 1329.
-- Temple of Elune (1478, 874) keeps out: the scenario has no step in 7.3.5.
DELETE FROM `scenarios` WHERE `map` IN (1157, 1200, 1329, 1461, 1475, 1523, 1529, 1545, 1622, 1623, 1624, 1626, 1646, 1673,
    1683, 1684, 1687, 1688, 1693, 1695, 1698, 1702, 1703, 1708, 1710, 1714, 1719, 1723, 1729, 1730, 1731, 1732, 1733, 1734, 1737,
    1744, 1756, 1774, 1812, 1840);
DELETE FROM `scenarios` WHERE `map` = 1431 AND `difficulty` = 20;
INSERT INTO `scenarios` (`map`, `difficulty`, `class`, `scenario_A`, `scenario_H`, `zoneid`) VALUES
(1157, 11, 0, 278, 278, 0),   -- Noodle Time
(1157, 12, 0, 269, 269, 0),   -- Finding the Secret Ingredient
(1200, 12, 0, 323, 323, 0),   -- Bonetown
(1329, 12, 0, 508, 509, 0),   -- The Might of the Alliance / of the Horde
(1431, 20, 0, 736, 736, 0),   -- The Coliseum: the map only has difficulty 20
(1461, 12, 0, 795, 795, 0),   -- Tides of Glory
(1475, 12, 0, 826, 824, 0),   -- Greymane's Gambit / The Splintered Fleet
(1523, 12, 0, 975, 975, 0),   -- Defense of the Fel Hammer
(1529, 12, 0, 989, 989, 0),   -- Return to Karazhan
(1545, 12, 0, 1012, 1012, 0), -- The Dread Admiral
(1622, 12, 0, 1410, 0, 0),    -- Telogrus Rift
(1623, 12, 0, 1135, 1135, 0), -- The Oculus
(1624, 12, 0, 1138, 1138, 0), -- Battle for the Exodar
(1626, 12, 0, 1150, 1150, 0), -- The Collapse
(1646, 12, 0, 1179, 1179, 0), -- Ravencrest's Legacy
(1673, 12, 0, 1204, 1204, 0), -- The Archmage's Reckoning
(1683, 12, 0, 1220, 1220, 0), -- Imminent Launch
(1684, 12, 0, 1273, 1273, 0), -- Thwarting the Twins
(1687, 12, 0, 1235, 1235, 0), -- Wailing Critters
(1688, 12, 0, 1293, 1293, 0), -- Deadmines: Pet Edition
(1693, 12, 0, 1236, 1236, 0), -- Panic at the Brewery
(1695, 12, 0, 1244, 1244, 0), -- Battleship: Ruin
(1698, 12, 0, 1259, 1259, 0), -- Kruul's Intentions
(1702, 12, 0, 1266, 1266, 0), -- Feltotem's Fall
(1703, 12, 0, 1265, 1265, 0), -- The God-Queen's Fury
(1708, 12, 0, 1275, 1275, 0), -- Stirring in the Shadows
(1710, 12, 0, 1281, 1281, 0), -- End of the Risen Threat
(1714, 12, 0, 1283, 1283, 0), -- Tournament of Valor
(1719, 12, 0, 1298, 1298, 0), -- Calling the Wrathsteed
(1723, 12, 0, 1292, 1292, 0), -- The Coldridge Cataclysm
(1729, 12, 0, 1230, 1230, 0), -- Dispersion of the Discs
(1730, 12, 0, 1306, 1306, 0), -- Defense of Aviana
(1731, 12, 0, 1312, 1312, 0), -- You Can't Take the Sky from Me
(1732, 12, 0, 1303, 1303, 0), -- Felwing Ledge
(1733, 12, 0, 1304, 1304, 0), -- Azeroth's Warning
(1734, 12, 0, 1307, 1307, 0), -- Gathering of the Storms
(1737, 12, 0, 1310, 1310, 0), -- Akazamzarak's Hat
(1744, 30, 0, 1329, 1329, 0), -- The Trial of Style
(1756, 12, 0, 1351, 1351, 0), -- The Deaths of Chromie
(1774, 12, 0, 1434, 0, 0),    -- Forge of Aeons
(1812, 12, 0, 0, 1423, 0),    -- Suramar (Nightborne)
(1840, 12, 0, 0, 1443, 0);    -- Remember the Sunwell
