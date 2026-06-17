# TrinityCore - WowPacketParser
# File name: 22594_2016-09-17_12-16-52.pkt ARM WARRIOR
# Detected build: V7_0_3_22594
# Detected locale: zhCN
# Targeted database: Legion
# Parsing date: 09/20/2018 21:58:07

-- instance template
UPDATE `instance_template` SET `script`='scenario_artifact_brokenshore', `insideResurrection`=1 WHERE `map`=1500;
UPDATE `instance_template` SET `script`='scenario_artifact_tirisfal_glades', `insideResurrection`=1 WHERE `map`=1539;

DELETE FROM `phase_area` WHERE `AreaId`=7796 AND `PhaseId`=6815;
INSERT INTO `phase_area` (`AreaId`, `PhaseId`, `Comment`) VALUES (7796, 6815, 'Phase 6815 On scenario artifact brokenshore');

-- 93773 high_overlord_saurfang
UPDATE `creature_template` SET `ScriptName`='npc_high_overlord_saurfang_93773' WHERE `entry`=93773;
UPDATE `creature_template` SET `ScriptName`='npc_makka_100519' WHERE `entry`=100519;

DELETE FROM `conversation_actors` WHERE (`ConversationId`=1338 AND `ConversationActorId`=51657 AND `Idx`=0) OR (`ConversationId`=1405 AND `Idx`=1) OR (`ConversationId`=1405 AND `Idx`=0) OR (`ConversationId`=1361 AND `ConversationActorId`=51657 AND `Idx`=0) OR (`ConversationId`=792 AND `ConversationActorId`=50343 AND `Idx`=0) OR (`ConversationId`=791 AND `ConversationActorId`=50343 AND `Idx`=0) OR (`ConversationId`=1412 AND `Idx`=0) OR (`ConversationId`=788 AND `ConversationActorId`=12585 AND `Idx`=1) OR (`ConversationId`=788 AND `ConversationActorId`=50343 AND `Idx`=0) OR (`ConversationId`=790 AND `ConversationActorId`=50343 AND `Idx`=0) OR (`ConversationId`=1336 AND `ConversationActorId`=51657 AND `Idx`=0) OR (`ConversationId`=1915 AND `ConversationActorId`=51657 AND `Idx`=0) OR (`ConversationId`=789 AND `ConversationActorId`=50342 AND `Idx`=1) OR (`ConversationId`=789 AND `ConversationActorId`=50343 AND `Idx`=0) OR (`ConversationId`=826 AND `ConversationActorId`=50462 AND `Idx`=0) OR (`ConversationId`=770 AND `ConversationActorId`=50342 AND `Idx`=0) OR (`ConversationId`=1492 AND `ConversationActorId`=51657 AND `Idx`=0) OR (`ConversationId`=1315 AND `ConversationActorId`=51657 AND `Idx`=1) OR (`ConversationId`=1315 AND `ConversationActorId`=51658 AND `Idx`=0) OR (`ConversationId`=1414 AND `ConversationActorId`=12585 AND `Idx`=0) OR (`ConversationId`=1414 AND `ConversationActorId`=50342 AND `Idx`=1) OR (`ConversationId`=1496 AND `ConversationActorId`=51657 AND `Idx`=0) OR (`ConversationId`=771 AND `ConversationActorId`=50342 AND `Idx`=1) OR (`ConversationId`=771 AND `ConversationActorId`=50343 AND `Idx`=0) OR (`ConversationId`=1386 AND `Idx`=1) OR (`ConversationId`=1386 AND `Idx`=0) OR (`ConversationId`=1331 AND `ConversationActorId`=51657 AND `Idx`=0);
INSERT INTO `conversation_actors` (`ConversationId`, `ConversationActorId`, `Idx`, `VerifiedBuild`) VALUES
(1338, 51657, 0, 22594),
(1405, 50342, 1, 22594), -- Full: 0x203D70BB805EE3C00024EA00005CC2E6 Creature/0 R3932/S9450 Map: 1500 Entry: 97167 Low: 6079206
(1405, 103608, 0, 22594), -- Full: 0x203D70BB80652E000024EA00005CC3F0 Creature/0 R3932/S9450 Map: 1500 Entry: 103608 (接引者丹妮卡) Low: 6079472
(1361, 51657, 0, 22594),
(792, 50343, 0, 22594),
(791, 50343, 0, 22594),
(1412, 50342, 0, 22594), -- Full: 0x203D70BB805EE3C00024EA00005CC2E6 Creature/0 R3932/S9450 Map: 1500 Entry: 97167 Low: 6079206
(788, 12585, 1, 22594),
(788, 50343, 0, 22594),
(790, 50343, 0, 22594),
(1336, 51657, 0, 22594),
(1915, 51657, 0, 22594),
(789, 50342, 1, 22594),
(789, 50343, 0, 22594),
(826, 50462, 0, 22594),
(770, 50342, 0, 22594),
(1492, 51657, 0, 22594),
(1315, 51657, 1, 22594),
(1315, 51658, 0, 22594),
(1414, 12585, 0, 22594),
(1414, 50342, 1, 22594),
(1496, 51657, 0, 22594),
(771, 50342, 1, 22594),
(771, 50343, 0, 22594),
(1386, 50342, 1, 22594), -- Full: 0x203D70BB805EE3C00024EA00005CC2E6 Creature/0 R3932/S9450 Map: 1500 Entry: 97167 Low: 6079206
(1386, 12585, 0, 22594), -- Full: 0x203D70BB805EE3800024EA00005CC2E6 Creature/0 R3932/S9450 Map: 1500 Entry: 97166 Low: 6079206
(1331, 51657, 0, 22594);


DELETE FROM `conversation_actor_template` WHERE `Id` IN (51657, 50343, 12585, 50342, 50462, 51658);
INSERT INTO `conversation_actor_template` (`Id`, `CreatureId`, `CreatureModelId`, `VerifiedBuild`) VALUES
(51657, 103144, 68038, 22594),
(50343, 92608, 73674, 22594),
(12585, 97166, 67923, 22594),
(50342, 97167, 67919, 22594),
(50462, 93818, 68280, 22594),
(51658, 101875, 67184, 22594);

-- Creature Entry: 103608 (Danica the Reclaimer)
DELETE FROM `conversation_actor_template` WHERE `Id`=103608;
INSERT INTO `conversation_actor_template` (`Id`, `CreatureId`, `CreatureModelId`, `VerifiedBuild`) VALUES 
(103608, 103608, 73300, 26972); 

DELETE FROM `conversation_line_template` WHERE `Id` IN (3114, 3202, 3201, 3139, 1893, 1892, 3214, 1887, 1886, 1891, 1890, 3110, 4044, 1889, 1888, 2017, 1831, 3343, 3342, 3078, 3077, 3222, 3221, 3220, 3219, 3218, 3348, 1833, 1832, 3172, 3171, 3095);
INSERT INTO `conversation_line_template` (`Id`, `StartTime`, `UiCameraID`, `ActorIdx`, `Flags`, `VerifiedBuild`) VALUES
(3114, 0, 83, 0, 0, 22594),
(3202, 10929, 3422522304, 1, 0, 22594),
(3201, 0, 3422522304, 0, 0, 22594),
(3139, 0, 83, 0, 0, 22594),
(1893, 0, 572, 0, 0, 22594),
(1892, 0, 572, 0, 0, 22594),
(3214, 0, 3422522304, 0, 0, 22594),
(1887, 6844, 136, 1, 0, 22594),
(1886, 0, 572, 0, 0, 22594),
(1891, 8285, 572, 0, 0, 22594),
(1890, 0, 572, 0, 0, 22594),
(3110, 0, 83, 0, 0, 22594),
(4044, 0, 83, 0, 0, 22594),
(1889, 7608, 134, 1, 0, 22594),
(1888, 0, 572, 0, 0, 22594),
(2017, 0, 136, 0, 0, 22594),
(1831, 0, 135, 0, 0, 22594),
(3343, 11708, 82, 0, 0, 22594),
(3342, 0, 83, 0, 0, 22594),
(3078, 8258, 82, 1, 0, 22594),
(3077, 0, 91, 0, 0, 22594),
(3222, 30172, 137, 0, 0, 22594),
(3221, 19899, 135, 1, 0, 22594),
(3220, 10109, 137, 0, 0, 22594),
(3219, 4145, 135, 1, 0, 22594),
(3218, 0, 137, 0, 0, 22594),
(3348, 0, 83, 0, 0, 22594),
(1833, 4756, 134, 1, 0, 22594),
(1832, 0, 572, 0, 0, 22594),
(3172, 4122, 3422522304, 1, 0, 22594),
(3171, 0, 3422522304, 0, 0, 22594),
(3095, 0, 83, 0, 0, 22594);


DELETE FROM `conversation_template` WHERE `Id` IN (1496, 1492, 1361, 1338, 1915, 1336, 1331, 1315, 826, 791, 790, 789, 788, 792, 1414, 771, 1412, 1405, 1386, 770);
INSERT INTO `conversation_template` (`Id`, `FirstLineID`, `LastLineEndTime`, `VerifiedBuild`) VALUES
(1496, 3348, 1610708480, 22594),
(1492, 3342, 1610708224, 22594),
(1361, 3139, 1610699840, 22594),
(1338, 3114, 1610698368, 22594),
(1915, 4044, 1610735296, 22594),
(1336, 3110, 1610698240, 22594),
(1331, 3095, 1610697920, 22594),
(1315, 3077, 1610696896, 22594),
(826, 2017, 2147536512, 22594),
(791, 1892, 2147534272, 22594),
(790, 1890, 2147534208, 22594),
(789, 1888, 2147534144, 22594),
(788, 1886, 2147534080, 22594),
(792, 1893, 2147534336, 22594),
(1414, 3218, 2147574144, 22594),
(771, 1832, 2147532992, 22594),
(1412, 3214, 2147574016, 22594),
(1405, 3201, 2147573568, 22594),
(1386, 3171, 2147572352, 22594),
(770, 1831, 2147532928, 22594);


DELETE FROM `gameobject_template_addon` WHERE `entry` IN (248466 /*暗影之墙*/, 251349 /*场景战役碰撞*/);
INSERT INTO `gameobject_template_addon` (`entry`, `faction`, `flags`) VALUES
(248466, 0, 48),
(251349, 0, 32); 

SET NAMES 'latin1';
DELETE FROM `scene_template` WHERE (`SceneId`=1225 AND `ScriptPackageID`=1590) OR (`SceneId`=1207 AND `ScriptPackageID`=1571);
INSERT INTO `scene_template` (`SceneId`, `Flags`, `ScriptPackageID`) VALUES
(1225, 21, 1590), -- 7.0 Artifacts - Warrior - Arms - Loot Scene
(1207, 25, 1571); -- 7.0 Artifacts - Warrior - Arms - Boss Reveal Scene

SET NAMES 'latin1';
SET NAMES 'utf8';

DELETE FROM `quest_offer_reward` WHERE `ID` IN (38904 /*Return to the Broken Shore*/, 41052 /*A Desperate Plea*/);
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(38904, 0, 0, 0, 0, 0, 0, 0, 0, 'Welcome to the Halls of Valor, hero. Normally one must die to gain entrance, but times have changed.', 26124), -- Return to the Broken Shore
(41052, 0, 0, 0, 0, 0, 0, 0, 0, 'You have come to save Azeroth, a goal I heartily approve. I am a simple traveler that has learned much over the years. Let us speak of the power of proving your valor.', 26124); -- A Desperate Plea

DELETE FROM `quest_details` WHERE `ID` IN (40585 /*-Unknown-*/, 39214 /*-Unknown-*/, 39192 /*-Unknown-*/, 39530 /*-Unknown-*/, 41105 /*-Unknown-*/, 40579 /*-Unknown-*/, 39654 /*-Unknown-*/);
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES
(40585, 1, 1, 0, 0, 0, 0, 0, 0, 22594), -- -Unknown-
(39214, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- -Unknown-
(39192, 1, 0, 0, 0, 0, 0, 0, 0, 22594), -- -Unknown-
(39530, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- -Unknown-
(41105, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- -Unknown-
(40579, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- -Unknown-
(39654, 0, 0, 0, 0, 0, 0, 0, 0, 22594); -- -Unknown-

DELETE FROM `quest_details` WHERE `ID` IN (39654 /*Odyn and the Valarjar*/, 38904 /*Return to the Broken Shore*/, 41052 /*A Desperate Plea*/);
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES
(39654, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- Odyn and the Valarjar
(38904, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- Return to the Broken Shore
(41052, 0, 0, 0, 0, 0, 0, 0, 0, 26124); -- A Desperate Plea

SET @CGUID = 452067;
DELETE FROM `creature` WHERE `guid` BETWEEN @CGUID+0 AND @CGUID+83;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `PhaseId`, `PhaseGroup`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `VerifiedBuild`) VALUES
-- 6811 - 7201 - 7300 - 7302 - 7304 - 7313 - 7314 - 7318 - 7319 - 7334 - 7342 - 4592 - 4590 - 4588 - 4586
(@CGUID+83, 93773, 1220, 7505, 7502, 3, '7300', 0, 0, 0, -836.988,   4255.25,   746.362, 4.65065, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- High Overlord Saurfang (Area: -Unknown- - Difficulty: 0)
(@CGUID+0, 100519, 1220, 7505, 7502, 3, '7300', 0, 0, 0, -842.042, 4255.39, 746.363, 4.75103, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- Makka (Area: -Unknown- - Difficulty: 0)

-- 6811 - 6815 - 7201 - 7300 - 7302 - 7304 - 7313 - 7314 - 7318 - 7319 - 7334 - 7342 - 4592 - 4590 - 4588 - 4586
(@CGUID+1, 92446, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -1984, -1192.87, 1.42315, 2.09439, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- Wrathbringer Vanguard (Area: -Unknown- - Difficulty: 0)
(@CGUID+2, 97177, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -1954.08, -1278.73, 4.65972, 3.59216, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- Impling Pursuer (Area: -Unknown- - Difficulty: 0)
(@CGUID+3, 97177, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -1947.58, -1291.94, 5.54113, 3.59216, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- Impling Pursuer (Area: -Unknown- - Difficulty: 0) (Auras: )
(@CGUID+4, 64367, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -1966.13, -1236.74, 2.2793, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- 隐形人 (Area: -Unknown- - Difficulty: 0) (Auras: )
(@CGUID+5, 97177, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -1979.77, -1215.27, 2.60271, 2.48881, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- Impling Pursuer (Area: -Unknown- - Difficulty: 0) (Auras: )
(@CGUID+6, 64367, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -1995.62, -1247.17, 6.98914, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- 隐形人 (Area: -Unknown- - Difficulty: 0) (Auras: )
(@CGUID+7, 97176, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -1959.39, -1290.38, 3.9356, 3.59216, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- Eredar Enslaver (Area: -Unknown- - Difficulty: 0)
(@CGUID+8, 92447, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -1941.65, -1231.89, 1.01215, 4.18879, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- 混沌之子 (Area: -Unknown- - Difficulty: 0)
(@CGUID+9, 97177, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -1982.16, -1204.67, 1.93565, 2.48881, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- Impling Pursuer (Area: -Unknown- - Difficulty: 0) (Auras: )
(@CGUID+10, 102990, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -1891.34, -1253, 2.67882, 3.66838, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- Aspiring Vrykul Hero (Area: -Unknown- - Difficulty: 0) (Auras: )
(@CGUID+11, 97176, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -1983.7, -1208.42, 2.43449, 5.77508, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- Eredar Enslaver (Area: -Unknown- - Difficulty: 0) (Auras: )
(@CGUID+12, 64367, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -2024.43, -1229.52, 16.545, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- 隐形人 (Area: -Unknown- - Difficulty: 0) (Auras: )
(@CGUID+13, 97175, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -1970.82, -1271.93, 4.62153, 0.823377, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- Felguard Invader (Area: -Unknown- - Difficulty: 0) (Auras: )
(@CGUID+14, 97177, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -1958.85, -1275.55, 4.75695, 3.59216, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- Impling Pursuer (Area: -Unknown- - Difficulty: 0)
(@CGUID+15, 97177, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -1981.87, -1228.06, 4.19445, 2.48881, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- Impling Pursuer (Area: -Unknown- - Difficulty: 0) (Auras: )
(@CGUID+16, 102990, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -1921.81, -1237.92, 1.37436, 5.23599, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- Aspiring Vrykul Hero (Area: -Unknown- - Difficulty: 0)
(@CGUID+17, 64367, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -2061.65, -1216.18, 27.4044, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- 隐形人 (Area: -Unknown- - Difficulty: 0) (Auras: )
(@CGUID+18, 102990, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -1950.69, -1207.15, 0.913116, 4.18879, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- Aspiring Vrykul Hero (Area: -Unknown- - Difficulty: 0)
(@CGUID+19, 97176, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -1981.51, -1269.52, 5.2934, 3.59216, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- Eredar Enslaver (Area: -Unknown- - Difficulty: 0) (Auras: )
(@CGUID+20, 102990, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -1923.86, -1269.4, 4.24909, 5.23599, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- Aspiring Vrykul Hero (Area: -Unknown- - Difficulty: 0)
(@CGUID+21, 97177, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -1983.94, -1200.97, 1.84033, 2.48881, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- Impling Pursuer (Area: -Unknown- - Difficulty: 0)
(@CGUID+22, 98257, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -2083.05, -1197.52, 28.478, 6.27537, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- Bezzeredes (Area: -Unknown- - Difficulty: 0) (Auras: )
(@CGUID+23, 102990, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -1920.82, -1192.82, 0.90809, 4.08133, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- Aspiring Vrykul Hero (Area: -Unknown- - Difficulty: 0)
(@CGUID+24, 97177, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -1943.37, -1287.47, 3.95433, 3.59216, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- Impling Pursuer (Area: -Unknown- - Difficulty: 0) (Auras: )
(@CGUID+25, 102965, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -1909.4, -1228.99, 0.93135, 3.62527, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- Alrik the Slayer (Area: -Unknown- - Difficulty: 0)
(@CGUID+26, 92445, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -1935.76, -1277.64, 5.22109, 3.14159, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- 恶魔卫士入侵者 (Area: -Unknown- - Difficulty: 0)
(@CGUID+27, 64367, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -2049.37, -1201.89, 15.9318, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- 隐形人 (Area: -Unknown- - Difficulty: 0) (Auras: )
(@CGUID+28, 97177, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -1964.55, -1271.09, 4.52431, 3.59216, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- Impling Pursuer (Area: -Unknown- - Difficulty: 0)
(@CGUID+29, 102990, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -1903.83, -1241.88, 1.52083, 3.73236, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- Aspiring Vrykul Hero (Area: -Unknown- - Difficulty: 0) (Auras: )
(@CGUID+30, 64367, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -2068.39, -1221.65, 30.7604, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- 隐形人 (Area: -Unknown- - Difficulty: 0) (Auras: )
(@CGUID+31, 97177, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -1985.85, -1215.34, 3.45139, 2.48881, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- Impling Pursuer (Area: -Unknown- - Difficulty: 0)
(@CGUID+32, 102990, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -1898.48, -1231.35, 0.835069, 3.46362, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- Aspiring Vrykul Hero (Area: -Unknown- - Difficulty: 0)
(@CGUID+33, 92447, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -1963.57, -1221.98, 1.88587, 1.0472, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- 混沌之子 (Area: -Unknown- - Difficulty: 0)
(@CGUID+34, 100463, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -2003.19, -1198.98, 4.17976, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- 隐形人 (Area: -Unknown- - Difficulty: 0)
(@CGUID+35, 102990, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -1944.61, -1232.41, 1.05559, 5.23599, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- Aspiring Vrykul Hero (Area: -Unknown- - Difficulty: 0)
(@CGUID+36, 97176, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -2113.29, -1217.26, 41.9512, 6.03055, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- Eredar Enslaver (Area: -Unknown- - Difficulty: 0)
(@CGUID+37, 97177, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -1969.87, -1265.02, 4.26389, 3.59216, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- Impling Pursuer (Area: -Unknown- - Difficulty: 0) (Auras: )
(@CGUID+38, 92450, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -1959.11, -1201, 0.913878, 4.18879, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- 艾瑞达裂隙制造者 (Area: -Unknown- - Difficulty: 0)
(@CGUID+39, 64367, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -2059.3, -1180.46, 16.5097, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- 隐形人 (Area: -Unknown- - Difficulty: 0) (Auras: )
(@CGUID+40, 97177, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -1958.2, -1285.19, 4.25058, 3.59216, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- Impling Pursuer (Area: -Unknown- - Difficulty: 0) (Auras: )
(@CGUID+41, 97175, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -1952.31, -1289.66, 4.21273, 0.873375, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- Felguard Invader (Area: -Unknown- - Difficulty: 0) (Auras: )
(@CGUID+42, 102990, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -1895.91, -1244.14, 1.62326, 3.32062, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- Aspiring Vrykul Hero (Area: -Unknown- - Difficulty: 0)
(@CGUID+43, 64367, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -2047.86, -1201.5, 15.1837, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- 隐形人 (Area: -Unknown- - Difficulty: 0) (Auras: )
(@CGUID+44, 97166, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -1918.47, -1227.38, 0.908083, 1.09381, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- Finna Bjornsdottir (Area: -Unknown- - Difficulty: 0) (Auras: 13736 - -Unknown-)
(@CGUID+45, 97177, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -1982.45, -1236.19, 4.44271, 2.48881, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- Impling Pursuer (Area: -Unknown- - Difficulty: 0)
(@CGUID+46, 97176, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -2112.98, -1177.26, 36.6424, 6.1202, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- Eredar Enslaver (Area: -Unknown- - Difficulty: 0)
(@CGUID+47, 97175, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -1991.24, -1229.81, 5.42361, 6.05321, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- Felguard Invader (Area: -Unknown- - Difficulty: 0) (Auras: )
(@CGUID+48, 97177, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -1976.75, -1207.78, 1.60356, 2.48881, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- Impling Pursuer (Area: -Unknown- - Difficulty: 0) (Auras: )
(@CGUID+49, 97177, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -1989.51, -1227.3, 5.01389, 2.48881, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- Impling Pursuer (Area: -Unknown- - Difficulty: 0) (Auras: )
(@CGUID+50, 92447, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -1952.04, -1212.9, 0.997552, 1.0472, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- 混沌之子 (Area: -Unknown- - Difficulty: 0)
(@CGUID+51, 64367, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -2057.95, -1170.71, 15.1605, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- 隐形人 (Area: -Unknown- - Difficulty: 0) (Auras: )
(@CGUID+52, 97177, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -1990.74, -1239.8, 6.30472, 2.48881, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- Impling Pursuer (Area: -Unknown- - Difficulty: 0) (Auras: )
(@CGUID+53, 64367, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -2019.05, -1166.8, 5.20134, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- 隐形人 (Area: -Unknown- - Difficulty: 0) (Auras: )
(@CGUID+54, 97177, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -1947.08, -1282.91, 5.37061, 3.59216, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- Impling Pursuer (Area: -Unknown- - Difficulty: 0)
(@CGUID+55, 102970, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -1984.43, -1252.56, 6.02399, 0.519483, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- Fel Lord Dakuur (Area: -Unknown- - Difficulty: 0) (Auras: 199094 - -Unknown-)
(@CGUID+56, 102990, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -1932.11, -1257.79, 3.42371, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- Aspiring Vrykul Hero (Area: -Unknown- - Difficulty: 0)
(@CGUID+57, 64367, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -1963.51, -1190.33, 0.920304, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- 隐形人 (Area: -Unknown- - Difficulty: 0) (Auras: )
(@CGUID+58, 102990, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -1957.73, -1205.42, 0.913228, 5.23599, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- Aspiring Vrykul Hero (Area: -Unknown- - Difficulty: 0)
(@CGUID+59, 97177, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -1981.18, -1222.36, 3.58333, 2.48881, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- Impling Pursuer (Area: -Unknown- - Difficulty: 0) (Auras: )
(@CGUID+60, 102990, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -1914.88, -1200.35, 0.908038, 3.66838, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- Aspiring Vrykul Hero (Area: -Unknown- - Difficulty: 0)
(@CGUID+61, 64367, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -1952.38, -1243.11, 1.9766, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- 隐形人 (Area: -Unknown- - Difficulty: 0) (Auras: )
(@CGUID+62, 97176, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -2113.06, -1187.26, 37.371, 0.854409, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- Eredar Enslaver (Area: -Unknown- - Difficulty: 0)
(@CGUID+63, 97177, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -1971.62, -1261.57, 4.06597, 3.59216, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- Impling Pursuer (Area: -Unknown- - Difficulty: 0) (Auras: )
(@CGUID+64, 64367, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -1985.13, -1203.85, 2.23208, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- 隐形人 (Area: -Unknown- - Difficulty: 0) (Auras: )
(@CGUID+65, 97167, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -1923.29, -1218.93, 0.90809, 0.0923169, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- Ragnvald Drakeborn (Area: -Unknown- - Difficulty: 0) (Auras: 13736 - -Unknown-)
(@CGUID+66, 97177, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -1978.93, -1209.58, 1.96059, 2.48881, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- Impling Pursuer (Area: -Unknown- - Difficulty: 0)
(@CGUID+67, 102964, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -1920.94, -1210.26, 0.90809, 3.65804, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- Haardgrim (Area: -Unknown- - Difficulty: 0)
(@CGUID+68, 92450, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -1946.49, -1242.26, 1.79176, 3.14159, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- 艾瑞达裂隙制造者 (Area: -Unknown- - Difficulty: 0)
(@CGUID+69, 97177, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -1967.22, -1276.55, 4.54861, 3.59216, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- Impling Pursuer (Area: -Unknown- - Difficulty: 0)
(@CGUID+70, 102990, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -1926.99, -1186.67, 0.90809, 3.58056, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- Aspiring Vrykul Hero (Area: -Unknown- - Difficulty: 0)
(@CGUID+71, 97177, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -1975.08, -1268.44, 4.65799, 3.59216, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- Impling Pursuer (Area: -Unknown- - Difficulty: 0)
(@CGUID+72, 102990, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -1977.83, -1215.51, 2.37969, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- Aspiring Vrykul Hero (Area: -Unknown- - Difficulty: 0)
(@CGUID+73, 102990, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -1913.24, -1258.16, 3.67639, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- Aspiring Vrykul Hero (Area: -Unknown- - Difficulty: 0)
(@CGUID+74, 64367, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -1993.41, -1175.09, 1.81088, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- 隐形人 (Area: -Unknown- - Difficulty: 0) (Auras: )
(@CGUID+75, 92445, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -1931.98, -1245.58, 2.11111, 3.14159, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- 恶魔卫士入侵者 (Area: -Unknown- - Difficulty: 0)
(@CGUID+76, 97177, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -1975.29, -1259.16, 4.0382, 3.59216, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- Impling Pursuer (Area: -Unknown- - Difficulty: 0) (Auras: )
(@CGUID+77, 92447, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -1962.58, -1264.05, 4.07989, 4.18879, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- 混沌之子 (Area: -Unknown- - Difficulty: 0)
(@CGUID+78, 64367, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -1972.91, -1243.17, 3.21135, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- 隐形人 (Area: -Unknown- - Difficulty: 0) (Auras: )
(@CGUID+79, 97176, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -2113.21, -1207.26, 39.1394, 5.06491, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- Eredar Enslaver (Area: -Unknown- - Difficulty: 0)
(@CGUID+80, 92447, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -1977.82, -1225.4, 3.51562, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- 混沌之子 (Area: -Unknown- - Difficulty: 0)
(@CGUID+81, 97177, 1500, 7796, 7796, 4096, '6815', 0, 0, 0, -1984.86, -1241.56, 5.1686, 2.48881, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124), -- Impling Pursuer (Area: -Unknown- - Difficulty: 0)
(@CGUID+82, 103608, 1500, 7796, 7796, 4096, '0', 0, 0, 0, -2001, -1255, 42.2, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 26124); -- Danica the Reclaimer (Area: -Unknown- - Difficulty: 12)

DELETE FROM `creature_addon` WHERE `guid` BETWEEN @CGUID+0 AND @CGUID+83;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `auras`) VALUES

(@CGUID+83, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- High Overlord Saurfang
(@CGUID+0, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- Makka
(@CGUID+1, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- Wrathbringer Vanguard
(@CGUID+2, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- Impling Pursuer
(@CGUID+3, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- Impling Pursuer
(@CGUID+4, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 隐形人
(@CGUID+5, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- Impling Pursuer
(@CGUID+6, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 隐形人
(@CGUID+7, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- Eredar Enslaver
(@CGUID+8, 0, 0, 0, 0, 0, 0, 0, 0, ''), -- 混沌之子
(@CGUID+9, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- Impling Pursuer
(@CGUID+10, 0, 0, 0, 257, 0, 0, 0, 0, ''), -- Aspiring Vrykul Hero
(@CGUID+11, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- Eredar Enslaver
(@CGUID+12, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 隐形人
(@CGUID+13, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- Felguard Invader
(@CGUID+14, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- Impling Pursuer
(@CGUID+15, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- Impling Pursuer
(@CGUID+16, 0, 0, 0, 257, 0, 0, 0, 0, ''), -- Aspiring Vrykul Hero
(@CGUID+17, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 隐形人
(@CGUID+18, 0, 0, 0, 257, 0, 0, 0, 0, ''), -- Aspiring Vrykul Hero
(@CGUID+19, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- Eredar Enslaver
(@CGUID+20, 0, 0, 0, 257, 0, 0, 0, 0, ''), -- Aspiring Vrykul Hero
(@CGUID+21, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- Impling Pursuer
(@CGUID+22, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- Bezzeredes
(@CGUID+23, 0, 0, 0, 257, 0, 0, 0, 0, ''), -- Aspiring Vrykul Hero
(@CGUID+24, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- Impling Pursuer
(@CGUID+25, 0, 0, 0, 257, 0, 0, 0, 0, ''), -- Alrik the Slayer
(@CGUID+26, 0, 0, 0, 0, 0, 0, 0, 0, ''), -- 恶魔卫士入侵者
(@CGUID+27, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 隐形人
(@CGUID+28, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- Impling Pursuer
(@CGUID+29, 0, 0, 0, 257, 0, 0, 0, 0, ''), -- Aspiring Vrykul Hero
(@CGUID+30, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 隐形人
(@CGUID+31, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- Impling Pursuer
(@CGUID+32, 0, 0, 0, 257, 0, 0, 0, 0, ''), -- Aspiring Vrykul Hero
(@CGUID+33, 0, 0, 0, 0, 0, 0, 0, 0, ''), -- 混沌之子
(@CGUID+34, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 隐形人
(@CGUID+35, 0, 0, 0, 257, 0, 0, 0, 0, ''), -- Aspiring Vrykul Hero
(@CGUID+36, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- Eredar Enslaver
(@CGUID+37, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- Impling Pursuer
(@CGUID+38, 0, 0, 0, 0, 0, 0, 0, 0, ''), -- 艾瑞达裂隙制造者
(@CGUID+39, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 隐形人
(@CGUID+40, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- Impling Pursuer
(@CGUID+41, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- Felguard Invader
(@CGUID+42, 0, 0, 0, 257, 0, 0, 0, 0, ''), -- Aspiring Vrykul Hero
(@CGUID+43, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 隐形人
(@CGUID+44, 0, 0, 0, 257, 0, 0, 0, 0, '13736'), -- Finna Bjornsdottir - 13736 - -Unknown-
(@CGUID+45, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- Impling Pursuer
(@CGUID+46, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- Eredar Enslaver
(@CGUID+47, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- Felguard Invader
(@CGUID+48, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- Impling Pursuer
(@CGUID+49, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- Impling Pursuer
(@CGUID+50, 0, 0, 0, 0, 0, 0, 0, 0, ''), -- 混沌之子
(@CGUID+51, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 隐形人
(@CGUID+52, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- Impling Pursuer
(@CGUID+53, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 隐形人
(@CGUID+54, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- Impling Pursuer
(@CGUID+55, 0, 0, 0, 1, 0, 0, 0, 0, '199094'), -- Fel Lord Dakuur - 199094 - -Unknown-
(@CGUID+56, 0, 0, 0, 257, 0, 0, 0, 0, ''), -- Aspiring Vrykul Hero
(@CGUID+57, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 隐形人
(@CGUID+58, 0, 0, 0, 257, 0, 0, 0, 0, ''), -- Aspiring Vrykul Hero
(@CGUID+59, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- Impling Pursuer
(@CGUID+60, 0, 0, 0, 257, 0, 0, 0, 0, ''), -- Aspiring Vrykul Hero
(@CGUID+61, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 隐形人
(@CGUID+62, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- Eredar Enslaver
(@CGUID+63, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- Impling Pursuer
(@CGUID+64, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 隐形人
(@CGUID+65, 0, 0, 0, 257, 0, 0, 0, 0, '13736'), -- Ragnvald Drakeborn - 13736 - -Unknown-
(@CGUID+66, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- Impling Pursuer
(@CGUID+67, 0, 0, 0, 257, 0, 0, 0, 0, ''), -- Haardgrim
(@CGUID+68, 0, 0, 0, 0, 0, 0, 0, 0, ''), -- 艾瑞达裂隙制造者
(@CGUID+69, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- Impling Pursuer
(@CGUID+70, 0, 0, 0, 257, 0, 0, 0, 0, ''), -- Aspiring Vrykul Hero
(@CGUID+71, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- Impling Pursuer
(@CGUID+72, 0, 0, 0, 257, 0, 0, 0, 0, ''), -- Aspiring Vrykul Hero
(@CGUID+73, 0, 0, 0, 257, 0, 0, 0, 0, ''), -- Aspiring Vrykul Hero
(@CGUID+74, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 隐形人
(@CGUID+75, 0, 0, 0, 0, 0, 0, 0, 0, ''), -- 恶魔卫士入侵者
(@CGUID+76, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- Impling Pursuer
(@CGUID+77, 0, 0, 0, 0, 0, 0, 0, 0, ''), -- 混沌之子
(@CGUID+78, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 隐形人
(@CGUID+79, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- Eredar Enslaver
(@CGUID+80, 0, 0, 0, 0, 0, 0, 0, 0, ''), -- 混沌之子
(@CGUID+81, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- Impling Pursuer
(@CGUID+82, 0, 0, 50331648, 0, 0, 0, 0, 0, ''); -- Danica the Reclaimer

SET @CGUID = 452602;
DELETE FROM `creature` WHERE `guid` BETWEEN @CGUID+0 AND @CGUID+130;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `PhaseId`, `PhaseGroup`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `VerifiedBuild`) VALUES
(@CGUID+0, 104276, 1539, 85, 7978, 4096, '0', 0, 0, 0, 1882.181, 2163.351, 35.92473, 2.002049, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 腐蚀者扎卡兹 (Area: -Unknown- - Difficulty: 12) (Auras: 211453 - -Unknown-)
(@CGUID+1, 104772, 1539, 85, 7978, 4096, '0', 0, 0, 0, 1875.873, 2171.735, 35.92521, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 气息追踪者 (Area: -Unknown- - Difficulty: 12)
(@CGUID+2, 104772, 1539, 85, 7978, 4096, '0', 0, 0, 0, 1875.873, 2171.735, 35.92521, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 气息追踪者 (Area: -Unknown- - Difficulty: 12)
(@CGUID+3, 104772, 1539, 85, 7978, 4096, '0', 0, 0, 0, 1875.873, 2171.735, 35.92521, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 气息追踪者 (Area: -Unknown- - Difficulty: 12)
(@CGUID+4, 104772, 1539, 85, 7978, 4096, '0', 0, 0, 0, 1875.873, 2171.735, 35.92521, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 气息追踪者 (Area: -Unknown- - Difficulty: 12)
(@CGUID+5, 104772, 1539, 85, 7978, 4096, '0', 0, 0, 0, 1875.873, 2171.735, 35.92521, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 气息追踪者 (Area: -Unknown- - Difficulty: 12)
(@CGUID+6, 104772, 1539, 85, 7978, 4096, '0', 0, 0, 0, 1875.873, 2171.735, 35.92521, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 气息追踪者 (Area: -Unknown- - Difficulty: 12)
(@CGUID+7, 104772, 1539, 85, 7978, 4096, '0', 0, 0, 0, 1875.768, 2171.875, 35.92521, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 气息追踪者 (Area: -Unknown- - Difficulty: 12)
(@CGUID+8, 104772, 1539, 85, 7978, 4096, '0', 0, 0, 0, 1875.768, 2171.875, 35.92521, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 气息追踪者 (Area: -Unknown- - Difficulty: 12)
(@CGUID+9, 104772, 1539, 85, 7978, 4096, '0', 0, 0, 0, 1875.768, 2171.875, 35.92521, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 气息追踪者 (Area: -Unknown- - Difficulty: 12)
(@CGUID+10, 104307, 1539, 85, 7978, 4096, '0', 0, 0, 0, 1897.611, 2213.425, 39.01884, 3.544497, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 索拉丁 (Area: -Unknown- - Difficulty: 12)
(@CGUID+11, 103151, 1539, 85, 7978, 4096, '0', 0, 0, 0, 1883.608, 2181.691, 36.08333, 0.0153217, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- Effects Bunny (Area: -Unknown- - Difficulty: 12) (Auras: 63048 - -Unknown-)

(@CGUID+12, 103144, 1539, 85, 7977, 4096, '0', 0, 0, 0, 2131.323, 2423.563, 122.2778, 2.44508, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 索拉丁 (Area: -Unknown- - Difficulty: 12) (Auras: 204093 - -Unknown-)
(@CGUID+13, 103151, 1539, 85, 7977, 4096, '0', 0, 0, 0, 2132.773, 2423.611, 120.2508, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- Effects Bunny (Area: -Unknown- - Difficulty: 12) (Auras: )
(@CGUID+14, 103151, 1539, 85, 7977, 4096, '0', 0, 0, 0, 2130.389, 2424.774, 120.5008, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- Effects Bunny (Area: -Unknown- - Difficulty: 12) (Auras: )
(@CGUID+15, 103151, 1539, 85, 7977, 4096, '0', 0, 0, 0, 2130.62, 2422.292, 120.3464, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- Effects Bunny (Area: -Unknown- - Difficulty: 12) (Auras: )
(@CGUID+16, 101127, 1539, 85, 7977, 4096, '0', 0, 0, 0, 2057.263, 2432.545, 129.9624, 0.7052379, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 暮光折剑者 (Area: -Unknown- - Difficulty: 12) (Auras: )
(@CGUID+17, 101127, 1539, 85, 7977, 4096, '0', 0, 0, 0, 2080.298, 2469.75, 124.3304, 2.192748, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 暮光折剑者 (Area: -Unknown- - Difficulty: 12)
(@CGUID+18, 51964, 1539, 85, 7977, 4096, '0', 0, 0, 0, 2041.686, 2479.42, 133.7604, 0, 7200, 10, 0, 0, 0, 1, 0, 0, 0, 22594), -- 提瑞斯法雌鹿 (Area: -Unknown- - Difficulty: 12) (possible waypoints or random movement)
(@CGUID+19, 101127, 1539, 85, 7977, 4096, '0', 0, 0, 0, 2084.969, 2433.368, 125.7363, 2.813559, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 暮光折剑者 (Area: -Unknown- - Difficulty: 12)
(@CGUID+20, 51961, 1539, 85, 7977, 4096, '0', 0, 0, 0, 2046.556, 2479.304, 132.6986, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 提瑞斯法雄鹿 (Area: -Unknown- - Difficulty: 12)
(@CGUID+21, 101122, 1539, 85, 7977, 4096, '0', 0, 0, 0, 2100.453, 2433.33, 118.9706, 4.979061, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 暮光暗影法师 (Area: -Unknown- - Difficulty: 12) (Auras: )
(@CGUID+22, 101875, 1539, 85, 7977, 4096, '0', 0, 0, 0, 2123.578, 2432.773, 119.3312, 5.378629, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 暮光祭师 (Area: -Unknown- - Difficulty: 12) (Auras: 34429 - -Unknown-)
(@CGUID+23, 101127, 1539, 85, 7977, 4096, '0', 0, 0, 0, 2116.802, 2448.976, 119.4689, 2.835669, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 暮光折剑者 (Area: -Unknown- - Difficulty: 12)
(@CGUID+24, 101875, 1539, 85, 7977, 4096, '0', 0, 0, 0, 2127.429, 2412.736, 119.4875, 0.9958076, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 暮光祭师 (Area: -Unknown- - Difficulty: 12) (Auras: 34429 - -Unknown-)
(@CGUID+25, 101875, 1539, 85, 7977, 4096, '0', 0, 0, 0, 2142.637, 2425.96, 119.8455, 3.234222, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 暮光祭师 (Area: -Unknown- - Difficulty: 12) (Auras: 34429 - -Unknown-)
(@CGUID+26, 101127, 1539, 85, 7977, 4096, '0', 0, 0, 0, 2129.955, 2486.594, 134.2023, 2.338427, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 暮光折剑者 (Area: -Unknown- - Difficulty: 12)
(@CGUID+27, 101122, 1539, 85, 7977, 4096, '0', 0, 0, 0, 2164.533, 2432.898, 119.5129, 1.535296, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 暮光暗影法师 (Area: -Unknown- - Difficulty: 12)
(@CGUID+28, 101122, 1539, 85, 7977, 4096, '0', 0, 0, 0, 2171.771, 2419.21, 119.3853, 5.742339, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 暮光暗影法师 (Area: -Unknown- - Difficulty: 12)
(@CGUID+29, 101122, 1539, 85, 7977, 4096, '0', 0, 0, 0, 2154.045, 2398.681, 119.3258, 5.609139, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 暮光暗影法师 (Area: -Unknown- - Difficulty: 12)
(@CGUID+30, 103151, 1539, 85, 7681, 4096, '0', 0, 0, 0, 1950.951, 2350.38, 78.03673, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- Effects Bunny (Area: -Unknown- - Difficulty: 12) (Auras: 202925 - -Unknown-)
(@CGUID+31, 103151, 1539, 85, 7681, 4096, '0', 0, 0, 0, 1951.644, 2321.946, 78.04782, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- Effects Bunny (Area: -Unknown- - Difficulty: 12) (Auras: 202925 - -Unknown-)
(@CGUID+32, 103151, 1539, 85, 7681, 4096, '0', 0, 0, 0, 2013.349, 2325.674, 77.84207, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- Effects Bunny (Area: -Unknown- - Difficulty: 12) (Auras: 202925 - -Unknown-)
(@CGUID+33, 103151, 1539, 85, 7681, 4096, '0', 0, 0, 0, 2012.635, 2349.957, 77.88901, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- Effects Bunny (Area: -Unknown- - Difficulty: 12) (Auras: 202925 - -Unknown-)
(@CGUID+34, 103151, 1539, 85, 7681, 4096, '0', 0, 0, 0, 1974.646, 2350.943, 78.05308, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- Effects Bunny (Area: -Unknown- - Difficulty: 12) (Auras: 202925 - -Unknown-)
(@CGUID+35, 103151, 1539, 85, 7681, 4096, '0', 0, 0, 0, 1975.302, 2322.498, 78.06256, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- Effects Bunny (Area: -Unknown- - Difficulty: 12) (Auras: 202925 - -Unknown-)
(@CGUID+36, 103151, 1539, 85, 7681, 4096, '0', 0, 0, 0, 1907.549, 2335.262, 75.70384, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- Effects Bunny (Area: -Unknown- - Difficulty: 12) (Auras: 204345 - -Unknown-)
(@CGUID+37, 101120, 1539, 85, 7978, 4096, '0', 0, 0, 0, 2042.96, 2325.189, 70.6383, 4.751894, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 血肉之子 (Area: -Unknown- - Difficulty: 12) (Auras: 34429 - -Unknown-)
(@CGUID+38, 101120, 1539, 85, 7978, 4096, '0', 0, 0, 0, 2042.538, 2322.583, 71.27046, 1.60554, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 血肉之子 (Area: -Unknown- - Difficulty: 12) (Auras: 34429 - -Unknown-)
(@CGUID+39, 101120, 1539, 85, 7978, 4096, '0', 0, 0, 0, 2042.381, 2328.106, 70.59363, 2.296371, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 血肉之子 (Area: -Unknown- - Difficulty: 12) (Auras: 34429 - -Unknown-)
(@CGUID+40, 101120, 1539, 85, 7978, 4096, '0', 0, 0, 0, 2041.587, 2326.344, 71.30777, 3.252892, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 血肉之子 (Area: -Unknown- - Difficulty: 12) (Auras: 34429 - -Unknown-)
(@CGUID+41, 101120, 1539, 85, 7978, 4096, '0', 0, 0, 0, 2043.892, 2352.619, 70.00777, 0.4638599, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 血肉之子 (Area: -Unknown- - Difficulty: 12) (Auras: 34429 - -Unknown-)
(@CGUID+42, 101120, 1539, 85, 7978, 4096, '0', 0, 0, 0, 2041.389, 2322.785, 71.74055, 0.1371602, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 血肉之子 (Area: -Unknown- - Difficulty: 12) (Auras: 34429 - -Unknown-)
(@CGUID+43, 101120, 1539, 85, 7978, 4096, '0', 0, 0, 0, 2041.132, 2348.721, 71.17515, 0.7551426, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 血肉之子 (Area: -Unknown- - Difficulty: 12) (Auras: 34429 - -Unknown-)
(@CGUID+44, 101120, 1539, 85, 7978, 4096, '0', 0, 0, 0, 2040.995, 2353.15, 71.50456, 5.729535, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 血肉之子 (Area: -Unknown- - Difficulty: 12) (Auras: 34429 - -Unknown-)
(@CGUID+45, 101120, 1539, 85, 7978, 4096, '0', 0, 0, 0, 2039.965, 2325.32, 71.81195, 4.137269, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 血肉之子 (Area: -Unknown- - Difficulty: 12) (Auras: 34429 - -Unknown-)
(@CGUID+46, 101120, 1539, 85, 7978, 4096, '0', 0, 0, 0, 2040.968, 2323.295, 71.74067, 0.1998825, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 血肉之子 (Area: -Unknown- - Difficulty: 12) (Auras: 34429 - -Unknown-)
(@CGUID+47, 101120, 1539, 85, 7978, 4096, '0', 0, 0, 0, 2038.93, 2346.66, 71.8903, 2.403741, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 血肉之子 (Area: -Unknown- - Difficulty: 12) (Auras: 34429 - -Unknown-)
(@CGUID+48, 101120, 1539, 85, 7978, 4096, '0', 0, 0, 0, 2038.8, 2347.92, 72.02583, 4.653935, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 血肉之子 (Area: -Unknown- - Difficulty: 12) (Auras: 34429 - -Unknown-)
(@CGUID+49, 101120, 1539, 85, 7978, 4096, '0', 0, 0, 0, 2041.285, 2320.731, 72.07221, 4.771214, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 血肉之子 (Area: -Unknown- - Difficulty: 12) (Auras: 34429 - -Unknown-)
(@CGUID+50, 101120, 1539, 85, 7978, 4096, '0', 0, 0, 0, 2040.397, 2347.665, 71.45305, 1.86109, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 血肉之子 (Area: -Unknown- - Difficulty: 12) (Auras: 34429 - -Unknown-)
(@CGUID+51, 101120, 1539, 85, 7978, 4096, '0', 0, 0, 0, 2038.314, 2347.089, 72.14603, 3.378751, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 血肉之子 (Area: -Unknown- - Difficulty: 12) (Auras: 34429 - -Unknown-)
(@CGUID+52, 101120, 1539, 85, 7978, 4096, '0', 0, 0, 0, 2039.937, 2327.526, 71.72593, 1.177831, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 血肉之子 (Area: -Unknown- - Difficulty: 12) (Auras: 34429 - -Unknown-)
(@CGUID+53, 101120, 1539, 85, 7978, 4096, '0', 0, 0, 0, 2038.348, 2349.558, 72.23657, 1.017918, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 血肉之子 (Area: -Unknown- - Difficulty: 12) (Auras: 34429 - -Unknown-)
(@CGUID+54, 101120, 1539, 85, 7978, 4096, '0', 0, 0, 0, 2037.782, 2343.688, 72.27098, 1.463283, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 血肉之子 (Area: -Unknown- - Difficulty: 12) (Auras: 34429 - -Unknown-)
(@CGUID+55, 101120, 1539, 85, 7978, 4096, '0', 0, 0, 0, 2024.471, 2339.12, 75.3027, 3.498015, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 血肉之子 (Area: -Unknown- - Difficulty: 12) (Auras: 34429 - -Unknown-)
(@CGUID+56, 101120, 1539, 85, 7978, 4096, '0', 0, 0, 0, 2022.109, 2357.753, 75.72289, 5.075116, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 血肉之子 (Area: -Unknown- - Difficulty: 12) (Auras: 34429 - -Unknown-)
(@CGUID+57, 101120, 1539, 85, 7978, 4096, '0', 0, 0, 0, 2021.232, 2360.343, 76.04662, 4.549811, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 血肉之子 (Area: -Unknown- - Difficulty: 12) (Auras: 34429 - -Unknown-)
(@CGUID+58, 101120, 1539, 85, 7978, 4096, '0', 0, 0, 0, 2024.959, 2335.282, 75.29901, 2.014057, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 血肉之子 (Area: -Unknown- - Difficulty: 12) (Auras: 34429 - -Unknown-)
(@CGUID+59, 101120, 1539, 85, 7978, 4096, '0', 0, 0, 0, 2025.135, 2311.839, 76.02517, 5.852931, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 血肉之子 (Area: -Unknown- - Difficulty: 12) (Auras: 34429 - -Unknown-)
(@CGUID+60, 101120, 1539, 85, 7978, 4096, '0', 0, 0, 0, 2025.132, 2364.089, 75.87653, 0.6443775, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 血肉之子 (Area: -Unknown- - Difficulty: 12) (Auras: 34429 - -Unknown-)
(@CGUID+61, 101120, 1539, 85, 7978, 4096, '0', 0, 0, 0, 2025.436, 2336.813, 75.29121, 3.040614, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 血肉之子 (Area: -Unknown- - Difficulty: 12) (Auras: 34429 - -Unknown-)
(@CGUID+62, 101120, 1539, 85, 7978, 4096, '0', 0, 0, 0, 2023.413, 2318.334, 75.60072, 3.035289, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 血肉之子 (Area: -Unknown- - Difficulty: 12) (Auras: 34429 - -Unknown-)
(@CGUID+63, 101120, 1539, 85, 7978, 4096, '0', 0, 0, 0, 2019.669, 2361.717, 76.04662, 2.734824, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 血肉之子 (Area: -Unknown- - Difficulty: 12) (Auras: 34429 - -Unknown-)
(@CGUID+64, 101120, 1539, 85, 7978, 4096, '0', 0, 0, 0, 2025.782, 2314.211, 75.67527, 1.929567, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 血肉之子 (Area: -Unknown- - Difficulty: 12) (Auras: 34429 - -Unknown-)
(@CGUID+65, 101120, 1539, 85, 7978, 4096, '0', 0, 0, 0, 2022.751, 2366.444, 76.04662, 1.324765, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 血肉之子 (Area: -Unknown- - Difficulty: 12) (Auras: 34429 - -Unknown-)
(@CGUID+66, 101120, 1539, 85, 7978, 4096, '0', 0, 0, 0, 2024.272, 2337.733, 75.30654, 4.721408, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 血肉之子 (Area: -Unknown- - Difficulty: 12) (Auras: 34429 - -Unknown-)
(@CGUID+67, 101120, 1539, 85, 7978, 4096, '0', 0, 0, 0, 2024.844, 2310.201, 75.97712, 1.30195, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 血肉之子 (Area: -Unknown- - Difficulty: 12) (Auras: 34429 - -Unknown-)
(@CGUID+68, 101120, 1539, 85, 7978, 4096, '0', 0, 0, 0, 2022.028, 2316.607, 76.04662, 2.038995, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 血肉之子 (Area: -Unknown- - Difficulty: 12) (Auras: 34429 - -Unknown-)
(@CGUID+69, 101120, 1539, 85, 7978, 4096, '0', 0, 0, 0, 2019.007, 2360.768, 76.04662, 4.103871, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 血肉之子 (Area: -Unknown- - Difficulty: 12) (Auras: 34429 - -Unknown-)
(@CGUID+70, 101114, 1539, 85, 7978, 4096, '0', 0, 0, 0, 2010.783, 2337.809, 75.63125, 3.241742, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 无面镇压者 (Area: -Unknown- - Difficulty: 12) (Auras: 206899 - -Unknown-)
(@CGUID+71, 101120, 1539, 85, 7978, 4096, '0', 0, 0, 0, 2019.03, 2361.456, 76.04662, 4.073328, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 血肉之子 (Area: -Unknown- - Difficulty: 12) (Auras: 34429 - -Unknown-)
(@CGUID+72, 101120, 1539, 85, 7978, 4096, '0', 0, 0, 0, 2025.917, 2339.929, 75.2821, 2.783979, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 血肉之子 (Area: -Unknown- - Difficulty: 12) (Auras: 34429 - -Unknown-)
(@CGUID+73, 101120, 1539, 85, 7978, 4096, '0', 0, 0, 0, 2020.436, 2359.946, 75.97851, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 血肉之子 (Area: -Unknown- - Difficulty: 12) (Auras: 34429 - -Unknown-)
(@CGUID+74, 101120, 1539, 85, 7978, 4096, '0', 0, 0, 0, 2021.716, 2335.793, 75.34338, 0.4657371, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 血肉之子 (Area: -Unknown- - Difficulty: 12) (Auras: 34429 - -Unknown-)
(@CGUID+75, 101120, 1539, 85, 7978, 4096, '0', 0, 0, 0, 2023.658, 2341.79, 75.31181, 4.831481, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 血肉之子 (Area: -Unknown- - Difficulty: 12) (Auras: 34429 - -Unknown-)
(@CGUID+76, 101120, 1539, 85, 7978, 4096, '0', 0, 0, 0, 2022.651, 2359.258, 75.72849, 5.955913, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 血肉之子 (Area: -Unknown- - Difficulty: 12) (Auras: 34429 - -Unknown-)
(@CGUID+77, 101120, 1539, 85, 7978, 4096, '0', 0, 0, 0, 2022.956, 2335.458, 75.32652, 3.02923, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 血肉之子 (Area: -Unknown- - Difficulty: 12) (Auras: 34429 - -Unknown-)
(@CGUID+78, 101120, 1539, 85, 7978, 4096, '0', 0, 0, 0, 2020.551, 2336.913, 75.35857, 0.6356313, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 血肉之子 (Area: -Unknown- - Difficulty: 12) (Auras: 34429 - -Unknown-)
(@CGUID+79, 101120, 1539, 85, 7978, 4096, '0', 0, 0, 0, 2022.347, 2313.594, 76.04662, 4.405847, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 血肉之子 (Area: -Unknown- - Difficulty: 12) (Auras: 34429 - -Unknown-)
(@CGUID+80, 101120, 1539, 85, 7978, 4096, '0', 0, 0, 0, 2019.222, 2314.423, 76.04662, 6.244098, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 血肉之子 (Area: -Unknown- - Difficulty: 12) (Auras: 34429 - -Unknown-)
(@CGUID+81, 101120, 1539, 85, 7978, 4096, '0', 0, 0, 0, 2021.102, 2314.167, 76.04662, 6.230104, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 血肉之子 (Area: -Unknown- - Difficulty: 12) (Auras: 34429 - -Unknown-)
(@CGUID+82, 101120, 1539, 85, 7978, 4096, '0', 0, 0, 0, 2020.443, 2314.552, 76.04662, 2.041847, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 血肉之子 (Area: -Unknown- - Difficulty: 12) (Auras: 34429 - -Unknown-)
(@CGUID+83, 51965, 1539, 85, 7978, 4096, '0', 0, 0, 0, 1988.548, 2360.091, 127.8028, 2.277007, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 提瑞斯法小鹿 (Area: -Unknown- - Difficulty: 12) (Auras: )
(@CGUID+84, 51964, 1539, 85, 7978, 4096, '0', 0, 0, 0, 1987.316, 2353.567, 126.0513, 2.181688, 7200, 10, 0, 0, 0, 1, 0, 0, 0, 22594), -- 提瑞斯法雌鹿 (Area: -Unknown- - Difficulty: 12) (Auras: ) (possible waypoints or random movement)
(@CGUID+85, 51965, 1539, 85, 7978, 4096, '0', 0, 0, 0, 1987.039, 2357.407, 127.4576, 2.222054, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 提瑞斯法小鹿 (Area: -Unknown- - Difficulty: 12) (Auras: )
(@CGUID+86, 51964, 1539, 85, 7978, 4096, '0', 0, 0, 0, 1975.462, 2362.947, 131.4355, 2.498374, 7200, 10, 0, 0, 0, 1, 0, 0, 0, 22594), -- 提瑞斯法雌鹿 (Area: -Unknown- - Difficulty: 12) (Auras: ) (possible waypoints or random movement)
(@CGUID+87, 104583, 1539, 85, 7978, 4096, '0', 0, 0, 0, 1950.891, 2350.406, 79.23569, 5.561185, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 虚空触须 (Area: -Unknown- - Difficulty: 12) (Auras: 196285 - -Unknown-)
(@CGUID+88, 104583, 1539, 85, 7978, 4096, '0', 0, 0, 0, 1951.63, 2321.931, 79.37769, 1.624161, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 虚空触须 (Area: -Unknown- - Difficulty: 12) (Auras: 196285 - -Unknown-)
(@CGUID+89, 104583, 1539, 85, 7978, 4096, '0', 0, 0, 0, 1974.701, 2350.92, 79.28799, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 虚空触须 (Area: -Unknown- - Difficulty: 12) (Auras: 196285 - -Unknown-)
(@CGUID+90, 104583, 1539, 85, 7978, 4096, '0', 0, 0, 0, 1975.359, 2322.503, 79.27341, 3.708907, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 虚空触须 (Area: -Unknown- - Difficulty: 12) (Auras: 196285 - -Unknown-)
(@CGUID+91, 51961, 1539, 85, 7978, 4096, '0', 0, 0, 0, 1906.667, 2330.361, 132.6658, 6.008372, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 提瑞斯法雄鹿 (Area: -Unknown- - Difficulty: 12) (Auras: )
(@CGUID+92, 51964, 1539, 85, 7978, 4096, '0', 0, 0, 0, 1972.39, 2248.915, 135.7614, 0.5405869, 7200, 10, 0, 0, 0, 1, 0, 0, 0, 22594), -- 提瑞斯法雌鹿 (Area: -Unknown- - Difficulty: 12) (Auras: ) (possible waypoints or random movement)
(@CGUID+93, 51965, 1539, 85, 7978, 4096, '0', 0, 0, 0, 1963.959, 2246.754, 137.6229, 0.398996, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 提瑞斯法小鹿 (Area: -Unknown- - Difficulty: 12) (Auras: )
(@CGUID+94, 51965, 1539, 85, 7978, 4096, '0', 0, 0, 0, 1967.591, 2244.713, 137.084, 0.4911636, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 提瑞斯法小鹿 (Area: -Unknown- - Difficulty: 12) (Auras: )
(@CGUID+95, 103151, 1539, 85, 7978, 4096, '0', 0, 0, 0, 1962.698, 2336.349, 80.3631, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- Effects Bunny (Area: -Unknown- - Difficulty: 12)
(@CGUID+96, 103226, 1539, 85, 7978, 4096, '0', 0, 0, 0, 1962.637, 2336.55, 80.3631, 3.16063, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 守护者索斯奥兹 (Area: -Unknown- - Difficulty: 12) (Auras: )
(@CGUID+97, 101120, 1539, 85, 7978, 4096, '0', 0, 0, 0, 1863.877, 2334.497, 50.46243, 3.375036, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 血肉之子 (Area: -Unknown- - Difficulty: 12) (Auras: 34429 - -Unknown-)
(@CGUID+98, 103398, 1539, 85, 7978, 4096, '0', 0, 0, 0, 1882.179, 2163.353, 35.92474, 2.002052, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 腐蚀者扎卡兹 (Area: -Unknown- - Difficulty: 12) (Auras: 163090 - -Unknown-)
(@CGUID+99, 101120, 1539, 85, 7978, 4096, '0', 0, 0, 0, 1869.184, 2330.752, 49.0212, 4.88434, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 血肉之子 (Area: -Unknown- - Difficulty: 12) (Auras: 34429 - -Unknown-)
(@CGUID+100, 101120, 1539, 85, 7978, 4096, '0', 0, 0, 0, 1881.019, 2336.587, 53.0024, 4.757432, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 血肉之子 (Area: -Unknown- - Difficulty: 12) (Auras: 34429 - -Unknown-)
(@CGUID+101, 101120, 1539, 85, 7978, 4096, '0', 0, 0, 0, 1874.004, 2334.859, 50.26377, 5.298792, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 血肉之子 (Area: -Unknown- - Difficulty: 12) (Auras: 34429 - -Unknown-)
(@CGUID+102, 101120, 1539, 85, 7978, 4096, '0', 0, 0, 0, 1881.089, 2328.635, 51.74957, 5.405564, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 血肉之子 (Area: -Unknown- - Difficulty: 12) (Auras: 34429 - -Unknown-)
(@CGUID+103, 101120, 1539, 85, 7978, 4096, '0', 0, 0, 0, 1874.198, 2327.738, 49.94025, 1.057476, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 血肉之子 (Area: -Unknown- - Difficulty: 12) (Auras: 34429 - -Unknown-)
(@CGUID+104, 101120, 1539, 85, 7978, 4096, '0', 0, 0, 0, 1862.26, 2328.889, 48.82635, 3.886318, 7200, 10, 0, 0, 0, 1, 0, 0, 0, 22594), -- 血肉之子 (Area: -Unknown- - Difficulty: 12) (Auras: 34429 - -Unknown-) (possible waypoints or random movement)
(@CGUID+105, 101120, 1539, 85, 7978, 4096, '0', 0, 0, 0, 1863.198, 2324.523, 48.95365, 4.009132, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 血肉之子 (Area: -Unknown- - Difficulty: 12) (Auras: 34429 - -Unknown-)
(@CGUID+106, 101120, 1539, 85, 7978, 4096, '0', 0, 0, 0, 1884.519, 2335.514, 54.24805, 1.909189, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 血肉之子 (Area: -Unknown- - Difficulty: 12) (Auras: 34429 - -Unknown-)
(@CGUID+107, 101120, 1539, 85, 7978, 4096, '0', 0, 0, 0, 1878.122, 2333.247, 50.73741, 3.221937, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 血肉之子 (Area: -Unknown- - Difficulty: 12) (Auras: 34429 - -Unknown-)
(@CGUID+108, 101120, 1539, 85, 7978, 4096, '0', 0, 0, 0, 1885.84, 2331.524, 54.38757, 2.119061, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 血肉之子 (Area: -Unknown- - Difficulty: 12) (Auras: 34429 - -Unknown-)
(@CGUID+109, 101120, 1539, 85, 7978, 4096, '0', 0, 0, 0, 1877.734, 2329.943, 50.67208, 3.267135, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 血肉之子 (Area: -Unknown- - Difficulty: 12) (Auras: 34429 - -Unknown-)
(@CGUID+110, 101120, 1539, 85, 7978, 4096, '0', 0, 0, 0, 1882.941, 2332.464, 52.6153, 3.047902, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 血肉之子 (Area: -Unknown- - Difficulty: 12) (Auras: 34429 - -Unknown-)
(@CGUID+111, 101114, 1539, 85, 7978, 4096, '0', 0, 0, 0, 1856.863, 2323.913, 47.9398, 0.6494821, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 无面镇压者 (Area: -Unknown- - Difficulty: 12) (Auras: 206899 - -Unknown-)
(@CGUID+112, 51961, 1539, 85, 7978, 4096, '0', 0, 0, 0, 1871.748, 2401.5, 130.9309, 2.342591, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 提瑞斯法雄鹿 (Area: -Unknown- - Difficulty: 12) (Auras: )
(@CGUID+113, 103339, 1539, 85, 7978, 4096, '0', 0, 0, 0, 1815.318, 2291.549, 45.45652, 0.6974968, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 无面幻术师 (Area: -Unknown- - Difficulty: 12) (Auras: )
(@CGUID+114, 109127, 1539, 85, 7978, 4096, '0', 0, 0, 0, 1879.773, 2203.62, 38.24985, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 占位符 (Area: -Unknown- - Difficulty: 12)
(@CGUID+115, 96569, 1539, 85, 7978, 4096, '0', 0, 0, 0, 1880.094, 2210.292, 38.1934, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 时空裂痕 (Area: -Unknown- - Difficulty: 12)
(@CGUID+116, 96569, 1539, 85, 7978, 4096, '0', 0, 0, 0, 1893.943, 2209.474, 38.59758, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 时空裂痕 (Area: -Unknown- - Difficulty: 12) (Auras: 207114 - -Unknown-)
(@CGUID+117, 96569, 1539, 85, 7978, 4096, '0', 0, 0, 0, 1849.509, 2200.429, 39.56246, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 时空裂痕 (Area: -Unknown- - Difficulty: 12) (Auras: 207114 - -Unknown-)
(@CGUID+118, 96569, 1539, 85, 7978, 4096, '0', 0, 0, 0, 1889.347, 2196.674, 37.94201, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 时空裂痕 (Area: -Unknown- - Difficulty: 12)
(@CGUID+119, 96569, 1539, 85, 7978, 4096, '0', 0, 0, 0, 1869.01, 2211.155, 37.96517, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 时空裂痕 (Area: -Unknown- - Difficulty: 12)
(@CGUID+120, 96569, 1539, 85, 7978, 4096, '0', 0, 0, 0, 1863.109, 2199.104, 38.48477, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 时空裂痕 (Area: -Unknown- - Difficulty: 12)
(@CGUID+121, 96569, 1539, 85, 7978, 4096, '0', 0, 0, 0, 1880.332, 2182.747, 35.92474, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 时空裂痕 (Area: -Unknown- - Difficulty: 12)
(@CGUID+122, 96569, 1539, 85, 7978, 4096, '0', 0, 0, 0, 1860.569, 2185.54, 37.46564, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 时空裂痕 (Area: -Unknown- - Difficulty: 12)
(@CGUID+123, 96569, 1539, 85, 7978, 4096, '0', 0, 0, 0, 1877.835, 2195.05, 37.5492, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 时空裂痕 (Area: -Unknown- - Difficulty: 12) (Auras: 207114 - -Unknown-)
(@CGUID+124, 96569, 1539, 85, 7978, 4096, '0', 0, 0, 0, 1883.91, 2165.918, 35.92473, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 时空裂痕 (Area: -Unknown- - Difficulty: 12)
(@CGUID+125, 96569, 1539, 85, 7978, 4096, '0', 0, 0, 0, 1864.859, 2161.741, 36.78588, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 时空裂痕 (Area: -Unknown- - Difficulty: 12)
(@CGUID+126, 96569, 1539, 85, 7978, 4096, '0', 0, 0, 0, 1870.156, 2173.401, 35.92474, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 时空裂痕 (Area: -Unknown- - Difficulty: 12) (Auras: 207114 - -Unknown-)
(@CGUID+127, 96569, 1539, 85, 7978, 4096, '0', 0, 0, 0, 1894.63, 2181.392, 37.13327, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 时空裂痕 (Area: -Unknown- - Difficulty: 12) (Auras: 207114 - -Unknown-)
(@CGUID+128, 96569, 1539, 85, 7978, 4096, '0', 0, 0, 0, 1889.946, 2158.095, 37.17652, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 时空裂痕 (Area: -Unknown- - Difficulty: 12)
(@CGUID+129, 96569, 1539, 85, 7978, 4096, '0', 0, 0, 0, 1897.915, 2168.656, 37.47842, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594), -- 时空裂痕 (Area: -Unknown- - Difficulty: 12)
(@CGUID+130, 93819, 1539, 85, 7978, 3, '6844', 0, 0, 0, 1880.13, 2198.05, 43.56908, 2.715542, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 22594); -- 奥丁的瓦格里 (Area: -Unknown- - Difficulty: 12)

DELETE FROM `creature_addon` WHERE `guid` BETWEEN @CGUID+0 AND @CGUID+130;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `auras`) VALUES
(@CGUID+0, 0, 0, 0, 1, 0, 730, 0, 0, '211453'), -- 腐蚀者扎卡兹 - 211453 - -Unknown-
(@CGUID+1, 0, 0, 50331648, 1, 0, 0, 0, 0, ''), -- 气息追踪者
(@CGUID+2, 0, 0, 50331648, 1, 0, 0, 0, 0, ''), -- 气息追踪者
(@CGUID+3, 0, 0, 50331648, 1, 0, 0, 0, 0, ''), -- 气息追踪者
(@CGUID+4, 0, 0, 50331648, 1, 0, 0, 0, 0, ''), -- 气息追踪者
(@CGUID+5, 0, 0, 50331648, 1, 0, 0, 0, 0, ''), -- 气息追踪者
(@CGUID+6, 0, 0, 50331648, 1, 0, 0, 0, 0, ''), -- 气息追踪者
(@CGUID+7, 0, 0, 50331648, 1, 0, 0, 0, 0, ''), -- 气息追踪者
(@CGUID+8, 0, 0, 50331648, 1, 0, 0, 0, 0, ''), -- 气息追踪者
(@CGUID+9, 0, 0, 50331648, 1, 0, 0, 0, 0, ''), -- 气息追踪者
(@CGUID+10, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 索拉丁
(@CGUID+11, 0, 0, 0, 1, 0, 0, 0, 0, '63048'), -- Effects Bunny - 63048 - -Unknown-

(@CGUID+12, 0, 0, 33554432, 1, 0, 0, 0, 0, '204093'), -- 索拉丁 - 204093 - -Unknown-
(@CGUID+13, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- Effects Bunny
(@CGUID+14, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- Effects Bunny
(@CGUID+15, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- Effects Bunny
(@CGUID+16, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 暮光折剑者
(@CGUID+17, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 暮光折剑者
(@CGUID+18, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 提瑞斯法雌鹿
(@CGUID+19, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 暮光折剑者
(@CGUID+20, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 提瑞斯法雄鹿
(@CGUID+21, 0, 0, 8, 0, 0, 0, 0, 0, ''), -- 暮光暗影法师
(@CGUID+22, 0, 0, 0, 1, 0, 0, 0, 0, '34429'), -- 暮光祭师 - 34429 - -Unknown-
(@CGUID+23, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 暮光折剑者
(@CGUID+24, 0, 0, 0, 1, 0, 0, 0, 0, '34429'), -- 暮光祭师 - 34429 - -Unknown-
(@CGUID+25, 0, 0, 0, 1, 0, 0, 0, 0, '34429'), -- 暮光祭师 - 34429 - -Unknown-
(@CGUID+26, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 暮光折剑者
(@CGUID+27, 0, 0, 0, 0, 0, 0, 0, 0, ''), -- 暮光暗影法师
(@CGUID+28, 0, 0, 0, 0, 0, 0, 0, 0, ''), -- 暮光暗影法师
(@CGUID+29, 0, 0, 0, 0, 0, 0, 0, 0, ''), -- 暮光暗影法师
(@CGUID+30, 0, 0, 0, 1, 0, 0, 0, 0, '202925'), -- Effects Bunny - 202925 - -Unknown-
(@CGUID+31, 0, 0, 0, 1, 0, 0, 0, 0, '202925'), -- Effects Bunny - 202925 - -Unknown-
(@CGUID+32, 0, 0, 0, 1, 0, 0, 0, 0, '202925'), -- Effects Bunny - 202925 - -Unknown-
(@CGUID+33, 0, 0, 0, 1, 0, 0, 0, 0, '202925'), -- Effects Bunny - 202925 - -Unknown-
(@CGUID+34, 0, 0, 0, 1, 0, 0, 0, 0, '202925'), -- Effects Bunny - 202925 - -Unknown-
(@CGUID+35, 0, 0, 0, 1, 0, 0, 0, 0, '202925'), -- Effects Bunny - 202925 - -Unknown-
(@CGUID+36, 0, 0, 0, 1, 0, 0, 0, 0, '204345'), -- Effects Bunny - 204345 - -Unknown-
(@CGUID+37, 0, 0, 0, 1, 0, 0, 0, 0, '34429'), -- 血肉之子 - 34429 - -Unknown-
(@CGUID+38, 0, 0, 0, 1, 0, 0, 0, 0, '34429'), -- 血肉之子 - 34429 - -Unknown-
(@CGUID+39, 0, 0, 0, 1, 0, 0, 0, 0, '34429'), -- 血肉之子 - 34429 - -Unknown-
(@CGUID+40, 0, 0, 0, 1, 0, 0, 0, 0, '34429'), -- 血肉之子 - 34429 - -Unknown-
(@CGUID+41, 0, 0, 0, 1, 0, 0, 0, 0, '34429'), -- 血肉之子 - 34429 - -Unknown-
(@CGUID+42, 0, 0, 0, 1, 0, 0, 0, 0, '34429'), -- 血肉之子 - 34429 - -Unknown-
(@CGUID+43, 0, 0, 0, 1, 0, 0, 0, 0, '34429'), -- 血肉之子 - 34429 - -Unknown-
(@CGUID+44, 0, 0, 0, 1, 0, 0, 0, 0, '34429'), -- 血肉之子 - 34429 - -Unknown-
(@CGUID+45, 0, 0, 0, 1, 0, 0, 0, 0, '34429'), -- 血肉之子 - 34429 - -Unknown-
(@CGUID+46, 0, 0, 0, 1, 0, 0, 0, 0, '34429'), -- 血肉之子 - 34429 - -Unknown-
(@CGUID+47, 0, 0, 0, 1, 0, 0, 0, 0, '34429'), -- 血肉之子 - 34429 - -Unknown-
(@CGUID+48, 0, 0, 0, 1, 0, 0, 0, 0, '34429'), -- 血肉之子 - 34429 - -Unknown-
(@CGUID+49, 0, 0, 0, 1, 0, 0, 0, 0, '34429'), -- 血肉之子 - 34429 - -Unknown-
(@CGUID+50, 0, 0, 0, 1, 0, 0, 0, 0, '34429'), -- 血肉之子 - 34429 - -Unknown-
(@CGUID+51, 0, 0, 0, 1, 0, 0, 0, 0, '34429'), -- 血肉之子 - 34429 - -Unknown-
(@CGUID+52, 0, 0, 0, 1, 0, 0, 0, 0, '34429'), -- 血肉之子 - 34429 - -Unknown-
(@CGUID+53, 0, 0, 0, 1, 0, 0, 0, 0, '34429'), -- 血肉之子 - 34429 - -Unknown-
(@CGUID+54, 0, 0, 0, 1, 0, 0, 0, 0, '34429'), -- 血肉之子 - 34429 - -Unknown-
(@CGUID+55, 0, 0, 0, 1, 0, 0, 0, 0, '34429'), -- 血肉之子 - 34429 - -Unknown-
(@CGUID+56, 0, 0, 0, 1, 0, 0, 0, 0, '34429'), -- 血肉之子 - 34429 - -Unknown-
(@CGUID+57, 0, 0, 0, 1, 0, 0, 0, 0, '34429'), -- 血肉之子 - 34429 - -Unknown-
(@CGUID+58, 0, 0, 0, 1, 0, 0, 0, 0, '34429'), -- 血肉之子 - 34429 - -Unknown-
(@CGUID+59, 0, 0, 0, 1, 0, 0, 0, 0, '34429'), -- 血肉之子 - 34429 - -Unknown-
(@CGUID+60, 0, 0, 0, 1, 0, 0, 0, 0, '34429'), -- 血肉之子 - 34429 - -Unknown-
(@CGUID+61, 0, 0, 0, 1, 0, 0, 0, 0, '34429'), -- 血肉之子 - 34429 - -Unknown-
(@CGUID+62, 0, 0, 0, 1, 0, 0, 0, 0, '34429'), -- 血肉之子 - 34429 - -Unknown-
(@CGUID+63, 0, 0, 0, 1, 0, 0, 0, 0, '34429'), -- 血肉之子 - 34429 - -Unknown-
(@CGUID+64, 0, 0, 0, 1, 0, 0, 0, 0, '34429'), -- 血肉之子 - 34429 - -Unknown-
(@CGUID+65, 0, 0, 0, 1, 0, 0, 0, 0, '34429'), -- 血肉之子 - 34429 - -Unknown-
(@CGUID+66, 0, 0, 0, 1, 0, 0, 0, 0, '34429'), -- 血肉之子 - 34429 - -Unknown-
(@CGUID+67, 0, 0, 0, 1, 0, 0, 0, 0, '34429'), -- 血肉之子 - 34429 - -Unknown-
(@CGUID+68, 0, 0, 0, 1, 0, 0, 0, 0, '34429'), -- 血肉之子 - 34429 - -Unknown-
(@CGUID+69, 0, 0, 0, 1, 0, 0, 0, 0, '34429'), -- 血肉之子 - 34429 - -Unknown-
(@CGUID+70, 0, 0, 0, 1, 0, 0, 0, 0, '206899'), -- 无面镇压者 - 206899 - -Unknown-
(@CGUID+71, 0, 0, 0, 1, 0, 0, 0, 0, '34429'), -- 血肉之子 - 34429 - -Unknown-
(@CGUID+72, 0, 0, 0, 1, 0, 0, 0, 0, '34429'), -- 血肉之子 - 34429 - -Unknown-
(@CGUID+73, 0, 0, 0, 1, 0, 0, 0, 0, '34429'), -- 血肉之子 - 34429 - -Unknown-
(@CGUID+74, 0, 0, 0, 1, 0, 0, 0, 0, '34429'), -- 血肉之子 - 34429 - -Unknown-
(@CGUID+75, 0, 0, 0, 1, 0, 0, 0, 0, '34429'), -- 血肉之子 - 34429 - -Unknown-
(@CGUID+76, 0, 0, 0, 1, 0, 0, 0, 0, '34429'), -- 血肉之子 - 34429 - -Unknown-
(@CGUID+77, 0, 0, 0, 1, 0, 0, 0, 0, '34429'), -- 血肉之子 - 34429 - -Unknown-
(@CGUID+78, 0, 0, 0, 1, 0, 0, 0, 0, '34429'), -- 血肉之子 - 34429 - -Unknown-
(@CGUID+79, 0, 0, 0, 1, 0, 0, 0, 0, '34429'), -- 血肉之子 - 34429 - -Unknown-
(@CGUID+80, 0, 0, 0, 1, 0, 0, 0, 0, '34429'), -- 血肉之子 - 34429 - -Unknown-
(@CGUID+81, 0, 0, 0, 1, 0, 0, 0, 0, '34429'), -- 血肉之子 - 34429 - -Unknown-
(@CGUID+82, 0, 0, 0, 1, 0, 0, 0, 0, '34429'), -- 血肉之子 - 34429 - -Unknown-
(@CGUID+83, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 提瑞斯法小鹿
(@CGUID+84, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 提瑞斯法雌鹿
(@CGUID+85, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 提瑞斯法小鹿
(@CGUID+86, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 提瑞斯法雌鹿
(@CGUID+87, 0, 0, 0, 1, 0, 0, 0, 0, '196285'), -- 虚空触须 - 196285 - -Unknown-
(@CGUID+88, 0, 0, 0, 1, 0, 0, 0, 0, '196285'), -- 虚空触须 - 196285 - -Unknown-
(@CGUID+89, 0, 0, 0, 1, 0, 0, 0, 0, '196285'), -- 虚空触须 - 196285 - -Unknown-
(@CGUID+90, 0, 0, 0, 1, 0, 0, 0, 0, '196285'), -- 虚空触须 - 196285 - -Unknown-
(@CGUID+91, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 提瑞斯法雄鹿
(@CGUID+92, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 提瑞斯法雌鹿
(@CGUID+93, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 提瑞斯法小鹿
(@CGUID+94, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 提瑞斯法小鹿
(@CGUID+95, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- Effects Bunny
(@CGUID+96, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 守护者索斯奥兹
(@CGUID+97, 0, 0, 0, 1, 0, 0, 0, 0, '34429'), -- 血肉之子 - 34429 - -Unknown-
(@CGUID+98, 0, 0, 262144, 1, 0, 0, 0, 0, '163090'), -- 腐蚀者扎卡兹 - 163090 - -Unknown-
(@CGUID+99, 0, 0, 0, 1, 0, 0, 0, 0, '34429'), -- 血肉之子 - 34429 - -Unknown-
(@CGUID+100, 0, 0, 0, 1, 0, 0, 0, 0, '34429'), -- 血肉之子 - 34429 - -Unknown-
(@CGUID+101, 0, 0, 0, 1, 0, 0, 0, 0, '34429'), -- 血肉之子 - 34429 - -Unknown-
(@CGUID+102, 0, 0, 0, 1, 0, 0, 0, 0, '34429'), -- 血肉之子 - 34429 - -Unknown-
(@CGUID+103, 0, 0, 0, 1, 0, 0, 0, 0, '34429'), -- 血肉之子 - 34429 - -Unknown-
(@CGUID+104, 0, 0, 0, 1, 0, 0, 0, 0, '34429'), -- 血肉之子 - 34429 - -Unknown-
(@CGUID+105, 0, 0, 0, 1, 0, 0, 0, 0, '34429'), -- 血肉之子 - 34429 - -Unknown-
(@CGUID+106, 0, 0, 0, 1, 0, 0, 0, 0, '34429'), -- 血肉之子 - 34429 - -Unknown-
(@CGUID+107, 0, 0, 0, 1, 0, 0, 0, 0, '34429'), -- 血肉之子 - 34429 - -Unknown-
(@CGUID+108, 0, 0, 0, 1, 0, 0, 0, 0, '34429'), -- 血肉之子 - 34429 - -Unknown-
(@CGUID+109, 0, 0, 0, 1, 0, 0, 0, 0, '34429'), -- 血肉之子 - 34429 - -Unknown-
(@CGUID+110, 0, 0, 0, 1, 0, 0, 0, 0, '34429'), -- 血肉之子 - 34429 - -Unknown-
(@CGUID+111, 0, 0, 0, 1, 0, 0, 0, 0, '206899'), -- 无面镇压者 - 206899 - -Unknown-
(@CGUID+112, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 提瑞斯法雄鹿
(@CGUID+113, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 无面幻术师
(@CGUID+114, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 占位符
(@CGUID+115, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 时空裂痕
(@CGUID+116, 0, 0, 0, 1, 0, 0, 0, 0, '207114'), -- 时空裂痕 - 207114 - -Unknown-
(@CGUID+117, 0, 0, 0, 1, 0, 0, 0, 0, '207114'), -- 时空裂痕 - 207114 - -Unknown-
(@CGUID+118, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 时空裂痕
(@CGUID+119, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 时空裂痕
(@CGUID+120, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 时空裂痕
(@CGUID+121, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 时空裂痕
(@CGUID+122, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 时空裂痕
(@CGUID+123, 0, 0, 0, 1, 0, 0, 0, 0, '207114'), -- 时空裂痕 - 207114 - -Unknown-
(@CGUID+124, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 时空裂痕
(@CGUID+125, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 时空裂痕
(@CGUID+126, 0, 0, 0, 1, 0, 0, 0, 0, '207114'), -- 时空裂痕 - 207114 - -Unknown-
(@CGUID+127, 0, 0, 0, 1, 0, 0, 0, 0, '207114'), -- 时空裂痕 - 207114 - -Unknown-
(@CGUID+128, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 时空裂痕
(@CGUID+129, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 时空裂痕
(@CGUID+130, 0, 0, 50331648, 1, 0, 0, 0, 0, ''); -- 奥丁的瓦格里

SET @OGUID = 100793;
DELETE FROM `gameobject` WHERE `guid` BETWEEN @OGUID+0 AND @OGUID+19;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `PhaseId`, `PhaseGroup`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`) VALUES
(@OGUID+19, 247492, 1500, 7796, 7796, 4096, '6815', 0, -2007.17, -1307.54, 12.8153, 0.852474, 0, 0, 0.4134474, 0.910528, 7200, 255, 1, 26124), -- Legion Portal (Area: -Unknown- - Difficulty: 0)
(@OGUID+0, 243491, 1500, 7796, 7796, 4096, '0', 0, -2244.385, -1274.816, 79.87719, 1.043926, 0, 0, 0.4985828, 0.866842, 7200, 255, 1, 22594), -- -Unknown- (Area: -Unknown- - Difficulty: 1)
(@OGUID+1, 243491, 1500, 7796, 7796, 4096, '0', 0, -2256.976, -1002.054, 50.45898, 5.651232, 0, 0, -0.3107452, 0.9504932, 7200, 255, 1, 22594), -- -Unknown- (Area: -Unknown- - Difficulty: 1)
(@OGUID+2, 251429, 1539, 85, 7978, 4096, '0', 0, 1890.184, 2231.009, -82.21384, 4.83199, 0, 0, -0.6635828, 0.7481028, 7200, 255, 1, 22594), -- 浓雾 (Area: -Unknown- - Difficulty: 12)
(@OGUID+3, 251429, 1539, 85, 7978, 4096, '0', 0, 1890.184, 2231.009, -75.88976, 4.83199, 0, 0, -0.6635828, 0.7481028, 7200, 255, 1, 22594), -- 浓雾 (Area: -Unknown- - Difficulty: 12)
(@OGUID+4, 251429, 1539, 85, 7978, 4096, '0', 0, 1891.597, 2236.116, -82.23755, 4.83199, 0, 0, -0.6635828, 0.7481028, 7200, 255, 1, 22594), -- 浓雾 (Area: -Unknown- - Difficulty: 12)
(@OGUID+5, 251429, 1539, 85, 7978, 4096, '0', 0, 1871.792, 2232.649, -75.90102, 5.084545, 0, 0, -0.5640812, 0.8257193, 7200, 255, 1, 22594), -- 浓雾 (Area: -Unknown- - Difficulty: 12)
(@OGUID+6, 251429, 1539, 85, 7978, 4096, '0', 0, 1871.792, 2232.649, -82.2251, 5.084545, 0, 0, -0.5640812, 0.8257193, 7200, 255, 1, 22594), -- 浓雾 (Area: -Unknown- - Difficulty: 12)
(@OGUID+7, 251429, 1539, 85, 7978, 4096, '0', 0, 1873.484, 2228.392, -82.2291, 4.845592, 0, 0, -0.6584797, 0.7525985, 7200, 255, 1, 22594), -- 浓雾 (Area: -Unknown- - Difficulty: 12)
(@OGUID+8, 248466, 1539, 85, 7978, 4096, '0', 0, 1855.283, 2292.285, 45.64474, 2.674203, 0, 0, 0.9728174, 0.2315734, 7200, 255, 1, 22594), -- 暗影之墙 (Area: -Unknown- - Difficulty: 12)
(@OGUID+9, 251429, 1539, 85, 7978, 4096, '0', 0, 1849.766, 2230.252, -75.85808, 1.610447, 0, 0, 0.7209854, 0.6929502, 7200, 255, 1, 22594), -- 浓雾 (Area: -Unknown- - Difficulty: 12)
(@OGUID+10, 251429, 1539, 85, 7978, 4096, '0', 0, 1849.766, 2230.252, -82.18213, 1.610447, 0, 0, 0.7209854, 0.6929502, 7200, 255, 1, 22594), -- 浓雾 (Area: -Unknown- - Difficulty: 12)
(@OGUID+11, 251429, 1539, 85, 7978, 4096, '0', 0, 1849.962, 2225.965, -82.19727, 1.610447, 0, 0, 0.7209854, 0.6929502, 7200, 255, 1, 22594), -- 浓雾 (Area: -Unknown- - Difficulty: 12)
(@OGUID+12, 251429, 1539, 85, 7978, 4096, '0', 0, 1849.962, 2225.965, -75.87321, 1.610447, 0, 0, 0.7209854, 0.6929502, 7200, 255, 1, 22594), -- 浓雾 (Area: -Unknown- - Difficulty: 12)
(@OGUID+13, 247877, 1539, 85, 7978, 4096, '0', 0, 1883.608, 2181.688, 35.84459, 0.01531998, 0, 0, 0.007659912, 0.9999707, 7200, 255, 1, 22594), -- 斯多姆卡 (Area: -Unknown- - Difficulty: 12)
(@OGUID+14, 251349, 1539, 85, 7681, 4096, '0', 0, 1915.259, 2326.842, 75.3084, 0.03414511, 0, 0, 0.01707172, 0.9998543, 7200, 255, 1, 22594), -- 场景战役碰撞 (Area: -Unknown- - Difficulty: 12)
(@OGUID+15, 251349, 1539, 85, 7681, 4096, '0', 0, 1914.825, 2343.531, 75.3084, 0.04581661, 0, 0, 0.0229063, 0.9997376, 7200, 255, 1, 22594), -- 场景战役碰撞 (Area: -Unknown- - Difficulty: 12)
(@OGUID+16, 251349, 1539, 85, 7681, 4096, '0', 0, 1915.04, 2339.207, 75.3084, 0.02942001, 0, 0, 0.01470947, 0.9998918, 7200, 255, 1, 22594), -- 场景战役碰撞 (Area: -Unknown- - Difficulty: 12)
(@OGUID+17, 251429, 1539, 85, 7978, 4096, '0', 0, 1891.597, 2236.116, -75.9135, 4.83199, 0, 0, -0.6635828, 0.7481028, 7200, 255, 1, 22594), -- 浓雾 (Area: -Unknown- - Difficulty: 12)
(@OGUID+18, 251429, 1539, 85, 7978, 4096, '0', 0, 1873.484, 2228.392, -75.90501, 4.845592, 0, 0, -0.6584797, 0.7525985, 7200, 255, 1, 22594); -- 浓雾 (Area: -Unknown- - Difficulty: 12)

DELETE FROM `gameobject_addon` WHERE `guid` BETWEEN @OGUID+0 AND @OGUID+19;



DELETE FROM `creature_template_addon` WHERE `entry` IN (100622 /*100622 (接引者丹妮卡)*/, 104307 /*104307 (索拉丁)*/, 104772 /*104772 (气息追踪者)*/, 104276 /*104276 (腐蚀者扎卡兹) - -Unknown-*/, 96569 /*96569 (时空裂痕)*/, 103339 /*103339 (无面幻术师)*/, 103398 /*103398 (腐蚀者扎卡兹) - -Unknown-*/, 103226 /*103226 (守护者索斯奥兹)*/, 104583 /*104583 (虚空触须) - -Unknown-*/, 101114 /*101114 (无面镇压者) - -Unknown-*/, 101120 /*101120 (血肉之子) - -Unknown-*/, 101875 /*101875 (暮光祭师) - -Unknown-*/, 101122 /*101122 (暮光暗影法师)*/, 101127 /*101127 (暮光折剑者)*/, 103151 /*103151 (Effects Bunny)*/, 103144 /*103144 (索拉丁) - -Unknown-*/, 51962 /*51962 (提瑞斯法野熊)*/, 61890 /*61890 (生病的松鼠)*/, 92608 /*92608 (马加洛) - -Unknown-*/, 100463 /*100463 (隐形人)*/, 97176 /*97176*/, 98257 /*98257 (贝泽德斯)*/, 103608 /*103608 (接引者丹妮卡)*/, 109033 /*109033*/, 92446 /*92446 (天罚使者先锋) - -Unknown-*/);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `auras`) VALUES
(100622, 0, 0, 50331648, 1, 0, 0, 0, 0, ''), -- 100622 (接引者丹妮卡)
(104307, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 104307 (索拉丁)
(104772, 0, 0, 50331648, 1, 0, 0, 0, 0, ''), -- 104772 (气息追踪者)
(104276, 0, 0, 0, 1, 0, 730, 0, 0, '211453'), -- 104276 (腐蚀者扎卡兹) - -Unknown-
(96569, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 96569 (时空裂痕)
(103339, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 103339 (无面幻术师)
(103398, 0, 0, 262144, 1, 0, 0, 0, 0, '163090'), -- 103398 (腐蚀者扎卡兹) - -Unknown-
(103226, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 103226 (守护者索斯奥兹)
(104583, 0, 0, 0, 1, 0, 0, 0, 0, '196285'), -- 104583 (虚空触须) - -Unknown-
(101114, 0, 0, 0, 1, 0, 0, 0, 0, '206899'), -- 101114 (无面镇压者) - -Unknown-
(101120, 0, 0, 0, 1, 0, 0, 0, 0, '34429'), -- 101120 (血肉之子) - -Unknown-
(101875, 0, 0, 0, 1, 0, 0, 0, 0, '34429'), -- 101875 (暮光祭师) - -Unknown-
(101122, 0, 0, 8, 0, 0, 0, 0, 0, ''), -- 101122 (暮光暗影法师)
(101127, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 101127 (暮光折剑者)
(103151, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 103151 (Effects Bunny)
(103144, 0, 0, 33554432, 1, 0, 0, 0, 0, '204093'), -- 103144 (索拉丁) - -Unknown-
(51962, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 51962 (提瑞斯法野熊)
(61890, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 61890 (生病的松鼠)
(92608, 0, 0, 0, 1, 0, 0, 0, 0, '184322'), -- 92608 (马加洛) - -Unknown-
(100463, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 100463 (隐形人)
(97176, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 97176
(98257, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 98257 (贝泽德斯)
(103608, 0, 0, 50331648, 1, 0, 0, 0, 0, ''), -- 103608 (接引者丹妮卡)
(109033, 0, 0, 0, 1, 0, 0, 0, 0, ''), -- 109033
(92446, 0, 0, 262144, 1, 0, 0, 0, 0, '159474'); -- 92446 (天罚使者先锋) - -Unknown-

DELETE FROM `creature_template_scaling` WHERE `Entry` IN (104276, 103339, 103226, 104583, 101114, 101120, 101875, 101122, 101127, 103151, 92608, 97176, 98257, 92446);
INSERT INTO `creature_template_scaling` (`Entry`, `LevelScalingMin`, `LevelScalingMax`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `VerifiedBuild`) VALUES
(104276, 98, 110, 0, 0, 22594),
(103339, 98, 110, 0, 0, 22594),
(103226, 98, 110, 0, 0, 22594),
(104583, 98, 110, 0, 0, 22594),
(101114, 98, 110, 0, 0, 22594),
(101120, 98, 110, 0, 0, 22594),
(101875, 98, 110, 0, 0, 22594),
(101122, 98, 110, 0, 0, 22594),
(101127, 98, 110, 0, 0, 22594),
(103151, 98, 110, 0, 0, 22594),
(92608, 98, 110, 0, 0, 22594),
(97176, 98, 110, 0, 0, 22594),
(98257, 98, 110, 0, 0, 22594),
(92446, 98, 110, 0, 0, 22594);

UPDATE `creature_model_info` SET `BoundingRadius`=0.75, `CombatReach`=10.5, `VerifiedBuild`=22594 WHERE `DisplayID`=67454;
UPDATE `creature_model_info` SET `BoundingRadius`=0.5425, `CombatReach`=1.75, `VerifiedBuild`=22594 WHERE `DisplayID`=68678;
UPDATE `creature_model_info` SET `BoundingRadius`=37.5, `CombatReach`=22.5, `VerifiedBuild`=22594 WHERE `DisplayID`=68556;
UPDATE `creature_model_info` SET `VerifiedBuild`=22594 WHERE `DisplayID`=32018;
UPDATE `creature_model_info` SET `BoundingRadius`=6.150001, `CombatReach`=5.25, `VerifiedBuild`=22594 WHERE `DisplayID`=68651;
UPDATE `creature_model_info` SET `BoundingRadius`=0.465, `CombatReach`=3, `VerifiedBuild`=22594 WHERE `DisplayID`=27932;
UPDATE `creature_model_info` SET `BoundingRadius`=0.2496, `CombatReach`=1.8, `VerifiedBuild`=22594 WHERE `DisplayID`=66978;
UPDATE `creature_model_info` SET `BoundingRadius`=0.4164, `CombatReach`=1.8, `VerifiedBuild`=22594 WHERE `DisplayID`=67184;
UPDATE `creature_model_info` SET `BoundingRadius`=0.4164, `CombatReach`=1.8, `VerifiedBuild`=22594 WHERE `DisplayID`=67185;
UPDATE `creature_model_info` SET `BoundingRadius`=0.26, `CombatReach`=1.875, `VerifiedBuild`=22594 WHERE `DisplayID`=66990;
UPDATE `creature_model_info` SET `BoundingRadius`=0.3672, `CombatReach`=1.8, `VerifiedBuild`=22594 WHERE `DisplayID`=66979;
UPDATE `creature_model_info` SET `BoundingRadius`=0.3672, `CombatReach`=1.8, `VerifiedBuild`=22594 WHERE `DisplayID`=66992;
UPDATE `creature_model_info` SET `VerifiedBuild`=22594 WHERE `DisplayID`=37687;
UPDATE `creature_model_info` SET `BoundingRadius`=0.2496, `CombatReach`=1.8, `VerifiedBuild`=22594 WHERE `DisplayID`=66989;
UPDATE `creature_model_info` SET `BoundingRadius`=0.4284, `CombatReach`=2.1, `VerifiedBuild`=22594 WHERE `DisplayID`=68038;
UPDATE `creature_model_info` SET `VerifiedBuild`=22594 WHERE `DisplayID`=4732;
UPDATE `creature_model_info` SET `VerifiedBuild`=22594 WHERE `DisplayID`=10091;
UPDATE `creature_model_info` SET `VerifiedBuild`=22594 WHERE `DisplayID`=11413;
UPDATE `creature_model_info` SET `BoundingRadius`=0.85, `CombatReach`=1.0625, `VerifiedBuild`=22594 WHERE `DisplayID`=11421;
UPDATE `creature_model_info` SET `VerifiedBuild`=22594 WHERE `DisplayID`=32656;
UPDATE `creature_model_info` SET `VerifiedBuild`=22594 WHERE `DisplayID`=34346;
UPDATE `creature_model_info` SET `VerifiedBuild`=22594 WHERE `DisplayID`=34064;
UPDATE `creature_model_info` SET `VerifiedBuild`=22594 WHERE `DisplayID`=30500;
UPDATE `creature_model_info` SET `VerifiedBuild`=22594 WHERE `DisplayID`=7689;
UPDATE `creature_model_info` SET `VerifiedBuild`=22594 WHERE `DisplayID`=10834;
UPDATE `creature_model_info` SET `VerifiedBuild`=22594 WHERE `DisplayID`=33979;
UPDATE `creature_model_info` SET `VerifiedBuild`=22594 WHERE `DisplayID`=33984;
UPDATE `creature_model_info` SET `VerifiedBuild`=22594 WHERE `DisplayID`=33981;
UPDATE `creature_model_info` SET `VerifiedBuild`=22594 WHERE `DisplayID`=4124;
UPDATE `creature_model_info` SET `VerifiedBuild`=22594 WHERE `DisplayID`=37686;
UPDATE `creature_model_info` SET `VerifiedBuild`=22594 WHERE `DisplayID`=7449;
UPDATE `creature_model_info` SET `VerifiedBuild`=22594 WHERE `DisplayID`=1244;
UPDATE `creature_model_info` SET `BoundingRadius`=10.29085, `CombatReach`=8, `VerifiedBuild`=22594 WHERE `DisplayID`=73674;
UPDATE `creature_model_info` SET `BoundingRadius`=1.75, `CombatReach`=2.625, `VerifiedBuild`=22594 WHERE `DisplayID`=65735;
UPDATE `creature_model_info` SET `BoundingRadius`=1.75, `CombatReach`=2.625, `VerifiedBuild`=22594 WHERE `DisplayID`=65736;
UPDATE `creature_model_info` SET `BoundingRadius`=1.75, `CombatReach`=2.625, `VerifiedBuild`=22594 WHERE `DisplayID`=65734;

DELETE FROM `creature_equip_template` WHERE (`CreatureID`=100622 AND `ID`=1) OR (`CreatureID`=101122 AND `ID`=2) OR (`CreatureID`=101875 AND `ID`=1) OR (`CreatureID`=101122 AND `ID`=1) OR (`CreatureID`=101127 AND `ID`=1) OR (`CreatureID`=45254 AND `ID`=1) OR (`CreatureID`=44954 AND `ID`=2) OR (`CreatureID`=92608 AND `ID`=1) OR (`CreatureID`=97176 AND `ID`=1) OR (`CreatureID`=103608 AND `ID`=1) OR (`CreatureID`=92446 AND `ID`=1);
INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `AppearanceModID1`, `ItemVisual1`, `ItemID2`, `AppearanceModID2`, `ItemVisual2`, `ItemID3`, `AppearanceModID3`, `ItemVisual3`) VALUES
(100622, 1, 140345, 0, 0, 0, 0, 0, 0, 0, 0), -- 接引者丹妮卡
(101122, 2, 1903, 0, 0, 0, 0, 0, 0, 0, 0), -- 暮光暗影法师
(101875, 1, 72863, 0, 0, 0, 0, 0, 0, 0, 0), -- 暮光祭师
(101122, 1, 72863, 0, 0, 0, 0, 0, 0, 0, 0), -- 暮光暗影法师
(101127, 1, 41343, 0, 0, 15909, 0, 0, 0, 0, 0), -- 暮光折剑者
(45254, 1, 2714, 0, 0, 0, 0, 0, 0, 0, 0), -- 希尔斯布莱德狼人
(44954, 2, 2704, 0, 0, 0, 0, 0, 0, 0, 0), -- 希尔斯布莱德难民
(92608, 1, 28365, 0, 0, 0, 0, 0, 0, 0, 0), -- 马加洛
(97176, 1, 113988, 0, 0, 0, 0, 0, 0, 0, 0), -- -Unknown-
(103608, 1, 140345, 0, 0, 0, 0, 0, 0, 0, 0), -- 接引者丹妮卡
(92446, 1, 79734, 0, 0, 0, 0, 0, 0, 0, 0); -- 天罚使者先锋

UPDATE `creature_equip_template` SET `ItemID1`=3346 WHERE (`CreatureID`=44966 AND `ID`=1); -- 希尔斯布莱德难民
UPDATE `creature_equip_template` SET `ItemID1`=3351 WHERE (`CreatureID`=44954 AND `ID`=1); -- 希尔斯布莱德难民
UPDATE `creature_equip_template` SET `ItemID1`=2202 WHERE (`CreatureID`=113270 AND `ID`=1); -- 女武神

DELETE FROM `gossip_menu` WHERE (`MenuId`=19302 AND `TextId`=28400) OR (`MenuId`=19307 AND `TextId`=28415) OR (`MenuId`=19309 AND `TextId`=28417) OR (`MenuId`=19308 AND `TextId`=28416) OR (`MenuId`=19310 AND `TextId`=28418);
INSERT INTO `gossip_menu` (`MenuId`, `TextId`, `VerifiedBuild`) VALUES
(19302, 28400, 22594), -- 103144 (索拉丁)
(19307, 28415, 22594), -- 103144 (索拉丁)
(19309, 28417, 22594), -- 103144 (索拉丁)
(19308, 28416, 22594), -- 103144 (索拉丁)
(19310, 28418, 22594); -- 103144 (索拉丁)

UPDATE `gossip_menu` SET `VerifiedBuild`=22594 WHERE (`MenuId`=20375 AND `TextId`=30468); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=22594 WHERE (`MenuId`=19725 AND `TextId`=29257); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=22594 WHERE (`MenuId`=20254 AND `TextId`=30257); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=22594 WHERE (`MenuId`=18724 AND `TextId`=27208); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=22594 WHERE (`MenuId`=18723 AND `TextId`=12487); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=22594 WHERE (`MenuId`=18724 AND `TextId`=27208); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=22594 WHERE (`MenuId`=19091 AND `TextId`=27914); -- 0

DELETE FROM `gossip_menu_option` WHERE (`MenuId`=19302 AND `OptionIndex`=2) OR (`MenuId`=19302 AND `OptionIndex`=1) OR (`MenuId`=19302 AND `OptionIndex`=0) OR (`MenuId`=19307 AND `OptionIndex`=0) OR (`MenuId`=19309 AND `OptionIndex`=0) OR (`MenuId`=19308 AND `OptionIndex`=0) OR (`MenuId`=19310 AND `OptionIndex`=0) OR (`MenuId`=19091 AND `OptionIndex`=0);
INSERT INTO `gossip_menu_option` (`MenuId`, `OptionIndex`, `OptionIcon`, `OptionText`, `OptionBroadcastTextId`, `VerifiedBuild`) VALUES
(19302, 2, 0, '跟我说说你那把防止怪物复活的剑吧。', 0, 22594),
(19302, 1, 0, '这里发生了什么？', 38328, 22594),
(19302, 0, 0, '我想再多了解一下你。', 0, 22594),
(19307, 0, 0, '好的。', 33525, 22594),
(19309, 0, 0, '好的。', 33525, 22594),
(19308, 0, 0, '它死了，可又被唤醒了？', 0, 22594),
(19310, 0, 0, '好的。', 33525, 22594),
(19091, 0, 0, '我想看一下我们可以选择的武器。', 0, 22594);

UPDATE `gossip_menu_option` SET `VerifiedBuild`=22594 WHERE (`MenuId`=18723 AND `OptionIndex`=0);

DELETE FROM `gossip_menu_option_action` WHERE (`MenuId`=19307 AND `OptionIndex`=0) OR (`MenuId`=19302 AND `OptionIndex`=0) OR (`MenuId`=19309 AND `OptionIndex`=0) OR (`MenuId`=19308 AND `OptionIndex`=0) OR (`MenuId`=19302 AND `OptionIndex`=1) OR (`MenuId`=19310 AND `OptionIndex`=0) OR (`MenuId`=19302 AND `OptionIndex`=2);
INSERT INTO `gossip_menu_option_action` (`MenuId`, `OptionIndex`, `ActionMenuId`, `ActionPoiId`) VALUES
(19307, 0, 19302, 0),
(19302, 0, 19307, 0),
(19309, 0, 19302, 0),
(19308, 0, 19309, 0),
(19302, 1, 19308, 0),
(19310, 0, 19302, 0),
(19302, 2, 19310, 0);

DELETE FROM `gossip_menu` WHERE (`MenuId`=19874 AND `TextId`=29525) OR (`MenuId`=19875 AND `TextId`=29527);
INSERT INTO `gossip_menu` (`MenuId`, `TextId`) VALUES
(19874, 29525), -- 93773 (High Overlord Saurfang)
(19875, 29527); -- 93773 (High Overlord Saurfang)

DELETE FROM `gossip_menu_option` WHERE (`MenuId`=19875 AND `OptionIndex`=0) OR (`MenuId`=19874 AND `OptionIndex`=0);
INSERT INTO `gossip_menu_option` (`MenuId`, `OptionIndex`, `OptionIcon`, `OptionText`, `OptionBroadcastTextId`) VALUES
(19875, 0, 0, '那我跟你一起去。', 0),
(19874, 0, 0, '你想要做什么？', 0);

UPDATE `gossip_menu_option` SET `OptionType`=1, `OptionNpcFlag`=1 WHERE (`MenuId`=19875 AND `OptionIndex`=0) OR (`MenuId`=19874 AND `OptionIndex`=0);

DELETE FROM `gossip_menu_option_action` WHERE (`MenuId`=19874 AND `OptionIndex`=0);
INSERT INTO `gossip_menu_option_action` (`MenuId`, `OptionIndex`, `ActionMenuId`, `ActionPoiId`) VALUES
(19874, 0, 19875, 0);

UPDATE `creature_template` SET `minlevel`=100, `maxlevel`=100, `npcflag`=16777216, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=33536, `unit_flags2`=18432 WHERE `entry`=100519; -- Makka
UPDATE `creature_template` SET `gossip_menu_id`=19874, `faction`=2714, `minlevel`=100, `maxlevel`=100, `npcflag`=3, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=33536, `unit_flags2`=18432 WHERE `entry`=93773; -- High Overlord Saurfang
UPDATE `creature_template` SET `InhabitType`=4 WHERE `entry`=103608;


UPDATE `creature_template` SET `gossip_menu_id`=19725 WHERE `entry`=107494; 
UPDATE `creature_template` SET `gossip_menu_id`=20254 WHERE `entry`=112577;
UPDATE `creature_template` SET `minlevel`=100, `maxlevel`=100, `npcflag`=2, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=33536, `unit_flags2`=18432, `HoverHeight`=2.8 WHERE `entry`=100622; -- 接引者丹妮卡
UPDATE `creature_template` SET `minlevel`=99, `maxlevel`=99, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=33536, `unit_flags2`=18432 WHERE `entry`=104307; -- 索拉丁
UPDATE `creature_template` SET `minlevel`=110, `maxlevel`=110, `faction`=14, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=33554688, `unit_flags2`=67110912 WHERE `entry`=104772; -- 气息追踪者
UPDATE `creature_template` SET `minlevel`=98, `maxlevel`=110, `faction`=14, `speed_run`=0.9126986, `BaseAttackTime`=1500, `RangeAttackTime`=2000, `unit_flags`=33088, `unit_flags2`=2097152 WHERE `entry`=104276; -- 腐蚀者扎卡兹
UPDATE `creature_template` SET `minlevel`=113, `maxlevel`=113, `faction`=14, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=33587200, `unit_flags3`=1 WHERE `entry`=96569; -- 时空裂痕
UPDATE `creature_template` SET `minlevel`=98, `maxlevel`=110, `faction`=16, `speed_run`=0.9126986, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=103339; -- 无面幻术师
UPDATE `creature_template` SET `minlevel`=100, `maxlevel`=100, `faction`=14, `speed_run`=0.9126986, `BaseAttackTime`=1500, `RangeAttackTime`=2000, `unit_flags`=536904512, `unit_flags2`=4212737, `dynamicflags`=32 WHERE `entry`=103398; -- 腐蚀者扎卡兹
UPDATE `creature_template` SET `minlevel`=98, `maxlevel`=110, `faction`=16, `speed_run`=0.9126986, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768 WHERE `entry`=103226; -- 守护者索斯奥兹
UPDATE `creature_template` SET `minlevel`=98, `maxlevel`=110, `faction`=16, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=2147516416 WHERE `entry`=104583; -- 虚空触须
UPDATE `creature_template` SET `minlevel`=98, `maxlevel`=110, `faction`=16, `speed_run`=0.9126986, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=101114; -- 无面镇压者
UPDATE `creature_template` SET `minlevel`=98, `maxlevel`=110, `faction`=16, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=101120; -- 血肉之子
UPDATE `creature_template` SET `minlevel`=98, `maxlevel`=110, `faction`=16, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=101875; -- 暮光祭师
UPDATE `creature_template` SET `minlevel`=98, `maxlevel`=110, `faction`=16, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=32768 WHERE `entry`=101122; -- 暮光暗影法师
UPDATE `creature_template` SET `minlevel`=98, `maxlevel`=110, `faction`=16, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768 WHERE `entry`=101127; -- 暮光折剑者
UPDATE `creature_template` SET `minlevel`=98, `maxlevel`=110, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=33588032, `unit_flags2`=37750784 WHERE `entry`=103151; -- Effects Bunny
UPDATE `creature_template` SET `gossip_menu_id`=19302, `minlevel`=107, `maxlevel`=107, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=33536, `unit_flags2`=4212736 WHERE `entry`=103144; -- 索拉丁
UPDATE `creature_template` SET `minlevel`=83, `maxlevel`=83, `faction`=1711, `speed_run`=1 WHERE `entry`=51962; -- 提瑞斯法野熊
UPDATE `creature_template` SET `speed_run`=1 WHERE `entry`=1797; -- 疯狂的巨熊
UPDATE `creature_template` SET `unit_flags`=33536 WHERE `entry`=46559; -- 部落工程师
UPDATE `creature_template` SET `unit_flags2`=4196352, `unit_flags3`=1 WHERE `entry`=44764; -- 部落棺木运输车
UPDATE `creature_template` SET `unit_flags2`=2099200 WHERE `entry`=44766; -- 棺材
UPDATE `creature_template` SET `unit_flags`=832, `unit_flags2`=4196352 WHERE `entry`=46560; -- 被降服的森林双头魔
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=45263; -- 部落大炮
UPDATE `creature_template` SET `faction`=31, `npcflag`=1073741824, `speed_run`=0.8571429, `unit_flags`=512, `unit_flags2`=2048 WHERE `entry`=61890; -- 生病的松鼠
UPDATE `creature_template` SET `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768 WHERE `entry`=1766; -- 疯狂的座狼
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=5 WHERE `entry`=61827; -- 被感染的小鹿
UPDATE `creature_template` SET `minlevel`=15 WHERE `entry`=6033; -- 洛丹米尔狂鱼
UPDATE `creature_template` SET `minlevel`=23, `speed_run`=1.142857, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `dynamicflags`=0 WHERE `entry`=2408; -- -Unknown-
UPDATE `creature_template` SET `minlevel`=1, `maxlevel`=1 WHERE `entry`=61366; -- -Unknown-
UPDATE `creature_template` SET `minlevel`=17, `maxlevel`=17, `speed_run`=1.142857 WHERE `entry`=2358; -- 达拉然召唤师
UPDATE `creature_template` SET `minlevel`=90, `maxlevel`=90, `unit_class`=2, `unit_flags`=537133056, `unit_flags2`=2049, `dynamicflags`=32 WHERE `entry`=62622; -- 虔敬的十字军战士乔尼
UPDATE `creature_template` SET `minlevel`=16, `maxlevel`=17, `speed_run`=1.142857, `dynamicflags`=0 WHERE `entry`=45728; -- 奥术残渣
UPDATE `creature_template` SET `speed_walk`=0.888888 WHERE `entry`=113775; -- -Unknown-
UPDATE `creature_template` SET `faction`=190, `npcflag`=0 WHERE `entry`=113782; -- 汉妮丝·滩行
UPDATE `creature_template` SET `speed_run`=1 WHERE `entry`=112847; -- -Unknown-
UPDATE `creature_template` SET `speed_walk`=1.2, `speed_run`=1 WHERE `entry`=96797; -- -Unknown-
UPDATE `creature_template` SET `speed_walk`=1.2, `speed_run`=1 WHERE `entry`=96798; -- -Unknown-
-- UPDATE `creature_template` SET `gossip_menu_id`=18723 WHERE `entry`=96813; -- -Unknown-
UPDATE `creature_template` SET `speed_run`=0.9920629 WHERE `entry`=106528; -- -Unknown-
UPDATE `creature_template` SET `speed_run`=1.142857 WHERE `entry`=101436; -- -Unknown-
UPDATE `creature_template` SET `npcflag`=1099511627779 WHERE `entry`=111741; -- 刻石匠福森
UPDATE `creature_template` SET `gossip_menu_id`=19091 WHERE `entry`=96469; -- 奥丁
UPDATE `creature_template` SET `gossip_menu_id`=20375, `minlevel`=98 WHERE `entry`=112392; -- 军需官杜诺夫
UPDATE `creature_template` SET `minlevel`=98, `maxlevel`=110, `faction`=2102, `speed_walk`=2, `speed_run`=2, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=33024, `unit_flags2`=6293504, `unit_flags3`=1 WHERE `entry`=92608; -- 马加洛
UPDATE `creature_template` SET `minlevel`=100, `maxlevel`=100, `faction`=14, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=33554944, `unit_flags2`=2048, `unit_flags3`=1 WHERE `entry`=100463; -- 隐形人
UPDATE `creature_template` SET `minlevel`=98, `maxlevel`=110, `faction`=16, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=32768, `unit_flags2`=4196352, `unit_flags3`=1 WHERE `entry`=97176; -- -Unknown-
UPDATE `creature_template` SET `minlevel`=98, `maxlevel`=110, `faction`=2102, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=8, `unit_flags`=32768, `unit_flags2`=4196352, `unit_flags3`=1 WHERE `entry`=98257; -- 贝泽德斯
UPDATE `creature_template` SET `speed_run`=1 WHERE `entry`=64367; -- 隐形人
UPDATE `creature_template` SET `minlevel`=100, `maxlevel`=100, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=33536, `unit_flags2`=18432, `HoverHeight`=2.8 WHERE `entry`=103608; -- 接引者丹妮卡
UPDATE `creature_template` SET `minlevel`=100, `maxlevel`=106, `faction`=14, `speed_run`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=33587968, `unit_flags2`=4196352, `unit_flags3`=1 WHERE `entry`=109033; -- -Unknown-
UPDATE `creature_template` SET `minlevel`=98, `maxlevel`=110, `faction`=16, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=536904448, `unit_flags2`=2049, `dynamicflags`=32 WHERE `entry`=92446; -- 天罚使者先锋
UPDATE `creature_template` SET `unit_flags`=536904448, `unit_flags2`=2049, `dynamicflags`=32 WHERE `entry`=92450; -- 艾瑞达裂隙制造者
UPDATE `creature_template` SET `speed_run`=1, `unit_flags`=536904448, `unit_flags2`=2049, `dynamicflags`=32 WHERE `entry`=92447; -- 混沌之子
UPDATE `creature_template` SET `speed_run`=1, `unit_flags`=536904448, `unit_flags2`=2049, `dynamicflags`=32 WHERE `entry`=92445; -- 恶魔卫士入侵者

SET NAMES 'utf8';
DELETE FROM `creature_text` WHERE (`CreatureID`=97166 AND `GroupID`='0' AND `ID`='0') OR (`CreatureID`=100622 AND `GroupID`='0' AND `ID`='0') OR (`CreatureID`=100622 AND `GroupID`='1' AND `ID`='0') OR (`CreatureID`=100622 AND `GroupID`='2' AND `ID`='0') OR (`CreatureID`=103144 AND `GroupID`='0' AND `ID`='0') OR (`CreatureID`=103144 AND `GroupID`='1' AND `ID`='0') OR (`CreatureID`=103144 AND `GroupID`='2' AND `ID`='0') OR (`CreatureID`=103144 AND `GroupID`='3' AND `ID`='0') OR (`CreatureID`=103144 AND `GroupID`='4' AND `ID`='0') OR (`CreatureID`=104307 AND `GroupID`='0' AND `ID`='0') OR (`CreatureID`=104307 AND `GroupID`='1' AND `ID`='0') OR (`CreatureID`=104307 AND `GroupID`='2' AND `ID`='0') OR (`CreatureID`=104307 AND `GroupID`='3' AND `ID`='0') OR (`CreatureID`=112392 AND `GroupID`='0' AND `ID`='0');
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `comment`) VALUES
(97166, 0, 0, 'A val\'kyr approaches! We must greet her with respect. Come, heroes!', 12, 0, 100, 396, 0, 60433, 106207, '菲娜·伯恩多提尔 to 新晋维库人英雄'),
(100622, 0, 0, '勇士，要是你打磨完武器了，我有东西要给你看。', 14, 0, 100, 0, 0, 0, 0, '接引者丹妮卡 to Player'),
(100622, 1, 0, '请跟我来。奥丁之眼是一个强大的占卜及沟通装置。使用它，你就能看到破碎群岛，向你的勇士们发号施令，并制定你自己的行动计划。天空贤者格伦特会帮你操纵它的。', 12, 0, 100, 0, 0, 0, 0, '接引者丹妮卡 to Player'),
(100622, 2, 0, '这是就天空贤者格伦特和奥丁之眼。祝你政令畅通，百战百胜，$ct！', 12, 0, 100, 0, 0, 0, 0, '接引者丹妮卡 to Player'),
(103144, 0, 0, '非常……感谢。我不认识你，但我知道你心中充满勇气。对……你就是我要等的英雄！', 12, 0, 100, 0, 0, 60457, 105775, '索拉丁 to -Unknown-'),
(103144, 1, 0, '很久之前，求知的欲望将我带到此地，一座湖底陵墓。冰冷的石墙后面，埋藏着……可怕的黑暗，一个古老的邪神。', 12, 0, 100, 0, 0, 60458, 105776, '索拉丁 to -Unknown-'),
(103144, 2, 0, '部下们求我离开，可我拒绝了。骄傲葬送了我……和他们。惊醒的邪神带来了死亡。弥留之际，我将我的佩剑，斯多姆卡，插入了它的头颅。', 12, 0, 100, 0, 0, 60459, 105781, '索拉丁 to -Unknown-'),
(103144, 3, 0, '几百年过去了，那把剑一直使怪物无法复活。现在它又被惊动了，请你深入墓穴，消弭我闯下的大祸。我会跟你一起去，尽力帮助你。', 12, 0, 100, 0, 0, 60460, 105782, '索拉丁 to -Unknown-'),
(103144, 4, 0, '这个怪物，死了也不安分。它的腐蚀已扩散到整个墓穴。你得自己杀出一条路来！', 14, 0, 100, 1, 0, 60461, 105866, '索拉丁 to Player'),
(104307, 0, 0, '你做到了我做不到的事，击败扎卡兹并活了下来。', 12, 0, 100, 1, 0, 60473, 106751, '索拉丁 to Player'),
(104307, 1, 0, '你知道应该怎么做。拿起灭战者，彻底消灭扎卡兹的威胁吧！', 12, 0, 100, 0, 0, 60474, 106752, '索拉丁 to Player'),
(104307, 2, 0, '噩梦终于结束了！我可以离开这里，获得安息了。', 12, 0, 100, 1, 0, 60471, 106753, '索拉丁 to Player'),
(104307, 3, 0, '我的剑归你了。斯多姆卡属于战场，而不是坟墓。它由铸剑大师所造，灌注了精灵魔法。我不知道在怪物体内埋了几百年是否对它有影响，但它定能成为你的得力助手。', 12, 0, 100, 1, 0, 60472, 106805, '索拉丁 to Player'),
(112392, 0, 0, '$n！我有合适你的货物！来看看吧！', 12, 0, 100, 0, 0, 0, 0, '军需官杜诺夫 to Player');

INSERT IGNORE INTO `npc_spellclick_spells` (`npc_entry`, `spell_id`, `cast_flags`, `user_type`) VALUES
-- (68232, 75648, UNKNOWN, UNKNOWN),
-- (68239, 75648, UNKNOWN, UNKNOWN),
-- (68238, 75648, UNKNOWN, UNKNOWN),
(45263, 84549, 0, 0),
-- (44764, 86807, UNKNOWN, UNKNOWN),
(103398, 204771, 0, 0);


UPDATE `quest_template` SET `RewardBonusMoney`=220, `RewardFactionCapIn1`=7, `RewardFactionCapIn2`=7, `RewardFactionCapIn3`=7, `RewardFactionCapIn4`=7, `RewardFactionCapIn5`=7, `VerifiedBuild`=22594 WHERE `ID`=30596; -- -Unknown-

DELETE FROM `quest_objectives` WHERE `ID`=273388;
INSERT INTO `quest_objectives` (`ID`, `QuestID`, `Type`, `Order`, `StorageIndex`, `ObjectID`, `Amount`, `Flags`, `Flags2`, `ProgressBarWeight`, `VerifiedBuild`) VALUES
(273388, 34445, 0, 0, 3, 80929, 1, 0, 0, 0, 22594); -- 273388

UPDATE `quest_objectives` SET `Order`=2, `VerifiedBuild`=22594 WHERE `ID`=272842; -- 272842
UPDATE `quest_objectives` SET `Order`=1, `VerifiedBuild`=22594 WHERE `ID`=272841; -- 272841
UPDATE `quest_objectives` SET `VerifiedBuild`=22594 WHERE `ID`=272840; -- 272840
UPDATE `quest_objectives` SET `VerifiedBuild`=22594 WHERE `ID`=253734; -- 253734
UPDATE `quest_objectives` SET `VerifiedBuild`=22594 WHERE `ID`=252964; -- 252964

DELETE FROM `quest_visual_effect` WHERE (`ID`=273388 AND `Index`=0);
INSERT INTO `quest_visual_effect` (`ID`, `Index`, `VisualEffect`, `VerifiedBuild`) VALUES
(273388, 0, 2726, 22594);

UPDATE `quest_visual_effect` SET `VerifiedBuild`=22594 WHERE (`ID`=272842 AND `Index`=0);
UPDATE `quest_visual_effect` SET `VerifiedBuild`=22594 WHERE (`ID`=272841 AND `Index`=0);
UPDATE `quest_visual_effect` SET `VerifiedBuild`=22594 WHERE (`ID`=272840 AND `Index`=0);

DELETE FROM `gameobject_template` WHERE `entry`=248466;
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `RequiredLevel`, `VerifiedBuild`) VALUES
(248466, 0, 24101, '暗影之墙', '', '', 1.5, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 22594); -- 暗影之墙

DELETE FROM `gameobject_template` WHERE `entry`=243491;
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `RequiredLevel`, `VerifiedBuild`) VALUES
(243491, 5, 27616, '栅栏', '', '', 5, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 26124); -- Баррикада Скверны 栅栏

UPDATE `gameobject_template` SET `type`=10, `displayId`=16973, `size`=1.75, `Data13`=1, `Data16`=1, `VerifiedBuild`=26124 WHERE `entry`=247492; -- Legion Portal

UPDATE `gameobject_template` SET `type`=3, `displayId`=9806, `IconName`='questinteract', `size`=2, `Data0`=1691, `Data1`=65156, `Data14`=23645, `Data17`=43718, `VerifiedBuild`=22594 WHERE `entry`=247877; -- 斯多姆卡
UPDATE `gameobject_template` SET `VerifiedBuild`=22594 WHERE `entry`=251349; -- 场景战役碰撞
UPDATE `gameobject_template` SET `VerifiedBuild`=22594 WHERE `entry`=205143; -- 废弃的厕所
UPDATE `gameobject_template` SET `VerifiedBuild`=22594 WHERE `entry`=205350; -- 部落通讯台
UPDATE `gameobject_template` SET `VerifiedBuild`=22594 WHERE `entry`=181689; -- 埃索达
UPDATE `gameobject_template` SET `VerifiedBuild`=22594 WHERE `entry`=20654; -- lowerLdoor
UPDATE `gameobject_template` SET `VerifiedBuild`=22594 WHERE `entry`=20649; -- 升降梯
UPDATE `gameobject_template` SET `VerifiedBuild`=22594 WHERE `entry`=20652; -- 升降梯
UPDATE `gameobject_template` SET `VerifiedBuild`=22594 WHERE `entry`=20651; -- lowerLdoor
UPDATE `gameobject_template` SET `VerifiedBuild`=22594 WHERE `entry`=20653; -- upperLdoor
UPDATE `gameobject_template` SET `VerifiedBuild`=22594 WHERE `entry`=20650; -- upperLdoor
UPDATE `gameobject_template` SET `VerifiedBuild`=22594 WHERE `entry`=20656; -- upperLdoor
UPDATE `gameobject_template` SET `VerifiedBuild`=22594 WHERE `entry`=20655; -- 升降梯
UPDATE `gameobject_template` SET `VerifiedBuild`=22594 WHERE `entry`=20657; -- lowerLdoor

DELETE FROM `npc_text` WHERE `ID` IN (28418 /*28418*/, 28417 /*28417*/, 28416 /*28416*/, 28415 /*28415*/, 28400 /*28400*/);
INSERT INTO `npc_text` (`ID`, `Probability0`, `Probability1`, `Probability2`, `Probability3`, `Probability4`, `Probability5`, `Probability6`, `Probability7`, `BroadcastTextId0`, `BroadcastTextId1`, `BroadcastTextId2`, `BroadcastTextId3`, `BroadcastTextId4`, `BroadcastTextId5`, `BroadcastTextId6`, `BroadcastTextId7`, `VerifiedBuild`) VALUES
(28418, 1, 0, 0, 0, 0, 0, 0, 0, 105862, 0, 0, 0, 0, 0, 0, 0, 22594), -- 28418
(28417, 1, 0, 0, 0, 0, 0, 0, 0, 105853, 0, 0, 0, 0, 0, 0, 0, 22594), -- 28417
(28416, 1, 0, 0, 0, 0, 0, 0, 0, 105846, 0, 0, 0, 0, 0, 0, 0, 22594), -- 28416
(28415, 1, 0, 0, 0, 0, 0, 0, 0, 105841, 0, 0, 0, 0, 0, 0, 0, 22594), -- 28415
(28400, 1, 0, 0, 0, 0, 0, 0, 0, 105783, 0, 0, 0, 0, 0, 0, 0, 22594); -- 28400


DELETE FROM `npc_text` WHERE `ID` IN (29527 /*29527*/, 29525 /*29525*/);
INSERT INTO `npc_text` (`ID`, `Probability0`, `Probability1`, `Probability2`, `Probability3`, `Probability4`, `Probability5`, `Probability6`, `Probability7`, `BroadcastTextId0`, `BroadcastTextId1`, `BroadcastTextId2`, `BroadcastTextId3`, `BroadcastTextId4`, `BroadcastTextId5`, `BroadcastTextId6`, `BroadcastTextId7`, `VerifiedBuild`) VALUES
(29527, 1, 0, 0, 0, 0, 0, 0, 0, 114660, 0, 0, 0, 0, 0, 0, 0, 26124), -- 29527
(29525, 1, 0, 0, 0, 0, 0, 0, 0, 114652, 0, 0, 0, 0, 0, 0, 0, 26124); -- 29525
