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
(251528,10,27635,'Legion Communicator','questinteract','','',0.7,93,0,0,30000,0,0,0,0,0,0,37020,0,0,0,27700,0,0,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,0,0,'','',22423);
UPDATE `gameobject` SET `id` = '251528' WHERE `guid` = '20406041';
DELETE FROM `creature_equip_template` WHERE `CreatureID` IN (99262, 99254);
INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `AppearanceModID1`, `ItemVisual1`, `ItemID2`, `AppearanceModID2`, `ItemVisual2`, `ItemID3`, `AppearanceModID3`, `ItemVisual3`, `VerifiedBuild`) VALUES
(99262,1,128360,0,0,128370,0,0,0,0,0,25549),
(99254,1,128360,0,0,128370,0,0,0,0,0,25549);
UPDATE `creature` SET `equipment_id`='1' WHERE `id` IN ('99254', '99262');
DELETE FROM `creature_text` WHERE `CreatureID` = 99262;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(99262, 0, 0, 'Allari, report in. Have you located the Warblades?', 12, 0, 100, 1, 0, 64662, 101006, 0, 'Jace Darkweaver to Player'),
(99262, 1, 0, 'We have their position. That will have to do.', 12, 0, 100, 1, 0, 64665, 101006, 0, 'Jace Darkweaver to Player');
DELETE FROM `creature_text` WHERE `CreatureID` = 104909;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(104909, 0, 0, 'Yes... <garbled> Caria... <garbled> Broken Shore... <garbled> heavy resistance...', 12, 0, 100, 1, 0, 64663, 101006, 0, 'Allari the Souleater to Player'),
(104909, 1, 0, 'Damn it all! INCOMING!', 12, 0, 100, 1, 0, 64664, 101006, 0, 'Allari the Souleater to Player');
UPDATE `creature_template` SET `scale` = '0.85' WHERE `entry` = '104909'; 