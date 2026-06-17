INSERT IGNORE INTO `instance_template` (`map`, `parent`, `script`, `allowMount`) VALUES
(1495, 1220, 'scenario_paladin_truthguard', 1);

UPDATE `gameobject_template` SET `data1` = 249420 WHERE `entry` = 249420 AND `type` IN (3, 50);
DELETE FROM `gameobject_loot_template` WHERE `entry` = '249420';
INSERT INTO `gameobject_loot_template` (`entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
('249420', '128866', '0', '100', '1', '1', '0', '1', '1', '');

DELETE FROM `gameobject_template` WHERE `entry`=249420;
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `IconName`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `RequiredLevel`, `VerifiedBuild`) VALUES
(249420, 3, 9806, 'questinteract', '', 2.25, 1691, 65912, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 23645, 0, 0, 43719, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 22624);

DELETE FROM `gameobject_template_addon` WHERE `entry`= 249420;
INSERT INTO `gameobject_template_addon` (`entry`, `faction`, `flags`) VALUES
(249420, 0, 2097152);

INSERT INTO `scenarios` (`map`, `difficulty`, `scenario_A`, `scenario_H`) VALUES 
(1495, 12, 1082, 1082);




//dh
    
UPDATE `quest_template_addon` SET `PrevQuestID`=39718 WHERE `ID`=41220;
UPDATE `quest_template_addon` SET `PrevQuestID`=41220 WHERE `ID`=38834;
-- Enchanting quests
UPDATE `quest_template_addon` SET `PrevQuestID`=39874 WHERE `ID`=39875;
UPDATE `quest_template_addon` SET `PrevQuestID`=39876 WHERE `ID`=39876;
UPDATE `quest_template_addon` SET `PrevQuestID`=39876 WHERE `ID`=39877;

DELETE FROM `smart_scripts` WHERE `entryorguid`='86563';
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_archmage_khadgar_86563' WHERE `entry`='86563';
UPDATE `gossip_menu_option` SET `OptionText`='I\'m ready. Let\'s get down to Azsuna, Khadgar.' WHERE `MenuId` = '86563';
DELETE FROM `creature_text` WHERE `CreatureID`=86563 AND `GroupID` IN (0, 1);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(86563, 0, 0, 'Here you are. $n, over here, Azsuna awaits.', 12, 0, 100, 3, 0, 57419, 0, 0, 'Archmage Khadgar to Player'),
(86563, 1, 0, 'Let me know when you are ready, champion.', 12, 0, 100, 1, 0, 58371, 0, 0, 'Archmage Khadgar to Player');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (15) AND `SourceGroup` IN (86563);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `sourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES 
(15, 86563, 1, 0, 0, 9, 0, 41220, 0, 0, 0, 0, 0, '', 'Gossip Only Shows if Quest Taken');

UPDATE `creature` SET `position_x`=-833.704, `position_y`=4276.217, `position_z`=746.254, `orientation`=1.250528 WHERE `guid`=20544383;
UPDATE `creature` SET `position_x`=-813.472, `position_y`=4288.03, `position_z`=746.282, `orientation`=3.693114 WHERE `guid`=20549214;

DELETE FROM `creature` WHERE `guid`=280000404;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(280000404,93326,1220,7334,7334,0,0,0,0,-1,0,1,-78.3393,6858.93,31.0119,1.73103,300,0,0,997696768,250,0,0,0,0,0,0,'npc_archmage_khadgar_93326',25549); -- Khadgar
DELETE FROM `creature_text` WHERE `CreatureID`=93326 AND `GroupID`=1;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(93326, 1, 0, 'Hurry. The Illidari are about to be overrun.', 12, 0, 100, 25, 0, 52607, 0, 0, 'Archmage Khadgar to Player');
UPDATE `creature_template_addon` SET `auras`='84240' WHERE `entry` = 93326;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_archmage_khadgar_90417' WHERE `entry`='90417';
UPDATE `creature_template` SET `AIName`='', `ScriptName`='' WHERE `entry`='91827';
DELETE FROM `waypoint_data` WHERE `id`=9332600;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(9332600,1,-78.3393,6858.93,31.0119,0,0,0,0,100,0),
(9332600,2,-81.4901,6880,23.6468,0,0,0,0,100,0),
(9332600,3,-80.4822,6885.37,21.999,0,0,0,0,100,0),
(9332600,4,-74.7649,6899,17.9561,0,0,0,0,100,0),
(9332600,5,-73.2156,6906.45,16.512,0,0,0,0,100,0),
(9332600,6,-73.6964,6909.42,16.0559,0,0,0,0,100,0),
(9332600,7,-76.6878,6919.45,15.2145,0,0,0,0,100,0);
SET @KHADGAR := 90417;
DELETE FROM `creature_text` WHERE `CreatureID` = @KHADGAR;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(@KHADGAR, 0, 0, 'Nobody touch it! Not until our guest arrives.', 12, 0, 100, 1, 0, 67263, 101006, 0, 'Archmage Khadgar to Player'),
(@KHADGAR, 1, 0, 'Any disturbance should catalyze the sequence. Just, uh, give it a poke or something.', 12, 0, 100, 1, 0, 67264, 100058, 0, 'Archmage Khadgar to Player'),
(@KHADGAR, 2, 0, 'Be careful, champion. The land of Suramar has been wild for ten thousand years.', 12, 0, 100, 0, 0, 67271, 100062, 0, 'Archmage Khadgar to Player'),
(@KHADGAR, 3, 0, 'I have just a thing. Follow me.', 12, 0, 100, 0, 0, 64653, 0, 0, 'Archmage Khadgar to Player'),
(@KHADGAR, 4, 0, 'Hold on just a moment. I fear I\'m a bit of a pack rat.', 12, 0, 100, 0, 0, 64654, 0, 0, 'Archmage Khadgar to Player'),
(@KHADGAR, 5, 0, 'Now let\'s see... apexis crystals? No, no, those won\'t do at all.', 12, 0, 100, 0, 0, 64655, 0, 0, 'Archmage Khadgar to Player'),
(@KHADGAR, 6, 0, 'Hmm, I must\'ve put it over here.', 12, 0, 100, 25, 0, 64656, 0, 0, 'Archmage Khadgar to Player'),
(@KHADGAR, 7, 0, 'Arcane powder... soul shards... that\'s definitely not it...', 12, 0, 100, 0, 0, 64657, 0, 0, 'Archmage Khadgar to Player'),
(@KHADGAR, 8, 0, 'A-ha! Here we are... a crystallized soul. That ought to do the trick!', 12, 0, 100, 0, 0, 64658, 0, 0, 'Archmage Khadgar to Player'),
(@KHADGAR, 9, 0, 'Would you mind grabbing it? These crystals tend to have an adverse effect on non-demonic beings.', 12, 0, 100, 0, 0, 64659, 0, 0, 'Archmage Khadgar to Player'),
(@KHADGAR, 10, 0, 'Be careful, $n. You\'re tapping into magic even Illidan would have considered dangerous.', 12, 0, 100, 0, 0, 64667, 0, 0, 'Archmage Khadgar to Player'),
(@KHADGAR, 11, 0, '$n! Councilors, this is the demon hunter I spoke of.', 12, 0, 100, 0, 0, 64660, 0, 0, 'Archmage Khadgar to Player');
UPDATE `creature` SET `spawntimesecs` = '30' WHERE `guid` = '280000404';
DELETE FROM `spell_area` WHERE `area` = 7334 AND `spell` = 81004;
INSERT INTO `spell_area` (`spell`, `area`, `quest_start`, `quest_end`, `quest_start_status`, `quest_end_status`) VALUES
(81004, 7334, 41220, 38834, 74, 64);
DELETE FROM `script_waypoint` WHERE `entry`=90417;
INSERT INTO `script_waypoint` (`entry`, `pointid`, `location_x`, `location_y`, `location_z`, `waittime`, `point_comment`) VALUES
(90417,1,-848.442,4638.899,749.545,0,'Archmage Khadgar for Ask And You Shall Receive'),
(90417,2,-848.171,4641.024,749.514,0,'Archmage Khadgar for Ask And You Shall Receive'),
(90417,3,-847.318,4647.033,754.076,0,'Archmage Khadgar for Ask And You Shall Receive'),
(90417,4,-846.427,4657.34,761.238,0,'Archmage Khadgar for Ask And You Shall Receive'),
(90417,5,-845.337,4665.472,767.328,0,'Archmage Khadgar for Ask And You Shall Receive'),
(90417,6,-839.465,4667.614,767.667,0,'Archmage Khadgar for Ask And You Shall Receive'),
(90417,7,-837.08,4667.586,767.702,0,'Archmage Khadgar for Ask And You Shall Receive'),
(90417,8,-836.185,4667.269,767.716,0,'Archmage Khadgar for Ask And You Shall Receive'),
(90417,9,-834.92,4666.387,767.722,0,'Archmage Khadgar for Ask And You Shall Receive'),
(90417,10,-833.79,4665.166,767.725,0,'Archmage Khadgar for Ask And You Shall Receive'),
(90417,11,-832.274,4663.507,767.761,0,'Archmage Khadgar stop in the middle'),
(90417,12,-833.934,4661.947,767.682,0,'Archmage Khadgar go to the first chest'),
(90417,13,-830.438,4658.558,767.835,0,'Archmage Khadgar go to the second chest'),
(90417,14,-829.686,4657.596,767.829,0,'Archmage Khadgar go to the second chest'),
(90417,15,-829.414,4656.686,767.816,0,'Archmage Khadgar go to the second chest'),
(90417,16,-829.319,4654.568,767.664,0,'Archmage Khadgar at the second chest'),
(90417,17,-833.367,4664.476,767.725,0,'Archmage Khadgar return to home'),
(90417,18,-840.298,4668.154,767.664,0,'Archmage Khadgar return to home'),
(90417,19,-844.087,4665.268,767.432,0,'Archmage Khadgar return to home'),
(90417,20,-846.585,4652.285,757.706,0,'Archmage Khadgar return to home'),
(90417,21,-848.133,4641.222,749.669,0,'Archmage Khadgar return to home'),
(90417,22,-848.358,4639.632,749.532,0,'Archmage Khadgar return to home');
DELETE FROM `gameobject_loot_template` WHERE `Entry`=246561;
INSERT INTO `gameobject_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(246561, 136385, 0, 100, 1, 1, 0, 1, 1, 'Crystallized Soul');
UPDATE `gameobject_template` SET `IconName`='questinteract', `castBarCaption`='Grabbing', `Data0`=43, `Data1`=246561, `Data14`=37379, `Data30`=53993, `Data31`=1 WHERE `entry`=248521;
UPDATE `creature` SET `spawntimesecs` = '0' WHERE `guid` = '20508639' AND `id` = '90417';
DELETE FROM `gameobject_template` WHERE `entry`=251528;
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `RequiredLevel`, `AIName`, `ScriptName`, `VerifiedBuild`) VALUES
(251528,10,27635,'Legion Communicator','questinteract','','',0.7,93,0,0,30000,0,0,0,0,0,0,0,0,0,0,27700,0,0,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,0,0,'','go_legion_communicator',22423);
UPDATE `gameobject` SET `id` = '251528' WHERE `guid` = '20406041';
DELETE FROM `creature_equip_template` WHERE `CreatureID` IN (99262, 99254, 104909);
INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `AppearanceModID1`, `ItemVisual1`, `ItemID2`, `AppearanceModID2`, `ItemVisual2`, `ItemID3`, `AppearanceModID3`, `ItemVisual3`, `VerifiedBuild`) VALUES
(99262,1,128360,0,0,128370,0,0,0,0,0,25549),
(99254,1,128360,0,0,128370,0,0,0,0,0,25549),
(104909,1,122430,0,0,0,0,0,0,0,0,25549);
UPDATE `creature` SET `equipment_id`='1' WHERE `id` IN ('99254', '99262', '104909');
DELETE FROM `creature_text` WHERE `CreatureID` = 99262;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(99262, 0, 0, 'Allari, report in. Have you located the Warblades?', 12, 0, 100, 1, 0, 64662, 0, 0, 'Jace Darkweaver to Player'),
(99262, 1, 0, 'We have their position. That will have to do.', 12, 0, 100, 1, 0, 64666, 0, 0, 'Jace Darkweaver to Player');
DELETE FROM `creature_text` WHERE `CreatureID` = 104909;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(104909, 0, 0, 'Yes... <garbled> Caria... <garbled> Broken Shore... <garbled> heavy resistance...', 12, 0, 100, 0, 0, 64663, 0, 0, 'Allari the Souleater to Player'),
(104909, 1, 0, 'Damn it all! INCOMING!', 12, 0, 100, 33, 0, 64664, 0, 0, 'Allari the Souleater to Player');
UPDATE `creature_template` SET `scale` = '0.85' WHERE `entry` = '104909';
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_jace_darkweaver_99262' WHERE `entry`='99262';
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_allari_souleater_104909' WHERE `entry`='104909';
DELETE FROM `creature_text` WHERE `CreatureID` = 99254;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(99254, 0, 0, '$n. I have an idea.', 12, 0, 100, 1, 0, 64661, 0, 0, 'Altruis to Player');
UPDATE `creature` SET `position_x`=-864.727, `position_y`=4260.450, `position_z`=745.120, `orientation`=2.93473 WHERE `guid`=20556170;
UPDATE `gameobject` SET `position_x`=-868.421, `position_y`=4261.290 WHERE `guid`=20406041;
-- The Aldrachi Warblades Artifact Scenario
UPDATE `instance_template` SET `script`='scenario_artifact_brokenshore', `parent`=0, `insideResurrection`=1 WHERE `map`=1500;
DELETE FROM `scenarios` WHERE `map` = '1500' AND `scenario_A` = '961';
INSERT INTO `scenarios` (`map`, `difficulty`, `scenario_A`, `scenario_H`) VALUES ('1500', '12', '961', '961');
-- Allari Souleater 98882
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_allari_soulweaver_98882' WHERE `entry`='98882';
DELETE FROM `creature_text` WHERE `CreatureID` = 98882;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(98882, 0, 0, '$n, is that you? Finally some good news.', 14, 0, 100, 0, 0, 58226, 0, 0, 'Allari Souleater to Player'),
(98882, 0, 1, 'Caria left me for dead... the fool!', 12, 0, 100, 0, 0, 58227, 0, 0, 'Allari Souleater to Player'),
(98882, 0, 2, 'My wounds are severe. You\'ll have to push ahead alone.', 12, 0, 100, 0, 0, 58228, 0, 0, 'Allari Souleater to Player'),
(98882, 0, 3, 'I\'ll join you as soon as I\'m able.', 12, 0, 100, 0, 0, 58229, 0, 0, 'Allari Souleater to Player');
DELETE FROM `creature_equip_template` WHERE `CreatureID`=98882;
INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `AppearanceModID1`, `ItemVisual1`, `ItemID2`, `AppearanceModID2`, `ItemVisual2`, `ItemID3`, `AppearanceModID3`, `ItemVisual3`, `VerifiedBuild`) VALUES
(98882,1,122430,0,0,0,0,0,0,0,0,25549);
SET @GUID := 280000405;
DELETE FROM `creature` WHERE `guid` BETWEEN @GUID+1 AND @GUID+47;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(@GUID+1,105125,1500,7796,7797,'1,2,8,12',0,0,0,-1,0,0,-2776.7,-198.007,42.7372,0.412475,900,0,0,0,0,0,0,0,0,0,0,'',26972),
(@GUID+2,105138,1500,7796,7797,'1,2,8,12',0,0,0,-1,0,0,-2779.4,-201.615,42.2245,0.479234,900,0,0,0,0,0,0,0,0,0,0,'',26972),
(@GUID+3,105000,1500,7796,7797,'1,2,8,12',0,0,0,-1,0,0,-2633.39,42.9172,43.3673,0.588264,900,0,0,0,0,0,0,0,0,0,0,'',26972),
(@GUID+4,98975,1500,7796,7797,'1,2,8,12',0,0,0,-1,0,0,-2622.2,48.7097,40.186,1.08621,900,0,0,0,0,0,0,0,0,0,0,'',26972),
(@GUID+5,105125,1500,7796,7797,'1,2,8,12',0,0,0,-1,0,0,-2741.7,-159.902,48.5941,1.51518,900,0,0,0,0,0,0,0,0,0,0,'',26972),
(@GUID+6,105000,1500,7796,7797,'1,2,8,12',0,0,0,-1,0,0,-2624.29,35.2339,42.6158,1.15375,900,0,0,0,0,0,0,0,0,0,0,'',26972),
(@GUID+7,98891,1500,7796,7797,'1,2,8,12',0,0,0,-1,0,0,-2819.03,-211.928,39.2151,0.544413,900,0,0,0,0,0,0,0,0,0,0,'',26972),
(@GUID+8,105138,1500,7796,7797,'1,2,8,12',0,0,0,-1,0,0,-2818.72,-215.646,39.175,0.544413,900,0,0,0,0,0,0,0,0,0,0,'',26972),
(@GUID+9,98891,1500,7796,7797,'1,2,8,12',0,0,0,-1,0,0,-2799.04,-204.15,39.8648,0.322936,900,0,0,0,0,0,0,0,0,0,0,'',26972),
(@GUID+10,98891,1500,7796,7797,'1,2,8,12',0,0,0,-1,0,0,-2798.18,-201.348,39.8876,0.210625,900,0,0,0,0,0,0,0,0,0,0,'',26972),
(@GUID+11,105125,1500,7796,7797,'1,2,8,12',0,0,0,-1,0,0,-2774.94,-202.043,42.4006,0.412475,900,0,0,0,0,0,0,0,0,0,0,'',26972),
(@GUID+12,105125,1500,7796,7797,'1,2,8,12',0,0,0,-1,0,0,-2752.38,-182.139,46.1015,1.03687,900,0,0,0,0,0,0,0,0,0,0,'',26972),
(@GUID+13,105125,1500,7796,7797,'1,2,8,12',0,0,0,-1,0,0,-2754.3,-179.766,46.3346,1.11148,900,0,0,0,0,0,0,0,0,0,0,'',26972),
(@GUID+14,105125,1500,7796,7797,'1,2,8,12',0,0,0,-1,0,0,-2742.02,-165.608,47.9461,1.51518,900,0,0,0,0,0,0,0,0,0,0,'',26972),
(@GUID+15,105000,1500,7796,7797,'1,2,8,12',0,0,0,-1,0,0,-2632.57,40.4857,43.4871,0.941693,900,0,0,0,0,0,0,0,0,0,0,'',26972),
(@GUID+16,105000,1500,7796,7797,'1,2,8,12',0,0,0,-1,0,0,-2609.77,73.9158,35.7398,0.190852,900,0,0,0,0,0,0,0,0,0,0,'',26972),
(@GUID+17,105000,1500,7796,7797,'1,2,8,12',0,0,0,-1,0,0,-2609.57,81.7673,35.7878,6.22271,900,0,0,0,0,0,0,0,0,0,0,'',26972),
(@GUID+18,105000,1500,7796,7797,'1,2,8,12',0,0,0,-1,0,0,-2607.37,79.7441,35.2339,6.23449,900,0,0,0,0,0,0,0,0,0,0,'',26972),
(@GUID+19,105000,1500,7796,7797,'1,2,8,12',0,0,0,-1,0,0,-2607.18,75.669,35.1404,0.0887503,900,0,0,0,0,0,0,0,0,0,0,'',26972),
(@GUID+20,105000,1500,7796,7797,'1,2,8,12',0,0,0,-1,0,0,-2600.5,83.9686,33.7518,5.34856,900,0,0,0,0,0,0,0,0,0,0,'',26972),
(@GUID+21,105000,1500,7796,7797,'1,2,8,12',0,0,0,-1,0,0,-2627.05,48.9812,41.2774,1.12862,900,0,0,0,0,0,0,0,0,0,0,'',26972),
(@GUID+22,105000,1500,7796,7797,'1,2,8,12',0,0,0,-1,0,0,-2616.88,49.1165,39.0248,1.19538,900,0,0,0,0,0,0,0,0,0,0,'',26972),
(@GUID+23,105000,1500,7796,7797,'1,2,8,12',0,0,0,-1,0,0,-2619.78,44.6529,40.2464,1.15611,900,0,0,0,0,0,0,0,0,0,0,'',26972),
(@GUID+24,105000,1500,7796,7797,'1,2,8,12',0,0,0,-1,0,0,-2627.64,35.4816,43.1705,0.937766,900,0,0,0,0,0,0,0,0,0,0,'',26972),
(@GUID+25,105000,1500,7796,7797,'1,2,8,12',0,0,0,-1,0,0,-2597.53,74.1462,32.9812,0.819961,900,0,0,0,0,0,0,0,0,0,0,'',26972),
(@GUID+26,105000,1500,7796,7797,'1,2,8,12',0,0,0,-1,0,0,-2604.85,68.95,34.4744,0.658948,900,0,0,0,0,0,0,0,0,0,0,'',26972),
(@GUID+27,105000,1500,7796,7797,'1,2,8,12',0,0,0,-1,0,0,-2624.87,53.5853,40.0687,1.12469,900,0,0,0,0,0,0,0,0,0,0,'',26972),
(@GUID+28,105000,1500,7796,7797,'1,2,8,12',0,0,0,-1,0,0,-2594.34,82.9146,32.5172,5.84572,900,0,0,0,0,0,0,0,0,0,0,'',26972),
(@GUID+29,105000,1500,7796,7797,'1,2,8,12',0,0,0,-1,0,0,-2593.16,76.8109,32.1264,0.39192,900,0,0,0,0,0,0,0,0,0,0,'',26972),
(@GUID+30,105000,1500,7796,7797,'1,2,8,12',0,0,0,-1,0,0,-2577.3,77.858,26.7235,0.475957,900,0,0,0,0,0,0,0,0,0,0,'',26972),
(@GUID+31,105000,1500,7796,7797,'1,2,8,12',0,0,0,-1,0,0,-2579.34,85.7889,27.3312,5.9117,900,0,0,0,0,0,0,0,0,0,0,'',26972),
(@GUID+32,105000,1500,7796,7797,'1,2,8,12',0,0,0,-1,0,0,-2577.32,89.2888,26.8618,5.2504,900,0,0,0,0,0,0,0,0,0,0,'',26972),
(@GUID+33,105000,1500,7796,7797,'1,2,8,12',0,0,0,-1,0,0,-2574.07,75.537,25.8615,0.374648,900,0,0,0,0,0,0,0,0,0,0,'',26972),
(@GUID+34,98995,1500,7796,7797,'1,2,8,12',0,0,0,-1,0,0,-2572.93,74.152,25.5651,2.45595,900,0,0,0,0,0,0,0,0,0,0,'',26972),
(@GUID+35,98995,1500,7796,7797,'1,2,8,12',0,0,0,-1,0,0,-2574.5,74.1077,25.9783,2.24154,900,0,0,0,0,0,0,0,0,0,0,'',26972),
(@GUID+36,98995,1500,7796,7797,'1,2,8,12',0,0,0,-1,0,0,-2578.97,89.7792,27.2976,5.70594,900,0,0,0,0,0,0,0,0,0,0,'',26972),
(@GUID+37,98995,1500,7796,7797,'1,2,8,12',0,0,0,-1,0,0,-2577.09,91.1646,26.8336,6.05387,900,0,0,0,0,0,0,0,0,0,0,'',26972),
(@GUID+38,99184,1500,7796,7796,'1,2,8,12',0,0,0,-1,0,0,-2749.17,-330.338,38.7842,1.88583,900,0,0,0,0,0,0,0,0,0,0,'',26972),
(@GUID+39,105151,1500,7796,7799,'1,2,8,12',0,0,0,-1,0,0,-2810.06,-243.924,38.6361,1.92589,900,0,0,0,0,0,0,0,0,0,0,'',26972),
-- (@GUID+40,99046,1500,7796,7798,'1,2,8,12',0,0,0,-1,0,0,-2784.22,-98.7661,47.9949,0.511382,900,0,0,0,0,0,0,0,0,0,0,'',26972),
(@GUID+40,105094,1500,7796,7798,'1,2,8,12',0,0,0,-1,0,0,-2746.54,-84.4343,46.6362,1.93767,900,0,0,0,0,0,0,0,0,0,0,'',26972),
(@GUID+41,105095,1500,7796,7798,'1,2,8,12',0,0,0,-1,0,0,-2751.16,-69.521,46.6362,4.99993,900,0,0,0,0,0,0,0,0,0,0,'',26972),
(@GUID+42,98995,1500,7796,7798,'1,2,8,12',0,0,0,-1,0,0,-2680.71,-33.3051,49.843,4.0983,900,0,0,0,0,0,0,0,0,0,0,'',26972),
(@GUID+43,98995,1500,7796,7798,'1,2,8,12',0,0,0,-1,0,0,-2682.25,-35.4171,49.796,0.698307,900,0,0,0,0,0,0,0,0,0,0,'',26972),
(@GUID+44,98995,1500,7796,7798,'1,2,8,12',0,0,0,-1,0,0,-2690.99,-21.124,49.6984,6.02095,900,0,0,0,0,0,0,0,0,0,0,'',26972),
(@GUID+45,98882,1500,7796,7797,'1,2,8,12',0,0,0,-1,0,0,-2507.72,117.919,8.19956,0.0794148,900,0,0,0,0,0,3,0,0,0,0,'',26972),
(@GUID+46,98995,1500,7796,7798,'1,2,8,12',0,0,0,-1,0,0,-2689.22,-20.6522,48.3898,1.48999,900,0,0,0,0,0,0,0,0,0,0,'',26972);
-- Aldrachi Soulwrath SAI
UPDATE `creature_template` SET `AIName`="SmartAI", `minlevel`=100, `maxlevel`=100, `faction`=16, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32832, `HealthModifier`=1 WHERE `entry`=105000;
DELETE FROM `smart_scripts` WHERE `entryorguid`=105000 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(105000,0,0,0,0,0,100,0,5000,8000,12000,15000,11,216265,0,0,0,0,0,2,0,0,0,0,0,0,0,"Aldrachi Soulwraith - In Combat - Cast 'Dark Presence'");
-- Doomherald Akvesh 98975
UPDATE `creature_template` SET `lootid`=98975, `AIName`="SmartAI", `minlevel`=100, `maxlevel`=100, `faction`=16, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32832, `HealthModifier`=5 WHERE `entry`=98975;
DELETE FROM `smart_scripts` WHERE `entryorguid`=98975 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(98975,0,0,0,0,0,100,0,5000,8000,12000,15000,11,215709,0,0,0,0,0,2,0,0,0,0,0,0,0,"Doomherald Akvesh - In Combat - Cast 'Shadowflame'"),
(98975,0,1,0,0,0,100,0,10000,10000,10000,25000,11,215701,0,0,0,0,0,2,0,0,0,0,0,0,0,"Doomherald Akvesh - In Combat - Cast 'Impending Doom'");
DELETE FROM `creature_equip_template` WHERE `CreatureID`=98975;
INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `AppearanceModID1`, `ItemVisual1`, `ItemID2`, `AppearanceModID2`, `ItemVisual2`, `ItemID3`, `AppearanceModID3`, `ItemVisual3`, `VerifiedBuild`) VALUES
(98975,1,134069,0,0,0,0,0,0,0,0,25549);
UPDATE `creature` SET `equipment_id`=1 WHERE `id`=98975;
-- Doomherald Saera 105095
DELETE FROM `creature_template_addon` WHERE `entry`=105095;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `auras`) VALUES 
(105095,0,0,0,1,0,0,0,0,'215837');
UPDATE `creature_template` SET `lootid`=105095, `AIName`='', `ScriptName`='npc_doomherald_saera_105095', `minlevel`=100, `maxlevel`=100, `faction`=16, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32832, `HealthModifier`=5 WHERE `entry`=105095;
DELETE FROM `creature_equip_template` WHERE `CreatureID`=105095;
INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `AppearanceModID1`, `ItemVisual1`, `ItemID2`, `AppearanceModID2`, `ItemVisual2`, `ItemID3`, `AppearanceModID3`, `ItemVisual3`, `VerifiedBuild`) VALUES
(105095,1,126760,0,0,125648,0,0,0,0,0,25549);
UPDATE `creature` SET `equipment_id`=1 WHERE `id`=105095;
DELETE FROM `creature_text` WHERE `CreatureID` = 105095;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(105095, 0, 0, 'Put your back into it, Taraar. Quickly!', 12, 0, 100, 0, 0, 0, 0, 0, 'Doomherald Saera to Player'),
(105095, 0, 1, 'Keep its soul in tact - Caria has plans for this one.', 12, 0, 100, 0, 0, 0, 0, 0, 'Doomherald Saera to Player'),
(105095, 0, 2, 'You are too late... he comes...', 12, 0, 100, 0, 0, 0, 0, 0, 'Doomherald Saera to Player');
-- Doomherald Taraar 105094
DELETE FROM `creature_template_addon` WHERE `entry`=105094;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `auras`) VALUES 
(105094,0,0,0,1,0,0,0,0,'215837');
UPDATE `creature_template` SET `lootid`=105094, `AIName`='', `ScriptName`='npc_doomherald_taraar_105094', `minlevel`=100, `maxlevel`=100, `faction`=16, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32832, `HealthModifier`=5 WHERE `entry`=105094;
DELETE FROM `creature_equip_template` WHERE `CreatureID`=105094;
INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `AppearanceModID1`, `ItemVisual1`, `ItemID2`, `AppearanceModID2`, `ItemVisual2`, `ItemID3`, `AppearanceModID3`, `ItemVisual3`, `VerifiedBuild`) VALUES
(105094,1,126760,0,0,125648,0,0,0,0,0,25549);
UPDATE `creature` SET `equipment_id`=1 WHERE `id`=105094;
DELETE FROM `creature_text` WHERE `CreatureID` = 105094;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(105094, 0, 0, 'Me?! If you\'d focus we would be done by now!', 12, 0, 100, 0, 0, 0, 0, 0, 'Doomherald Taraar to Player'),
(105094, 0, 1, 'At last something reasonable escapes your lips.', 12, 0, 100, 0, 0, 0, 0, 0, 'Doomherald Taraar to Player');
-- Gorgonnash 99046
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_gorgonnash_99046', `minlevel`=100, `maxlevel`=100, `faction`=16, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32832, `HealthModifier`=5 WHERE `entry`=99046;
DELETE FROM `creature_text` WHERE `CreatureID` = 99046;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(99046, 0, 0, 'What\'s that smell? Is that... Illidari?', 12, 0, 100, 0, 0, 58230, 0, 0, 'Gorgonnash to Player'),
(99046, 0, 1, 'Caria must complete her work. You will not intefere.', 12, 0, 100, 0, 0, 58231, 0, 0, 'Gorgonnash to Player'),
(99046, 0, 2, 'Reesh Archim, galar.', 12, 0, 100, 0, 0, 58232, 0, 0, 'Gorgonnash to Player'),
(99046, 0, 3, 'DEATH IS ALL THAT AWAITS YOU!', 12, 0, 100, 0, 0, 58234, 0, 0, 'Gorgonnash to Player');
DELETE FROM `creature_equip_template` WHERE `CreatureID`=99046;
INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `AppearanceModID1`, `ItemVisual1`, `ItemID2`, `AppearanceModID2`, `ItemVisual2`, `ItemID3`, `AppearanceModID3`, `ItemVisual3`, `VerifiedBuild`) VALUES
(99046,1,127648,0,0,0,0,0,0,0,0,25549);
UPDATE `creature` SET `equipment_id`=1 WHERE `id`=99046;
-- Felsoul Legionnaire SAI 105125
SET @FELSOUL_LEGIONAIRE := 105125;
UPDATE `creature_template` SET `lootid`=105125, `AIName`="SmartAI", `minlevel`=100, `maxlevel`=100, `faction`=16, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32832, `HealthModifier`=3 WHERE `entry`=@FELSOUL_LEGIONAIRE;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@FELSOUL_LEGIONAIRE AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@FELSOUL_LEGIONAIRE*100+01,@FELSOUL_LEGIONAIRE*100+02) AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@FELSOUL_LEGIONAIRE,0,1,0,10,0,100,1,1,10,0,0,87,@FELSOUL_LEGIONAIRE*100+01,@FELSOUL_LEGIONAIRE*100+02,0,0,0,0,1,0,0,0,0,0,0,0,"Felsoul Legionnaire - Within 1-10 Range Out of Combat LoS - Run Random Script (No Repeat)"),
(@FELSOUL_LEGIONAIRE,0,2,0,0,0,100,0,5000,8000,12000,15000,11,204092,0,0,0,0,0,1,0,0,0,0,0,0,0,"Felsoul Legionnaire - In Combat - Cast 'Fel Strike'"),
(@FELSOUL_LEGIONAIRE*100+01,9,0,0,0,0,100,0,100,100,0,0,1,0,5000,0,0,0,0,1,0,0,0,0,0,0,0,"Felsoul Legionnaire - On Script - Say Line 0"),
(@FELSOUL_LEGIONAIRE*100+02,9,0,0,0,0,100,0,100,100,0,0,1,1,5000,0,0,0,0,1,0,0,0,0,0,0,0,"Felsoul Legionnaire - On Script - Say Line 1");
DELETE FROM `creature_text` WHERE `CreatureID` = 105125;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `BroadcastTextId`, `comment`) VALUES
(105125, 0, 0, 'You will meet your end!', 12, 0, 100, 0, 0, 53417, 0, 'Felsoul Legionnaire to Player'),
(105125, 1, 0, 'Reinforcements - now!', 12, 0, 100, 0, 0, 53418, 0, 'Felsoul Legionnaire to Player');
DELETE FROM `creature_equip_template` WHERE `CreatureID` IN (105125);
INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `AppearanceModID1`, `ItemVisual1`, `ItemID2`, `AppearanceModID2`, `ItemVisual2`, `ItemID3`, `AppearanceModID3`, `ItemVisual3`, `VerifiedBuild`) VALUES
(105125,1,138754,0,0,0,0,0,0,0,0,25549);
UPDATE `creature` SET `equipment_id`=1 WHERE `id`=105125;
-- Felsoul Chaosweaver 105138
UPDATE `creature_template` SET `lootid`=105138, `AIName`="SmartAI", `minlevel`=100, `maxlevel`=100, `faction`=16, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32832, `HealthModifier`=3 WHERE `entry`=105138;
DELETE FROM `smart_scripts` WHERE `entryorguid`= 105138 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(105138,0,0,0,0,0,100,0,5000,8000,12000,15000,11,216009,0,0,0,0,0,2,0,0,0,0,0,0,0,"Felsoul Chaosweaver - In Combat - Cast 'Corrupting Chaos'"),
(105138,0,1,0,0,0,100,0,0,0,3400,4700,11,183345,64,0,0,0,0,2,0,0,0,0,0,0,0,"Felsoul Chaosweaver - In Combat - Cast 'Shadow Bolt'");
DELETE FROM `creature_equip_template` WHERE `CreatureID`=105138;
INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `AppearanceModID1`, `ItemVisual1`, `ItemID2`, `AppearanceModID2`, `ItemVisual2`, `ItemID3`, `AppearanceModID3`, `ItemVisual3`, `VerifiedBuild`) VALUES
(105138,1,128199,0,0,0,0,0,0,0,0,25549);
UPDATE `creature` SET `equipment_id`=1 WHERE `id`=105138;
-- Felsoul Bloodseeker 98891
UPDATE `creature_template` SET `lootid`=98891, `AIName`="SmartAI", `minlevel`=100, `maxlevel`=100, `faction`=16, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32832, `HealthModifier`=5 WHERE `entry`=98891;
DELETE FROM `smart_scripts` WHERE `entryorguid`= 98891 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(98891,0,0,0,0,0,100,0,5000,8000,12000,15000,11,204885,0,0,0,0,0,2,0,0,0,0,0,0,0,"Felsoul Bloodseeker - In Combat - Cast 'Devour Magic'"),
(98891,0,1,0,0,0,100,0,0,0,9400,14700,11,204896,64,0,0,0,0,2,0,0,0,0,0,0,0,"Felsoul Bloodseeker - In Combat - Cast 'Drain Life'");
-- Aldrachi Revenant SAI
SET @ALDRACHI_REVENANT := 105151;
UPDATE `creature_template` SET `lootid`=105151, `AIName`="SmartAI", `minlevel`=100, `maxlevel`=100, `faction`=16, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32832, `HealthModifier`=5 WHERE `entry`=@ALDRACHI_REVENANT;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ALDRACHI_REVENANT AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ALDRACHI_REVENANT,0,0,0,0,0,100,1,0,0,0,0,1,0,5000,0,0,0,0,1,0,0,0,0,0,0,0,"Aldrachi Revenant- In Combat - Say Line 0 (No Repeat)"),
(@ALDRACHI_REVENANT,0,1,0,0,0,100,0,5000,8000,12000,15000,11,208196,0,0,0,0,0,1,0,0,0,0,0,0,0,"Aldrachi Revenant - In Combat - Cast 'Dark Presence'"),
(@ALDRACHI_REVENANT,0,2,0,0,0,100,0,10000,10000,10000,25000,11,216020,0,0,0,0,0,1,0,0,0,0,0,0,0,"Aldrachi Revenant - In Combat - Cast 'Despair'");
DELETE FROM `creature_text` WHERE `CreatureID` = 105151;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(105151, 0, 0, 'Your soul will be ours...', 12, 0, 100, 0, 0, 0, 0, 0, 'Aldrachi Revenant to Player');
-- Eredar Shadow trapper 108646
UPDATE `creature_template` SET `AIName`='', `minlevel`=100, `maxlevel`=100, `faction`=16, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32832, `HealthModifier`=2 WHERE `entry`=108646;
DELETE FROM `creature_equip_template` WHERE `CreatureID`=108646;
INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `AppearanceModID1`, `ItemVisual1`, `ItemID2`, `AppearanceModID2`, `ItemVisual2`, `ItemID3`, `AppearanceModID3`, `ItemVisual3`, `VerifiedBuild`) VALUES
(108646,1,126793,0,0,0,0,0,0,0,0,25549);
UPDATE `creature` SET `equipment_id`=1 WHERE `id`=108646;
-- Caria Felsoul 99184
UPDATE `creature_template` SET `lootid`=99184, `AIName`='', `ScriptName`='npc_caria_felsoul_99184', `minlevel`=100, `maxlevel`=100, `faction`=16, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32832, `HealthModifier`=5 WHERE `entry`=99184;
DELETE FROM `creature_equip_template` WHERE `CreatureID` IN (99184);
INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `AppearanceModID1`, `ItemVisual1`, `ItemID2`, `AppearanceModID2`, `ItemVisual2`, `ItemID3`, `AppearanceModID3`, `ItemVisual3`, `VerifiedBuild`) VALUES
(99184,1,128832,0,0,0,0,0,0,0,0,25549);
UPDATE `creature` SET `equipment_id`=1 WHERE `id`=9184;
-- Lesser imp (98995)
UPDATE `creature_template` SET `AIName`='', `minlevel`=100, `maxlevel`=100, `faction`=16, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32832, `HealthModifier`=0 WHERE `entry`=98995;
-- Burning Crusher (105103)
UPDATE `creature_template` SET `AIName`='', `minlevel`=100, `maxlevel`=100, `faction`=16, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32832, `HealthModifier`=0 WHERE `entry`=105103;
-- Burning Crusher (105103)
UPDATE `creature_template` SET `AIName`='', `minlevel`=100, `maxlevel`=100, `faction`=16, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32832, `HealthModifier`=0 WHERE `entry`=105103;
-- Felsoul Portals
UPDATE `gameobject_template` SET `type`=10, `displayId`=30007, `IconName`='questinteract', `castBarCaption`='Destroying', `size`=0.66, `Data0`=99, `Data10`=190610, `Data13`=1, `Data14`=24585, `Data20`=1, `Data23`=1, `Data25`=1, `Data26`=0, `AIName`='', `VerifiedBuild`=26822 WHERE `entry` IN ('248517', '248573');
DELETE FROM `gameobject` WHERE `guid` in (51014375, 51014376, 51014377, 51014378);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `isActive`, `ScriptName`, `VerifiedBuild`) VALUES
(51014375,248573,1500,7796,7797,'1,2,8,12',0,0,0,-1,-2648.52,19.5848,48.6442,0.85781,-0,-0,-0.415875,-0.909422,7200,255,0,1,'go_brokenshore_felsoul_portal',26822),
(51014376,248517,1500,7796,7797,'1,2,8,12',0,0,0,-1,-2618.59,78.8602,38.1285,6.15595,-0,-0,-0.0635752,0.997977,7200,255,0,1,'go_brokenshore_felsoul_portal',26822),
(51014377,266029,1500,7796,7797,'1,2,8,12',0,0,0,-1,-2507.57,117.86,8.20133,0.254625,-0,-0,-0.126969,-0.991907,7200,255,1,0,'go_temporary_allari_cage',26822),
(51014378,252400,1500,7796,7797,'1,2,8,12',0,0,0,-1,-2740.67,-149.12,48.4044,1.50511,0,0,0.559193,-0.829037,7200,255,1,0,'go_cavern_stones_7796',26822);
DELETE FROM `gameobject_addon` WHERE `guid` in (51014375, 51014376);
INSERT INTO `gameobject_addon` (`guid`, `parent_rotation0`, `parent_rotation1`, `parent_rotation2`, `parent_rotation3`, `invisibilityType`, `invisibilityValue`, `WorldEffectID`) VALUES
(51014375,0.0664606,0.00581074,0.156891,0.98536,0,0,0),
(51014376,0.0664606,0.00581074,0.156891,0.98536,0,0,0);
DELETE FROM `gameobject_template_addon` WHERE `entry` in (248573, 248517);
INSERT INTO `gameobject_template_addon` (`entry`, `faction`, `flags`, `mingold`, `maxgold`, `WorldEffectID`) VALUES
(248573,0,262176,0,0,0),
(248517,0,262176,0,0,0);
-- Creature Loot
DELETE FROM `creature_loot_template` WHERE `Entry` IN (98975, 105095, 105094, 105125, 105138, 98891, 105151, 99184);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(98975,132204,0,98,0,1,0,1,1,'Doomherald Akvesh: Sticky Volatile Substance'),
(98975,132199,0,2,0,1,0,1,1,'Doomherald Akvesh: Congealed Felblood'),
(98975,137677,0,18,1,1,0,1,1,'Doomherald Akvesh: Fel Blood'),
(105095,132204,0,98,0,1,0,1,1,'Doomherald Saera: Sticky Volatile Substance'),
(105095,132199,0,2,0,1,0,1,1,'Doomherald Saera: Congealed Felblood'),
(105095,138782,0,1,0,1,0,1,1,'Doomherald Saera: Brief History of the Ages'),
(105095,140221,0,2,0,1,0,1,1,'Doomherald Saera: Found Sack of Gems'),
(105095,137677,0,24,1,1,0,1,1,'Doomherald Saera: Fel Blood'),
(105094,132204,0,98,0,1,0,1,1,'Doomherald Taraar: Sticky Volatile Substance'),
(105094,132199,0,2,0,1,0,1,1,'Doomherald Taraar: Congealed Felblood'),
(105094,144345,0,2,0,1,0,1,1,'Doomherald Taraar: Pile of Pet Goodies'),
(105094,137677,0,23,1,1,0,1,1,'Doomherald Taraar: Fel Blood'),
(105125,132204,0,94,0,1,0,1,1,'Felsoul Legionnaire: Sticky Volatile Substance'),
(105125,132199,0,6,0,1,0,1,1,'Felsoul Legionnaire: Congealed Felblood'),
(105125,132231,0,1,0,1,0,1,1,'Felsoul Legionnaire: Worn Hooked Claw'),
(105125,138782,0,0.11,0,1,0,1,1,'Felsoul Legionnaire: Brief History of the Ages'),
(105125,137677,0,23,1,1,0,1,1,'Felsoul Legionnaire: Fel Blood'),
(105125,141064,0,0.09,1,1,0,1,1,'Felsoul Legionnaire: Technique Glyph of Shivarra'),
(105138,132204,0,98,0,1,0,1,1,'Felsoul Chaosweaver: Sticky Volatile Substance'),
(105138,132199,0,2,0,1,0,1,1,'Felsoul Chaosweaver: Congealed Felblood'),
(105138,132231,0,3,0,1,0,1,1,'Felsoul Chaosweaver: Worn Hooked Claw'),
(105138,138782,0,0.5,0,1,0,1,1,'Felsoul Chaosweaver: Brief History of the Ages'),
(105138,138781,0,0.02,0,1,0,1,1,'Felsoul Chaosweaver: Brief History of the Aeons'),
(105138,137677,0,25,1,1,0,1,1,'Felsoul Chaosweaver: Fel Blood'),
(98891,132204,0,3,0,1,0,1,1,'Felsoul Bloodseeker: Sticky Volatile Substance'),
(98891,132231,0,99,0,1,0,1,1,'Felsoul Bloodseeker: Worn Hooked Claw'),
(98891,138781,0,0.02,0,1,0,1,1,'Felsoul Bloodseeker: Brief History of the Aeons'),
(98891,137677,0,24,1,1,0,1,1,'Felsoul Bloodseeker: Fel Blood'),
(105151,132204,0,98,0,1,0,1,1,'Aldrachi Revenant: Sticky Volatile Substance'),
(105151,132199,0,1.2,0,1,0,1,1,'Aldrachi Revenant: Congealed Felblood'),
(105151,138781,0,0.01,0,1,0,1,1,'Aldrachi Revenant: Brief History of the Aeons'),
(105151,137677,0,23,1,1,0,1,1,'Aldrachi Revenant: Fel Blood'),
(99184,132231,0,70,0,1,0,1,1,'Caira Felsoul: Worn Hooked Claw'),
(99184,138782,0,20,0,1,0,1,1,'Caria Felsoul: Brief History of the Ages');
-- Graveyards
DELETE FROM `graveyard_zone` WHERE `GhostZone` IN (7871, 7866, 7864, 7819, 7873);
INSERT INTO `graveyard_zone` (`ID`, `GhostZone`, `Faction`, `Comment`) VALUES
(5135, 7871, 0, 'TombOfThePenitent'),
(5136, 7866, 0, 'TheDemonWard'),
(5137, 7864, 0, 'ChamberOfNight'),
(5344, 7819, 0, 'VaultOfTheBetrayer - Corpse Catcher 1'),
(5345, 7819, 0, 'VaultOfTheBetrayer - Corpse Catcher 2'),
(5346, 7819, 0, 'VaultOfTheBetrayer - Corpse Catcher 3'),
(5347, 7819, 0, 'VaultOfTheBetrayer - Corpse Catcher 4'),
(5348, 7819, 0, 'VaultOfTheBetrayer - Corpse Catcher 5'),
(5349, 7819, 0, 'VaultOfTheBetrayer - Corpse Catcher 6'),
(5350, 7819, 0, 'VaultOfTheBetrayer - Corpse Catcher 7'),
(5356, 7873, 0, 'VaultOfSilence');