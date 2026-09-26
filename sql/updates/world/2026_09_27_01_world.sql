-- Correctifs de contenu (2e lot) portes depuis Krigsgaldrnet/AshamaneCore
-- Analyse detaillee commit par commit : exclusion stricte de toute table indexee par GUID de spawn (creature/gameobject/etc.) et de smart_scripts

-- DB/Creature: Archmage Khadgar
DELETE FROM `creature_text` WHERE `CreatureID`=78558;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(78558, 0, 0, 'We\'re all counting on you, $n.', 12, 0, 100, 1, 0, 44868, 0, 0, 'Archmage Khadgar to Player'),
(78558, 1, 1, 'Look! The portal grows weaker!', 14, 0, 100, 0, 0, 44883, 0, 0, 'Archmage Khadgar to Player'),
(78558, 2, 2, 'Hold that front! Our work is nearly done!', 14, 0, 100, 0, 0, 44884, 0, 0, 'Archmage Khadgar to Player'),
(78558, 3, 3, 'Please, don\'t wander too far. We need you here, champion.', 12, 0, 100, 0, 0, 44879, 0, 0, 'Archmage Khadgar to Player'),
(78558, 4, 4, 'Use whatever means are necessary, champion. Azeroth\'s final hope lies with you.', 12, 0, 100, 1, 0, 44873, 0, 0, 'Archmage Khadgar to Player');


-- DB: Remove wrong conditions
-- 
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=20;

-- DB/Conditions: fix Sablemane's Sleeping Powder exploit
-- Condition for source Spell condition type Object entry guid
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=17 AND `SourceGroup`=0 AND `SourceEntry`=38510 AND `SourceId`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(17, 0, 38510, 0, 0, 31, 1, 3, 20216, 0, 0, 0, 0, '', 'Spell Sablemane''s Sleeping Powder will hit the explicit target of the spell if target is unit Grulloc.');

-- DB/Creature: Meryl Felstorm creature text
DELETE FROM `creature_text` WHERE `CreatureId`=102700;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `comment`) VALUES
(102700, 0, 0, 'It seems my fears were well-founded! The dreadlord is already inside. We must hurry!', 12, 0, 100, 603, 0, 69708, 120632, 'Meryl·Felsong to Player'),
(102700, 1, 0, 'The hall hasn''t seen any use since the disbanding of the Council of Tirisfal.', 12, 0, 100, 0, 0, 61731, 105438, 'Meryl·Felsong to Player'),
(102700, 2, 0, 'Look to the stacks for answers. I will check my memory vault.', 12, 0, 100, 1, 0, 64246, 112312, 'Meryl·Felsong to Player'),
(102700, 3, 0, 'So Arrexis was ambushed by this eredar, Balaadur?  Then he is probably in possession of the staff...', 12, 0, 100, 1, 0, 64241, 112317, 'Meryl·Felsong to Player'),
(102700, 4, 0, 'With the invasion I have no doubt he is either here or watching. I propose something... audacious.', 12, 0, 100, 1, 0, 64243, 112326, 'Meryl·Felsong to Player'),
(102700, 5, 0, 'Let us recreate Arrexis''s ritual! Conducting the ritual at an invasion point will attract Balaadur''s attention. He will likely try an ambush, but we will be ready.', 12, 0, 100, 1, 0, 64244, 112327, 'Meryl·Felsong to Player'),
(102700, 6, 0, 'In the center of Dalaran is a portal that can you to Karazhan. Start your search in the mountains west of the tower. I seem to recall a mention of something up there.', 12, 0, 100, 1, 0, 64247, 112462, 'Meryl·Felsong to Player'),
(102700, 7, 0, 'Uh, I''m pretty sure she''s a goblin now.', 12, 0, 100, 11, 0, 64239, 112459, 'Meryl·Felsong to Player'),
(102700, 8, 0, 'I will arrange transportation at Krasus'' Landing. Talk to the flight master when you are ready.', 12, 0, 100, 1, 0, 64248, 112812, 'Meryl·Felsong to Player'),
(102700, 9, 0, 'Alright Akazamzarak, you have the locations. Do you think you can manage the portals?', 12, 0, 100, 0, 0, 61738, 105822, 'Meryl·Felsong to Player'),
(102700, 10, 0, 'Mages of Azeroth! I have summoned you here because we face a threat to the future of the world itself!', 12, 0, 100, 0, 0, 61740, 105824, 'Meryl·Felsong to Player'),
(102700, 11, 0, 'The dreadlord Kathra\'natir has escaped into the Twisting Nether, carrying with him the secrets of the Council of Tirisfal.', 12, 0, 100, 0, 0, 61742, 105825, 'Meryl·Felsong to Player'),
(102700, 12, 0, 'We must hunt him down in the Twisting Nether. Only then will we know his knowledge cannot be used against us.', 12, 0, 100, 0, 0, 61743, 105826, 'Meryl·Felsong to Player'),
(102700, 13, 0, 'To this end, I hereby reform the Tirisgarde. Will you join us and take up arms against the Legion?', 12, 0, 100, 0, 0, 61744, 105827, 'Meryl·Felsong to Player'),
(102700, 14, 0, 'It is done, then.', 12, 0, 100, 1, 0, 61745, 105828, 'Meryl·Felsong to Player'),
(102700, 15, 0, 'Very well. Here, in presence of many of Azeroth\'s greatest mages, it is my honor to dub you $n, Conjuror of the Tirisgarde.', 12, 0, 100, 1, 0, 61746, 105829, 'Meryl·Felsong to Player'),
(102700, 16, 0, 'This ancient title symbolizes the awesome responsibility borne by the Tirisgarde. May you carry it with honor.', 12, 0, 100, 1, 0, 61747, 105830, 'Meryl·Felsong to Player'),
(102700, 17, 0, 'It is time to meet with our new goblin ally in the War Room. You can begin planning your next steps there.', 12, 0, 100, 0, 0, 61748, 105831, 'Meryl·Felsong to Player'),
(102700, 18, 0, 'I have some personal business to attend to...', 12, 0, 100, 0, 0, 61749, 105993, 'Meryl·Felsong to Player');


-- DB/Terrainswap: Skyfire Jade Forest
DELETE FROM `terrain_swap_defaults` WHERE `MapId`=870 AND `TerrainSwapMap`=971;
INSERT INTO `terrain_swap_defaults` (`MapId`, `TerrainSwapMap`, `Comment`) VALUES
(870, 971, 'The Jade Forest - Jade Forest Alliance Hub Phase');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=25 AND `SourceEntry`=971;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(25,0,971,0,0,6,0,469,0,0,0,0,0,'','Apply terrain swap 971 if player is Alliance'),
(25,0,971,0,0,47,0,31736,64,0,1,0,0,'','Apply terrain swap 971 if quest 31736 is not rewarded');

-- DB/Loot: remove some incorrect drops of three quest reward items
DELETE FROM `creature_loot_template` WHERE `Item` IN (10780, 10781, 10782);
DELETE FROM `item_loot_template` WHERE `Item` IN (10780, 10781, 10782);
INSERT INTO `item_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
(10773, 10780, 0, 100, 0, 1, 0, 1, 1), -- Mark of Hakkar
(10773, 10781, 0, 100, 0, 1, 1, 1, 1), -- Hakkari Breastplate
(10773, 10782, 0, 100, 0, 1, 2, 1, 1); -- Hakkari Shroud

-- DB/Spells: Sparkles for the quest Fear No Evil
-- 
DELETE FROM `spell_area` WHERE `spell` IN (84459) AND `area`=9;
INSERT INTO `spell_area` (`spell`,`area`,`quest_start`,`quest_end`,`aura_spell`,`racemask`,`gender`,`flags`,`quest_start_status`,`quest_end_status`) VALUES
(84459,9,28806,0,0,0,2,3,8,67),
(84459,9,28808,0,0,0,2,3,8,67),
(84459,9,28809,0,0,0,2,3,8,67),
(84459,9,28810,0,0,0,2,3,8,67),
(84459,9,28811,0,0,0,2,3,8,67),
(84459,9,28812,0,0,0,2,3,8,67),
(84459,9,28813,0,0,0,2,3,8,67),
(84459,9,29082,0,0,0,2,3,8,67);

-- DB/Player: Typo fix
UPDATE `playercreateinfo` SET `orientation`= 0.377780 WHERE `race` = 3 AND `map`=1;

-- DB/Quest: Battle Before The Citadel - Phasing
-- 
DELETE FROM `spell_area` WHERE `quest_start` IN (13861, 13862, 13863, 13864) AND `area`=4522;
INSERT INTO `spell_area` (`spell`, `area`, `quest_start`, `quest_end`, `aura_spell`, `racemask`, `gender`, `flags`, `quest_start_status`, `quest_end_status`) VALUES 
(64576, 4522, 13864, 13864, 0, 0, 2, 1, 74, 11),
(64576, 4522, 13861, 13861, 0, 0, 2, 1, 74, 11),
(64576, 4522, 13862, 13862, 0, 0, 2, 1, 74, 11),
(64576, 4522, 13863, 13863, 0, 0, 2, 1, 74, 11);

-- DB/Phase: Add phase name table.
DROP TABLE IF EXISTS `phase_name`;
CREATE TABLE `phase_name` (`ID` INT(10) UNSIGNED NOT NULL, `Name` TEXT NULL DEFAULT NULL COLLATE 'utf8_general_ci', PRIMARY KEY (`ID`) USING BTREE) COMMENT='Helper table to store names for phases' COLLATE='utf8_general_ci' ENGINE=MyISAM;

DELETE FROM `phase_name` WHERE `ID` IN (50, 51, 52, 53, 54, 101, 102, 103, 104, 105, 106, 122, 123, 124, 125, 126, 127, 141, 142, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 209, 223, 224, 225, 226, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238, 239, 240, 241, 242, 243, 244, 245, 246, 247, 251, 252, 253, 254, 255, 256, 257, 259, 260, 261, 262, 263, 264, 265, 266, 267, 268, 269, 270, 271, 272, 273, 274, 275, 276, 277, 278, 279, 280, 281, 282, 283, 284, 285, 287, 288, 289, 290, 293, 294, 295, 297, 298, 299, 300, 301, 302, 303, 304, 305, 306, 307, 308, 309, 310, 311, 312, 313, 314, 315, 316, 317, 318, 319, 320, 321, 322, 323, 324, 325, 326, 327, 328, 329, 330, 331, 332, 333, 334, 335, 336, 337, 338, 339, 340, 341, 342, 343, 344, 345, 346, 347, 348, 349, 350, 351, 352, 353, 354, 355, 356, 357, 358, 359, 360, 361, 362, 363, 364, 365, 366, 367, 368, 369, 370, 371, 372, 373, 374, 375, 376, 377, 378, 379, 380, 381, 382, 383, 384, 385, 386, 387, 388, 389, 390, 391, 392, 393, 394, 395, 396, 397, 399, 400, 401, 402, 404, 405, 406, 407, 408, 417, 418, 421, 424, 425, 426, 427, 428, 429, 430, 431, 432, 433, 434, 438, 440, 441, 442, 443, 444, 445, 448, 449, 450, 451, 452, 459, 460, 467, 470, 473, 486, 489, 503, 504, 509, 515, 516, 517, 518, 523, 524, 525, 526, 527, 528, 529, 535, 536, 540, 541, 542, 543, 544, 545, 546, 549, 550, 553, 555, 556, 559, 560, 561, 562, 563, 566, 567, 568, 569, 573, 575, 579, 580, 582, 583, 584, 585, 586, 587, 588, 589, 590, 591, 592, 593, 594, 595, 596, 597, 598, 599, 600, 601, 602, 606, 607, 608, 611, 614, 616, 617, 618, 619, 620, 621, 622, 623, 624, 625, 628, 629, 630, 631, 632, 635, 638, 639, 640, 642, 643, 644, 645, 646, 647, 648, 649, 650, 651, 652, 655, 656, 657, 658, 659, 660, 661, 662, 665, 666, 667, 668, 669, 670, 673, 674, 675, 676, 677, 678, 679, 680, 681, 682, 683, 684, 685, 686, 687, 688, 689, 690, 691, 692, 693, 694, 695, 698, 699, 700, 701, 703, 704, 705, 706, 707, 708, 709, 710, 711, 712, 713, 714, 715, 716, 717, 718, 719, 720, 721, 722, 723, 724, 725, 726, 727, 728, 729, 734, 735, 736, 737, 738, 739, 741, 742, 743, 744, 745, 746, 747, 748, 751, 752, 753, 754, 755, 756, 757, 758, 759, 760, 765, 766, 767, 768, 770, 771, 772, 773, 774, 775, 776, 777, 778, 779, 780, 783, 784, 785, 786, 787, 788, 789, 790, 791, 792, 795, 798, 801, 802, 803, 804, 805, 809, 810, 811, 812, 813, 814, 815, 816, 817, 818, 819, 820, 821, 822, 823, 824, 825, 826, 827, 828, 829, 830, 831, 832, 833, 834, 835, 836, 837, 838, 841, 842, 843, 844, 845, 846, 847, 848, 849, 850, 851, 852, 853, 854, 855, 856, 857, 858, 859, 860, 861, 862, 863, 864, 865, 866, 867, 868, 869, 870, 871, 872, 873, 874, 875, 876, 877, 878, 879, 884, 885, 886, 887, 888, 889, 890, 891, 892, 893, 894, 895, 896, 897, 898, 899, 900, 901, 902, 903, 904, 905, 906, 907, 908, 909, 910, 911, 912, 913, 914, 915, 916, 917, 918, 919, 920, 921, 922, 923, 924, 925, 926, 927, 928, 929, 930, 931, 932, 933, 934, 935, 936, 937, 938, 939, 940, 941, 942, 943, 944, 945, 946, 947, 948, 949, 950, 951, 952, 953, 954, 955, 956, 957, 958, 959, 960, 961, 962, 963, 964, 965, 966, 967, 968, 969, 970, 971, 972, 973, 974, 975, 976, 977, 978, 979, 980, 981, 984, 985, 986, 987, 988, 989, 990, 992, 993, 994, 995, 996, 997, 998, 999, 1000, 1001, 1004, 1005, 1006, 1007, 1008, 1009, 1010, 1011, 1012, 1013, 1014, 1015, 1016, 1017, 1018, 1019, 1020, 1021, 1022, 1023, 1024, 1025, 1026, 1027, 1028, 1029, 1030, 1031, 1032, 1033, 1034, 1035, 1036, 1037, 1038, 1039, 1040, 1041, 1042, 1045, 1046, 1047, 1048, 1049, 1051, 1053, 1054, 1055, 1056, 1057, 1058, 1059, 1060, 1061, 1062, 1063, 1064, 1065, 1066, 1067, 1068, 1069, 1070, 1071, 1072, 1073, 1074, 1075, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1088, 1089, 1090, 1091, 1092, 1093, 1094, 1095, 1098, 1099, 1100, 1101, 1102, 1103, 1104, 1105, 1106, 1107, 1108, 1109, 1110, 1111, 1112, 1113, 1115, 1116, 1117, 1118, 1119, 1120, 1121, 1122, 1123, 1124, 1125, 1126, 1127, 1128, 1129, 1130, 1131, 1132, 1133, 1134, 1135, 1136, 1137, 1138, 1139, 1140, 1143, 1144, 1145, 1146, 1147, 1148, 1149, 1150, 1151, 1152, 1154, 1155, 1156, 1157, 1158, 1159, 1160, 1161, 1162, 1163, 1164, 1165, 1166, 1167, 1168, 1169, 1170, 1171, 1173, 1174, 1175, 1176, 1177, 1178, 1179, 1180, 1181, 1182, 1183, 1184, 1185, 1186, 1187, 1188, 1189, 1190, 1191, 1192, 1193, 1194, 1195, 1196, 1197, 1198, 1199, 1200, 1202, 1203, 1204, 1205, 1207, 1208, 1209, 1210, 1211, 1212, 1213, 1214, 1215, 1216, 1217, 1218, 1219, 1220, 1221, 1222, 1223, 1224, 1225, 1226, 1227, 1228, 1229, 1230, 1231, 1232, 1233, 1234, 1246, 1247, 1248, 1249, 1250, 1251, 1252, 1253, 1254, 1255, 1256, 1257, 1258, 1259, 1260, 1261, 1262, 1263, 1264, 1265, 1266, 1267, 1268, 1269, 1270, 1271, 1272, 1273, 1274, 1275, 1276, 1277, 1278, 1279, 1280, 1281, 1282, 1283, 1284, 1285, 1286, 1287, 1288, 1289, 1290, 1291, 1292, 1293, 1294, 1295, 1296, 1297, 1298, 1299, 1300, 1301, 1302, 1303, 1304, 1305, 1306, 1307, 1308, 1309, 1310, 1311, 1312, 1313, 1314, 1315, 1316, 1317, 1318, 1319, 1320, 1321, 1322, 1323, 1324, 1325, 1326, 1327, 1328, 1329, 1330, 1331, 1332, 1333, 1334, 1335, 1336, 1337, 1338, 1339, 1340, 1341, 1342, 1343, 1344, 1345, 1346, 1347, 1348, 1349, 1350, 1351, 1352, 1353, 1354, 1355, 1356, 1357, 1358, 1359, 1360, 1361, 1362, 1363, 1364, 1365, 1366, 1367, 1368, 1369, 1370, 1371, 1372, 1373, 1374, 1375, 1376, 1377, 1378, 1379, 1380, 1381, 1382, 1383, 1384, 1385, 1386, 1387, 1388, 1389, 1390, 1391, 1392, 1393, 1394, 1395, 1396, 1397, 1398, 1399, 1400, 1401, 1402, 1403, 1404, 1405, 1406, 1407, 1408, 1409, 1410, 1411, 1412, 1413, 1414, 1415, 1416, 1417, 1418, 1419, 1420, 1421, 1422, 1425, 1426, 1427, 1428, 1429, 1430, 1431, 1432, 1433, 1434, 1435, 1436, 1437, 1438, 1439, 1440, 1441, 1442, 1443, 1444, 1445, 1456, 1457, 1460, 1461, 1462, 1463, 1464, 1465, 1466, 1467, 1468, 1469, 1470, 1471, 1472, 1473, 1474, 1475, 1476, 1477, 1478, 1479, 1480, 1481, 1482, 1483, 1484, 1485, 1486, 1487, 1488, 1489, 1490, 1491, 1492, 1493, 1494, 1495, 1496, 1497, 1498, 1499, 1500, 1501, 1502, 1503, 1504, 1505, 1506, 1507, 1508, 1509, 1510, 1511, 1512, 1513, 1514, 1515, 1516, 1517, 1518, 1519, 1520, 1521, 1522, 1523, 1526, 1527, 1528, 1529, 1530, 1531, 1532, 1533, 1534, 1535, 1536, 1537, 1538, 1539, 1540, 1541, 1542, 1543, 1544, 1545, 1546, 1547, 1548, 1549, 1550, 1551, 1552, 1553, 1554, 1555, 1556, 1557, 1558, 1559, 1560, 1561, 1562, 1563, 1564, 1565, 1566, 1567, 1568, 1569, 1570, 1571, 1572, 1573, 1574, 1575, 1576, 1577, 1578, 1579, 1580, 1581, 1582, 1583, 1584, 1585, 1586, 1587, 1588, 1589, 1590, 1591, 1592, 1593, 1594, 1595, 1596, 1597, 1598, 1599, 1600, 1601, 1602, 1603, 1604, 1605, 1606, 1607, 1608, 1611, 1612, 1613, 1614, 1615, 1616, 1617, 1618, 1619, 1620, 1621, 1622, 1623, 1624, 1632, 1633, 1634, 1635, 1636, 1637, 1638, 1639, 1641, 1645, 1646, 1647, 1648, 1649, 1650, 1651, 1652, 1653, 1654, 1655, 1656, 1657, 1658, 1659, 1660, 1661, 1662, 1663, 1664, 1666, 1668, 1669, 1670, 1671, 1672, 1673, 1674, 1675, 1676, 1677, 1678, 1679, 1680, 1683, 1684, 1685, 1686, 1687, 1688, 1689, 1690, 1691, 1692, 1693, 1695, 1697, 1698, 1699, 1700, 1701, 1702, 1703, 1704, 1705, 1706, 1708, 1709, 1710, 1711, 1712, 1713, 1714, 1715, 1716, 1717, 1718, 1719, 1720, 1721, 1722, 1723, 1724, 1725, 1726, 1727, 1728, 1729, 1730, 1731, 1732, 1733, 1734, 1735, 1736, 1737, 1738, 1739, 1740, 1741, 1742, 1743, 1744, 1745, 1746, 1747, 1748, 1749, 1750, 1751, 1752, 1753, 1754, 1755, 1756, 1757, 1758, 1759, 1761, 1762, 1763, 1764, 1765, 1766, 1767, 1768, 1769, 1770, 1771, 1772, 1773, 1774, 1775, 1776, 1777, 1778, 1779, 1780, 1781, 1782, 1783, 1785, 1786, 1787, 1788, 1789, 1790, 1791, 1792, 1793, 1794, 1795, 1796, 1797, 1798, 1799, 1800, 1801, 1802, 1803, 1804, 1805, 1806, 1807, 1808, 1809, 1810, 1811, 1812, 1813, 1814, 1815, 1816, 1817, 1818, 1819, 1820, 1821, 1822, 1823, 1824, 1825, 1826, 1827, 1828, 1829, 1830, 1831, 1832, 1833, 1834, 1835, 1836, 1837, 1838, 1839, 1840, 1841, 1842, 1843, 1844, 1845, 1846, 1847, 1848, 1849, 1850, 1851, 1852, 1853, 1854, 1855, 1856, 1857, 1858, 1859, 1860, 1861, 1862, 1863, 1864, 1865, 1866, 1867, 1868, 1869, 1870, 1871, 1872, 1873, 1874, 1875, 1876, 1877, 1878, 1879, 1880, 1881, 1882, 1883, 1884, 1885, 1886, 1887, 1888, 1889, 1890, 1891, 1892, 1893, 1894, 1895, 1896, 1897, 1898, 1899, 1900, 1901, 1902, 1903, 1904, 1905, 1906, 1907, 1908, 1909, 1910, 1911, 1912, 1913, 1914, 1915, 1916, 1918, 1919, 1921, 1926, 1927, 1928, 1929, 1930, 1931, 1932, 1933, 1934, 1935, 1936, 1937, 1938, 1942, 1943, 1944, 1945, 1946, 1947, 1950, 1952, 1955, 1956, 1957, 1958, 1959, 1960, 1961, 1962, 1963, 1964, 1965, 1966, 1967, 1968, 1969, 1970, 1971, 1972, 1973, 1974, 1975, 1976, 1977, 1978, 1979, 1980, 1981, 1982, 1983, 1984, 1986, 1988, 1989, 1992, 1993, 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013, 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025, 2026, 2028, 2029, 2030, 2031, 2032, 2033, 2034, 2035, 2036, 2037, 2038, 2039, 2040, 2041, 2042, 2043, 2044, 2045, 2046, 2047, 2048, 2049, 2050, 2051, 2052, 2053, 2054, 2055, 2056, 2057, 2058, 2059, 2060, 2061, 2063, 2064, 2065, 2066, 2067, 2068, 2069, 2070, 2071, 2072, 2073, 2074, 2075, 2076, 2077, 2081, 2082, 2083, 2084, 2085, 2086, 2087, 2090, 2091, 2092, 2093, 2094, 2095, 2097, 2098, 2099, 2100, 2101, 2102, 2104, 2105, 2108, 2109, 2110, 2111, 2112, 2113, 2114, 2115, 2116, 2117, 2118, 2119, 2120, 2121, 2122, 2123, 2124, 2125, 2126, 2127, 2128, 2129, 2132, 2133, 2134, 2136, 2137, 2138, 2139, 2140, 2141, 2142, 2143, 2144, 2145, 2146, 2147, 2148, 2149, 2150, 2151, 2152, 2153, 2154, 2155, 2156, 2157, 2158, 2159, 2160, 2161, 2162, 2163, 2165, 2166, 2167, 2168, 2169, 2170, 2171, 2172, 2173, 2174, 2175, 2176, 2177, 2178, 2179, 2180, 2181, 2182, 2183, 2184, 2185, 2186, 2187, 2188, 2189, 2190, 2191, 2192, 2193, 2194, 2195, 2196, 2197, 2198, 2199, 2200, 2201, 2202, 2205, 2206, 2207, 2208, 2209, 2210, 2211, 2212, 2213, 2214, 2215, 2216, 2217, 2218, 2219, 2220, 2221, 2222, 2223, 2224, 2225, 2226, 2227, 2228, 2229, 2230, 2231, 2232, 2233, 2234, 2235, 2236, 2237, 2238, 2239, 2240, 2241, 2242, 2243, 2244, 2245, 2246, 2247, 2248, 2249, 2250, 2251, 2252, 2253, 2254, 2255, 2256, 2257, 2259, 2262, 2263, 2264, 2265, 2266, 2267, 2268, 2269, 2270, 2271, 2272, 2273, 2274, 2275, 2279, 2280, 2281, 2282, 2283, 2284, 2285, 2286, 2287, 2288, 2289, 2290, 2291, 2292, 2293, 2294, 2295, 2296, 2297, 2298, 2299, 2300, 2306, 2307, 2308, 2309, 2310, 2311, 2312, 2317, 2319, 2321, 2322, 2323, 2324, 2325, 2326, 2327, 2328, 2329, 2330, 2331, 2332, 2333, 2334, 2335, 2336, 2337, 2338, 2339, 2340, 2341, 2342, 2343, 2344, 2345, 2346, 2347, 2348, 2349, 2350, 2351, 2352, 2353, 2354, 2355, 2356, 2357, 2358, 2359, 2360, 2361, 2362, 2363, 2364, 2365, 2366, 2367, 2368, 2369, 2370, 2371, 2374, 2375, 2376, 2377, 2378, 2379, 2380, 2381, 2382, 2383, 2384, 2385, 2386, 2387, 2388, 2391, 2392, 2394, 2395, 2396, 2397, 2398, 2399, 2401, 2402, 2403, 2404, 2405, 2406, 2407, 2409, 2410, 2411, 2412, 2413, 2414, 2415, 2416, 2418, 2419, 2420, 2421, 2422, 2423, 2424, 2425, 2426, 2427, 2428, 2429, 2430, 2431, 2432, 2433, 2436, 2437, 2438, 2439, 2440, 2441, 2442, 2443, 2444, 2445, 2446, 2447, 2448, 2449, 2450, 2451, 2452, 2458, 2459, 2460, 2461, 2462, 2463, 2464, 2465, 2466, 2467, 2468, 2469, 2470, 2471, 2472, 2473, 2474, 2475, 2476, 2481, 2482, 2483, 2484, 2486, 2487, 2488, 2489, 2490, 2491, 2492, 2493, 2494, 2495, 2496, 2497, 2498, 2499, 2501, 2503, 2506, 2509, 2510, 2511, 2512, 2513, 2514, 2515, 2516, 2517, 2518, 2519, 2520, 2521, 2522, 2523, 2524, 2525, 2526, 2527, 2528, 2529, 2531, 2532, 2533, 2534, 2535, 2537, 2538, 2539, 2540, 2541, 2542, 2543, 2544, 2545, 2546, 2547, 2548, 2549, 2550, 2551, 2552, 2553, 2554, 2555, 2559, 2560, 2561, 2562, 2563, 2566, 2567, 2568, 2569, 2570, 2571, 2572, 2574, 2575, 2576, 2578, 2579, 2581, 2582, 2583, 2584, 2585, 2586, 2587, 2588, 2589, 2590, 2593, 2594, 2597, 2598, 2600, 2601, 2602, 2603, 2604, 2605, 2606, 2607, 2609, 2610, 2611, 2612, 2613, 2614, 2615, 2616, 2618, 2619, 2620, 2621, 2622, 2623, 2624, 2625, 2629, 2630, 2631, 2632, 2633, 2634, 2635, 2636, 2637, 2638, 2639, 2640, 2641, 2642, 2643, 2644, 2645, 2646, 2647, 2648, 2649, 2650, 2651, 2652, 2653, 2654, 2655, 2656, 2657, 2658, 2659, 2660, 2661, 2662, 2663, 2664, 2665, 2666, 2668, 2669, 2670, 2671, 2672, 2673, 2674, 2675, 2676, 2677, 2678, 2679, 2680, 2681, 2684, 2685, 2686, 2687, 2688, 2689, 2690, 2691, 2692, 2693, 2694, 2695, 2696, 2697, 2698, 2699, 2700, 2701, 2702, 2703, 2704, 2705, 2706, 2707, 2708, 2709, 2710, 2711, 2712, 2713, 2714, 2715, 2716, 2717, 2718, 2719, 2720, 2721, 2722, 2723, 2724, 2725, 2726, 2727, 2728, 2729, 2730, 2731, 2732, 2733, 2734, 2735, 2736, 2737, 2738, 2740, 2741, 2742, 2743, 2744, 2745, 2746, 2747, 2748, 2749, 2750, 2753, 2754, 2755, 2756, 2757, 2758, 2759, 2760, 2761, 2762, 2763, 2764, 2765, 2766, 2767, 2768, 2769, 2772, 2773, 2774, 2775, 2776, 2777, 2779, 2782, 2787, 2788, 2789, 2790, 2791, 2792, 2793, 2794, 2795, 2796, 2797, 2798, 2799, 2800, 2801, 2802, 2803, 2804, 2805, 2806, 2807, 2808, 2809, 2810, 2811, 2812, 2813, 2814, 2815, 2816, 2817, 2818, 2819, 2820, 2821, 2822, 2823, 2824, 2825, 2826, 2827, 2828, 2829, 2830, 2831, 2833, 2835, 2836, 2837, 2838, 2839, 2840, 2841, 2842, 2843, 2844, 2845, 2846, 2847, 2848, 2849, 2850, 2851, 2854, 2855, 2856, 2857, 2858, 2859, 2861, 2862, 2863, 2864, 2865, 2866, 2867, 2868, 2869, 2870, 2871, 2872, 2873, 2874, 2875, 2876, 2877, 2878, 2879, 2880, 2881, 2882, 2883, 2884, 2885, 2886, 2887, 2889, 2891, 2892, 2894, 2895, 2896, 2897, 2898, 2899, 2900, 2901, 2902, 2903, 2904, 2905, 2907, 2908, 2909, 2910, 2911, 2912, 2913, 2914, 2915, 2916, 2917, 2918, 2919, 2920, 2921, 2922, 2923, 2924, 2925, 2927, 2928, 2929, 2930, 2931, 2932, 2933, 2934, 2935, 2938, 2939, 2940, 2941, 2942, 2943, 2944, 2945, 2946, 2947, 2948, 2949, 2950, 2951, 2952, 2953, 2954, 2955, 2956, 2957, 2958, 2959, 2960, 2961, 2962, 2963, 2964, 2965, 2966, 2967, 2968, 2969, 2970, 2971, 2972, 2973, 2974, 2975, 2976, 2977, 2978, 2979, 2980, 2981, 2982, 2983, 2984, 2985, 2986, 2987, 2988, 2989, 2990, 2991, 2992, 2993, 2994, 2995, 2996, 2997, 2999, 3000, 3001, 3002, 3003, 3004, 3005, 3006, 3007, 3008, 3009, 3010, 3011, 3012, 3013, 3014, 3015, 3016, 3017, 3018, 3019, 3020, 3021, 3022, 3023, 3024, 3025, 3026, 3027, 3028, 3029, 3030, 3031, 3032, 3033, 3034, 3035, 3036, 3037, 3038, 3039, 3040, 3041, 3042, 3043, 3044, 3045, 3046, 3047, 3048, 3049, 3050, 3051, 3052, 3053, 3054, 3055, 3056, 3057, 3058, 3059, 3060, 3061, 3062, 3063, 3064, 3065, 3066, 3067, 3068, 3069, 3070, 3071, 3072, 3073, 3074, 3075, 3076, 3077, 3078, 3079, 3080, 3081, 3082, 3083, 3084, 3085, 3086, 3087, 3088, 3089, 3090, 3091, 3092, 3093, 3094, 3095, 3096, 3097, 3098, 3099, 3100, 3101, 3102, 3103, 3107, 3108, 3109, 3110, 3111, 3112, 3113, 3114, 3115, 3116, 3117, 3118, 3119, 3120, 3121, 3122, 3123, 3124, 3125, 3127, 3128, 3129, 3130, 3132, 3133, 3134, 3135, 3136, 3137, 3138, 3139, 3140, 3141, 3142, 3143, 3145, 3146, 3147, 3148, 3149, 3150, 3151, 3152, 3153, 3154, 3155, 3156, 3157, 3158, 3159, 3160, 3161, 3162, 3163, 3164, 3165, 3166, 3167, 3168, 3169, 3170, 3171, 3173, 3174, 3175, 3176, 3177, 3178, 3179, 3180, 3181, 3182, 3183, 3184, 3185, 3186, 3187, 3188, 3189, 3190, 3191, 3194, 3195, 3196, 3197, 3198, 3199, 3200, 3201, 3202, 3203, 3204, 3205, 3206, 3207, 3208, 3209, 3210, 3211, 3212, 3213, 3214, 3215, 3216, 3217, 3218, 3219, 3220, 3221, 3222, 3223, 3224, 3225, 3226, 3227, 3228, 3229, 3230, 3231, 3232, 3233, 3234, 3235, 3236, 3237, 3238, 3239, 3240, 3241, 3242, 3243, 3244, 3245, 3246, 3247, 3248, 3249, 3250, 3251, 3252, 3253, 3254, 3255, 3257, 3258, 3259, 3260, 3261, 3262, 3263, 3264, 3265, 3266, 3267, 3268, 3269, 3270, 3271, 3272, 3273, 3274, 3275, 3276, 3277, 3278, 3279, 3280, 3281, 3282, 3283, 3284, 3285, 3286, 3287, 3288, 3289, 3290, 3291, 3292, 3293, 3294, 3295, 3296, 3297, 3298, 3299, 3300, 3301, 3302, 3303, 3304, 3305, 3306, 3307, 3308, 3309, 3310, 3311, 3312, 3313, 3314, 3315, 3316, 3317, 3318, 3319, 3320, 3321, 3322, 3323, 3324, 3325, 3326, 3327, 3328, 3329, 3330, 3331, 3332, 3333, 3334, 3335, 3336, 3337, 3338, 3339, 3340, 3341, 3342, 3343, 3344, 3345, 3347, 3348, 3349, 3350, 3351, 3352, 3353, 3354, 3355, 3356, 3357, 3358, 3359, 3360, 3361, 3362, 3363, 3364, 3365, 3366, 3367, 3368, 3370, 3371, 3372, 3373, 3374, 3375, 3376, 3377, 3378, 3379, 3380, 3381, 3382, 3383, 3386, 3387, 3388, 3389, 3390, 3391, 3392, 3393, 3394, 3395, 3396, 3397, 3398, 3399, 3400, 3401, 3402, 3403, 3404, 3405, 3406, 3407, 3408, 3409, 3410, 3411, 3412, 3413, 3414, 3415, 3416, 3417, 3418, 3419, 3420, 3421, 3422, 3423, 3424, 3425, 3426, 3427, 3428, 3429, 3430, 3431, 3432, 3433, 3434, 3435, 3436, 3437, 3438, 3439, 3440, 3441, 3442, 3443, 3444, 3445, 3446, 3447, 3448, 3449, 3450, 3451, 3452, 3453, 3454, 3455, 3456, 3457, 3458, 3459, 3460, 3461, 3462, 3463, 3464, 3465, 3466, 3467, 3468, 3469, 3470, 3471, 3472, 3473, 3474, 3475, 3476, 3477, 3478, 3479, 3480, 3481, 3482, 3483, 3484, 3485, 3486, 3487, 3488, 3489, 3490, 3491, 3492, 3493, 3494, 3495, 3496, 3497, 3498, 3499, 3500, 3501, 3502, 3503, 3504, 3505, 3506, 3507, 3508, 3509, 3510, 3511, 3512, 3513, 3514, 3515, 3516, 3517, 3518, 3519, 3520, 3521, 3522, 3523, 3524, 3525, 3526, 3527, 3528, 3529, 3530, 3531, 3532, 3533, 3534, 3535, 3536, 3537, 3538, 3539, 3540, 3541, 3542, 3543, 3544, 3545, 3546, 3547, 3548, 3549, 3550, 3551, 3552, 3553, 3554, 3555, 3556, 3557, 3558, 3559, 3560, 3561, 3562, 3563, 3564, 3565, 3566, 3567, 3568, 3569, 3570, 3571, 3572, 3573, 3574, 3575, 3576, 3577, 3578, 3579, 3580, 3581, 3582, 3583, 3584, 3585, 3586, 3587, 3588, 3589, 3590, 3591, 3592, 3593, 3594, 3595, 3596, 3597, 3598, 3599, 3600, 3601, 4881, 4883, 4884, 4899, 4925, 4927, 4931, 4932, 5056, 5077, 5086, 5094, 5095, 5113, 5114, 5115, 5116, 5117, 5120, 5160, 5305, 5310, 5311, 5343, 5344, 5357, 5381, 5461, 5462, 5463, 5464, 5533, 5534, 5595, 5658, 6303);
INSERT INTO `phase_name` (`ID`, `Name`) VALUES
(50, 'Gilneas Lev 6'),
(51, 'Gilneas Lev 7'),
(52, 'Gilneas Lev 8'),
(53, 'Gilneas Lev 9'),
(54, 'Gilneas Lev 10'),
(101, 'Gilneas City Unphased Terrain Swap'),
(102, 'Gilneas City Phase 1 Terrain Swap'),
(103, 'Gilneas City Phase 2 Terrain Swap'),
(104, 'Gilneas City Phase 3 Terrain Swap'),
(105, 'Gilneas City Phase 4 Terrain Swap'),
(106, 'Gilneas City Phase 5 Terrain Swap'),
(122, 'Gilneas Phase 11 Terrain Swap'),
(123, 'Blank Phase'),
(124, 'Blank Phase'),
(125, 'Test Phase'),
(126, 'Test Phase'),
(127, 'Blank Phase'),
(141, 'The Lost Isles Phase 5 Terrain Swap'),
(142, 'The Lost Isles Phase 6 Terrain Swap'),
(161, 'The Lost Isles Phase 7 Terrain Swap'),
(162, 'The Lost Isles Phase 8 Terrain Swap'),
(163, 'The Lost Isles Phase 9 Terrain Swap'),
(164, 'The Lost Isles Phase 10 Terrain Swap'),
(165, 'Hyjal A'),
(166, 'Hyjal B'),
(167, 'Hyjal C'),
(168, 'Hyjal D'),
(169, 'Normal'),
(170, 'Quest Zone-Specific 01'),
(171, 'Quest Zone-Specific 02'),
(172, 'Quest Zone-Specific 03'),
(173, 'Dungeon Encounter 1'),
(174, 'Dungeon Encounter 2'),
(175, 'Custom Event 1'),
(176, 'Custom Event 2'),
(177, 'Custom Event 3'),
(178, 'Barber Shop'),
(179, 'Quest Zone-Specific 04'),
(180, 'Quest Zone-Specific 05'),
(181, 'Quest Zone-Specific 06'),
(182, 'Quest Zone-Specific 07'),
(183, 'Quest Zone-Specific 08'),
(184, 'Quest Zone-Specific 09'),
(185, 'Quest Zone-Specific 10'),
(186, 'Quest Zone-Specific 11'),
(187, 'Quest Zone-Specific 12'),
(188, 'Quest Zone-Specific 13'),
(189, 'Quest Zone-Specific 14'),
(190, 'Quest Zone-Specific 15'),
(191, 'Quest Zone-Specific 16'),
(192, 'Quest Zone-Specific 17'),
(193, 'Quest Zone-Specific 18'),
(194, 'Quest Zone-Specific 19'),
(195, 'Quest Zone-Specific 20'),
(196, 'Quest Zone-Specific 21'),
(197, 'Quest Zone-Specific 22'),
(198, 'Quest Zone-Specific 23'),
(199, 'Quest Zone-Specific 24'),
(200, 'Quest Zone-Specific 25'),
(201, 'Stonetalon Bomb'),
(209, 'test!!!'),
(223, 'Stonetalon Bomb 2'),
(224, 'Stonetalon 4.x - Cliffwalker Finale (Final)'),
(225, 'PattyMack<test>'),
(226, 'Westfall Act II'),
(228, 'Cavern Submarine'),
(229, 'Dragonmaw Story Chapter I'),
(230, 'CC Pro - EA - TB'),
(231, 'Vision of the Past'),
(232, 'Rise of the Brotherhood'),
(233, 'CC Pro - EA - IF'),
(234, 'Zul\'Gurub Mind Vision'),
(235, 'Zul\'Gurub Mind Control'),
(236, 'Twilight Highlands Horde Zeppelin Event'),
(237, 'Therazane Siege'),
(238, 'Dragonmaw Story Chapter II'),
(239, 'Attack on Booty Bay'),
(240, 'Render\'s Valley Camera'),
(241, 'Render\'s Valley Post Explosion'),
(242, 'Bravo Company Siege Tank'),
(243, 'Showdown'),
(244, 'Showdown'),
(245, 'Stitches Attacks'),
(246, 'Triumphant Return'),
(247, 'Dragonmaw Story Chapter III'),
(251, 'Rescue the Stonefather... and Flint'),
(252, 'The Stone March'),
(253, '"Temple of Earth Finale, Stage 1"'),
(254, '"Temple of Earth Finale, Stage 2"'),
(255, '"Temple of Earth Finale, Stage 3"'),
(256, '"Temple of Earth Finale, Stage 4"'),
(257, 'Temple of Earth Finale Complete '),
(259, 'Andorhal 01 - Horde/Alliance vs. Scourge'),
(260, 'Andorhal 02 - Horde/Alliance Prep'),
(261, 'Andorhal 03 - Horde vs. Alliance'),
(262, 'Felstone Field - Alliance-Held'),
(263, 'Felstone Field - Val\'kyr Practice'),
(264, 'Forsaken High Command Introduction'),
(265, 'Lord Darius Crowley & Packleader Bloodfang'),
(266, 'Sophia\'s Choice'),
(267, 'For Lordaeron!'),
(268, 'Andorhal 04H - Val\'kyr Attack (H)'),
(269, 'Andorhal 05 - Andorhal Event'),
(270, 'Crypt Ambush'),
(271, 'Writhing Haunt Training'),
(272, 'Andorhal 04A - Val\'kyr Attack (A)'),
(273, 'The Waters Run Red...'),
(274, 'Gilneas Act I'),
(275, 'Gilneas Act II'),
(276, 'Gilneas Act III'),
(277, 'The Forsaken Front'),
(278, 'The Forsaken Front'),
(279, 'Amber Mill'),
(280, 'Amber Mill'),
(281, 'Amber Mill'),
(282, '[UNUSED] Redridge 4.x - Bridge'),
(283, 'The Twilight Gate - Pre-Invasion'),
(284, 'The Forsaken Front'),
(285, 'The Twilight Gate - Invasion'),
(287, 'Battle for Tyr\'s Hand 1'),
(288, 'Battle for Tyr\'s Hand 2'),
(289, 'The Forsaken Front'),
(290, 'Twilight Zone'),
(293, 'The Day that Deathwing Came 1'),
(294, 'Quel\'Danil Battle'),
(295, 'The Day that Deathwing Came 2'),
(297, 'Uldum - Phased Oasis'),
(298, 'Entrance to Uldum'),
(299, 'Dunwald Market Row Ambush'),
(300, 'Dunwald Town Square Fight'),
(301, 'Nyxondra Vision'),
(302, 'The Bloodmire - Phase II'),
(303, 'Uldum - Caravan Event'),
(304, 'The Bloodmire - Phase III - Stonard'),
(305, 'Skullcrusher the Mountain Fight - Alliance'),
(306, 'Skullcrusher the Mountain Fight - Horde'),
(307, 'Rheastrasza\'s Gift'),
(308, 'Tailgunner!'),
(309, '"""Put It On"" Quest Phase"'),
(310, 'The Day that Deathwing Came 3'),
(311, 'Firebeard\'s Attack'),
(312, 'Gobbles Completion Event'),
(313, 'Schnottz\'s Landing - Chapter 1'),
(314, 'Class Phase 1'),
(315, 'Schnottz\'s Landing - Chapter 2'),
(316, 'Jadefire Nether Pocket'),
(317, 'Welcome to the Machine'),
(318, '"Twilight Caravan Ambush, Horde"'),
(319, '"Grim Batol Attack, Horde"'),
(320, '"Twilight Caravan Ambush, Alliance"'),
(321, '"Grim Batol Attack, Alliance"'),
(322, 'Thundermar Attack - Horde'),
(323, 'Twilight Highlands - Gullet - Torth Attack'),
(324, 'Schnottz\'s Landing - Chapter 3'),
(325, 'Schnottz\'s Landing - Chapter 4'),
(326, 'The Sludge Fields'),
(327, 'Isorath Nightmare'),
(328, 'Isorath Awakened'),
(329, 'Sindweller Vision'),
(330, 'Tyrande Event'),
(331, 'Maelstrom Nightmare'),
(332, 'A Blight Upon the Land'),
(333, 'The Sludge Fields Reclaimed'),
(334, 'Eye of Twilight Vision'),
(335, 'Thundermar Attack - Alliance'),
(336, '"The Lost Isles -  ""Town-In-A- Box"" Phased Terrain Preload it"'),
(337, 'Obelisk of the Moon - Chapter 1'),
(338, 'Obelisk of the Moon - Final'),
(339, 'Oil Leak!'),
(340, 'Fires'),
(341, 'Assault on Dreadmaul Rock - Cinematic'),
(342, 'Assault on Dreadmaul Rock 1'),
(343, 'Stormpike Rendezvous'),
(344, 'Battle for the Undercity'),
(345, 'Battle for the Undercity'),
(346, 'Assault on Dreadmaul Rock 2'),
(347, 'Obelisk of the Moon - Chapter 2'),
(348, 'Road to Purgation'),
(349, 'Glopgut\'s Hollow - Dwarf Attack'),
(350, 'March of the Stormpike'),
(351, 'Uldum - Chamber of the Moon - Initial'),
(352, 'Uldum - Chamber of the Moon - Pre-Fight'),
(353, 'Uldum - Chamber of the Moon - Fight'),
(354, 'Uldum - Chamber of the Moon - Final'),
(355, 'March of the Stormpike'),
(356, 'Uldum - Artillery Event'),
(357, 'Aid of the Frostwolf'),
(358, 'Thousand Needles Raceway - Race 1'),
(359, 'Kirthaven Wedding Scene'),
(360, 'Kirthaven Wedding Fight'),
(361, 'Krazzworks Highbank Attack'),
(362, 'Fire From the Sky Completion'),
(363, 'The Headland'),
(364, 'Stormpike Apocalypse'),
(365, 'Plants Vs. Ghouls Game Phase'),
(366, 'Cradle of the Ancients - Harrison - Prephase'),
(367, 'Uldum - Phased Oasis - Spawns'),
(368, 'Kirthaven Wedding Celebration'),
(369, 'Rotbrain Battle'),
(370, 'Caravan Event Phase'),
(371, 'Deathwing vs. Alexstrasza'),
(372, 'Twilight Highlands - Stormwind Prelude - Barracks'),
(373, 'Twilight Highlands - Stormwind Prelude - Catacombs'),
(374, 'Dormus The Camel-Hoarder'),
(375, '"The Lost Isles -  ""Volcano Eruption"" Phased Terrain Preload it"'),
(376, 'Sullah\'s Caravan'),
(377, 'Uldum - Firing Squad'),
(378, 'Kezan - Chapter 1'),
(379, 'Kezan - Chapter 2'),
(380, 'Kezan - Chapter 3'),
(381, 'Kezan - Chapter 4'),
(382, 'Kezan - Chapter 5'),
(383, 'Kezan - Chapter 6'),
(384, 'Kezan - Chapter 7'),
(385, 'Security Alert Cinematic'),
(386, 'Obelisk Explosion Cinematic'),
(387, 'Schnottz So Fast Cutscene'),
(388, 'Uldum - Chamber of the Moon - Beam Cutscene'),
(389, 'Deathwing vs. Alexstrasza Cutscene'),
(390, 'Uldum - Temple of Uldum'),
(391, 'Pre-sundering - Uldum'),
(392, 'Presundering - Twilight Highlands'),
(393, 'Plants Vs. Ghouls Game Phase - Endless'),
(394, 'Three if by Air'),
(395, 'Spirit Realm'),
(396, 'Coffer of Promise'),
(397, 'Deathwing vs. Alexstrasza'),
(399, 'To Windshear Hold!'),
(400, 'UNUSED'),
(401, 'Blizzcon Paragon Raid'),
(402, 'Blackwing Descent - Magmaw'),
(404, 'Suppressing the Firelord - Alliance'),
(405, 'Suppressing the Firelord - Horde'),
(406, 'Twilight Highlands - Drake Ride Cutscene'),
(407, 'Vashj\'ir - Personal Phase - Briny Cutter Battle'),
(408, 'Vashj\'ir - Personal Phase Aura - Immortal Coil'),
(417, 'Elemental Phase'),
(418, 'Twilight Invasion'),
(421, 'Firebeak Bombing Phase'),
(424, 'Stranglethorn - 4.1 - ZG Event'),
(425, 'Hyjal Regrowth Invasion'),
(426, 'Hyjal Regrowth Pre-Invasion A'),
(427, 'Anachronos Vision'),
(428, 'Forlorn Spire Assault'),
(429, 'Elemental Bonds - Worldtree Intro Cinematic'),
(430, 'Tarecgosa Intro'),
(431, 'Hyjal Regrowth Pre-Invasion C'),
(432, 'Hyjal Regrowth Pre-Invasion D'),
(433, 'Hyjal Regrowth Pre-Invasion B'),
(434, 'Eye of Eternity Cutscene 01'),
(438, 'Emergency Extraction Cutscene'),
(440, 'Foothold Fight'),
(441, 'Coldarra - At One Scene'),
(442, '"Firelands Tree, Not Grown"'),
(443, '"Firelands Tree, Half Grown"'),
(444, '"Firelands Tree, Full Grown"'),
(445, 'Furnace Assault'),
(448, 'Alignment Cutscene'),
(449, 'Post Alignment Alignment Cutscene'),
(450, 'Foothold Completion'),
(451, 'Leyara Confrontation'),
(452, 'The Nexus - Legendary'),
(459, 'Nexus Legendary QUEST CRITERIA COMPLETE'),
(460, 'Silverpine 4.x - Arugal Resurrection Event'),
(467, 'Elemental Bonds - Firelands Quests'),
(470, 'Leyara Confrontation Completion'),
(473, 'Elemental Bonds - Alysra Kill Event'),
(486, 'Training Master Completion'),
(489, 'Wayward Landing - Arrival Phase [DISCONTINUED]'),
(503, 'Art of War Cutscene'),
(504, 'Spirit Master Fight'),
(509, 'Over the Deep Blue Cutscene'),
(515, 'The Debriefing: Rell\'s Report'),
(516, 'The Debriefing: Sully\'s Report'),
(517, 'The Debriefing: Yu\'s Report'),
(518, 'The Debriefing: Amber\'s Report'),
(523, 'A King\'s Request Cutscene'),
(524, 'Dragon Fight'),
(525, 'Scouting Report: Hostile Natives'),
(526, 'Scouting Report: A Rain of Lead'),
(527, 'Scouting Report: We\'re Not Alone'),
(528, 'Scouting Report: Like Jinyu in a Barrel'),
(529, 'Acid Rain'),
(535, 'Ravenholdt Infiltration Phase'),
(536, 'Dragon Fight Completion'),
(540, 'To Bridge Earth and Sky'),
(541, 'Wisdom of the Ages'),
(542, 'One Hand Clapping'),
(543, 'Crashed Ship Boss Fight'),
(544, 'Crashed Ship Healing'),
(545, 'Crashed Ship Healed'),
(546, 'Wisdom of the Ages'),
(549, 'Cosmetic - PattyMack Cosmetic 2'),
(550, 'Instant Messaging Event'),
(553, 'Ling Completion Phase'),
(555, 'Skat Shoot'),
(556, 'Cosmetic - Sha of Doubt'),
(559, 'Legacy'),
(560, 'Broken Dreams'),
(561, 'Pei-Back'),
(562, 'Grimleer Showdown'),
(563, 'Unyielding Fist'),
(566, 'Cosmetic - Sha of Doubt'),
(567, 'Cosmetic - Sha of Doubt'),
(568, 'Cosmetic - Sha of Doubt'),
(569, 'Cosmetic - Sha of Doubt'),
(573, 'Temple of the Jade Serpent'),
(575, 'Fort Grookin War Prep'),
(579, 'Stoneplow Finale'),
(580, 'Cosmetic - Blacksoil at Home'),
(582, 'Cosmetic - Greentill at Home'),
(583, 'Cosmetic - Zhang Marlfur'),
(584, 'Cosmetic - Spadepaw'),
(585, 'Cosmetic - Lin in Stoneplow'),
(586, '"Cosmetic - Bamboo Stack, Unbroken"'),
(587, '"Cosmetic - Bamboo Stack, Broken"'),
(588, '"Cosmetic - Wood Stack, Unbroken"'),
(589, '"Cosmetic - Wood Stack, Broken"'),
(590, '"Cosmetic - Stone Stack, Unbroken"'),
(591, '"Cosmetic - Stone Stack, Broken"'),
(592, 'Cosmetic - Warrior Weapon Racks'),
(593, 'Cosmetic - Mage Weapon Racks'),
(594, 'Cosmetic - Hunter Weapon Racks'),
(595, 'Cosmetic - Priest Weapon Racks'),
(596, 'Cosmetic - Rogue Weapon Racks'),
(597, 'Cosmetic - Shaman Weapon Racks'),
(598, 'Cosmetic - Monk Weapon Racks'),
(599, 'Cosmetic - Azure Serpent'),
(600, 'Cosmetic - Crimson Serpent'),
(601, 'Cosmetic - Emerald Serpent'),
(602, 'Cosmetic - Gold Serpent'),
(606, 'Temple of the Jade Serpent - Cinematic - Arrival'),
(607, 'Temple of the Jade Serpent - Cinematic - Serpent'),
(608, 'Cosmetic - Chen in Halfhill'),
(611, 'Cosmetic - Li Li in Halfhill'),
(614, 'East Temple Sha Dailies - Grounds'),
(616, 'Cosmetic - Mina at Home'),
(617, 'Cosmetic - Mina on Carrot'),
(618, 'Bonkers Brewery'),
(619, 'Cosmetic - Chen at Brewery Front'),
(620, 'Cosmetic - Chen at Brewery Back'),
(621, 'Cosmetic - Li Li at Brewery Front'),
(622, 'Cosmetic - Li Li at Brewery Back'),
(623, 'Cosmetic - Mudmug at Brewery Front'),
(624, 'Cosmetic - Mudmug at Brewery Back'),
(625, 'Cosmetic - Kung Fu Intro'),
(628, 'Ravenholdt Chapter 03 Cutscene'),
(629, 'Cosmetic - Cart Driver Captured'),
(630, 'Cosmetic - Cart Driver Freed'),
(631, '"Cosmetic - Huo, Pre-Ignition"'),
(632, '"Cosmetic - Huo, Post-Ignition"'),
(635, 'Gilneas Infiltration Phase'),
(638, 'Cosmetic - Bell'),
(639, 'Cosmetic - Water SpringsNOTUSED'),
(640, 'Karazhan Infiltration Phase'),
(642, 'Cosmetic - Mudmug in Halfhill'),
(643, 'Cosmetic - Post-Brewing NPCs in Halfhill'),
(644, 'Cosmetic - Barrels in Halfhill'),
(645, 'Cosmetic - NPCs at Brewery Front'),
(646, 'Cosmetic - NPCs at Brewery Back'),
(647, 'Knocking on the Door B'),
(648, 'East Temple Sha Dailies - Bombing Run'),
(649, 'Cosmetic - Cart at Brewery Front'),
(650, 'Cleaning House'),
(651, 'Ravenholdt Chapter 08 Finale'),
(652, 'Ravenholdt Chapter 08 Finale Cutscene'),
(655, 'Cosmetic - Jade Witch Pre-Fight'),
(656, 'Cosmetic - War Serpent for FirefightingNOTUSED'),
(657, 'Cosmetic - War Serpent for BombingNOTUSED'),
(658, 'Cosmetic - Doza in New Taurajo'),
(659, 'Cosmetic - New Taurajo (Going West)'),
(660, '"Cosmetic - Chezin Dawnchaser (Alive, H)"'),
(661, 'Cosmetic - Kang Bramblestaff (New Taurajo)'),
(662, 'Cosmetic - New Taurajo (Going West)'),
(665, 'The Arboretum - Serpent Hatch Cinematic'),
(666, 'Cosmetic - Li Li at Granary'),
(667, 'Cosmetic - Mudmug at Gilded Fan'),
(668, 'Cosmetic - New Taurajo (Labor for Labor)'),
(669, 'Zhu\'s Despair'),
(670, 'Well of Eternity - Well RP Scene'),
(673, 'Cosmetic - The Torjari Pits (Toad Mastery)'),
(674, 'Cosmetic - The Torjari Pit (Post Toad Mastery)'),
(675, 'Cosmetic - Nesingwary\'s Safari'),
(676, 'Cosmetic - Nesingwary\'s Safari - Darkwool\'s Head'),
(677, 'Cosmetic - Nesingwary\'s Safari'),
(678, 'Cosmetic - Lair of the Beast (Fight NPCs)'),
(679, 'Cosmetic - Fallsong Village (Horde)'),
(680, 'Cosmetic - Flag 1'),
(681, 'Cosmetic - Flag 2'),
(682, 'Cosmetic - Flag 3'),
(683, 'Cosmetic - Flag 4'),
(684, 'Cosmetic - Flag 5'),
(685, 'Cosmetic - Flag 6'),
(686, 'Cosmetic - Flag 7'),
(687, 'Cosmetic - Flag 8'),
(688, 'Cosmetic - Flag 9'),
(689, 'Cosmetic - Flag 10'),
(690, 'Cosmetic - Nesingwary\'s Safari (Mushan done)'),
(691, 'Cosmetic - Nesingwary\'s Safari (Wolf done)'),
(692, 'Cosmetic - Post-Birth Event'),
(693, 'Cosmetic - Nesingwary\'s Safari (Fox done)'),
(694, 'The Arboretum - They Grow Like Weeds'),
(695, 'Birth Scene'),
(698, 'The Arboretum - Riding the Skies'),
(699, 'Cosmetic - Farwalker Refuge (Going West)'),
(700, 'Montage A'),
(701, 'Cosmetic - Forbidden Jungle (Captives)'),
(703, 'Montage B'),
(704, 'Cosmetic - Farwalker Refuge (For the Tribe)'),
(705, 'Cosmetic - Forbidden Jungle (H)'),
(706, 'Cosmetic - Farmer Yoon State 1'),
(707, 'Cosmetic - Farmer Yoon State 2'),
(708, 'Cosmetic - Farmer Yoon State 3'),
(709, 'Cosmetic - Unbudging Rocks'),
(710, 'Cosmetic - Farwalker Refuge (Conclusion)'),
(711, 'The Incursion (Oubliette)'),
(712, 'Cosmetic - See Haohan Mudclaw at House'),
(713, 'Cosmetic - See Haohan Mudclaw at Market'),
(714, 'Cosmetic - See Old Hillpaw at House'),
(715, 'Cosmetic - See Old Hillpaw at Market'),
(716, 'Cosmetic - See Farmer Fung at House'),
(717, 'Cosmetic - See Farmer Fung at Market'),
(718, 'Cosmetic - See Tina Mudclaw at House'),
(719, 'Cosmetic - See Tina Mudclaw at Market'),
(720, 'Cosmetic - See Chee Chee at House'),
(721, 'Cosmetic - See Chee Chee at Market'),
(722, 'Cosmetic - See Sho at House'),
(723, 'Cosmetic - See Sho at Market'),
(724, 'Cosmetic - See Ella at House'),
(725, 'Cosmetic - See Ella at Market'),
(726, 'Cosmetic - See Fish at House'),
(727, 'Cosmetic - See Fish at Market'),
(728, 'Cosmetic - Krasarang Wilds (Horde)'),
(729, 'Cosmetic - Krasarang Wilds (Alliance)'),
(734, 'Cosmetic - Kang Bramblestaff (The Incursion)'),
(735, 'Cosmetic - The Lost Dynasty (A)'),
(736, 'Cosmetic - Sentinel Basecamp (No Sister Left Behind)'),
(737, 'Cosmetic - Ruins of Korja (Horde)'),
(738, 'Cosmetic - Yoon\'s Marsh Lotus'),
(739, 'Cosmetic - Ruins of Korja (Hostages)'),
(741, 'Cosmetic - The Incursion (Post-Poisoning)'),
(742, 'Cosmetic - The Incursion (Pre-Poisoning)'),
(743, 'Cosmetic - The Lost Dynasty (A)'),
(744, 'Cosmetic - The Incursion (Lorekeeper Vaeldrin)'),
(745, '"Cosmetic - The Incursion (Post-Immortality, Lyalia)"'),
(746, '"Cosmetic - The Incursion (Pre-Immortality, Lyalia)"'),
(747, 'Cosmetic - Krasarang Wilds (Alliance)'),
(748, 'Cosmetic - Krasarang Wilds (Horde)'),
(751, 'Cosmetic - The Incursion (Main NPCs visible)'),
(752, 'Cosmetic - Forbidden Jungle (A)'),
(753, 'Cosmetic - Forbidden Jungle (Rescued Stoneplow Envoy)'),
(754, 'Cosmetic - The Incursion (Vaeldrin visible)'),
(755, 'Cosmetic - The Incursion (Pre-Immortality)'),
(756, 'Cosmetic - Sentinel Basecamp (Alliance Present) '),
(757, 'Cosmetic - Sentinel Basecamp (Vaeldrin) '),
(758, 'Cosmetic - Sentinel Basecamp (Lyalia Present) '),
(759, 'Cosmetic - Sentinel Basecamp (Lyalia Present 02) '),
(760, 'Cosmetic - Sentinel Basecamp (Lyalia Corpse)'),
(765, 'Cosmetic - The Incursion (Alynna)'),
(766, 'Cosmetic - See Little Lu'),
(767, 'Cosmetic - Nimm Codejack'),
(768, 'Cosmetic - Nimm\'s Cage'),
(770, 'Cosmetic - The Incursion (Xintar visible)'),
(771, 'Cosmetic - The Incursion (Post-Going on the Offensive)'),
(772, 'Cosmetic - Glassfin Waterspeaking Actors'),
(773, 'Cosmetic - Glassfin Waterspeaking Elder'),
(774, 'Cosmetic - Shrine of the Dawn (Find the Boy)'),
(775, 'Cosmetic - Dawnblossom (Lo Flamelager 01)'),
(776, 'Cosmetic - Dawnblossom (Shrine of the Dawn Complete)'),
(777, 'Ambermist Bog - The Dream Brew Vision'),
(778, 'Spirit Shift'),
(779, 'Cosmetic - Anduin Camp'),
(780, 'Cosmetic - Alliance Flags'),
(783, 'Cosmetic - Simian Sabotage - Stolen Weapons'),
(784, 'Cosmetic - Simian Sabotage - Stolen Tools'),
(785, 'Cosmetic - Simian Sabotage - Stolen Beer'),
(786, 'Cosmetic - Simian Sabotage - Stolen Grain'),
(787, 'Jade Dragon Destroyed '),
(788, 'Jade Dragon Destroyed - Bombing Run'),
(789, 'Jade Dragon Intact (Terrain)'),
(790, 'Cosmetic - Yak Wash 001'),
(791, 'Cosmetic - Yak Wash (Post wash)'),
(792, 'Cosmetic - Yombo Grumblepaw 001'),
(795, 'Cosmetic - See Ka Pao'),
(798, 'Meditation'),
(801, 'Cosmetic - Nazgrim & Taylor Unconscious'),
(802, 'Cosmetic - Nazgrim & Taylor Conscious'),
(803, 'Cosmetic - Frightened Pandaren in Binan Village'),
(804, 'Cosmetic - The Deeper (Idol 1 - Broken)'),
(805, 'Cosmetic - The Deeper (Idol 1 - Not Broken)'),
(809, 'Cosmetic - Plot Expansion 1'),
(810, 'Cosmetic - See Gai Lan at Farm'),
(811, 'Cosmetic - Easterly & Westerly Rest Not Taken'),
(812, 'Cosmetic - Easterly & Westerly Rest Taken'),
(813, 'Cosmetic - See Suspicious Footprints'),
(814, 'Cosmetic - Plot Expansion 2'),
(815, 'Glassfin Village War Prep'),
(816, 'Cosmetic - Do Not See Fish Because She\'s Working'),
(817, 'Cosmetic - See Gai Lan'),
(818, 'Cosmetic - See Gai Lan Junior'),
(819, 'Cosmetic - See Lost Dog'),
(820, 'Cosmetic - See Dog'),
(821, 'Cosmetic - See Fish at Farmer Yoon\'s'),
(822, 'Cosmetic - Dusty Spots'),
(823, 'Chief Yip-Yip'),
(824, 'Cosmetic - Plot Expansion 3'),
(825, 'Cosmetic - See Haohan at Farmer Yoon\'s'),
(826, 'Cosmetic - See Thunder'),
(827, 'Cosmetic - Upgrade - See Fixed Wagon'),
(828, 'Cosmetic - Upgrade - See Mushan Beast'),
(829, 'Cosmetic - Upgrade - See Chickens'),
(830, 'Cosmetic - Upgrade - See Horse'),
(831, 'Cosmetic - Upgrade - See Sheep'),
(832, 'Cosmetic - Upgrade - See Pigs'),
(833, 'Cosmetic - Upgrade - See Cat'),
(834, 'Cosmetic - Upgrade - See Tree'),
(835, 'Cosmetic - Upgrade - See Mailbox'),
(836, 'Cosmetic - See Ka Pao'),
(837, 'Cosmetic - See Luna at Ella\'s'),
(838, 'Cave of Scrolls Attack'),
(841, 'Cosmetic - Tassle 001'),
(842, 'Riding Tassle'),
(843, 'Cosmetic - Uyen Chow\'s Cast Iron Pot and Vegetables'),
(844, 'Cosmetic - Farmhand is Chee Chee'),
(845, 'Cosmetic - Farmhand is Ella'),
(846, 'Cosmetic - Farmhand is Fish'),
(847, 'Cosmetic - Farmhand is Fung'),
(848, 'Cosmetic - Farmhand is Gina'),
(849, 'Cosmetic - Farmhand is Haohan'),
(850, 'Cosmetic - Farmhand is Jogu'),
(851, 'Cosmetic - Farmhand is Old Hillpaw'),
(852, 'Cosmetic - Farmhand is Sho'),
(853, 'Cosmetic - Farmhand is Tina'),
(854, 'Cosmetic - Farmer Chow\'s Yaks'),
(855, 'Cosmetic - See Jogu at Market (Oracle 1-8)'),
(856, 'Cosmetic - See Gina at Market'),
(857, 'Cosmetic - Uyen Chow\'s Meat'),
(858, 'Cosmetic - Freed Farmhands'),
(859, 'Cosmetic - See Rake'),
(860, 'Cosmetic - See Dark Soil'),
(861, 'Cosmetic - See Rivett\'s Grill'),
(862, 'Serpent\'s Spine - Post Apacolypse '),
(863, 'Cosmetic - See Rell Nightwind at Wayward Landing'),
(864, 'Cosmetic - The Great Shazboodle 01'),
(865, 'Cosmetic - Unloaded Firework Launchers'),
(866, 'Cosmetic - Loaded Firework Launchers'),
(867, 'Cosmetic - Supplies Restocked '),
(868, 'Cosmetic - See Mishka at Plane'),
(869, 'Cosmetic - Sherpan Gathered'),
(870, 'Cosmetic - Mogu Relics Flavor'),
(871, 'Cosmetic - Ji-Lu\'s Cart 01'),
(872, 'Cosmetic - Ji-Lu\'s Cart 02'),
(873, 'Cosmetic - Supplies in Cart '),
(874, 'Cosmetic - Loon Mai at House'),
(875, 'Cosmetic - Loon Mai at Barricade'),
(876, 'Golden Valley Intro'),
(877, 'Cosmetic - See Momo'),
(878, 'Cosmetic - Mandori Village Gate Spawns'),
(879, 'Cosmetic - Pei-Wu Forest Gate Spawns'),
(884, 'Cosmetic - Brother Rabbitsfoot'),
(885, 'Cosmetic - The Great Shazboodle Prisoner'),
(886, 'Cosmetic - Pako the Speaker'),
(887, 'Cosmetic - The Deeper (Idol 2 - Not Broken)'),
(888, 'Cosmetic - The Deeper (Idol 2 - Broken)'),
(889, 'Cosmetic - The Deeper (Idol 3 - Not Broken)'),
(890, 'Cosmetic - The Deeper (Idol 3 - Broken)'),
(891, 'Ruins Rise - Cave is Open (NEVER)'),
(892, '"Cosmetic - On ""Round \'Em Up"""'),
(893, 'Cosmetic - See He Softfoot'),
(894, 'Cosmetic - Mudmug in Stoneplow'),
(895, 'Cosmetic - See Arrow'),
(896, 'Cosmetic - Stoneplow Kegs - Archers'),
(897, 'Cosmetic - Stoneplow Kegs - Priests'),
(898, 'Cosmetic - Stoneplow Kegs - Shadowpan'),
(899, 'Cosmetic - Stoneplow Kegs - Alliance'),
(900, 'Cosmetic - Stoneplow Kegs - Horde'),
(901, 'Ruins Rise - Cave is Closed (NEVER)'),
(902, 'Cosmetic - Floor Babies'),
(903, 'Cosmetic - Hermit Hut Spawns'),
(904, 'Player Farm - Horde Phase 0'),
(905, 'Player Farm - Alliance Phase 0'),
(906, 'Cosmetic - Fort Silverback (Snackrifice)'),
(907, '"Cosmetic - On ""Pandaren Prisoners"""'),
(908, 'Cosmetic - The Other Shazboodle 01'),
(909, 'Cosmetic - Fort Silverback (prelude)'),
(910, 'Cosmetic - Fort Silverback (Prelude 002)'),
(911, '"Cosmetic - ""In Tents Channeling"" Fire Shield"'),
(912, 'Cosmetic - Miss Fanny in Stoneplow'),
(913, 'Cosmetic - Mantid Colossus'),
(914, '"Cosmetic - ""Barrels of Fun"" - Eastern Oil Rig Effects"'),
(915, '"Cosmetic - ""Barrels of Fun"" - Southern Oil Rig Effects"'),
(916, '"Cosmetic - ""Barrels of Fun"" - Western Oil Rig Effects"'),
(917, 'Cosmetic - Fort Silverback (Idol 4 - Not Broken)'),
(918, 'Cosmetic - Fort Silverback (Idol 4 - Broken)'),
(919, 'Golden Valley Finale'),
(920, 'Golden Valley Finale Completion Phase'),
(921, '"Cosmetic - ""Challenge Accepted"" Props Before"'),
(922, '"Cosmetic - ""Challenge Accepted"" Props After"'),
(923, 'Cosmetic Phase - See Rusty Watering Can'),
(924, 'Cosmetic Phase - See Vintage Bug Sprayer'),
(925, 'Silent Sanctuary NPCs Dead'),
(926, 'Silent Sanctuary Combat Phase'),
(927, 'Cosmetic - Untainted Supplies'),
(928, 'Cosmetic - The Dooker Dome (Sherp it Up)'),
(929, 'Cosmetic - See NPCs at Outpost - Phase 1'),
(930, 'Cosmetic - Dooker Dome (Questgivers 1)'),
(931, 'Cosmetic - Supplies at the Camp - Phase 2'),
(932, 'Dooker Dome (Final Fight)'),
(933, 'Cosmetic - Rokko'),
(934, 'Dooker Dome (Final Fight Prep)'),
(935, '"Cosmetic - ""Holed Up"" - Jin Warmkeg"'),
(936, '"Cosmetic - ""Holed Up"" - Mayor Firebough"'),
(937, 'Cosmetic - Lha-Po - Phase 3'),
(938, 'Cosmetic - The Deeper (Idol 2 Alter - Not Broken)'),
(939, 'Cosmetic - The Deeper (Idol 3 Alter - Not Broken)'),
(940, 'Cosmetic - The Deeper (Idol 1 Alter - Not Broken)'),
(941, '"Cosmetic - ""Holed Up"" - Old Lady Fung"'),
(942, '"Cosmetic - ""Holed Up"" - Sya Lotusflower"'),
(943, 'Cosmetic - See Leven Dawnblade During Finale Completion'),
(944, 'Cosmetic - Yeti Mountain Basecamp'),
(945, 'Cosmetic - See Extra Dead Bodies'),
(946, 'Cosmetic - Spare Plank'),
(947, 'Horde Hub Swap'),
(948, 'Cosmetic - Tough Kelp'),
(949, 'Cosmetic - See Campfire at Outpost - Phase 1'),
(950, 'Cosmetic - Player Raft'),
(951, 'Cosmetic - The Dooker Dome (Monkey Idol 5 - Not Broken)'),
(952, 'Cosmetic - See Refugees at Gate'),
(953, 'Cosmetic - See Questgivers at Gate'),
(954, 'Cosmetic - The Dooker Dome (Monkey Idol 5 - Broken)'),
(955, '"Cosmetic - ""The Show Must Go On!"" Special FX"'),
(956, '"Cosmetic - ""Holed Up"" - Complete"'),
(957, 'Cosmetic - See Mogu Gate 1 - FIRST'),
(958, 'Cosmetic - See Mogu Gate 1 - SECOND'),
(959, 'Cosmetic - Silent Sanctuary Guards 1 (Fewer)'),
(960, 'Cosmetic - Silent Sanctuary Guards 2 (More)'),
(961, 'Cosmetic - Recipe - Flask of Spring Blossoms'),
(962, 'Cosmetic - See Zhi the Harmonious at Twin Monoliths'),
(963, 'Fort Silverback - Old Poot Poot Escape'),
(964, 'Cosmetic - Aysa\'s Vision'),
(965, '"Cosmetic - ""Regaining Honor"" Completed"'),
(966, 'Cosmetic - Cradle of Chi-Ji - Boss Fight 00'),
(967, 'Cosmetic - Cradle of Chi-Ji - Boss Fight 01'),
(968, 'Cosmetic - Cradle of Chi-Ji - Boss Fight 02'),
(969, 'Cosmetic - Cradle of Chi-Ji - Boss Fight 03'),
(970, 'Cosmetic - Cradle of Chi-Ji - Boss Fight 04'),
(971, 'Cosmetic - Cradle of Chi-Ji - Boss Fight 05'),
(972, 'Cosmetic - Cradle of Chi-Ji - Boss Fight 06'),
(973, 'Cosmetic - Cradle of Chi-Ji - Boss Fight 07'),
(974, 'Cosmetic - Cradle of Chi-Ji - Boss Fight 08'),
(975, 'Cosmetic - Cradle of Chi-Ji - Boss Fight 09'),
(976, 'Cosmetic - Cradle of Chi-Ji - Boss Fight 10'),
(977, 'Cosmetic - Cradle of Chi-Ji - Boss Fight 11'),
(978, 'Cosmetic - Cradle of Chi-Ji - Boss Fight 12'),
(979, 'Cosmetic - Cradle of Chi-Ji - Boss Fight 13'),
(980, 'Cosmetic - Cradle of Chi-Ji - Boss Fight 14'),
(981, 'Cosmetic - Cradle of Chi-Ji - Boss Fight 15'),
(984, 'Cosmetic - Intro - Two Soldiers'),
(985, 'Cosmetic - Cradle of Chi-Ji - Thelonius'),
(986, 'Cosmetic - Cradle of Chi-Ji - Kuo-Na'),
(987, 'Cosmetic - Cradle of Chi-Ji - Yan'),
(988, 'Cosmetic - See Battle Axe'),
(989, 'Cosmetic - See Battle Helm'),
(990, 'Cosmetic - See 3 Weapons'),
(992, 'Cosmetic - Destroyed Fishing Village QG Kneeling'),
(993, 'Crashed Ship Cinematic Leadin'),
(994, 'Cosmetic - Sumprushes - Broken Torch'),
(995, 'Cosmetic - Sumprushes - Mistbreaker\'s Torch'),
(996, 'Cosmetic - See Cooking Pot Sparkles'),
(997, 'Cosmetic - Sumprushes - Freed Orbiss'),
(998, 'Cosmetic - Destroyed Panda Village Intro'),
(999, 'Cosmetic - A Fair Trade - Questgivers'),
(1000, 'Cosmetic - Destroyed Panda Village Escort'),
(1001, 'The Burlap Grind'),
(1004, 'Alliance Hub Swap'),
(1005, 'Cosmetic - See Archers on Cart Ride'),
(1006, 'Cosmetic - A Fair Trade - Kota Kon'),
(1007, 'Cosmetic - Keenbean and Gootfur A'),
(1008, 'Cosmetic - See Shado-Pan Banner'),
(1009, 'Cosmetic - A Fair Trade - Lair of Kota Kon'),
(1010, 'Cosmetic - See Ban at Osul Peak'),
(1011, 'Cosmetic - See Ban at Outpost'),
(1012, 'Cosmetic - Sumprushes - Misty Orbiss'),
(1013, 'Cosmetic - Sumprushes - Golgoss'),
(1014, 'Cosmetic - Sumprushes - Arconiss'),
(1015, 'Cosmetic - See Taran'),
(1016, 'Cosmetic - Sumprushes - Finale Actors'),
(1017, 'Cosmetic - Sumprushes - Final Orbiss'),
(1018, 'Cosmetic - Kun-Lai Village Funeral Done'),
(1019, 'Cosmetic - Kun-Lai Funeral Incense Stick'),
(1020, 'Cosmetic - See Ban at Outpost'),
(1021, 'Cosmetic - Kun-Lai Funeral - Pre-Event Props (Not Stick)'),
(1022, 'Cosmetic - See Suna 1 at Osul Peak'),
(1023, 'Cosmetic - See Suna 2 at Osul Peak'),
(1024, 'Cosmetic - Burlap Waystation (Snackrifice Complete)'),
(1025, 'Cosmetic - See Suna 2 at Osul Peak'),
(1026, 'Cosmetic - See Suna at Outpost'),
(1027, 'Cosmetic - Fire Spirit Rescued'),
(1028, 'Cosmetic - Water Spirit Rescued'),
(1029, 'Cosmetic - Earth Spirit Rescued'),
(1030, 'Cosmetic - Air Spirit Rescued'),
(1031, 'Cosmetic - Ancient Text'),
(1032, 'Cosmetic - Burlap Trail 1'),
(1033, 'Cosmetic - Burlap Trail 2'),
(1034, 'Cosmetic - Grain Basket in Halfhill'),
(1035, 'Cosmetic - See Totem of Kindness'),
(1036, 'Cosmetic - See Totem of Love'),
(1037, 'Cosmetic - See Totem of Serenity'),
(1038, 'Cosmetic - See Totems'),
(1039, 'Cosmetic - Hop Bags in Halfhill'),
(1040, 'Reclaiming Thunder God'),
(1041, 'Cosmetic - Lin in Paoquan'),
(1042, 'Hatred Phase'),
(1045, 'Cosmetic - Mysterious Whirlpool'),
(1046, 'Cosmetic - North Fissure Available'),
(1047, 'Cosmetic - East Fissure Available'),
(1048, 'Cosmetic - South Fissure Available'),
(1049, 'Cosmetic - Wayward Lamb'),
(1051, 'Cosmetic - See Shado-Pan'),
(1053, 'Resurrecting Thunder God'),
(1054, 'Cosmetic - See Shado-Pan'),
(1055, 'Cosmetic - See Questgivers'),
(1056, 'Cosmetic - See Caravan'),
(1057, 'Cosmetic - See Xiao Tu'),
(1058, 'Cosmetic - See Yalia'),
(1059, 'Cosmetic - Xuen Location 1 - Intro'),
(1060, 'Cosmetic - Xuen Location 2 - Gazebo'),
(1061, 'Cosmetic - Xuen Location 3 - Eastern Arena'),
(1062, 'Cosmetic - Xuen Location 4 - Eastern Arena'),
(1063, 'Cosmetic - Xuen Location 5 - Tiger Temple 1'),
(1064, 'Cosmetic - See Xiao Tu'),
(1065, 'Cosmetic - See Questgivers'),
(1066, 'Cosmetic - See Yalia'),
(1067, 'Cosmetic - See Xiao Tu'),
(1068, 'Lei Shen\'s Tomb With Remains'),
(1069, 'Cosmetic - Kri\'vess - Weapon Racks'),
(1070, 'Cosmetic - Kri\'vess - Eggs'),
(1071, 'Cosmetic - Kri\'vess - Exploded Eggs'),
(1072, 'Cosmetic - Kri\'vess - Exploded Weapons'),
(1073, 'Cosmetic - See Mishi in Ruins'),
(1074, 'Cosmetic - See Shado-Pan'),
(1075, 'Cosmetic - Burial at Sea Questgiver'),
(1077, 'GoWB - Attack Phase 1 (Wall and Barrel Roll)'),
(1078, 'GoWB - Attack Phase 2 Pre-Event'),
(1079, 'Cosmetic - GoWB - Post-Attack'),
(1080, 'Cosmetic - Tiger Temple (Round 1 Flavor)'),
(1081, 'Cosmetic - Tiger Temple (Round 2 Flavor)'),
(1082, 'Cosmetic - Tiger Temple (Round 3 Flavor)'),
(1083, 'Cosmetic - Tiger Temple (Round 4 Flavor)'),
(1084, '"Cosmetic - Taoshi, Gao-ran Blockade"'),
(1085, '"Cosmetic - Taoshi, Shallowstep Pass"'),
(1086, '"Cosmetic - Taoshi, Dampsoil Burrow"'),
(1087, 'Cosmetic - See Dead Bodies'),
(1088, 'Cosmetic - See Grayson Early Normal'),
(1089, 'Cosmetic - See Flavor Crewmen'),
(1090, 'Cosmetic - Clouds'),
(1091, 'Cosmetic - Scout Wei-chin'),
(1092, 'Cosmetic - Scout Jai-gan'),
(1093, 'Cosmetic - Scout Ying'),
(1094, 'Cosmetic - Scout Long'),
(1095, 'Cosmetic - Don\'t See Zuni'),
(1098, 'Cosmetic - Gorrok in Hellscream\'s Hope'),
(1099, 'Cosmetic - See Zuni'),
(1100, 'Cosmetic - Shokia in Hellscream\'s Hope'),
(1101, 'Cosmetic - Rivett in Hellscream\'s Hope'),
(1102, 'Cosmetic - Kiryn in Hellscream\'s Hope'),
(1103, 'Cosmetic - See Wounded Villagers'),
(1104, 'Cosmetic - See Villagers'),
(1105, 'Cosmetic - Kun-Lai Summit - No Mere Event'),
(1106, 'Cosmetic - Kun-Lai - Jinyu Speaker Questgiver Position 1'),
(1107, 'Cosmetic - Kun-Lai Summit - Jinyu Mere Post-Boss'),
(1108, 'Cosmetic - Kun-Lai - Waterspeaker Staff Done'),
(1109, 'Cosmetic - Kun-Lai - Father and Son Reunion Not Started'),
(1110, 'Cosmetic - Jade Mines Arrival'),
(1111, 'Cosmetic - Jade Mines - Miners Saved'),
(1112, '"Cosmetic - Kun-Lai Summit - Staff Done, No Event"'),
(1113, 'Cosmetic - Kun-Lai - Ritual Complete'),
(1115, 'Cosmetic - Xuen Location 6 - Tiger Temple 2'),
(1116, 'Cosmetic - Kun-Lai - Mere Not Yet Cleansed'),
(1117, 'Cosmetic - Kun-Lai - Father and Son Reunion Complete'),
(1118, 'Cosmetic - Yak Temple - Grummles'),
(1119, 'Cosmetic - Kun-Lai Summit - Reposession Complete'),
(1120, 'Cosmetic - See Ancient Text (Lootable)'),
(1121, 'Cosmetic - See Ancient Text (Quest Giver)'),
(1122, 'Cosmetic - See Ancient Text (Final)'),
(1123, 'Cosmetic - Kun-Lai Summit - Post Mere Event'),
(1124, 'Cosmetic - Kun-Lai Summit - Cleansed Corpses(NLC)'),
(1125, 'Cosmetic - Kun-Lai Summit - Uncleansed Corpses(NLC)'),
(1126, 'Cosmetic - Fresco Panel 1'),
(1127, 'Cosmetic - Fresco Panel 2'),
(1128, 'Cosmetic - Fresco Panel 3'),
(1129, 'Cosmetic - Yak Temple - Yak Area Grummles'),
(1130, 'Cosmetic - Yak Temple - Yak Area Ruthers'),
(1131, 'Cosmetic - Yak Temple - Yak Area Good Yak'),
(1132, 'Cosmetic - Emperor\'s Omen - Hao Mann'),
(1133, 'Cosmetic - Pearlfin Finale Event 1'),
(1134, 'Cosmetic - See Bombers'),
(1135, 'Cosmetic - Stormwind/Elwynn - Aysa'),
(1136, 'Cosmetic - Stormwind/Elwynn - Jojo'),
(1137, 'Cosmetic - Stormwind/Elwynn - Balloon'),
(1138, 'Cosmetic - Ling Completion - See Scroll'),
(1139, 'Cosmetic - Stormwind Keep - See Varian'),
(1140, 'Cosmetic - Kun-Lai Funeral Appears'),
(1143, 'Cosmetic - Pearlfin Finale Event 2'),
(1144, 'Cosmetic - See Thunder King\'s Tablet'),
(1145, 'Cosmetic - See Thunder King\'s Tablet (Broken)'),
(1146, 'Cosmetic - Ling Completion - See Scroll - Dummy'),
(1147, 'Spar with Varian'),
(1148, 'Cosmetic - See Thunder King\'s Tablet Restored'),
(1149, 'Horde Intro Scene'),
(1150, 'Cosmetic - See Lorewalker Cho'),
(1151, 'Cosmetic - Kun-Lai Summit - GoWB - Liu\'s Spirit Not Freed'),
(1152, 'Cosmetic - Kun-Lai Summit - GoWB - Zhiyao\'s Spirit Not Freed'),
(1154, 'Cosmetic - Lorewalker Cho'),
(1155, 'Mantid Attack Phase'),
(1156, 'Cosmetic - Kun-Lai Summit - GoWB - Shiya\'s Spirit Not Freed'),
(1157, '"Cosmetic - Gate of Winter\'s Blossom - Wall Started, Not Complete"'),
(1158, 'Zouchin Village - Zandalari Attack '),
(1159, 'Cosmetic - GoWB - Start Phase'),
(1160, 'Cosmetic - GoWB - Past Suna Start Phase'),
(1161, 'Cosmetic - Ji-Lu\'s Cart 03'),
(1162, 'Cosmetic - See Opan in Onekeg'),
(1163, 'Cosmetic - Lorewalker - Bookshelf'),
(1164, 'Cosmetic - Orgrimmar/Durotar - Ji'),
(1165, 'Cosmetic - Orgrimmar/Durotar - Balloon'),
(1166, 'Cosmetic - Lao on the Wall'),
(1167, 'Cosmetic - Orgrimmar - Grommash Hold - See Garrosh'),
(1168, 'Cosmetic - Guides on Yaks'),
(1169, 'Cosmetic - Don\'t See Yaks'),
(1170, 'Cosmetic - Orgrimmar - Garrosh by Arena'),
(1171, 'Cosmetic - Lali the Assistant'),
(1173, 'Cosmetic - Keg Bombs Ready!'),
(1174, 'Cosmetic - Lao Barrel Roll'),
(1175, 'Hellscream\'s Gift - Pre-Fight'),
(1176, 'Hellscream\'s Gift - Fight'),
(1177, 'Cosmetic - See Mantid 1 Bunnies'),
(1178, 'Cosmetic - See Mantid 2 Bunnies'),
(1179, 'Cosmetic - See Mantid 3 Bunnies'),
(1180, 'Cosmetic - See Mantid 4 Bunnies'),
(1181, 'Cosmetic - See Carapace'),
(1182, 'GoWB - Attack Phase 2 Event'),
(1183, 'GoWB - Attack Phase 2 Boss Fight'),
(1184, 'Cosmetic - See Thunder King\'s Tablet Restored'),
(1185, 'Cosmetic - See Paragon 2.1'),
(1186, 'Cosmetic - See Paragon 1.1'),
(1187, '"GoWB - Attack Phase 3 - Post Boss, Lao-Chen"'),
(1188, '"GoWB - Attack Phase 3 - Post Boss, Suna Available"'),
(1189, '"GoWB - Attack Phase 3 - Post Boss, Ban Here"'),
(1190, 'Cosmetic - Shado-Pan Monastery - Ban QG Visible'),
(1191, 'Cosmetic - Shado-Pan Monastery - Unbelievable!'),
(1192, 'Cosmetic - See Offering'),
(1193, 'Cosmetic - See Paragon 1.2'),
(1194, 'Cosmetic - See Paragon 2.2'),
(1195, 'Cosmetic - See Paragon 5 Carapace'),
(1196, 'Cosmetic - See Paragon 5'),
(1197, 'MoP Horde Intro Scene - Orgrimmar'),
(1198, 'Cosmetic - Wayward Landing - See Fires'),
(1199, 'Mantid Flying Phase (Shooting Gallery)'),
(1200, 'Mantid Boss Phase'),
(1202, 'Cosmetic - Jade Forest - Disciple\'s Enclave - JSB'),
(1203, 'Cosmetic - Kil\'ruk Sick'),
(1204, 'Cosmetic - Tik Alive'),
(1205, 'Cosmetic - Tik Dead'),
(1207, '"Cosmetic - Teran Zhu, Gao-ran Blockade"'),
(1208, '"Cosmetic - Taoshi, Dusklight Hollow"'),
(1209, 'Cosmetic - Horde Only'),
(1210, 'Cosmetic - Townlong Steppes - Tai Ho in Cave'),
(1211, 'Cosmetic - Temp Fires'),
(1212, 'Cosmetic - Townlong Steppes - Tai Ho at Garrison'),
(1213, 'Cosmetic - Temp Fires'),
(1214, 'Cosmetic - Townlong Steppes - Ku-Mo at Bridge'),
(1215, 'Cosmetic - Townlong Steppes - Ku-Mo at Stairs'),
(1216, 'Spawn Blendinng Test Phase 1'),
(1217, 'Cosmetic - Burial at Sea WESTERN CORPSE'),
(1218, 'Cosmetic - Burial at Sea SOUTHEASTERN CORPSE'),
(1219, 'Cosmetic - Burial at Sea NORTHEASTERN CORPSE'),
(1220, 'Dusklight Holdout Phase'),
(1221, 'Dusklight Combat Phase'),
(1222, 'Cosmetic - See Shomi Training'),
(1223, '"Cosmetic - Lao-Chin, Dusklight Bridge"'),
(1224, '"Cosmetic - Lao-Chin, Holdout Turn-in"'),
(1225, '"Cosmetic - Taran Zhu, Holdout Turn-in"'),
(1226, '"Cosmetic - Taoshi, Holdout Turn-in"'),
(1227, '"Cosmetic - Taran Zhu, Crossroads, First Arrival"'),
(1228, '"Cosmetic - Taoshi, Crossroads"'),
(1229, '"Cosmetic - Lao-Chin, Crossroads, First Arrival"'),
(1230, 'Cosmetic - Orgrimmar - Ji Firepaw Trainer'),
(1231, 'Cosmetic - Stormwind - Aysa Monk Trainer'),
(1232, 'Mantid Ground Boss Phase'),
(1233, 'Cosmetic - Mantid Ground Boss Completion Phase'),
(1234, 'Cosmetic - Malik at Klaxxi\'vess 1'),
(1246, '"Cosmetic - Nurong, Farwatch Cliff"'),
(1247, 'Cosmetic - See Snow Blossom @ Challenger\'s Ring'),
(1248, 'Cosmetic - See Yalia @ Challenger\'s Ring'),
(1249, 'Cosmetic - Lost Mugs'),
(1250, 'Cosmetic - Lost Keg'),
(1251, 'Cosmetic - Lost Picnic'),
(1252, '"Cosmetic - Taoshi, Sik\'vess Subboss"'),
(1253, '"Cosmetic - Lao-Chin, Sik\'vess Subboss"'),
(1254, '"Cosmetic - Nurong, Sik\'vess Subboss"'),
(1255, '"Cosmetic - Taoshi, Sik\'vess Entrance"'),
(1256, '"Cosmetic - Lao-Chin, Sik\'vess Entrance"'),
(1257, '"Cosmetic - Nurong, Sik\'vess Entrance"'),
(1258, '"Cosmetic - Taran Zhu, Sik\'vess Entrance"'),
(1259, '"Cosmetic - Ban, Sik\'vess Entrance"'),
(1260, '"Cosmetic - Nurong, Crossroads"'),
(1261, 'Sha of Hatred Comp Phase'),
(1262, 'Sha of Hatred Combat Phase'),
(1263, 'Cosmetic - See Portals'),
(1264, 'Cosmetic - See Snow Blossom at Hub 1'),
(1265, 'Cosmetic - See Yalia at Hub 1'),
(1266, 'Cosmetic - See Fei Li at Hub'),
(1267, 'Cosmetic - See Shifting Rocks Closed'),
(1268, 'Cosmetic - See Shifting Rocks (Summon)'),
(1269, 'Cosmetic - See Snow Blossom at Hub 2'),
(1270, 'Cosmetic - See Yalia at Hub 2'),
(1271, 'Cosmetic - Kil\'ruk at Klaxxi\'vess A'),
(1272, 'Cosmetic - Scroll of Auspice (Cave)'),
(1273, 'Cosmetic - See Chen A at Sunset Brewgarden'),
(1274, 'Cosmetic - See Chen with Evie'),
(1275, 'Cosmetic - See Chen B at Sunset Brewgarden'),
(1276, 'Cosmetic - See Evie\'s Grave'),
(1277, 'Cosmetic - See Han in Morrowchamber'),
(1278, 'Cosmetic - See Kneeling Chen in Morrowchamber'),
(1279, 'Cosmetic - See Amber Han in Brewgarden'),
(1280, 'Cosmetic - See Lya at Brewgarden'),
(1281, 'Cosmetic - See Scroll at Brewgarden'),
(1282, 'Cosmetic - See Stormstouts at Brewgarden'),
(1283, 'Cosmetic - See Li Li at Brewgarden'),
(1284, 'Cosmetic - See Evie at Brewgarden'),
(1285, 'Cosmetic - See Big Dan at Brewgarden'),
(1286, 'Cosmetic - See Brewers at Brewgarden (Opening)'),
(1287, 'Cosmetic - See Brewers at Rikkitun'),
(1288, 'Cosmetic - See Hiding Guides'),
(1289, 'Cosmetic - See Shinyseed at Rikkitun'),
(1290, 'Cosmetic - See Papa at Rikkitun'),
(1291, 'Cosmetic - See Landslide at Amber Hibernal'),
(1292, 'Cosmetic - See Caravan Guides'),
(1293, 'Cosmetic - See Brewers at Brewgarden (Final)'),
(1294, 'Cosmetic - See Dreadbrew at Brewgarden'),
(1295, 'Cosmetic - Mogu Lake Ritual Statues'),
(1296, 'Cosmetic - See Yi at Hub (NLC)'),
(1297, 'Cosmetic - See Chao @ Ring'),
(1298, 'Cosmetic - See Chao @ Hub'),
(1299, 'Cosmetic - See Lao-Chin @ Hub'),
(1300, 'Cosmetic - See Lao-Chin @ Ring'),
(1301, 'Cosmetic - See Han at Brewgarden (Free)'),
(1302, 'Cosmetic - See Malik in Hollow'),
(1303, 'Cosmetic - See Brew/Daggers at Brewgarden'),
(1304, 'Cosmetic - See Cho at Cairn of Bone'),
(1305, 'Cosmetic - Ting Still in Deathknell'),
(1306, 'Cosmetic - Daggle Bombstrider'),
(1307, 'Cosmetic - See Cho at Cairn of Stone'),
(1308, '"Cosmetic - Chezin Dawnchaser (Dead, H)"'),
(1309, 'Cosmetic - Ancient Mogu Artifact'),
(1310, 'Cosmetic - See Mishi Finale'),
(1311, 'Cosmetic - See Sonar Tower'),
(1312, 'Cosmetic - See Korven the Prime'),
(1313, 'Cosmetic - See Zouchin Balloon (Long Ride)'),
(1314, 'Cosmetic - See Zouchin Balloon (Short Ride)'),
(1315, 'Saltscale Grotto Defense'),
(1316, 'Cosmetic - See Skeer - Frozen'),
(1317, 'Cosmetic - See Skeer - Unfrozen'),
(1318, 'Cosmetic - The Spring Drifter'),
(1319, 'Stoneplow Finale Scene'),
(1320, 'Cosmetic - See Great Wall Cap'),
(1321, 'Cosmetic - See Zouchin Balloon (Short Ride - Up)'),
(1322, 'Saltscale Grotto Completion Phase'),
(1323, '"Cosmetic - Central Statue, Pre-Fire"'),
(1324, '"Cosmetic - Central Statue, Post-Fire"'),
(1325, '"Cosmetic - Central Statue, Post-Water"'),
(1326, '"Cosmetic - Central Statue, Post-Earth"'),
(1327, '"Cosmetic - Central Statue, Post-Air"'),
(1328, 'Cosmetic - GoWB - Pre-Battle Phase'),
(1329, 'Cosmetic - See NPCs - Pre-Invasion'),
(1330, 'Cosmetic - See NPCs - Post Invasion'),
(1331, 'Cosmetic - Kun-Lai Summit - On Eastwind Rest or Challenge'),
(1332, 'Cosmetic - Kun-Lai Summit - Westerly Rest Evacuees Gathered'),
(1333, 'Cosmetic - See Zidormi - Post Scenario'),
(1334, 'Cosmetic - Lorewalker Cho in Dawn\'s Blossom'),
(1335, 'Phase 3 - GoWB - Ban Waiting for Balloon'),
(1336, 'Cosmetic - Balloon Visible at Winter\'s Blossom'),
(1337, 'Cosmetic - See Xaril Questgiver'),
(1338, 'Cosmetic - See Dim Tower 1'),
(1339, 'Cosmetic - See Dim Tower 2'),
(1340, 'Cosmetic - See Dim Tower 3'),
(1341, 'Cosmetic - See Dim Tower 4'),
(1342, 'Cosmetic - See Dim Towers'),
(1343, 'Manipulator\'s Talisman Not Received'),
(1344, 'Cosmetic - See Xaril Frozen'),
(1345, 'Cosmetic - Curious Cub 1'),
(1346, 'Cosmetic - Curious Cub 2'),
(1347, 'Cosmetic - Curious Cub 3'),
(1348, 'Cosmetic - Curious Cub 4'),
(1349, 'Cosmetic - Curious Cub 5'),
(1350, 'Cosmetic - Dawn\'s Blossom (Post - Cho)'),
(1351, 'East Temple Sha Dailies - Temple'),
(1352, 'Klaxxi Daily Bombing Run'),
(1353, 'Cosmetic - Balloon Visible at Monastery'),
(1354, 'Cosmetic - See Taoshi at Hub'),
(1355, 'Cosmetic - See Tenwu at Hub'),
(1356, 'Cosmetic - See Nurong at Hub'),
(1357, 'Cosmetic - See Trolls Attacking Strand'),
(1358, 'Cosmetic - See Liao Summon'),
(1359, 'Cosmetic - See Villager Corpses'),
(1360, 'Cosmetic - See Crab with Sleeping Panda'),
(1361, 'Cosmetic - See Crab while Standing'),
(1362, 'NOT-Cosmetic - See Trolls Finale'),
(1363, 'Cosmetic - Sra\'vess - Intact Statue A'),
(1364, 'Cosmetic - Sra\'vess - Destroyed Statue A'),
(1365, 'Cosmetic - Sra\'vess - Intact Statue B'),
(1366, 'Cosmetic - Sra\'vess - Destroyed Statue B'),
(1367, 'Cosmetic - Sra\'vess - Intact Statue C'),
(1368, 'Jeek Jeek'),
(1369, 'Cosmetic - Sra\'vess - Destroyed Statue C'),
(1370, 'Cosmetic - Sra\'vess - Intact Statue D'),
(1371, 'Cosmetic - Sra\'vess - Destroyed Statue D'),
(1372, 'Cosmetic: See Lorewalker Cho (Phased)'),
(1373, 'Cosmetic - Sra\'vess - Intact Tank A'),
(1374, 'Cosmetic - Sra\'vess - Intact Tank B'),
(1375, 'Cosmetic - Sra\'vess - Intact Tank C'),
(1376, 'Cosmetic - Sra\'vess - Intact Tank D'),
(1377, 'Cosmetic - Sra\'vess - Destroyed Tank A'),
(1378, 'Cosmetic - Sra\'vess - Destroyed Tank B'),
(1379, 'Cosmetic - Sra\'vess - Destroyed Tank C'),
(1380, 'Cosmetic - Sra\'vess - Destroyed Tank D'),
(1381, 'Cosmetic: See Elders (Phased)'),
(1382, 'Cosmetic - Freed Farmhands - Horde Hub'),
(1383, 'Cosmetic - Freed Farmhands - Alliance Hub'),
(1384, 'Cosmetic - Messenger Grummles'),
(1385, 'Cosmetic - Westerly Rest - Yaks'),
(1386, 'Cosmetic - Westerly Rest - Meat'),
(1387, 'Cosmetic - Easterly Rest - Meat'),
(1388, 'Cosmetic - Daggle Bombstrider 2'),
(1389, 'Cosmetic - Grookin Flapmaster'),
(1390, 'Cosmetic - Eastwind Rest - Yaks'),
(1391, 'Cosmetic - See Skeer the Bloodseeker'),
(1392, 'Cosmetic - See Xaril the Poisoned Mind'),
(1393, 'Cosmetic - Westwind Rest - Adm. Taylor Position 1'),
(1394, 'Cosmetic - Westwind Rest - Adm. Taylor Position 2'),
(1395, 'Cosmetic - Westwind Rest - Pandaren Prisoners Rescued'),
(1396, 'Cosmetic - Eastwind Rest - Pandaren Prisoners Rescued'),
(1397, 'Cosmetic - Eastwind Rest - Nazgrim Position 2'),
(1398, 'Cosmetic - Eastwind Rest - Nazgrim Position 1'),
(1399, 'Yak Temple - Niuzao Temple Under Siege'),
(1400, 'Cosmetic - See Inactive Beacon'),
(1401, 'Cosmetic - See Active Beacon'),
(1402, 'Cosmetic - See Kaz\'tik 1'),
(1403, 'Theramore - Post Scenario (Destroyed)'),
(1404, 'Cosmetic - See Kaz\'tik [Summon]'),
(1405, 'Cosmetic - See Zouchin Balloon (Short Ride)'),
(1406, 'Cosmetic - See Frightened Villagers'),
(1407, 'Shado-Pan Garrison - Shado-Pan Finale'),
(1408, 'Cosmetic - The Spring Drifter (Saurok Visible)'),
(1409, 'Cosmetic - Sik\'vess Door'),
(1410, 'Jade Forest - Sha Bombing Run'),
(1411, 'Cosmetic - See Lucky at Outpost - Phase 1'),
(1412, 'The Mariner\'s Revenge'),
(1413, 'Cosmetic - See Kaz\'tik 3'),
(1414, 'Cosmetic - See Dirt'),
(1415, 'Cosmetic - See Thistle\'s Treasure'),
(1416, 'Cosmetic - See Sheepie 1'),
(1417, 'Cosmetic - See Sheepie 2'),
(1418, 'Cosmetic - See Sheepie 3'),
(1419, 'Cosmetic - See Kaz\'tik 4'),
(1420, 'Cosmetic - See Nurong @ Ring'),
(1421, 'Cosmetic - Between Mariner\'s Revenge and Mazu\'s Bounty'),
(1422, 'Cosmetic - See Tenwu @ Ring'),
(1425, 'Cosmetic - See Kovok 3'),
(1426, 'Cosmetic - Clutches Relay Inactve'),
(1427, 'Cosmetic - Clutches Relay Active'),
(1428, 'Cosmetic - See Amber'),
(1429, '"Cosmetic - Onyx Dragon, Bridge Flyby"'),
(1430, '"Cosmetic - Onyx Dragon, Over Air Plateau"'),
(1431, 'Cosmetic - Scholomance 5.0 - Quest - Talking Skull - Low Level ('),
(1432, 'The Secrets of Guo-Lai (NEVER)'),
(1433, 'Cosmetic - See Amberfied Hisek'),
(1434, 'Cosmetic - See Duskroot Mushroom'),
(1435, 'Cosmetic - See Hesik (Version 2)'),
(1436, 'Cosmetic - Scholomance 5.0 - Quest - Talking Skull - 90+ Heroic '),
(1437, 'Tiger Temple Anduin Event'),
(1438, 'Cosmetic - Sra\'vess - N Trainee'),
(1439, 'Cosmetic - Sra\'vess - CTrainee'),
(1440, 'Cosmetic - Sra\'vess - S Trainee'),
(1441, 'Cosmetic - Scarlet Halls 5.0 - Low Level - Quest - Hooded Crusad'),
(1442, 'Cosmetic - Scarlet Halls 5.0 - 90+ Heroic - Quest - Hooded Crusa'),
(1443, 'Cosmetic - Scarlet Monastery 5.0 - Low Level - Quest - Hooded Cr'),
(1444, 'The Helm of the Thunder King (NEVER)'),
(1445, 'Cosmetic - Scarlet Monastery 5.0 - 90+ Heroic - Quest - Hooded C'),
(1456, 'The Secrets of Guo-Lai Comp (NEVER)'),
(1457, 'Cosmetic - See Chen Stormstout'),
(1460, '"Cosmetic - Ren, Hall Static"'),
(1461, '"Cosmetic - Ren, Boss Fight"'),
(1462, 'Cosmetic - Player Dead'),
(1463, 'Cosmetic - Player Alive'),
(1464, 'Cosmetic - See Silent Santuary Door'),
(1465, '"Cosmetic - He, Hall Static"'),
(1466, '"Cosmetic - He, Boss Fight"'),
(1467, 'Cosmetic - See Yoon\'s Apples & Craneberries'),
(1468, 'Cosmetic - Mogu Doors - Open'),
(1469, 'Cosmetic - Mogu Doors - Closed'),
(1470, 'Cosmetic - Rik\'kal on Zan\'vess'),
(1471, 'Suna Phase'),
(1472, 'Cosmetic - Ka\'roz at Klaxxi\'vess'),
(1473, 'Cosmetic - Iyyokuk at Klaxxi\'vess'),
(1474, 'Cosmetic - Rik\'kal at Klaxxi\'vess'),
(1475, 'Cosmetic - Kil\'ruk at Klaxxi\'vess B'),
(1476, 'Cosmetic - Cloud Serpent Hatchling - Pet Battle'),
(1477, 'Cosmetic - Marksman Lann Webbed'),
(1478, 'Cosmetic - See Kaz\'tik in Hub'),
(1479, 'Cosmetic - Hisek the Swarmkeeper In Hub'),
(1480, 'Cosmetic - See Kovok in Hub'),
(1481, 'Cosmetic - Kil\'ruk Well'),
(1482, 'Cosmetic - Ku-Mo at Garrison'),
(1483, 'Cosmetic - Ku-Yao in Kunchong Pit'),
(1484, 'Cosmetic - Ku-Yao at Garrison'),
(1485, 'Cosmetic - Ku Family in Halfhill'),
(1486, 'Cosmetic - See Suspicious Footprints - TEST'),
(1487, 'Roll Club - Serpent\'s Spine'),
(1488, 'Cosmetic - Kil\'ruk Broken Amber'),
(1489, 'Cosmetic - See Kor\'ik in Amberglow'),
(1490, 'Cosmetic - Tiger Temple Flavor NPCs'),
(1491, 'Cosmetic - Valley Gates Opened'),
(1492, 'Cosmetic - Valley Gates NOT Opened'),
(1493, 'Cosmetic - See Mishi - Version 1'),
(1494, 'Cosmetic - See Thunder King\'s Tablet Restored - Final'),
(1495, 'Cosmetic - Malik at Klaxxi\'vess 2'),
(1496, 'Zouchin Village (Phase 1)'),
(1497, 'Cosmetic - In Tents Channeling - Blazecaster Beam'),
(1498, 'Cosmetic - In Tents Channeling - Embercaster Beam'),
(1499, 'Cosmetic - In Tents Channeling - Firespeaker Beam'),
(1500, 'Cosmetic - In Tents Channeling - Pyromancer Beam'),
(1501, 'Cosmetic - See Sage Liao'),
(1502, 'Cosmetic - See Villagers Preparing'),
(1503, 'Theramore Explosion Scene'),
(1504, 'Cosmetic - See Hesik (Version 3)'),
(1505, 'Cosmetic - Tiger Temple Winds'),
(1506, 'Cosmetic - Ten Foot Pole'),
(1507, 'Ten Foot Pole'),
(1508, 'Amberglow Hollow - Silent Beacon'),
(1509, 'Cosmetic - See Dead Ik\'thik Colossus'),
(1510, 'Cosmetic - Recess Mallet'),
(1511, 'Sha of Doubt Scene'),
(1512, 'Cosmetic - See Zer\'ik in Klaxxi\'vess'),
(1513, 'Cosmetic - See Kor\'ik in Klaxxi\'vess'),
(1514, 'Cosmetic - See Kor\'ik in Amberglow - Version 1'),
(1515, 'Cosmetic - See Zer\'ik in Amberglow - Version 1'),
(1516, 'Cosmetic - Amberglow Hollow - Active Beacon - Kor\'ik'),
(1517, 'Cosmetic - Amberglow Hollow - See Kor\'ik Version 1'),
(1518, '"Cosmetic - Master Shang Xi, Air Village"'),
(1519, '"Cosmetic - Elder Shaopai, Air Village"'),
(1520, 'See Zer\'ik - Version 2'),
(1521, 'Manipulator\'s Talisman Received'),
(1522, 'Cosmetic - Malik Broken Amber'),
(1523, 'Cosmetic - Dafeng Vision'),
(1526, '"Cosmetic - Master Shang Xi, Dragon Comp"'),
(1527, '"Cosmetic - Master Shang Xi, Staff Graveyard"'),
(1528, 'Jade Infused Blade Not Received'),
(1529, 'Kafa Press Not Received'),
(1530, 'Ancient Pandaren Woodcutter Not Received'),
(1531, 'Ancient Pandaren Fishing Lure Not Received'),
(1532, 'Cosmetic - Brewmaster Boof in Binan'),
(1533, '"Cosmetic - Lao-Chin, Crossroads, Farwatch Return"'),
(1534, '"Cosmetic - Taran Zhu, Crossroads, Farwatch Return"'),
(1535, '"Cosmetic - Leng, Crossroads"'),
(1536, 'Cosmetic - See Tiny Poop'),
(1537, 'Cosmetic - See Big Poop'),
(1538, 'Cosmetic - Mishi - Alliance'),
(1539, 'Cosmetic - Mishi - Horde'),
(1540, '"Cosmetic - See Blue Baby Serpent 1.0 - 9,000"'),
(1541, '"Cosmetic - See Blue Baby Serpent 1.2 - 11,200"'),
(1542, '"Cosmetic - See Blue Baby Serpent 1.4 - 13,400"'),
(1543, '"Cosmetic - See Blue Baby Serpent 1.6 - 15,600"'),
(1544, '"Cosmetic - See Blue Baby Serpent 1.8 - 17,800"'),
(1545, '"Cosmetic - See Blue Baby Serpent 2.0 - 20,000"'),
(1546, '"Cosmetic - See Blue Adult Serpent 1.0 - 21,000"'),
(1547, '"Cosmetic - See Blue Adult Serpent 1.1 - 23,000"'),
(1548, '"Cosmetic - See Blue Adult Serpent 1.2 - 25,000"'),
(1549, '"Cosmetic - See Blue Adult Serpent 1.3 - 27,000"'),
(1550, '"Cosmetic - See Blue Adult Serpent 1.4 - 29,000"'),
(1551, '"Cosmetic - See Blue Adult Serpent 1.5 - 31,000"'),
(1552, '"Cosmetic - See Blue Adult Serpent 1.6 - 33,000"'),
(1553, '"Cosmetic - See Blue Adult Serpent 1.7 - 35,000"'),
(1554, '"Cosmetic - See Blue Adult Serpent 1.8 - 37,000"'),
(1555, '"Cosmetic - See Blue Adult Serpent 1.9 - 39,000"'),
(1556, '"Cosmetic - See Blue Adult Serpent 2.0 - 40,000"'),
(1557, 'Cosmetic - See Blue Adult Serpent 2.0 - Exalted'),
(1558, '"Cosmetic - See Jade Baby Serpent 1.0 - 9,000"'),
(1559, '"Cosmetic - See Jade Baby Serpent 1.2 - 11,200"'),
(1560, '"Cosmetic - See Jade Baby Serpent 1.4 - 13,400"'),
(1561, '"Cosmetic - See Jade Baby Serpent 1.6 - 15,600"'),
(1562, '"Cosmetic - See Jade Baby Serpent 1.8 - 17,800"'),
(1563, '"Cosmetic - See Jade Baby Serpent 2.0 - 20,000"'),
(1564, '"Cosmetic - See Jade Adult Serpent 1.0 - 21,000"'),
(1565, '"Cosmetic - See Jade Adult Serpent 1.1 - 23,000"'),
(1566, '"Cosmetic - See Jade Adult Serpent 1.2 - 25,000"'),
(1567, '"Cosmetic - See Jade Adult Serpent 1.3 - 27,000"'),
(1568, '"Cosmetic - See Jade Adult Serpent 1.4 - 29,000"'),
(1569, '"Cosmetic - See Jade Adult Serpent 1.5 - 31,000"'),
(1570, '"Cosmetic - See Jade Adult Serpent 1.6 - 33,000"'),
(1571, '"Cosmetic - See Jade Adult Serpent 1.7 - 35,000"'),
(1572, '"Cosmetic - See Jade Adult Serpent 1.8 - 37,000"'),
(1573, '"Cosmetic - See Jade Adult Serpent 1.9 - 39,000"'),
(1574, '"Cosmetic - See Jade Adult Serpent 2.0 - 40,000"'),
(1575, 'Cosmetic - See Jade Adult Serpent 2.0 - Exalted'),
(1576, '"Cosmetic - See Gold Baby Serpent 1.0 - 9,000"'),
(1577, '"Cosmetic - See Gold Baby Serpent 1.2 - 11,200"'),
(1578, '"Cosmetic - See Gold Baby Serpent 1.4 - 13,400"'),
(1579, '"Cosmetic - See Gold Baby Serpent 1.6 - 15,600"'),
(1580, '"Cosmetic - See Gold Baby Serpent 1.8 - 17,800"'),
(1581, '"Cosmetic - See Gold Baby Serpent 2.0 - 20,000"'),
(1582, '"Cosmetic - See Gold Adult Serpent 1.0 - 21,000"'),
(1583, '"Cosmetic - See Gold Adult Serpent 1.1 - 23,000"'),
(1584, '"Cosmetic - See Gold Adult Serpent 1.2 - 25,000"'),
(1585, '"Cosmetic - See Gold Adult Serpent 1.3 - 27,000"'),
(1586, '"Cosmetic - See Gold Adult Serpent 1.4 - 29,000"'),
(1587, '"Cosmetic - See Gold Adult Serpent 1.5 - 31,000"'),
(1588, '"Cosmetic - See Gold Adult Serpent 1.6 - 33,000"'),
(1589, '"Cosmetic - See Gold Adult Serpent 1.7 - 35,000"'),
(1590, '"Cosmetic - See Gold Adult Serpent 1.8 - 37,000"'),
(1591, '"Cosmetic - See Gold Adult Serpent 1.9 - 39,000"'),
(1592, '"Cosmetic - See Gold Adult Serpent 2.0 - 40,000"'),
(1593, 'Cosmetic - See Gold Adult Serpent 2.0 - Exalted'),
(1594, 'Cosmetic - Mishi - Seat of Knowledge'),
(1595, 'Yaungol Boss Scene'),
(1596, 'Cosmetic - Stormcaller 1 Active'),
(1597, 'Cosmetic - Stormcaller 2 Active'),
(1598, 'Cosmetic - Stormcaller 3 Active'),
(1599, 'Cosmetic - Stormcaller 4 Active'),
(1600, 'Cosmetic - Stormcaller 1 Destroyed'),
(1601, 'Cosmetic - Stormcaller 2 Destroyed'),
(1602, 'Cosmetic - Stormcaller 3 Destroyed'),
(1603, 'Cosmetic - Stormcaller 4 Destroyed'),
(1604, 'Klaxxi Finale'),
(1605, 'Cosmetic - See Headless Ik in Klaxxi\'va'),
(1606, 'Celestial Gate Scene'),
(1607, 'Cosmetic - Kun-Lai Summit - On Eastwind Rest'),
(1608, 'Cosmetic - Kun-Lai Summit - Eastwind -> Challenge'),
(1611, 'Cosmetic - See Mishi on Isle of Reckoning'),
(1612, 'Cosmetic - Kun-Lai Summit - On Westwind Rest'),
(1613, 'Cosmetic - Kun-Lai Summit - Westwind -> Challenge'),
(1614, '"Cosmetic - Lao, Cage Rescue"'),
(1615, 'Cosmetic - See Instructor Windblade 1'),
(1616, 'Cosmetic - See Instructor Windblade 2'),
(1617, 'Cosmetic - Dread Wastes - On Pheromone Mine Quest'),
(1618, 'Cosmetic - See Summoned Hisek (Version 1)'),
(1619, 'See Zer\'ik - Version 2 - Alternate'),
(1620, 'Kun-Lai Summit: North Gate Pre-Opening'),
(1621, 'Jade Forest - Strongarm Airstrip - Alliance-Held'),
(1622, 'Cosmetic - Jade Forest - Strongarm Airstrip - Alliance Flags'),
(1623, 'Cosmetic - Patrick Burke'),
(1624, 'Cosmetic - See Zhang Yue'),
(1632, 'Cosmetic - Leven'),
(1633, 'Cosmetic - Anji'),
(1634, 'Cosmetic - Che'),
(1635, 'Cosmetic - He'),
(1636, 'Cosmetic - Kun'),
(1637, 'Cosmetic - Ren'),
(1638, 'Cosmetic - Rook'),
(1639, 'Cosmetic - Sun'),
(1641, 'Cosmetic - He'),
(1645, 'Cosmetic - Ren'),
(1646, 'Cosmetic - He'),
(1647, 'Cosmetic - Ren'),
(1648, 'Cosmetic - Leven'),
(1649, 'Cosmetic - Rook'),
(1650, 'Cosmetic - Sun'),
(1651, 'Cosmetic - Anji'),
(1652, 'Cosmetic - Kun'),
(1653, 'Cosmetic - Anji'),
(1654, 'Cosmetic - Kun'),
(1655, 'Cosmetic - Leven'),
(1656, 'Cosmetic - Che'),
(1657, 'Cosmetic - Rook'),
(1658, 'Cosmetic - Sun'),
(1659, 'Cosmetic - Klaxxi\'va Pre-Finale'),
(1660, 'Cosmetic - Deathknell - Lilian in Graveyard'),
(1661, 'Cosmetic - Deathknell - Marshal in Graveyard'),
(1662, 'Cosmetic - Deathknell - Valdred in Graveyard'),
(1663, 'Orgrimmar Gunship'),
(1664, 'Horde Gunship - Intact - Shooting Gallery'),
(1666, 'Alliance Arrival - Garrosh\'ar Point - Horde Alive'),
(1668, 'Alliance Arrival - Garrosh\'ar Point - Horde Dead'),
(1669, 'Cosmetic Phase - See Sprinkler 1 Keg'),
(1670, 'Cosmetic Phase - See Sprinkler 2 Keg'),
(1671, 'Fighting Disarm Boss'),
(1672, 'Cosmetic - See Teng Thundermalt @ Village 1'),
(1673, 'Cosmetic - See Teng Thundermalt @ Village 2'),
(1674, 'Cosmetic - See Teng Thundermalt @ Beach'),
(1675, 'Fighting Snare Boss'),
(1676, 'Fighting Touch of Death Boss'),
(1677, 'Fighting Roll Boss'),
(1678, 'Fighting Lightning Boss'),
(1679, 'Fighting Stun Boss'),
(1680, 'Fighting Interrupt Boss'),
(1683, 'Horde Gunship - Intact - Ground Assault'),
(1684, 'Jade Forest - Paw\'don Village - Doors Open'),
(1685, 'Cosmetic - Jade Forest - Paw\'don Village - Doors Closed'),
(1686, 'Stormwind - 5.0 Phased Terrain Master'),
(1687, 'See Rell Nightwind'),
(1688, 'Cosmetic - Twinspire - Munitions'),
(1689, 'Cosmetic - Twinspire - Demolishers Intact'),
(1690, 'Cosmetic - Twinspire - Imps Imprisoned'),
(1691, 'Cosmetic - Twinspire - Beholder Imprisoned'),
(1692, 'Cosmetic - Twinspire - Munitions Destroyed'),
(1693, 'Cosmetic - Twinspire - Demolishers Destroyed'),
(1695, 'Cosmetic - Twinspire - Beholder Free'),
(1697, 'Cosmetic - Wrathion\'s Agents'),
(1698, 'Cosmetic - Garrosh\'ar Point - Barricade 1'),
(1699, 'Cosmetic - Garrosh\'ar Point - Barricade 2'),
(1700, 'Alliance Arrival - Garrosh\'ar Point - Bombing Run'),
(1701, 'Cosmetic - Jade Forest - Nazgrim - 01'),
(1702, 'Cosmetic - Garrosh\'ar Point - Ga\'trul'),
(1703, 'Cosmetic - Garrosh\'ar Point - Rell'),
(1704, 'Cosmetic - See Mishi in Zouchin'),
(1705, 'Cosmetic - Horde - See Portal to Pandaria'),
(1706, 'Cosmetic - Stormwind - Can See Portal to Paw\'Don'),
(1708, 'Cosmetic - Spawned Player Gyrocopter'),
(1709, 'Cosmetic - Paw\'don Village - Mishka'),
(1710, 'Cosmetic - Paw\'don Village - Rell'),
(1711, 'Cosmetic - Paw\'don Village - Taran Zhu at Fountain'),
(1712, 'Cosmetic - Paw\'don Village - Taran Zhu at Gate'),
(1713, 'Cosmetic - Paw\'don Village - Mayor at Gate'),
(1714, 'Cosmetic - The Wandering Isle - Jade Tiger Pillar (ELM)'),
(1715, 'Cosmetic - See Barricade 1'),
(1716, 'Cosmetic - See Barricade 2'),
(1717, 'Cosmetic - See Barricade 3'),
(1718, 'Cosmetic - See Barricade Bunny 2'),
(1719, 'Cosmetic - See Barricade Bunny 1'),
(1720, 'Cosmetic - See Barricade Bunny 3'),
(1721, 'Theramore - Post Scenario (Intact)'),
(1722, 'Cosmetic - Jade Forest - Twinspire Keep - See Rell'),
(1723, 'Cosmetic - Jade Forest - Taylor Sick'),
(1724, 'Cosmetic - Jade Forest - Taylor Healthy'),
(1725, 'Ga\'trul Completion'),
(1726, 'Cosmetic - See Alliance Supplies at Pearlfin'),
(1727, 'Cosmetic - Jade Forest - Glassfin Village Gunship'),
(1728, 'Cosmetic - See Nazgrim in Thunder Hold'),
(1729, '"Cosmetic - Gunship Turret, Left"'),
(1730, '"Cosmetic - Gunship Turret, Middle"'),
(1731, '"Cosmetic - Gunship Turret, Right"'),
(1732, 'Cosmetic - Nook of Konk - Zin'),
(1733, 'Cosmetic - Nook of Konk - Nazgrim'),
(1734, 'Cosmetic - Nook of Konk - Gorrok'),
(1735, 'Cosmetic - Nook of Konk - Shokia'),
(1736, 'Cosmetic - Nook of Konk - Rivett'),
(1737, 'Cosmetic - Nook of Konk - Kiryn'),
(1738, 'Cosmetic - Jade Forest - Nook of Konk - Konk\'s Corpse'),
(1739, 'Naval Finale Cinematic'),
(1740, 'Alliance Intro Scene - Pandaria'),
(1741, 'Cosmetic Phase - See Master Plow'),
(1742, 'Cosmetic - Halfhill Market NPCs'),
(1743, 'Fighting Capper Boss'),
(1744, 'On Capper Quest'),
(1745, 'On Capper Quest Not Fighting Boss'),
(1746, '"Cosmetic - Taoshi, Ring-Worm Backup"'),
(1747, 'Cosmetic - Anji'),
(1748, 'Cosmetic - Kun'),
(1749, 'Klaxxi Klimaxxi'),
(1750, 'Cosmetic Phase - See Dented Shovel'),
(1751, 'Cosmetic - Townlong Steppes - Claw of Anger'),
(1752, 'Cosmetic - Horde Gunship - Intact - Captain Doren'),
(1753, 'Cosmetic - Horde Gunship - Intact - Doren Gyrocopter'),
(1754, 'Cosmetic - Upgrade - See Nice Furniture'),
(1755, 'Cosmetic - Upgrade - See Crappy Furniture'),
(1756, 'Cosmetic - See Ellie Honeypaw with Stick'),
(1757, 'Cosmetic - See Ellie Honeypaw without Stick'),
(1758, 'See Wreckage'),
(1759, 'Cosmetic - Dread Wastes - Clutches of Shek\'zeer - Malik'),
(1761, 'Cosmetic - See Incense 1'),
(1762, 'Cosmetic - See Incense 2'),
(1763, 'Cosmetic - See Incense 3'),
(1764, 'Cosmetic - See Incense 4'),
(1765, 'Cosmetic - See Incense 5'),
(1766, 'Cosmetic - See Incense 6'),
(1767, '"Cosmetic - Nazgrim, Horde Gunship"'),
(1768, 'Cosmetic - See Kai-Lin without Kiryn'),
(1769, 'Cosmetic - See Kai-Lin with Kiryn'),
(1770, 'Cosmetic - See Crash Survivors in Village - Gorrok'),
(1771, 'Cosmetic - See Crash Survivors in Village - Shokia'),
(1772, 'Cosmetic - See Priorities Completion'),
(1773, 'Cosmetic - Horde Gunship - Crashed - Taran Zhu Transition'),
(1774, 'Cosmetic - See Tillers Shrine - Questgiver'),
(1775, 'Cosmetic - See Tillers Shrine - Doodad'),
(1776, 'Not On Tour'),
(1777, 'Cosmetic - See Kiryn on Ground'),
(1778, 'Cosmetic - See Stationary Gi-Oh'),
(1779, 'Jade Forest - Strongarm Airstrip - Horde-Held'),
(1780, 'Cosmetic - Ally Gunship Bombing NPCs'),
(1781, 'Hidden Transport Phase'),
(1782, 'Cosmetic - Horde Gunship - Crashed - Nazgrim Transition'),
(1783, 'Cosmetic - See Mishka Kneeling'),
(1785, 'Cosmetic - Nazgrim\'s Kor\'kron'),
(1786, 'Thereamore Scenario - Intact'),
(1787, 'Cosmetic - Paratroopers for Rogers Speech'),
(1788, 'Cosmetic - See Large Barricades'),
(1789, 'Cosmetic - See Spawned Rogers on Skyfire'),
(1790, 'Cosmetic - Jade Forest - Strongarm Airstrip - Alliance Copters'),
(1791, 'Cosmetic - Jade Forest - Strongarm Airstrip - Horde Flags'),
(1792, 'Cosmetic - See Paw\'don Gunship Teleporter'),
(1793, 'Cosmetic - See Taran Zhu in Honeydew'),
(1794, 'Cosmetic Phase - Ju Lien Fishing'),
(1795, 'Cosmetic - See Teleporter @ Garroshar'),
(1796, 'Cosmetic - See West Hall Rubble'),
(1797, 'Psycho Mantid - Adjunct Kree\'zot Alive'),
(1798, 'Klaxxi Daily Bug Rampage'),
(1799, 'Cosmetic - Jade Forest - Glassfin Village Gunship Talkers'),
(1800, 'Cosmetic - Soggy near Arie'),
(1801, 'Cosmetic - Jiao'),
(1802, 'Cosmetic - See Tiny Kovok'),
(1803, 'Cosmetic - See Big Kovok'),
(1804, 'Cosmetic - Wrathion\'s Agents (Stoneplow)'),
(1805, 'Cosmetic - Blacksoil in Town'),
(1806, 'Cosmetic - Greentill in Town'),
(1807, '"Cosmetic - Marlfur Back at Home, Scroll"'),
(1808, 'Cosmetic - Marlfur Start at Home'),
(1809, 'Not Fighting Disarm Boss'),
(1810, 'Not Fighting Snare Boss'),
(1811, 'Not Fighting Touch of Death Boss'),
(1812, 'Not Fighting Roll Boss'),
(1813, 'Not Fighting  Lightning Boss'),
(1814, 'Not Fighting Stun Boss'),
(1815, 'Not Fighting Interrupt Boss'),
(1816, 'Cosmetic - Twinspire - Rell\'s Gyrocopter'),
(1817, 'Cosmetic - The Spring Drifter'),
(1818, 'Cosmetic - See Stationary Rocks'),
(1819, 'Cosmetic - See Anduin in Stormwind'),
(1820, 'Cosmetic - Malik\'s Spear'),
(1821, 'Cosmetic - See Nimm Codejack'),
(1822, 'Cosmetic - Rik\'kal Props on Zan\'ves'),
(1823, 'Cosmetic - Messenger Grummles'),
(1824, 'Cosmetic - Messenger Grummles'),
(1825, 'Cosmetic - Klaxxi\'vess Exalted Door'),
(1826, 'Cosmetic - Leza\'s Totem'),
(1827, '"Cosmetic - Water Spirit, Farmlands"'),
(1828, 'Cosmetic - Psycho Mantid - Tik Wounded'),
(1829, 'Battle Pet Stadium'),
(1830, 'Cosmetic - Brewery Doors'),
(1831, 'Cosmetic - Chen/Li Li Post Trip'),
(1832, 'Cosmetic - Chen/Li Li Pre Trip'),
(1833, 'Cosmetic - Mudmug at Mudmug\'s'),
(1834, 'Cosmetic - Li Li Alone'),
(1835, '"Cosmetic - Ji Firepaw, Forest Horde Camp"'),
(1836, 'Cosmetic - Chamber of Wind Effects'),
(1837, 'Player Farm - Horde Phase 1'),
(1838, 'Player Farm - Horde Phase 2'),
(1839, 'Player Farm - Horde Phase 3'),
(1840, 'Player Farm - Horde Phase 4'),
(1841, 'Player Farm - Horde Phase 5'),
(1842, 'Player Farm - Horde Phase 6'),
(1843, 'Player Farm - Horde Phase 7'),
(1844, 'Player Farm - Horde Phase 8'),
(1845, 'Player Farm - Horde Phase 9'),
(1846, 'Player Farm - Horde Phase 10'),
(1847, 'Player Farm - Horde Phase 11'),
(1848, 'Player Farm - Horde Phase 12'),
(1849, 'Player Farm - Horde Phase 13'),
(1850, 'Player Farm - Horde Phase 14'),
(1851, 'Player Farm - Horde Phase 15'),
(1852, 'Player Farm - Alliance Phase 1'),
(1853, 'Player Farm - Alliance Phase 2'),
(1854, 'Player Farm - Alliance Phase 3'),
(1855, 'Player Farm - Alliance Phase 4'),
(1856, 'Player Farm - Alliance Phase 5'),
(1857, 'Player Farm - Alliance Phase 6'),
(1858, 'Player Farm - Alliance Phase 7'),
(1859, 'Player Farm - Alliance Phase 8'),
(1860, 'Player Farm - Alliance Phase 9'),
(1861, 'Player Farm - Alliance Phase 10'),
(1862, 'Player Farm - Alliance Phase 11'),
(1863, 'Player Farm - Alliance Phase 12'),
(1864, 'Player Farm - Alliance Phase 13'),
(1865, 'Player Farm - Alliance Phase 14'),
(1866, 'Player Farm - Alliance Phase 15'),
(1867, 'Cosmetic - Hellscream\'s Fist Spawns'),
(1868, 'Cosmetic - See Zin\'jun in Ascent'),
(1869, 'Cosmetic - See Naz\'grim at Wreck'),
(1870, 'Cosmetic - Goblin Fishing Raft'),
(1871, 'Jade Dragon Intact (Creatures)'),
(1872, 'Cosmetic - Rell Visible 1 (Garrosh\'ar Point)'),
(1873, 'Cosmetic - Rell Visible 2 (Docks)'),
(1874, 'Cosmetic - Klaxxi\'vess Closed Door'),
(1875, 'Cosmetic - Zouchin Village - Finale'),
(1876, 'Cosmetic - Zhu\'s Watch - Sad Yun and Sunni'),
(1877, 'Cosmetic - Zhu\'s Watch - Yun and Sunni Cured'),
(1878, 'Cosmetic - See Grown Kovok in Hub'),
(1879, 'Cosmetic - Paragon 09 - Broken Amber'),
(1880, 'Cosmetic - Kung Fu Guys in Paoquan'),
(1881, 'Cosmetic - Xiao at Pang\'s'),
(1882, 'Cosmetic - Kang in Basecamp'),
(1883, 'Cosmetic - Conclusion Kang in Dawnchaser Retreat'),
(1884, 'Cosmetic - Unsafe Passage Questgiver'),
(1885, 'Cosmetic - Hot Air Balloon'),
(1886, 'Cosmetic - Koro at Crane Wing Refuge'),
(1887, 'Cosmetic - See Anduin in Refuge'),
(1888, 'Cosmetic - Burlap Waystation Complete'),
(1889, 'Cosmetic - See Anduin by Snakes'),
(1890, 'Cosmetic - The Mariner\'s Revenge - Spawned Boat'),
(1891, 'Cosmetic - See Dog in Pen'),
(1892, 'Cosmetic - Rock 1'),
(1893, 'Cosmetic - Rock 2'),
(1894, 'Cosmetic - Rock 3'),
(1895, 'Cosmetic - Rock 4'),
(1896, 'Cosmetic - Rock 5'),
(1897, 'Cosmetic - Rock 6'),
(1898, 'Cosmetic - Rock 7'),
(1899, 'Cosmetic - Rock 8'),
(1900, 'Kiryn\'s Focus'),
(1901, 'Nazgrim\'s Focus'),
(1902, 'Rivett\'s Focus'),
(1903, 'Shokia\'s Focus'),
(1904, 'Mishka\'s Focus'),
(1905, 'Sully\'s Focus'),
(1906, 'Taylor\'s Focus'),
(1907, 'Cosmetic - Foreman Mann'),
(1908, 'Cosmetic - Knucklethump Hole - See Mok Mok'),
(1909, 'Cosmetic - Knucklethump (See Yakshoe)'),
(1910, 'Cosmetic - Lorewalker Cho at House'),
(1911, 'The Golden Dream'),
(1912, 'Cosmetic - Lorewalker Cho at Alchemy'),
(1913, 'Cosmetic - Lorewalker Cho at Pagoda'),
(1914, 'Cosmetic - See Rivett in Honeydew Village'),
(1915, 'Cosmetic - See Kiryn in Honeydew Village'),
(1916, 'Cosmetic - See Spawned Rogers at Paw\'don'),
(1918, 'Krasarang - Horde Base Visible'),
(1919, 'Krasarang - Alliance Base Visible'),
(1921, 'Cosmetic - Elder Shu Visible in House'),
(1926, 'Cosmetic - Demolishers (alive)'),
(1927, 'Cosmetic - Demolishers (dead)'),
(1928, 'Cosmetic - See Tiger Meat'),
(1929, 'Cosmetic - See Dead Tiger'),
(1930, 'Cosmetic - See Crane Feathers'),
(1931, 'Cosmetic - See Dead Crane'),
(1932, 'Cosmetic - Wolves (visible)'),
(1933, 'Cosmetic - See Crab Fish'),
(1934, 'Cosmetic - See Dead Crab'),
(1935, 'Cosmetic - Sully visible in Domination Point'),
(1936, 'Mogujia Horde Phase'),
(1937, 'Mogujia Alliance Phase'),
(1938, 'Cosmetic - Goblin Fires (visible)'),
(1942, 'Cosmetic - Domination Point (Horde NPCs)'),
(1943, 'Cosmetic - Valor\'s Edge on Fire'),
(1944, 'Cosmetic - Docks Sentry Ward'),
(1945, 'Cosmetic - Barracks Sentry Ward'),
(1946, 'Cosmetic - Town Hall Sentry Ward'),
(1947, 'Cosmetic - The Defiant on Fire'),
(1950, 'Cosmetic - Alliance Cannons'),
(1952, 'Cosmetic - See Blood Elves @ Ancestral Rise'),
(1955, 'Cosmetic - See Goob'),
(1956, 'Cosmetic - See Goob - Complete'),
(1957, 'Cosmetic - See Pile of Wood - Complete'),
(1958, 'Cosmetic - See Garrosh @ Shrine of Two Moons'),
(1959, 'Cosmetic - Scout-o-Meter'),
(1960, 'Alliance Sha Phase'),
(1961, 'Warlock - Class Quest'),
(1962, 'Cosmetic - Bixy Buzzsaw - Fuel'),
(1963, 'Cosmetic - Bixy Buzzsaw - Iron'),
(1964, 'Cosmetic - Bixy Buzzsaw - Lumber'),
(1965, 'Cosmetic - See Anduin 1 @ Shrine'),
(1966, 'Cosmetic - Binan Village (NOT on Vol\'jin)'),
(1967, 'Cosmetic - Krasarang - No Bases Visible'),
(1968, 'Cosmetic - Binan Village (ON Vol\'jin)'),
(1969, 'Cosmetic - Goblin Hub - Quest Givers'),
(1970, 'Cosmetic - Messenger Grummle 5.1 (Horde)'),
(1971, 'Cosmetic - Aggra in Durotar 5.1'),
(1972, 'Echo Isles 5.1 - Thrall Escort'),
(1973, 'Cosmetic - Thrall in Durotar 5.1'),
(1974, 'Darnassus 5.1: Stealing the Bell'),
(1975, 'Cosmetic - Darnassus 5.1: Divine Bell'),
(1976, 'Cosmetic - Garrosh on Beach'),
(1977, 'Darnassus 5.1: Safety Bubble'),
(1978, 'Cosmetic - Darnassus 5.1: Bubble Sparkles'),
(1979, 'Dalaran 5.1 - Horde Assault Phase (PRK)'),
(1980, 'Cosmetic - Silvermoon 5.1 - Mogu Artifacts'),
(1981, 'Cosmetic - Krasarang - 5.1 Bases Bonus Cosmetic Phase'),
(1982, 'Warlock - Class Quest - Black Temple'),
(1983, 'Cosmetic - The Monkey King at Tiger Temple'),
(1984, 'Hyjal E'),
(1986, 'Cosmetic - Anduin in Valley of the Emperors 1'),
(1988, 'Cosmetic - Anduin in Valley of the Emperors 2'),
(1989, 'Cosmetic - The Monkey King - Unjaded'),
(1992, 'Jade Warlord - Fight'),
(1993, 'Cosmetic - See Tyrande'),
(1994, 'Cosmetic - See Genn'),
(1995, 'Cosmetic - See Nobundo'),
(1996, 'Cosmetic - See Jaina'),
(1997, 'Cosmetic - Mogu Door (closed)'),
(1998, 'Cosmetic - See Varian'),
(1999, 'Cosmetic - See Anduin 2 @ Shrine'),
(2000, 'Barrel Ramp'),
(2001, 'Cosmetic - Krasarang Wilds: JLR - See Valves - Horde'),
(2002, 'Cosmetic - Krasarang Wilds: JLR - See Valves - Alliance'),
(2003, 'Horde Sha Phase'),
(2004, 'Cosmetic - Jaina & Anduin in Dalaran'),
(2005, 'Cosmetic - Portal to the Purple Parlor visible'),
(2006, 'Baine\'s Brew Phase - Horde'),
(2007, 'Cosmetic - Thrall in Echo Isles 1'),
(2008, 'Cosmetic - Echo Isles 5.1 - Thrall in Echo Isles 1'),
(2009, 'Cosmetic - Kor\'kron Soulbreaker'),
(2010, 'Baine\'s Brew Phase - Alliance'),
(2011, 'Cosmetic - See Agent Connelly at Grummle Bazaar'),
(2012, 'Cosmetic - Echo Isles 5.1 - Thrall in Echo Isles 2'),
(2013, 'Alliance - Day 6 - Story Quests - Sabotage the Camp'),
(2014, 'Cosmetic - Echo Isles 5.1 - Aftermath'),
(2015, 'Kun-Lai Summit 5.1 - VoE - Horde Storyline Quests (NLC)'),
(2016, 'Cosmetic - Varian on Beach'),
(2017, 'Cosmetic - Kun-Lai Summit 5.1 - VoE - See Spawned Aenea (NLC)'),
(2018, 'Cosmetic - Kun-Lai Summit 5.1 - VoE - See Spawned Orestes (NLC)'),
(2019, 'Cosmetic - Silvermoon 5.1 - Lor\'theron visible'),
(2020, 'Kun-Lai Summit 5.1 - VoE - Horde Can See Book(NLC)'),
(2021, 'Ruins of Korune - Alliance'),
(2022, 'Ruins of Korune - Horde'),
(2023, 'Cosmetic - Horde Camp - Statue 1'),
(2024, 'Cosmetic - Horde Camp - Statue 2'),
(2025, 'Cosmetic - Horde Camp - Statue 3'),
(2026, 'Shan Kien Defeat Aftermath'),
(2028, 'Cosmetic - Hilda on Beach'),
(2029, 'Cosmetic - Monkey King Duel with Jade Warlord'),
(2030, 'Cosmetic - Monkey King in Lion\'s Landing'),
(2031, 'Cosmetic - Anduin in Lion\'s Landing'),
(2032, '"Cosmetic - See ""To Catch A Spy"" - Actors Set 1"'),
(2033, 'Cosmetic - Hozen King Entourage'),
(2034, 'Cosmetic - See Connelly in Brawlers Guild'),
(2035, 'Cosmetic - Monkey King at Unga Ingoo'),
(2036, '"Cosmetic - 5.1 - ON ""The Head"""'),
(2037, 'Cosmetic - Krasarang Wilds 5.1 - Domination Point - Sunreaver Agent A - PRK'),
(2038, 'Cosmetic - Krasarang Wilds 5.1 - Domination Point - Sunreaver Agent B - PRK'),
(2039, 'Ruins of Korune - Alliance - Completion'),
(2040, 'Dalaran 5.1 - Rommath 01 (Entrance)'),
(2041, 'Dalaran 5.1 - Rommath 02 (Arena)'),
(2042, 'Dalaran 5.1 - Rommath 03 (Black Market)'),
(2043, 'Dalaran 5.1 - Rommath 04 (Ramp)'),
(2044, 'Dalaran 5.1 - Rommath 05 (Center)'),
(2045, 'Cosmetic - See Sarannha'),
(2046, 'Cosmetic - See Sarannha @ Bell'),
(2047, 'Cosmetic - See Ishi @ Bell'),
(2048, 'Cosmetic - See Ishi Outside'),
(2049, 'Ruins of Korune - Horde - Completion'),
(2050, 'Darnassus 5.1: Horde Portal'),
(2051, 'Cosmetic - Chief Ingoo Ingoo'),
(2052, '5.1 Finale - Horde'),
(2053, '5.1 Finale - Alliance'),
(2054, 'Dalaran 5.1 - Alliance Assault Phase (PRK)'),
(2055, 'See Tak-Tak'),
(2056, 'Cosmetic - Silvermoon 5.1 - See Lor\'themar for Post-Dalaran - ZTO'),
(2057, 'Dalaran 5.1 - H - See Uda - PRK'),
(2058, 'Dalaran 5.1 - H - See Savor - PRK'),
(2059, 'Dalaran 5.1 - H - See Hathorel - PRK'),
(2060, 'Dalaran 5.1 - H - See Surdiel - PRK'),
(2061, 'Dalaran 5.1 - H - See Vesara- PRK'),
(2063, 'Darnassus 5.1: Jaina Near Bell'),
(2064, 'Darnassus 5.1: Bodies Near Bell'),
(2065, 'Cosmetic - See Fuel Tank Bunny - Northwestern'),
(2066, 'Cosmetic - See Fuel Tank Bunny - Northern'),
(2067, 'Cosmetic - See Fuel Tank Bunny - Northeastern'),
(2068, 'Cosmetic - See Fuel On Fire - Northwestern'),
(2069, 'Cosmetic - See Fuel On Fire - Northern'),
(2070, 'Cosmetic - See Fuel On Fire - Northeastern'),
(2071, '5.1 Finale - Horde - Completion'),
(2072, 'Jaina & Anduin in Dalaran'),
(2073, 'Cosmetic - Horde Camp - Statue 1 - Alpha'),
(2074, 'Cosmetic - Horde Camp - Statue 2 - Alpha'),
(2075, 'Cosmetic - Horde Camp - Statue 3 - Alpha'),
(2076, 'Cosmetic - Portal to Domination Point'),
(2077, 'Cosmetic - See Alliance Epilogue'),
(2081, '5.1 Finale - Alliance - Completion 1'),
(2082, 'Cosmetic - See Fennie Hornswaggle'),
(2083, 'A Little Patience'),
(2084, 'Cosmetic - Silvermoon 5.1 - See Post-Dalaran Non-Scene actors- ZTO'),
(2085, 'Darnassus 5.1: Jaina'),
(2086, 'Cosmetic - Varian in Lions Landing (post Dalaran)'),
(2087, 'Cosmetic - Jaina in Lion\'s Landing (post-Dalaran)'),
(2090, 'Cosmetic - 7th Legion Champion on Beach'),
(2091, 'Krasarang 5.1 - Alliance Only NPCs Visible'),
(2092, 'Krasarang 5.1 - Horde Only NPCs Visible'),
(2093, 'Cosmetic - Silvermoon 5.1 - Hide non-Scene Actors- ZTO'),
(2094, 'Cosmetic - Kor\'kron Bodyguards on Beach'),
(2095, 'See Garrosh - Horde Completion'),
(2097, 'Cosmetic - The Defiant not on fire'),
(2098, 'Cosmetic - Valor\'s Edge not on fire'),
(2099, '"Cosmetic - See Admiral Taylor, Mishka Questgivers"'),
(2100, 'Cosmetic - See Anduin'),
(2101, 'Cosmetic - Taradormi at Lion\'s Landing'),
(2102, 'Cosmetic - Taradormi at Paw\'don'),
(2104, 'Cosmetic - Player Sees Mishi - Fort Grookin'),
(2105, 'Cosmetic - Player Sees Mishi - Pearlfin'),
(2108, 'Cosmetic - Ally Stygian Scar NPCs'),
(2109, 'Cosmetic - See Scout 1'),
(2110, 'Cosmetic - See Scout 2'),
(2111, 'Cosmetic - See Scout 3 (Alliance)'),
(2112, 'Cosmetic - IotTK - See Magisters'),
(2113, 'Cosmetic - IotTK - See Disabled Construct'),
(2114, 'Cosmetic - IotTK - See Buried Construct'),
(2115, 'Cosmetic - IotTK - See Malfunctioning Construct'),
(2116, 'Cosmetic - IotTK - See Distressed Construct'),
(2117, 'Cosmetic - See Parachutes'),
(2118, 'Cosmetic - Troll Beast Pens - Horde Questgivers Visible'),
(2119, 'Cosmetic - Troll Beast Pens - Alliance Questgivers Visible'),
(2120, 'Cosmetic - See Blue Cauldron'),
(2121, 'Cosmetic - See Purple Cauldron'),
(2122, 'Cosmetic - See Red Cauldron'),
(2123, 'Cosmetic - See Green Cauldron'),
(2124, 'Cosmetic - See Blue Cauldron - Destroyed'),
(2125, 'Cosmetic - See Green Cauldron - Destroyed'),
(2126, 'Cosmetic - See Red Cauldron - Destroyed'),
(2127, 'Cosmetic - See Purple Cauldron - Destroyed'),
(2128, 'Cosmetic - Horde - See Mini Mana Bomb Placement'),
(2129, 'Cosmetic - Planting Bombs - Ships Destroyed'),
(2132, 'Cosmetic - Planting Bombs - Horde - Construct Destroyed'),
(2133, 'Cosmetic - Planting Bombs - Crates Destroyed'),
(2134, 'Cosmetic - See Dragonhawk Enabler'),
(2136, 'Cosmetic - See Sunreaver Scout'),
(2137, 'Cosmetic - See Drill 1 (Intact)'),
(2138, 'Cosmetic - See Drill 1 (Destroyed)'),
(2139, 'Cosmetic - See Drill 2 (Intact)'),
(2140, 'Cosmetic - See Drill 2 (Destroyed)'),
(2141, 'Cosmetic - See Drill 3 (Intact)'),
(2142, 'Cosmetic - See Drill 3 (Destroyed)'),
(2143, 'Cosmetic - Saurok Mountain - Alliance Magisters Visible'),
(2144, 'Cosmetic - Saurok Mountain - Horde Magisters Visible'),
(2145, 'Cosmetic - IotTK - See Buried Construct (Alliance)'),
(2146, 'Cosmetic - Troll War Camp - Horde Questgivers Visible'),
(2147, 'Cosmetic - Troll War Camp - Alliance Questgivers Visible'),
(2148, 'Cosmetic - IotTK - See Disabled Construct - Alliance'),
(2149, 'Cosmetic - IotTK - See Distressed Construct - Alliance'),
(2150, 'Cosmetic - See Silver Covenant Scout'),
(2151, 'Cosmetic - IotTK - See Malfunctioning Construct - Alliance'),
(2152, 'Cosmetic - Trolltonshire Horde'),
(2153, 'Cosmetic - Isle of Thunder - Alliance (Only) Stage 1+'),
(2154, 'Cosmetic - See Scout 1 (Alliance)'),
(2155, 'Cosmetic - See Scout 2 (Alliance)'),
(2156, 'Cosmetic - Broken Golem Visible'),
(2157, 'Cosmetic - See Exalted Actors - Lor\'Themar'),
(2158, 'Cosmetic - Planting Bombs - Alliance - Ships NOT Destroyed'),
(2159, 'Cosmetic - Repaired Golem Visible'),
(2160, 'Mogu Concubines Space'),
(2161, 'Cosmetic - Dawnseeker Promontory - Stage 3+'),
(2162, 'Cosmetic - Horde Camp Extended - Stage 4+'),
(2163, 'Assault on Zeb\'tula Scenario - Zeb\'tula Phased Terrain'),
(2165, 'Cosmetic - See Staff (Alpha) - JLR'),
(2166, 'Cosmetic - Rare Chests'),
(2167, 'Cosmetic - Wild Thunder Pterodactyl Hatchlings'),
(2168, 'Cosmetic - Final Gate Scenario - Lor\'Themar'),
(2169, 'Cosmetic - See Final Staff'),
(2170, 'Cosmetic - See Floating Staff'),
(2171, 'Cosmetic - See Exalted Actors - Jaina'),
(2172, 'Cosmetic - See Exalted Actors - Jaina - Final'),
(2173, 'Cosmetic - Thunderwing (adult)'),
(2174, 'Cosmetic - Thunderwing (Hatchling)'),
(2175, 'Cosmetic - Thunderwing (Medium)'),
(2176, 'Isle of the Thunder King - Phased Terrain (Horde Hub)'),
(2177, 'Isle of the Thunder King - Phased Terrain (Alliance Hub)'),
(2178, 'Assault on Shaol\'mara Scenario - Shaol\'mara Phased Terrain'),
(2179, 'Cosmetic - Horde NPCs - Horde Player Stage 1+ OR Alliance Player Always'),
(2180, 'Cosmetic - Alliance NPCs - Alliance Player Stage 1+ OR Horde Player Always'),
(2181, 'Cosmetic - See Work Orders - Player Farm'),
(2182, 'Cosmetic - Tactical Mana Bomb - Disarm - Horde Ships'),
(2183, 'Cosmetic - Tactical Mana Bomb - Disarm - Horde Crystals'),
(2184, 'Cosmetic - Tactical Mana Bomb - Disarm - Horde Bridge'),
(2185, 'Cosmetic - See Hippogryph Enabler'),
(2186, 'Cosmetic - Final Gate Scenario - Jaina'),
(2187, 'Cosmetic - Thunderwing (Hatchling)'),
(2188, 'Cosmetic - Thunderwing (Medium)'),
(2189, 'Cosmetic - Thunderwing (Adult)'),
(2190, 'Cosmetic - Trolltonshire - Alliance - Cha\'lat\'s Altar Unbroken'),
(2191, 'Cosmetic - Trolltonshire - Horde - Cha\'lat\'s Altar Broken'),
(2192, 'Cosmetic - Trolltonshire - Horde - Cha\'lat\'s Altar Unbroken'),
(2193, 'Cosmetic - Trolltonshire - Alliance - Cha\'lat\'s Altar Broken'),
(2194, 'Cosmetic - Trolltonshire - Horde - Tec\'uat\'s Altar Unbroken'),
(2195, 'Cosmetic - Trolltonshire - Horde - Tec\'uat\'s Altar Broken'),
(2196, 'Cosmetic - Trolltonshire - Alliance - Tec\'uat\'s Altar Broken'),
(2197, 'Cosmetic - Trolltonshire - Alliance - Tec\'uat\'s Altar Unbroken'),
(2198, 'Cosmetic - Trolltonshire - Horde - Pa\'chek\'s Altar Unbroken'),
(2199, 'Cosmetic - Trolltonshire - Alliance - Pa\'chek\'s Altar Unbroken'),
(2200, 'Cosmetic - Trolltonshire - Alliance - Pa\'chek\'s Altar Broken'),
(2201, 'Cosmetic - Trolltonshire - Horde - Pa\'chek\'s Altar Broken'),
(2202, 'Warlock - Class Quest - Completed Green Fire'),
(2205, 'Cosmetic - Forge Door'),
(2206, 'Cosmetic - Forge Door'),
(2207, 'Cosmetic - Shipyard Scenario Breadcrumb Alliance'),
(2208, 'Cosmetic - See Stormy Chest'),
(2209, 'Cosmetic - Planting Bombs - Alliance - Bridge Destroyed'),
(2210, 'Cosmetic - Planting Bombs - Alliance - Crystals Destroyed'),
(2211, 'Cosmetic - Planting Bombs - Alliance - Ships Destroyed'),
(2212, 'Cosmetic - Wrathion at Forge'),
(2213, 'Wall Explosion Scene'),
(2214, 'Cosmetic - Farmer Yoon State 4'),
(2215, 'Cosmetic - See Scout 3'),
(2216, 'Cosmetic - Shipyard Scenario Breadcrumb Horde'),
(2217, 'Cosmetic - Stormsea Landing Mage Day'),
(2218, 'Cosmetic - Stormsea Landing Beastcaller Day'),
(2219, 'Isle of the Thunder King - See Dalaran Tower'),
(2220, 'Isle of the Thunder King - See Sunwell'),
(2221, '5.2 Legendary Scenario Not Active'),
(2222, 'Cosmetic - Horde Portal - Horde Player Stage 1+ OR Alliance Player Always'),
(2223, 'Cosmetic - See Stationary Lor\'themar on Boat'),
(2224, 'Cosmetic - Horde Portal - Horde Player Stage 0'),
(2225, 'Cosmetic - See Elsia in Townlong'),
(2226, 'Cosmetic - Alliance Portal - Alliance Player Stage 0'),
(2227, 'Cosmetic - Alliance Portal - Alliance Player Stage 1+ OR Horde Player Always'),
(2228, 'Cosmetic - See Stationary Aethas - Final'),
(2229, 'Cosmetic - See Stationary Aethas - Start'),
(2230, 'Cosmetic - See Vereesa in Townlong'),
(2231, 'Cosmetic - See Stationary Jaina on Boat'),
(2232, 'Cosmetic - Saurok Mountain - Horde Inner Questgivers Visible'),
(2233, 'Cosmetic - Saurok Mountain - Alliance Inner Questgivers Visible'),
(2234, 'Cosmetic - Troll Town - Alliance Beach Questgivers Visible'),
(2235, 'Cosmetic - Troll Town - Alliance Inner Questgivers Visible'),
(2236, 'Cosmetic - Troll Town - Horde Inner Questgivers Visible'),
(2237, 'Cosmetic - See Stationary Elemental - Final'),
(2238, 'Cosmetic - Saurok Caves - Alliance Beach Questgivers Visible'),
(2239, 'Cosmetic - Mogu Graveyard - Alliance Inner Questgivers Visible'),
(2240, 'Cosmetic - Mogu Graveyard - Horde Beach Questgivers Visible'),
(2241, 'Cosmetic - Mogu Graveyard - Horde Inner Questgivers Visible'),
(2242, 'Cosmetic - Troll Town - Alliance Hub Questgivers Visible'),
(2243, 'Cosmetic - Saurok Caves - Alliance Hub Questgivers Visible'),
(2244, 'Cosmetic - Mogu Graveyard - Alliance Hub Questgivers Visible'),
(2245, 'Cosmetic - Mogu Graveyard - Horde Hub Questgivers Visible'),
(2246, 'Cosmetic - Saurok Caves - Horde Hub Questgivers Visible'),
(2247, 'Cosmetic - Troll Town - Horde Hub Questgivers Visible'),
(2248, 'Cosmetic - Troll Town - Horde Hub Questgivers NOT Visible'),
(2249, 'Cosmetic - Saurok Caves - Horde Hub Questgivers NOT Visible'),
(2250, 'Cosmetic - Mogu Graveyard - Horde Hub Questgivers NOT Visible'),
(2251, 'Cosmetic - Troll Town - Alliance Hub Questgivers NOT Visible'),
(2252, 'Cosmetic - Saurok Caves - Alliance Hub Questgivers NOT Visible'),
(2253, 'Cosmetic - Mogu Graveyard - Alliance Hub Questgivers NOT Visible'),
(2254, 'Cosmetic - See Alliance Turn-In Scout (Stg3+)'),
(2255, 'Cosmetic - See Horde Turn-In Scout (Stg3+)'),
(2256, 'Cosmetic - See Exalted Actors - Aethas'),
(2257, 'Cosmetic - See PvE vs. PvP choice'),
(2259, 'Cosmetic - See PvE vs. PvP choice'),
(2262, 'Cosmetic - See Thunderwing'),
(2263, 'Cosmetic - Alliance Portal Guards'),
(2264, 'Cosmetic - Horde Portal Guards'),
(2265, 'Cosmetic - See Taoshi Crossing Start'),
(2266, 'Cosmetic - See Taoshi Stage 1'),
(2267, 'Cosmetic - Stage 4+'),
(2268, 'Cosmetic - See Priorities Completion (Alliance)'),
(2269, 'Cosmetic - Isle of Thunder - Stage 4+'),
(2270, 'Cosmetic - See Alliance Turn-In Scout (Stg 3)'),
(2271, 'Cosmetic - See Horde Turn-In Scout (Stg3)'),
(2272, 'Cosmetic - See Gorrok'),
(2273, 'Warlock - Class Quest - Jubeka\'s Mark'),
(2274, 'Marcio\'s Test Phase'),
(2275, 'PattyMack - Test Personal'),
(2279, 'Frostwind - Cosmetic - Test - Wolf Den - See Wolf to Exiles'),
(2280, 'Frostwind - Cosmetic - Test - Exile Camp - See Wolf to Canyon'),
(2281, 'Cosmetic - Legendary 5.3 - Wrathion Outside Jade Temple - JSB'),
(2282, 'Durotar 5.3 - Battle of Sen\'jin Village - DEPRECATED'),
(2283, 'Legendary Jade Temple'),
(2284, 'Cosmetic - Razor Hill - Kor\'kron Occupied'),
(2285, 'Cosmetic - Razor Hill - Darkspear Occupied'),
(2286, 'Legendary Jade Temple'),
(2287, 'Legendary Jade Temple - Combat Phase 01'),
(2288, 'Legendary Jade Temple - Combat Phase 02'),
(2289, 'Legendary Jade Temple - Combat Phase 03'),
(2290, 'Legendary Jade Temple - Combat Phase 04'),
(2291, 'Legendary Jade Temple - Combat Phase 05'),
(2292, 'Legendary Jade Temple - Combat Phase 06'),
(2293, 'Legendary Jade Temple - Combat Phase 07'),
(2294, 'Legendary Jade Temple - Combat Phase 08'),
(2295, 'Legendary Jade Temple - Combat Phase 09'),
(2296, 'Legendary Jade Temple - Combat Phase 10'),
(2297, 'Durotar 5.3 - Battle of Razor Hill'),
(2298, 'Cosmetic - 5.3 - See Quest Givers in Durotar - JLR'),
(2299, 'Cosmetic - Taran Zhu Visible'),
(2300, 'Cosmetic - Dezco Visible'),
(2306, 'Legendary Tiger Temple - Combat Phase 04'),
(2307, 'Legendary Tiger Temple - Combat Phase 05'),
(2308, 'Legendary Tiger Temple - Combat Phase 06'),
(2309, 'Legendary Tiger Temple - Combat Phase 07'),
(2310, 'Legendary Tiger Temple - Combat Phase 08'),
(2311, 'Legendary Tiger Temple - Combat Phase 09'),
(2312, 'Legendary Tiger Temple - Combat Phase 10'),
(2317, 'Legendary Tiger Temple'),
(2319, 'Cosmetic - Legendary 5.3 - Wrathion Spawn - Tiger Temple - JSB'),
(2321, 'Legendary Tiger Temple - Combat Phase 01'),
(2322, 'Legendary Tiger Temple - Combat Phase 02'),
(2323, 'Legendary Tiger Temple - Combat Phase 03'),
(2324, 'Legendary Ox Temple'),
(2325, 'Cosmetic - Legendary 5.3 - Wrathion Spawn - Ox Temple - JSB'),
(2326, 'Legendary Ox Temple - Combat Phase 01'),
(2327, 'Legendary Ox Temple - Combat Phase 02'),
(2328, 'Legendary Ox Temple - Combat Phase 03'),
(2329, 'Cosmetic - See Stationary Vol\'jin'),
(2330, 'Legendary Ox Temple - Combat Phase 04'),
(2331, 'Legendary Ox Temple - Combat Phase 05'),
(2332, 'Legendary Ox Temple - Combat Phase 06'),
(2333, 'Legendary Ox Temple - Combat Phase 07'),
(2334, 'Legendary Ox Temple - Combat Phase 08'),
(2335, 'Legendary Ox Temple - Combat Phase 09'),
(2336, 'Legendary Ox Temple - Combat Phase 10'),
(2337, 'Legendary Crane Temple'),
(2338, 'Cosmetic - Legendary 5.3 - Wrathion Spawn - Crane Temple - JSB'),
(2339, 'Legendary Crane Temple - Combat Phase 01'),
(2340, 'Legendary Crane Temple - Combat Phase 02'),
(2341, 'Legendary Crane Temple - Combat Phase 03'),
(2342, 'Legendary Crane Temple - Combat Phase 04'),
(2343, 'Legendary Crane Temple - Combat Phase 05'),
(2344, 'Legendary Crane Temple - Combat Phase 06'),
(2345, 'Legendary Crane Temple - Combat Phase 07'),
(2346, 'Legendary Crane Temple - Combat Phase 08'),
(2347, 'Legendary Crane Temple - Combat Phase 09'),
(2348, 'Legendary Crane Temple - Combat Phase 10'),
(2349, 'Cosmetic - Durotar 5.3 - Sen\'jin Village Questgivers'),
(2350, 'Path of the Last Emperor'),
(2351, 'Cosmetic - Durotar 5.3 - Alliance in Dranosh\'ar'),
(2352, 'Cosmetic - Seer Hao Pham Roo Seeker\'s Point'),
(2353, 'Cosmetic - Seer Hao Pham Roo Start'),
(2354, 'Cosmetic - Durotar 5.3 - Sen\'jin Village Normal'),
(2355, 'Cosmetic - Durotar 5.3 - Sen\'jin Village - Jhash'),
(2356, 'Cosmetic - See Stationary Baine'),
(2357, 'Cosmetic - Razor Hill - Darkspear Occupied OR Battle of Razor Hill'),
(2358, 'Cosmetic - Razor Hill - Baine'),
(2359, 'Cosmetic - Kor\'kron Command Posts - visible'),
(2360, 'Cosmetic - Operation: Darkspear Destruction - visible'),
(2361, 'Cosmetic - Kor\'kron Supply Lines - visible'),
(2362, 'Cosmetic - Durotar 5.3 - Sen\'jin Village - Pre-Battle'),
(2363, 'Cosmetic - Player Sees Boots in Camp'),
(2364, 'Cosmetic - Durotar 5.3 - Sen\'jin Village - Pre-Battle (post war)'),
(2365, 'Cosmetic - See Master Gadrin'),
(2366, 'Cosmetic - See Zen\'tabra'),
(2367, 'Cosmetic - See Zen\'tabra in Cage'),
(2368, 'Cosmetic - Durotar 5.3 - Battle of Sen\'jin Village Vol\'jin'),
(2369, 'Cosmetic - Durotar 5.3 - Sen\'jin Village Post-Battle'),
(2370, 'Cosmetic - Northern Barrens - Horde Caravans'),
(2371, 'Cosmetic - Northern Barrens - Alliance Caravans'),
(2374, 'Cosmetic - VoeB - Big Blossom - Alive'),
(2375, 'Cosmetic - VoeB - Big Blossom - Dead'),
(2376, 'Cosmetic - See Player Clone in Bubble'),
(2377, 'Cosmetic - Legendary 5.3 - Wrathion Spawn - Mason\'s Folly - JSB'),
(2378, 'Cosmetic - See Ki\'Ta - Final'),
(2379, 'Cosmetic - Rope Anchor A Gears'),
(2380, 'Cosmetic - Rope Anchor B Gears'),
(2381, 'Cosmetic - Rope Anchor C Gears'),
(2382, 'Cosmetic - Rope Anchor D Gears'),
(2383, 'Cosmetic - Rope Anchor E Gears'),
(2384, 'Cosmetic - Razor Hill - Alliance-Only Flavor'),
(2385, 'Cosmetic - Soggy in House'),
(2386, 'Cosmetic - Legendary 5.3 - Wrathion Spawn - Jade Temple - JSB'),
(2387, 'Warlock - Class Quest - Black Temple & Plunder'),
(2388, 'Cosmetic - Taxi - Exile Camp -> Canyon'),
(2391, 'Cosmetic - Kolloc Trash'),
(2392, 'Personal - Kolloc Boss Fight'),
(2394, 'Cosmetic - Vragor at Scorpar Cave'),
(2395, 'Cosmetic - Urtok Defeated'),
(2396, 'Cosmetic - See Supplies On Fire - Frostwind'),
(2397, 'Cosmetic - See Harpoons On Fire - Frostwind'),
(2398, 'Cosmetic - See Supplies Bunny - Frostwind'),
(2399, 'Cosmetic - See Harpoon Bunny - Frostwind'),
(2401, 'Cosmetic - Ga\'nar\'s Spear (Chest)'),
(2402, 'Cosmetic - Ga\'nar\'s Spear (Summon)'),
(2403, 'Cosmetic - Frostwolf Traveler\'s Pack'),
(2404, 'Cosmetic - Frostwolf Axe'),
(2405, 'Cosmetic - Frostwolf Collar'),
(2406, 'Cosmetic - See Durotan at Coliseum'),
(2407, 'Personal - Kor\'scrage Encounter'),
(2409, 'Scorpar Gulch - Aberration Fight Phase'),
(2410, 'Scorpar Gulch - Arrival Phase'),
(2411, 'Cosmetic - Translucent Clefthoof Meat'),
(2412, 'Cosmetic - Opaque Clefthoof Meat'),
(2413, 'Cosmetic - Scorpar Gulch - See Frostwolf Axe'),
(2414, 'Cosmetic - Urtok Not Defeated'),
(2415, 'Cosmetic - Scorpar Gulch - See Vragor at Altar'),
(2416, 'Cosmetic - Scorpar Gulch - See Vragor Mounted'),
(2418, 'Cosmetic - Exile Camp - See Vragor at Camp'),
(2419, 'Cosmetic - See Vragor at Exile Camp'),
(2420, 'Cosmetic - See Ga\'nar at Exile Camp'),
(2421, 'Cosmetic - Scorpar Gulch - See Vragor at Scorpar Entrance'),
(2422, 'Cosmetic - Ga\'nar Mounted (Across the Dunes)'),
(2423, 'Cosmetic - Vragor Mounted (Across the Dunes)'),
(2424, 'Cosmetic - Ga\'nar at Canyon (Lines in the Sand)'),
(2425, 'Cosmetic - Vragor at Canyon (Lines in the Sand)'),
(2426, 'Cosmetic - Taxi Flavor Spawns (DLA)'),
(2427, 'The Spirit Cave'),
(2428, 'Cosmetic - The Spirit Cave - Tomb Static'),
(2429, 'Cosmetic - Frostwolves for Feeding'),
(2430, 'Cosmetic - See Ga\'nar at Exile Camp 2'),
(2431, 'Kolloc Boss Fight - Wrap Up'),
(2432, 'Blightstone Quarry - Intro'),
(2433, 'Cosmetic - See Feather Fall Platforms'),
(2436, 'Ghost Pirate Cave Aftermath'),
(2437, 'Cosmetic - Ghost Pirate Treasure Chest (Spectral)'),
(2438, 'Cosmetic - Ghost Pirate Treasure Chest'),
(2439, 'Dungeon Encounter 3'),
(2440, 'Dungeon Encounter 4'),
(2441, 'Dungeon Encounter 5'),
(2442, 'Cosmetic - See Jaluu (Alliance)'),
(2443, 'Cosmetic - See Jaluu (Horde)'),
(2444, 'Personal - Draka Intro'),
(2445, 'Cosmetic - Farseer\'s Rock - Draka Pre-Intro'),
(2446, 'Cosmetic - Draka Post-Intro'),
(2447, 'Cosmetic - Draka - Land of Giants'),
(2448, 'Cosmetic - Drek\'Thar - Ice Forges'),
(2449, 'Cosmetic - Draka - The Ascent'),
(2450, 'Cosmetic - Draka - The Ancient of Frostfire'),
(2451, 'Cosmetic - Frostfire Prison Visible'),
(2452, 'Cosmetic - Draka & Drek\'thar at the First Anvil'),
(2458, 'Cosmetic - Ahura in Field'),
(2459, 'Cosmetic - Huugo in Field'),
(2460, 'Cosmetic - Maloof in Field'),
(2461, 'Cosmetic - Ahura in Center'),
(2462, 'Cosmetic - Huugo in Center'),
(2463, 'Cosmetic - Maloof in Center'),
(2464, 'Cosmetic - Akama Iron March A - PRK'),
(2465, 'Cosmetic - Ahura Iron March A - PRK'),
(2466, 'Cosmetic - Huugo Iron March A - PRK'),
(2467, 'Cosmetic - Maloof Iron March A - PRK'),
(2468, 'Cosmetic - Akama Iron March B - PRK'),
(2469, 'Cosmetic - Ahura Iron March B - PRK'),
(2470, 'Cosmetic - Huugo Iron March B - PRK'),
(2471, 'Cosmetic - Akama Iron March C - PRK'),
(2472, 'Cosmetic - Huugo Iron March C - PRK'),
(2473, 'Cosmetic - Huugo Iron March D - PRK'),
(2474, 'Cosmetic - Akama in Center'),
(2475, 'Cosmetic - Lokra at Stonefang'),
(2476, 'Cosmetic - Sky at Stonefang'),
(2481, 'Cosmetic - Makar Down'),
(2482, 'Cosmetic - Gana in The Boneslag'),
(2483, '"Cosmetic - Shadowmoon Valley 6.0 - ""Soul Shards of Summoning"" - Corruptor Kurgoth\'s Light Beam (ELM)"'),
(2484, '"Cosmetic - Shadowmoon Valley 6.0 - ""Soul Shards of Summoning"" - Grogal the Harvester\'s Light Beam (ELM)"'),
(2486, '"Cosmetic - Shadowmoon Valley 6.0 - ""Soul Shards of Summoning"" - Fel Mistress Hagra\'s Light Beam (ELM)"'),
(2487, 'Cosmetic - Shadowmoon Valley 6.0 - Starfall Outpost - Cordana Felsong (ELM)'),
(2488, 'Cosmetic - Makar Up'),
(2489, 'Treasure Map 1'),
(2490, 'Treasure Map 2'),
(2491, 'Treasure Map 3'),
(2492, '"Cosmetic - Shadowmoon Valley 6.0 - Starfall Outpost - ""Catching His Eye"" Event (ELM)"'),
(2493, '"Cosmetic - Shadowmoon Valley 6.0 - ""Ominous Portents"" - Dead All-Seeing Eye (ELM)"'),
(2494, 'Cosmetic - Shadowmoon Valley 6.0 - Gul\'var - Image of Archmage Khadgar (ELM)'),
(2495, 'Cosmetic - Lokra in The Boneslag'),
(2496, 'Cosmetic - Drifts - Lokra 1'),
(2497, 'Cosmetic - Drifts - Asha 1'),
(2498, 'Cosmetic - Wrathion'),
(2499, '"Cosmetic - Shadowmoon Valley 6.0 - ""Ominous Portents"" - Spawned All-Seeing Eye (ELM)"'),
(2501, 'Cosmetic - Shadowmoon Valley 6.0 - Starfall Outpost - Archmage Khadgar (ELM)'),
(2503, 'Cosmetic - Grom\'gar - Karg Captured'),
(2506, 'Cosmetic - Vignette - See Sunken Hozen Chest'),
(2509, '"Cosmetic - Shadowmoon Valley 6.0 - ""Shadowmoonwell"" - Moonwell Visual Bunny (ELM)"'),
(2510, 'Dungeon Encounter 6'),
(2511, 'Dungeon Encounter 7'),
(2512, 'Dungeon Encounter 8'),
(2513, 'Dungeon Encounter 9'),
(2514, 'Dungeon Encounter 10'),
(2515, 'Dungeon Encounter 11'),
(2516, 'Dungeon Encounter 12'),
(2517, 'Dungeon Encounter 13'),
(2518, 'Dungeon Encounter 14'),
(2519, 'Dungeon Encounter 15'),
(2520, 'Dungeon Encounter 16'),
(2521, 'Dungeon Encounter 17'),
(2522, 'Dungeon Encounter 18'),
(2523, 'Dungeon Encounter 19'),
(2524, 'Dungeon Encounter 20'),
(2525, 'Dungeon Encounter 21'),
(2526, 'Dungeon Encounter 22'),
(2527, 'Dungeon Encounter 23'),
(2528, 'Dungeon Encounter 24'),
(2529, 'Dungeon Encounter 25'),
(2531, 'Cosmetic - Thunderfall - Nerok'),
(2532, 'Personal - Observatory Arrival'),
(2533, 'Cosmetic - 5.4 Finale Event'),
(2534, 'Cosmetic - Lorewalker Cho at Tree'),
(2535, 'Cosmetic - Quest Giver - Kill Guttra Wolfchew - Quest Accept'),
(2537, 'Cosmetic - Frostfire Ridge - Frostwind Dunes - Cordana Felsong (ELM)'),
(2538, 'Cosmetic - Frostfire Ridge - Throm\'var - Archmage Khadgar (ELM)'),
(2539, 'Cosmetic - Frostfire Ridge - Throm\'var - Cordana Felsong (ELM)'),
(2540, 'Frostfire Rige - Grimfrost Garrison - Dead Orc 01 JP3 '),
(2541, 'Cosmetic - Chest- See Pillar Hopping Treasure Chest'),
(2542, 'Cosmetic - Chest- See Rope Dropping Treasure Chest'),
(2543, 'Cosmetic - Chest- See Gleaming Crane Statue'),
(2544, 'Cosmetic - Chest- See Gleaming Treasure Satchel'),
(2545, 'Cosmetic - See Aruuna in Plaza'),
(2546, 'Cosmetic - Frostfire Ridge - Throm\'var - Farseer Urquan 02 (ELM)'),
(2547, 'Cosmetic - Tree of New Seasons'),
(2548, 'Cosmetic - See Aruuna by Scopes'),
(2549, 'Cosmetic - Frostfire Ridge - Grimfrost - Kill Guttra WolfKill - Quest Return - JP3'),
(2550, 'Cosmetic - Valley of the Four Winds (Catch and Carry: Cart Hunter\'s Mark) - ELM'),
(2551, 'Cosmetic - See Telescope - The Arbitum Arrival'),
(2552, 'Cosmetic - Frostfire Ridge - Throm\'var - Farseer Urquan 01 (ELM)'),
(2553, '"Cosmetic - Frostfire Ridge - ""The Sleeper Has Awakened"" - Sleeper\'s Lair Rocks & Burrow Visual (ELM)"'),
(2554, 'Personal - Dark Side of the Moon'),
(2555, '"Cosmetic - Frostfire Ridge - ""The Sleeper Has Awakened"" - Image of Cho\'gall & Area Triggers (ELM)"'),
(2559, '[PH] SMV - Alliance Garrison V1'),
(2560, '[PH] SMV - Alliance Garrison V2'),
(2561, '[PH] SMV - Alliance Garrison V3'),
(2562, 'Cosmetic - See Telescope - NOT The Arbitum Arrival'),
(2563, 'Wrathion Tantrum'),
(2566, 'Frostfire Rige - Grimfrost Garrison - Dead Orc 02 JP3 '),
(2567, 'Frostfire Rige - Grimfrost Garrison - Dead Orc 03 JP3 '),
(2568, 'Cosmetic - Player Monument'),
(2569, 'Frostfire Rige - Grimfrost Garrison - Dead Orc 01 - After Phase JP3 '),
(2570, 'Frostfire Rige - Grimfrost Garrison - Dead Orc 02 - After Phase JP3 '),
(2571, 'Frostfire Rige - Grimfrost Garrison - Dead Orc 03 - After Phase JP3 '),
(2572, 'Karabor Attack - Intro'),
(2574, 'Cosmetic - Frostfire Ridge - Grimfrost - Kill Guttra WolfKill - Quest Complete - JP3'),
(2575, 'Garrosh Raid - Cutscenes'),
(2576, 'Krasarang - Alliance Base Visible - Portcullis'),
(2578, 'Personal - Bladespire Ravine Wave Event'),
(2579, 'Cosmetic - Ga\'nar at the front of Daggermaw Canyon'),
(2581, 'Cosmetic - See Kuruna'),
(2582, 'Cosmetic - See Immune NPCs'),
(2583, 'See Stationary Kuruna 1'),
(2584, '"Shadowmoon Valley 6.0 - ""Ominous Portents"" - Client-Side Scene (ELM)"'),
(2585, 'Cosmetic - Shaz\'gul Ner\'zhul Event'),
(2586, '"Cosmetic - Shadowmoon Valley 6.0 - ""Ominous Portents"" - Moonstone Beams (ELM)"'),
(2587, 'Cosmetic - See Gar\'s Well Kept Journal'),
(2588, 'Cosmetic - See Rukah\'s Dusty Journal'),
(2589, 'Cosmetic - See Mokrik\'s Tattered Journal'),
(2590, 'Personal -Shadowmoon Valley - Podlingpatch Forest - Draenei Cave Rescue (Jp3)'),
(2593, 'Combat - Shaz\'gul Escape'),
(2594, 'Cosmetic -Shadowmoon Valley 6.0- Podlingpatch Forest-  See Phlox Opening- JP3'),
(2597, 'Cosmetic - Ga\'nar - Post-Wave'),
(2598, 'Shadowmoon Valley - Foreling Forest - Moonstone Offering (Jp3)'),
(2600, 'Cosmetic - Frostfire Ridge - Ogre Fortress - Catapault 1 Vision - GJC'),
(2601, 'Cosmetic - See Spawned Erryl'),
(2602, '"Shadowmoon Valley 6.0 - ""Shadowmoon Join the Iron Horde"" Quest - Client-Side Scene (ELM)"'),
(2603, 'Cosmetic - See Cannon and Bunny - Shadowmoon'),
(2604, 'Cosmetic - Ga\'nar at Kolloc\'s Lair'),
(2605, 'Cosmetic - NEVER'),
(2606, 'Cosmetic - See Supplies On Fire - Shadowmoon'),
(2607, 'Cosmetic - See Supply Bunny and Barrel - Shadowmoon'),
(2609, 'Cosmetic - Frostfire Ridge - Ogre Fortress - Catapault 2 Vision - GJC'),
(2610, 'Cosmetic - Frostfire Ridge - Ogre Fortress - Catapault 3 Vision - GJC'),
(2611, 'Cosmetic - Frostfire Ridge - Ogre Fortress - Catapault 4 Vision - GJC'),
(2612, 'Cosmetic - Frostfire Ridge - Ogre Fortress - Catapault 5 Vision - GJC'),
(2613, 'Cosmetic - Frostfire Ridge - Ogre Fortress - Lieutenant 2 Vision - GJC'),
(2614, 'Cosmetic - Frostfire Ridge - Ogre Fortress - Durotan Vision Inside Fortress - GJC'),
(2615, 'Cosmetic - See Vindicator Erryl'),
(2616, 'Cosmetic - Teluuna Observatory - See Velen'),
(2618, 'Cosmetic - Shadowmoon Valley - Podlingpatch ending -jp3'),
(2619, 'Cosmetic - See Ginni'),
(2620, 'Personal - The Iron Wolf Encounter'),
(2621, 'Shadowmoon Valley - Foreling Forest - Podling Riddler'),
(2622, 'Cosmetic - Frostfire Ridge - Ogre Fortress - Ga\'nar Vision - GJC'),
(2623, 'Cosmetic - Player Monument (new)'),
(2624, 'Cosmetic - Frostfire Ridge - Ogre Fortress - Ligra Vision - Stairs - GJC'),
(2625, 'Cosmetic - Frostfire Ridge - Bladespire Fortress - Korga Quest - GJC'),
(2629, 'Personal Cosmetic - Karg\'s Hut Event'),
(2630, 'Cosmetic - Frostfire Ridge - Bladespire Fortress - Ghostfur at Stairs'),
(2631, 'Cosmetic - Frostfire Ridge - Bladespire Fortress - Ga\'nar Stairs'),
(2632, 'Cosmetic - Frostfire Ridge - Bladespire Fortress - Durotan - Personal Vis - GJC'),
(2633, 'Cosmetic - Frostfire Ridge: (GJC) - Bladespire Fortress - Personal Vis - Ga\'nar'),
(2634, 'Cosmetic - Frostfire Ridge - Bladespire Fortress - Korga Vision - Stairs'),
(2635, 'Cosmetic - Frostfire Ridge - Ogre Fortress - Ligra Vision - GJC'),
(2636, 'Cosmetic - Draka - The Ascent'),
(2637, 'Cosmetic - Frostfire Ridge: (GJC) - Bladespire Fortress - Dodg\'em Rocks'),
(2638, 'Treasure - Frostwolf Supply Cache'),
(2639, 'Cosmetic - Frostfire Ridge - Bladespire Fortress - Assault Squad - GJC'),
(2640, 'Cosmetic - Draka & Drek\'thar at the First Anvil - Wrap up'),
(2641, 'Cosmetic -Shadowmoon Valley - Podlingpatch Forest - Captured Critters (Jp3)'),
(2642, 'Cosmetic - Frostfire Ridge - Time Portal - Chronormu - GJC'),
(2643, 'Cosmetic - Shadowmoon Valley - Podlingpatch ending Draenei Rescue -jp3'),
(2644, 'Cosmetic - Frostfire Ridge - Bladespire Fortress - Camp - Thrall - GJC'),
(2645, 'Personal - Bladespire Fortress - Gorr\'thog Encounter'),
(2646, 'Cosmetic - Shadowmoon Valley - Podlingpatch ending Draenei Rescue -jp3'),
(2647, 'Cosmetic - See Straka'),
(2648, 'Bladespire Fortress - Dorogg'),
(2649, 'Cosmetic - Frostfire Ridge - Ogre Fortress - Ghostpaw Vision - Stairs - GJC'),
(2650, 'Cosmetic - Horde Caravan - Position 00 (Nowhere)'),
(2651, 'Cosmetic - Horde Caravan - Position 01 (Start Hub)'),
(2652, 'Cosmetic - Horde Caravan - Position 02 (Tank Base)'),
(2653, 'Cosmetic - Horde Caravan - Position 03 (West)'),
(2654, 'Cosmetic - Horde Caravan - Position 04 (Center)'),
(2655, 'Cosmetic - Horde Caravan - Position 05 (Northwest)'),
(2656, 'Cosmetic - Alliance Caravan - Position 00 (Nowhere)'),
(2657, 'Cosmetic - Alliance Caravan - Position 01 (Start Hub)'),
(2658, 'Cosmetic - Alliance Caravan - Position 02 (Tank Base)'),
(2659, 'Cosmetic - Alliance Caravan - Position 03 (Center)'),
(2660, 'Cosmetic - Alliance Caravan - Position 04 (West)'),
(2661, 'Cosmetic - Alliance Caravan - Position 05 (Northwest)'),
(2662, 'Cosmetic - Horde Caravan - Position 06 (East)'),
(2663, 'Cosmetic - Alliance Caravan - Position 06 (East)'),
(2664, 'Cosmetic - Frostwolf Rider Vision'),
(2665, 'Cosmetic - Frostfire Ridge - Bladespire Fortress - Ga\'nar Vision - GJC'),
(2666, 'Cosmetic - Frostfire Ridge - Bladespire Fortress - Durotan Vision - GJC'),
(2668, 'Cosmetic - Drifts - Makar'),
(2669, 'Cosmetic - Shadowmoon Valley - Gloomshade Grove - Phlox Phase 1 - jp3'),
(2670, 'Cosmetic - Shadowmoon Valley - Gloomshade Grove - Phlox Phase 2 - jp3'),
(2671, 'Cosmetic - Shadowmoon Valley - Gloomshade Grove - Phlox Phase 2A - jp3'),
(2672, 'Cosmetic - Shadowmoon Valley - Gloomshade Grove - Phlox Phase 3 - jp3'),
(2673, 'Cosmetic - Shadowmoon Valley - Gloomshade Grove - Summon Borisari 001 - jp3'),
(2674, 'Cosmetic - Frostfire Ridge - Bladespire Fortress - Korga Wolf Vision - GJC'),
(2675, 'Wounded Morkra'),
(2676, 'Healthy Morkra'),
(2677, 'Bladespire Fortress - Intro'),
(2678, 'Cosmetic - Erryl in Field - PRK'),
(2679, 'Cosmetic - Giral in Field - PRK'),
(2680, 'Cosmetic - Yoraal in Field - PRK'),
(2681, 'Cosmetic - Taalo in Field - PRK'),
(2684, 'Cosmetic - Broken Aeluun Crystal - PRK'),
(2685, 'Cosmetic - Fixed Aeluun Crystal - PRK'),
(2686, 'Cosmetic - Ice Forge - Flamerog'),
(2687, 'Cosmetic - Ice Forge - Kindler'),
(2688, 'Cosmetic - Ice Forge - Sparkren'),
(2689, 'Cosmetic - Barricade Bunny Vision'),
(2690, 'Cosmetic - Frostwolf Muster'),
(2691, 'Cosmetic - See Explosives @ Supply Hut'),
(2692, 'Cosmetic - See Explosives @ Supply Hut'),
(2693, 'Cosmetic - See Explosives @ Main Lodge'),
(2694, 'Cosmetic - See Explosives @ Main Lodge'),
(2695, 'Cosmetic - See Explosives @ Chieftain\'s Seat'),
(2696, 'Cosmetic - See Explosives @ Chieftain\'s Seat'),
(2697, 'Cosmetic - See Explosives @ Ritual Altar'),
(2698, 'Cosmetic - See Explosives @ Ritual Altar'),
(2699, 'Cosmetic - See Cannon On Fire - Shadowmoon'),
(2700, 'Cosmetic - See Battle Plans Fire - Shadowmoon'),
(2701, 'Cosmetic - Don\'t See Battle Plans Fire - Shadowmoon'),
(2702, 'Bladespire Fortress - Sacked'),
(2703, 'Cosmetic - Non Quest Barricade'),
(2704, 'Frostfire Ridge - Sootstained Mines - Ogre Occupied'),
(2705, 'Cosmetic - Frostfire Ridge - Favela - Frostwolf Slaves'),
(2706, 'Cosmetic - See Malfunctioning Gnome Copter - Shadowmoon'),
(2707, 'Cosmetic - See Gnome Bomb Phase 001  - Shadowmoon'),
(2708, 'Cosmetic - See Gnome Copter Phase 001  - Shadowmoon'),
(2709, 'Cosmetic - Thrall in Bladespire (sacked)'),
(2710, 'Cosmetic - Durotan in Bladespire (sacked)'),
(2711, 'Cosmetic - See Gnome Bomb Phase 002  - Shadowmoon'),
(2712, 'Cosmetic - See Gnome Bomb Phase 003  - Shadowmoon'),
(2713, 'Cosmetic - Durotan at Frostwolf Muster '),
(2714, 'Cosmetic - Thrall at Muster Field'),
(2715, 'Cosmetic - Ga\'nar at Muster Field'),
(2716, 'Cosmetic - Taylor in Karabor'),
(2717, 'Cosmetic - Maraad outside Karabor'),
(2718, 'Cosmetic - Velen at Side Door'),
(2719, 'Cosmetic - Velen at Staging Area B'),
(2720, 'Cosmetic - Bladespire Fortress - Post Dorogg'),
(2721, 'Cosmetic - Erryl in Staging Area - PRK'),
(2722, 'Cosmetic - Giral in Staging Area - PRK'),
(2723, 'Cosmetic - Yoraal in Staging Area - PRK'),
(2724, 'Cosmetic - Taalo in Staging Area - PRK'),
(2725, 'Cosmetic - See Flow Rider'),
(2726, 'Cosmetic - See Tanks - PRK'),
(2727, 'Cosmetic - See Activated Crystal  - Shadowmoon'),
(2728, 'Cosmetic - See Scouts 001 - Shadowmoon'),
(2729, '"Cosmetic - On Quest ""A Little Action On the Side"" (JP3)"'),
(2730, 'Cosmetic - See Scouts 002 - Shadowmoon'),
(2731, 'Cosmetic - See Zipfizzle Copter Taxi - Shadowmoon'),
(2732, 'Cosmetic - See Arkadian at Twilight Glade'),
(2733, 'Cosmetic - See Arkadian at Shaz\'gul'),
(2734, 'Cosmetic - See Portal 1'),
(2735, 'Cosmetic - Feeding Area Marker'),
(2736, 'Cosmetic - Sacrifice Pit Chest'),
(2737, 'Cosmetic - See Chronalis on Artichoke Mountain'),
(2738, 'Cosmetic - See Chronalis in Karabor'),
(2740, 'Cosmetic - See Exarch Maladaar at Tomb of Lights'),
(2741, 'Cosmetic - See Lady Liadrin at Tomb of Lights'),
(2742, 'Cosmetic - Frostfire Ridge - Bladespire Fortress - Cyclone Totem (RKS)'),
(2743, 'Cosmetic - See Zipfizzle at Observatory'),
(2744, 'Cosmetic - See Rommul at Observatory - Dais'),
(2745, 'Cosmetic - Gorgrond - Bastion Rise - Thaelin Darksocket 01 (ELM)'),
(2746, 'Cosmetic - Frostfire Ridge - Bladespire Fortress - See Lorgosh at Level 1 Stairs'),
(2747, 'Cosmetic - Bladespire Fortress - Lorgosh Rally AFTER'),
(2748, 'Cosmetic - Frostfire Ridge - Bladespire Fortress - See Gol\'kosh to Rally'),
(2749, 'Cosmetic - Frostfire Ridge - Bladespire Fortress - See Gol\'kosh AFTER'),
(2750, 'Cosmetic - See Limbflayer in Laughing Skull 01'),
(2753, 'Cosmetic - Possible Survivors in Laughing Skull'),
(2754, 'Cosmetic - Frostfire Ridge - Bladespire Fortress - Destroyed Supplies Phase 1'),
(2755, 'Time-Warped Tower'),
(2756, 'Cosmetic - Gorgrond - Bastion Rise - Thaelin Darksocket 02 (ELM)'),
(2757, 'Laughing Skull - Intro'),
(2758, 'Cosmetic - Frostfire Ridge - Bladespire Fortress - Cyclone Totem AFTER (RKS)'),
(2759, 'Cosmetic - See Fire - Gorgrond - Spineling Spires - Burn house 001 (JP3)'),
(2760, 'Cosmetic - Gorgrond - Bastion Rise - The Big Cannon Flavor (ELM)'),
(2761, 'Cosmetic - See Fire - Gorgrond - Spineling Spires - Burn house 002 (JP3)'),
(2762, 'Karabor Conclusion Scene'),
(2763, 'Cosmetic - See Portal 2'),
(2764, 'Cosmetic - See Defiant Battlehoof at Skullchief\'s Stand'),
(2765, 'Cosmetic - Frostfire Ridge - Bladespire Fortress - Destroyed Supplies Phase 2'),
(2766, 'Cosmetic - Frostfire Ridge - Bladespire Fortress - Destroyed Supplies Phase 3'),
(2767, 'Cosmetic - Horde Caravan - Position 01 (Start Hub) - Rokk'),
(2768, 'Cosmetic - Horde Caravan - Position 01 (Start Hub) - Campfire'),
(2769, 'Cosmetic - Horde Questgivers in Gorgrond Pass'),
(2772, 'Cosmetic - See Fire - Gorgrond - Spineling Spires - Burn house 003 (JP3)'),
(2773, 'Cosmetic - Kaz Introduction'),
(2774, 'Cosmetic - See Jagahari Static Quest Giver  - Gorgrond - Spineling Spires (JP3)'),
(2775, 'Cosmetic - Frostfire Ridge - Bladespire Fortress - Throne Room - Ga\'nar'),
(2776, 'Cosmetic - Gorgrond - Bastion Rise - 6 Satchel Charges (ELM)'),
(2777, 'Cosmetic - Gorgrond - Bastion Rise - 3 Satchel Charges (ELM)'),
(2779, 'Cosmetic - See Nyami at Light\'s Rest'),
(2782, 'Cosmetic - See Blood Golem'),
(2787, 'Cosmetic - Bladespire Fortress - Durotan/Thrall After'),
(2788, 'Cosmetic - Laughing Skull on Fire'),
(2789, 'Cosmetic - Flippable Table'),
(2790, 'Cosmetic - Refugee Spirit Near Artifact'),
(2791, 'Karabor Front Door (BlizzCon)'),
(2792, 'Cosmetic - See Frostwolves to Assemble at Laughing Skull'),
(2793, 'Cosmetic - See Frostwolves to Assemble at Laughing Skull 02'),
(2794, 'Cosmetic - Kaz and Limbflayer in Laughing Skull'),
(2795, 'Cosmetic - Iskar 1'),
(2796, 'Cosmetic - Kura on Duskfall Island'),
(2797, 'Cosmetic - Raastok on Duskfall Island'),
(2798, 'Cosmetic - See Limbflayer in Laughing Skull 02'),
(2799, 'Cosmetic - Bladespire Fortress - Throne Room - Backup Ogres/Wolf Taxi'),
(2800, 'Cosmetic - Frostfire Ridge - Bladespire Fortress - Throne Room - Frost Wolf Taxi'),
(2801, '6.0 Invasion - Blasted Lands (A) Phase'),
(2802, 'Cosmetic - Karabor Aftermath - Cosmetic'),
(2803, 'Cosmetic - See Rooter Static Quest Giver  - Gorgrond - Stray Animal (JP3)'),
(2804, 'Cosmetic - See Skullchief'),
(2805, 'Cosmetic - Velen at Staging Area A'),
(2806, 'Cosmetic - Gorgrond - Ulon Oasis - Slavemaster Ok\'mok (ELM)'),
(2807, 'Cosmetic - See Mogor at Weapon\'s Testing Facility'),
(2808, 'Cosmetic - See Illona'),
(2809, 'Cosmetic - Iskar 2'),
(2810, 'Cosmetic - See Y\'kish Static Quest Giver  - Gorgrond - Giant Cauldron (JP3)'),
(2811, 'Cosmetic - Gorgrond - Bastion Rise - Fire Scene Bunny (ELM)'),
(2812, 'Cosmetic - See Oil Spewing (GJC)'),
(2813, '"Cosmetic - Gorgrond - ""The Heavyhanded Way"" Quest - Hansel Heavyhands (ELM)"'),
(2814, 'Cosmetic - See Supply Fires (GJC)'),
(2815, 'Cosmetic - See Camp Fires (GJC)'),
(2816, 'Cosmetic - See Iron Horde Supplies by Lake (GJC)'),
(2817, '"Cosmetic - Gorgrond - ""Self Destruction"" - Remote Firing Plunger (ELM)"'),
(2818, 'Cosmetic - See Velen at Karabor Aftermath'),
(2819, 'Cosmetic - Gorgrond - Prototype Proving Grounds - Fire Scene Bunny (ELM)'),
(2820, 'Cosmetic - Goc at Capping Operation'),
(2821, 'Thunderlord Kit Test'),
(2822, 'Cosmetic - See Illona Post Quests'),
(2823, 'Cosmetic - See Iron Oiler'),
(2824, '"Cosmetic - Gorgrond - ""Fog of War Machines"" - War Machines (ELM)"'),
(2825, '"Cosmetic - Gorgrond - ""They Love Iron"" - War Machines (ZTO)"'),
(2826, 'TEST - Talador - Shwayder Spawns'),
(2827, 'Cosmetic - See Beldos BEFORE 01 Complete'),
(2828, 'Cosmetic - See Muura Outside Farm'),
(2829, 'Cosmetic - See Luuco'),
(2830, 'Cosmetic - See Escaped Talbuk'),
(2831, 'Gronning Run'),
(2833, 'Cosmetic - Gorgrond - Spineling Crevice - Slavemaster Ok\'mok (ELM)'),
(2835, 'Cosmetic - See Muura Inside Farm'),
(2836, 'Cosmetic - See Beldos AFTER 01 Complete'),
(2837, 'Cosmetic - Goc at Horde Caravan'),
(2838, 'Cosmetic - Draka at Capping Operation'),
(2839, 'Cosmetic - Decommissioned Iron Shredder'),
(2840, 'Cosmetic - See Beldos AFTER 01 Complete'),
(2841, 'Cosmetic - See Dead Podlings at Beldos'),
(2842, '"Cosmetic - Gorgrond - ""Fog of War Machines"" - Smoke After Quest Complete (ELM)"'),
(2843, 'Cosmetic - See Dead Skreek  - Gorgrond - Giant Cauldron (JP3)'),
(2844, 'Cosmetic - Barum and Melani at Sojourn'),
(2845, 'Cosmetic - Barum and Melani in Woods'),
(2846, 'Cosmetic - Raksi in Aruuna'),
(2847, '"Cosmetic - Gorgrond - Stonemaul Slave Camp - ""Free Yrel: Setting It Up"" - Slavemaster Ok\'mok (ELM)"'),
(2848, 'Karabor Aftermath - Combat'),
(2849, 'Cosmetic - Functional Iron Shredder'),
(2850, 'Tuurem - Iron Horde'),
(2851, 'Cosmetic - Draka at Capping Operation Camp'),
(2854, 'Cosmetic - Swiftshadow Ending Phase - Gorgrond - Giant Cauldron (JP3)'),
(2855, 'Farm - Iron Horde Attack Phase (GJC)'),
(2856, 'Personal - Tuurem - Boss Phase'),
(2857, 'Cosmetic - See Akama at Karabor Aftermath'),
(2858, 'Cosmetic - See Yrel at Twilight Glade'),
(2859, 'Darkmoon Race #1'),
(2861, 'Cosmetic - See Paddock Fires'),
(2862, 'Cosmetic - See Shore/Store Fires'),
(2863, 'Cosmetic - See Forge Fires'),
(2864, 'Cosmetic - See Rommul at Observatory - Entrance'),
(2865, 'Cosmetic - Gorgrond - Stonemaul Slave Mine - Yrel - Spawned (ELM)'),
(2866, 'Cosmetic - See Yrel at Observatory - Entrance'),
(2867, 'Cosmetic - See Beldos at Overlook'),
(2868, 'Cosmetic - See Karmaan at Steps'),
(2869, 'Cosmetic - Gorgrond - Spineling Crevice - Yrel (ELM)'),
(2870, 'Cosmetic - See Questgivers After Boss Fight (GJC)'),
(2871, 'Cosmetic - See Karmaan'),
(2872, 'Cosmetic - See Luuco'),
(2873, 'Cosmetic - Frostfire Ridge - Favela - Mulverick'),
(2874, 'Cosmetic - Looming Army'),
(2875, 'Cosmetic - Gorgrond - Spineling Crevice - Dead Ogres (ELM)'),
(2876, 'Cosmetic - See Goc at Binding Trench - Horde'),
(2877, 'Cosmetic - See Iron Rider'),
(2878, '"Cosmetic - Gorgrond - Stonemaul Slave Camp - ""Free Yrel: Escape!"" - Alarm (ELM)"'),
(2879, '"Frostfire Ridge - Wor\'gol - ""Save Wolf Home"" questline (ELM)"'),
(2880, 'Cosmetic - See Injured Maraad'),
(2881, 'Personal - Ner\'zhul Finale'),
(2882, 'Personal - Bladespire Fortress - Gormaul Tower - Ogre Occupied'),
(2883, 'Cosmetic - Drifts - Corpses'),
(2884, 'Cosmetic - See Susanna Eyesley Injured'),
(2885, 'Cosmetic - See Susanna Eyesley Healed'),
(2886, 'Cosmetic - See Kal\'gor at the Gronn Grotto'),
(2887, 'Cosmetic - See Brewing Materials'),
(2889, 'Cosmetic - See Rulkan in Cave'),
(2891, '"Cosmetic - Frostfire Ridge - Wor\'gol - ""Back to Bladespire Fortress"" - Smoke, Corpses, & Mourners (ELM)"'),
(2892, 'Cosmetic - See Brewing Materials'),
(2894, 'Cosmetic - See Pale Illusionist'),
(2895, 'Cosmetic - See Pale Illusion'),
(2896, 'Cosmetic - See Rok\'nar Initially'),
(2897, 'Cosmetic - See Rok\'nar Post Breakout'),
(2898, 'Cosmetic - Yrel at Back Door'),
(2899, 'Cosmetic - Yrel at Front Door'),
(2900, 'Cosmetic - See Roka Trapped'),
(2901, 'Cosmetic - See Roka Rescued'),
(2902, 'Cosmetic - See Shadow Rose'),
(2903, 'Cosmetic - Wor\'gol - Static Frost Wolf Vehicle'),
(2904, 'Cosmetic - See Scout Tenemus'),
(2905, 'Cosmetic - Wor\'gol - Static Durotan'),
(2907, 'Cosmetic - See Yrel'),
(2908, 'Cosmetic - See Tess Greymane at Twilight Glade'),
(2909, 'Cosmetic - Wor\'gol - Static Drek\'thar at Pool of Visions'),
(2910, 'Cosmetic - Wor\'gol - Honor Circle - Static Durotan'),
(2911, 'Cosmetic - See Kadus at Twilight Glade'),
(2912, 'Cosmetic - See Tess Greymane Summon'),
(2913, 'Cosmetic - See Kadus Summon'),
(2914, 'Cosmetic - See Hemma at Twilight Glade'),
(2915, 'Cosmetic - See Hemma Summon'),
(2916, 'Cosmetic - See Artificers'),
(2917, 'Cosmetic - Drifts - Lokra 2'),
(2918, 'Cosmetic - Drifts - Asha 2'),
(2919, 'Cosmetic - Drifts - Iron Wolf'),
(2920, 'Cosmetic - See Kadus at Hilltop'),
(2921, 'Cosmetic - See Tess at Hilltop'),
(2922, 'Cosmetic - Frostfire Ridge - Bladespire Fortress - Gormaul Camp Iconics'),
(2923, 'Cosmetic - See Hemma at Hill'),
(2924, 'Cosmetic - See Hemma at Hill'),
(2925, 'Cosmetic - Frostfire Ridge - Bladespire Fortress - Cyclone Thrall Static'),
(2927, 'Cosmetic - Yrel at Smokebelcher Depot Camp (ELM)'),
(2928, 'Cosmetic - Yrel inside Smokebelcher Depot (ELM)'),
(2929, 'Cosmetic - See Asher in Melted Burrow'),
(2930, 'Cosmetic - Maraad/D\'kaan/Hansel at Smokebelcher Depot Camp (ELM)'),
(2931, 'Cosmetic - Maraad/D\'kaan/Hansel inside Smokebelcher Depot (ELM)'),
(2932, '"Cosmetic - Gormaul Tower - Prequel - ""Static"" Durotan"'),
(2933, 'Cosmetic - See Rescued Prisoners'),
(2934, 'Cosmetic - See Helga Static Quest Giver  - Gorgrond - Pale Caves (JP3)'),
(2935, 'Cosmetic - See Helga Static Quest Giver  - Gorgrond - Pale Caves (JP3)'),
(2938, 'Cosmetic - Prequel - Beach - Static Drek\'thar'),
(2939, '"Cosmetic - Gorgrond - Smokebelcher Depot - ""Charges Remaining"" - Train Fire Controller Bunny A (ELM)"'),
(2940, 'Cosmetic - Prequel - Beach - Static Thrall'),
(2941, '"Cosmetic - Gorgrond - Smokebelcher Depot - ""Charges Remaining"" - Train Fire Controller Bunny B (ELM)"'),
(2942, 'Cosmetic - Draka & Drek\'thar at Ice Forge'),
(2943, '"Cosmetic - Gorgrond - Smokebelcher Depot - ""Charges Remaining"" - Train Fire Controller Bunny C (ELM)"'),
(2944, 'Cosmetic - Lokra at Muster Field'),
(2945, 'Cosmetic - Karg at Muster Field'),
(2946, 'Cosmetic - Nerok at Muster Field'),
(2947, 'Cosmetic - Prequel - Beach - Static Ga\'nar'),
(2948, 'Cosmetic - Na\'shra (Initiate)'),
(2949, 'Cosmetic - Na\'Shra (Blademaster)'),
(2950, 'Cosmetic - See Land Mine Location (GJC)'),
(2951, 'Thunderfall - Frostwolf Raid'),
(2952, 'Cosmetic - Wor\'gol - Static Nightstalker/Draka'),
(2953, 'Cosmetic - See Iron Horde Weapons (GJC)'),
(2954, 'Cosmetic - See Beldos by Boss'),
(2955, 'Cosmetic - Arkonite Hologram ON - 1 - Fields'),
(2956, 'Cosmetic - Arkonite Hologram ON - 2 - Quarry'),
(2957, 'Cosmetic - Arkonite Hologram ON - 3 - Gloomshade'),
(2958, 'Cosmetic - Arkonite Hologram ON - 4 - Arkaat Outpost'),
(2959, 'Cosmetic - Arkonite Hologram ON - 5 - Overlook'),
(2960, 'Cosmetic - Arkonite Hologram OFF - 1 - Fields'),
(2961, 'Cosmetic - Arkonite Hologram OFF - 2 - Quarry'),
(2962, 'Cosmetic - Arkonite Hologram OFF - 3 - Gloomsahde'),
(2963, 'Cosmetic - Arkonite Hologram OFF - 4 - Arkaat Outpost'),
(2964, 'Cosmetic - Arkonite Hologram OFF - 5 - Overlook'),
(2965, 'Cosmetic - See Slavemaster Ok\'mok at Horde Caravan 02'),
(2966, 'Cosmetic - See Limbflayer vs Axegrim'),
(2967, 'Cosmetic - Sootstained Mines - Gol\'kosh Etc.'),
(2968, 'Cosmetic - Sootstained Mines - Extra Gol\'kosh Ogre Corpses'),
(2969, 'Cosmetic - See Yrel at Observatory - Dais'),
(2970, 'Cosmetic - See Maraad'),
(2971, 'Cosmetic - Wor\'gol - Frostwolves Pre Gormaul'),
(2972, 'Cosmetic - Frostfire Ridge - Bladespire Fortress - Last Steps Complete'),
(2973, '"Cosmetic - Gorgrond - ""Goc\'s Revenge"" - Goc\'s Gifts (ELM)"'),
(2974, 'Cosmetic - Arkonite Hologram Stand OFF - 1 - Fields'),
(2975, 'Cosmetic - Arkonite Hologram Stand OFF - 2 - Quarry'),
(2976, 'Cosmetic - Arkonite Hologram Stand OFF - 3 - Gloomsahde'),
(2977, 'Cosmetic - Arkonite Hologram Stand OFF - 4 - Arkaat Outpost'),
(2978, 'Cosmetic - Arkonite Hologram Stand OFF - 5 - Overlook'),
(2979, '"Cosmetic - Gorgrond - Smokebelcher Depot - ""Goc\'s Revenge"" - Yrel on Goc (ELM)"'),
(2980, 'Cosmetic - Gorgrond - Tailthrasher Basin - Initial Spawned Rangari D\'kaan (ELM)'),
(2981, 'Cosmetic - See Argus Expert'),
(2982, 'Cosmetic - See Velen Expert'),
(2983, 'Cosmetic - See Kil\'jaeden Expert'),
(2984, 'Cosmetic - See Crash Expert'),
(2985, 'Cosmetic - See Naaru Expert'),
(2986, 'Phase Out Aklana Static 001'),
(2987, 'Cosmetic - See Hurkan and Teron\'gore in Tomb of Souls (GJC)'),
(2988, 'Aklana Rescue '),
(2989, 'Phase Out Aklana Static 002'),
(2990, 'Cosmetic - See Explosives in Cave'),
(2991, 'Cosmetic - See Hansel Upstairs'),
(2992, 'Cosmetic - See Hansel by Dais'),
(2993, 'Cosmetic - See Thaelin Upstairs'),
(2994, 'Cosmetic - Frostwolves In Canyon'),
(2995, 'Cosmetic - Frostwolves In Clearing'),
(2996, 'Cosmetic - Bluff - Horde Hub Cave'),
(2997, 'Cosmetic - Thrall and Wolves at the First Anvil'),
(2999, 'Cosmetic - Thrall & Wolves at the First Anvil - Wrap up'),
(3000, 'Cosmetic - See Maladaar at Auch North Gate (GJC)'),
(3001, 'Cosmetic - Drek\'Thar\'s Totem at The First Anvil'),
(3002, 'Cosmetic - Beach - Horde First Hub (RKS)'),
(3003, 'Cosmetic - Beach - Horde First Hub - Gazlowe (RKS)'),
(3004, 'Cosmetic - Bluff - Horde Hub Cave - Gazlowe (RKS)'),
(3005, 'Cosmetic - Tuurem - Horde Hub'),
(3006, 'Cosmetic - Tuurem - Horde Hub - Gazlowe'),
(3007, 'Cosmetic - Treasure - Lagoon Pool'),
(3008, 'Cosmetic -  Draenei Camp Explosion After'),
(3009, 'Cosmetic -  Draenei Camp Explosion Before'),
(3010, 'Cosmetic - See Demon Chains at Tomb of Lights'),
(3011, 'Cosmetic -  Draenei Camp Explosion Deceptia'),
(3012, 'Cosmetic -  Draenei Camp Explosion - Deceptia\'s Boots'),
(3013, 'Cosmetic - Bluff - Horde Hub Cave - Shredder (RKS)'),
(3014, 'Cosmetic - See Ricky - Quest Giver'),
(3015, 'Spirit World'),
(3016, 'Cosmetic - Dark Amalgamation (GJC)'),
(3017, 'Show Rakla'),
(3018, 'Cosmetic - Cave Dust Cloud'),
(3019, 'Cosmetic - Spider Caught Questgiver (A)'),
(3020, 'Cosmetic - Spider Caught Questgiver (H)'),
(3021, 'Cosmetic - Rubble A'),
(3022, 'Cosmetic - Blast Rubble A'),
(3023, 'Cosmetic - Rubble B'),
(3024, 'Cosmetic - Blast Rubble B'),
(3025, 'Cosmetic - Rubble C'),
(3026, 'Cosmetic - Rubble D'),
(3027, 'Cosmetic - Blast Rubble C'),
(3028, 'Cosmetic - Gorgrond - Bastion Rise - Rangari D\'kaan (ELM)'),
(3029, 'Cosmetic - Blast Rubble D'),
(3030, 'Cosmetic - Durotan in Back of Slave Mines'),
(3031, 'Cosmetic - See Leafshadow Fog'),
(3032, 'Cosmetic - Durotan & Draka visible at Dethroller'),
(3033, 'Cosmetic - See Torches at Telmor'),
(3034, 'Cosmetic - See Note at Telmor'),
(3035, 'Cosmetic - Horde - Stonemaul Slave Camp Decorations'),
(3036, 'Cosmetic - See Kaz in Stonemaul Slave Camp'),
(3037, 'Cosmetic - Orgrim\'s Dethroller in front of Stonemaul Slave Camp'),
(3038, 'Cosmetic:JP3 - Show Thaelin and Romuul after Q33153'),
(3039, 'Stonemaul - Kor\'gall Encounter'),
(3040, 'Cosmetic - Gorgrond - Bastion Rise - General Phasing (ELM)'),
(3041, 'Cosmetic - Tuurem - Horde Hub - Gazlowe\'s Workstation (RKS)'),
(3042, 'Cosmetic - See Liadrin at Liadrin\'s Watch'),
(3043, 'Cosmetic - See Nyami at Auch North Gate (GJC)'),
(3044, 'Cosmetic - See Astalor at Liadrin\'s Watch'),
(3045, 'Cosmetic - See Rescued Units'),
(3046, 'Cosmetic - Laughing Skull slaves at Horde Caravan 03'),
(3047, 'Cosmetic - Orgrim at Horde Caravan (Slave Camp)'),
(3048, 'Cosmetic - See Voidborne Errant Souls'),
(3049, 'Cosmetic - See Dead Fara in Stonemaul Slave Camp'),
(3050, 'Cosmetic - See Kaduz Trapped'),
(3051, 'Cosmetic - See Kaduz at Palemoon Village'),
(3052, 'Cosmetic - See Romuul at Karabor Aftermath'),
(3053, 'Cosmetic - Gorgrond - Stonemaul Slave Mine - Yrel\'s Dead Ogres - Spawned (ELM)'),
(3054, 'Cosmetic - Extra Tanks in Iron March'),
(3055, 'Cosmetic - See Kyresh'),
(3056, 'Cosmetic - See Maraad at Arkaat'),
(3057, 'Cosmetic - See Velen at Arkaat'),
(3058, 'Cosmetic - See Yrel at Arkaat'),
(3059, 'Velen Staff Scene'),
(3060, 'See Ranger Arepheon 1'),
(3061, 'See Ranger Arepheon 2'),
(3062, 'Cosmetic - Hansel in Thaelin\'s Workshop'),
(3063, 'Cosmetic - Teluuna Observatory - See Velen Pre-Finale'),
(3064, 'Cosmetic - See Yrel at Observatory - Pre-Finale'),
(3065, 'Cosmetic - See Maraad'),
(3066, 'Cosmetic - Nightstalker at Horde Caravan 03'),
(3067, 'Cosmetic - See Maraad at Light\'s Fall'),
(3068, 'Cosmetic - Totally Inconspicuous Crate'),
(3069, 'Cosmetic - Thaelin Captured'),
(3070, 'Cosmetic - Alliance Logging Camp - Observiscope'),
(3071, 'Cosmetic - Scout Ruk\'gun Secondary Camp 1.0'),
(3072, 'Cosmetic - Scout Ruk\'gun Tertiary Camp'),
(3073, 'Cosmetic - Scout Ruk\'gun - Initial Camp'),
(3074, 'Cosmetic - Muster Field 1'),
(3075, 'Cosmetic - Muster Field 2'),
(3076, 'Cosmetic - Frostfire Ridge - Favela - Lokra Clickable Box'),
(3077, 'Cosmetic - Decommissioned Iron Shredder'),
(3078, 'Cosmetic - Coil of Rope Questgiver visual toggle'),
(3079, 'Cosmetic - Scout Ruk\'gun Secondary Camp 1.5'),
(3080, 'Cosmetic - Functional Iron Shredder'),
(3081, 'Cosmetic - Bluff/Tuurem - Thaelin (RKS)'),
(3082, 'Cosmetic - Bluff/Tuurem - Decommissioned Shredder'),
(3083, 'Cosmetic - Bluff/Tuurem - Alliance Questgivers'),
(3084, 'Cosmetic - Logging Camp - Alliance First Hub (RKS)'),
(3085, 'Cosmetic - Logging Camp - Alliance First Hub - Thaelin'),
(3086, 'Cosmetic - Bluff/Tuurem - Khadgar'),
(3087, 'Cosmetic - See Explosives in Cave'),
(3088, 'Cosmetic - Thunder Pass Finale'),
(3089, 'Cosmetic - See Saved Isaari'),
(3090, 'Cosmetic - See Saved Ankaa'),
(3091, 'Cosmetic - See Saved Mardaar'),
(3092, 'Cosmetic - See Saved Doruun'),
(3093, 'Cosmetic - See Saved Norana'),
(3094, 'Cosmetic - See Saved Riasa'),
(3095, 'Cosmetic - See Saved Baran'),
(3096, 'Cosmetic - See Saved Orian'),
(3097, 'Cosmetic - See Chat on Mardaar'),
(3098, 'Cosmetic - See Chat on Baran'),
(3099, 'Cosmetic - See Yuuri Saved - Alliance'),
(3100, 'Cosmetic - See Yuuri in Field'),
(3101, 'Cosmetic - See Yuuri Saved - Horde '),
(3102, 'Cosmetic - Shadowmoon Valley 6.0 - Gul\'var - Image of Archmage Khadgar - 001 (ELM)'),
(3103, '"Cosmetic - Shadowmoon Valley 6.0 - Gul\'var - ""Forging the Soul Trap"" Quest Objects (ELM)"'),
(3107, 'Cosmetic - See Soulbinder Nyami at Liadrin\'s Watch'),
(3108, 'Cosmetic - See Soulbinder Nyami at Goldendawn Camp'),
(3109, 'Cosmetic - Graragg Escort 1'),
(3110, 'Cosmetic - Graragg Escort 2'),
(3111, 'Cosmetic - Graragg Escort 3'),
(3112, 'Cosmetic - Rescue Operative - Newt'),
(3113, 'Cosmetic - Grulk Escort - In Cage'),
(3114, 'Cosmetic - See Restalaan at Hub 3'),
(3115, 'Cosmetic - See Restalaan in Telmor'),
(3116, 'Cosmetic - Grulk Escort - Dungeon'),
(3117, 'Cosmetic - Thaelin in Cave'),
(3118, 'Cosmetic - Hansel in Cave'),
(3119, 'Cosmetic - See Lootable Murmur'),
(3120, 'Cosmetic - Thaelin and Hansel at Garrison'),
(3121, 'Cosmetic - Scout Ruk\'gun - Initial Camp - Axe Prop'),
(3122, 'Cosmetic - Underwater Demolition - Ticker'),
(3123, 'Cosmetic - Grommar - Gob Squad'),
(3124, 'Cosmetic - Gob Squad - Newt'),
(3125, 'Cosmetic - Scout Ruk\'gun Secondary Placement 1.0'),
(3127, 'Cosmetic - Fel Barrier - Front Door'),
(3128, 'Cosmetic - Anchorite Raleen (Snowfall Alcove)'),
(3129, 'Cosmetic - Anchorite Raleen in Frostbite Hollow'),
(3130, 'Cosmetic - Fel Barrier - Interrior Doors'),
(3132, 'Cosmetic - Eredar Conflict at Frostbite Hollow'),
(3133, 'Cosmetic - Grommar - Eastern Tower Fire'),
(3134, 'Cosmetic - Grommar - Western Tower Fire'),
(3135, 'Cosmetic - Grommar - Fortress Fire'),
(3136, 'Cosmetic - Grommar - Battleship Fire'),
(3137, 'Cosmetic - Blook'),
(3138, 'Combat Phase - The Drill'),
(3139, 'Cosmetic - See Tuulani at Goldendawn Camp - GJC'),
(3140, 'Cosmetic - See Mehlar Dawnblade at Goldendawn Camp - GJC'),
(3141, 'Cosmetic - Drill Turbines'),
(3142, 'Cosmetic - Drill Turbines Destroyed Smoke'),
(3143, 'Cosmetic - Gazlowe Near Drill'),
(3145, 'Cosmetic - See Kaluud and Artaal at Telmor'),
(3146, '6.0 Invasion - Blasted Lands (H) Phase'),
(3147, 'Cosmetic - See Tuulani at Light\'s Rest - GJC'),
(3148, 'Cosmetic - See Namuun at Light\'s Rest - GJC'),
(3149, 'Cosmetic - Magma Lord Questgiver'),
(3150, 'Cosmetic - Rescue Operative - Snap'),
(3151, 'Cosmetic - See Tuulani at Telmor'),
(3152, 'Cosmetic - Owynn Graddock Shackle'),
(3153, 'Owynn Graddock Ungeared state'),
(3154, 'Cosmetic - Snap Togglespin'),
(3155, 'Cosmetic - Grommar - Battleship Fire 2'),
(3156, 'Cosmetic - Grommar - Battleship Fire 2'),
(3157, 'Cosmetic - Owynn\'s Gear - Dagger'),
(3158, 'Cosmetic - Owynn\'s Gear - Mace'),
(3159, '"Owynn Graddock Geared state - End of ""Seeking the Truth"" , start of ""The Shadow Gate"""'),
(3160, 'Cosmetic - See Aren Mistshade'),
(3161, 'Cosmetic - See Thisalee Crow'),
(3162, 'Cosmetic - See Choluna'),
(3163, 'Cosmetic - See Aren Mistshade'),
(3164, 'Cosmetic - See Thisalee Crow'),
(3165, 'Cosmetic - See Choluna'),
(3166, 'Cosmetic - Snap\'s Crash Site'),
(3167, 'Cosmetic - Snap Repairing'),
(3168, 'Cosmetic - Alliance Questgivers'),
(3169, 'Cosmetic - Alliance Questgivers - Lusia Moonwhisper'),
(3170, '"Owynn Graddock Geared state - End of ""Gearing Up"" , start of ""Seeking the Truth"""'),
(3171, 'Cosmetic - See Colossal Heart'),
(3173, 'Cosmetic - Shadow Gate - Quest'),
(3174, 'Cosmetic - Sacrificial Corpses'),
(3175, 'Bloodmaul - Shadowlands'),
(3176, 'Cosmetic - Gazlowe on Roof'),
(3177, '"Cosmetic - ""Soulgrinder Survivor"" - Summoning Circles"'),
(3178, 'Cosmetic - See Stone Heart'),
(3179, 'Cosmetic - See Choluna'),
(3180, 'Cosmetic - Orlana Strongbrow'),
(3181, 'Cosmetic - Eerie Totem'),
(3182, '"Frostfire Ridge - Bloodmaul Stronghold - ""The Shadow Gate"" Quest - Client-Side Scene (LWB)"'),
(3183, 'Garrison Lumberjack Test Phase'),
(3184, 'Cosmetic - See Omnuron'),
(3185, 'Bloodmaul - Shadowlands - Shadowgate Closed'),
(3186, 'Cosmetic - See Shard of Lights at Burning Front'),
(3187, 'Cosmetic - Azerothean Reinforcements (Pre-Cold Weather Gear)'),
(3188, 'Cosmetic - Azerothean Reinforcements (Post-Cold Weather Gear)'),
(3189, 'Cosmetic - Azerothean Reinforcements (Gear Unrelated)'),
(3190, 'Owynn Graddock - Shadowlands - Cave'),
(3191, 'Cosmetic - See Stone Heart'),
(3194, 'Cosmetic - Iconics at Garrison Landing'),
(3195, 'Cosmetic - Durotan at Hilltop'),
(3196, 'Cosmetic - Iconics at Garrison Location'),
(3197, 'Cosmetic - Gazlowe at Initial Garrison Location'),
(3198, 'Cosmetic - See Liadrin at Exarch\'s Refuge'),
(3199, 'Cosmetic - See Maladaar at Exarch\'s Refuge'),
(3200, 'Cosmetic - See Mehlar at Exarch\'s Refuge'),
(3201, 'Cosmetic - See Nyami at Exarch\'s Refuge'),
(3202, 'Cosmetic - See Tuulani at Exarch\'s Refuge'),
(3203, 'Cosmetic - Jorune Mine - Alliance'),
(3204, 'Cosmetic - Jorune Mine - Horde'),
(3205, 'Personal - Jorune Mine Boss Fight'),
(3206, 'Personal - Jorune Mine Boss Fight'),
(3207, 'Cosmetic - Bleeding Hollow Slaves 01'),
(3208, 'Cosmetic - Bleeding Hollow Slaves 02'),
(3209, 'Cosmetic - Bleeding Hollow Slaves 03'),
(3210, 'Cosmetic - Bleeding Hollow Slaves 04'),
(3211, 'Cosmetic - See Sparkles on Unmarked Journal'),
(3212, '"Cosmetic - Frostfire Ridge - ""The Fel Crystals"" - The Shield (ELM)"'),
(3213, '"Cosmetic - Azerothean Reinforcements (Darkspear\'s Edge, Pre-Cold Weather Gear)"'),
(3214, '"Cosmetic - Azerothean Reinforcements (Darkspear\'s Edge, Post-Cold Weather Gear)"'),
(3215, '"Cosmetic - Frostfire Ridge - ""The Fel Crystals"" - Southern Fel Crystal (ELM)"'),
(3216, '"Cosmetic - Frostfire Ridge - ""The Fel Crystals"" - Central Fel Crystal (ELM)"'),
(3217, '"Cosmetic - Frostfire Ridge - ""The Fel Crystals"" - Northern Fel Crystal (ELM)"'),
(3218, 'Cosmetic - Frostfire Ridge - Ruins of Ata\'gar - Image of Archmage Khadgar (ELM)'),
(3219, 'Cosmetic - Frostfire Ridge - The Gloomspire - Image of Archmage Khadgar (ELM)'),
(3220, 'Cosmetic - See Shard of Souls at Tomb of Souls'),
(3221, 'Cosmetic - See Artaal at Court of Souls'),
(3222, 'Cosmetic - See Orvuu at Court of Souls'),
(3223, 'Cosmetic - Jorune Mine - Kaelynara'),
(3224, 'Cosmetic - Orlana Strongbrow'),
(3225, 'Frostbite Hollow - Eredar Conflict'),
(3226, 'Cosmetic - Frostfire Ridge - The Gloomspire - Area Trigger & Portal to Throm\'var (ELM)'),
(3227, 'Cosmetic - Gul\'dan\'s Dome'),
(3228, '"Bwu\'ja Geared state - End of ""Gearing Up"" , start of ""Seeking the Truth"""'),
(3229, 'Cosmetic - See Tuulani at Tomb of Lights'),
(3230, 'Cosmetic - Shadow Hunter Bwu\'ja Shackle'),
(3231, 'Shadow Hunter Bwu\'ja Ungeared state'),
(3232, '"Bwu\'ja - End of ""Seeking the Truth"" , start of ""The Shadow Gate"""'),
(3233, 'Shadow Hunter Bwu\'ja - Shadowlands - Cave'),
(3234, 'Owynn Graddock - Soulgrinder Survivor - End'),
(3235, 'Bwu\'ja - Soulgrinder Survivor - End'),
(3236, 'Cosmetic - Dying Slave is Alive'),
(3237, 'Cosmetic - Dying Slave is Dead'),
(3238, 'Cosmetic - Rexxar Quest giver 001'),
(3239, 'Owynn Graddock - Soulgrinder Survivor - Prior to Ritual'),
(3240, 'Owynn Graddock - Soulgrinder Survivor - During Boss Fight'),
(3241, 'Shadow Hunter Bwu\'ja - Soulgrinder Survivor - Prior to Ritual'),
(3242, 'Shadow Hunter Bwu\'ja - Soulgrinder Survivor - During Boss Fight'),
(3243, 'Cosmetic - See Sha\'tari in Deathweb Hollow'),
(3244, 'Cosmetic - Rylak Opening Snip Scene'),
(3245, 'Cosmetic - Draka at Main Tent'),
(3246, 'Cosmetic - Draka at War Horn'),
(3247, 'Cosmetic - Rexxar Quest giver 002'),
(3248, 'Cosmetic - Gul\'dan - Ganahma\'s Barb'),
(3249, 'Cosmetic - Gul\'dan - Rune of the Felbreakers'),
(3250, 'Cosmetic - Gul\'dan - Horn of Kairozdormu'),
(3251, 'Cosmetic - Gul\'dan'),
(3252, 'Cosmetic - See Liadrin at Goldendawn Camp'),
(3253, 'Cosmetic - Great Rylak Static'),
(3254, 'Cosmetic - See Maladaar at Light\'s Rest'),
(3255, 'Cosmetic - Darktide Roost - Rexxar Guardian Finale'),
(3257, 'Cosmetic - See Zuulo'),
(3258, 'Cosmetic - See Arekk'),
(3259, 'Cosmetic - See Diaani'),
(3260, 'Cosmetic - See Roona'),
(3261, 'Cosmetic - Nagrand Corral'),
(3262, 'Cosmetic - See Auch\'naaru in Telmor'),
(3263, 'Cosmetic - Questgivers at Dark Portal'),
(3264, 'Cosmetic - Questgivers at Bleeding Hollow Building'),
(3265, 'Cosmetic - Questgivers at Bleeding Hollow Altar (E)'),
(3266, 'Cosmetic - Questgivers at Shattered Hand Bridge'),
(3267, 'Cosmetic - Questgivers at Shadowmoon Cave Entrance (A)'),
(3268, 'Cosmetic - Questgivers at Blackrock Quarry Rise'),
(3269, 'Cosmetic - Questgivers at Labor Camp'),
(3270, 'Hungry Wolf'),
(3271, 'Cosmetic - Frostfire Ridge - Favela - Mulverick - Follower Ready'),
(3272, 'Cosmetic - Thrall/Maraad/Kargath Fight'),
(3273, 'Cosmetic - Garrison Construction'),
(3274, 'Cosmetic - Anima Static 000'),
(3275, 'Cosmetic - Anima 002 Static'),
(3276, 'Personal - Remains of Xandros - Teron\'gor Encounter'),
(3277, 'Cosmetic - See Nyami at Seat of Depravity'),
(3278, 'Cosmetic - Drek at Shattered Hand Building'),
(3279, 'Cosmetic - See Aftermath at Dungeon Entrance'),
(3280, 'Talador - Outpost - Construction Yard - Alliance'),
(3281, 'Talador - Outpost - Armory - Alliance'),
(3282, 'Talador - Outpost - Mage Tower- Alliance'),
(3283, 'Talador - Outpost - Armory - Horde'),
(3284, 'Talador - Outpost - Construction Yard - Horde'),
(3285, 'Talador - Outpost - Mage Tower- Horde'),
(3286, 'Cosmetic - Drifts - Asha 3'),
(3287, 'Cosmetic - Flowerpicker'),
(3288, 'Cosmetic - Gronnstalker Rokash'),
(3289, 'Cosmetic - Cordana at Bladespire'),
(3290, 'Lumberjacks Carry Wood'),
(3291, 'Personal - Ring of Trials Fights'),
(3292, 'Personal Phase - Glade of Shadows'),
(3293, 'Prequel - Mines - After'),
(3294, 'Garrison Intro - Baros Alexston'),
(3295, 'Cosmetic - See Rangari Actor 1 at Twilight Glade'),
(3296, 'Cosmetic - See Rangari Actor 2 at Twilight Glade'),
(3297, 'Cosmetic - Nagrand 6.0 - Wor\'var - Wor\'var Demolisher (ELM)'),
(3298, 'Cosmetic - Nagrand 6.0 - Telaari Station - Telaari Tank (ELM)'),
(3299, 'Cosmetic - See Explosives @ Training Pit'),
(3300, 'Cosmetic - See Explosives @ Training Pit'),
(3301, 'Garrison Intro - Mines - After'),
(3302, 'Cosmetic - Ner\'zhul Event - Actors Who Leave'),
(3303, 'Cosmetic - Ner\'zhul Event - Actors Who Stay'),
(3304, 'Cosmetic - Nagrand 6.0 Ogre POI Alliance (JMC)'),
(3305, 'Cosmetic - Nagrand 6.0 Ogre POI Horde (JMC)'),
(3306, 'Cosmetic - Thrall and Maraad at Shattered Hand Rise'),
(3307, 'Cosmetic - Garrison - Bladespire Fortress Complete'),
(3308, 'Cosmetic - Garrison - Cordana'),
(3309, 'Cosmetic - Portal Open 001'),
(3310, 'Personal - Remains of Xandros'),
(3311, 'Cosmetic - Grom\'gar - Dagg the Ogre Follower'),
(3312, 'Cosmetic - Gronnstalker Rokash in Daggermaw Ravine'),
(3313, 'Cosmetic - Daggermaw Ravine - Dagg the Ogre Follower'),
(3314, 'Shattered Hand Intro'),
(3315, 'Cosmetic - Garrison - Dagg the Ogre Follower'),
(3316, 'Cosmetic - Muglokk Corpse Phase'),
(3317, 'Cosmetic - Questgivers at Shattered Hand Rise'),
(3318, 'Cosmetic - Ruulan is Alive'),
(3319, 'Cosmetic - Ruulan is Dead'),
(3320, 'Spires Intro Phase'),
(3321, 'Cosmetic - Nagrand 6.0 - Garrison Caravan - Alliance (ELM)'),
(3322, 'Cosmetic - Nagrand 6.0 - Garrison Caravan - Dead Lieutenant Balfor (ELM)'),
(3323, 'Cosmetic - Nagrand 6.0 - Garrison Caravan - Living Lieutenant Balfor (ELM)'),
(3324, 'Cosmetic - Prequel - Garrison Tier 0 - Bonfire'),
(3325, 'Cosmetic - Prequel - Garrison Tier 0 - Logs First Set'),
(3326, 'Cosmetic - Prequel - Garrison Tier 0 - Logs Second Set'),
(3327, 'Cosmetic - Azik on High Road'),
(3328, 'Cosmetic - Reshad in Shop'),
(3329, ' Cosmetic - Follow Velen Complete'),
(3330, 'Cosmetic - Questgivers at Shadowmoon Cave Entrance (H)'),
(3331, 'Cosmetic - Durotan at Garrison Location'),
(3332, 'Cosmetic - See Yrel at Alliance Garrison Outpost'),
(3333, 'Cosmetic - Questgivers at Shadowmoon Cave Middle (A)'),
(3334, 'Cosmetic - Questgivers at Shadowmoon Cave Middle (H)'),
(3335, 'Cosmetic - See Durotan at Horde Garrison Outpost'),
(3336, 'Cosmetic - See Kalaam at Alliance Garrison Outpost'),
(3337, 'Cosmetic - See Kalaam at Horde Garrison Outpost'),
(3338, 'Cosmetic - See Knight-Lord Dranarus at Horde Garrison Outpost'),
(3339, 'Cosmetic - See Foreman Grobash at Horde Garrison Outpost (Building Not Selected)'),
(3340, 'Cosmetic  - See Foreman Eksos at Alliance Garrison Outpost (Building Not Selected)'),
(3341, 'Cosmetic - See Vindicator Bi\'lee at Alliance Garrison Outpost'),
(3342, 'Cosmetic - See Kyresh at Alliance Garrison Outpost'),
(3343, 'Cosmetic - Nagrand 6.0 - Rangari Overlook - Alliance NPCs (ELM)'),
(3344, 'Cosmetic - Nagrand 6.0 - Telaari Station - Thaelin\'s Copter (ELM)'),
(3345, 'Cosmetic - See Drafting Table in Alliance Garrison Outpost'),
(3347, 'Cosmetic - See Artaal at Alliance Tuurem Outpost'),
(3348, 'Cosmetic - See Artaal at Horde Tuurem Outpost'),
(3349, 'Cosmetic - Qiana Moonshadow at Shattered Hand Rise'),
(3350, 'Cosmetic - Maladaar at Shattered Hand Building'),
(3351, 'Cosmetic - Yrel in Central Chamber (H/A)'),
(3352, 'Cosmetic - Yrel in Cave Terminal (H/A)'),
(3353, ' Cosmetic - Snip Scene (Draenei Boat Landing)'),
(3354, 'Cosmetic - Maladaar at Shadowmoon Cave Middle (A)'),
(3355, 'Cosmetic - Reshad on Road'),
(3356, 'Cosmetic - Liadrin at Shadowmoon Cave Middle (H)'),
(3357, '"Nagrand 6.0 - Telaar - Alliance Before ""Shields Down!"" Combat Phase (ELM)"'),
(3358, 'Cosmetic - Olin Umberhide at Shattered Hand Rise'),
(3359, 'Cosmetic - Lady Liadrin at Shattered Hand Rise'),
(3360, 'Cosmetic - See Foreman Grobash at Horde Garrison Outpost (Building Selected)'),
(3361, 'Cosmetic  - See Foreman Eksos at Alliance Garrison Outpost (Building Selected)'),
(3362, 'Cosmetic - See Hedontron at Duskfall Island (H) Pre-Quests'),
(3363, 'Cosmetic - See Hedontron at Duskfall Island (H) Post-Quests'),
(3364, '[PH] FFR - Horde Garrison V1'),
(3365, '[PH] FFR - Horde Garrison V2'),
(3366, '[PH] FFR - Horde Garrison V3'),
(3367, 'Cosmetic - See Hedontron at Duskfall Island (A) Pre-Quests'),
(3368, 'Cosmetic - See Hedontron at Duskfall Island (A) Post-Quests'),
(3370, '"Cosmetic - Nagrand 6.0 - Telaar - ""Shields Down!"" - Arkonite Shield - Alliance Stables version (ELM)"'),
(3371, '"Cosmetic - Nagrand 6.0 - Telaar - ""Shields Down!"" - Arkonite Shield - Alliance Workshop version (ELM)"'),
(3372, '"Cosmetic - Nagrand 6.0 - Telaari Station - ""Work Complete"" - Alliance - The Final Nail (ELM)"'),
(3373, 'Morkeths Cage Closed'),
(3374, 'Morkeths Cage Open'),
(3375, '"Cosmetic - Nagrand 6.0 - Telaari Station - Hansel, Felaani, Isel, & Old Scratch (ELM)"'),
(3376, 'Cosmetic - Sabermaw - Bazwix Turn-in'),
(3377, 'Cosmetic - See Pristine Star Lily'),
(3378, 'Cosmetic - See Velen'),
(3379, 'Cosmetic - See Velen'),
(3380, 'Morketh - Free In the Armory'),
(3381, 'Cosmetic - Nagrand 6.0 - Garrison Caravan - Horde (ELM)'),
(3382, 'Cosmetic - Nagrand 6.0 - Garrison Caravan - Living Stone Guard Brox (ELM)'),
(3383, 'Cosmetic - Nagrand 6.0 - Garrison Caravan - Dead Stone Guard Brox (ELM)'),
(3386, 'Cosmetic - See Nadur at Scenic Road'),
(3387, 'Cosmetic - Spirit Wall Into Auchindoun'),
(3388, 'Cosmetic - See Aeda Brightdawn at Auchenai Precipice'),
(3389, 'Cosmetic - See Defender Kaluum at Auchenai Precipice'),
(3390, 'Can See Hataaru in Elodor Fields'),
(3391, 'Cosmetic - See Khadgar at T-Intersection'),
(3392, 'Cosmetic - Questgivers at Bleeding Hollow Altar (H)'),
(3393, 'Cosmetic - Questgivers at Bleeding Hollow Altar (A)'),
(3394, 'Cosmetic - Khadgar at Bleeding Hollow Building'),
(3395, 'Cosmetic - Thrall at Bleeding Hollow Building'),
(3396, 'Cosmetic - Maraad at Bleeding Hollow Building'),
(3397, 'Cosmetic - See Gatekeeper at Zangar Crater'),
(3398, 'Abyssal Breach REVAMP'),
(3399, 'Cosmetic - See Luminrath at Khadgar\'s Tower'),
(3400, 'Abyssal Breach REVAMP - Nazgrim Turnin'),
(3401, 'Abyssal Breach REVAMP - Taylor Turnin'),
(3402, 'Cosmetic - See Bookshelf Fire'),
(3403, 'Cosmetic - See Floor Fire'),
(3404, 'Cosmetic - See Table Fire'),
(3405, 'Cosmetic - Ariok at Bleeding Hollow Altar'),
(3406, 'Cosmetic - See Rastaak'),
(3407, 'Cosmetic - See Hakaam'),
(3408, 'Cosmetic - See Ariaana)'),
(3409, 'Cosmetic - Thrall at Shattered Hand Bridge'),
(3410, 'Cosmetic - Maraad at Shattered Hand Bridge'),
(3411, 'Frostfire - Garrison - Fishing Shack - Active'),
(3412, 'Gordal Fortress - Morketh Quest Giver 1. Start'),
(3413, 'Cosmetic - Khadgar vs. Muglokk'),
(3414, 'Cosmetic - Khadgar at Shattered Hand Bridge'),
(3415, 'Combat - Observatory Arrival'),
(3416, 'Cosmetic - Khadgar at Shattered Hand Rise'),
(3417, 'Cosmetic - See Abjurist Belmara at Khadgar\'s Tower'),
(3418, 'Cosmetic - Reshad at Crow\'s Crook'),
(3419, 'Cosmetic - Goblin Protest'),
(3420, 'Cosmetic - Complete Q34386'),
(3421, 'Cosmetic - See Questgivers'),
(3422, 'Cosmetic - See Questgivers'),
(3423, 'Terrain Phase - Forge'),
(3424, 'Attack on Elodor Fields'),
(3425, 'Cosmetic - Nagrand 6.0 - Hallvalor - Lantresor of the Blade (ELM)'),
(3426, 'Cosmetic - Nagrand 6.0 - The Masters\' Cavern - Lantresor of the Blade - Horde (ELM)'),
(3427, 'Frostfire Ridge Intro - Horde'),
(3428, 'Cosmetic - Lokra at Garrison (Follower Ready)'),
(3429, 'Gordal Fortress - Horde Rope'),
(3430, 'Gordal Fortress - Morketh Quest Giver 2. Midrange'),
(3431, 'Gordal Fortress - Morketh Quest Giver 3. Before Boss'),
(3432, 'Cosmetic - Molten Rock'),
(3433, 'Cosmetic - See Defenders'),
(3434, 'Tracking Quest Complete - Stealthed Rangari'),
(3435, 'Tracking Quest Complete - Stealthed Rangari 002'),
(3436, 'Talador - Gordal Fortress - Morketh Quest Giver 4. After Boss'),
(3437, '"Cosmetic - Nagrand 6.0 - ""Challenge of the Masters"" - Stables version (ELM)"'),
(3438, '"Cosmetic - Nagrand 6.0 - ""Challenge of the Masters"" - Workshop version (ELM)"'),
(3439, '"Cosmetic - Nagrand 6.0 - Wor\'var - ""Work Complete"" - Horde - The Final Nail (ELM)"'),
(3440, 'Cosmetic - Ishaal at Hut'),
(3441, 'Cosmetic - Less-Iconics at Garrison Landing'),
(3442, 'Cosmetic - See Luminrath\'s Portals'),
(3443, 'Cosmetic - See Luminrath at Wall'),
(3444, '"Nagrand 6.0 - Telaar - Horde Before ""Shields Down!"" Combat Phase (ELM)"'),
(3445, 'Cosmetic - Nagrand 6.0 - Telaar - Shadow Hunter Kajassa (ELM)'),
(3446, 'Cosmetic - See Gordunni Boulderthrower (Mage Tower)'),
(3447, 'Cosmetic - See Gordunni Boulderthrower (Armory)'),
(3448, 'Cosmetic - Nagrand 6.0 - Telaar - Vindicator Mo\'mor (ELM)'),
(3449, '"Cosmetic - Nagrand 6.0 - Telaar - ""Shields Down!"" - Arkonite Shield - Horde version (ELM)"'),
(3450, 'Cosmetic - Farseer Drek\'thar in Wor\'gol (pre-Bladespire)'),
(3451, 'Cosmetic - Ikky\'s Egg Interact'),
(3452, 'Cosmetic - Ikky in Shadowglade'),
(3453, 'Cosmetic - Ikky\'s Egg Questgiver'),
(3454, 'Veil Akraz Shadow Realm'),
(3455, 'Cosmetic - Gar\'rok'),
(3456, 'Cosmetic - See K\'ara'),
(3457, 'Cosmetic - See Conjurer Luminrath in Vol\'jin\'s Holdfast'),
(3458, 'Cosmetic - Nagrand 6.0 - Telaar - Always (ELM)'),
(3459, 'Cosmetic - See Anti-Magic Zone in Gordal Fortress'),
(3460, 'Cosmetic - See Questgivers'),
(3461, 'Cosmetic - Nagrand 6.0 - The Masters\' Cavern - Lantresor of the Blade - Alliance (ELM)'),
(3462, '"Cosmetic - Nagrand 6.0 - ""Challenge of the Masters"" - Alliance version (ELM)"'),
(3463, 'Cosmetic - Ember Blossom'),
(3464, 'Cosmetic - See Yrel'),
(3465, 'Ravenspeaker Camp - Krikka - 1. Initial'),
(3466, '"Cosmetic - Nagrand 6.0 - Hallvalor - ""Not Without My Honor"" - Horde (ELM)"'),
(3467, '"Cosmetic - Nagrand 6.0 - Hallvalor - ""Not Without My Honor"" - Alliance (ELM)"'),
(3468, 'Cosmetic - Allies Outside Shattrath'),
(3469, 'Cosmetic - See Conjurer Luminrath at Base'),
(3470, 'Cosmetic - See Abjurist Belmara at Base'),
(3471, 'Cosmetic - See Belmara at Wall'),
(3472, '"Cosmetic - Nagrand 6.0 - ""Challenge of the Masters"" - Horde Stables Blueprints (ELM)"'),
(3473, '"Cosmetic - Nagrand 6.0 - ""Challenge of the Masters"" - Horde Workshop Blueprints (ELM)"'),
(3474, 'Cosmetic - Nightmare Foes'),
(3475, 'Cosmetic - See Morketh after Gordal in Vol\'jin\'s Holdfast'),
(3476, 'Cosmetic - Nagrand 6.0 - Telaari Station - Vindicator Mo\'mor (ELM)'),
(3477, 'Cosmetic - See Belamra\'s Portals'),
(3478, 'Cosmetic - Gnarlwood Pass - Iktis'),
(3479, 'Cosmetic - Gar\'rok\'s Body'),
(3480, 'Cosmetic - Bridge Intact'),
(3481, 'Cosmetic - Bridge Broken'),
(3482, 'Cosmetic - See Yrel'),
(3483, 'Cosmetic - H - Lumber Mill'),
(3484, 'Cosmetic - A - Armory'),
(3485, 'Cosmetic - A - Mage Tower'),
(3486, 'Cosmetic - H - Armory'),
(3487, 'Cosmetic - H - Mage Tower'),
(3488, 'Cosmetic - See Abjurist Belmara in Fort Wrynn'),
(3489, 'Cosmetic - See Yrel'),
(3490, 'Cosmetic - See Ariaana - Backup)'),
(3491, 'Cosmetic - Ligra - Post-Wave'),
(3492, 'Cosmetic - Gar\'rok\'s Grave'),
(3493, 'Spires - Ravenscar - Ravenspeaker Sekara during attack (LWB)'),
(3494, 'Cosmetic - See Wolves Outside Garrison Building'),
(3495, 'The Battle for the Forge'),
(3496, 'Cosmetic - Anzu and Flame at Perch'),
(3497, 'Cosmetic - Prisoners at Blackrock Quarry Rise'),
(3498, 'Cosmetic - Cave-In'),
(3499, 'Cosmetic - Khadgar at Blackrock Quarry Rise'),
(3500, 'Cosmetic - Khadgar at Blackrock Quarry Dam'),
(3501, 'Cosmetic - Anzu and Flame at Sethe'),
(3502, 'Ravenspeaker Camp - Krikka - 2. Ravenscar'),
(3503, 'Ravenspeaker Camp - Vakora - 2. Ravenscar'),
(3504, 'Cosmetic - Tank at Zone Entrance'),
(3505, 'Dam Aftermath'),
(3506, 'Cosmetic - See Horde Deconstruction Crew'),
(3507, 'Cosmetic - See Alliance Deconstruction Crew'),
(3508, '"Cosmetic - Thaelin, Blackrock, in the Field"'),
(3509, 'Cosmetic - See Anguish Barrier'),
(3510, 'Cosmetic - See Darkness Barrier'),
(3511, 'Cosmetic - See Shadows Barrier'),
(3512, 'Ravenspeaker Camp - Static'),
(3513, 'Cosmetic - Grulkor - 2a - Pre Spore Cloud'),
(3514, 'Cosmetic - Grulkor - 2b - Post Spore Cloud'),
(3515, 'Cosmetic - See Velen'),
(3516, 'Cosmetic - Grulkor - 3 - At Dead Heart'),
(3517, 'Cosmetic - Lithic'),
(3518, 'Cosmetic - See Cordana Felsong outside Zangarra'),
(3519, 'Cosmetic - Tank Controls'),
(3520, 'Cosmetic - Restless Spirits'),
(3521, 'Fort Wrynn - Apprentice Miall'),
(3522, 'Cosmetic - See Miall at Alliance Garrison Outpost'),
(3523, 'Cosmetic - See Mark of Anguish'),
(3524, 'Cosmetic - See Mark of Darkness'),
(3525, 'Cosmetic - See Mark of Shadows'),
(3526, 'Gordal Fortress - Miall Quest Giver 1. Start'),
(3527, 'Gordal Fortress - Miall Quest Giver 2. Midrange'),
(3528, 'Gordal Fortress - Miall Quest Giver 3. Before Boss'),
(3529, 'Talador - Gordal Fortress - Miall Quest Giver 4. After Boss'),
(3530, 'Cosmetic - See Thaelin in Rangari Station (Victim)'),
(3531, 'Cosmetic - See Rangari in Rangari Station (Victim)'),
(3532, 'Cosmetic - See Yrel & Velen'),
(3533, 'Cosmetic - See Luminrath + Scroll'),
(3534, 'Cosmetic - See Belmara + Scroll'),
(3535, 'Cosmetic - See Miall after Gordal in Fort Wrynn'),
(3536, 'Cosmetic - See Mage Tower Forces'),
(3537, 'Cosmetic - See Mage Tower Flavor'),
(3538, 'Cosmetic - Jorune Mine - Alliance - Kaelynara Turn-in'),
(3539, 'Cosmetic - Jorune Mine - Horde - Kaelynara Turn-in'),
(3540, 'Cosmetic - Tank at Zone Entrance 2'),
(3541, 'Cosmetic - A - Lumber Mill'),
(3542, 'Cosmetic - Thaelin on the Tank'),
(3543, 'The Home Stretch'),
(3544, 'Cosmetic - See Garrison Portal'),
(3545, 'Cosmetic - See Garrison Magi'),
(3546, 'Cosmetic - See Garrison Magi'),
(3547, 'Cosmetic - See Garrison Portal'),
(3548, 'Cosmetic - See Yrel & Velen'),
(3549, 'Cosmetic - Horned Skull'),
(3550, 'Cosmetic - See Oracle Stone'),
(3551, 'Cosmetic - Ga\'nar in Labor Camp'),
(3552, 'Nagrand 6.0 - Lok-rath - Alliance Combat Phase (ELM)'),
(3553, 'Cosmetic - Nagrand 6.0 - Lok-rath - Alliance Normal Phase (ELM)'),
(3554, 'Kill the genesaur (Objective Complete)'),
(3555, 'Cosmetic - Nagrand 6.0 - Lok-rath - Captured Uruk Foecleaver (ELM)'),
(3556, 'Lightning Cosmetic'),
(3557, 'Can See Hataaru at the Mines'),
(3558, 'Cosmetic - Heavy Bangle'),
(3559, 'Cosmetic - See Valdez'),
(3560, '"Cosmetic - Nagrand 6.0 - Yrel\'s Watch - ""Terror of Nagrand"" Flavor - Alliance (ELM)"'),
(3561, 'Cosmetic - Stonemaul Arena - Questgiver Aftermath'),
(3562, 'Cosmetic - See Rangari'),
(3563, 'Cosmetic - Khadgar at Dark Portal'),
(3564, 'Cosmetic - H - Construction Plot'),
(3565, 'Cosmetic - Nagrand 6.0 - Lok-rath - Horde Normal Phase (ELM)'),
(3566, 'Nagrand 6.0 - Lok-rath - Horde Combat Phase (ELM)'),
(3567, '"Cosmetic - Nagrand 6.0 - Riverside Post - ""Terror of Nagrand"" Flavor - Horde (ELM)"'),
(3568, 'Battle for the Dark Portal'),
(3569, '"Cosmetic - Named Characters on Dark Portal, Post-Guldan"'),
(3570, 'Battle for the Dark Portal UNUSED'),
(3571, 'Spirit Woods - Twisting Nether'),
(3572, 'Cosmetic - Grulkor - 1 - Initial QG'),
(3573, 'Cosmetic - See Yrel'),
(3574, 'Cosmetic - Alliance Outpost - State 0'),
(3575, 'Cosmetic - A - Sparring Arena'),
(3576, 'Cosmetic - A - Sparring Arena - Full Group'),
(3577, 'Cosmetic - Nagrand 6.0 - Telaari Station - Thaelin Darkanvil (ELM)'),
(3578, 'Cosmetic - H - Sparring Arena'),
(3579, 'Cosmetic - Khadgar out of Water'),
(3580, 'Cosmetic - H - Sparring Arena (Full Unlock)'),
(3581, 'Cosmetic - Ga\'nar at Hub'),
(3582, 'Tank Phase'),
(3583, 'Cosmetic - Tank Turret'),
(3584, 'Cosmetic - Dagg in Stonemaul'),
(3585, 'Cosmetic - Shadowmoon Valley 6.0 - Starfall Outpost - Alliance (ELM)'),
(3586, 'Cosmetic - Frostfire Ridge - Frostwind Dunes - Alliance (ELM)'),
(3587, 'Cosmetic - Nagrand 6.0 - Yrel\'s Watch - Alliance (ELM)'),
(3588, 'Cosmetic - Rexxar at Battlefield IH Camp'),
(3589, 'Cosmetic - Stonemaul Arena Gladiators - At Boss'),
(3590, 'Cosmetic - A - Construction Plot'),
(3591, 'Cosmetic - Anima Chained at Battlefield IH Camp'),
(3592, 'Cosmetic - Garrison - Horde - Frostfire - Mine Door'),
(3593, 'Cosmetic - Weapon Racks (A)'),
(3594, 'Cosmetic - Weapon Racks (H)'),
(3595, 'Cosmetic - Slavemaster Broon Visible at Stonemaul Arena'),
(3596, 'Cosmetic - Nagrand 6.0 - Gates of Grommashar - Alliance (ELM)'),
(3597, 'Cosmetic - Post-Prisoners on Blackrock Quarry Rise'),
(3598, 'Combat - Throne of the Witch Lord (Horde)'),
(3599, 'Combat - Throne of the Witch Lord (Alliance)'),
(3600, '"Cosmetic - Nagrand 6.0 - ""The Stones of Prophecy"" - Alliance & Horde NPCs (ELM)"'),
(3601, '"Cosmetic - Nagrand 6.0 - ""The Stones of Prophecy"" - Gorehowl (ELM)"'),
(4881, 'Ashtongue/Battlelord Gaardoun at Illidari Foothold'),
(4883, 'Coilskar/Lady S\'theno at Illidari Foothold'),
(4884, 'Shivarra/Matron Mother Malevolence at Illidari Foothold'),
(4899, 'Jace Darkweaver, Kayn Sunfury, Allari the Souleater, Cyana Nightglaive, Kor\'vas Bloodthorn and Sevis Brightflame Demonhunter Intro'),
(4925, 'Cyana Nightglaive caged Molten Shore'),
(4927, 'Mannethrel Darkstar caged Molten Shore'),
(4931, 'Belath Dawnblade caged Molten Shore'),
(4932, 'Izal Whitemoon caged Molten Shore'),
(5056, 'Colossal Infernal from Inquisitor Bailful Molten Shore'),
(5077, 'Cryptic Hollow NPCs inside cave for quest Hidden No More'),
(5086, 'Kayn Sunfury and Spawns at Cryptic Hollow'),
(5094, 'Allari the Souleater at Dispair Ridge Cave'),
(5095, 'Jace Darkweaver at Molten Shore'),
(5113, 'Soul Engine Devastator Banner'),
(5114, 'Soul Engine Devastator'),
(5115, 'Doom Fortress Devastator'),
(5116, 'Forge of Corruption Devastator'),
(5117, 'Forge of Corruption Devastator Banner'),
(5120, 'Doom Fortress Devastator Banner'),
(5160, 'Cyana Nightglaive, Kayn Sunfury and Allari the Souleater at Illidari Foothold'),
(5305, 'Kayn Sunfury and Kor\'vas Bloodthorn at Legion Banner'),
(5310, 'The Invasion Begins - Dispair Ridge Spawns'),
(5311, 'Dispair Ridge Spawns (Quest The Incasion Begins STATE_NONE)'),
(5343, 'Kor\'vas Bloodthorn at Illidari Foothold'),
(5344, 'Kor\'vas Bloodthorn at Imp Mother cave'),
(5357, 'Mannethrel Darkstar at Illidari Foothold'),
(5381, 'Illidari Foothold Generic Spawns'),
(5461, 'Ashtongue Mystic (for sacrifice) at Coilskar Gateway'),
(5462, 'Sevis Brightflame at Shivarra Gateway'),
(5463, 'Sevis Brightflame at Ashtongue Gateway'),
(5464, 'Sevis Brightflame at Coilskar Gateway'),
(5533, 'Injured Ashtongue/Healer at Illidari Foothold'),
(5534, 'Injured Coilskar/Healer at Illidari Foothold'),
(5595, 'Sevis Brightflame at Dispair Ridge Cave'),
(5658, 'Felsaber at Ashtongue Gateway'),
(6303, 'Sevis Brightflame Ghost at Illidari Foothold');

-- DB/Instances: Update parent map for Kalimdor Cataclysm instances
--
UPDATE `instance_template` SET `parent`= 1 WHERE `map` IN (938, 720, 754, 939, 940, 967, 755, 657, 644);

-- DB/Loot: Fix self-reference issue
-- Fix self-reference issue
UPDATE `reference_loot_template` SET `Reference` = 0 WHERE `Entry` IN (11919,11920,11921,13006,13007,13008,13009,13010);

-- DB/Creature: Add missing text for Thaelin & Hansel
DELETE FROM `creature_text` WHERE `CreatureID` IN (78568, 78569);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(78568, 0, 0, 'Don\'t worry, $n. We\'ve got your back!', 12, 0, 100, 0, 0, 45747, 0, 0, 'Thaelin Darkanvil to Player'),
(78569, 0, 0, 'Get on in there, champ!', 12, 0, 100, 0, 0, 45699, 0, 0, 'Hansel Heavyhands to Player'),
(78569, 1, 1, 'There she goes...', 12, 0, 100, 0, 0, 45702, 0, 0, 'Hansel Heavyhands to Player'),
(78569, 2, 2, '...wait for it...', 12, 0, 100, 0, 0, 45703, 0, 0, 'Hansel Heavyhands to Player'),
(78569, 3, 3, 'KER-PLOW!', 12, 0, 100, 0, 0, 45704, 0, 0, 'Hansel Heavyhands to Player'),
(78569, 4, 4, 'Ohhh, weren\'t that the prettiest thing?', 12, 0, 100, 0, 0, 45705, 0, 0, 'Hansel Heavyhands to Player');

-- DB: Fix 2 DB errors
-- 
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=1 AND `SourceGroup`=21060 AND  `SourceEntry`= 23612;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=1 AND `SourceGroup`=21061 AND  `SourceEntry`= 23612;

-- DB/Spell: Egg of mortal essence should proc with HoTs
UPDATE `spell_proc` SET `ProcFlags`=`ProcFlags`|0x00040000 WHERE `SpellId`=33953;

-- DB/Terrainswap: Blastedlands Warlords of Draenor Intro
-- TerrainSwap condition for blasted lands Warlords of Draenor: The Dark Portal
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 25 AND `SourceEntry` = 1190;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(25, 0, 1190, 0, 0, 27, 0, 90, 3, 0, 0, 0, 0, '', 'TerrainSwap 1190 only when player has level 90'),
(25, 0, 1190, 0, 0, 47, 0, 34398, 8, 0, 0, 0, 0, '', 'Quest Warlords of Draenor: The Dark Portal');

-- DB/Misc: add DEFAULT value to racemask
--
ALTER TABLE `spell_area` ALTER COLUMN `racemask` SET DEFAULT 0;

-- DB/Gossip: Maddix and Alieshor
-- 
DELETE FROM `gossip_menu` WHERE `MenuId`=8558 AND `textid`=10722;
INSERT INTO `gossip_menu` (`MenuId`,`textid`) VALUES
(8558,10722);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup` IN (8558,8560);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14,8558,7778,0,0,5,0,932,16,0,0,0,0,'',"Show gossip text if player is Friendly with The Aldor"),
(14,8558,10722,0,0,5,0,932,16,0,1,0,0,'',"Show gossip text if player is not Friendly with The Aldor"),
(14,8560,7778,0,0,5,0,934,16,0,0,0,0,'',"Show gossip text if player is Friendly with The Scryers"),
(14,8560,10723,0,0,5,0,934,16,0,1,0,0,'',"Show gossip text if player is not Friendly with The Scryers"),
(15,8558,0,0,0,5,0,932,16,0,0,0,0,'',"Show gossip menu option if player is Friendly with The Aldor"),
(15,8560,0,0,0,5,0,934,16,0,0,0,0,'',"Show gossip menu option if player is Friendly with The Scryers");

-- DB/Cleanup: Fix a few more DB Errors.
DELETE FROM `spell_script_names` WHERE `ScriptName` IN ('spell_bank_67497', 'spell_bank_67499', 'spell_launch_96185', 'spell_mulgore_funeral_offering', 'spell_68281',
'spell_bank_67496', 'spell_bank_67498', 'spell_gen_moss_covered_feet', 'spell_kezan_despawn_sharks', 'spell_rescue_drowning_watchman_68735', 'spell_round_up_horse_68903');

UPDATE `creature_template` SET `ScriptName`='' WHERE `ScriptName` IN ('npc_girocoptere', 'npc_ashley_36269', 'npc_blood_ritual_orb', 'npc_blackrock_follower', 'npc_archmage_khadgar_bridge',
'npc_archmage_khadgar', 'npc_chipie_quest_giver_end_event', 'npc_ankova_the_fallen', 'npc_tanaan_yrel_summon', 'npc_galaw', 'npc_eagle_spirit', 'npc_bleeding_hollow_sauvage',
'npc_ogron_warcrusher', 'npc_james_36268', 'npc_tanaan_mandragora', 'npc_maladaar_liadrin_tanaan_cave', 'npc_blackrock_grunt', 'npc_iron_gronnling', 'npc_cynthia_36267', 
'npc_thaelin_tanaan_questgiver', 'npc_lianne_gobelin', 'npc_generic_tanaan_guardian', 'npc_thrall_maladaar_blackrock', 'npc_gls_gob', 'npc_keli_dan_the_breaker', 'npc_meteor_gob');



-- DB/Creature: Temp fix a lot of startup errors
--
UPDATE `creature_template` SET `faction`=35 WHERE`faction`=0;

-- DB/Terrainswap: The Mission
-- Terrainswap for The Mission Alliance Pandaria Intro

-- Terrainswap Condition
DELETE FROM `conditions` WHERE `SourceEntry`=1066;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES 
(25, 0, 1066, 0, 0, 6, 0, 469, 0, 0, 0, 0, 0, '', 'Apply Terrian swap 1066 if player is Alliance'),
(25, 0, 1066, 0, 0, 47, 0, 29548, 8, 0, 0, 0, 0, '', 'Apply Terrain swap 1066 if quest 29548 is taken');

-- terrain swap defaults
DELETE FROM `terrain_swap_defaults` WHERE `TerrainSwapMap`=1066;
INSERT INTO `terrain_swap_defaults` (`MapId`, `TerrainSwapMap`, `Comment`) VALUES 
(0, 1066, 'Skyfire Stormwind Harbor');



-- DB/Conversation: Felstorm's Plea
DELETE FROM `conversation_template` WHERE `Id`=1264;
INSERT INTO `conversation_template` (`Id`, `FirstLineID`, `LastLineEndTime`, `VerifiedBuild`) VALUES
(1264, 2982, 9842, 26365);

DELETE FROM `conversation_line_template` WHERE `Id`=2982;
INSERT INTO `conversation_line_template` (`Id`, `StartTime`, `UiCameraID`, `ActorIdx`, `Flags`, `VerifiedBuild`) VALUES
(2982, 0, 0, 0, 0, 26365);

DELETE FROM `conversation_actor_template` WHERE `id`=51396;
INSERT INTO `conversation_actor_template` (`Id`, `CreatureId`, `CreatureModelId`, `VerifiedBuild`) VALUES
(51396, 102850, 67760, 26365); -- Meryl Felstorm

DELETE FROM `conversation_actors` WHERE `ConversationId`=1264;
INSERT INTO `conversation_actors` (`ConversationId`, `ConversationActorId`, `Idx`, `VerifiedBuild`) VALUES
(1264, 51396, 0, 26365); -- Full: 0x00000000000000000000000000000000 Creature/0 R3149/S9980 Map: 1220 Entry: 102700 (Meryl Felstorm) Low: 451794

-- DB/Misc: synh TC merge

UPDATE `creature_template_addon` SET `auras`=32648 WHERE `entry` IN(19698);
DELETE FROM `spell_area` WHERE `spell`=32649 AND `area`=3688;
INSERT INTO `spell_area` (`spell`,`area`,`quest_start`, `quest_end`,`aura_spell`,`racemask`,`gender`,`flags`,quest_start_status) VALUES
(32649,3688,10252,0,0,0,2,1,64);
DELETE FROM `creature_template_addon` WHERE `entry`=19879;
INSERT INTO `creature_template_addon` (`entry`,`bytes2`,`auras`) VALUES
(19879,1,"32648");
-- Prospecting loot, 4 ores are wrongly assumed to work
DELETE FROM `prospecting_loot_template`WHERE `Entry` IN (23424, 36909, 36910, 36912);
INSERT INTO `prospecting_loot_template` (`Entry`,`Item`,`Chance`,`LootMode`,`GroupId`,`Reference`,`MinCount`,`MaxCount`) VALUES
(23424,     1, 100, 1, 1,  1000, 1, 1),
(36909,     1, 100, 1, 1,  1001, 1, 1),
(36910, 46849,  75, 1, 0,     0, 1, 1),
(36910,     1,  20, 1, 0, 13005, 1, 1),
(36910,     2, 100, 1, 1,  1002, 1, 1),
(36910,     3,  75, 1, 1,  1003, 1, 1),
(36912,     1,  85, 1, 0,  1003, 1, 1),
(36912,     2, 100, 1, 1,  1004, 1, 1);

DELETE FROM `reference_loot_template` WHERE `Entry` IN (13003, 13004); -- Remove now unused references
DELETE FROM `reference_loot_template` WHERE `Entry` IN (1000, 1001, 1002, 1003, 1004);
INSERT INTO `reference_loot_template` (`Entry`,`Item`,`Chance`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`) VALUES 
(1000, 21929,   16, 1, 1, 1, 2),
(1000, 23077,   16, 1, 1, 1, 2),
(1000, 23079,   16, 1, 1, 1, 2),
(1000, 23107,   16, 1, 1, 1, 2),
(1000, 23112,   15, 1, 1, 1, 2),
(1000, 23117,   15, 1, 1, 1, 2),
(1000, 23436,    1, 1, 1, 1, 1),
(1000, 23437,    1, 1, 1, 1, 1),
(1000, 23438,    1, 1, 1, 1, 1),
(1000, 23439,    1, 1, 1, 1, 1),
(1000, 23440,    1, 1, 1, 1, 1),
(1000, 23441,    1, 1, 1, 1, 1),
(1001, 36917,   16, 1, 1, 1, 2),
(1001, 36920,   16, 1, 1, 1, 2),
(1001, 36923,   16, 1, 1, 1, 2),
(1001, 36926,   16, 1, 1, 1, 2),
(1001, 36929,   15, 1, 1, 1, 2),
(1001, 36932,   15, 1, 1, 1, 2),
(1001, 36918,    1, 1, 1, 1, 2),
(1001, 36921,    1, 1, 1, 1, 2),
(1001, 36924,    1, 1, 1, 1, 2),
(1001, 36927,    1, 1, 1, 1, 2),
(1001, 36930,    1, 1, 1, 1, 2),
(1001, 36933,    1, 1, 1, 1, 2),
(1002, 36917, 12.5, 1, 1, 1, 2),
(1002, 36920, 12.5, 1, 1, 1, 2),
(1002, 36923, 12.5, 1, 1, 1, 2),
(1002, 36926, 12.5, 1, 1, 1, 2),
(1002, 36929, 12.5, 1, 1, 1, 2),
(1002, 36932, 12.5, 1, 1, 1, 2),
(1002, 36918,    5, 1, 1, 1, 2),
(1002, 36921,    4, 1, 1, 1, 2),
(1002, 36924,    4, 1, 1, 1, 2),
(1002, 36927,    4, 1, 1, 1, 2),
(1002, 36930,    4, 1, 1, 1, 2),
(1002, 36933,    4, 1, 1, 1, 2),
(1003, 36917,    0, 1, 1, 1, 2),
(1003, 36920,    0, 1, 1, 1, 2),
(1003, 36923,    0, 1, 1, 1, 2),
(1003, 36926,    0, 1, 1, 1, 2),
(1003, 36929,    0, 1, 1, 1, 2),
(1003, 36932,    0, 1, 1, 1, 2),
(1004, 36917,   15, 1, 1, 1, 2),
(1004, 36920,   15, 1, 1, 1, 2),
(1004, 36923,   14, 1, 1, 1, 2),
(1004, 36926,   14, 1, 1, 1, 2),
(1004, 36929,   14, 1, 1, 1, 2),
(1004, 36932,   14, 1, 1, 1, 2),
(1004, 36918,    3, 1, 1, 1, 2),
(1004, 36921,    3, 1, 1, 1, 2),
(1004, 36924,    2, 1, 1, 1, 2),
(1004, 36927,    2, 1, 1, 1, 2),
(1004, 36930,    2, 1, 1, 1, 2),
(1004, 36933,    2, 1, 1, 1, 2);
-- 
DELETE FROM `item_loot_template` WHERE `Entry` = 43575 AND `Item` IN (43611,43612,43613);
INSERT INTO `item_loot_template` (`Entry`,`Item`,`Reference`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`) VALUES
(43575,43611,0,0.05,0,1,1,1,1),
(43575,43613,0,0.05,0,1,1,1,1);

-- DB/Quest: Update quests allowable classes.
UPDATE `quest_template_addon` SET `AllowableClasses`=4 WHERE `ID` IN (41009, 40952);

-- DB/Scenario: Add correct data for Battle for brokenshore
DELETE FROM `scenarios` WHERE `map`=1460;
INSERT INTO `scenarios` (map, difficulty, scenario_A, scenario_H) VALUES
(1460, 12, 1018, 1017);

-- DB/Loot: Fix prospecting from titanium and saronite
-- Prospecting loot, 4 ores are wrongly assumed to work
DELETE FROM `prospecting_loot_template`WHERE `Entry` IN (23424, 36909, 36910, 36912);
INSERT INTO `prospecting_loot_template` (`Entry`,`Item`,`Chance`,`LootMode`,`GroupId`,`Reference`,`MinCount`,`MaxCount`) VALUES
(23424,     1, 100, 1, 1,  1000, 1, 1),
(36909,     1, 100, 1, 1,  1001, 1, 1),
(36910, 46849,  75, 1, 0,     0, 1, 1),
(36910,     1,  20, 1, 0, 13005, 1, 1),
(36910,     2, 100, 1, 1,  1002, 1, 1),
(36910,     3,  75, 1, 1,  1003, 1, 1),
(36912,     1,  85, 1, 0,  1003, 1, 1),
(36912,     2, 100, 1, 1,  1004, 1, 1);

DELETE FROM `reference_loot_template` WHERE `Entry` IN (13003, 13004); -- Remove now unused references
DELETE FROM `reference_loot_template` WHERE `Entry` IN (1000, 1001, 1002, 1003, 1004);
INSERT INTO `reference_loot_template` (`Entry`,`Item`,`Chance`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`) VALUES 
(1000, 21929,   16, 1, 1, 1, 2),
(1000, 23077,   16, 1, 1, 1, 2),
(1000, 23079,   16, 1, 1, 1, 2),
(1000, 23107,   16, 1, 1, 1, 2),
(1000, 23112,   15, 1, 1, 1, 2),
(1000, 23117,   15, 1, 1, 1, 2),
(1000, 23436,    1, 1, 1, 1, 1),
(1000, 23437,    1, 1, 1, 1, 1),
(1000, 23438,    1, 1, 1, 1, 1),
(1000, 23439,    1, 1, 1, 1, 1),
(1000, 23440,    1, 1, 1, 1, 1),
(1000, 23441,    1, 1, 1, 1, 1),
(1001, 36917,   16, 1, 1, 1, 2),
(1001, 36920,   16, 1, 1, 1, 2),
(1001, 36923,   16, 1, 1, 1, 2),
(1001, 36926,   16, 1, 1, 1, 2),
(1001, 36929,   15, 1, 1, 1, 2),
(1001, 36932,   15, 1, 1, 1, 2),
(1001, 36918,    1, 1, 1, 1, 2),
(1001, 36921,    1, 1, 1, 1, 2),
(1001, 36924,    1, 1, 1, 1, 2),
(1001, 36927,    1, 1, 1, 1, 2),
(1001, 36930,    1, 1, 1, 1, 2),
(1001, 36933,    1, 1, 1, 1, 2),
(1002, 36917, 12.5, 1, 1, 1, 2),
(1002, 36920, 12.5, 1, 1, 1, 2),
(1002, 36923, 12.5, 1, 1, 1, 2),
(1002, 36926, 12.5, 1, 1, 1, 2),
(1002, 36929, 12.5, 1, 1, 1, 2),
(1002, 36932, 12.5, 1, 1, 1, 2),
(1002, 36918,    5, 1, 1, 1, 2),
(1002, 36921,    4, 1, 1, 1, 2),
(1002, 36924,    4, 1, 1, 1, 2),
(1002, 36927,    4, 1, 1, 1, 2),
(1002, 36930,    4, 1, 1, 1, 2),
(1002, 36933,    4, 1, 1, 1, 2),
(1003, 36917,    0, 1, 1, 1, 2),
(1003, 36920,    0, 1, 1, 1, 2),
(1003, 36923,    0, 1, 1, 1, 2),
(1003, 36926,    0, 1, 1, 1, 2),
(1003, 36929,    0, 1, 1, 1, 2),
(1003, 36932,    0, 1, 1, 1, 2),
(1004, 36917,   15, 1, 1, 1, 2),
(1004, 36920,   15, 1, 1, 1, 2),
(1004, 36923,   14, 1, 1, 1, 2),
(1004, 36926,   14, 1, 1, 1, 2),
(1004, 36929,   14, 1, 1, 1, 2),
(1004, 36932,   14, 1, 1, 1, 2),
(1004, 36918,    3, 1, 1, 1, 2),
(1004, 36921,    3, 1, 1, 1, 2),
(1004, 36924,    2, 1, 1, 1, 2),
(1004, 36927,    2, 1, 1, 1, 2),
(1004, 36930,    2, 1, 1, 1, 2),
(1004, 36933,    2, 1, 1, 1, 2);

-- DB: At The Enemy's Gates - Phasing
-- At The Enemy's Gates - Phasing for Icecrown -- http://www.wowhead.com/quest=13847/at-the-enemys-gates
DELETE FROM `spell_area` WHERE `quest_start` IN (13847, 13851, 13852, 13854, 13855, 13856, 13857, 13858, 13859, 13860) AND `area`=4522;
INSERT INTO `spell_area` (`spell`, `area`, `quest_start`, `quest_end`, `aura_spell`, `racemask`, `gender`, `flags`, `quest_start_status`, `quest_end_status`) VALUES 
(64576, 4522, 13847, 13847, 0, 0, 2, 1, 74, 11),
(64576, 4522, 13851, 13851, 0, 0, 2, 1, 74, 11),
(64576, 4522, 13852, 13852, 0, 0, 2, 1, 74, 11),
(64576, 4522, 13854, 13854, 0, 0, 2, 1, 74, 11),
(64576, 4522, 13855, 13855, 0, 0, 2, 1, 74, 11),
(64576, 4522, 13856, 13856, 0, 0, 2, 1, 74, 11),
(64576, 4522, 13857, 13857, 0, 0, 2, 1, 74, 11),
(64576, 4522, 13858, 13858, 0, 0, 2, 1, 74, 11),
(64576, 4522, 13859, 13859, 0, 0, 2, 1, 74, 11),
(64576, 4522, 13860, 13860, 0, 0, 2, 1, 74, 11);

-- DB/Misc: Clean up a few DBError logs
-- cleanup startup logs

DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_warr_lambs_to_the_slaughter';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_pri_phantasm';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_pri_divine_aegis';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_warr_sword_and_board';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_hun_improved_mend_pet';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_sha_lightning_shield';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_sha_earth_shield';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_dru_mark_of_the_wild';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_pri_lightwell_renew';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_shaman_windfury_weapon';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_pal_blessing_of_might';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_pal_blessing_of_kings';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_warr_retaliation';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_pri_power_word_fortitude';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_mark_of_nature';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_pri_shadow_protection';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_sha_glyph_of_shamanistic_rage';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_sha_nature_guardian';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_archimonde_drain_world_tree_dummy';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_dk_plague_strike';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_pri_pain_and_suffering_proc';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_warl_molten_core_dot';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_pri_mind_sear';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_dk_blood_gorged';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_warr_vigilance';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_warr_vigilance_trigger';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_hun_invigoration';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_sha_glyph_of_healing_wave';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_gen_dungeon_credit';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_dk_glyph_of_deaths_embrace';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_warr_improved_spell_reflection';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_gen_ds_flush_knockback';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_xt002_heart_overload_periodic';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_pri_hymn_of_hope';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_pos_ice_shards';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_putricide_slime_puddle_aura';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_halion_spawn_living_embers';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_sha_fulmination';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_springvale_forsaken_ability';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_wind_burst';

UPDATE `creature_template` SET `ScriptName`='' WHERE `entry` IN (36283, 36269, 37694, 37953, 37067, 36231, 36459, 38762, 43337, 36332, 36440, 37065, 36268,
34571, 36267, 36452, 36488, 38765, 43336, 44928, 36743, 37876, 36331, 36290, 38764, 37783, 36405, 36409, 36555, 36606, 36540, 36205, 24616, 37078, 38051, 36741);

UPDATE `creature_template` SET `ScriptName`='' WHERE `ScriptName`='npc_velen_shadowmoon_begin';
UPDATE `creature_template` SET `ScriptName`='' WHERE `ScriptName`='npc_velen_shadowmoon_follower';
-- cleanup startup logs 2

DELETE FROM `script_waypoint` WHERE `entry` IN (79219, 79218, 79206);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=21058 AND `SourceEntry`=5;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=21072 AND `SourceEntry` IN (5, 6, 7);
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=21253 AND `SourceEntry`=0;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=21312 AND `SourceEntry`=0;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=10 AND `SourceGroup`=34379 AND `SourceEntry` IN (50453, 50452);

-- DB/Phase: Handle a lot of phases for quest 34392
-- Handle all phases for quest 34392. Credits Aquadeus Trinitycore.

DELETE FROM `phase_area` WHERE `AreaId` IN (7025, 7037) AND `PhaseId` IN (3946, 3947, 3948, 4142, 4143, 4150, 4151, 3763, 3764);
INSERT INTO `phase_area` (`AreaId`, `PhaseId`, `Comment`) VALUES
(7025, 3946, 'See Dark Portal opened (Assault on the Dark Portal)'),
(7025, 3947, 'See Dark Portal half opened (Assault on the Dark Portal)'),
(7025, 3948, 'See Dark Portal almost closed (Assault on the Dark Portal)'),
(7025, 4142, 'See Northern Fel Spire enabled (Assault on the Dark Portal)'),
(7025, 4143, 'See Southern Fel Spire enabled (Assault on the Dark Portal)'),
(7025, 4150, 'See Northern Fel Spire disabled (Assault on the Dark Portal)'),
(7025, 4151, 'See Southern Fel Spire disabled (Assault on the Dark Portal)'),
(7037, 3763, 'See Cho\'gall in Fel Prison (Assault on the Dark Portal)'),
(7037, 3764, 'See Teron\'gor in Fel Prison (Assault on the Dark Portal)');

-- Conditions
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId`=26 AND `SourceGroup` = 3946 AND `SourceEntry` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES
(26, 3946, 0, 0, 0, 47, 0, 34392, 2 | 64, 0, 1, 'Apply Phase 3946 if Quest 34392 is not complete | rewarded'),
(26, 3946, 0, 0, 0, 48, 0, 272621, 0, 0, 1, 'Apply Phase 3946 if QuestObjective 272621 is not complete'),
(26, 3946, 0, 0, 0, 48, 0, 273946, 0, 0, 1, 'Apply Phase 3946 if QuestObjective 273946 is not complete');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId`=26 AND `SourceGroup` = 3947 AND `SourceEntry` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES
(26, 3947, 0, 0, 0, 47, 0, 34392, 8, 0, 0, 'Apply Phase 3947 if Quest 34392 is in progress'),
(26, 3947, 0, 0, 0, 48, 0, 272621, 0, 0, 1, 'Apply Phase 3947 if QuestObjective 272621 is not complete'),
(26, 3947, 0, 0, 0, 48, 0, 273946, 0, 0, 1, 'Apply Phase 3947 if QuestObjective 273946 is complete'),
(26, 3947, 0, 0, 1, 48, 0, 272621, 0, 0, 1, 'Apply Phase 3947 if QuestObjective 272621 is complete'),
(26, 3947, 0, 0, 1, 48, 0, 273946, 0, 0, 1, 'Apply Phase 3947 if QuestObjective 273946 is not complete');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId`=26 AND `SourceGroup` = 3948 AND `SourceEntry` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES
(26, 3948, 0, 0, 0, 47, 0, 34392, 2 | 64, 0, 0, 'Apply Phase 3948 if Quest 34392 is complete | rewarded'),
(26, 3948, 0, 0, 0, 47, 0, 34393, 2 | 64, 0, 1, 'Apply Phase 3948 if Quest 34393 is not complete | rewarded');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId`=26 AND `SourceGroup` = 4142 AND `SourceEntry` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES
(26, 4142, 0, 0, 0, 47, 0, 34392, 2 | 64, 0, 1, 'Apply Phase 4142 if Quest 34392 is not complete | rewarded'),
(26, 4142, 0, 0, 0, 48, 0, 272621, 0, 0, 1, 'Apply Phase 4142 if QuestObjective 272621 is not complete');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId`=26 AND `SourceGroup` = 4143 AND `SourceEntry` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES
(26, 4143, 0, 0, 0, 47, 0, 34392, 2 | 64, 0, 1, 'Apply Phase 4143 if Quest 34392 is not complete | rewarded'),
(26, 4143, 0, 0, 0, 48, 0, 273946, 0, 0, 1, 'Apply Phase 4143 if QuestObjective 273946 is not complete');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId`=26 AND `SourceGroup` = 4150 AND `SourceEntry` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES
(26, 4150, 0, 0, 0, 47, 0, 34392, 2 | 8 | 64, 0, 0, 'Apply Phase 4150 if Quest 34392 is in progress | complete | rewarded'),
(26, 4150, 0, 0, 0, 48, 0, 272621, 0, 0, 0, 'Apply Phase 4150 if QuestObjective 272621 is complete');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId`=26 AND `SourceGroup` = 4151 AND `SourceEntry` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES
(26, 4151, 0, 0, 0, 47, 0, 34392, 2 | 8 | 64, 0, 0, 'Apply Phase 4151 if Quest 34392 is in progress | complete | rewarded'),
(26, 4151, 0, 0, 0, 48, 0, 273946, 0, 0, 0, 'Apply Phase 4151 if QuestObjective 273946 is complete');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId`=26 AND `SourceGroup` = 3763 AND `SourceEntry` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES
(26, 3763, 0, 0, 0, 47, 0, 34392, 2 | 64, 0, 1, 'Apply Phase 3763 if Quest 34392 is not in progress | complete | rewarded'),
(26, 3763, 0, 0, 0, 48, 0, 272621, 0, 0, 1, 'Apply Phase 3763 if QuestObjective 272621 is not complete');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId`=26 AND `SourceGroup` = 3764 AND `SourceEntry` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES
(26, 3764, 0, 0, 0, 47, 0, 34392, 2 | 64, 0, 1, 'Apply Phase 3764 if Quest 34392 is not in progress | complete | rewarded'),
(26, 3764, 0, 0, 0, 48, 0, 273946, 0, 0, 1, 'Apply Phase 3764 if QuestObjective 273946 is not complete');

-- DB/Loot: Remove some wrong loots
-- 
-- These items should be contained only in Decoded True Believer Clippings
DELETE FROM `creature_loot_template` WHERE `Item` IN (20518,20531,20532,20541,20545,20546,20552,20676,20677,20678,20679);

-- DB/Creature: Initial Alliance Garrison Intro Creature Text
-- Creature Text
SET @GROUP_ID := 0;
SET @ID := 0;
DELETE FROM `creature_text` WHERE `CreatureID` IN (77209, 79241, 79243, 79436, 79470, 79567, 79635, 79655, 79656, 79796, 82098, 82125);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(77209, @GROUP_ID+0, @ID+0, 'Thanks to you we have a terrific foothold here in Shadowmoon Valley.', 12, 0, 100, 396, 0, 0, 0, 0, 'Baros Alexston to Player'),
(79241, @GROUP_ID+0, @ID+0, 'I do hope my trust in your people is not misplaced.', 12, 0, 100, 0, 0, 45382, 0, 0, 'Prophet Velen to Player'),
(79243, @GROUP_ID+0, @ID+0, 'If you mark those trees, Shelly\'s lumberjacks will do the rest.', 12, 0, 100, 1, 0, 43525, 0, 0, 'Baros Alexston to Player'),
(79243, @GROUP_ID+1, @ID+1, 'Giant killer ravens... I have a feeling it\'s going to be a long, cold night.', 12, 0, 100, 1, 0, 43527, 0, 0, 'Baros Alexston to Player'),
(79243, @GROUP_ID+2, @ID+2, 'An excellent choice of lumber, if I do say so myself.', 12, 0, 100, 1, 0, 43526, 0, 0, 'Baros Alexston to Player'),
(79243, @GROUP_ID+3, @ID+3, 'Impressive work, commander. I know I\'ll sleep a lot better without those giant killer birds flying around.', 12, 0, 100, 1, 0, 43528, 0, 0, 'Baros Alexston to Player'),
(79243, @GROUP_ID+4, @ID+4, 'Let me know when you are ready to start construction, commander.', 12, 0, 100, 1, 0, 0, 0, 0, 'Baros Alexston to Player'),
(79436, @GROUP_ID+0, @ID+0, 'This is it, boys! Let\'s break some ground and take this world for the Alliance!', 12, 0, 100, 5, 0, 43531, 0, 0, 'Baros Alexston to Player'),
(79470, @GROUP_ID+0, @ID+0, 'Plant your banner, and claim your destiny.', 12, 0, 100, 25, 0, 44819, 0, 0, 'Vindicator Maraad to Player'),
(79470, @GROUP_ID+1, @ID+1, 'I assure you, my Prophet, the commander we\'ve chosen represents the very best of the Alliance.', 12, 0, 100, 1, 0, 44821, 0, 0, 'Vindicator Maraad to Player'),
(79567, @GROUP_ID+0, @ID+0, 'With the giant defeated we shouldn\'t have any more trouble clearing out the area.', 12, 0, 100, 1, 0, 45611, 0, 0, 'Yrel to Player'),
(79635, @GROUP_ID+0, @ID+0, 'It is good to see you, my child. My people welcome your aid, champion. Come with me.', 12, 0, 100, 396, 0, 45389, 0, 0, 'Prophet Velen to Player'),
(79635, @GROUP_ID+1, @ID+1, 'We will deal with one problem at a time. First, we must settle your people.', 12, 0, 100, 1, 0, 45391, 0, 0, 'Prophet Velen to Player'),
(79655, @GROUP_ID+0, @ID+2, 'Prophet, I must warn you: the Iron Horde intends to strike out against all who oppose him. We must prepare our defenses!', 12, 0, 100, 1, 0, 44825, 0, 0, 'Vindicator Maraad to Player'),
(79656, @GROUP_ID+0, @ID+0, 'Prophet, this hero - and many others from another world - have come to aid us.', 12, 0, 100, 1, 0, 45636, 0, 0, 'Yrel to Player'),
(79796, @GROUP_ID+0, @ID+0, 'Are you going to be okay?', 12, 0, 100, 71, 0, 0, 0, 0, 'Draenei Refugee'),
(82098, @GROUP_ID+0, @ID+0, 'Alright, come on through. Steady... Steady...', 12, 0, 100, 0, 0, 44537, 0, 0, 'Foreman Zipfizzle to Player'),
(82125, @GROUP_ID+0, @ID+0, 'I can open up a portal to Stormwind only briefly.', 12, 0, 100, 0, 0, 44990, 0, 0, 'Archmage Khadgar to Player');

-- DB/Loot: Add missing item to Reinforced Junkbox
-- 
DELETE FROM `item_loot_template` WHERE `Entry` = 43575 AND `Item` IN (43611,43612,43613);
INSERT INTO `item_loot_template` (`Entry`,`Item`,`Reference`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`) VALUES
(43575,43611,0,0.05,0,1,1,1,1),
(43575,43613,0,0.05,0,1,1,1,1);

-- DB/Misc: synh @Darking work
-- quest 37656
-- Eye See You

-- DB/Spell: Recently Bandaged debuff shouldn't break stealth
-- Recently Bandaged
DELETE FROM `spell_custom_attr` WHERE `entry` = 11196;
INSERT INTO `spell_custom_attr` (`entry`, `attributes`) VALUES
(11196, 0x40);

-- DB/Gossip: Apprentice Shatharia and Magister Quallestis
-- 
DELETE FROM `gossip_menu` WHERE `MenuId`=7192 AND `textid`=8473;
DELETE FROM `gossip_menu` WHERE `MenuId`=7194 AND `textid`=8475;
INSERT INTO `gossip_menu` (`MenuId`, `textid`, `VerifiedBuild`) VALUES
(7192, 8473, 0),
(7194, 8475, 0);

DELETE FROM `npc_text` WHERE `ID`=8473;
INSERT INTO `npc_text` (`ID`, `Probability0`,`BroadcastTextID0`) VALUES
(8473, 100, 12182);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=14 AND `SourceGroup` IN (7192, 7194);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `comment`) VALUES
(14, 7192, 8472, 0, 0, 8, 0, 9207, 0, 0, 1, 0, 0, "", "Gossip text requires quest Underlight Ore Samples NOT rewarded"),
(14, 7192, 8473, 0, 0, 8, 0, 9207, 0, 0, 0, 0, 0, "", "Gossip text requires quest Underlight Ore Samples rewarded"),
(14, 7194, 8474, 0, 0, 8, 0, 9207, 0, 0, 1, 0, 0, "", "Gossip text requires quest Underlight Ore Samples NOT rewarded"),
(14, 7194, 8475, 0, 0, 8, 0, 9207, 0, 0, 0, 0, 0, "", "Gossip text requires quest Underlight Ore Samples rewarded");

UPDATE `quest_offer_reward` SET `RewardText`="My apprentice was unable to take care of this herself?  I shall have a word with her when she returns then, gnolls or not.  Speaking of which, why didn't she return with you?$B$B<The magister sighs.>$B$BThat one is a handful, and is going to be quite a challenge to properly train.  Thank you, for bringing these samples to me.  We are hoping that we can uncover some special property from them that will help in the fight against the Scourge.$B$BPlease take this coin as a token of my appreciation." WHERE `ID`=9207;

-- DB/World: Add character templates
DELETE FROM `character_template` WHERE `ID` IN (37, 38);
INSERT INTO `character_template` (`ID`, `Name`, `Description`, `Level`) VALUES
(37, '90 level character', 'Create character with level 90', 90),
(38, '100 level character', 'Create character with level 100', 100);

DELETE FROM `character_template_class` WHERE `TemplateId` IN (37, 38);
INSERT INTO `character_template_class` (`TemplateId`, `FactionGroup`, `Class`) VALUES
(37, 3, 1),
(37, 3, 2),
(37, 3, 3),
(37, 3, 4),
(37, 3, 5),
(37, 3, 6),
(37, 3, 7),
(37, 3, 8),
(37, 3, 9),
(37, 3, 10),
(37, 3, 11),
(37, 3, 12),
(37, 5, 1),
(37, 5, 2),
(37, 5, 3),
(37, 5, 4),
(37, 5, 5),
(37, 5, 6),
(37, 5, 7),
(37, 5, 8),
(37, 5, 9),
(37, 5, 10),
(37, 5, 11),
(37, 5, 12),
(38, 3, 1),
(38, 3, 2),
(38, 3, 3),
(38, 3, 4),
(38, 3, 5),
(38, 3, 6),
(38, 3, 7),
(38, 3, 8),
(38, 3, 9),
(38, 3, 10),
(38, 3, 11),
(38, 3, 12),
(38, 5, 1),
(38, 5, 2),
(38, 5, 3),
(38, 5, 4),
(38, 5, 5),
(38, 5, 6),
(38, 5, 7),
(38, 5, 8),
(38, 5, 9),
(38, 5, 10),
(38, 5, 11),
(38, 5, 12);

-- DB/Creature: Greatfather Aldrimus

UPDATE `creature_template_addon` SET `auras`=32648 WHERE `entry` IN(19698);
DELETE FROM `spell_area` WHERE `spell`=32649 AND `area`=3688;
INSERT INTO `spell_area` (`spell`,`area`,`quest_start`, `quest_end`,`aura_spell`,`racemask`,`gender`,`flags`,quest_start_status) VALUES
(32649,3688,10252,0,0,0,2,1,64);
DELETE FROM `creature_template_addon` WHERE `entry`=19879;
INSERT INTO `creature_template_addon` (`entry`,`bytes2`,`auras`) VALUES
(19879,1,"32648");

-- DB/Creature: Fix a type on creature text related to Lord Thorval
-- 
UPDATE `creature_text`SET `CreatureID`=28472 WHERE `CreatureID` IN(2847206);

-- DB/Misc: More valsharah
UPDATE `creature_template` SET `VehicleId`=4120 WHERE `entry`=91465;
UPDATE `creature_template` SET `VehicleId`=91465 WHERE `entry`=94588;

DELETE FROM `vehicle_template_accessory` WHERE (`entry`=91465 AND `seat_id`=1);
INSERT INTO `vehicle_template_accessory` (`entry`, `accessory_entry`, `seat_id`, `minion`, `description`, `summontype`, `summontimer`) VALUES
(91465, 94588, 1, 0, '91465 - 94588', 0, 0); -- 91465 - 94588

DELETE FROM `creature_text` WHERE `CreatureID`=94588 AND `GroupID` IN (0, 1, 2, 3, 4, 5);
DELETE FROM `creature_text` WHERE `CreatureID`=91465;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(91465, 0, 0, 'Follow me.', 12, 0, 100, 0, 0, 52741, 0, 0, 'Malfurion Stormrage to Player'),
(94588, 0, 0, 'Ahh, Val\'sharah...', 12, 0, 100, 1, 0, 52735, 0, 0, 'Malfurion Stormrage to Malfurion Stormrage'),
(94588, 1, 1, 'Every step in this forest brings back precious memories.', 12, 0, 100, 0, 0, 52358, 0, 0, 'Malfurion Stormrage to Malfurion Stormrage'),
(94588, 2, 2, 'Ages ago, the first druids molded this land to be a reflection of the Emerald Dream.', 12, 0, 100, 0, 0, 52359, 0, 0, 'Malfurion Stormrage to Malfurion Stormrage'),
(94588, 3, 3, 'Merely an echo, but Val\'sharah is as close to the Dream as this world can come.', 12, 0, 100, 0, 0, 52360, 0, 0, 'Malfurion Stormrage to Malfurion Stormrage'),
(94588, 4, 4, 'Make ready, hero. We shall soon stand in the presence of the Lord of the Forest.', 12, 0, 100, 0, 0, 52277, 0, 0, 'Malfurion Stormrage to Malfurion Stormrage');

-- DB/Creature Goblin Assassin
UPDATE creature_template SET name = 'Goblin Assassin', faction = 7, npcflag = 0, unit_flags = 0, unit_flags2 = 2048, unit_flags3 = 0, dynamicflags = 4, flags_extra = 0, AIName = 'SmartAI', ScriptName = '' WHERE entry = 50039;

-- DB/Misc: fixed zone Stormheim template date
DELETE FROM `conversation_actors` WHERE (`ConversationId`=2257 AND `ConversationActorId`=53867 AND `Idx`=0) OR (`ConversationId`=2586 AND `ConversationActorId`=53727 AND `Idx`=0) OR (`ConversationId`=2844 AND `ConversationActorId`=49656 AND `Idx`=0) OR (`ConversationId`=2256 AND `ConversationActorId`=50552 AND `Idx`=0) OR (`ConversationId`=3623 AND `Idx`=0) OR (`ConversationId`=2849 AND `Idx`=1) OR (`ConversationId`=2849 AND `Idx`=0) OR (`ConversationId`=2253 AND `ConversationActorId`=50552 AND `Idx`=0) OR (`ConversationId`=2336 AND `Idx`=0) OR (`ConversationId`=2336 AND `Idx`=1) OR (`ConversationId`=2529 AND `ConversationActorId`=53622 AND `Idx`=0) OR (`ConversationId`=2671 AND `ConversationActorId`=53867 AND `Idx`=0) OR (`ConversationId`=2251 AND `ConversationActorId`=50552 AND `Idx`=0) OR (`ConversationId`=1867 AND `Idx`=1) OR (`ConversationId`=1867 AND `Idx`=0) OR (`ConversationId`=775 AND `ConversationActorId`=50369 AND `Idx`=0) OR (`ConversationId`=2258 AND `ConversationActorId`=50552 AND `Idx`=0) OR (`ConversationId`=778 AND `ConversationActorId`=50369 AND `Idx`=0) OR (`ConversationId`=2237 AND `ConversationActorId`=53077 AND `Idx`=0) OR (`ConversationId`=2259 AND `ConversationActorId`=50552 AND `Idx`=0) OR (`ConversationId`=777 AND `ConversationActorId`=50369 AND `Idx`=0) OR (`ConversationId`=2550 AND `Idx`=0) OR (`ConversationId`=773 AND `ConversationActorId`=50369 AND `Idx`=0) OR (`ConversationId`=3593 AND `Idx`=1) OR (`ConversationId`=3593 AND `Idx`=0) OR (`ConversationId`=776 AND `ConversationActorId`=50369 AND `Idx`=0) OR (`ConversationId`=2260 AND `ConversationActorId`=50552 AND `Idx`=0) OR (`ConversationId`=2255 AND `ConversationActorId`=50552 AND `Idx`=0) OR (`ConversationId`=2650 AND `Idx`=0) OR (`ConversationId`=2845 AND `ConversationActorId`=49656 AND `Idx`=0) OR (`ConversationId`=2252 AND `ConversationActorId`=50552 AND `Idx`=0) OR (`ConversationId`=2338 AND `Idx`=1) OR (`ConversationId`=2338 AND `Idx`=0) OR (`ConversationId`=2339 AND `Idx`=1) OR (`ConversationId`=2339 AND `Idx`=0) OR (`ConversationId`=2542 AND `Idx`=1) OR (`ConversationId`=2542 AND `Idx`=0) OR (`ConversationId`=2439 AND `ConversationActorId`=49664 AND `Idx`=0) OR (`ConversationId`=2846 AND `Idx`=0) OR (`ConversationId`=1875 AND `Idx`=0) OR (`ConversationId`=1875 AND `Idx`=1) OR (`ConversationId`=774 AND `ConversationActorId`=50369 AND `Idx`=0) OR (`ConversationId`=3624 AND `Idx`=0) OR (`ConversationId`=2254 AND `ConversationActorId`=50552 AND `Idx`=0) OR (`ConversationId`=2247 AND `ConversationActorId`=53077 AND `Idx`=0);
INSERT INTO `conversation_actors` (`ConversationId`, `ConversationActorId`, `Idx`, `VerifiedBuild`) VALUES
(2257, 53867, 0, 23420),
(2586, 53727, 0, 23420),
(2844, 49656, 0, 23420),
(2256, 50552, 0, 23420),
(2253, 50552, 0, 23420),
(2529, 53622, 0, 23420),
(2671, 53867, 0, 23420),
(2251, 50552, 0, 23420),
(775, 50369, 0, 23420),
(2258, 50552, 0, 23420),
(778, 50369, 0, 23420),
(2237, 53077, 0, 23420),
(2259, 50552, 0, 23420),
(777, 50369, 0, 23420),
(773, 50369, 0, 23420),
(776, 50369, 0, 23420),
(2260, 50552, 0, 23420),
(2255, 50552, 0, 23420),
(2845, 49656, 0, 23420),
(2252, 50552, 0, 23420),
(2439, 49664, 0, 23420),
(774, 50369, 0, 23420),
(2254, 50552, 0, 23420),
(2247, 53077, 0, 23420);


DELETE FROM `conversation_actor_template` WHERE `Id` IN (53867, 53727, 49656, 50552, 53622, 50369, 53077, 49664);
INSERT INTO `conversation_actor_template` (`Id`, `CreatureId`, `CreatureModelId`, `VerifiedBuild`) VALUES
(53867, 91387, 65043, 23420),
(53727, 93231, 65138, 23420),
(49656, 98174, 68213, 23420),
(50552, 91387, 65043, 23420),
(53622, 91556, 62280, 23420),
(50369, 96257, 25217, 23420),
(53077, 96254, 64208, 23420),
(49664, 96254, 64208, 23420);


DELETE FROM `conversation_line_template` WHERE `Id` IN (4753, 5427, 5924, 4752, 8118, 5931, 5932, 4749, 4939, 4938, 4937, 5345, 5344, 5343, 5614, 5426, 4747, 3960, 3959, 3958, 3957, 3955, 1839, 4754, 1842, 4711, 4710, 4755, 1841, 5379, 1837, 8041, 8040, 8039, 8038, 1840, 4756, 4751, 5565, 5564, 5926, 4748, 4944, 4943, 4947, 4946, 5365, 5364, 5366, 5162, 5928, 5927, 5428, 3973, 3972, 3970, 1838, 8119, 4750, 4743, 4742, 4741, 4740, 5925);
INSERT INTO `conversation_line_template` (`Id`, `StartTime`, `UiCameraID`, `ActorIdx`, `Flags`, `VerifiedBuild`) VALUES
(4753, 0, 620, 0, 1, 23420),
(5427, 0, 601, 0, 0, 23420),
(5924, 0, 149, 0, 0, 23420),
(4752, 0, 620, 0, 0, 23420),
(8118, 0, 690911645, 0, 0, 23420),
(5931, 2000, 0, 1, 0, 23420),
(5932, 0, 0, 0, 0, 23420),
(4749, 0, 620, 0, 0, 23420),
(4939, 2693, 0, 0, 1, 23420),
(4938, 0, 0, 1, 1, 23420),
(4937, 0, 0, 0, 1, 23420),
(5345, 14905, 134, 0, 0, 23420),
(5344, 7253, 134, 0, 0, 23420),
(5343, 0, 134, 0, 0, 23420),
(5614, 0, 620, 0, 0, 23420),
(5426, 0, 601, 0, 0, 23420),
(4747, 0, 620, 0, 0, 23420),
(3960, 24434, 833283456, 1, 0, 23420),
(3959, 13558, 833283456, 1, 0, 23420),
(3958, 10498, 833283456, 0, 0, 23420),
(3957, 4337, 833283456, 1, 0, 23420),
(3955, 0, 833283456, 0, 0, 23420),
(1839, 0, 598, 0, 0, 23420),
(4754, 0, 620, 0, 0, 23420),
(1842, 0, 598, 0, 0, 23420),
(4711, 4511, 134, 0, 0, 23420),
(4710, 0, 134, 0, 0, 23420),
(4755, 0, 620, 0, 0, 23420),
(1841, 0, 598, 0, 0, 23420),
(5379, 0, 1465, 0, 0, 23420),
(1837, 0, 598, 0, 0, 23420),
(8041, 14300, 833290952, 1, 0, 23420),
(8040, 9800, 833290952, 0, 0, 23420),
(8039, 6050, 833290952, 1, 0, 23420),
(8038, 0, 833290952, 0, 0, 23420),
(1840, 0, 598, 0, 0, 23420),
(4756, 0, 620, 0, 0, 23420),
(4751, 0, 620, 0, 0, 23420),
(5565, 7082, 4290027536, 0, 0, 23420),
(5564, 0, 4290027536, 0, 0, 23420),
(5926, 0, 149, 0, 0, 23420),
(4748, 0, 620, 0, 0, 23420),
(4944, 3064, 0, 1, 0, 23420),
(4943, 0, 0, 0, 0, 23420),
(4947, 3537, 0, 1, 0, 23420),
(4946, 0, 0, 0, 0, 23420),
(5365, 7091, 4290027536, 1, 0, 23420),
(5364, 2000, 4290027536, 1, 0, 23420),
(5366, 0, 4290027536, 0, 0, 23420),
(5162, 0, 134, 0, 0, 23420),
(5928, 5844, 0, 0, 0, 23420),
(5927, 0, 0, 0, 0, 23420),
(5428, 0, 601, 0, 0, 23420),
(3973, 14674, 833286496, 0, 0, 23420),
(3972, 9090, 833286496, 1, 0, 23420),
(3970, 0, 833286496, 0, 0, 23420),
(1838, 0, 598, 0, 0, 23420),
(8119, 0, 0, 0, 0, 23420),
(4750, 0, 620, 0, 0, 23420),
(4743, 22355, 134, 0, 0, 23420),
(4742, 15243, 134, 0, 0, 23420),
(4741, 5034, 134, 0, 0, 23420),
(4740, 0, 134, 0, 0, 23420),
(5925, 0, 149, 0, 0, 23420);


DELETE FROM `conversation_template` WHERE `Id` IN (2339, 2338, 3593, 2849, 2846, 2845, 2260, 2259, 2258, 2257, 2256, 2255, 2254, 2253, 2252, 2251, 2671, 1867, 1875, 2650, 2586, 2336, 2247, 3623, 3624, 2542, 2550, 2529, 775, 774, 773, 778, 777, 776, 2439, 2237);
INSERT INTO `conversation_template` (`Id`, `FirstLineID`, `LastLineEndTime`, `VerifiedBuild`) VALUES
(2339, 4946, 0, 23420),
(2338, 4943, 0, 23420),
(3593, 8038, 0, 23420),
(2849, 5932, 0, 23420),
(2846, 5927, 0, 23420),
(2845, 5926, 0, 23420),
(2260, 4756, 0, 23420),
(2259, 4755, 0, 23420),
(2258, 4754, 0, 23420),
(2257, 4753, 0, 23420),
(2256, 4752, 0, 23420),
(2255, 4751, 0, 23420),
(2254, 4750, 0, 23420),
(2253, 4749, 0, 23420),
(2252, 4748, 0, 23420),
(2251, 4747, 0, 23420),
(2671, 5614, 0, 23420),
(1867, 3955, 0, 23420),
(1875, 3970, 0, 23420),
(2650, 5564, 0, 23420),
(2586, 5428, 0, 23420),
(2336, 4937, 0, 23420),
(2247, 4740, 0, 23420),
(3623, 8118, 0, 23420),
(3624, 8119, 0, 23420),
(2542, 5366, 0, 23420),
(2550, 5379, 0, 23420),
(2529, 5343, 0, 23420),
(775, 1839, 0, 23420),
(774, 1838, 0, 23420),
(773, 1837, 0, 23420),
(778, 1842, 0, 23420),
(777, 1841, 0, 23420),
(776, 1840, 0, 23420),
(2439, 5162, 0, 23420),
(2237, 4710, 0, 23420);


DELETE FROM `gameobject_template_addon` WHERE `entry` IN (243455 /*Plant Explosives*/, 266054 /*Keg of Grog*/, 245668 /*Whelp Cage*/, 245672 /*Whelp Cage*/);
INSERT INTO `gameobject_template_addon` (`entry`, `faction`, `flags`) VALUES
(243455, 0, 262144), -- Plant Explosives
(266054, 0, 262144), -- Keg of Grog
(245668, 0, 4), -- Whelp Cage
(245672, 0, 5); -- Whelp Cage

UPDATE `gameobject_template_addon` SET `flags`=17 WHERE `entry`=247421; -- Powder Keg
UPDATE `gameobject_template_addon` SET `flags`=1 WHERE `entry`=243570; -- Shieldmaiden Idol
UPDATE `gameobject_template_addon` SET `flags`=4 WHERE `entry`=243454; -- Gilnean Heavy Explosive
UPDATE `gameobject_template_addon` SET `flags`=1 WHERE `entry`=244703; -- Nether Circle
UPDATE `gameobject_template_addon` SET `flags`=1 WHERE `entry`=244730; -- Nether Circle
UPDATE `gameobject_template_addon` SET `flags`=1 WHERE `entry`=244731; -- Nether Circle
UPDATE `gameobject_template_addon` SET `flags`=1 WHERE `entry`=244733; -- Nether Circle
UPDATE `gameobject_template_addon` SET `flags`=1 WHERE `entry`=244704; -- Tideskorn Banner
UPDATE `gameobject_template_addon` SET `flags`=5 WHERE `entry`=244565; -- Kvaldir Spoils
UPDATE `gameobject_template_addon` SET `flags`=1 WHERE `entry`=251189; -- Plate of Leftovers
UPDATE `gameobject_template_addon` SET `flags`=262145 WHERE `entry`=240650; -- Ritual Circle
UPDATE `gameobject_template_addon` SET `flags`=262145 WHERE `entry`=244337; -- Ritual Circle
UPDATE `gameobject_template_addon` SET `flags`=262145 WHERE `entry`=244336; -- Ritual Circle
UPDATE `gameobject_template_addon` SET `flags`=262145 WHERE `entry`=244335; -- Ritual Circle
UPDATE `gameobject_template_addon` SET `flags`=2113540 WHERE `entry`=241460; -- Climbing Treads
UPDATE `gameobject_template_addon` SET `flags`=5 WHERE `entry`=245670; -- Whelp Cage
UPDATE `gameobject_template_addon` SET `flags`=2113540 WHERE `entry`=241462; -- Oiled Cloak
UPDATE `gameobject_template_addon` SET `flags`=262149 WHERE `entry`=243817; -- Powered Console
UPDATE `gameobject_template_addon` SET `flags`=1 WHERE `entry`=243808; -- Unpowered Console
UPDATE `gameobject_template_addon` SET `flags`=5 WHERE `entry`=243841; -- Bloodtotem Standard
UPDATE `gameobject_template_addon` SET `flags`=2113540 WHERE `entry`=249890; -- Tigrid's Arkhana
UPDATE `gameobject_template_addon` SET `flags`=4 WHERE `entry`=244453; -- Cullen's Scouting Report

DELETE FROM `quest_offer_reward` WHERE `ID` IN (42483 /*Put It All on Red*/, 39786 /*A Stone Cold Gamble*/, 39792 /*A Stack of Racks*/, 39793 /*Only the Finest*/, 39787 /*Rigging the Wager*/, 42447 /*Dances With Ravenbears*/, 42446 /*Singed Feathers*/, 42445 /*Nithogg's Tribute*/, 42444 /*Plight of the Blackfeather*/, 38882 /*A New Life for Undeath*/, 39155 /*Becoming the Ascendant*/, 38878 /*Shielded Secrets*/, 39154 /*To Skold-Ashil*/, 38873 /*Clear the Deck!*/, 39153 /*Dreadwake's Dilemma*/, 39385 /*A Gift for Greymane*/, 38872 /*The Dark Lady's Bidding*/, 39789 /*Eating Into Our Business*/, 38618 /*Above the Winter Moonlight*/, 38617 /*Another Way*/, 38615 /*Impalement Insurance*/, 38614 /*To Weather the Storm*/, 38616 /*Built to Scale*/, 38613 /*No Wings Required*/, 38612 /*A Grapple a Day*/, 38611 /*Will of the Thorignir*/, 38459 /*The Ancient Trials*/, 38317 /*Masters of Disguise*/, 38308 /*Eyes in the Overlook*/, 38362 /*A Grim Trophy*/, 38360 /*The Windrunner's Fate*/, 38361 /*Wrath of the Blightcaller*/, 38332 /*The Ranger Lord*/, 38358 /*Pump it Up*/, 38357 /*Side Effects May Include Mild Undeath*/);
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(42483, 0, 0, 0, 0, 0, 0, 0, 0, '<A note from the goblins is left behind, along with an old magnifying glass>$B$BI wish I coulda been there to see the look on your face, but Raz and I got bigger fish to fry!$B$BThanks for the trophies and meat. I\'m sure they\'ll fetch a nice sum on the black market, along with all the goodies we got from those stupid tauren! I\'m sure they won\'t be needing them any more!$B$BSo long sucker!', 23420), -- Put It All on Red
(39786, 0, 0, 0, 0, 0, 0, 0, 0, 'Well, well. I half expected to find your statue on the riverbank. You\'re gonna get a nice payout once those tauren get back...$B$BYou haven\'t seen them around, have you?', 23420), -- A Stone Cold Gamble
(39792, 0, 0, 0, 0, 0, 0, 0, 0, 'Oh hey, it\'s... you again! Of course you didn\'t have any trouble with those musken. You\'re a big, tough hero after all!$B$BThe tauren still aren\'t back, though. I\'m a bit worried that they may have gone off and hunted a bit more that they can chew.$B$BOh, I\'ll take those ribs, though. What do you want for em?', 23420), -- A Stack of Racks
(39793, 0, 0, 0, 0, 0, 0, 0, 0, 'You\'re back? $B$BI mean... hey, you\'re back!$B$BWell, the tauren haven\'t come back yet, but no worries, I\'ll take that stuff off your hands! Let me show you some of my prime trade goods.', 23420), -- Only the Finest
(39787, 0, 0, 0, 0, 0, 0, 0, 0, 'So you took him out, eh? Those tauren are gonna be so jealous when they get back!  \n\nNaturally, you\'ll have to wait till the tauren get back and pay their wager before I can give you your cut. But in the meantime, I\'ve got another target for you.', 23420), -- Rigging the Wager
(42447, 0, 0, 0, 0, 0, 0, 0, 0, 'It seems that Nithogg wasn\'t interested in the ravenbears\' tribute.$B$BIt\'s probably a good idea to get out of here before he comes back...', 23420), -- Dances With Ravenbears
(42446, 0, 0, 0, 0, 0, 0, 0, 0, 'The Blackfeather chieftain bows respectfully to you. $B$BYou have helped ensure the survival of his tribe.', 23420), -- Singed Feathers
(42445, 0, 0, 0, 0, 0, 0, 0, 0, 'Caw! Caw! $B$B<The ravenbear chieftain flaps his wings excitedly when he sees the reagents you\'ve brought.>', 23420), -- Nithogg's Tribute
(42444, 0, 0, 0, 0, 0, 0, 0, 0, 'Caw?$B$B<The ravenbear chieftain seems preoccupied with the gathering of reagents for some sort of ritual. Perhaps you could help him?>', 23420), -- Plight of the Blackfeather
(38882, 0, 0, 0, 0, 0, 0, 0, 0, 'It looks like we underestimated Greymane\'s tenacity - a mistake that cost the Forsaken dearly. $B$BThis Eyir cannot hide for long, however. If I must I will hunt her through the Halls of Valor! $B$BGo now, $c. I will call upon you when you are needed.', 23420), -- A New Life for Undeath
(39155, 0, 0, 0, 0, 0, 0, 0, 0, 'The hero returns, and with the barrier disabled. I will see that you are commended for this. $B$BBut first, we must claim this vault!', 23420), -- Becoming the Ascendant
(38878, 0, 0, 0, 0, 0, 0, 0, 0, 'I would hope that you bring me some good news, $c. $B$BFor both of our sake.', 23420), -- Shielded Secrets
(39154, 0, 0, 0, 0, 0, 0, 0, 0, 'You seem surprised to find me here? I was surprised as well, to find that my forces were unable to even breach the city of these cursed vrykul! $B$BThe time has come to employ some different tactics, and your arrival couldn\'t have been more fortuitous.', 23420), -- To Skold-Ashil
(38873, 0, 0, 0, 0, 0, 0, 0, 0, 'Hah! Greymane will find his cannons aren\'t so useful when the blight takes his crew!', 23420), -- Clear the Deck!
(39153, 0, 0, 0, 0, 0, 0, 0, 0, 'It looks like the ravens will feast on worgen flesh today, $c.$B$BWell done.', 23420), -- Dreadwake's Dilemma
(39385, 0, 0, 0, 0, 0, 0, 0, 0, 'By the Dark Lady\'s favor, you did it! I witnessed the explosion from here - there\'s no way that Greymane could have survived such destruction! $B$BYou have done a great deed today for the Forsaken. Rest assured, it will be remembered.', 23420), -- A Gift for Greymane
(38872, 0, 0, 0, 0, 0, 0, 0, 0, 'Finally someone competent arrives at this sorry excuse for an outpost. $B$BOur efforts to complete Sylvanas\'s mission are at a standstill, but now we have even more pressing matters on our hands.', 23420), -- The Dark Lady's Bidding
(39789, 0, 0, 0, 0, 0, 0, 0, 0, 'Oh, hey! You must be lookin for them tauren was camped here. They just stepped out for a bit, but Snaggle here and I - we can take care of ya!$B$BYou say they were gonna pay you for killin\' some worgs, huh? No prob, bub!$B$BI ain\'t got a lot of gold, but these goods are pretty valuable. Take your pick!', 23420), -- Eating Into Our Business
(38618, 1, 0, 0, 0, 0, 0, 0, 0, 'You are here for the trial? I\'m afraid you might be too late.$B$BThis battle with these Felskorn has taken its toll. I am too weak to grant you the power you seek...$B$BBut perhaps you may be able to help...', 23420), -- Above the Winter Moonlight
(38617, 4, 0, 0, 0, 0, 0, 0, 0, 'What a fight! $B$BAnd here I thought this place would be boring.', 23420), -- Another Way
(38615, 5, 0, 0, 0, 0, 0, 0, 0, 'We won\'t have to worry about those scrap heaps anymore! $B$BIt looks like we\'ve got a hitch in our plan though. That bridge was the only way up.', 23420), -- Impalement Insurance
(38614, 1, 0, 0, 0, 0, 0, 0, 0, 'Well, the sizing might be a bit big, but I think you can make them work. $B$BThat path doesn\'t look pleasant, so it\'ll help to be prepared.', 23420), -- To Weather the Storm
(38616, 1, 0, 0, 0, 0, 0, 0, 0, 'Good thinking. If the vrykul can use the drake scales for their armor, why not us? $B$BIt shouldn\'t be too tough to work this into something serviceable.', 23420), -- Built to Scale
(38613, 1, 0, 0, 0, 0, 0, 0, 0, 'Those vrykul were so distracted seeing someone flying through their village, they never noticed me slip by. $B$BI hope that didn\'t get you too much unwanted attention.', 23420), -- No Wings Required
(38612, 1, 0, 0, 0, 0, 0, 0, 0, 'Yes, that should do quite nicely.', 23420), -- A Grapple a Day
(38611, 5, 0, 0, 0, 0, 0, 0, 0, 'These vrykul are so boring! Why does Nathanos send me on missions like this? Does he really think the Aegis is here?$B$BI hope you\'ve come to stir up some trouble.', 23420), -- Will of the Thorignir
(38459, 0, 0, 0, 0, 0, 0, 0, 0, 'I\'m sure your head is filled with questions. Answers will come, in time.$B$BI am Havi, and my words are those of the Valarjar - the glorious keepers of the Halls of Valor. $B$BYou will need my help if it is the Aegis you seek. Oh yes, I know your goals outsider. As I know many things...', 23420), -- The Ancient Trials
(38317, 0, 0, 0, 0, 0, 0, 0, 0, 'Finally, I can get back to the action!', 23420), -- Masters of Disguise
(38308, 0, 0, 0, 0, 0, 0, 0, 0, '<Thumbing through the intel, you discover that Knockwhistle wasn\'t the only SI:7 spy in the area.>', 23420), -- Eyes in the Overlook
(38362, 0, 0, 0, 0, 0, 0, 0, 0, 'Look carefully at this head, $p. This is what comes to those who stand against the Forsaken.$B$BFor now, we should begin our search for the Aegis of Agrammar. I will send some scouts out to discern its location. You should start your search as well. $B$BWhat are you waiting for?', 23420), -- A Grim Trophy
(38360, 0, 0, 0, 0, 0, 0, 0, 0, 'So, she escaped after all...', 23420), -- The Windrunner's Fate
(38361, 0, 0, 0, 0, 0, 0, 0, 0, 'They have only begun to pay for their insolence.', 23420), -- Wrath of the Blightcaller
(38332, 0, 0, 0, 0, 0, 0, 0, 0, '<Nathanos narrows his eyes at the wreckage of Sylvanas\' ship.>$B$BShe\'s out there... she has to be.', 23420), -- The Ranger Lord
(38358, 11, 0, 0, 0, 100, 0, 0, 0, 'Wonderful, just put that down anywhere. Careful not to spill it!$B$B<The apothecary snickers.>', 23420), -- Pump it Up
(38357, 0, 0, 0, 0, 0, 0, 0, 0, 'The R.A.S. is nothing if not humane.', 23420); -- Side Effects May Include Mild Undeath

DELETE FROM `quest_greeting` WHERE (`ID`=108072 AND `Type`=0) OR (`ID`=107498 AND `Type`=0) OR (`ID`=97480 AND `Type`=0) OR (`ID`=91531 AND `Type`=0) OR (`ID`=97270 AND `Type`=0) OR (`ID`=93446 AND `Type`=0) OR (`ID`=91249 AND `Type`=0) OR (`ID`=92567 AND `Type`=0) OR (`ID`=243836 AND `Type`=1) OR (`ID`=91158 AND `Type`=0) OR (`ID`=91590 AND `Type`=0);
INSERT INTO `quest_greeting` (`ID`, `Type`, `GreetEmoteType`, `GreetEmoteDelay`, `Greeting`, `VerifiedBuild`) VALUES
(108072, 0, 0, 0, 'What-ho traveller! What brings you to these dusty ruins?', 23420), -- 108072
(107498, 0, 0, 0, 'Caw?', 23420), -- 107498
(97480, 0, 0, 0, 'We face a formidable foe, but we must not let Helya win.', 23420), -- 97480
(91531, 0, 0, 0, 'I\'m sure ye don\'t belong here in Helheim, just like me.  $B$BI just hope Helya agrees with us.', 23420), -- 91531
(97270, 0, 0, 0, 'What have you uncovered in Haustvald, outsider?', 23420), -- 97270
(93446, 0, 0, 0, 'The Mystics have committed an unforgivable heresy here. The Valkyra will not forget this trespass.', 23420), -- 93446
(91249, 0, 0, 0, 'You... $B$BYou are not like the others.', 23420), -- 91249
(92567, 0, 0, 0, 'Good work with the distractions, boss. $B$BThose guards never knew what hit em.', 23420), -- 92567
(243836, 1, 0, 0, 'This cannot be! What kind of gall does this Skovald have to disregard these ancient rites! $B$BThis must not stand!', 23420), -- 243836
(91158, 0, 0, 0, 'The Alliance are still scouring the wreckage. They haven\'t found their quarry yet...', 23420), -- 91158
(91590, 0, 0, 0, 'No use crying over spilled toxic waste.$B$BSeriously, don\'t cry - the fumes can enter your tear ducts and melt your eyes from the inside.$B$BIsn\'t science fun?!', 23420); -- 91590


DELETE FROM `quest_details` WHERE `ID` IN (42483 /*Put It All on Red*/, 39792 /*A Stack of Racks*/, 39786 /*A Stone Cold Gamble*/, 42447 /*Dances With Ravenbears*/, 43341 /*Uniting the Isles*/, 42445 /*Nithogg's Tribute*/, 42446 /*Singed Feathers*/, 42444 /*Plight of the Blackfeather*/, 38882 /*A New Life for Undeath*/, 39155 /*Becoming the Ascendant*/, 38878 /*Shielded Secrets*/, 39154 /*To Skold-Ashil*/, 39385 /*A Gift for Greymane*/, 39153 /*Dreadwake's Dilemma*/, 38873 /*Clear the Deck!*/, 38872 /*The Dark Lady's Bidding*/, 39787 /*Rigging the Wager*/, 39793 /*Only the Finest*/, 39789 /*Eating Into Our Business*/, 38618 /*Above the Winter Moonlight*/, 38617 /*Another Way*/, 38615 /*Impalement Insurance*/, 38616 /*Built to Scale*/, 38614 /*To Weather the Storm*/, 38613 /*No Wings Required*/, 38612 /*A Grapple a Day*/, 38611 /*Will of the Thorignir*/, 38317 /*Masters of Disguise*/, 38308 /*Eyes in the Overlook*/, 38459 /*The Ancient Trials*/, 38362 /*A Grim Trophy*/, 38361 /*Wrath of the Blightcaller*/, 38360 /*The Windrunner's Fate*/, 38357 /*Side Effects May Include Mild Undeath*/, 38358 /*Pump it Up*/, 38332 /*The Ranger Lord*/);
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES
(42483, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- Put It All on Red
(39792, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- A Stack of Racks
(39786, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- A Stone Cold Gamble
(42447, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- Dances With Ravenbears
(43341, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- Uniting the Isles
(42445, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- Nithogg's Tribute
(42446, 403, 0, 0, 0, 0, 0, 0, 0, 23420), -- Singed Feathers
(42444, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- Plight of the Blackfeather
(38882, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- A New Life for Undeath
(39155, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- Becoming the Ascendant
(38878, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- Shielded Secrets
(39154, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- To Skold-Ashil
(39385, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- A Gift for Greymane
(39153, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- Dreadwake's Dilemma
(38873, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- Clear the Deck!
(38872, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- The Dark Lady's Bidding
(39787, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- Rigging the Wager
(39793, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- Only the Finest
(39789, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- Eating Into Our Business
(38618, 1, 0, 0, 0, 0, 0, 0, 0, 23420), -- Above the Winter Moonlight
(38617, 6, 0, 0, 0, 0, 0, 0, 0, 23420), -- Another Way
(38615, 1, 0, 0, 0, 0, 0, 0, 0, 23420), -- Impalement Insurance
(38616, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- Built to Scale
(38614, 1, 0, 0, 0, 0, 0, 0, 0, 23420), -- To Weather the Storm
(38613, 1, 0, 0, 0, 0, 0, 0, 0, 23420), -- No Wings Required
(38612, 6, 0, 0, 0, 0, 0, 0, 0, 23420), -- A Grapple a Day
(38611, 1, 0, 0, 0, 0, 0, 0, 0, 23420), -- Will of the Thorignir
(38317, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- Masters of Disguise
(38308, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- Eyes in the Overlook
(38459, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- The Ancient Trials
(38362, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- A Grim Trophy
(38361, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- Wrath of the Blightcaller
(38360, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- The Windrunner's Fate
(38357, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- Side Effects May Include Mild Undeath
(38358, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- Pump it Up
(38332, 0, 0, 0, 0, 0, 0, 0, 0, 23420); -- The Ranger Lord

DELETE FROM `quest_request_items` WHERE `ID` IN (42483 /*Put It All on Red*/, 42639 /*A Stone of Blood*/, 42635 /*The Mystery of Dreyrgrot*/, 42640 /*The Value of Knowledge*/, 39786 /*A Stone Cold Gamble*/, 39792 /*A Stack of Racks*/, 39793 /*Only the Finest*/, 39787 /*Rigging the Wager*/, 42445 /*Nithogg's Tribute*/, 42446 /*Singed Feathers*/, 39405 /*Stories of Battle*/, 40002 /*A Familiar Fate*/, 39849 /*To Light the Way*/, 39848 /*A Desperate Bargain*/, 38347 /*Stealth by Seaweed*/, 38339 /*A Little Kelp From My Foes*/, 38324 /*Accessories of the Cursed*/, 38817 /*Regal Remains*/, 38808 /*Bjornharta*/, 38810 /*The Dreaming Fungus*/, 38413 /*Wings of Liberty*/, 38614 /*To Weather the Storm*/, 38616 /*Built to Scale*/, 39593 /*The Shattered Watcher*/, 39590 /*Ahead of the Game*/, 39595 /*Blood and Gold*/, 38308 /*Eyes in the Overlook*/, 38362 /*A Grim Trophy*/);
INSERT INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) VALUES
(42483, 0, 0, 0, 0, 'Hmm...', 23420), -- Put It All on Red
(42639, 0, 0, 0, 0, 'We will need the amulet\'s protection to proceed.', 23420), -- A Stone of Blood
(42635, 0, 0, 0, 0, 'How goes the hunt for knowledge?', 23420), -- The Mystery of Dreyrgrot
(42640, 0, 0, 0, 0, 'What\'s this?', 23420), -- The Value of Knowledge
(39786, 0, 0, 0, 0, 'Did you take him out?', 23420), -- A Stone Cold Gamble
(39792, 0, 0, 0, 0, 'Aint nothin like some good old meaty musken ribs, eh pal?', 23420), -- A Stack of Racks
(39793, 0, 0, 0, 0, 'Make sure to get the good stuff!', 23420), -- Only the Finest
(39787, 0, 0, 0, 0, 'You got my trophy yet?', 23420), -- Rigging the Wager
(42445, 0, 0, 0, 0, 'Ca-caw?', 23420), -- Nithogg's Tribute
(42446, 0, 0, 0, 0, '', 23420), -- Singed Feathers
(39405, 0, 0, 0, 0, 'This appears to be the last verse.', 23420), -- Stories of Battle
(40002, 0, 0, 0, 0, 'The jailer has... the key...', 23420), -- A Familiar Fate
(39849, 0, 0, 0, 0, 'Were you able to secure the lantern?', 23420), -- To Light the Way
(39848, 0, 0, 0, 0, '<The air hangs silent as you approach.>', 23420), -- A Desperate Bargain
(38347, 0, 0, 0, 0, 'Gods, what is that stench?! $B$BThis disguise had better work!', 23420), -- Stealth by Seaweed
(38339, 0, 0, 0, 0, 'Do ye have enough for a proper disguise?', 23420), -- A Little Kelp From My Foes
(38324, 0, 0, 0, 0, 'Make sure ye\'ve got enough bones before we move on.', 23420), -- Accessories of the Cursed
(38817, 0, 0, 0, 0, 'Were you able to recover her remains?', 23420), -- Regal Remains
(38808, 0, 0, 0, 0, 'How went the hunt, outsider?', 23420), -- Bjornharta
(38810, 0, 0, 0, 0, 'What do you bring?', 23420), -- The Dreaming Fungus
(38413, 0, 0, 0, 0, 'What news do you bring of my brothers and sisters?', 23420), -- Wings of Liberty
(38614, 0, 0, 0, 0, 'Were you able to get all the gear you needed?', 23420), -- To Weather the Storm
(38616, 0, 0, 0, 0, 'What have we here?', 23420), -- Built to Scale
(39593, 0, 0, 0, 0, 'Have you managed to find them all?', 23420), -- The Shattered Watcher
(39590, 0, 0, 0, 0, 'An ironic gift you bring me, challenger.', 23420), -- Ahead of the Game
(39595, 0, 0, 0, 0, 'What is this you bring?$B$BYou honor me, outsider.', 23420), -- Blood and Gold
(38308, 0, 0, 0, 0, '<The gnome spy was guarding a detailed report of the Forsaken forces.>', 23420), -- Eyes in the Overlook
(38362, 0, 0, 0, 0, 'Do you have his head?', 23420); -- A Grim Trophy

DELETE FROM `creature_template_scaling` WHERE `Entry` IN (105387, 105386, 103222, 95755, 94228, 95611, 94227, 107441, 103786, 97250, 91904, 91536, 91158);
INSERT INTO `creature_template_scaling` (`Entry`, `LevelScalingMin`, `LevelScalingMax`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `VerifiedBuild`) VALUES
(105387, 98, 110, 0, 0, 23420),
(105386, 98, 110, 0, 0, 23420),
(103222, 98, 110, 0, 0, 23420),
(95755, 98, 110, 0, 0, 23420),
(94228, 98, 110, 0, 0, 23420),
(95611, 98, 110, 0, 0, 23420),
(94227, 98, 110, 0, 0, 23420),
(107441, 98, 110, 0, 0, 23420),
(103786, 98, 110, 0, 0, 23420),
(97250, 98, 110, 0, 0, 23420),
(91904, 98, 110, 0, 0, 23420),
(91536, 98, 110, 0, 0, 23420),
(91158, 98, 110, 0, 0, 23420);

DELETE FROM `creature_model_info` WHERE `DisplayID`=25202;
INSERT INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `DisplayID_Other_Gender`, `VerifiedBuild`) VALUES
(25202, 0.575, 2.53, 0, 23420);

DELETE FROM `creature_equip_template` WHERE (`CreatureID`=94337 AND `ID`=1) OR (`CreatureID`=109640 AND `ID`=1) OR (`CreatureID`=107926 AND `ID`=2) OR (`CreatureID`=107926 AND `ID`=1) OR (`CreatureID`=92609 AND `ID`=1) OR (`CreatureID`=104290 AND `ID`=1) OR (`CreatureID`=103307 AND `ID`=1) OR (`CreatureID`=103745 AND `ID`=1) OR (`CreatureID`=103729 AND `ID`=1) OR (`CreatureID`=103245 AND `ID`=1) OR (`CreatureID`=95755 AND `ID`=1) OR (`CreatureID`=94228 AND `ID`=1) OR (`CreatureID`=95611 AND `ID`=1) OR (`CreatureID`=94227 AND `ID`=1) OR (`CreatureID`=92803 AND `ID`=1) OR (`CreatureID`=94313 AND `ID`=1) OR (`CreatureID`=95444 AND `ID`=1) OR (`CreatureID`=109635 AND `ID`=1) OR (`CreatureID`=94614 AND `ID`=1) OR (`CreatureID`=93611 AND `ID`=1) OR (`CreatureID`=95052 AND `ID`=1) OR (`CreatureID`=97695 AND `ID`=1) OR (`CreatureID`=93624 AND `ID`=1) OR (`CreatureID`=107675 AND `ID`=1) OR (`CreatureID`=97258 AND `ID`=1) OR (`CreatureID`=92951 AND `ID`=1) OR (`CreatureID`=92568 AND `ID`=1) OR (`CreatureID`=92573 AND `ID`=1) OR (`CreatureID`=92567 AND `ID`=1) OR (`CreatureID`=92566 AND `ID`=2) OR (`CreatureID`=92566 AND `ID`=1) OR (`CreatureID`=92561 AND `ID`=1) OR (`CreatureID`=97250 AND `ID`=1) OR (`CreatureID`=91158 AND `ID`=1) OR (`CreatureID`=91473 AND `ID`=1);
INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `AppearanceModID1`, `ItemVisual1`, `ItemID2`, `AppearanceModID2`, `ItemVisual2`, `ItemID3`, `AppearanceModID3`, `ItemVisual3`) VALUES
(94337, 1, 0, 0, 0, 0, 0, 0, 80271, 0, 0), -- Dread-Rider Plaguebringer
(109640, 1, 0, 0, 0, 0, 0, 0, 80271, 0, 0), -- Dread-Rider Plaguebringer
(107926, 2, 0, 0, 0, 120406, 0, 0, 0, 0, 0), -- Hannval the Butcher
(107926, 1, 120406, 0, 0, 120406, 0, 0, 0, 0, 0), -- Hannval the Butcher
(92609, 1, 0, 0, 0, 0, 0, 0, 52052, 0, 0), -- Tracker Jack
(104290, 1, 134848, 0, 0, 134848, 0, 0, 0, 0, 0), -- Captain Grimshanks
(103307, 1, 0, 0, 0, 0, 0, 0, 80271, 0, 0), -- Forsaken Plaguebringer
(103745, 1, 0, 0, 0, 0, 0, 0, 18680, 0, 0), -- Forsaken Dark Ranger
(103729, 1, 0, 0, 0, 0, 0, 0, 25243, 0, 0), -- Forsaken Archer
(103245, 1, 0, 0, 0, 0, 0, 0, 80271, 0, 0), -- Forsaken Befouler
(95755, 1, 0, 0, 0, 0, 0, 0, 42775, 0, 0), -- Lady Sylvanas Windrunner
(94228, 1, 0, 0, 0, 0, 0, 0, 42775, 0, 0), -- Lady Sylvanas Windrunner
(95611, 1, 0, 0, 0, 0, 0, 0, 42775, 0, 0), -- Lady Sylvanas Windrunner
(94227, 1, 0, 0, 0, 0, 0, 0, 42775, 0, 0), -- Lady Sylvanas Windrunner
(92803, 1, 0, 0, 0, 0, 0, 0, 97227, 0, 0), -- Ranger Captain Areiel
(94313, 1, 0, 0, 0, 0, 0, 0, 110599, 0, 0), -- Daniel "Boomer" Vorick
(95444, 1, 46737, 0, 0, 0, 0, 0, 0, 0, 0), -- Genn Greymane
(109635, 1, 0, 0, 0, 0, 0, 0, 110178, 0, 0), -- Greywatch Saboteur
(94614, 1, 0, 0, 0, 0, 0, 0, 110178, 0, 0), -- Greywatch Saboteur
(93611, 1, 0, 0, 0, 0, 0, 0, 97227, 0, 0), -- Dark Ranger
(95052, 1, 0, 0, 0, 0, 0, 0, 80271, 0, 0), -- Dread-Rider Plaguebringer
(97695, 1, 0, 0, 0, 0, 0, 0, 42775, 0, 0), -- Lady Sylvanas Windrunner
(93624, 1, 113362, 0, 0, 0, 0, 0, 0, 0, 0), -- Dread-Rider Cullen
(107675, 1, 0, 0, 0, 0, 0, 0, 110600, 0, 0), -- Rax Sixtrigger
(97258, 1, 0, 0, 0, 0, 0, 0, 108715, 0, 0), -- Ootasa Galehoof
(92951, 1, 0, 0, 0, 0, 0, 0, 56170, 0, 0), -- Houndmaster Ely
(92568, 1, 113362, 0, 0, 0, 0, 0, 0, 0, 0), -- Dread-Rider Cullen
(92573, 1, 113362, 0, 0, 0, 0, 0, 0, 0, 0), -- Dread-Rider Cullen
(92567, 1, 113362, 0, 0, 0, 0, 0, 0, 0, 0), -- Dread-Rider Cullen
(92566, 2, 113362, 0, 0, 0, 0, 0, 112340, 0, 0), -- Dread-Rider Cullen
(92566, 1, 113362, 0, 0, 0, 0, 0, 0, 0, 0), -- Dread-Rider Cullen
(92561, 1, 113362, 0, 0, 0, 0, 0, 0, 0, 0), -- Dread-Rider Cullen
(97250, 1, 52521, 0, 0, 34717, 0, 0, 0, 0, 0), -- Forsaken Bat-Rider
(91158, 1, 65795, 0, 0, 65795, 0, 0, 5258, 0, 0), -- Nathanos Blightcaller
(91473, 1, 113362, 0, 0, 0, 0, 0, 0, 0, 0); -- Dread-Rider Cullen

UPDATE `creature_equip_template` SET `ItemID2`=109042, `ItemID3`=0 WHERE (`CreatureID`=109639 AND `ID`=1); -- Dread-Rider Stalker
UPDATE `creature_equip_template` SET `ItemID2`=52528, `ItemID3`=0 WHERE (`CreatureID`=92611 AND `ID`=1); -- Ambusher Daggerfang
UPDATE `creature_equip_template` SET `ItemID2`=119202, `ItemID3`=0 WHERE (`CreatureID`=92604 AND `ID`=1); -- Champion Elodie
UPDATE `creature_equip_template` SET `ItemID2`=5285, `ItemID3`=0 WHERE (`CreatureID`=92633 AND `ID`=1); -- Assassin Huwe
UPDATE `creature_equip_template` SET `ItemID2`=134848, `ItemID3`=0 WHERE (`CreatureID`=103222 AND `ID`=1); -- Forsaken Shadowblade
UPDATE `creature_equip_template` SET `ItemID2`=109042, `ItemID3`=0 WHERE (`CreatureID`=103218 AND `ID`=1); -- Forsaken Deceiver
UPDATE `creature_equip_template` SET `ItemID2`=52524, `ItemID3`=0 WHERE (`CreatureID`=103210 AND `ID`=1); -- Forsaken Defender
UPDATE `creature_equip_template` SET `ItemID2`=52524, `ItemID3`=0 WHERE (`CreatureID`=103215 AND `ID`=1); -- Forsaken Deathwarder
UPDATE `creature_equip_template` SET `ItemID2`=55170, `ItemID3`=0 WHERE (`CreatureID`=98188 AND `ID`=1); -- Egyl the Enduring
UPDATE `creature_equip_template` SET `ItemID2`=89116, `ItemID3`=0 WHERE (`CreatureID`=92764 AND `ID`=2); -- Valkyra Aspirant
UPDATE `creature_equip_template` SET `ItemID2`=89116, `ItemID3`=0 WHERE (`CreatureID`=94393 AND `ID`=1); -- Statue
UPDATE `creature_equip_template` SET `ItemID2`=61512, `ItemID3`=110180 WHERE (`CreatureID`=93779 AND `ID`=1); -- Commander Lorna Crowley
UPDATE `creature_equip_template` SET `ItemID3`=107953 WHERE (`CreatureID`=109589 AND `ID`=1); -- Royal Dreadguard
UPDATE `creature_equip_template` SET `ItemID2`=89116, `ItemID3`=0 WHERE (`CreatureID`=92764 AND `ID`=1); -- Valkyra Aspirant
UPDATE `creature_equip_template` SET `ItemID2`=109040, `ItemID3`=0 WHERE (`CreatureID`=109633 AND `ID`=1); -- Greywatch Infiltrator
UPDATE `creature_equip_template` SET `ItemID2`=109040, `ItemID3`=0 WHERE (`CreatureID`=93860 AND `ID`=1); -- Greywatch Infiltrator
UPDATE `creature_equip_template` SET `ItemID2`=52524, `ItemID3`=107953 WHERE (`CreatureID`=95787 AND `ID`=1); -- Dreadwake Deathguard
UPDATE `creature_equip_template` SET `ItemID2`=109040, `ItemID3`=0 WHERE (`CreatureID`=94825 AND `ID`=1); -- Greywatch Infiltrator
UPDATE `creature_equip_template` SET `ItemID2`=65795, `ItemID3`=5258 WHERE (`CreatureID`=93603 AND `ID`=1); -- Nathanos Blightcaller
UPDATE `creature_equip_template` SET `ItemID2`=52524, `ItemID3`=107953 WHERE (`CreatureID`=109452 AND `ID`=1); -- Dreadwake Deathguard
UPDATE `creature_equip_template` SET `ItemID3`=107953 WHERE (`CreatureID`=93592 AND `ID`=1); -- Royal Dreadguard
UPDATE `creature_equip_template` SET `ItemID2`=52524, `ItemID3`=107953 WHERE (`CreatureID`=93612 AND `ID`=1); -- Dreadwake Deathguard
UPDATE `creature_equip_template` SET `ItemID2`=109042, `ItemID3`=0 WHERE (`CreatureID`=94338 AND `ID`=1); -- Dread-Rider Stalker
UPDATE `creature_equip_template` SET `ItemID2`=108594, `ItemID3`=0 WHERE (`CreatureID`=97851 AND `ID`=1); -- Felskorn Chosen
UPDATE `creature_equip_template` SET `ItemID2`=77408, `ItemID3`=0 WHERE (`CreatureID`=98953 AND `ID`=1); -- Tideskorn Shieldmaiden
UPDATE `creature_equip_template` SET `ItemID2`=111717, `ItemID3`=110314 WHERE (`CreatureID`=93870 AND `ID`=1); -- Greywatch Guard
UPDATE `creature_equip_template` SET `ItemID2`=52524, `ItemID3`=0 WHERE (`CreatureID`=94413 AND `ID`=1); -- Isel the Hammer
UPDATE `creature_equip_template` SET `ItemID2`=77408, `ItemID3`=0 WHERE (`CreatureID`=97664 AND `ID`=1); -- Ashildir
UPDATE `creature_equip_template` SET `ItemID2`=89116, `ItemID3`=0 WHERE (`CreatureID`=97665 AND `ID`=1); -- Valkyra Guardian
UPDATE `creature_equip_template` SET `ItemID2`=56913, `ItemID3`=0 WHERE (`CreatureID`=97443 AND `ID`=1); -- Unworthy Combatant
UPDATE `creature_equip_template` SET `ItemID1`=128097 WHERE (`CreatureID`=89759 AND `ID`=1); -- Kvaldir Cursewalker
UPDATE `creature_equip_template` SET `ItemID2`=56913, `ItemID3`=0 WHERE (`CreatureID`=97433 AND `ID`=1); -- Unworthy Combatant
UPDATE `creature_equip_template` SET `ItemID2`=34590, `ItemID3`=0 WHERE (`CreatureID`=105687 AND `ID`=1); -- Valkyra Shieldmaiden
UPDATE `creature_equip_template` SET `ItemID2`=34217, `ItemID3`=0 WHERE (`CreatureID`=105680 AND `ID`=1); -- Bonespeaker Drudge
UPDATE `creature_equip_template` SET `ItemID2`=89116, `ItemID3`=0 WHERE (`CreatureID`=97270 AND `ID`=1); -- Shieldmaiden Iounn
UPDATE `creature_equip_template` SET `ItemID2`=89116, `ItemID3`=0 WHERE (`CreatureID`=93446 AND `ID`=1); -- Shieldmaiden Iounn
UPDATE `creature_equip_template` SET `ItemID2`=107703, `ItemID3`=0 WHERE (`CreatureID`=92920 AND `ID`=1); -- Oktel Dragonblood
UPDATE `creature_equip_template` SET `ItemID2`=56174, `ItemID3`=0 WHERE (`CreatureID`=108940 AND `ID`=1); -- Ancient Boneservant
UPDATE `creature_equip_template` SET `ItemID2`=111426, `ItemID3`=0 WHERE (`CreatureID`=107588 AND `ID`=1); -- Blood-Thane Lucard
UPDATE `creature_equip_template` SET `ItemID3`=110315 WHERE (`CreatureID`=108029 AND `ID`=1); -- Plundering Corsair
UPDATE `creature_equip_template` SET `ItemID2`=111586, `ItemID3`=0 WHERE (`CreatureID`=108030 AND `ID`=1); -- Blood-Crazed Swashbuckler
UPDATE `creature_equip_template` SET `ItemID2`=89116, `ItemID3`=0 WHERE (`CreatureID`=93445 AND `ID`=1); -- Valkyra Guardian
UPDATE `creature_equip_template` SET `ItemID2`=124531, `ItemID3`=0 WHERE (`CreatureID`=93401 AND `ID`=1); -- Urgev the Flayer
UPDATE `creature_equip_template` SET `ItemID2`=107112, `ItemID3`=0 WHERE (`CreatureID`=93066 AND `ID`=1); -- Bonespeaker Runeaxe
UPDATE `creature_equip_template` SET `ItemID3`=42484 WHERE (`CreatureID`=107674 AND `ID`=1); -- Snaggle Sixtrigger
UPDATE `creature_equip_template` SET `ItemID2`=49638, `ItemID3`=0 WHERE (`CreatureID`=92381 AND `ID`=1); -- Drekirjar Shieldbearer
UPDATE `creature_equip_template` SET `ItemID3`=112340 WHERE (`CreatureID`=92312 AND `ID`=1); -- Drekirjar Galeborn
UPDATE `creature_equip_template` SET `ItemID3`=40759 WHERE (`CreatureID`=91244 AND `ID`=1); -- Felskorn Trapper
UPDATE `creature_equip_template` SET `ItemID2`=40534, `ItemID3`=112340 WHERE (`CreatureID`=91429 AND `ID`=1); -- Tideskorn Pathfinder
UPDATE `creature_equip_template` SET `ItemID2`=108591, `ItemID3`=0 WHERE (`CreatureID`=91240 AND `ID`=1); -- Gunnlaug Scaleheart
UPDATE `creature_equip_template` SET `ItemID2`=36452, `ItemID3`=0 WHERE (`CreatureID`=108579 AND `ID`=1); -- Runelord Ragnar
UPDATE `creature_equip_template` SET `ItemID3`=108479 WHERE (`CreatureID`=100446 AND `ID`=1); -- Tideskorn Huntress
UPDATE `creature_equip_template` SET `ItemID2`=56913, `ItemID3`=0 WHERE (`CreatureID`=96129 AND `ID`=1); -- Felskorn Raider
UPDATE `creature_equip_template` SET `ItemID2`=56913, `ItemID3`=0 WHERE (`CreatureID`=108306 AND `ID`=1); -- Felskorn Raider
UPDATE `creature_equip_template` SET `ItemID2`=119204, `ItemID3`=0 WHERE (`CreatureID`=91460 AND `ID`=1); -- Spymaster Shwayder
UPDATE `creature_equip_template` SET `ItemID2`=18166, `ItemID3`=15460 WHERE (`CreatureID`=91880 AND `ID`=1); -- Royal Dreadguard
UPDATE `creature_equip_template` SET `ItemID3`=62400 WHERE (`CreatureID`=91414 AND `ID`=1); -- Skyfire Gryphon Rider
UPDATE `creature_equip_template` SET `ItemID3`=62285 WHERE (`CreatureID`=91950 AND `ID`=1); -- Forsaken Ranger
UPDATE `creature_equip_template` SET `ItemID2`=3757, `ItemID3`=0 WHERE (`CreatureID`=91590 AND `ID`=1); -- Apothecary Withers
UPDATE `creature_equip_template` SET `ItemID2`=3276, `ItemID3`=0 WHERE (`CreatureID`=91532 AND `ID`=1); -- Forsaken Deathguard

DELETE FROM `gossip_menu` WHERE (`MenuId`=18657 AND `TextId`=27093);
INSERT INTO `gossip_menu` (`MenuId`, `TextId`, `VerifiedBuild`) VALUES
(18657, 27093, 23420); -- 93624 (Dread-Rider Cullen)

DELETE FROM `gossip_menu_option` WHERE (`MenuId`=18657 AND `OptionIndex`=0);
INSERT INTO `gossip_menu_option` (`MenuId`, `OptionIndex`, `OptionIcon`, `OptionText`, `OptionBroadcastTextId`, `VerifiedBuild`) VALUES
(18657, 0, 0, 'Take me to Dreadwake\'s Landing.', 97471, 23420);

UPDATE `creature_template` SET `unit_flags`=33536, `unit_flags2`=71305216 WHERE `entry`=107709; -- Goblin Zeppelin
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=93371; -- Mordvigbjorn
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=94342; -- Credit  Bunny
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=111682; -- Savage Great White
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=111496; -- Isle Remora Shark
UPDATE `creature_template` SET `minlevel`=110, `unit_flags`=32768 WHERE `entry`=108032; -- Captain Broketooth
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=91984; -- Grapple Point
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=108062; -- Citrine Thresher
UPDATE `creature_template` SET `minlevel`=110, `unit_flags`=67141632 WHERE `entry`=107917; -- Steelscale
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=97809; -- Coastal Seagull
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=109639; -- Dread-Rider Stalker
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=94337; -- Dread-Rider Plaguebringer
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=94340; -- Credit  Bunny
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=109640; -- Dread-Rider Plaguebringer
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=109110; -- Tracking Hound
UPDATE `creature_template` SET `minlevel`=108 WHERE `entry`=109559; -- Gilnean Mastiff
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=109083; -- Houndmaster Payne
UPDATE `creature_template` SET `faction`=188, `speed_run`=0.8571429, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=768, `unit_flags2`=2048 WHERE `entry`=105391; -- Mini Musken
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `npcflag`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=768, `unit_flags2`=2048 WHERE `entry`=105387; -- Andurs
UPDATE `creature_template` SET `faction`=188, `speed_run`=0.8571429, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=768, `unit_flags2`=2048 WHERE `entry`=105389; -- Baby Bjorn
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `npcflag`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=768, `unit_flags2`=2048 WHERE `entry`=105386; -- Rydyr
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=91800; -- Stormwing Whelp
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=16, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32832, `unit_flags2`=2048 WHERE `entry`=107926; -- Hannval the Butcher
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=107883; -- Tideskorn Beastbreaker
UPDATE `creature_template` SET `minlevel`=110, `unit_flags`=32784 WHERE `entry`=107850; -- Highlands Ettin
UPDATE `creature_template` SET `minlevel`=110, `unit_flags`=536904448, `unit_flags2`=2049, `dynamicflags`=32 WHERE `entry`=107881; -- Tideskorn Beastbreaker
UPDATE `creature_template` SET `unit_flags`=768 WHERE `entry`=107544; -- Nithogg
UPDATE `creature_template` SET `minlevel`=110, `unit_flags`=536904448, `unit_flags2`=2049, `dynamicflags`=32 WHERE `entry`=107519; -- Cukkaw
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=107487; -- Starbuck
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=97124; -- Spitefeather
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=99224; -- Drakol'nir
UPDATE `creature_template` SET `minlevel`=110, `unit_flags`=32784 WHERE `entry`=91956; -- Guthrie
UPDATE `creature_template` SET `minlevel`=110, `unit_flags`=32784 WHERE `entry`=91954; -- Beagan
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=92626; -- Deathguard Adams
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=92613; -- Priestess Liza
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=92609; -- Tracker Jack
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=92611; -- Ambusher Daggerfang
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=92604; -- Champion Elodie
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=92633; -- Assassin Huwe
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=71, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=104290; -- Captain Grimshanks
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=103307; -- Forsaken Plaguebringer
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=103430; -- Festering Abomination
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=103222; -- Forsaken Shadowblade
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=103431; -- Sninkwind Hulk
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=71, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=103745; -- Forsaken Dark Ranger
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=103729; -- Forsaken Archer
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=103218; -- Forsaken Deceiver
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=103446; -- Forsaken Frostflinger
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=103210; -- Forsaken Defender
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=103215; -- Forsaken Deathwarder
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=103245; -- Forsaken Befouler
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=103453; -- Forsaken Rector
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=111327; -- Hillevi the Scalekeeper
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=107499; -- Frightened Ravenbear
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=107498; -- Cukkaw
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=106565; -- Blackfeather Gatherer
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=107469; -- Rampaging Squallhunter
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=97516; -- Foothills Greatstag
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=109451; -- Great Eagle
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=98188; -- Egyl the Enduring
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=98189; -- Unseeing Watcher
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=68, `speed_run`=1, `BaseAttackTime`=1500, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=95755; -- Lady Sylvanas Windrunner
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=68, `speed_run`=1, `BaseAttackTime`=1500, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=94228; -- Lady Sylvanas Windrunner
UPDATE `creature_template` SET `gossip_menu_id`=18543 WHERE `entry`=94393; -- Statue
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=94477; -- Credit  Bunny
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=92751; -- Ivory Sentinel
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=68, `npcflag`=2, `speed_run`=1, `BaseAttackTime`=1500, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=32768, `unit_flags2`=34816 WHERE `entry`=95611; -- Lady Sylvanas Windrunner
UPDATE `creature_template` SET `npcflag`=0, `speed_run`=1 WHERE `entry`=93628; -- Eyir
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=94856; -- Priestess of Eyir
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=68, `speed_run`=1, `BaseAttackTime`=1500, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=94227; -- Lady Sylvanas Windrunner
UPDATE `creature_template` SET `minlevel`=107, `maxlevel`=107, `faction`=68, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=92803; -- Ranger Captain Areiel
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=109458; -- Rowboat to Dreadwake's Landing
UPDATE `creature_template` SET `unit_flags`=32784 WHERE `entry`=109589; -- Royal Dreadguard
UPDATE `creature_template` SET `faction`=190, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=33555200, `unit_flags2`=2099200, `unit_flags3`=1 WHERE `entry`=94593; -- Fire Effect Bunny
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=92764; -- Valkyra Aspirant
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=94313; -- Daniel "Boomer" Vorick
UPDATE `creature_template` SET `minlevel`=110, `unit_flags`=536904448, `unit_flags2`=2049, `dynamicflags`=32 WHERE `entry`=95073; -- Forsaken Dreadwing
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=92022; -- Grapple Point
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=94006; -- Nashal Bonepicker
UPDATE `creature_template` SET `minlevel`=108, `maxlevel`=108, `faction`=2166, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=33536, `unit_flags2`=2099200 WHERE `entry`=95444; -- Genn Greymane
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=107852; -- Stout Highlands Runehorn
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=95436; -- Greywatch Cannoneer
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=109633; -- Greywatch Infiltrator
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=109635; -- Greywatch Saboteur
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=94614; -- Greywatch Saboteur
UPDATE `creature_template` SET `minlevel`=110, `dynamicflags`=128 WHERE `entry`=95212; -- Forsaken Catapult
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=93860; -- Greywatch Infiltrator
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=109454; -- Rowboat to Skold Ashil
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=95787; -- Dreadwake Deathguard
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=94825; -- Greywatch Infiltrator
UPDATE `creature_template` SET `gossip_menu_id`=18625, `minlevel`=110 WHERE `entry`=93603; -- Nathanos Blightcaller
UPDATE `creature_template` SET `gossip_menu_id`=20270 WHERE `entry`=98106; -- Elliot Theodric
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=93608; -- Benjamin Parrish
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=93611; -- Dark Ranger
UPDATE `creature_template` SET `gossip_menu_id`=19884, `minlevel`=110 WHERE `entry`=109133; -- Batmaster Claud
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=109138; -- Warbat
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=109452; -- Dreadwake Deathguard
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=109482; -- Captain Dreadwake
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=109468; -- Oblivion Crewman
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=93612; -- Dreadwake Deathguard
UPDATE `creature_template` SET `minlevel`=110, `speed_run`=1 WHERE `entry`=93584; -- Tideskorn Shieldmaiden
UPDATE `creature_template` SET `minlevel`=112, `maxlevel`=112, `speed_walk`=1.6, `speed_run`=0.7142857, `BaseAttackTime`=1500, `RangeAttackTime`=2000, `unit_flags`=64, `unit_flags2`=67127296, `unit_flags3`=1 WHERE `entry`=116459; -- Barrels o' Fun
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `speed_run`=1, `BaseAttackTime`=1500, `RangeAttackTime`=2000, `unit_flags`=33600, `unit_flags2`=2048 WHERE `entry`=98196; -- Odyn
UPDATE `creature_template` SET `gossip_menu_id`=18852 WHERE `entry`=98190; -- Vethir
UPDATE `creature_template` SET `gossip_menu_id`=18843 WHERE `entry`=97986; -- Vethir
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=94338; -- Dread-Rider Stalker
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=95052; -- Dread-Rider Plaguebringer
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=95030; -- Forsaken Dreadwing
UPDATE `creature_template` SET `minlevel`=110, `speed_walk`=0.5, `speed_run`=0.5714286 WHERE `entry`=97944; -- Muorg
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=97985; -- Credit - South Portal Destroyed
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=98175; -- Hrafsir
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=98176; -- Erilar
UPDATE `creature_template` SET `minlevel`=110, `speed_run`=1.285714 WHERE `entry`=110973; -- Worthy Vrykul
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=97942; -- Ravathes
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=97983; -- Credit - North Portal Destroyed
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=107983; -- Stonewrought Guardian
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=113171; -- Felskorn Cleaver
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=97859; -- Karuas
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=96080; -- Demonic Gateway
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=97984; -- Credit - East Portal Destroyed
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=97821; -- Felskorn Oathbinder
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=97906; -- Runebound Wretch
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=97851; -- Felskorn Chosen
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=97822; -- Garzareth
UPDATE `creature_template` SET `minlevel`=110, `HoverHeight`=20 WHERE `entry`=92307; -- God-King Skovald
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=97816; -- Felskorn Zealot
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=97963; -- Felblood Cup
UPDATE `creature_template` SET `minlevel`=110, `unit_flags`=33587456 WHERE `entry`=96284; -- Helheim Champion
UPDATE `creature_template` SET `dynamicflags`=128 WHERE `entry`=105105; -- Storm Brew
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=95620; -- Servant of Skovald
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=97825; -- Felskorn Cleaver
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=98955; -- Tideskorn Warbear
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=98953; -- Tideskorn Shieldmaiden
UPDATE `creature_template` SET `gossip_menu_id`=18828 WHERE `entry`=91743; -- Circle of Binding
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=94413; -- Isel the Hammer
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=107928; -- Cliffdiver Eagle
UPDATE `creature_template` SET `gossip_menu_id`=0, `npcflag`=0 WHERE `entry`=97664; -- Ashildir
UPDATE `creature_template` SET `unit_flags`=33024 WHERE `entry`=97665; -- Valkyra Guardian
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=97484; -- Credit - Fragment of Valor
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=97483; -- Credit - Fragment of Might
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=97575; -- Chain Effect Bunny
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=97357; -- Chain Effect Bunny
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=97482; -- Credit - Fragment of Will
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=97578; -- Chain Effect Bunny
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=97577; -- Chain Effect Bunny
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=93005; -- Rotting Jailer
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=91657; -- Bloodbeard
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=97630; -- Soulthirster
UPDATE `creature_template` SET `npcflag`=2 WHERE `entry`=97480; -- Ashildir
UPDATE `creature_template` SET `minlevel`=110, `faction`=14 WHERE `entry`=97443; -- Unworthy Combatant
UPDATE `creature_template` SET `minlevel`=110, `dynamicflags`=32 WHERE `entry`=91424; -- Unworthy Warrior
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=89759; -- Kvaldir Cursewalker
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=97487; -- Credit - Helheim Escaped
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=97499; -- Helya
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=97479; -- Credit - Helya Confronted
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=97696; -- Credit - Helya Approached
UPDATE `creature_template` SET `minlevel`=110, `speed_run`=1.142857, `BaseAttackTime`=1333 WHERE `entry`=97433; -- Unworthy Combatant
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=93377; -- Kvaldir Mistcaller
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=91537; -- Bleakwater Helsquid
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=91384; -- Helhound
UPDATE `creature_template` SET `npcflag`=0 WHERE `entry`=91974; -- Bones of the Defeated
UPDATE `creature_template` SET `minlevel`=110, `dynamicflags`=160 WHERE `entry`=89819; -- Ashildir's Guard
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=97445; -- Deepbrine Horror
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=91575; -- Kvaldir Soulflayer
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=91948; -- Geir
UPDATE `creature_template` SET `dynamicflags`=128 WHERE `entry`=91387; -- Helya
UPDATE `creature_template` SET `npcflag`=16777216 WHERE `entry`=97469; -- Drowning Valkyra
UPDATE `creature_template` SET `unit_flags3`=1, `dynamicflags`=128 WHERE `entry`=91454; -- Helya's Tentacle
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=97408; -- Credit - Colborn Found
UPDATE `creature_template` SET `faction`=2633, `unit_flags`=33024 WHERE `entry`=91818; -- Unworthy Soul
UPDATE `creature_template` SET `npcflag`=2 WHERE `entry`=97319; -- Ashildir
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=91527; -- Dread Falke
UPDATE `creature_template` SET `npcflag`=2, `unit_flags`=33587200 WHERE `entry`=91531; -- Colborn the Unworthy
UPDATE `creature_template` SET `minlevel`=110, `unit_flags`=2129936, `unit_flags2`=33556608, `HoverHeight`=1 WHERE `entry`=105687; -- Valkyra Shieldmaiden
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=105680; -- Bonespeaker Drudge
UPDATE `creature_template` SET `gossip_menu_id`=0, `npcflag`=0, `HoverHeight`=1 WHERE `entry`=93428; -- Ashildir
UPDATE `creature_template` SET `minlevel`=110, `unit_flags`=33040 WHERE `entry`=93093; -- Runeseer Faljar
UPDATE `creature_template` SET `minlevel`=110, `unit_flags`=33587472 WHERE `entry`=97221; -- Empowered Runestone
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=97223; -- Empowered Runestone
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=98439; -- Bonespeaker's Ink
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=91556; -- God-King Skovald
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=98411; -- Bonespeaker Inkbinder
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=98412; -- Runeaxe Initiate
UPDATE `creature_template` SET `minlevel`=110, `unit_flags`=32832 WHERE `entry`=92889; -- Heimir of the Black Fist
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=93071; -- Bonespeaker Mystic
UPDATE `creature_template` SET `minlevel`=110, `unit_flags`=32832 WHERE `entry`=92920; -- Oktel Dragonblood
UPDATE `creature_template` SET `minlevel`=110, `unit_flags`=32848 WHERE `entry`=108939; -- Bonespeaker Cleaver
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=112257; -- Haustvald Bunny
UPDATE `creature_template` SET `minlevel`=110, `unit_flags`=32832 WHERE `entry`=92918; -- Rythas the Oracle
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=108940; -- Ancient Boneservant
UPDATE `creature_template` SET `minlevel`=110, `unit_flags`=32768, `unit_flags3`=0 WHERE `entry`=93094; -- Restless Ancestor
UPDATE `creature_template` SET `minlevel`=110, `unit_flags`=32768, `unit_flags3`=0 WHERE `entry`=109795; -- Neglected Bones
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=107588; -- Blood-Thane Lucard
UPDATE `creature_template` SET `minlevel`=110, `dynamicflags`=32 WHERE `entry`=108029; -- Plundering Corsair
UPDATE `creature_template` SET `minlevel`=110, `unit_flags3`=1 WHERE `entry`=108150; -- Drained Corsair
UPDATE `creature_template` SET `minlevel`=110, `unit_flags`=32784 WHERE `entry`=108030; -- Blood-Crazed Swashbuckler
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=107403; -- Nelvek the Ashen
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=93341; -- Credit  Bunny
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=112479; -- Felskorn Oathbinder
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=112481; -- Felskorn Zealot
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=112480; -- Servant of Skovald
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=97890; -- Dravax
UPDATE `creature_template` SET `gossip_menu_id`=18531 WHERE `entry`=93977; -- Leyweaver Tellumi
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=108922; -- Target - Runecarver Channel
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=108892; -- Runewood Fawn
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=93340; -- Credit  Bunny
UPDATE `creature_template` SET `dynamicflags`=128 WHERE `entry`=93342; -- Runestone
UPDATE `creature_template` SET `minlevel`=110, `dynamicflags`=32 WHERE `entry`=93095; -- Voracious Bear
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=108856; -- Agitated Stonewarden
UPDATE `creature_template` SET `gossip_menu_id`=18772 WHERE `entry`=93231; -- Vydhar
UPDATE `creature_template` SET `dynamicflags`=128 WHERE `entry`=93182; -- Runestone
UPDATE `creature_template` SET `minlevel`=110, `dynamicflags`=32 WHERE `entry`=108890; -- Runewood Greatstag
UPDATE `creature_template` SET `minlevel`=110, `unit_flags`=67141632 WHERE `entry`=93344; -- Runebound Stonewarden
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=93185; -- Credit  Bunny
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=93070; -- Bonespeaker Carver
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=93401; -- Urgev the Flayer
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=93066; -- Bonespeaker Runeaxe
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=108891; -- Runewood Doe
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=107401; -- Areg Bloodrune
UPDATE `creature_template` SET `speed_run`=0.9920629 WHERE `entry`=48706; -- Highlands Turkey
UPDATE `creature_template` SET `speed_walk`=0.888888, `speed_run`=0.9920629 WHERE `entry`=62821; -- Mystic Birdhat
UPDATE `creature_template` SET `speed_walk`=0.888888, `speed_run`=0.9920629 WHERE `entry`=62822; -- Cousin Slowhands
UPDATE `creature_template` SET `npcflag`=16777216 WHERE `entry`=98230; -- Ironhorn Buck
UPDATE `creature_template` SET `gossip_menu_id`=18657 WHERE `entry`=93624; -- Dread-Rider Cullen
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=98161; -- Garhal the Scalekeeper
UPDATE `creature_template` SET `gossip_menu_id`=19781, `minlevel`=110 WHERE `entry`=103797; -- Brulf the Heavy
UPDATE `creature_template` SET `gossip_menu_id`=10181 WHERE `entry`=106904; -- Valdemar Stormseeker
UPDATE `creature_template` SET `gossip_menu_id`=20232, `minlevel`=110 WHERE `entry`=103796; -- Riala the Hearthwatcher
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=110981; -- Fleshripper Helsquid
UPDATE `creature_template` SET `gossip_menu_id`=19809, `unit_flags`=33536 WHERE `entry`=107675; -- Rax Sixtrigger
UPDATE `creature_template` SET `minlevel`=110, `unit_flags3`=1 WHERE `entry`=92962; -- Saboteur Aronson
UPDATE `creature_template` SET `minlevel`=110, `unit_flags3`=1 WHERE `entry`=92967; -- Flavor Stalker
UPDATE `creature_template` SET `speed_run`=0.9920629 WHERE `entry`=97730; -- Black-Footed Fox Kit
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=107808; -- Plains Runehorn Calf
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=107805; -- Plains Runehorn Bull
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=107753; -- Duskpelt Alpha
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=92951; -- Houndmaster Ely
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=92956; -- Attack Mastiff
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=92591; -- Sinker
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=92590; -- Hook
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=91893; -- Erling the Lightningborn
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=91895; -- Asger Jarlborn
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=92392; -- Stormwing Drake
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=92381; -- Drekirjar Shieldbearer
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=92384; -- Tideskorn Worker
UPDATE `creature_template` SET `minlevel`=110, `unit_flags`=32784 WHERE `entry`=92374; -- Drekirjar Galeborn
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=92375; -- Stormwing Drake
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=92367; -- Tideskorn Longaxe
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=92361; -- Felscale Dominator
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=92312; -- Drekirjar Galeborn
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=92362; -- Felscale Subduer
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=92359; -- Drekirjar Felblade
UPDATE `creature_template` SET `gossip_menu_id`=20106 WHERE `entry`=92218; -- Thrymjaris
UPDATE `creature_template` SET `minlevel`=110, `npcflag`=16777216 WHERE `entry`=91767; -- Vethir
UPDATE `creature_template` SET `gossip_menu_id`=18741 WHERE `entry`=97061; -- Thrymjaris
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=97028; -- Aleifir
UPDATE `creature_template` SET `minlevel`=110, `unit_flags`=67141696 WHERE `entry`=91803; -- Fathnyr
UPDATE `creature_template` SET `gossip_menu_id`=18693 WHERE `entry`=96465; -- Vethir
UPDATE `creature_template` SET `minlevel`=110, `unit_flags`=32768 WHERE `entry`=91737; -- Azariah
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=97143; -- Juvenile Thorignir
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=97033; -- Hridmogir
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=97032; -- Erilar
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=97031; -- Hrafsir
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=91759; -- Felskorn Subduer
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=93280; -- Caged Soul
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=92128; -- Felskorn Pilferer
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=92206; -- Felscale Pilferer
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=91979; -- Grapple Point
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=91244; -- Felskorn Trapper
UPDATE `creature_template` SET `minlevel`=110, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=91566; -- Felskorn Executioner
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=91874; -- Bladesquall
UPDATE `creature_template` SET `minlevel`=110, `dynamicflags`=32 WHERE `entry`=91429; -- Tideskorn Pathfinder
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=91565; -- Raging Tempest
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=91561; -- Squall Bunny
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=91508; -- Fire Bunny
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=91240; -- Gunnlaug Scaleheart
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=98255; -- Credit - Tower Climbed
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=102852; -- Morjirn
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=99379; -- Stormcaster Throm
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=110372; -- Stormwing Drake
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=91529; -- Glimar Ironfist
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=91205; -- Drekirjar Galeborn
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=91517; -- Stormbreaker Reykir
UPDATE `creature_template` SET `minlevel`=110, `unit_flags`=67141632 WHERE `entry`=91486; -- Stormwing Drake
UPDATE `creature_template` SET `minlevel`=110, `unit_flags`=32768 WHERE `entry`=94624; -- Drekirjar Galeborn
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=108530; -- Drekirjar Galeborn
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=108579; -- Runelord Ragnar
UPDATE `creature_template` SET `minlevel`=110, `unit_flags`=67141632 WHERE `entry`=107965; -- Canyon Rockeater
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=91812; -- POI Target  Bunny
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=108403; -- Scout Grapple Point
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=105216; -- Jann Harnelor
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=100524; -- Untamed Whelp
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=91204; -- Tideskorn Longaxe
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=91229; -- Bluffwalker Goat
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=91423; -- Hillstalker Worg
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=108526; -- Tideskorn Worker
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=91417; -- Tideskorn Worker
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=91202; -- Stormwing Drake
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=100446; -- Tideskorn Huntress
UPDATE `creature_template` SET `minlevel`=110, `unit_flags`=32784 WHERE `entry`=111291; -- Stonescar River-Thresher
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=107914; -- Stonefang
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=107954; -- Stoned Vrykul
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=107957; -- Stoned Bird
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=91920; -- Stormwing Drake
UPDATE `creature_template` SET `minlevel`=110, `speed_run`=1, `unit_flags`=536904448, `unit_flags2`=2049, `dynamicflags`=32 WHERE `entry`=107803; -- Wild Plains Runehorn
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=97091; -- Duskpelt Snarler
UPDATE `creature_template` SET `gossip_menu_id`=18672 WHERE `entry`=96258; -- Yotnar
UPDATE `creature_template` SET `minlevel`=110, `unit_flags3`=1 WHERE `entry`=96174; -- Lightforged Sentinel
UPDATE `creature_template` SET `minlevel`=110, `unit_flags`=272, `unit_flags3`=1 WHERE `entry`=96175; -- Yotnar
UPDATE `creature_template` SET `minlevel`=113, `maxlevel`=113 WHERE `entry`=96282; -- Vault Guardian
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=108263; -- Felskorn Warmonger
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=96290; -- Credit - Trial of Might Started
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=96176; -- Titan Console
UPDATE `creature_template` SET `minlevel`=110, `unit_flags`=32768, `unit_flags3`=1 WHERE `entry`=99450; -- Blazesight Oculus
UPDATE `creature_template` SET `minlevel`=110, `unit_flags`=32768 WHERE `entry`=96121; -- Felskorn Torturer
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=96122; -- Titan Console
UPDATE `creature_template` SET `minlevel`=110, `unit_flags3`=1 WHERE `entry`=93151; -- Titan Beam
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=93110; -- Vault Keeper
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=96139; -- Titan Console
UPDATE `creature_template` SET `gossip_menu_id`=0 WHERE `entry`=6491; -- Spirit Healer
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=96215; -- Felskorn Runetwister
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=107258; -- Juvenile Squallhunter
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=90747; -- Slash Gutspill
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=96283; -- Yotnar
UPDATE `creature_template` SET `minlevel`=110, `unit_flags`=32848 WHERE `entry`=93166; -- Tiptog the Lost
UPDATE `creature_template` SET `minlevel`=113, `maxlevel`=113 WHERE `entry`=89817; -- Vault Guardian
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=107755; -- Amberfall Doe
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=107758; -- Amberfall Greatstag
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=96255; -- Credit - Vrykul Champion Missing
UPDATE `creature_template` SET `minlevel`=110, `unit_flags`=32768 WHERE `entry`=96135; -- Felskorn Warmonger
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=96129; -- Felskorn Raider
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=90734; -- Gro Rumblehoof
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=108306; -- Felskorn Raider
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=108309; -- Bloodtotem Flameheart
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=96229; -- Bloodtotem Skirmisher
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=100435; -- Bloodtotem Flameheart
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=110604; -- Credit - Ingredients Added
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=97306; -- Muninn
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=108289; -- Bloodtotem Skirmisher
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=108283; -- Mightstone Savage
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=96236; -- Mightstone Savage
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=100433; -- Mightstone Rockcaller
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=97755; -- Galecrested Eagle
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=108322; -- Ferngrazer Stag
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=108313; -- Ferngrazer Doe
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=99223; -- Adult Squallhunter
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=107455; -- Squallhunter Whelpling
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=108935; -- Highlands Runehorn Calf
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=7, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=103786; -- Well-Fed Musken
UPDATE `creature_template` SET `npcflag`=3 WHERE `entry`=98367; -- Tigrid the Charmer
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=90748; -- Whitewater Tempest
UPDATE `creature_template` SET `minlevel`=110, `dynamicflags`=32 WHERE `entry`=107445; -- Apprentice Conjuror
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=106150; -- Felsoul Magus
UPDATE `creature_template` SET `minlevel`=110, `speed_run`=1 WHERE `entry`=108927; -- Gluttonous Raven
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=104865; -- Galius Miremoore
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=91460; -- Spymaster Shwayder
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=107254; -- Felscale Imp
UPDATE `creature_template` SET `dynamicflags`=32 WHERE `entry`=113911; -- Spymaster Knockwhistle
UPDATE `creature_template` SET `dynamicflags`=32 WHERE `entry`=91470; -- Spymaster Knockwhistle
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=91458; -- Vicious Ravenbear
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=108538; -- Highlands Runehorn
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=97305; -- Huginn
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=107840; -- Stormforged Grapple Launcher
UPDATE `creature_template` SET `minlevel`=110, `dynamicflags`=32 WHERE `entry`=97828; -- Silvertail Mountain Goat
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=109867; -- Fjara Rockjaw
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=107667; -- Crimson Rockshell
UPDATE `creature_template` SET `minlevel`=110, `faction`=84, `unit_flags`=32768 WHERE `entry`=91571; -- Thane Wildsky
UPDATE `creature_template` SET `npcflag`=16777216 WHERE `entry`=91904; -- Dread-Captain Tattersail
UPDATE `creature_template` SET `unit_flags`=16 WHERE `entry`=88981; -- Ironclaw Scuttler
UPDATE `creature_template` SET `minlevel`=110, `dynamicflags`=32 WHERE `entry`=91880; -- Royal Dreadguard
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=91581; -- 7th Legion Paratrooper
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=91693; -- Black Rose Apothecary
UPDATE `creature_template` SET `minlevel`=110, `dynamicflags`=32 WHERE `entry`=91881; -- Skyfire Gryphon
UPDATE `creature_template` SET `minlevel`=110, `dynamicflags`=32 WHERE `entry`=91414; -- Skyfire Gryphon Rider
UPDATE `creature_template` SET `minlevel`=110, `unit_flags3`=1 WHERE `entry`=91950; -- Forsaken Ranger
UPDATE `creature_template` SET `unit_flags`=0 WHERE `entry`=83642; -- Mud Jumper
UPDATE `creature_template` SET `minlevel`=110, `speed_run`=1.385714, `unit_flags`=536904448, `unit_flags2`=2049, `dynamicflags`=32 WHERE `entry`=91824; -- Bluffwalker Goat
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=111206; -- Saberfang Worg
UPDATE `creature_template` SET `gossip_menu_id`=20708, `minlevel`=110 WHERE `entry`=91535; -- Quartermaster Ricard
UPDATE `creature_template` SET `minlevel`=110, `unit_flags3`=1 WHERE `entry`=98143; -- Forsaken Dreadwing
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=110534; -- Provisioner Sheldon
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=91590; -- Apothecary Withers
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=96928; -- Black Rose Apothecary
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=91825; -- Bay Hunter
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=91563; -- Volatile Sailor
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=91532; -- Forsaken Deathguard
UPDATE `creature_template` SET `minlevel`=110, `unit_flags`=67141632 WHERE `entry`=91569; -- Volatile Bear
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=110846; -- Cove Raven
UPDATE `creature_template` SET `speed_run`=1.385714 WHERE `entry`=91473; -- Dread-Rider Cullen
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=91885; -- Forsaken Crewman
UPDATE `creature_template` SET `minlevel`=110 WHERE `entry`=89829; -- Highcrag Eagle

DELETE FROM `gameobject_template` WHERE `entry` IN (250852 /*Animal Bones*/, 246665 /*Barricade*/, 253247 /*Bonfire*/);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `RequiredLevel`, `VerifiedBuild`) VALUES
(250852, 5, 16147, 'Animal Bones', '', '', '', 1.5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- Animal Bones
(246665, 5, 19432, 'Barricade', '', '', '', 2.56, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- Barricade
(253247, 8, 23396, 'Bonfire', '', '', '', 2.789998, 4, 10, 2066, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 23420); -- Bonfire

UPDATE `gameobject_template` SET `name`='Baskets', `VerifiedBuild`=23420 WHERE `entry`=250596; -- Baskets
UPDATE `gameobject_template` SET `VerifiedBuild`=23420 WHERE `entry`=250612; -- Snaggle's Note
UPDATE `gameobject_template` SET `name`='Corn', `VerifiedBuild`=23420 WHERE `entry`=250595; -- Corn
UPDATE `gameobject_template` SET `name`='Campfire', `VerifiedBuild`=23420 WHERE `entry`=259756; -- Campfire
UPDATE `gameobject_template` SET `name`='Forsaken Blight Cache', `VerifiedBuild`=23420 WHERE `entry`=243343; -- Forsaken Blight Cache
UPDATE `gameobject_template` SET `name`='Stool', `VerifiedBuild`=23420 WHERE `entry`=253270; -- Stool
UPDATE `gameobject_template` SET `name`='Stool', `VerifiedBuild`=23420 WHERE `entry`=253269; -- Stool
UPDATE `gameobject_template` SET `name`='Stool', `VerifiedBuild`=23420 WHERE `entry`=253264; -- Stool
UPDATE `gameobject_template` SET `name`='Stool', `VerifiedBuild`=23420 WHERE `entry`=253263; -- Stool
UPDATE `gameobject_template` SET `name`='Stool', `VerifiedBuild`=23420 WHERE `entry`=253262; -- Stool
UPDATE `gameobject_template` SET `name`='Stool', `VerifiedBuild`=23420 WHERE `entry`=253261; -- Stool
UPDATE `gameobject_template` SET `name`='Mailbox', `VerifiedBuild`=23420 WHERE `entry`=266464; -- Mailbox
UPDATE `gameobject_template` SET `name`='Campfire', `VerifiedBuild`=23420 WHERE `entry`=259757; -- Campfire
UPDATE `gameobject_template` SET `name`='Stool', `VerifiedBuild`=23420 WHERE `entry`=253268; -- Stool
UPDATE `gameobject_template` SET `name`='Stool', `VerifiedBuild`=23420 WHERE `entry`=253267; -- Stool
UPDATE `gameobject_template` SET `name`='Stool', `VerifiedBuild`=23420 WHERE `entry`=253266; -- Stool
UPDATE `gameobject_template` SET `castBarCaption`='Collecting', `Data1`=0, `VerifiedBuild`=23420 WHERE `entry`=258850; -- Ancient Dreyrgrot Tablet
UPDATE `gameobject_template` SET `castBarCaption`='Opening', `Data1`=0, `VerifiedBuild`=23420 WHERE `entry`=250985; -- Treasure Chest
UPDATE `gameobject_template` SET `castBarCaption`='Collecting', `Data1`=0, `VerifiedBuild`=23420 WHERE `entry`=251008; -- Ancient Dreyrgrot Tablet
UPDATE `gameobject_template` SET `VerifiedBuild`=23420 WHERE `entry`=250990; -- Crate of Ancient Relics
UPDATE `gameobject_template` SET `castBarCaption`='Opening', `Data1`=0, `VerifiedBuild`=23420 WHERE `entry`=250987; -- Small Treasure Chest
UPDATE `gameobject_template` SET `castBarCaption`='Collecting', `Data1`=0, `VerifiedBuild`=23420 WHERE `entry`=258851; -- Ancient Dreyrgrot Tablet
UPDATE `gameobject_template` SET `castBarCaption`='Collecting', `Data1`=0, `VerifiedBuild`=23420 WHERE `entry`=258849; -- Ancient Dreyrgrot Tablet
UPDATE `gameobject_template` SET `castBarCaption`='Collecting', `Data1`=0, `VerifiedBuild`=23420 WHERE `entry`=251007; -- Crate of Ancient Relics
UPDATE `gameobject_template` SET `name`='Forsaken Blight Cache', `VerifiedBuild`=23420 WHERE `entry`=243339; -- Forsaken Blight Cache
UPDATE `gameobject_template` SET `castBarCaption`='Opening', `Data1`=0, `VerifiedBuild`=23420 WHERE `entry`=251772; -- Small Treasure Chest
UPDATE `gameobject_template` SET `name`='Campfire', `VerifiedBuild`=23420 WHERE `entry`=259758; -- Campfire
UPDATE `gameobject_template` SET `name`='Stool', `VerifiedBuild`=23420 WHERE `entry`=253276; -- Stool
UPDATE `gameobject_template` SET `name`='Stool', `VerifiedBuild`=23420 WHERE `entry`=253275; -- Stool
UPDATE `gameobject_template` SET `name`='Stool', `VerifiedBuild`=23420 WHERE `entry`=253274; -- Stool
UPDATE `gameobject_template` SET `castBarCaption`='Opening', `Data1`=0, `VerifiedBuild`=23420 WHERE `entry`=251762; -- Small Treasure Chest
UPDATE `gameobject_template` SET `name`='Target', `VerifiedBuild`=23420 WHERE `entry`=250610; -- Target
UPDATE `gameobject_template` SET `castBarCaption`='Opening', `Data1`=0, `VerifiedBuild`=23420 WHERE `entry`=251792; -- Small Treasure Chest
UPDATE `gameobject_template` SET `name`='Intact Greatstag Antler', `VerifiedBuild`=23420 WHERE `entry`=250537; -- Intact Greatstag Antler
UPDATE `gameobject_template` SET `name`='Supplies', `VerifiedBuild`=23420 WHERE `entry`=246675; -- Supplies
UPDATE `gameobject_template` SET `name`='Supplies', `VerifiedBuild`=23420 WHERE `entry`=246668; -- Supplies
UPDATE `gameobject_template` SET `VerifiedBuild`=23420 WHERE `entry`=247421; -- Powder Keg
UPDATE `gameobject_template` SET `name`='Supplies', `VerifiedBuild`=23420 WHERE `entry`=246672; -- Supplies
UPDATE `gameobject_template` SET `name`='Banner', `VerifiedBuild`=23420 WHERE `entry`=246667; -- Banner
UPDATE `gameobject_template` SET `name`='Torch', `VerifiedBuild`=23420 WHERE `entry`=246666; -- Torch
UPDATE `gameobject_template` SET `VerifiedBuild`=23420 WHERE `entry`=250536; -- Intact Greatstag Antler
UPDATE `gameobject_template` SET `name`='Feather', `VerifiedBuild`=23420 WHERE `entry`=250538; -- Feather
UPDATE `gameobject_template` SET `castBarCaption`='Placing', `VerifiedBuild`=23420 WHERE `entry`=244457; -- Spitefeather's Rock
UPDATE `gameobject_template` SET `castBarCaption`='Opening', `Data1`=0, `VerifiedBuild`=23420 WHERE `entry`=251820; -- Treasure Chest
UPDATE `gameobject_template` SET `castBarCaption`='Retrieving', `Data1`=0, `Data14`=23645, `Data30`=62721, `Data31`=1, `VerifiedBuild`=23420 WHERE `entry`=245171; -- Agnes' Skinning Knife
UPDATE `gameobject_template` SET `name`='Torch', `VerifiedBuild`=23420 WHERE `entry`=243239; -- Torch
UPDATE `gameobject_template` SET `name`='Sylvanas Arrow', `VerifiedBuild`=23420 WHERE `entry`=243035; -- Sylvanas Arrow
UPDATE `gameobject_template` SET `name`='Barrier', `VerifiedBuild`=23420 WHERE `entry`=242572; -- Barrier
UPDATE `gameobject_template` SET `castBarCaption`='Receiving Blessing', `VerifiedBuild`=23420 WHERE `entry`=242995; -- Eyir's Pauldron
UPDATE `gameobject_template` SET `castBarCaption`='Receiving Blessing', `VerifiedBuild`=23420 WHERE `entry`=242994; -- Eyir's Helm
UPDATE `gameobject_template` SET `castBarCaption`='Receiving Blessing', `VerifiedBuild`=23420 WHERE `entry`=242996; -- Eyir's Shield
UPDATE `gameobject_template` SET `VerifiedBuild`=23420 WHERE `entry`=251558; -- Engraved Shield
UPDATE `gameobject_template` SET `castBarCaption`='Receiving Blessing', `VerifiedBuild`=23420 WHERE `entry`=242998; -- Eyir's Spear
UPDATE `gameobject_template` SET `castBarCaption`='Activating', `VerifiedBuild`=23420 WHERE `entry`=243574; -- Shieldmaiden Idol
UPDATE `gameobject_template` SET `VerifiedBuild`=23420 WHERE `entry`=251560; -- Engraved Shield
UPDATE `gameobject_template` SET `VerifiedBuild`=23420 WHERE `entry`=251559; -- Engraved Shield
UPDATE `gameobject_template` SET `name`='Bonfire', `VerifiedBuild`=23420 WHERE `entry`=253255; -- Bonfire
UPDATE `gameobject_template` SET `VerifiedBuild`=23420 WHERE `entry`=251557; -- Engraved Shield
UPDATE `gameobject_template` SET `castBarCaption`='Opening', `Data1`=0, `VerifiedBuild`=23420 WHERE `entry`=244903; -- Treasure Chest
UPDATE `gameobject_template` SET `castBarCaption`='Gathering', `Data1`=0, `VerifiedBuild`=23420 WHERE `entry`=244828; -- The Fjarnskaggl Fjormula
UPDATE `gameobject_template` SET `VerifiedBuild`=23420 WHERE `entry`=251561; -- Engraved Shield
UPDATE `gameobject_template` SET `castBarCaption`='Activating', `VerifiedBuild`=23420 WHERE `entry`=243571; -- Shieldmaiden Idol
UPDATE `gameobject_template` SET `castBarCaption`='Activating', `VerifiedBuild`=23420 WHERE `entry`=243573; -- Shieldmaiden Idol
UPDATE `gameobject_template` SET `name`='Titan Table', `VerifiedBuild`=23420 WHERE `entry`=243062; -- Titan Table
UPDATE `gameobject_template` SET `name`='Bonfire', `VerifiedBuild`=23420 WHERE `entry`=253246; -- Bonfire
UPDATE `gameobject_template` SET `VerifiedBuild`=23420 WHERE `entry`=242673; -- Engraved Shield
UPDATE `gameobject_template` SET `castBarCaption`='Activating', `VerifiedBuild`=23420 WHERE `entry`=243570; -- Shieldmaiden Idol
UPDATE `gameobject_template` SET `VerifiedBuild`=23420 WHERE `entry`=251571; -- Ashilvara, Verse 1
UPDATE `gameobject_template` SET `type`=10, `displayId`=8586, `IconName`='questinteract', `castBarCaption`='Planting', `size`=1.5, `Data0`=1691, `Data3`=3000, `Data14`=51667, `Data20`=1, `VerifiedBuild`=23420 WHERE `entry`=243455; -- Plant Explosives
UPDATE `gameobject_template` SET `name`='Gilnean Heavy Explosive', `VerifiedBuild`=23420 WHERE `entry`=243456; -- Gilnean Heavy Explosive
UPDATE `gameobject_template` SET `Data1`=19413, `VerifiedBuild`=23420 WHERE `entry`=243454; -- Gilnean Heavy Explosive
UPDATE `gameobject_template` SET `name`='Stool', `VerifiedBuild`=23420 WHERE `entry`=253582; -- Stool
UPDATE `gameobject_template` SET `name`='Stool', `VerifiedBuild`=23420 WHERE `entry`=253581; -- Stool
UPDATE `gameobject_template` SET `name`='Anvil', `VerifiedBuild`=23420 WHERE `entry`=253574; -- Anvil
UPDATE `gameobject_template` SET `name`='Forge', `VerifiedBuild`=23420 WHERE `entry`=253573; -- Forge
UPDATE `gameobject_template` SET `name`='Mailbox', `VerifiedBuild`=23420 WHERE `entry`=266465; -- Mailbox
UPDATE `gameobject_template` SET `name`='Campfire', `VerifiedBuild`=23420 WHERE `entry`=259759; -- Campfire
UPDATE `gameobject_template` SET `name`='Stool', `VerifiedBuild`=23420 WHERE `entry`=253580; -- Stool
UPDATE `gameobject_template` SET `name`='Stool', `VerifiedBuild`=23420 WHERE `entry`=253579; -- Stool
UPDATE `gameobject_template` SET `name`='Stool', `VerifiedBuild`=23420 WHERE `entry`=253575; -- Stool
UPDATE `gameobject_template` SET `name`='Stool', `VerifiedBuild`=23420 WHERE `entry`=253578; -- Stool
UPDATE `gameobject_template` SET `name`='Stool', `VerifiedBuild`=23420 WHERE `entry`=253576; -- Stool
UPDATE `gameobject_template` SET `name`='Stool', `VerifiedBuild`=23420 WHERE `entry`=253577; -- Stool
UPDATE `gameobject_template` SET `castBarCaption`='Opening', `Data1`=0, `VerifiedBuild`=23420 WHERE `entry`=244904; -- Small Treasure Chest
UPDATE `gameobject_template` SET `castBarCaption`='Opening', `Data1`=0, `VerifiedBuild`=23420 WHERE `entry`=244902; -- Treasure Chest
UPDATE `gameobject_template` SET `name`='Tideskorn Cage', `VerifiedBuild`=23420 WHERE `entry`=248775; -- Tideskorn Cage
UPDATE `gameobject_template` SET `name`='Fel Portal', `VerifiedBuild`=23420 WHERE `entry`=244768; -- Fel Portal
UPDATE `gameobject_template` SET `castBarCaption`='Breaking', `VerifiedBuild`=23420 WHERE `entry`=244703; -- Nether Circle
UPDATE `gameobject_template` SET `castBarCaption`='Breaking', `VerifiedBuild`=23420 WHERE `entry`=244729; -- Nether Circle
UPDATE `gameobject_template` SET `castBarCaption`='Breaking', `VerifiedBuild`=23420 WHERE `entry`=244730; -- Nether Circle
UPDATE `gameobject_template` SET `castBarCaption`='Opening', `Data1`=0, `VerifiedBuild`=23420 WHERE `entry`=251714; -- Small Treasure Chest
UPDATE `gameobject_template` SET `name`='Felbound Portal', `VerifiedBuild`=23420 WHERE `entry`=244681; -- Felbound Portal
UPDATE `gameobject_template` SET `castBarCaption`='Breaking', `VerifiedBuild`=23420 WHERE `entry`=244731; -- Nether Circle
UPDATE `gameobject_template` SET `castBarCaption`='Breaking', `VerifiedBuild`=23420 WHERE `entry`=244733; -- Nether Circle
UPDATE `gameobject_template` SET `castBarCaption`='Opening', `VerifiedBuild`=23420 WHERE `entry`=248601; -- Tideskorn Cage
UPDATE `gameobject_template` SET `name`='Fel Blood Cauldron', `VerifiedBuild`=23420 WHERE `entry`=244696; -- Fel Blood Cauldron
UPDATE `gameobject_template` SET `castBarCaption`='Burning', `VerifiedBuild`=23420 WHERE `entry`=244704; -- Tideskorn Banner
UPDATE `gameobject_template` SET `name`='FelMag_Empowered_AuraFel', `VerifiedBuild`=23420 WHERE `entry`=251285; -- FelMag_Empowered_AuraFel
UPDATE `gameobject_template` SET `name`='FelMag_Empowered_AuraFel', `VerifiedBuild`=23420 WHERE `entry`=251277; -- FelMag_Empowered_AuraFel
UPDATE `gameobject_template` SET `name`='FelMag_Empowered_AuraFel', `VerifiedBuild`=23420 WHERE `entry`=251276; -- FelMag_Empowered_AuraFel
UPDATE `gameobject_template` SET `name`='FelMag_Empowered_AuraFel', `VerifiedBuild`=23420 WHERE `entry`=251275; -- FelMag_Empowered_AuraFel
UPDATE `gameobject_template` SET `VerifiedBuild`=23420 WHERE `entry`=251221; -- Floki's Runestone
UPDATE `gameobject_template` SET `VerifiedBuild`=23420 WHERE `entry`=251220; -- Ragnar's Runestone
UPDATE `gameobject_template` SET `VerifiedBuild`=23420 WHERE `entry`=251219; -- Cage
UPDATE `gameobject_template` SET `VerifiedBuild`=23420 WHERE `entry`=251218; -- Rollo's Runestone
UPDATE `gameobject_template` SET `name`='Fish', `VerifiedBuild`=23420 WHERE `entry`=244870; -- Fish
UPDATE `gameobject_template` SET `name`='Fish', `VerifiedBuild`=23420 WHERE `entry`=244869; -- Fish
UPDATE `gameobject_template` SET `name`='Fish', `VerifiedBuild`=23420 WHERE `entry`=244871; -- Fish
UPDATE `gameobject_template` SET `name`='Fishing Rod', `VerifiedBuild`=23420 WHERE `entry`=244868; -- Fishing Rod
UPDATE `gameobject_template` SET `castBarCaption`='Collecting', `VerifiedBuild`=23420 WHERE `entry`=244867; -- Fish Barrel
UPDATE `gameobject_template` SET `name`='Nail', `VerifiedBuild`=23420 WHERE `entry`=244483; -- Nail
UPDATE `gameobject_template` SET `castBarCaption`='Burning', `VerifiedBuild`=23420 WHERE `entry`=244565; -- Kvaldir Spoils
UPDATE `gameobject_template` SET `Data3`=18790, `VerifiedBuild`=23420 WHERE `entry`=244559; -- Helya's Altar
UPDATE `gameobject_template` SET `castBarCaption`='Opening', `VerifiedBuild`=23420 WHERE `entry`=241272; -- Treasure Chest
UPDATE `gameobject_template` SET `VerifiedBuild`=23420 WHERE `entry`=240603; -- Cursed Seaweed
UPDATE `gameobject_template` SET `castBarCaption`='Opening', `VerifiedBuild`=23420 WHERE `entry`=241267; -- Small Treasure Chest
UPDATE `gameobject_template` SET `name`='Kvaldir Cage', `castBarCaption`='Opening', `VerifiedBuild`=23420 WHERE `entry`=241686; -- Kvaldir Cage
UPDATE `gameobject_template` SET `name`='Kvaldir Cage', `castBarCaption`='Opening', `VerifiedBuild`=23420 WHERE `entry`=241833; -- Kvaldir Cage
UPDATE `gameobject_template` SET `name`='Kvaldir Cage', `castBarCaption`='Opening', `VerifiedBuild`=23420 WHERE `entry`=241832; -- Kvaldir Cage
UPDATE `gameobject_template` SET `castBarCaption`='Gathering', `Data1`=0, `VerifiedBuild`=23420 WHERE `entry`=240586; -- Cursed Bones
UPDATE `gameobject_template` SET `name`='Kvaldir Cage', `castBarCaption`='Opening', `VerifiedBuild`=23420 WHERE `entry`=241783; -- Kvaldir Cage
UPDATE `gameobject_template` SET `name`='Kvaldir Cage', `castBarCaption`='Opening', `VerifiedBuild`=23420 WHERE `entry`=241774; -- Kvaldir Cage
UPDATE `gameobject_template` SET `name`='Kvaldir Cage', `castBarCaption`='Opening', `VerifiedBuild`=23420 WHERE `entry`=241771; -- Kvaldir Cage
UPDATE `gameobject_template` SET `name`='Kvaldir Cage', `castBarCaption`='Opening', `VerifiedBuild`=23420 WHERE `entry`=241688; -- Kvaldir Cage
UPDATE `gameobject_template` SET `name`='Bonfire', `VerifiedBuild`=23420 WHERE `entry`=259816; -- Bonfire
UPDATE `gameobject_template` SET `castBarCaption`='Opening', `VerifiedBuild`=23420 WHERE `entry`=241216; -- Treasure Chest
UPDATE `gameobject_template` SET `VerifiedBuild`=23420 WHERE `entry`=240649; -- Small Treasure Chest
UPDATE `gameobject_template` SET `name`='Bonfire', `VerifiedBuild`=23420 WHERE `entry`=259815; -- Bonfire
UPDATE `gameobject_template` SET `name`='Kvaldir Cage', `castBarCaption`='Opening', `VerifiedBuild`=23420 WHERE `entry`=241683; -- Kvaldir Cage
UPDATE `gameobject_template` SET `castBarCaption`='Opening', `VerifiedBuild`=23420 WHERE `entry`=241778; -- Colborn's Cage
UPDATE `gameobject_template` SET `name`='Kvaldir Cage', `castBarCaption`='Opening', `VerifiedBuild`=23420 WHERE `entry`=241729; -- Kvaldir Cage
UPDATE `gameobject_template` SET `name`='Kvaldir Cage', `VerifiedBuild`=23420 WHERE `entry`=244587; -- Kvaldir Cage
UPDATE `gameobject_template` SET `name`='Bone Pile', `VerifiedBuild`=23420 WHERE `entry`=240604; -- Bone Pile
UPDATE `gameobject_template` SET `name`='Portal to Stormheim', `VerifiedBuild`=23420 WHERE `entry`=241755; -- Portal to Stormheim
UPDATE `gameobject_template` SET `name`='Kvaldir Cage', `castBarCaption`='Opening', `VerifiedBuild`=23420 WHERE `entry`=241782; -- Kvaldir Cage
UPDATE `gameobject_template` SET `name`='Kvaldir Cage', `castBarCaption`='Opening', `VerifiedBuild`=23420 WHERE `entry`=241779; -- Kvaldir Cage
UPDATE `gameobject_template` SET `name`='Kvaldir Cage', `castBarCaption`='Opening', `VerifiedBuild`=23420 WHERE `entry`=241693; -- Kvaldir Cage
UPDATE `gameobject_template` SET `castBarCaption`='Opening', `Data1`=0, `VerifiedBuild`=23420 WHERE `entry`=251856; -- Small Treasure Chest
UPDATE `gameobject_template` SET `name`='Portal to Helheim', `VerifiedBuild`=23420 WHERE `entry`=241758; -- Portal to Helheim
UPDATE `gameobject_template` SET `name`='Altar', `VerifiedBuild`=23420 WHERE `entry`=244452; -- Altar
UPDATE `gameobject_template` SET `castBarCaption`='Opening', `Data1`=0, `VerifiedBuild`=23420 WHERE `entry`=251723; -- Small Treasure Chest
UPDATE `gameobject_template` SET `castBarCaption`='Opening', `Data1`=0, `VerifiedBuild`=23420 WHERE `entry`=244899; -- Small Treasure Chest
UPDATE `gameobject_template` SET `castBarCaption`='Breaking', `VerifiedBuild`=23420 WHERE `entry`=251412; -- Ritual Stone
UPDATE `gameobject_template` SET `castBarCaption`='Collecting', `Data1`=0, `VerifiedBuild`=23420 WHERE `entry`=241872; -- Ashildir's Bones
UPDATE `gameobject_template` SET `name`='Campfire', `VerifiedBuild`=23420 WHERE `entry`=244907; -- Campfire
UPDATE `gameobject_template` SET `castBarCaption`='Activating', `VerifiedBuild`=23420 WHERE `entry`=244450; -- Rune of Reformation
UPDATE `gameobject_template` SET `castBarCaption`='Opening', `Data1`=0, `VerifiedBuild`=23420 WHERE `entry`=251854; -- Small Treasure Chest
UPDATE `gameobject_template` SET `castBarCaption`='Breaking', `VerifiedBuild`=23420 WHERE `entry`=251413; -- Ritual Stone
UPDATE `gameobject_template` SET `castBarCaption`='Collecting', `Data1`=0, `VerifiedBuild`=23420 WHERE `entry`=241870; -- Ashildir's Bones
UPDATE `gameobject_template` SET `VerifiedBuild`=23420 WHERE `entry`=241840; -- Rune-Carved Tablet
UPDATE `gameobject_template` SET `name`='Altar', `VerifiedBuild`=23420 WHERE `entry`=241839; -- Altar
UPDATE `gameobject_template` SET `castBarCaption`='Breaking', `VerifiedBuild`=23420 WHERE `entry`=241849; -- Ritual Stone
UPDATE `gameobject_template` SET `castBarCaption`='Collecting', `Data1`=0, `VerifiedBuild`=23420 WHERE `entry`=241874; -- Ashildir's Bones
UPDATE `gameobject_template` SET `castBarCaption`='Opening', `Data1`=0, `VerifiedBuild`=23420 WHERE `entry`=244901; -- Treasure Chest
UPDATE `gameobject_template` SET `castBarCaption`='Collecting', `Data1`=0, `VerifiedBuild`=23420 WHERE `entry`=241873; -- Ashildir's Bones
UPDATE `gameobject_template` SET `castBarCaption`='Collecting', `Data1`=0, `VerifiedBuild`=23420 WHERE `entry`=244779; -- Ancient Vrykul Rune Tablet
UPDATE `gameobject_template` SET `castBarCaption`='Collecting', `Data1`=0, `VerifiedBuild`=23420 WHERE `entry`=241871; -- Ashildir's Bones
UPDATE `gameobject_template` SET `castBarCaption`='Opening', `Data1`=0, `VerifiedBuild`=23420 WHERE `entry`=241518; -- Small Treasure Chest
UPDATE `gameobject_template` SET `castBarCaption`='Placing', `VerifiedBuild`=23420 WHERE `entry`=241869; -- Offering Bowl
UPDATE `gameobject_template` SET `name`='Tomb Door', `VerifiedBuild`=23420 WHERE `entry`=251522; -- Tomb Door
UPDATE `gameobject_template` SET `castBarCaption`='Opening', `Data1`=0, `VerifiedBuild`=23420 WHERE `entry`=251761; -- Small Treasure Chest
UPDATE `gameobject_template` SET `castBarCaption`='Placing', `VerifiedBuild`=23420 WHERE `entry`=241868; -- Offering Bowl
UPDATE `gameobject_template` SET `castBarCaption`='Placing', `VerifiedBuild`=23420 WHERE `entry`=241864; -- Offering Bowl
UPDATE `gameobject_template` SET `castBarCaption`='Opening', `Data1`=0, `VerifiedBuild`=23420 WHERE `entry`=250984; -- Small Treasure Chest
UPDATE `gameobject_template` SET `name`='Map', `VerifiedBuild`=23420 WHERE `entry`=254021; -- Map
UPDATE `gameobject_template` SET `castBarCaption`='Placing', `VerifiedBuild`=23420 WHERE `entry`=241877; -- Offering Bowl
UPDATE `gameobject_template` SET `name`='Slab', `VerifiedBuild`=23420 WHERE `entry`=241863; -- Slab
UPDATE `gameobject_template` SET `name`='Torch', `VerifiedBuild`=23420 WHERE `entry`=241862; -- Torch
UPDATE `gameobject_template` SET `VerifiedBuild`=23420 WHERE `entry`=241838; -- Disturbed Earth
UPDATE `gameobject_template` SET `name`='Bonfire', `VerifiedBuild`=23420 WHERE `entry`=253244; -- Bonfire
UPDATE `gameobject_template` SET `name`='Runestone', `VerifiedBuild`=23420 WHERE `entry`=241765; -- Runestone
UPDATE `gameobject_template` SET `castBarCaption`='Opening', `Data1`=0, `VerifiedBuild`=23420 WHERE `entry`=251713; -- Small Treasure Chest
UPDATE `gameobject_template` SET `castBarCaption`='Opening', `Data1`=0, `VerifiedBuild`=23420 WHERE `entry`=233107; -- Small Treasure Chest
UPDATE `gameobject_template` SET `name`='Bonfire', `VerifiedBuild`=23420 WHERE `entry`=253252; -- Bonfire
UPDATE `gameobject_template` SET `castBarCaption`='Collecting', `Data1`=0, `VerifiedBuild`=23420 WHERE `entry`=241866; -- Soulthorn
UPDATE `gameobject_template` SET `name`='Runestone Base', `VerifiedBuild`=23420 WHERE `entry`=241763; -- Runestone Base
UPDATE `gameobject_template` SET `VerifiedBuild`=23420 WHERE `entry`=244708; -- Watcher's Journal
UPDATE `gameobject_template` SET `VerifiedBuild`=23420 WHERE `entry`=251431; -- Empowered Runestones
UPDATE `gameobject_template` SET `name`='Cleaver', `VerifiedBuild`=23420 WHERE `entry`=244866; -- Cleaver
UPDATE `gameobject_template` SET `name`='Bones', `VerifiedBuild`=23420 WHERE `entry`=244865; -- Bones
UPDATE `gameobject_template` SET `name`='Meat Chunk', `VerifiedBuild`=23420 WHERE `entry`=244864; -- Meat Chunk
UPDATE `gameobject_template` SET `name`='Meat Chunk', `VerifiedBuild`=23420 WHERE `entry`=244863; -- Meat Chunk
UPDATE `gameobject_template` SET `name`='Meat Chunk', `VerifiedBuild`=23420 WHERE `entry`=244862; -- Meat Chunk
UPDATE `gameobject_template` SET `name`='Meat Chunk', `VerifiedBuild`=23420 WHERE `entry`=244861; -- Meat Chunk
UPDATE `gameobject_template` SET `name`='Spear', `VerifiedBuild`=23420 WHERE `entry`=244860; -- Spear
UPDATE `gameobject_template` SET `name`='Mailbox', `VerifiedBuild`=23420 WHERE `entry`=266466; -- Mailbox
UPDATE `gameobject_template` SET `VerifiedBuild`=23420 WHERE `entry`=266054; -- Keg of Grog
UPDATE `gameobject_template` SET `VerifiedBuild`=23420 WHERE `entry`=244872; -- Spear
UPDATE `gameobject_template` SET `name`='Spit Post', `VerifiedBuild`=23420 WHERE `entry`=244859; -- Spit Post
UPDATE `gameobject_template` SET `name`='Campfire', `VerifiedBuild`=23420 WHERE `entry`=253250; -- Campfire
UPDATE `gameobject_template` SET `name`='Zeppelin', `VerifiedBuild`=23420 WHERE `entry`=250554; -- Zeppelin
UPDATE `gameobject_template` SET `name`='Baskets', `VerifiedBuild`=23420 WHERE `entry`=250564; -- Baskets
UPDATE `gameobject_template` SET `name`='Bedroll', `VerifiedBuild`=23420 WHERE `entry`=250574; -- Bedroll
UPDATE `gameobject_template` SET `name`='Corn', `VerifiedBuild`=23420 WHERE `entry`=250565; -- Corn
UPDATE `gameobject_template` SET `name`='Campfire', `VerifiedBuild`=23420 WHERE `entry`=257312; -- Campfire
UPDATE `gameobject_template` SET `name`='Stool', `VerifiedBuild`=23420 WHERE `entry`=257311; -- Stool
UPDATE `gameobject_template` SET `name`='Stool', `VerifiedBuild`=23420 WHERE `entry`=257310; -- Stool
UPDATE `gameobject_template` SET `name`='Stool', `VerifiedBuild`=23420 WHERE `entry`=248571; -- Stool
UPDATE `gameobject_template` SET `name`='Stool', `VerifiedBuild`=23420 WHERE `entry`=248570; -- Stool
UPDATE `gameobject_template` SET `name`='Campfire', `VerifiedBuild`=23420 WHERE `entry`=248569; -- Campfire
UPDATE `gameobject_template` SET `name`='Baskets', `VerifiedBuild`=23420 WHERE `entry`=250573; -- Baskets
UPDATE `gameobject_template` SET `name`='Spear', `VerifiedBuild`=23420 WHERE `entry`=250570; -- Spear
UPDATE `gameobject_template` SET `name`='Weapon Rack', `VerifiedBuild`=23420 WHERE `entry`=250569; -- Weapon Rack
UPDATE `gameobject_template` SET `name`='Bow', `VerifiedBuild`=23420 WHERE `entry`=250567; -- Bow
UPDATE `gameobject_template` SET `name`='Campfire', `VerifiedBuild`=23420 WHERE `entry`=259753; -- Campfire
UPDATE `gameobject_template` SET `name`='Sled', `VerifiedBuild`=23420 WHERE `entry`=250571; -- Sled
UPDATE `gameobject_template` SET `name`='Hides', `VerifiedBuild`=23420 WHERE `entry`=250566; -- Hides
UPDATE `gameobject_template` SET `name`='Baskets', `VerifiedBuild`=23420 WHERE `entry`=250563; -- Baskets
UPDATE `gameobject_template` SET `name`='Baskets', `VerifiedBuild`=23420 WHERE `entry`=250561; -- Baskets
UPDATE `gameobject_template` SET `castBarCaption`='Opening', `Data1`=0, `VerifiedBuild`=23420 WHERE `entry`=241154; -- Small Treasure Chest
UPDATE `gameobject_template` SET `castBarCaption`='Breaking', `VerifiedBuild`=23420 WHERE `entry`=240650; -- Ritual Circle
UPDATE `gameobject_template` SET `VerifiedBuild`=23420 WHERE `entry`=251173; -- Forbidden Tome
UPDATE `gameobject_template` SET `castBarCaption`='Breaking', `VerifiedBuild`=23420 WHERE `entry`=244337; -- Ritual Circle
UPDATE `gameobject_template` SET `castBarCaption`='Opening', `Data1`=0, `VerifiedBuild`=23420 WHERE `entry`=241152; -- Treasure Chest
UPDATE `gameobject_template` SET `castBarCaption`='Opening', `Data1`=0, `VerifiedBuild`=23420 WHERE `entry`=251780; -- Small Treasure Chest
UPDATE `gameobject_template` SET `castBarCaption`='Breaking', `VerifiedBuild`=23420 WHERE `entry`=244336; -- Ritual Circle
UPDATE `gameobject_template` SET `castBarCaption`='Collecting', `VerifiedBuild`=23420 WHERE `entry`=241279; -- Intact Thorignir Egg
UPDATE `gameobject_template` SET `castBarCaption`='Breaking', `VerifiedBuild`=23420 WHERE `entry`=244335; -- Ritual Circle
UPDATE `gameobject_template` SET `castBarCaption`='Opening', `Data1`=0, `VerifiedBuild`=23420 WHERE `entry`=241148; -- Small Treasure Chest
UPDATE `gameobject_template` SET `name`='Cauldron', `VerifiedBuild`=23420 WHERE `entry`=246870; -- Cauldron
UPDATE `gameobject_template` SET `castBarCaption`='Opening', `VerifiedBuild`=23420 WHERE `entry`=245671; -- Whelp Cage
UPDATE `gameobject_template` SET `castBarCaption`='Opening', `VerifiedBuild`=23420 WHERE `entry`=245669; -- Whelp Cage
UPDATE `gameobject_template` SET `castBarCaption`='Opening', `Data1`=0, `VerifiedBuild`=23420 WHERE `entry`=241207; -- Small Treasure Chest
UPDATE `gameobject_template` SET `name`='Bonfire', `VerifiedBuild`=23420 WHERE `entry`=253253; -- Bonfire
UPDATE `gameobject_template` SET `castBarCaption`='Opening', `Data1`=0, `VerifiedBuild`=23420 WHERE `entry`=241147; -- Small Treasure Chest
UPDATE `gameobject_template` SET `name`='Wood Pile', `VerifiedBuild`=23420 WHERE `entry`=245622; -- Wood Pile
UPDATE `gameobject_template` SET `castBarCaption`='Collecting', `Data1`=0, `VerifiedBuild`=23420 WHERE `entry`=241460; -- Climbing Treads
UPDATE `gameobject_template` SET `castBarCaption`='Opening', `VerifiedBuild`=23420 WHERE `entry`=245668; -- Whelp Cage
UPDATE `gameobject_template` SET `castBarCaption`='Opening', `VerifiedBuild`=23420 WHERE `entry`=245667; -- Whelp Cage
UPDATE `gameobject_template` SET `VerifiedBuild`=23420 WHERE `entry`=241429; -- Dragon-Blood Brew
UPDATE `gameobject_template` SET `castBarCaption`='Opening', `Data1`=0, `VerifiedBuild`=23420 WHERE `entry`=241146; -- Treasure Chest
UPDATE `gameobject_template` SET `castBarCaption`='Gathering', `Data1`=0, `VerifiedBuild`=23420 WHERE `entry`=244829; -- The Tangled Beard
UPDATE `gameobject_template` SET `name`='Bonfire', `VerifiedBuild`=23420 WHERE `entry`=253257; -- Bonfire
UPDATE `gameobject_template` SET `castBarCaption`='Opening', `VerifiedBuild`=23420 WHERE `entry`=245670; -- Whelp Cage
UPDATE `gameobject_template` SET `castBarCaption`='Opening', `VerifiedBuild`=23420 WHERE `entry`=245672; -- Whelp Cage
UPDATE `gameobject_template` SET `castBarCaption`='Collecting', `Data1`=0, `VerifiedBuild`=23420 WHERE `entry`=241462; -- Oiled Cloak
UPDATE `gameobject_template` SET `VerifiedBuild`=23420 WHERE `entry`=240365; -- Tethering Post
UPDATE `gameobject_template` SET `castBarCaption`='Dismantling', `VerifiedBuild`=23420 WHERE `entry`=251257; -- Tideskorn Harpoon Launcher
UPDATE `gameobject_template` SET `VerifiedBuild`=23420 WHERE `entry`=246924; -- Blazing Storm Mead
UPDATE `gameobject_template` SET `VerifiedBuild`=23420 WHERE `entry`=246922; -- Weak Storm Mead
UPDATE `gameobject_template` SET `castBarCaption`='Opening', `Data1`=0, `VerifiedBuild`=23420 WHERE `entry`=241149; -- Small Treasure Chest
UPDATE `gameobject_template` SET `name`='Campfire', `VerifiedBuild`=23420 WHERE `entry`=259754; -- Campfire
UPDATE `gameobject_template` SET `VerifiedBuild`=23420 WHERE `entry`=246925; -- Sour Storm Mead
UPDATE `gameobject_template` SET `castBarCaption`='Opening', `Data1`=0, `VerifiedBuild`=23420 WHERE `entry`=241564; -- Small Treasure Chest
UPDATE `gameobject_template` SET `castBarCaption`='Opening', `Data1`=0, `VerifiedBuild`=23420 WHERE `entry`=241665; -- Treasure Chest
UPDATE `gameobject_template` SET `Data1`=64266, `VerifiedBuild`=23420 WHERE `entry`=246491; -- Fever of Stormrays
UPDATE `gameobject_template` SET `castBarCaption`='Accessing Record', `VerifiedBuild`=23420 WHERE `entry`=243802; -- Powered Console
UPDATE `gameobject_template` SET `castBarCaption`='Opening', `Data1`=0, `VerifiedBuild`=23420 WHERE `entry`=241153; -- Small Treasure Chest
UPDATE `gameobject_template` SET `castBarCaption`='Collecting', `Data1`=0, `VerifiedBuild`=23420 WHERE `entry`=243822; -- Yotnar's Right Foot
UPDATE `gameobject_template` SET `castBarCaption`='Accessing Record', `VerifiedBuild`=23420 WHERE `entry`=243817; -- Powered Console
UPDATE `gameobject_template` SET `castBarCaption`='Accessing Record', `VerifiedBuild`=23420 WHERE `entry`=243801; -- Powered Console
UPDATE `gameobject_template` SET `castBarCaption`='Activating', `VerifiedBuild`=23420 WHERE `entry`=243808; -- Unpowered Console
UPDATE `gameobject_template` SET `VerifiedBuild`=23420 WHERE `entry`=251189; -- Plate of Leftovers
UPDATE `gameobject_template` SET `name`='Defender Statue', `VerifiedBuild`=23420 WHERE `entry`=241702; -- Defender Statue
UPDATE `gameobject_template` SET `castBarCaption`='Opening', `VerifiedBuild`=23420 WHERE `entry`=241721; -- Glimmering Treasure Chest
UPDATE `gameobject_template` SET `castBarCaption`='Activating', `VerifiedBuild`=23420 WHERE `entry`=243814; -- Unpowered Console
UPDATE `gameobject_template` SET `name`='Titan Defense Device', `VerifiedBuild`=23420 WHERE `entry`=242444; -- Titan Defense Device
UPDATE `gameobject_template` SET `castBarCaption`='Collecting', `Data1`=0, `VerifiedBuild`=23420 WHERE `entry`=243820; -- Yotnar's Right Arm
UPDATE `gameobject_template` SET `name`='Yotnar\'s  Left Foot', `castBarCaption`='Collecting', `Data1`=0, `VerifiedBuild`=23420 WHERE `entry`=243823; -- Yotnar's  Left Foot
UPDATE `gameobject_template` SET `name`='Hologram Projector', `VerifiedBuild`=23420 WHERE `entry`=243818; -- Hologram Projector
UPDATE `gameobject_template` SET `castBarCaption`='Collecting', `Data1`=0, `Data14`=19676, `Data30`=61884, `VerifiedBuild`=23420 WHERE `entry`=243819; -- Yotnar's Left Arm
UPDATE `gameobject_template` SET `VerifiedBuild`=23420 WHERE `entry`=243836; -- Yotnar's Head
UPDATE `gameobject_template` SET `castBarCaption`='Breaking', `VerifiedBuild`=23420 WHERE `entry`=243845; -- Demonic Runestone
UPDATE `gameobject_template` SET `name`='Waygate', `VerifiedBuild`=23420 WHERE `entry`=241705; -- Waygate
UPDATE `gameobject_template` SET `castBarCaption`='Opening', `Data1`=0, `VerifiedBuild`=23420 WHERE `entry`=251782; -- Small Treasure Chest
UPDATE `gameobject_template` SET `name`='Yotnar\'s Body', `VerifiedBuild`=23420 WHERE `entry`=243835; -- Yotnar's Body
UPDATE `gameobject_template` SET `name`='Bonfire', `VerifiedBuild`=23420 WHERE `entry`=253242; -- Bonfire
UPDATE `gameobject_template` SET `castBarCaption`='Burning', `VerifiedBuild`=23420 WHERE `entry`=243842; -- Tideskorn Banner
UPDATE `gameobject_template` SET `name`='Vrykul Crate', `VerifiedBuild`=23420 WHERE `entry`=243830; -- Vrykul Crate
UPDATE `gameobject_template` SET `name`='Campfire', `VerifiedBuild`=23420 WHERE `entry`=253237; -- Campfire
UPDATE `gameobject_template` SET `castBarCaption`='Opening', `Data1`=0, `VerifiedBuild`=23420 WHERE `entry`=241206; -- Small Treasure Chest
UPDATE `gameobject_template` SET `name`='Campfire', `VerifiedBuild`=23420 WHERE `entry`=253238; -- Campfire
UPDATE `gameobject_template` SET `castBarCaption`='Burning', `VerifiedBuild`=23420 WHERE `entry`=243841; -- Bloodtotem Standard
UPDATE `gameobject_template` SET `name`='Vrykul Crate', `VerifiedBuild`=23420 WHERE `entry`=251876; -- Vrykul Crate
UPDATE `gameobject_template` SET `name`='Rock', `VerifiedBuild`=23420 WHERE `entry`=251101; -- Rock
UPDATE `gameobject_template` SET `name`='Veggie', `VerifiedBuild`=23420 WHERE `entry`=252075; -- Veggie
UPDATE `gameobject_template` SET `castBarCaption`='Grabbing', `VerifiedBuild`=23420 WHERE `entry`=252074; -- Basket of Root Vegetables
UPDATE `gameobject_template` SET `name`='Pot of Stew', `VerifiedBuild`=23420 WHERE `entry`=244480; -- Pot of Stew
UPDATE `gameobject_template` SET `name`='Campfire', `VerifiedBuild`=23420 WHERE `entry`=253235; -- Campfire
UPDATE `gameobject_template` SET `castBarCaption`='Grabbing', `VerifiedBuild`=23420 WHERE `entry`=252080; -- Hearty Vrykul Grains
UPDATE `gameobject_template` SET `name`='Bowl', `VerifiedBuild`=23420 WHERE `entry`=252079; -- Bowl
UPDATE `gameobject_template` SET `name`='Crab', `VerifiedBuild`=23420 WHERE `entry`=252078; -- Crab
UPDATE `gameobject_template` SET `name`='Barrel', `VerifiedBuild`=23420 WHERE `entry`=252077; -- Barrel
UPDATE `gameobject_template` SET `castBarCaption`='Grabbing', `VerifiedBuild`=23420 WHERE `entry`=252076; -- Barrel of Crabs
UPDATE `gameobject_template` SET `name`='Sack', `VerifiedBuild`=23420 WHERE `entry`=250572; -- Sack
UPDATE `gameobject_template` SET `VerifiedBuild`=23420 WHERE `entry`=251188; -- Wicked-Looking Spear
UPDATE `gameobject_template` SET `castBarCaption`='Burning', `VerifiedBuild`=23420 WHERE `entry`=243840; -- Mightstone Banner
UPDATE `gameobject_template` SET `castBarCaption`='Opening', `Data1`=0, `VerifiedBuild`=23420 WHERE `entry`=251776; -- Small Treasure Chest
UPDATE `gameobject_template` SET `castBarCaption`='Collecting', `VerifiedBuild`=23420 WHERE `entry`=250424; -- Loose Rock
UPDATE `gameobject_template` SET `castBarCaption`='Breaking', `VerifiedBuild`=23420 WHERE `entry`=250427; -- Squallhunter Egg
UPDATE `gameobject_template` SET `castBarCaption`='Opening', `Data1`=0, `VerifiedBuild`=23420 WHERE `entry`=251716; -- Glimmering Treasure Chest
UPDATE `gameobject_template` SET `castBarCaption`='Taking', `Data1`=0, `VerifiedBuild`=23420 WHERE `entry`=249890; -- Tigrid's Arkhana
UPDATE `gameobject_template` SET `castBarCaption`='Opening', `Data1`=0, `VerifiedBuild`=23420 WHERE `entry`=241558; -- Treasure Chest
UPDATE `gameobject_template` SET `castBarCaption`='Broadcasting Signal', `VerifiedBuild`=23420 WHERE `entry`=240235; -- Skyfire Propeller
UPDATE `gameobject_template` SET `castBarCaption`='Opening', `Data1`=0, `VerifiedBuild`=23420 WHERE `entry`=241562; -- Small Treasure Chest
UPDATE `gameobject_template` SET `castBarCaption`='Opening', `Data1`=0, `VerifiedBuild`=23420 WHERE `entry`=251764; -- Small Treasure Chest
UPDATE `gameobject_template` SET `castBarCaption`='Opening', `Data1`=0, `VerifiedBuild`=23420 WHERE `entry`=241212; -- Treasure Chest
UPDATE `gameobject_template` SET `castBarCaption`='Opening', `Data1`=0, `VerifiedBuild`=23420 WHERE `entry`=241180; -- Treasure Chest
UPDATE `gameobject_template` SET `name`='Broken Cloaking Device', `VerifiedBuild`=23420 WHERE `entry`=241109; -- Broken Cloaking Device
UPDATE `gameobject_template` SET `name`='Skeleton', `VerifiedBuild`=23420 WHERE `entry`=241035; -- Skeleton
UPDATE `gameobject_template` SET `name`='Acid Burn', `VerifiedBuild`=23420 WHERE `entry`=241033; -- Acid Burn
UPDATE `gameobject_template` SET `castBarCaption`='Examining', `VerifiedBuild`=23420 WHERE `entry`=241032; -- Plague-Tipped Arrow
UPDATE `gameobject_template` SET `name`='Campfire', `VerifiedBuild`=23420 WHERE `entry`=256928; -- Campfire
UPDATE `gameobject_template` SET `castBarCaption`='Opening', `Data1`=0, `VerifiedBuild`=23420 WHERE `entry`=241213; -- Small Treasure Chest
UPDATE `gameobject_template` SET `castBarCaption`='Examining', `VerifiedBuild`=23420 WHERE `entry`=241031; -- Dread-Captain's Saber
UPDATE `gameobject_template` SET `name`='Campfire', `VerifiedBuild`=23420 WHERE `entry`=256929; -- Campfire
UPDATE `gameobject_template` SET `VerifiedBuild`=23420 WHERE `entry`=244453; -- Cullen's Scouting Report
UPDATE `gameobject_template` SET `name`='Stool', `VerifiedBuild`=23420 WHERE `entry`=253241; -- Stool
UPDATE `gameobject_template` SET `name`='Anvil', `VerifiedBuild`=23420 WHERE `entry`=253239; -- Anvil
UPDATE `gameobject_template` SET `name`='Stool', `VerifiedBuild`=23420 WHERE `entry`=253236; -- Stool
UPDATE `gameobject_template` SET `name`='Stool', `VerifiedBuild`=23420 WHERE `entry`=253240; -- Stool
UPDATE `gameobject_template` SET `name`='Worgen Plank', `VerifiedBuild`=23420 WHERE `entry`=240981; -- Worgen Plank
UPDATE `gameobject_template` SET `name`='Worgen Plank', `VerifiedBuild`=23420 WHERE `entry`=240980; -- Worgen Plank

-- DB/Trainers: Magar & Bowen Brisboise
-- 
UPDATE `creature_template` SET `gossip_menu_id`=4267 WHERE `entry`=3523;
DELETE FROM `gossip_menu_option_trainer` WHERE `MenuId` IN (4347,4267);
INSERT INTO `gossip_menu_option_trainer` (`MenuId`, `OptionIndex`, `TrainerId`) VALUES
(4347, 0, 163),
(4267, 0, 163);

-- DB/Misc: Fix typo on game_tele for Greymane Wal
--
UPDATE `game_tele` SET `name`='TheGreymaneWall' WHERE `id`=1071;
--

-- DB/Gossip: Add Missing gossip texts for some NPCs in Sunstrider Isle
-- Arcanist Ithanas
UPDATE `creature_template` SET `gossip_menu_id`= 15296 WHERE `entry`= 15296;

DELETE FROM `gossip_menu` WHERE `MenuId`= 15296;
INSERT INTO `gossip_menu` (`MenuId`,`textid`,`VerifiedBuild`) VALUES (15296, 7787, 0);

-- Arcanist Helion
UPDATE `creature_template` SET `gossip_menu_id`= 15297 WHERE `entry`= 15297;

DELETE FROM `gossip_menu` WHERE `MenuId`= 15297;
INSERT INTO `gossip_menu` (`MenuId`,`textid`,`VerifiedBuild`) VALUES (15297, 7786, 0);

-- Lanthan Perilon
DELETE FROM `gossip_menu` WHERE `MenuId`= 6570 AND `textid`= 7785;
INSERT INTO `gossip_menu` (`MenuId`,`textid`,`VerifiedBuild`) VALUES (6570, 7785, 0);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`= 14 AND `SourceGroup`= 6570;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`comment`) VALUES
(14, 6570, 7785, 0, 0, 8, 0, 8335, 0, 0, 1, 0, 0, '', "Gossip text requires quest 'Felendren the Banished' NOT rewarded"),
(14, 6570, 7869, 0, 0, 8, 0, 8335, 0, 0, 0, 0, 0, '', "Gossip text requires quest 'Felendren the Banished' rewarded");

-- Outrunner Alarion
DELETE FROM `gossip_menu` WHERE `MenuId`= 6573 AND `textid`= 7788;
INSERT INTO `gossip_menu` (`MenuId`,`textid`,`VerifiedBuild`) VALUES (6573, 7788, 0);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`= 14 AND `SourceGroup`= 6573;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`comment`) VALUES
(14, 6573, 7788, 0, 0, 8, 0, 9705, 0, 0, 1, 0, 0, '', "Gossip text requires quest 'Package Recovery' NOT rewarded"),
(14, 6573, 7821, 0, 0, 8, 0, 9705, 0, 0, 0, 0, 0, '', "Gossip text requires quest 'Package Recovery' rewarded");

-- DB/Gameobject: Update name to English.
UPDATE `gameobject_template` SET `name`='Iron Horde Capsule' WHERE `entry`=231763;

-- DB/Misc: some startup error
DELETE FROM `gameobject_template` WHERE `entry` = 1619; 
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `RequiredLevel`, `AIName`, `ScriptName`, `VerifiedBuild`) VALUES ('1619','3','414','Earthroot','','','','0.4','30','1416','0','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','20','1','0','0','0','0','0','0','0','0','0','0','0','0','0','','','26972'); 
UPDATE `gameobject_template` SET `Data0` = 221694 WHERE `entry` = 207691; 
DELETE FROM `gameobject_template_addon` WHERE `entry` = 300184; 
DELETE FROM `spell_proc` WHERE `spellid` = 253324; 
DELETE FROM `creature_model_info` WHERE `DisplayID` IN (84345, 87473, 87586, 87441, 87446, 87474, 87460, 87448, 87470, 87447, 87439, 87435, 87461, 87450, 87440, 25202); 
UPDATE `creature_template` SET `flags_extra` = 0, `unit_flags2` = 2048 WHERE `entry` = 38913; 

-- DB/Condition: Fix missing value from commit #1b78bb
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 26 AND `SourceGroup`=3329 AND `SourceEntry` = 6719);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES
(26, 3329, 6719, 0, 0, 47, 0, 34582, 1, 0, 0, 'Apply Phase 3329 if Quest 34582 is NOT Taken');

-- DB/Spell: added conditions for Argent Squire/Gruntling Pennant spells
-- Condition for source Spell implicit target condition type Object entry guid
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceGroup`=1 AND `SourceEntry` IN (62727, 63438, 63439, 63440, 63441, 63442, 63443, 63444, 63445, 63446) AND `SourceId`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 62727, 0, 0, 31, 0, 3, 33238, 0, 0, 0, 0, '', 'Spell Stormwind Champion''s Pennant (effect 0) will hit the potential target of the spell if target is unit Argent Squire.'),
(13, 1, 63438, 0, 0, 31, 0, 3, 33239, 0, 0, 0, 0, '', 'Spell Silvermoon Champion''s Pennant (effect 0) will hit the potential target of the spell if target is unit Argent Gruntling.'),
(13, 1, 63439, 0, 0, 31, 0, 3, 33238, 0, 0, 0, 0, '', 'Spell Exodar Champion''s Pennant (effect 0) will hit the potential target of the spell if target is unit Argent Squire.'),
(13, 1, 63440, 0, 0, 31, 0, 3, 33238, 0, 0, 0, 0, '', 'Spell Ironforge Champion''s Pennant (effect 0) will hit the potential target of the spell if target is unit Argent Squire.'),
(13, 1, 63441, 0, 0, 31, 0, 3, 33239, 0, 0, 0, 0, '', 'Spell Undercity Champion''s Pennant (effect 0) will hit the potential target of the spell if target is unit Argent Gruntling.'),
(13, 1, 63442, 0, 0, 31, 0, 3, 33238, 0, 0, 0, 0, '', 'Spell Gnomeregan Champion''s Pennant (effect 0) will hit the potential target of the spell if target is unit Argent Squire.'),
(13, 1, 63443, 0, 0, 31, 0, 3, 33238, 0, 0, 0, 0, '', 'Spell Darnassus Champion''s Pennant (effect 0) will hit the potential target of the spell if target is unit Argent Squire.'),
(13, 1, 63444, 0, 0, 31, 0, 3, 33239, 0, 0, 0, 0, '', 'Spell Orgrimmar Champion''s Pennant (effect 0) will hit the potential target of the spell if target is unit Argent Gruntling.'),
(13, 1, 63445, 0, 0, 31, 0, 3, 33239, 0, 0, 0, 0, '', 'Spell Thunder Bluff Champion''s Pennant (effect 0) will hit the potential target of the spell if target is unit Argent Gruntling.'),
(13, 1, 63446, 0, 0, 31, 0, 3, 33239, 0, 0, 0, 0, '', 'Spell Sen''jin Champion''s Pennant (effect 0) will hit the potential target of the spell if target is unit Argent Gruntling.');

-- DB/Misc: fix Pandaren zone quest area
DELETE FROM `spell_area` WHERE `spell` IN (105096, 108914, 117783, 117501, 108931, 105525, 115449, 115447, 109067, 105095, 105001, 104566, 105306, 104334, 106394, 104567, 105005, 105307, 105308, 108842, 108844, 109100, 104028, 104762, 115446, 115448, 118028, 104018, 114455, 109303, 108835, 108822, 108823, 128574, 102875, 102871, 116571, 102874, 102870, 103051, 108879, 108834, 102873, 102872, 102869, 106494, 106493, 102868, 105156, 105157, 105158, 108695, 108694, 105162, 105161, 105160, 102521, 119305, 119306, 119307, 102400, 102399, 102398, 102397, 102396, 102395, 114735, 102194, 100709, 107027, 107028, 107032, 102403, 100711, 107033, 102393, 102429);
INSERT INTO `spell_area` (`spell`, `area`, `quest_start`, `quest_end`, `aura_spell`, `racemask`, `gender`, `flags`, `quest_start_status`, `quest_end_status`) VALUES
(100709, 5834, 0, 29524, 0, 0, 2, 3, 0, 9), -- See Quest Invis 1 (Master Shang bench)
(107027, 5834, 0, 29406, 0, 0, 2, 3, 0, 11), -- See Quest Invis 20 (Gate 1 - GO)
(107028, 5834, 0, 29524, 0, 0, 2, 3, 0, 9), -- See Quest Invis 21 (Master Shang's staff & barrel near bench - GO)
(107032, 5834, 29524, 0, 0, 0, 2, 3, 74, 0), -- See Quest Invis 22 (Gate 2 - GO)
(102403, 5825, 29524, 0, 0, 0, 2, 3, 8, 0), -- Force Reaction Sparring Trainees
(102403, 5834, 29524, 0, 0, 0, 2, 3, 8, 0), -- Force Reaction Sparring Trainees
(102403, 5843, 29524, 0, 0, 0, 2, 3, 8, 0), -- Force Reaction Sparring Trainees
(100711, 5834, 29524, 29409, 0, 0, 2, 3, 66, 9), -- See Quest Invis 3 (Master Shang inside)
(107033, 5834, 29409, 0, 0, 0, 2, 3, 74, 0), -- See Quest Invis 23 (Gate 3 - GO)
(102429, 5825, 29409, 0, 0, 0, 2, 3, 10, 0), -- Force Reaction Jaomin Po
(102429, 5843, 29409, 0, 0, 0, 2, 3, 10, 0), -- Force Reaction Jaomin Po
(102194, 5825, 29409, 29414, 0, 0, 2, 3, 66, 9), -- See Quest Invis 4 (Master Shang bridge)
(102194, 5834, 29409, 29414, 0, 0, 2, 3, 66, 9), -- See Quest Invis 4 (Master Shang bridge)
(102194, 5843, 29409, 29414, 0, 0, 2, 3, 66, 9), -- See Quest Invis 4 (Master Shang bridge)
(102393, 5825, 0, 29419, 0, 0, 2, 3, 0, 9), -- See Quest Invis 5 (Mechant Lorvo & Alysa mole)
(102393, 5846, 0, 29419, 0, 0, 2, 3, 0, 9), -- See Quest Invis 5 (Mechant Lorvo & Alysa mole)
(114735, 5825, 29419, 29414, 0, 0, 2, 3, 66, 1), -- See Quest Invis 10 (Alysa Cloudsinger mole)
(114735, 5846, 29419, 29414, 0, 0, 2, 3, 66, 1), -- See Quest Invis 10 (Alysa Cloudsinger mole)
(102395, 5825, 29419, 0, 0, 0, 2, 3, 66, 0), -- See Quest Invis 6 (Mechant Lorvo mole)
(102395, 5846, 29419, 0, 0, 0, 2, 3, 66, 0), -- See Quest Invis 6 (Mechant Lorvo mole)
(102396, 5825, 29414, 29417, 0, 0, 2, 3, 66, 1), -- See Quest Invis 7 (Master Shang & Alysa cave)
(102396, 5846, 29414, 29417, 0, 0, 2, 3, 66, 1), -- See Quest Invis 7 (Master Shang & Alysa cave)
(102396, 5848, 29414, 29417, 0, 0, 2, 3, 66, 1), -- See Quest Invis 7 (Master Shang & Alysa cave)
(102397, 5835, 29522, 0, 0, 0, 2, 3, 66, 0), -- See Quest Invis 8 (???)
(102398, 5835, 29523, 29423, 0, 0, 2, 3, 66, 1), -- See Quest Invis 9 (Master Shang Wu-Shong Village)
(102399, 5849, 29420, 29423, 0, 0, 2, 3, 66, 9), -- See Quest Invis 10 (Master Li Fei)
(102400, 5849, 0, 29423, 0, 0, 2, 3, 0, 1), -- See Quest Invis 11 (Huo)
(102521, 5849, 0, 29422, 0, 0, 2, 3, 0, 1), -- See Quest Invis 12 (Flame Wall - GO)
(105160, 5849, 0, 29664, 0, 0, 2, 3, 0, 9), -- See Quest Invis 16 (Red Flame - GO)
(105161, 5849, 0, 29664, 0, 0, 2, 3, 0, 9), -- See Quest Invis 17 (Blue Flame - GO)
(105162, 5849, 0, 29664, 0, 0, 2, 3, 0, 9), -- See Quest Invis 18 (Violet Flame - GO)
(108694, 5849, 29664, 0, 0, 0, 2, 3, 8, 0), -- See Quest Invis 19 (Sparkle Bunny - Flickering Flame)
(108695, 5849, 29664, 0, 0, 0, 2, 3, 8, 0), -- See Quest Invis 20 (Sparkle Bunny flames)
(105156, 5849, 29664, 29422, 0, 0, 2, 6, 74, 1), -- See Quest Invis 13 (Red Flame activated - GO)
(105157, 5849, 29664, 29422, 0, 0, 2, 6, 74, 1), -- See Quest Invis 14 (Blue Flame activated - GO)
(105158, 5849, 29664, 29422, 0, 0, 2, 6, 74, 1), -- See Quest Invis 15 (Violet Flame activated - GO)
(119305, 5849, 29422, 0, 0, 0, 2, 3, 74, 0), -- See Quest Invis 13 (Red Flame activated - GO)
(119306, 5849, 29422, 0, 0, 0, 2, 3, 74, 0), -- See Quest Invis 14 (Blue Flame activated - GO)
(119307, 5849, 29422, 0, 0, 0, 2, 3, 74, 0), -- See Quest Invis 15 (Violet Flame activated - GO)
(106493, 5820, 0, 29423, 0, 0, 2, 3, 0, 11), -- See Quest Invis 15 (Brazier temple)
(102868, 5820, 29423, 29775, 0, 0, 2, 3, 74, 9), -- See Quest Invis 1 (Master Shang temple)
(106494, 5820, 29423, 0, 0, 0, 2, 7, 66, 0), -- See Quest Invis 16 (Brazier temple - GO)
(102869, 5826, 29521, 29677, 0, 0, 2, 3, 66, 1), -- See Quest Invis 1 (Aysa in water)
(102872, 5826, 0, 29662, 0, 0, 2, 3, 0, 11), -- See Quest Invis 4 (Jojo Ironbrow)
(102873, 5826, 0, 29677, 0, 0, 2, 3, 0, 9), -- See Quest Invis 5 (Old Man Liang - Liang's Retreat)
(102873, 5860, 0, 29677, 0, 0, 2, 3, 0, 9), -- See Quest Invis 5 (Old Man Liang - Liang's Retreat)
(108834, 5826, 0, 29662, 0, 0, 2, 5, 0, 11), -- See Quest Invis 8 (Children & Onlookers)
(108879, 5826, 0, 0, 0, 0, 2, 3, 0, 0), -- See Quest Invis 9 (Cart - The Singing Pools)
(103051, 5826, 29663, 0, 0, 0, 2, 3, 8, 0), -- Force Reaction Tushui Monks
(102870, 5826, 29677, 29678, 0, 0, 2, 3, 74, 9), -- See Quest Invis 2 (Aysa near jumping rocks)
(102874, 5826, 29677, 29678, 0, 0, 2, 3, 74, 9), -- See Quest Invis 6 (Old Man Liang near jumping rocks)
(116571, 5862, 29678, 0, 0, 0, 2, 3, 74, 0), -- Blessing of the Water Strider
(102871, 5862, 29678, 29776, 0, 0, 2, 3, 66, 11), -- See Quest Invis 3 (Aysa near Shu)
(102871, 5826, 29678, 29776, 0, 0, 2, 3, 66, 11), -- See Quest Invis 3 (Aysa near Shu)
(102875, 5862, 29678, 0, 0, 0, 2, 3, 66, 0), -- See Quest Invis 7 (Old Man Liang near Shu)
(102875, 5826, 29678, 0, 0, 0, 2, 3, 66, 0), -- See Quest Invis 7 (Old Man Liang near Shu)
(128574, 5862, 29678, 29679, 0, 0, 2, 3, 66, 9), -- See Quest Invis 29 (Shu)
(104018, 5881, 29680, 29774, 0, 0, 2, 7, 64, 9), -- See Quest Invis 1 (Shu)
(108822, 5881, 29423, 29768, 0, 0, 2, 3, 64, 1), -- See Quest Invis 2 (Ji Firepaw)
(108823, 5881, 29662, 29771, 0, 0, 2, 3, 64, 11), -- See Quest Invis 3 (Jojo Ironbrow)
(108835, 5881, 29662, 29771, 0, 0, 2, 5, 64, 11), -- See Quest Invis 4 (Children & Onlookers)
(109303, 5881, 0, 29774, 0, 0, 2, 3, 0, 9), -- See Quest Invis 5 (Wugou - gong)
(114455, 5881, 0, 0, 0, 0, 2, 3, 0, 0), -- See Quest Invis 6 (Cart - The Dai-Lo Farmstead)
(118028, 5881, 29768, 29776, 0, 0, 2, 3, 74, 11), -- See Quest Invis 7 (Ji Firepaw)
(115446, 5828, 0, 29792, 0, 0, 2, 3, 0, 9), -- See Quest Invis 29 (Mandori Village Gate - GO)
(104028, 5820, 29775, 29776, 0, 0, 2, 3, 66, 11), -- See Quest Invis 2 (Master Shang)
(104762, 5886, 29786, 0, 0, 0, 2, 3, 8, 0), -- Phase Shift: Dragon Fight + Normal
(104334, 5886, 0, 29785, 0, 0, 2, 3, 0, 9), -- See Quest Invis 1 (Chamber Winds - GO)
(106394, 5859, 0, 29787, 0, 0, 2, 3, 0, 9), -- See Quest Invis 2 (Spirit Wall - GO)
(104566, 5886, 29785, 29786, 0, 0, 2, 3, 66, 1), -- See Quest Invis 4 (Aysa - near Air Spirit)
(104567, 5886, 0, 29786, 0, 0, 2, 3, 0, 1), -- See Quest Invis 5 (Dafeng)
(105005, 5830, 0, 29787, 0, 0, 2, 3, 0, 1), -- See Quest Invis 6 (Balloon)
(105005, 5946, 0, 29787, 0, 0, 2, 3, 0, 1), -- See Quest Invis 6 (Balloon)
(105307, 5830, 29776, 29787, 0, 0, 2, 3, 66, 1), -- See Quest Invis 7 (Ji Firepaw)
(105307, 5946, 29776, 29787, 0, 0, 2, 3, 66, 1), -- See Quest Invis 7 (Ji Firepaw)
(105308, 5830, 29776, 0, 0, 0, 2, 3, 66, 0), -- See Quest Invis 8 (Aysa on rope - Lake)
(105308, 5946, 29776, 0, 0, 0, 2, 3, 66, 0), -- See Quest Invis 8 (Aysa on rope - Lake)
(108842, 5830, 29771, 29782, 0, 0, 2, 3, 66, 11), -- See Quest Invis 9 (Jojo Ironbrow)
(108842, 5946, 29771, 29782, 0, 0, 2, 3, 66, 11), -- See Quest Invis 9 (Jojo Ironbrow)
(108844, 5830, 29771, 29782, 0, 0, 2, 5, 66, 11), -- See Quest Invis 10 (Children & Onlookers)
(108844, 5946, 29771, 29782, 0, 0, 2, 5, 66, 11), -- See Quest Invis 10 (Children & Onlookers)
(109100, 5829, 0, 0, 0, 0, 2, 3, 0, 0), -- See Quest Invis 11 (???)
(105306, 5831, 0, 0, 0, 0, 2, 1, 0, 0), -- Summon Ji Yuan - has conditions
(105001, 5859, 29787, 29791, 0, 0, 2, 3, 74, 9), -- See Quest Invis 1 (Ji Firepaw)
(105001, 5832, 29787, 29791, 0, 0, 2, 3, 74, 9), -- See Quest Invis 1 (Ji Firepaw)
(105095, 5820, 29791, 0, 0, 0, 2, 3, 66, 0), --  See Quest Invis 3 (Elder Shaopai)
(109067, 5820, 29776, 29791, 0, 0, 2, 3, 64, 9), --  See Quest Invis 17 (Uplifting Draft)
(115448, 5828, 29792, 0, 0, 0, 2, 3, 8, 0), -- See Quest Invis 27 (Pei-Wu Forest Gate - GO)
(115448, 5737, 29792, 0, 0, 0, 2, 3, 8, 0), -- See Quest Invis 27 (Pei-Wu Forest Gate - GO)
(115447, 5828, 29792, 0, 0, 0, 2, 3, 74, 0), -- See Quest Invis 28 (Mandori Village Gate open - GO)
(115447, 5737, 29792, 0, 0, 0, 2, 3, 74, 0), -- See Quest Invis 28 (Mandori Village Gate open - GO)
(115449, 5737, 29792, 0, 0, 0, 2, 3, 66, 0), -- See Quest Invis 26 (Pei-Wu Forest Gate open - GO)
(105525, 5833, 0, 29794, 0, 0, 2, 3, 0, 9), -- See Quest Invis 1 (Injured Sailor)
(108931, 5833, 0, 0, 0, 0, 2, 3, 0, 0), -- See Quest Invis 2 (Cart - Wreck of the Skyseeker)
(117501, 5833, 0, 29799, 0, 0, 2, 3, 0, 1), -- See Quest Invis 11 (Aysa Cloudsinger - after Vordraka fight)
(117783, 5833, 29799, 0, 0, 0, 2, 3, 8, 0), -- The Healing of Shen-zin Su - altpower
(108914, 5820, 29800, 0, 0, 0, 2, 3, 74, 0), -- See Quest Invis 5 (Delora, Aysa, Ji, Korga)
(105096, 5820, 29800, 0, 0, 0, 2, 3, 74, 0); -- See Quest Invis 4 (Spirit of Master Shang)

-- DB/Equip: Add missing equipment template to Khadgar.
DELETE FROM `creature_equip_template` WHERE `CreatureID`=78558;
INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `AppearanceModID1`, `ItemVisual1`, `ItemID2`, `AppearanceModID2`, `ItemVisual2`, `ItemID3`, `AppearanceModID3`, `ItemVisual3`, `VerifiedBuild`) VALUES
(78558, 1, 28067, 0, 0, 0, 0, 0, 0, 0, 0, 0); -- 78558

-- DB/Creature: fix regenerating health for vehicles in Wintergrasp and BGs
UPDATE `creature_template` SET `RegenHealth`=0 WHERE `entry` IN (
/* Wintergrasp */
27881, -- Wintergrasp Catapult
28094, -- Wintergrasp Demolisher
28312, -- Wintergrasp Siege Engine
28366, -- Wintergrasp Tower Cannon
32627, -- Wintergrasp Siege Engine

/* Strand of the Ancients */
27894, 32795, -- Antipersonnel Cannon
28781, 32796, -- Battleground Demolisher

/* Isle of Conquest*/
34775, 35415, -- Demolisher
34776, 35431, -- Siege Engine
34793, 35413, -- Catapult
34802, 35419, -- Glaive Thrower
34929, 35410, -- Alliance Gunship Cannon
34935, 35427, -- Horde Gunship Cannon
34944, 35429, -- Keep Cannon
35069, 35433, -- Siege Engine
35273, 35421  -- Glaive Thrower
);

-- DB/Gameobject: Update gameobject templates naming.
UPDATE `gameobject_template` SET `name`='Spiked Ball' WHERE `entry`=232505;
UPDATE`gameobject_template` SET `name`='Gul\'dan Light Shaft' WHERE `entry`=237261;

-- DB/Scene: Add script to scene template missing from last commit.
UPDATE `scene_template` SET `ScriptName`='scene_battle_for_brokenshore_alliance' WHERE SceneId=1335;

-- DB/Misc: Add missing from last commit.
DELETE FROM `spell_area` WHERE `spell` IN(164609, 164611);
INSERT INTO `spell_area` (`spell`, `area`, `quest_start`, `quest_end`, `aura_spell`, `racemask`, `gender`, `flags`, `quest_start_status`, `quest_end_status`) VALUES 
(164609, 7025, 34422, 35297, 0, 0, 2, 3, 10, 1),
(164611, 7025, 34422, 35297, 0, 0, 2, 3, 8, 1);

UPDATE `scene_template` SET `ScriptName`='scene_bleeding_hollow_holdout' WHERE `SceneId`=770;
UPDATE `scene_template` SET `ScriptName`='scene_bleeding_hollow_trail_of_flame' WHERE `SceneId`=771;
UPDATE `quest_template_addon` SET `ScriptName`='quest_blade_of_glory' WHERE `Id`=34422;

-- DB/Creature: Karabor Peacekeeper
-- fix name for creature template 
UPDATE `creature_template` SET `name`='Karabor Peacekeeper' WHERE `entry`=81636;

-- DB/Phase: Add missing phase area data.
DELETE FROM `phase_area` WHERE `PhaseId`=7138;
INSERT INTO `phase_area` (`AreaId`, `PhaseId`, `Comment`) VALUES
(7502, 7138, 'See Emissary Auldbridge, welcoming in Broken Isles Dalaran');

-- DB/Creature: Fixed Valkyr Shadowguard immunities
-- Valkyr Shadowguard Imunity
UPDATE `creature_template` SET `mechanic_immune_mask` = 
1|          -- charm
2|          -- disorient
4|          -- disarm
8|          -- distract
16|         -- fear
32|         -- grip
64|         -- root
256|        -- silence
512|        -- sleep
4096|       -- freeze
8192|       -- knockout
65536|      -- polymorph
131072|     -- banish
524288|     -- shackle
1048576|    -- mount
4194304|    -- turn
8388608|    -- horror
33554432|   -- interrupt
536870912   -- sapped
WHERE `entry` IN (36609,39120,39121,39122);

-- DB/Creature: Fix Verifonix faction and reputation
-- Verifonix <The Surveyor>
UPDATE `creature_template` SET `faction`=47 WHERE `entry`=14492;

DELETE FROM `creature_onkill_reputation` WHERE `creature_id`=14492;
INSERT INTO `creature_onkill_reputation` (`creature_id`,`RewOnKillRepFaction1`,`RewOnKillRepFaction2`,`MaxStanding1`,`IsTeamAward1`,`RewOnKillRepValue1`,`MaxStanding2`,`IsTeamAward2`,`RewOnKillRepValue2`,`TeamDependent`) VALUES
(14492, 21, 0, 5, 0, 5, 0, 0, 0, 0);

-- DB/Quests: Missing completion text for Duskwood quests
-- 
DELETE FROM `quest_offer_reward` WHERE `ID` IN (25235, 26618, 26620, 26623, 26627, 26645, 26652, 26653, 26654, 26655, 26660, 26661, 26666, 26667, 26669, 26670, 26671, 26672, 26674, 26676, 26677, 26680, 26681, 26684, 26685, 26686, 26688, 26689, 26690, 26691, 26707, 26717, 26719, 26720, 26721, 26722, 26723, 26724, 26725, 26727, 26728, 26753, 26754, 26760, 26777, 26778, 26785, 26787, 26793, 26795, 26796, 26797, 28564);
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(25235, 0, 0, 0, 0, 0, 0, 0, 0, "I saw you drop a few of them from here. Nice work.$B$BHere's your reward, on behalf of the Night Watch.", 0),
(26618, 0, 0, 0, 0, 0, 0, 0, 0, "Don't go thinking that was too easy. Far greater dangers lurk deeper in the woods.", 0),
(26620, 0, 0, 0, 0, 0, 0, 0, 0, "Mmm-mmm! The skirtsteak's the best part. It's not an efficient way to cook, though.$B$BHere, have this recipe. It's a little different, but flank meat's easier to come by when you really need a meal.", 0),
(26623, 0, 0, 0, 0, 0, 0, 0, 0, "Ah yes, a nice lump you have there!  Let me just get this seasoned with my secret spices (no looking!) and get them to skittering on a skillet for a while...$B$BAnd, although Dusky Crab Cakes are my specialty and I won't give out the recipe, here's the recipe for a dish that's almost as good.", 0),
(26627, 0, 0, 0, 0, 0, 0, 0, 0, "Ah, welcome, stranger. I'd offer you something, but there's not much here...$B$BCould I beg you to run some errands for a poor old hermit?", 0),
(26645, 0, 0, 0, 0, 0, 0, 0, 0, "Splendid, $n.  For your service to the people of Darkshire you shall be rewarded.", 0),
(26652, 0, 0, 0, 0, 0, 0, 0, 0, "What is this?  A comb?  It's lovely!  And it glides through my hair as if it weren't the stiff, stringy horror that it is.$B$BOh, if only I had a mirror...", 0),
(26653, 0, 0, 0, 0, 0, 0, 0, 0, "Ah, ghost hair thread is what you need, is it?  I'm afraid I have none in stock, but I can make some for you...if you can supply the ghost hair.", 0),
(26654, 0, 0, 0, 0, 0, 0, 0, 0, "I can make a spool of ghost hair thread with this, and have a few strands to spare.  Here are some coins for those extra strands.", 0),
(26655, 0, 0, 0, 0, 0, 0, 0, 0, "Delightful!  This will do splendidly...$B$BHere, good $n, take this as payment for your honorable deed.", 0),
(26660, 0, 0, 0, 0, 0, 0, 0, 0, "You need some Zombie Juice, do you?  Hmm...that's some strong stuff - I don't usually get requests for it.", 0),
(26661, 0, 0, 0, 0, 0, 0, 0, 0, "Good,  you got the rot blossoms.$B$BI'll whip up the zombie juice... it's strong stuff, I warn you.", 0),
(26666, 0, 0, 0, 0, 0, 0, 0, 0, "Can I help you?", 0),
(26667, 0, 0, 0, 0, 0, 0, 0, 0, "By the Light... you actually went and got it?$B$BI'm shocked. I suppose I owe you thanks for returning it to the archives.", 0),
(26669, 0, 0, 0, 0, 0, 0, 0, 0, "This was all you found?$B$BThat's bad news, I'm afraid...", 0),
(26670, 0, 0, 0, 0, 0, 0, 0, 0, "You actually went and got it?!$B$BI don't know whether to call you brave or insane. But once again, my archives thank you.", 0),
(26671, 0, 0, 0, 0, 0, 0, 0, 0, "I can't thank you enough... I had hoped for this to be a joyous reunion, but the more I learn, the less glad I am to have asked.$B$BBut I must know.", 0),
(26672, 0, 0, 0, 0, 0, 0, 0, 0, "How interesting. It's been quite a while since I've seen such a ring...", 0),
(26674, 0, 0, 0, 0, 0, 0, 0, 0, "Master Harris may have been right. I would have been better to leave the past behind.$B$BI've got a new life now. Whether it's that of a monster or a man is up to me.$B$BAs for you, I cannot thank you enough for your assistance, regardless of the outcome. Please, take this with my thanks.", 0),
(26676, 0, 0, 0, 0, 0, 0, 0, 0, "A thousand thanks, $n.  You warm an old man's heart with your foolish-...I mean...with your kindness!$B$BHere you are, friend.  Take this as a token of my gratitude.", 0),
(26677, 0, 0, 0, 0, 0, 0, 0, 0, "Ah, thanks.  These will do just the trick!", 0),
(26680, 0, 0, 0, 0, 0, 0, 0, 0, "Thank the Nec-...well, thank YOU, $n!  You have more than earned your reward.$B$BAha!  Happy!  Happy nights ahead!!", 0),
(26681, 0, 0, 0, 0, 0, 0, 0, 0, "<Ello looks at the letter, and immediately pales.>$B$BYou fool! You've doomed us all!", 0),
(26684, 0, 0, 0, 0, 0, 0, 0, 0, "Most superb!  This will work perfectly.  Many thanks!", 0),
(26685, 0, 0, 0, 0, 0, 0, 0, 0, "At last!  The stargazing device is complete!  Thank you, $n.  Now I can continue my research. . .", 0),
(26686, 0, 0, 0, 0, 0, 0, 0, 0, "The people of Darkshire thank you, $n.  You have proven yourself to be a great ally of The Night Watch.", 0),
(26688, 0, 0, 0, 0, 0, 0, 0, 0, "Impressive, $n. It would seem that you are capable enough to handle yourself. Perhaps a more suitable challenge could be found for one of your abilities.", 0),
(26689, 0, 0, 0, 0, 0, 0, 0, 0, "You performed well against the Shadow Weavers, $n. But even now, years after their first arrival, there seem to be so many to replace the ones we kill.$B$BI will put my faith in Master Carevin. No doubt he will get to the bottom of the problem.", 0),
(26690, 0, 0, 0, 0, 0, 0, 0, 0, "$n, to be honest with you, I did not believe that you would get this far, but you are clearly a $c to be reckoned with. In fact, if you wish to formally join Master Carevin's struggle, I will gladly write for you a letter of recommendation.", 0),
(26691, 0, 0, 0, 0, 0, 0, 0, 0, "Here you go, $n. Bring this message to Master Carevin.$B$B<He quickly removes a piece of faded parchment and offers it to you.>$B$BA few more like you, and we will outnumber the Night Watch! Perhaps then we could complete the work that we few carry on today.", 0),
(26707, 0, 0, 0, 0, 0, 0, 0, 0, "I thank you, $c... and I'm sure the worgen that may be returned to sanity with the potion this will make would thank you too.", 0),
(26717, 0, 0, 0, 0, 0, 0, 0, 0, "Sounds like a close call! But he ran off without harming you further...$B$BHe might be still fighting it. Master Harris must know!", 0),
(26719, 0, 0, 0, 0, 0, 0, 0, 0, "Welcome to our humble camp. I wouldn't call it pleasant, but it's at least somewhat private.$B$BBeg your pardon? A worgen at the farm?", 0),
(26720, 0, 0, 0, 0, 0, 0, 0, 0, "You've got him!$B$BNo time to lose, then. We'll prepare to administer the serum right away.$B$BJITTERS! Get ready!", 0),
(26721, 0, 0, 0, 0, 0, 0, 0, 0, "Oh thank you, thank you! You've saved me from having to go out in the woods with those awful things!$B$BAt least for a day, that is...", 0),
(26722, 0, 0, 0, 0, 0, 0, 0, 0, "<In the darkest depths of this earthen tunnel, you spy the faintest gleam. The last piece is found!>", 0),
(26723, 0, 0, 0, 0, 0, 0, 0, 0, "His clothes and bloodstains? If it's not tricks, it's something worse...", 0),
(26724, 0, 0, 0, 0, 0, 0, 0, 0, "It's heartening to see one so recently recovered be so concerned with the plight of others. Sven spares himself suffering by not dwelling on his own misfortune.", 0),
(26725, 0, 0, 0, 0, 0, 0, 0, 0, "<Buried in the cold dirt, you find a brilliant metal shaft. But there are holes where pieces of the artifact are clearly missing.>", 0),
(26727, 0, 0, 0, 0, 0, 0, 0, 0, "Thank the Light, he's gone...$B$BI'll say you've made amends by helping save the lives of those here, $n.", 0),
(26728, 0, 0, 0, 0, 0, 0, 0, 0, "You are the help that we requested?$B$B<Althea sighs.>$B$BI suppose you will have to do.", 0),
(26753, 0, 0, 0, 0, 0, 0, 0, 0, "<In the dirt of this alcove, your eye catches the shine of brilliant metal. You've found another piece of the artifact!>", 0),
(26754, 0, 0, 0, 0, 0, 0, 0, 0, "May the disgusting monster stay dead this time!$B$BI'll head down there and scatter his remains to ash myself, $n. You've done a great thing; perhaps in time Duskwood can return to its former peaceful state.", 0),
(26760, 0, 0, 0, 0, 0, 0, 0, 0, "Success... Finally! I can't thank you enough for giving me the chance to work the cure myself.$B$BOur new friend may be in need of some help as well. You might want to speak with him.", 0),
(26777, 0, 0, 0, 0, 0, 0, 0, 0, "You have brought peace to those who knew only misery, $n. Be proud.", 0),
(26778, 0, 0, 0, 0, 0, 0, 0, 0, "The cries grow softer for now. Light bless you, $n. ", 0),
(26785, 0, 0, 0, 0, 0, 0, 0, 0, "Tobias is staying in town still?$B$BMaster Harris warned him not to pursue his brother's fate. We all lead new lives now, after all. But the past is hard to let go of...", 0),
(26787, 0, 0, 0, 0, 0, 0, 0, 0, "Thank you! Oh, thank you. I never thought I'd be happy to smell those brains, but I am now that I didn't have to get them!$B$BHere's your reward as promised...", 0),
(26793, 0, 0, 0, 0, 0, 0, 0, 0, "Morgan Ladimore?$B$BAhh, yes, of course. His was a long and sorrowful tale. I knew him, well, before he left for the war, but that was the last time I saw him. A noble and good man, he was, but he suffered a bad end.$B$BHere, I should have something here that can tell the tale better than my own recollections...", 0),
(26795, 0, 0, 0, 0, 0, 0, 0, 0, "You killed him? That's no small accomplishment, $n! On behalf of the people of Darkshire and the Night Watch, I thank you.$B$BAh... there is one small matter, however...", 0),
(26796, 0, 0, 0, 0, 0, 0, 0, 0, "Yes? My father...$B$B<Her eyes become downcast.>$B$BI wish... there was something I could have done for him... If only I had talked to him before he...", 0),
(26797, 0, 0, 0, 0, 0, 0, 0, 0, "<A ghostly voice sounds on the wind...>$B$BThis is...? Sarah? Could it be she's still alive? The weight is removed from my shoulders...$B$B$n. Take my sword, Archeus. As my soul is put to rest, I have no more need for it. It was forged to do good, and though I have proved myself unworthy to hold it, perhaps you will carry on the Light through it.$B$BLys, my love...", 0),
(28564, 0, 0, 0, 0, 0, 0, 0, 0, "You are the help that we requested?$B$B<Althea sighs.>$B$BI suppose you will have to do.", 0);

-- DB/Creature: Add creature text for archmage khadgar raven form.
DELETE FROM `creature_text` WHERE `CreatureID`=103660;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(103660, 0, 0, 'I prefer using the greatstaff Atiesh\'s raven form. Nothing\'s worse than saddle sores.', 12, 0, 100, 0, 0, 58376, 0, 0, 'Archmage Khadgar to Player'),
(103660, 1, 1, 'The demon hunters have set up camp on the far side of the island. Perhaps they can help us locate the Pillar of Creation.', 12, 0, 100, 0, 0, 58375, 0, 0, 'Archmage Khadgar to Player'),
(103660, 2, 2, 'Look there... naga forces. We have competition from Queen Azshara herself!', 12, 0, 100, 0, 0, 58374, 0, 0, 'Archmage Khadgar to Player'),
(103660, 3, 3, 'She must also be after the Pillar of Creation. This is unexpected.', 12, 0, 100, 0, 0, 58373, 0, 0, 'Archmage Khadgar to Player'),
(103660, 4, 4, 'Breathtaking. Imagine all of the arcane knowledge lost to the ages here.', 12, 0, 100, 0, 0, 60191, 0, 0, 'Archmage Khadgar to Player'),
(103660, 5, 5, 'There... the Illidari. And, the Burning Legion is here, too.', 12, 0, 100, 0, 0, 60192, 0, 0, 'Archmage Khadgar to Player');

-- DB/Phase: Handle a lot of phase for quest 34393
DELETE FROM `phase_area` WHERE `AreaId` IN (7025, 7037) AND `PhaseId`IN (3248, 3249, 3250, 3251);
INSERT INTO `phase_area` (`AreaId`, `PhaseId`, `Comment`) VALUES
(7037, 3248, 'Ganahma\'s Barb under the Dark Portal (Assault on the Dark Portal)'),
(7037, 3249, 'Rune of the Felbreakers under the Dark Portal (Assault on the Dark Portal)'),
(7037, 3250, 'Horn of Kairozdormu under the Dark Portal (Assault on the Dark Portal)'),
(7037, 3251, 'Gul\'Dan under the Dark Portal (Assault on the Dark Portal)');

-- Conditions
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId`=26 AND `SourceGroup` = 3248 AND `SourceEntry` = 7037);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES
(26, 3248, 7037, 0, 0, 47, 0, 34393, 2 | 64, 0, 1, 'Apply Phase 3248 if Quest 34393 is not complete | rewarded'),
(26, 3248, 7037, 0, 0, 48, 0, 273438, 0, 0, 1, 'Apply Phase 3248 if QuestObjective 273438 is not complete');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId`=26 AND `SourceGroup` = 3249 AND `SourceEntry` = 7037);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES
(26, 3249, 7037, 0, 0, 47, 0, 34393, 2 | 64, 0, 1, 'Apply Phase 3248 if Quest 34393 is not complete | rewarded'),
(26, 3249, 7037, 0, 0, 48, 0, 273556, 0, 0, 1, 'Apply Phase 3249 if QuestObjective 273556 is not complete');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId`=26 AND `SourceGroup` = 3250 AND `SourceEntry` = 7037);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES
(26, 3250, 7037, 0, 0, 47, 0, 34393, 2 | 64, 0, 1, 'Apply Phase 3250 if Quest 34393 is not complete | rewarded'),
(26, 3250, 7037, 0, 0, 48, 0, 273557, 0, 0, 1, 'Apply Phase 3250 if QuestObjective 273557 is not complete');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId`=26 AND `SourceGroup` = 3251 AND `SourceEntry` = 7037);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES
(26, 3251, 7037, 0, 0, 47, 0, 34393, 2 | 64, 0, 1, 'Apply Phase 3251 if Quest 34393 is not complete | rewarded');

-- DB/Misc: fix *unix system load hotfixes db
/*Table structure for table `questv2clitask` */

DROP TABLE IF EXISTS `questv2clitask`;

CREATE TABLE `QuestV2CliTask` (
  `Unk1` INT(10) NOT NULL,
  `Name` VARCHAR(255) DEFAULT NULL,
  `Description` VARCHAR(4098) DEFAULT NULL,
  `Unk2` INT(10) NOT NULL,
  `Unk3` SMALLINT(8) UNSIGNED NOT NULL,
  `Unk4` SMALLINT(10) UNSIGNED NOT NULL,
  `Unk5` SMALLINT(10) UNSIGNED NOT NULL,
  `QuestID0` SMALLINT(10) UNSIGNED NOT NULL,
  `QuestID1` SMALLINT(10) UNSIGNED NOT NULL,
  `QuestID2` SMALLINT(10) UNSIGNED NOT NULL,
  `Unk6` SMALLINT(10) UNSIGNED NOT NULL,
  `Unk7` SMALLINT(10) UNSIGNED NOT NULL,
  `Unk8` SMALLINT(10) UNSIGNED NOT NULL,
  `Unk9` SMALLINT(10) UNSIGNED NOT NULL,
  `Unk10` TINYINT(10) UNSIGNED NOT NULL,
  `Unk11` TINYINT(10) UNSIGNED NOT NULL,
  `Unk12` TINYINT(10) UNSIGNED NOT NULL,
  `Unk13` TINYINT(10) UNSIGNED NOT NULL,
  `Unk14` TINYINT(10) UNSIGNED NOT NULL,
  `Unk15` TINYINT(10) UNSIGNED NOT NULL,
  `Unk16` TINYINT(10) UNSIGNED NOT NULL,
  `RequiredLevel` TINYINT(10) UNSIGNED NOT NULL,
  `Unk18` TINYINT(10) UNSIGNED NOT NULL,
  `ID` INT(10) UNSIGNED NOT NULL,
  `Unk19` INT(10) NOT NULL,
  `QuestInfoID` INT(10) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=INNODB DEFAULT CHARSET=latin1;

/*Data for the table `questv2clitask` */

-- DB/Loot: Formula Enchant Weapon - Superior Striking
-- Formula: Enchant Weapon - Superior Striking
DELETE FROM `creature_loot_template` WHERE `item` = 16250;
INSERT INTO `creature_loot_template` (`Entry`,`Item`,`Chance`,`GroupId`,`MinCount`,`MaxCount`,`Reference`) VALUES 
-- Bosses
(10363, 16250, 2, 0, 1, 1, 0),
(10220, 16250, 2, 0, 1, 1, 0),
(9816, 16250, 2, 0, 1, 1, 0),
(10899, 16250, 2, 0, 1, 1, 0),
(10430, 16250, 2, 0, 1, 1, 0),
(9196, 16250, 2, 0, 1, 1, 0),
(9236, 16250, 2, 0, 1, 1, 0),
(9219, 16250, 2, 0, 1, 1, 0),
(10376, 16250, 2, 0, 1, 1, 0),
(9736, 16250, 2, 0, 1, 1, 0),
(9568, 16250, 2, 0, 1, 1, 0),
(9237, 16250, 2, 0, 1, 1, 0),
(9596, 16250, 2, 0, 1, 1, 0),
(10509, 16250, 2, 0, 1, 1, 0),
(9718, 16250, 2, 0, 1, 1, 0),
(10596, 16250, 2, 0, 1, 1, 0),
-- Trash
(10371, 16250, 1, 0, 1, 1, 0),
(10318, 16250, 1, 0, 1, 1, 0),
(10317, 16250, 1, 0, 1, 1, 0),
(10083, 16250, 1, 0, 1, 1, 0),
(9817, 16250, 1, 0, 1, 1, 0),
(9692, 16250, 1, 0, 1, 1, 0),
(9717, 16250, 1, 0, 1, 1, 0),
(9693, 16250, 1, 0, 1, 1, 0),
(9716, 16250, 7, 0, 1, 1, 0),
(9583, 16250, 1, 0, 1, 1, 0),
(10374, 16250, 1, 0, 1, 1, 0),
(9263, 16250, 1, 0, 1, 1, 0),
(9264, 16250, 1, 0, 1, 1, 0),
(9260, 16250, 1, 0, 1, 1, 0),
(9262, 16250, 1, 0, 1, 1, 0),
(9261, 16250, 1, 0, 1, 1, 0),
(9266, 16250, 1, 0, 1, 1, 0),
(9268, 16250, 1, 0, 1, 1, 0),
(9241, 16250, 1, 0, 1, 1, 0),
(9265, 16250, 1, 0, 1, 1, 0),
(9269, 16250, 1, 0, 1, 1, 0),
(9239, 16250, 1, 0, 1, 1, 0),
(9267, 16250, 1, 0, 1, 1, 0),
(9217, 16250, 1, 0, 1, 1, 0),
(9197, 16250, 1, 0, 1, 1, 0),
(9216, 16250, 1, 0, 1, 1, 0),
(9198, 16250, 1, 0, 1, 1, 0),
(9200, 16250, 1, 0, 1, 1, 0),
(9199, 16250, 1, 0, 1, 1, 0),
(9258, 16250, 1, 0, 1, 1, 0),
(9045, 16250, 1, 0, 1, 1, 0),
(9098, 16250, 1, 0, 1, 1, 0),
(9257, 16250, 1, 0, 1, 1, 0),
(9097, 16250, 1, 0, 1, 1, 0),
(10319, 16250, 1, 0, 1, 1, 0),
(10366, 16250, 1, 0, 1, 1, 0),
(10762, 16250, 1, 0, 1, 1, 0),
(10372, 16250, 1, 0, 1, 1, 0),
(9096, 16250, 1, 0, 1, 1, 0),
(9819, 16250, 1, 0, 1, 1, 0),
(9818, 16250, 1, 0, 1, 1, 0),
(9240, 16250, 1, 0, 1, 1, 0);

-- DB/Creature: Add missing text for Gul'dan
DELETE FROM `creature_text` WHERE `CreatureID`=78333;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(78333, 0, 0, 'Sever my bonds... and the portal falls...', 12, 0, 100, 0, 0, 45331, 0, 0, 'Gul\'dan to Player'),
(78333, 1, 0, 'Yes... Yes!', 12, 0, 100, 0, 0, 45332, 0, 0, 'Gul\'dan to Player'),
(78333, 2, 0, 'Grommash will pay for his arrogance.', 12, 0, 100, 0, 0, 45334, 0, 0, 'Gul\'dan to Player'),
(78333, 3, 0, 'The bonds weaken. Freedom will be mine!', 12, 0, 100, 0, 0, 45333, 0, 0, 'Gul\'dan to Player');


-- DB/Gossip: Add broadcast gossip text for Argent Gruntling/Argent Squire
-- 
-- Argent Tournament Champion's Pennant gossip option texts
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID`=35513 WHERE `MenuId`=10317 AND `OptionIndex`=0;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID`=35515 WHERE `MenuId`=10317 AND `OptionIndex`=1;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID`=35534 WHERE `MenuId`=10317 AND `OptionIndex`=2;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID`=33681, `OptionText`="Darkspear Champion's Pennant" WHERE `MenuId`=10317 AND `OptionIndex`=3;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID`=33682, `OptionText`="Forsaken Champion's Pennant" WHERE `MenuId`=10317 AND `OptionIndex`=4;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID`=33683 WHERE `MenuId`=10317 AND `OptionIndex`=5;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID`=33685 WHERE `MenuId`=10317 AND `OptionIndex`=6;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID`=33686 WHERE `MenuId`=10317 AND `OptionIndex`=7;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID`=35513 WHERE `MenuId`=10318 AND `OptionIndex`=0;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID`=35515 WHERE `MenuId`=10318 AND `OptionIndex`=1;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID`=35534 WHERE `MenuId`=10318 AND `OptionIndex`=2;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID`=33675 WHERE `MenuId`=10318 AND `OptionIndex`=3;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID`=33676 WHERE `MenuId`=10318 AND `OptionIndex`=4;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID`=33678 WHERE `MenuId`=10318 AND `OptionIndex`=5;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID`=33679 WHERE `MenuId`=10318 AND `OptionIndex`=6;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextID`=33401 WHERE `MenuId`=10318 AND `OptionIndex`=7;

-- DB/Release: ACLDB 735.02
/*
AshamaneCoreLegacy-legion rev. 2e92d50 2020-03-22 (legion branch)
*/

DELETE FROM `playercreateinfo_cast_spell` WHERE `raceMask` IN (134217728, 536870912, 268435456, 67108864);
INSERT INTO playercreateinfo_cast_spell (raceMask, classMask, spell, note) VALUES
(134217728, 4, 259084, 'Highmountain Tauren - Hunter - Great Eagle'),
(536870912, 4, 259085, 'Lightforged Draenei - Hunter - Lightforged Talbuk'),
(268435456, 4, 259086, 'Void Elf - Hunter - Shadowstalker'),
(67108864, 4, 259087, 'Nightborne - Hunter - Blue Mana Saber');

-- ACLDB 735.01 world
UPDATE `updates` SET `state`='ARCHIVED',`speed`=0;
UPDATE `version` SET `db_version`='ACLDB 735.02', `cache_id`=7 LIMIT 1;

-- DB/Creature: Fix Guardian of Icecrown creature_text typo
--
UPDATE `creature_text` SET `Text`= "%s flees after seeing Kel'Thuzad fall!" WHERE `CreatureID`= 16441 AND `GroupID`= 0;

-- DB/Creature: Pyroguard Emberseer
-- 
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1`=20 WHERE  `creature_id`=9816;

-- DB/Misc: Fix few startup errors
--
UPDATE `creature_template` SET `minlevel` = 1, `maxlevel` = 1 WHERE (`minlevel` =0 AND `maxlevel` = 0);
UPDATE `creature_template` SET `faction`=35 WHERE `entry` IN (125542,125261,124590,123252,122800,122799,104208,128217,128203,127466,127464,126638,125956,125880,125265,124997,124975,124264,123061,123025,121059,120876,120536,119868,119396,128626,128288,128195,127997,127722,127505,127465,127451,127445,127122,126944,126577,126408,126249,126194,125517,125350,125258,125102,124569,124485,124313,123260,123139,122509,121545,119436,128151,127845,127450,127429,127410,126951,126390,126082,126043,125780,125523,125520,125407,124998,124987,124076,124070,123629,123594,122768,122219,121645,121263,121179,121175,120875,120596,118830,129674,127996,127994,127946,127461,127146,127137,127008,126211,126075,126022,125409,125104,125099,125062,123698,123395,121423,120573,128722,128634,128242,127802,127640,127411,127135,127058,126442,126425,126368,125926,125912,125525,125522,125519,125259,125002,124276,123560,122945,119438,104230,127448,127037,126389,125872,125843,125270,125256,124558,124266,122769,121014,120894,120877,119870,127467,127083,127023,126680,126459,126312,126195,125911,125737,125260,124734,123699,123187,121676,121578,120533,119437,128191,127459,127409,125524,125521,125518,125461,125410,124999,124595,124398,123767,123746,123745,123744,123497,123390,123258,123051,122770,121644,120845,120693,131971,131963,131957,131953,131952,131950,131947,131946,131943,131942,131941,131940,131933,131928,131927,131923,131915,131914,131909,131908,131907,131906,131903,131895,131893,131892,131889,131888,131839,131838,131837,131779,131776,131773,131479,131478,131429,131428,131427,131426,131423,131422,131419,131418,131417,131401,131371,131347,131345,131334,131309,131308,131203,131201,131149,131076,131074,131072,131069,131032,130986,130982,130943,130937,130935,130931,130926,130925,130924,130923,130919,130907,130906,130894,130893,130892,130891,130890,130888,130886,130885,130884,130883,130882,130881,130877,130862,130861,130860,130859,130858,130857,130856,130855,130854,130853,130852,130851,130828,130810,130773,130758,130726,130682,130677,130676,130675,130654,130598,130560,130559,130558,130549,130547,130542,130540,130537,130535,130532,130511,130426,130425,130423,130418,130384,130383,130382,130381,130275,130274,130273,130272,130245,130243,130241,130216,130215,130213,130201,130200,130193,130183,130178,130151,130145,130142,130139,130135,130134,130133,130129,130128,130080,130076,130063,130049,130033,130032,130030,129963,129955,129930,129917,129915,129914,129912,129862,129792,129789,129770,129767,129659,129644,129629,129468,129428,129422,129356,129344,129268,129263,129251,129250,129248,129247,129244,129141,129049,129026,129024,129023,129022,128980,128970,128939,128915,128877,128836,128818,128816,128815,128814,128813,128812,128767,128713,128657,128656,128655,128622,128612,128566,128563,128562,128561,128560,128558,128550,128488,128487,128486,128485,128484,128483,128482,128481,128427,128425,128424,128423,128416,128415,128412,128411,128133,128131,128130,128125,128120,128115,128099,128081,128038,128036,128032,128030,128028,127983,127964,127924,127923,127827,127785,127619,127555,127521,127520,127295,127071,127070,127018,126972,126964,126799,126789,126788,126646,126639,126630,126604,126602,126589,126559,126538,126537,126536,126493,126492,126491,126489,126470,126370,126365,126364,126354,126344,126327,126315,126306,126305,126302,126231,126134,126081,126078,126077,126076,126068,126067,126066,126065,126062,126012,126011,126001,126000,125999,125998,125997,125951,125949,125832,125829,125826,125825,125778,125470,125466,125463,125459,125456,125454,125397,125356,125287,125285,125269,125253,125193,125192,125181,125180,125141,125136,124267,124252,103976);
UPDATE `creature_template` SET `faction`=7 WHERE `entry` IN (126352,125589,125582,125283,125255,125249,125191,125120,125119,125089,125077,125074,125040,125018,125017,125016,125007,125000,124986,124973,124969,124944,124943,124923,124891,124869,124867,124866,124865,124864,124863,124858,124815,124766,124764,124763,124762,124740,124739,124698,124692,124646,124644,124604,124603,124594,124589,124543,124542,124533,124508,124507,124505,124472,124457,124431,124389,124385,124379,124337,124285,124284,124283,124280,124263,124260,124257,124251,124248,124246,124245,124243,124237,124236,124235,124234,124233,124231,124222,124221,124220,124219,124215,124205,124204,124203,124202,124201,124200,124199,124198,124197,124196,124193,124192,124154,124153,124151,124149,124148,124147,124146,124145,124144,124143,124142,124141,124140,124139,124138,124136,124135,124134,124133,124132,124131,124130,124129,124128,124127,124126,124125,124124,124123,124122,124121,124120,124119,124118,124117,124116,124115,124114,124113,124104,124103,124102,124101,124100,124099,124097,124096,124095,124094,124092,124090,124089,124082,124081,124080,124074,124073,124072,124071,124065,124064,124061,124060,124059,124058,124057,124056,124054,124053,124052,124050,124049,124048,124047,124038,124023,124017,124014,124013,124012,124011,124010,124009,124008,124007,124006,124005,124004,124003,124002,124001,124000,123999,123998,123997,123996,123994,123993,123992,123991,123990,123989,123988,123987,123986,123985,123984,123983,123982,123981,123980,123979,123978,123977,123976,123975,123974,123973,123972,123971,123970,123969,123968,123967,123966,123965,123963,123962,123961,123960,123959,123958,123957,123956,123955,123954,123953,123952,123951,123950,123949,123948,123947,123946,123944,123943,123942,123941,123940,123939,123938,123936,123935,123934,123933,123932,123931,123930,123928,123927,123926,123925,123924,123923,123922,123920,123919,123918,123916,123915,123914,123913,123912,123911,123910,123909,123908,123907,123905,123904,123903,123902,123900,123899,123898,123897,123896,123895,123894,123892,123891,123872,123843,123839,123838,123837,123836,123804,123803,123802,123801,123800,123789,123788,123787,123786,123785,123783,123782,123781,123780,123779,123778,123777,123755,123735,123722,123721,123696,123694,123693,123691,123682,123662,123660,123636,123628,123618,123602,123568,123566,123563,123562,123557,123551,123540,123495,123494,123493,123492,123490,123458,123419,123412,123406,123403,123397,123396,123394,123393,123392,123329,123324,123256,123255,123227,123184,123134,123131,123125,123124,123122,123120,123112,123108,123107,123106,123105,123104,123101,123099,123097,123092,123091,123087,123082,123077,123075,123073,123042,123029,123023,123021,123014,123009,122998,122997,122996,122995,122990,122983,122982,122981,122980,122978,122964,122954,122943,122929,122899,122898,122896,122894,122893,122875,122874,122871,122859,122856,122853,122816,122786,122712,122682,122680,122668,122663,122660,122629,122612,122609,122603,122597,122580,122553,122552,122551,122550,122549,122548,122547,122546,122545,122544,122542,122541,122540,122539,122537,122528,122527,122526,122525,122524,122522,122521,122520,122519,122518,122517,122516,122515,122514,122513,122512,122511,122510,122508,122506,122505,122396,122390,122352,122351,122349,122346,122345,122344,122340,122339,122323,122290,122282,122281,122280,122279,122277,122270,122269,122258,122257,122256,122254,122253,122252,122250,122248,122243,122241,122234,122183,122139,122138,122134,122124,122096,122070,122069,122068,122053,122051,122050,122049,122048,122033,122008,121998,121977,121969,121967,121946,121913,121912,121911,121874,121870,121865,121821,121820,121818,121740,121739,121731,121730,121727,121725,121724,121694,121561,121543,121542,121537,121535,121529,121528,121527,121326,121325,121307,121293,121245,121244,121243,121139,121038,121008,120974,120971,120729,120728,120525,120524,120523,120519,120518,120517,120508,120489,120488,120487,120486,120484,120483,120479,120472,120470,120467,120462,120433,120432,120429,120411,120410,120391,120356,120308,120307,120305,120287,120248,120247,120203,120202,120175,120142,120111,119996,119951,119932,119931,119929,119927,119926,119896,119895,119894,119893,119892,119891,119890,119889,119888,119885,119794,119760,119756,119754,119744,119743,119601,119521,119448,119444,119419,119414,119409,119408,119407,119399,119390,119346,119345,119344,119343,119342,119341,116477,116460,104180,104177,104099,104090,104071,130202,130185,130179,130137,129635,129225,129210,129051,128364,128320,128318,128312,128304,128222,128207,128160,128142,128089,128069,128060,128058,128055,128011,127990,127971,127950,127948,127943,127892,127885,127871,127861,127843,127670,127608,127525,127510,127500,127471,127404,127399,127389,127373,127345,127337,127327,127324,127322,127300,127287,127256,127233,127183,127178,126986,126978,126954,126911,126895,126812,126791,126767,126741,126556,126495,125965,125954,125937,125902,125897,125896,125895,125851,125818,125638,125615,125514,125497,125476,125473,125435,125429,125426,125422,125406,125379,125339,125321,125313,125254,125237,125227,125225,125128,125125,125115,125048,125029,125026,125014,125008,125003,124966,124959,124934,124913,124903,124879,124871,124606,124600,124592,124568,124386,124340,124330,124314,124270,124227,124175,124165,123705,123616,123261,123241,123148,123085,123070,123048,123036,122953,122831,122657,122653,122644,122640,122634,122477,121864,121787,121654,121591,121558,121524,121515,121503,120977,120882,120844,120834,120782,120601,120529,120393,120222,119761,119755,119750,119555,119550,119464,119440,119432,119358,119355,119336,119333,119331,119322,119312,119297,130065,130000,129449,129115,129063,128790,128782,128777,128756,128752,128740,128725,128624,128589,128465,128366,128236,128226,128204,128169,128141,128111,128105,128098,128095,128064,128056,128004,127987,127896,127859,127787,127773,127732,127705,127692,127681,127658,127617,127533,127507,127472,127468,127456,127430,127397,127366,127342,127341,127340,127336,127311,127304,127285,127269,127264,127244,127230,127214,127190,127185,127180,127133,127108,127098,127086,126987,126950,126947,126946,126945,126914,126910,126898,126887,126875,126866,126844,126842,126818,126785,126766,126764,126743,126686,126648,126624,126572,126555,126501,126444,126400,126393,126388,126267,126186,126163,126156,126152,126137,126123,126110,126059,126010,125983,125969,125966,125939,125934,125913,125908,125892,125885,125873,125866,125850,125847,125837,125821,125720,125682,125655,125620,125604,125586,125584,125569,125537,125490,125450,125444,125438,125431,125424,125421,125388,125364,125324,125319,125238,125228,125220,125210,125149,125137,125083,125078,125050,125010,124995,124964,124848,124799,124775,124702,124660,124602,124597,124573,124551,124511,124502,124481,124477,124463,124454,124433,124421,124411,124373,124361,124343,124342,124288,124244,124164,124160,124086,123964,123702,123598,123569,123543,123529,123501,123459,123451,123435,123416,123411,123404,123398,123360,123307,123223,123147,123111,123094,123065,123047,123030,123020,123003,122994,122951,122944,122937,122895,122827,122818,122811,122659,122655,122652,122643,122581,122533,122502,122469,122342,122302,122272,122212,122202,122190,122177,122098,122092,122065,122046,122045,122038,122017,121960,121756,121555,121549,121517,121501,121398,121319,121280,121161,121033,121001,120978,120973,120954,120936,120925,120914,120881,120841,120703,120656,120232,120230,119751,119561,119556,119549,119410,119394,119339,119320,119315,118832,104201,104014,130240,130192,130184,129876,129824,129819,129722,129209,129109,128882,128781,128776,128720,128463,128431,128399,128396,128341,128314,128310,128301,128157,128153,128109,128091,128063,128046,128035,128023,128018,127986,127952,127947,127934,127889,127883,127875,127862,127852,127791,127777,127723,127704,127694,127659,127611,127601,127595,127568,127536,127511,127501,127470,127463,127460,127455,127442,127400,127360,127331,127325,127323,127309,127305,127281,127261,127240,127228,127191,127181,127136,127045,127035,127011,126989,126915,126874,126853,126827,126813,126700,126691,126669,126647,126619,126595,126573,126565,126558,126527,126416,126404,126397,126349,126307,126268,126259,126251,126241,126230,126127,126121,126096,126084,126050,126040,126016,125963,125933,125919,125917,125910,125906,125901,125899,125884,125870,125856,125844,125819,125814,125790,125776,125760,125757,125717,125691,125634,125606,125585,125578,125565,125487,125480,125478,125474,125472,125441,125433,125361,125348,125345,125322,125315,125272,125257,125236,125226,125217,125197,125158,125148,125113,125079,125051,125036,125012,124962,124912,124884,124872,124828,124778,124759,124721,124719,124696,124686,124669,124634,124605,124577,124571,124555,124540,124515,124453,124445,124437,124427,124394,124359,124339,124298,124277,124176,124168,124163,124158,123906,123873,123706,123680,123533,123503,123460,123433,123332,123257,123225,123089,123072,123066,123050,123016,122957,122884,122813,122789,122761,122740,122730,122720,122716,122656,122654,122645,122635,122588,122578,122559,122558,122534,122507,122468,122462,122440,122362,122283,122273,122199,122189,122185,122172,122164,122156,122133,122104,122084,121985,121786,121758,121751,121659,121609,121593,121557,121551,121500,121347,121162,121157,121153,121114,121041,120953,120917,120916,120913,120880,120874,120831,120813,120783,120704,120694,120655,120643,120638,120633,120218,119766,119757,119557,119551,119543,119392,119384,119380,119332,119310,118844,104070,130842,129871,129825,129822,128466,128391,128367,128357,128156,128154,128119,128110,128102,128092,128061,128052,128000,127998,127956,127951,127942,127938,127912,127898,127890,127868,127863,127853,127850,127804,127786,127775,127763,127759,127750,127730,127703,127612,127599,127581,127452,127446,127408,127403,127401,127257,127239,127184,127182,127130,126940,126923,126917,126899,126843,126830,126784,126765,126752,126750,126716,126699,126591,126584,126566,126498,126417,126401,126394,126366,126363,126333,126279,126166,126143,126131,126124,126119,126007,125970,125759,125758,125756,125745,125723,125689,125667,125646,125621,125570,125482,125471,125462,125371,125359,125338,125194,125182,125145,125080,125073,125049,125030,125027,125009,124952,124873,124474,124419,124395,124207,124166,124150,124027,124025,124018,123929,123769,123687,123615,123599,123589,123478,123457,123432,123405,123401,123349,123344,123013,122927,122852,122647,122637,122628,122621,122587,122575,122555,122536,122494,121772,121755,121658,121612,121590,121533,121465,121349,121308,121266,121264,121248,121246,121229,121168,121160,120980,120764,120760,120723,120702,120657,120648,120644,119563,119433,104110,104016,130843,130239,130210,129897,129872,129823,129818,129386,129255,129114,128949,128783,128778,128735,128429,128342,128319,128313,128205,128159,128117,128101,128088,128059,128057,128047,127963,127953,127949,127930,127911,127895,127894,127886,127878,127856,127809,127760,127753,127741,127717,127671,127654,127610,127577,127561,127535,127532,127531,127529,127508,127502,127344,127338,127330,127310,127306,127286,127260,127241,127231,127213,127197,127192,127186,127179,127155,127085,127069,127064,127044,127039,127028,126982,126981,126980,126961,126896,126889,126878,126870,126868,126867,126863,126826,126769,126678,126670,126666,126657,126609,126599,126435,126418,126398,126392,126382,126362,126275,126274,126266,126247,126224,126212,126188,126172,126149,126140,126088,126058,125982,125968,125964,125958,125930,125907,125900,125894,125886,125874,125865,125863,125845,125835,125817,125788,125718,125679,125666,125607,125587,125576,125562,125547,125513,125484,125447,125442,125440,125430,125428,125362,125358,125353,125325,125298,125264,125239,125235,125224,125216,125201,125147,125055,125033,125013,125006,124994,124971,124931,124928,124910,124905,124880,124809,124804,124777,124760,124689,124685,124680,124585,124575,124570,124550,124544,124538,124512,124503,124498,124492,124370,124346,124338,124230,124174,124167,124077,124032,123851,123597,123570,123531,123513,123480,123467,123424,123371,123359,123346,123343,123263,123247,123232,123186,123149,123086,123069,123054,122992,122977,122966,122938,122891,122889,122885,122810,122805,122778,122733,122651,122585,122543,122532,122503,122450,122378,122367,122341,122023,122006,121962,121778,121775,121761,121754,121708,121660,121617,121597,121556,121539,121532,121518,121402,121348,121331,121297,121267,121262,121254,121159,121126,120983,120981,120873,120785,120738,120736,120732,120637,120608,120544,120224,119758,119558,119552,119546,119502,119465,119359,119353,119337,119334,119321,119317,129713,129706,129651,129617,129429,129116,128784,128779,128775,128759,128754,128751,128719,128627,128464,128360,128317,128311,128303,128293,128219,128218,128206,128201,128165,128158,128137,128118,128108,128100,128097,128094,127897,127882,127872,127866,127857,127725,127706,127462,127457,127454,127356,127353,127335,127326,127320,127312,127307,127303,127238,127221,127131,127117,127107,127102,126873,126871,126862,126854,126828,126825,126608,126598,126535,126436,126426,126414,126409,126402,126395,126372,126371,126339,126265,126257,126239,126162,126145,126130,126128,126125,126118,126097,126025,126015,125905,125893,125883,125785,125779,125771,125612,125603,125549,125293,125274,125262,125252,125204,125199,125189,125184,125118,125081,125075,125052,124840,124835,124785,124776,124693,124682,124676,124633,124617,124607,124574,124514,124478,124452,124438,124436,124434,124424,124412,124393,124369,124304,124293,123704,123681,123595,123532,123528,123476,123452,123402,123350,123024,122918,122867,122838,122794,122759,122731,122718,122554,122500,122467,122464,122439,122420,122412,122369,122333,122274,122213,122201,122196,122188,122171,122135,122131,122091,122081,122080,122066,122026,121987,121890,121849,121842,121773,121757,121613,120986,120979,120924,120915,120885,120879,120731,120548,120521,120223,119562,119560,119554,119547,119535,119501,119443,119430,119428,119400,119383,119379,119352,119351,119330,119296,104181,103996,130352,130186,129355,129211,129133,129050,128289,128132,128116,128106,127936,127891,127867,127858,127823,127810,127798,127782,127767,127754,127724,127700,127657,127523,127506,127504,127473,127301,127096,127063,127057,127050,127009,126857,126849,126815,126797,126776,126701,126698,126673,126632,126587,126579,126575,126570,126561,126512,126446,126413,126403,126396,126357,126351,126320,126293,126177,126129,126086,126083,126024,126002,125981,125967,125936,125921,125909,125891,125869,125861,125846,125824,125791,125781,125777,125755,125609,125535,125445,125436,125432,125425,125423,125360,125336,125323,125314,125280,125251,125234,125219,125202,125157,125131,125084,124911,124904,124881,124874,124850,124836,124717,124704,124694,124691,124684,124632,124572,124552,124545,124539,124517,124413,124360,124345,124344,124341,124309,124162,124106,124091,124087,124026,123921,123796,123707,123686,123650,123304,123228,123191,123170,123068,123049,123040,123032,122974,122952,122950,122942,122897,122890,122857,122814,122783,122781,122773,122744,122658,122649,122633,122586,122501,122425,122409,122382,122366,122314,122303,122293,122220,122200,122187,122178,122168,122152,122040,122018,121862,121817,121619,121611,121606,121594,121559,121514,121365,121345,121327,121320,121260,121131,121067,121012,120955,120781,120701,120642,120514,120361,119606,119559,119553,119548,119534,119431,119411,119385,119335,119318,119313,131561,129896,129829,129820,129817,128785,128628,128462,128430,128400,128388,128383,128365,128352,128140,128090,128054,128022,127982,127954,127944,127937,127914,127906,127893,127880,127829,127615,127569,127546,127527,127509,127498,127469,127458,127453,127443,127398,127378,127343,127339,127334,127329,127321,127313,127308,127302,127283,127235,127118,127090,127036,126990,126949,126937,126916,126877,126872,126855,126829,126821,126603,126411,126405,126399,126391,125938,125931,125920,125918,125849,125842,125840,125813,125692,125683,125656,125648,125636,125590,125579,125545,125527,125512,125483,125451,125446,125434,125427,125111,125085,125011,124988,124974,124972,124967,124963,124906,124889,124875,124870,124797,124782,124745,124724,124705,124625,124622,124584,124576,124537,124479,124449,124396,124387,124367,123764,123763,123761,123760,123750,123749,123747,123738,123726,123719,123709,123708,123679,123601,123509,123477,123434,123420,123410,123355,123348,123321,123249,123067,123041,122812,122809,122804,122739,122590,122556,122538,122456,122438,122433,122414,122354,122343,122305,122211,122197,122186,122174,122125,122067,122052,122037,121975,121753,121663,121621,121595,121574,121546,121538,121534,121497,121385,121324,121281,121115,121066,120920,120872,119764,119759,119752,119463,119397);
UPDATE `creature_template` SET `unit_class`=1 WHERE `entry` IN (126352,125589,125582,125542,125283,125255,125249,125191,125120,125119,125089,125077,125074,125040,125018,125017,125016,125007,125000,124986,124973,124969,124944,124943,124923,124891,124869,124867,124866,124865,124864,124863,124858,124815,124766,124764,124763,124762,124740,124739,124698,124692,124646,124644,124604,124603,124598,124594,124590,124589,124543,124542,124533,124508,124507,124505,124472,124457,124431,124389,124385,124379,124337,124285,124284,124283,124280,124263,124260,124257,124251,124248,124246,124245,124243,124237,124236,124235,124234,124233,124231,124222,124221,124220,124219,124215,124205,124204,124203,124202,124201,124200,124199,124198,124197,124196,124193,124192,124154,124153,124151,124149,124148,124147,124146,124145,124144,124143,124142,124141,124140,124139,124138,124136,124135,124134,124133,124132,124131,124130,124129,124128,124127,124126,124125,124124,124123,124122,124121,124120,124119,124118,124117,124116,124115,124114,124113,124104,124103,124102,124101,124100,124099,124097,124096,124095,124094,124092,124090,124089,124082,124081,124080,124074,124073,124072,124071,124065,124064,124061,124060,124059,124058,124057,124056,124054,124053,124052,124050,124049,124048,124047,124038,124023,124017,124014,124013,124012,124011,124010,124009,124008,124007,124006,124005,124004,124003,124002,124001,124000,123999,123998,123997,123996,123994,123993,123992,123991,123990,123989,123988,123987,123986,123985,123984,123983,123982,123981,123980,123979,123978,123977,123976,123975,123974,123973,123972,123971,123970,123969,123968,123967,123966,123965,123963,123962,123961,123960,123959,123958,123957,123956,123955,123954,123953,123952,123951,123950,123949,123948,123947,123946,123944,123943,123942,123941,123940,123939,123938,123936,123935,123934,123933,123932,123931,123930,123928,123927,123926,123925,123924,123923,123922,123920,123919,123918,123916,123915,123914,123913,123912,123911,123910,123909,123908,123907,123905,123904,123903,123902,123900,123899,123898,123897,123896,123895,123894,123892,123891,123872,123843,123839,123838,123837,123836,123804,123803,123802,123801,123800,123789,123788,123787,123786,123785,123783,123782,123781,123780,123779,123778,123777,123755,123735,123722,123721,123696,123694,123693,123691,123682,123662,123660,123636,123628,123618,123602,123568,123566,123563,123562,123557,123551,123540,123525,123515,123495,123494,123493,123492,123490,123458,123456,123419,123412,123406,123403,123397,123396,123394,123393,123392,123329,123324,123256,123255,123252,123227,123184,123134,123131,123125,123124,123122,123120,123112,123108,123107,123106,123105,123104,123101,123099,123097,123092,123091,123087,123082,123077,123075,123073,123042,123029,123023,123021,123014,123009,122998,122997,122996,122995,122990,122983,122982,122981,122980,122978,122964,122954,122943,122929,122926,122899,122898,122896,122894,122893,122875,122874,122871,122859,122856,122853,122850,122816,122786,122712,122682,122680,122668,122663,122660,122629,122612,122609,122603,122597,122580,122553,122552,122551,122550,122549,122548,122547,122546,122545,122544,122542,122541,122540,122539,122537,122528,122527,122526,122525,122524,122522,122521,122520,122519,122518,122517,122516,122515,122514,122513,122512,122511,122510,122508,122506,122505,122396,122390,122352,122351,122349,122346,122345,122344,122340,122339,122323,122290,122282,122281,122280,122279,122277,122270,122269,122258,122257,122256,122254,122253,122252,122250,122248,122243,122241,122234,122183,122139,122138,122134,122124,122096,122070,122069,122068,122053,122051,122050,122049,122048,122033,122008,121998,121977,121969,121967,121946,121913,121912,121911,121874,121870,121865,121821,121820,121818,121740,121739,121731,121730,121727,121725,121724,121694,121561,121543,121542,121537,121535,121529,121528,121527,121326,121325,121307,121293,121245,121244,121243,121139,121038,121008,120974,120971,120729,120728,120525,120524,120523,120519,120518,120517,120508,120489,120488,120487,120486,120484,120483,120479,120472,120470,120467,120462,120433,120432,120429,120411,120410,120391,120356,120308,120307,120305,120287,120248,120247,120203,120202,120175,120142,120111,119996,119951,119932,119931,119929,119927,119926,119896,119895,119894,119893,119892,119891,119890,119889,119888,119885,119794,119760,119756,119754,119744,119743,119601,119521,119448,119444,119419,119414,119409,119408,119407,119399,119390,119346,119345,119344,119343,119342,119341,116477,116460,104208,104180,104177,104099,104090,104071,130202,130185,130179,130137,129635,129225,129210,129051,128364,128320,128318,128312,128304,128222,128217,128212,128207,128203,128194,128167,128160,128142,128089,128069,128060,128058,128055,128011,128008,127990,127971,127950,127948,127943,127892,127885,127871,127861,127843,127670,127608,127597,127579,127525,127510,127500,127476,127471,127466,127464,127404,127399,127389,127373,127345,127337,127327,127324,127322,127300,127287,127280,127270,127256,127233,127189,127183,127178,126994,126986,126978,126970,126960,126954,126911,126895,126812,126791,126767,126741,126638,126556,126495,125965,125956,125954,125937,125902,125897,125896,125895,125880,125851,125818,125638,125615,125514,125497,125481,125476,125473,125435,125429,125426,125422,125406,125387,125379,125339,125321,125313,125292,125265,125254,125237,125227,125225,125146,125128,125125,125115,125110,125061,125056,125048,125029,125026,125014,125008,125003,124975,124966,124959,124934,124913,124903,124879,124871,124606,124600,124592,124568,124386,124340,124330,124314,124278,124270,124264,124227,124175,124165,123705,123659,123616,123301,123261,123241,123148,123109,123085,123070,123061,123048,123036,123025,122953,122912,122837,122831,122657,122653,122644,122640,122634,122477,121864,121787,121654,121591,121563,121558,121531,121524,121515,121503,121059,120977,120882,120876,120844,120834,120782,120601,120536,120529,120393,120222,119868,119761,119755,119750,119555,119550,119464,119440,119432,119396,119358,119355,119336,119333,119331,119322,119312,119297,130065,130000,129449,129115,129063,128790,128782,128777,128756,128752,128740,128725,128626,128624,128589,128465,128366,128288,128236,128226,128214,128210,128204,128195,128172,128169,128162,128141,128111,128105,128098,128095,128064,128056,128020,128012,128009,128004,127997,127987,127945,127920,127896,127859,127795,127787,127773,127732,127722,127705,127692,127681,127658,127617,127596,127582,127533,127528,127507,127505,127472,127468,127465,127456,127451,127445,127430,127397,127366,127342,127341,127340,127336,127311,127304,127285,127269,127264,127244,127230,127214,127190,127185,127180,127171,127133,127122,127110,127108,127098,127086,126998,126987,126977,126950,126948,126947,126946,126945,126944,126914,126910,126898,126887,126875,126866,126852,126844,126842,126818,126785,126766,126764,126743,126686,126648,126624,126593,126577,126572,126555,126501,126445,126444,126419,126400,126393,126388,126267,126256,126249,126244,126197,126186,126173,126163,126156,126152,126137,126123,126110,126072,126059,126010,125983,125969,125966,125939,125934,125913,125908,125892,125885,125873,125866,125860,125850,125847,125841,125837,125821,125720,125682,125655,125620,125604,125586,125584,125569,125537,125498,125490,125450,125444,125438,125431,125424,125421,125388,125364,125350,125343,125324,125319,125258,125248,125238,125228,125220,125210,125168,125159,125149,125137,125102,125083,125078,125057,125050,125034,125010,124995,124964,124848,124833,124799,124775,124702,124677,124660,124602,124597,124573,124569,124551,124511,124502,124485,124481,124477,124463,124454,124439,124433,124421,124411,124373,124361,124343,124342,124313,124288,124244,124164,124160,124086,124051,123964,123702,123598,123569,123543,123529,123522,123512,123506,123501,123474,123459,123451,123435,123416,123411,123404,123398,123360,123307,123260,123223,123147,123139,123111,123094,123065,123047,123030,123020,123003,122994,122951,122944,122937,122895,122827,122818,122811,122659,122655,122652,122643,122581,122560,122533,122509,122502,122469,122457,122407,122358,122342,122302,122272,122212,122202,122190,122177,122098,122092,122065,122046,122045,122038,122022,122017,121960,121756,121671,121564,121555,121549,121517,121501,121417,121398,121319,121280,121250,121174,121161,121033,121001,120978,120973,120954,120936,120925,120914,120881,120841,120737,120703,120656,120598,120476,120329,120232,120230,119884,119874,119751,119747,119597,119561,119556,119549,119436,119410,119394,119339,119320,119315,118832,104201,104014,130240,130192,130184,129876,129824,129819,129722,129209,129109,128882,128781,128776,128720,128463,128431,128399,128396,128341,128314,128310,128301,128215,128173,128170,128163,128157,128153,128151,128109,128091,128063,128046,128035,128023,128018,127986,127952,127947,127934,127889,127883,127875,127862,127852,127845,127791,127777,127752,127723,127704,127694,127662,127659,127611,127601,127595,127568,127536,127511,127501,127470,127463,127460,127455,127450,127442,127429,127410,127400,127360,127331,127325,127323,127309,127305,127281,127272,127266,127261,127240,127228,127191,127181,127136,127116,127045,127035,127011,126996,126989,126971,126959,126951,126915,126874,126864,126853,126827,126813,126700,126691,126669,126647,126619,126595,126573,126565,126558,126547,126527,126499,126416,126404,126397,126390,126349,126338,126335,126307,126268,126259,126251,126241,126230,126207,126164,126127,126121,126096,126084,126050,126043,126040,126016,125963,125933,125919,125917,125910,125906,125901,125899,125884,125870,125856,125844,125830,125819,125814,125790,125780,125776,125760,125757,125717,125691,125634,125606,125585,125578,125565,125504,125501,125487,125480,125478,125474,125472,125468,125441,125439,125433,125407,125361,125348,125346,125345,125340,125322,125315,125290,125272,125257,125246,125236,125226,125217,125197,125158,125148,125129,125121,125113,125079,125063,125051,125036,125012,124987,124962,124912,124884,124872,124828,124778,124773,124759,124721,124719,124696,124686,124669,124634,124605,124577,124571,124555,124540,124515,124486,124453,124445,124437,124435,124427,124394,124359,124348,124339,124298,124294,124277,124225,124176,124168,124163,124158,124076,124070,123906,123873,123706,123680,123629,123594,123533,123520,123511,123503,123472,123460,123433,123422,123418,123389,123332,123257,123225,123089,123072,123066,123050,123016,122999,122957,122884,122834,122813,122789,122768,122761,122740,122730,122720,122716,122656,122654,122645,122635,122588,122578,122559,122558,122534,122507,122468,122462,122440,122410,122365,122362,122313,122304,122283,122273,122219,122199,122189,122185,122172,122164,122156,122133,122104,122084,121985,121786,121758,121751,121674,121672,121659,121645,121609,121593,121565,121557,121551,121500,121347,121263,121175,121162,121157,121153,121114,121041,120953,120917,120916,120913,120880,120875,120874,120831,120813,120783,120704,120694,120689,120655,120643,120638,120633,120602,120596,120218,119766,119757,119749,119557,119551,119543,119398,119392,119384,119380,119332,119310,118844,118830,104070,130842,129871,129825,129822,129793,129674,128466,128391,128367,128357,128171,128164,128156,128154,128119,128110,128102,128092,128061,128052,128024,128019,128015,128010,128007,128000,127998,127996,127994,127956,127951,127946,127942,127938,127912,127898,127890,127868,127863,127853,127850,127811,127804,127797,127786,127775,127763,127759,127750,127730,127703,127661,127660,127612,127599,127581,127461,127452,127446,127408,127403,127401,127257,127239,127184,127182,127163,127146,127137,127130,127012,127008,126993,126952,126940,126923,126917,126913,126908,126899,126843,126830,126784,126765,126752,126750,126716,126699,126591,126584,126566,126498,126456,126417,126401,126394,126366,126363,126333,126279,126211,126193,126174,126166,126160,126143,126131,126124,126119,126111,126098,126075,126007,125970,125759,125758,125756,125745,125723,125689,125667,125646,125621,125570,125502,125493,125482,125471,125462,125409,125371,125359,125351,125338,125194,125190,125182,125167,125145,125109,125104,125080,125073,125062,125049,125030,125027,125009,124952,124873,124474,124444,124419,124395,124207,124166,124150,124067,124046,124027,124025,124018,123929,123794,123769,123698,123687,123615,123599,123589,123574,123565,123507,123478,123471,123457,123432,123405,123401,123349,123344,123013,122927,122852,122815,122647,122637,122628,122621,122587,122575,122555,122536,122494,122478,121772,121755,121673,121658,121612,121590,121533,121465,121423,121349,121308,121266,121264,121248,121246,121229,121168,121160,120980,120764,120760,120723,120702,120657,120648,120644,120573,119563,119433,104110,104016,130843,130239,130210,129897,129872,129823,129818,129386,129255,129114,128949,128783,128778,128735,128634,128607,128429,128359,128342,128319,128313,128242,128213,128208,128205,128199,128192,128175,128166,128159,128117,128107,128101,128088,128059,128057,128047,128021,128017,128013,127963,127953,127949,127930,127911,127895,127894,127886,127878,127856,127809,127802,127796,127783,127760,127753,127741,127717,127671,127654,127640,127610,127598,127585,127584,127577,127561,127535,127532,127531,127529,127508,127502,127411,127344,127338,127330,127310,127306,127286,127260,127241,127231,127213,127197,127192,127186,127179,127155,127135,127097,127085,127069,127064,127058,127044,127039,127028,126992,126982,126981,126980,126976,126975,126961,126942,126939,126896,126889,126885,126878,126870,126868,126867,126863,126826,126769,126688,126678,126670,126666,126657,126609,126599,126442,126435,126425,126418,126398,126392,126382,126368,126362,126275,126274,126266,126258,126247,126224,126212,126199,126196,126188,126175,126172,126165,126149,126140,126120,126088,126058,125982,125968,125964,125958,125930,125926,125907,125900,125894,125886,125874,125865,125863,125855,125845,125835,125827,125817,125788,125718,125679,125666,125607,125587,125576,125562,125547,125525,125513,125505,125495,125484,125447,125442,125440,125430,125428,125362,125358,125353,125349,125325,125298,125264,125259,125247,125239,125235,125224,125216,125201,125152,125147,125103,125058,125055,125033,125013,125006,124994,124971,124931,124928,124910,124905,124880,124834,124809,124804,124777,124760,124689,124685,124680,124670,124585,124575,124570,124550,124544,124538,124512,124503,124498,124492,124370,124346,124338,124279,124276,124230,124174,124167,124077,124032,123889,123851,123597,123570,123560,123531,123527,123521,123513,123508,123504,123480,123467,123424,123371,123359,123346,123343,123263,123247,123232,123186,123149,123086,123076,123069,123054,122992,122977,122966,122958,122945,122938,122924,122902,122891,122889,122885,122833,122810,122805,122778,122733,122651,122585,122543,122532,122503,122482,122450,122405,122401,122378,122367,122364,122357,122341,122316,122023,122015,122006,121962,121778,121775,121761,121754,121708,121670,121660,121617,121597,121562,121556,121539,121532,121518,121402,121348,121331,121297,121267,121262,121254,121159,121126,120983,120981,120884,120873,120785,120738,120736,120732,120637,120608,120544,120354,120330,120224,119968,119758,119558,119552,119546,119502,119465,119438,119359,119353,119337,119334,119321,119317,119314,104230,129713,129706,129651,129617,129429,129116,128784,128779,128775,128759,128754,128751,128719,128627,128464,128360,128317,128311,128303,128293,128219,128218,128211,128206,128201,128198,128193,128174,128165,128158,128146,128137,128118,128108,128100,128097,128094,127897,127882,127872,127866,127857,127751,127725,127706,127462,127457,127454,127448,127375,127356,127353,127335,127326,127320,127312,127307,127303,127238,127221,127131,127117,127109,127107,127102,127037,126873,126871,126869,126862,126860,126854,126828,126825,126608,126598,126535,126458,126436,126426,126414,126409,126402,126395,126389,126372,126371,126339,126336,126283,126265,126257,126254,126239,126208,126198,126167,126162,126145,126130,126128,126125,126118,126114,126097,126025,126015,125905,125893,125883,125857,125843,125785,125779,125771,125612,125603,125549,125293,125274,125270,125262,125256,125252,125233,125204,125199,125189,125184,125178,125118,125081,125075,125052,124840,124835,124785,124776,124738,124729,124711,124693,124687,124682,124676,124633,124617,124607,124574,124558,124514,124478,124452,124438,124436,124434,124424,124412,124393,124369,124304,124293,124269,124266,123704,123681,123595,123567,123532,123528,123476,123452,123402,123350,123024,122918,122867,122838,122832,122769,122759,122731,122718,122571,122554,122500,122467,122464,122439,122423,122420,122412,122369,122359,122333,122319,122274,122213,122201,122196,122188,122171,122135,122131,122091,122081,122080,122066,122058,122026,122014,122010,121987,121890,121849,121842,121773,121757,121629,121613,121014,120986,120979,120924,120915,120894,120885,120879,120877,120731,120586,120548,120521,120223,119870,119602,119576,119562,119560,119554,119547,119535,119501,119443,119430,119428,119400,119393,119383,119379,119352,119351,119330,119296,104181,103996,130352,130186,129355,129211,129133,129050,128289,128132,128116,128106,127936,127891,127867,127858,127823,127810,127798,127782,127767,127754,127724,127700,127657,127523,127506,127504,127473,127301,127288,127096,127084,127063,127057,127050,127023,127009,126857,126849,126815,126797,126776,126701,126698,126680,126673,126632,126587,126579,126575,126570,126561,126512,126459,126446,126413,126403,126396,126357,126351,126341,126337,126320,126312,126293,126177,126168,126138,126129,126086,126083,126024,126002,125981,125967,125936,125921,125909,125891,125869,125861,125846,125824,125791,125781,125777,125755,125737,125609,125535,125445,125436,125432,125425,125423,125360,125341,125336,125323,125314,125280,125260,125251,125234,125219,125202,125183,125157,125131,125084,124911,124904,124881,124874,124850,124836,124734,124717,124704,124694,124691,124684,124632,124572,124552,124545,124539,124517,124440,124430,124413,124360,124345,124344,124341,124309,124303,124271,124265,124162,124106,124091,124087,124026,124015,123921,123796,123707,123699,123686,123650,123304,123228,123191,123170,123068,123049,123040,123032,123008,122993,122974,122952,122950,122946,122942,122897,122890,122857,122814,122783,122781,122773,122744,122658,122649,122633,122586,122501,122425,122421,122413,122409,122382,122366,122363,122361,122314,122303,122293,122220,122200,122187,122178,122168,122152,122040,122018,121862,121817,121676,121619,121611,121606,121594,121578,121559,121514,121365,121345,121327,121320,121260,121251,121131,121067,121012,120955,120781,120701,120642,120514,120361,120322,119748,119745,119606,119604,119559,119553,119548,119534,119437,119431,119411,119395,119385,119335,119318,119313,131561,129896,129829,129820,129817,128785,128628,128462,128430,128400,128388,128383,128365,128358,128352,128196,128191,128176,128168,128140,128090,128054,128022,128016,128014,127982,127954,127944,127937,127914,127906,127893,127880,127829,127793,127663,127615,127569,127557,127546,127527,127509,127498,127469,127459,127458,127453,127443,127409,127398,127378,127374,127343,127339,127334,127329,127328,127321,127313,127308,127302,127283,127271,127235,127118,127090,127036,126999,126990,126949,126937,126916,126912,126877,126872,126855,126829,126821,126603,126411,126405,126399,126391,125938,125931,125920,125918,125849,125842,125840,125813,125692,125683,125656,125648,125636,125590,125579,125545,125527,125512,125499,125483,125461,125451,125446,125434,125427,125410,125111,125085,125032,125011,124988,124974,124972,124967,124963,124947,124906,124889,124875,124870,124797,124782,124745,124724,124705,124625,124622,124584,124576,124537,124479,124449,124446,124432,124398,124396,124387,124367,123793,123767,123764,123763,123761,123760,123750,123749,123747,123746,123745,123738,123726,123719,123709,123708,123679,123658,123601,123514,123509,123505,123497,123488,123477,123434,123420,123410,123390,123355,123348,123321,123302,123258,123249,123196,123084,123074,123067,123051,123041,122826,122812,122809,122804,122770,122739,122590,122556,122538,122456,122438,122433,122414,122408,122403,122360,122354,122343,122322,122305,122211,122197,122186,122174,122125,122067,122052,122041,122037,121975,121753,121675,121663,121644,121621,121595,121587,121575,121574,121546,121538,121536,121534,121497,121385,121324,121281,121115,121066,120920,120883,120872,120693,120690,120395,119969,119764,119759,119752,119463,119397,119391,133934,133783,133755,133754,133744,133743,133741,133740,133739,133695,133675,133548,133547,133546,133545,133544,133543,133542,133535,133534,133533,133532,133523,133522,133521,133520,133519,133509,133497,133496,133467,133466,133452,133441,133433,133431,133422,133411,133409,133408,133407,133396,133395,133388,133387,133369,133367,133364,133355,133344,133342,133334,133332,133326,133322,133315,133314,133313,133312,133311,133276,133274,133271,133270,133269,133267,133266,133265,133263,133262,133261,133254,133241,133239,133236,133228,133225,133224,133223,133222,133221,133220,133218,133198,133196,133188,133185,133180,133178,133177,133176,133168,133164,133153,133127,133114,133109,133108,133106,133104,133091,133090,133089,133088,133087,133086,133085,133084,133083,133082,133081,133080,133071,133066,133064,133059,133056,133053,133049,133048,133047,133046,133045,133044,133043,133042,133039,133038,133022,133019,133012,132999,132995,132972,132971,132970,132960,132863,132800,132739,132738,132730,132721,132718,132705,132702,132688,132684,132682,132676,132675,132674,132672,132623,132622,132621,132620,132606,132594,132593,132591,132584,132580,132578,132537,132526,132483,132467,132466,132465,132464,132463,132462,132460,132459,132458,132457,132456,132455,132435,132418,132415,132400,132397,132387,132380,132371,132366,132358,132357,132353,132351,132340,132334,132325,132323,132293,132291,132290,132289,132287,132281,132274,132255,132225,132224,132222,132221,132220,132219,132218,132216,132212,132210,132208,132203,132199,132192,132190,132184,132183,132169,132167,132164,132159,132149,132148,132147,132145,132144,132142,132141,132140,132139,132138,132129,132128,132100,132099,132090,132081,132064,132062,132058,132055,132045,132042,132040,132035,132034,132033,132032,132029,132027,132026,132024,131971,131963,131957,131953,131952,131950,131947,131946,131943,131942,131941,131940,131933,131928,131927,131923,131915,131914,131909,131908,131907,131906,131904,131903,131897,131896,131895,131893,131892,131890,131889,131888,131839,131838,131837,131779,131776,131773,131479,131478,131429,131428,131427,131426,131424,131423,131422,131420,131419,131418,131417,131413,131401,131371,131347,131334,131328,131326,131309,131308,131203,131201,131149,131076,131074,131072,131069,131032,130986,130982,130943,130937,130935,130931,130926,130925,130924,130923,130919,130911,130907,130906,130894,130893,130892,130891,130890,130888,130886,130885,130884,130883,130882,130881,130877,130862,130861,130860,130859,130858,130857,130856,130855,130854,130853,130852,130851,130828,130810,130773,130758,130726,130682,130677,130676,130675,130654,130598,130560,130559,130558,130549,130547,130542,130540,130537,130535,130532,130511,130426,130425,130423,130418,130384,130383,130382,130381,130275,130274,130273,130272,130245,130243,130241,130215,130213,130201,130200,130193,130183,130178,130151,130145,130142,130139,130135,130134,130133,130129,130128,130080,130076,130069,130063,130049,130033,130032,130030,129963,129955,129930,129917,129915,129914,129912,129862,129792,129789,129770,129767,129659,129644,129629,129468,129428,129422,129356,129344,129268,129263,129251,129250,129248,129247,129244,129141,129049,129026,129024,129023,129022,128980,128970,128939,128915,128877,128836,128818,128816,128815,128814,128813,128812,128767,128713,128657,128656,128655,128622,128612,128566,128563,128562,128561,128560,128558,128550,128488,128487,128486,128485,128484,128483,128482,128481,128427,128425,128424,128423,128416,128415,128412,128411,128133,128131,128130,128125,128120,128115,128099,128081,128038,128036,128032,128030,128028,127983,127964,127924,127923,127827,127785,127619,127555,127521,127520,127295,127071,127070,127018,126972,126964,126799,126789,126788,126646,126639,126630,126604,126602,126589,126559,126538,126537,126536,126493,126492,126491,126489,126470,126370,126365,126364,126354,126344,126332,126327,126326,126319,126315,126306,126305,126302,126231,126134,126081,126078,126077,126068,126067,126066,126062,126012,126011,126001,126000,125999,125998,125997,125951,125949,125832,125829,125826,125825,125778,125470,125466,125463,125459,125456,125454,125397,125356,125287,125285,125269,125253,125193,125192,125181,125180,125141,125136,124267,124252);

-- DB/Terrainswap: Add missing terrain swap defaults for blastedlands draenor phase.
DELETE FROM `terrain_swap_defaults` WHERE `MapId`= 0 AND `TerrainSwapMap`= 1190;
INSERT INTO `terrain_swap_defaults` (`MapId`,`TerrainSwapMap`,`Comment`) VALUES
(0, 1190, 'Blasted Land Terrian');

-- DB/Creature: Heldgarr Steelbeard
-- 
DELETE FROM `disables` WHERE `entry`= 45425;
INSERT INTO `disables` (`sourceType`,`entry`,`flags`,`params_0`,`params_1`,`comment`) VALUES
(0, 45425, 64, '', '', 'Ignore LOS for Shoot (Dummy)');

-- DB/Playerchoice: Add mage artifact playerchoice data.
-- mage artifact choice
DELETE FROM `playerchoice` WHERE `ChoiceId`=265;
INSERT INTO `playerchoice` (`ChoiceId`, `Question`, `VerifiedBuild`) VALUES 
(265, 'Which weapon should we pursue first?', 26972);

DELETE FROM `playerchoice_response` WHERE `ChoiceId`=265;
INSERT INTO `playerchoice_response` (`ChoiceId`, `ResponseId`, `Index`, `ChoiceArtFileId`, `Header`, `Answer`, `Description`, `Confirmation`, `VerifiedBuild`) VALUES 
(265, 584, 0, 1389389, 'Arcane', 'Select', 'Aluneth was most notably wielded for a time by Aegwynn, the only female Guardian of Tirisfal, although stories indicate that it is far older than she.\n\nToward the end of Aegwynn\'s life, she entrusted the staff to the Blue Dragonflight. Deeming the staff too dangerous to use, they locked it away in a secret vault, where it remains still.', 'CONFIRM_ARTIFACT_CHOICE', 26972),
(265, 585, 1, 1389390, 'Fire', 'Select', '"Flamestrike" in its native tongue, Felo\'melorn was borne into battle by members of the Sunstrider family as they proved their valor in the War of the Ancients, during the Troll Wars, and against the death knight Arthas Menethil.\n\nUltimately, the sword was lost in the frigid wastes of Northrend.', 'CONFIRM_ARTIFACT_CHOICE', 26972),
(265, 586, 2, 1389391, 'Frost', 'Select', 'This greatstaff was wielded by Alodi, the first Guardian of Tirisfal. He bore the staff into many battles against Legion forces for the century in which he served as Guardian.\n\nShortly after Alodi', 'CONFIRM_ARTIFACT_CHOICE', 26972);


DELETE FROM `playerchoice_response_reward` WHERE `ChoiceId`=265;
INSERT INTO `playerchoice_response_reward` (`ChoiceId`, `ResponseId`, `TitleId`, `PackageId`, `SkillLineId`, `SkillPointCount`, `ArenaPointCount`, `HonorPointCount`, `Money`, `Xp`, `VerifiedBuild`) VALUES 
(265, 584, 0, 0, 0, 0, 0, 0, 0, 0, 26972),
(265, 585, 0, 0, 0, 0, 0, 0, 0, 0, 26972),
(265, 586, 0, 0, 0, 0, 0, 0, 0, 0, 26972);

DELETE FROM `playerchoice_response_reward_item` WHERE `ChoiceId`=265;
INSERT INTO `playerchoice_response_reward_item` (`ChoiceId`, `ResponseId`, `Index`, `ItemId`, `BonusListIDs`, `Quantity`, `VerifiedBuild`) VALUES 
(265, 584, 0, 127857, '', 0, 26972),
(265, 585, 0, 128820, '', 0, 26972),
(265, 586, 0, 128862, '', 0, 26972);

