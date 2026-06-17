INSERT INTO smart_scripts VALUES ('102600', '0', '0', '0', '62', '0', '100', '0', '20453', '0', '0', '0', '', '33', '102600', '0', '0', '0', '0', '0', '7', '0', '0', '0', '0', '0', '0', '0', 'Smart Script');

INSERT INTO conditions (SourceTypeOrReferenceId, SourceGroup, SourceEntry, SourceId, ElseGroup, ConditionTypeOrReference, ConditionTarget, ConditionValue1, ConditionValue2, ConditionValue3, NegativeCondition, ErrorType, ErrorTextId, ScriptName, Comment) VALUES 
(15, 20453, 0, 0, 0, 9, 0, 40010, 0, 0, 0, 0, 0, '', 'Gossip only if player taken quest 40010');

DELETE FROM `spell_script_names` WHERE `spell_id` in (845);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES 
('845', 'spell_warr_cleave_SpellScript');

-- The Damned quest fix
DELETE FROM `creature_loot_template` WHERE `Entry` IN (1512, 1513) AND `Item` = 3264;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1512, 3264, 0, 80, 1, 1, 0, 1, 1, 'Duskbat Wing for quest: The Damned'),
(1513, 3264, 0, 80, 1, 1, 0, 1, 1, 'Duskbat Wing for quest: The Damned');

-- creature Muad fix duplicate
UPDATE `creature` SET `modelid` = 5243, `position_x` = 2546.78, `position_y` = 1409.32, `position_z` = 5.76295, `orientation` = 0.698132, `spawndist` = 3, `MovementType` = 1 WHERE `guid` = 18008 AND `id` = 1910;
DELETE FROM `creature` WHERE `guid` = 193827;

-- fixed leatherworking trainer in tirisfal glades
DELETE FROM `npc_trainer` WHERE `ID` = 3549;
INSERT INTO `npc_trainer` (`ID`, `SpellID`, `MoneyCost`, `ReqSkillLine`, `ReqSkillRank`, `ReqLevel`, `Index`) VALUES
(3549,2108,10,0,0,0,0),
(3549,2153,50,165,15,0,0),
(3549,3753,75,165,25,0,0),
(3549,3816,50,165,35,0,0),
(3549,2160,100,165,40,0,0),
(3549,3104,500,165,50,0,0),
(3549,2161,100,165,55,0,0),
(3549,226105,100,165,55,0,0),
(3549,3756,150,165,55,0,0),
(3549,2162,100,165,60,0,0),
(3549,226106,150,165,70,0,0),
(3549,9065,150,165,70,0,0),
(3549,226107,150,165,70,0,0),
(3549,3759,200,165,75,0,0),
(3549,3763,300,165,80,0,0),
(3549,3761,350,165,85,0,0),
(3549,226114,350,165,85,0,0),
(3549,226108,350,165,85,0,0),
(3549,2159,250,165,85,0,0),
(3549,226110,350,165,90,0,0),
(3549,226109,350,165,90,0,0),
(3549,226113,400,165,95,0,0),
(3549,9068,400,165,95,0,0),
(3549,226112,400,165,95,0,0),
(3549,20648,500,165,100,0,0),
(3549,2165,250,165,100,0,0),
(3549,3817,200,165,100,0,0),
(3549,2167,350,165,100,0,0),
(3549,226115,350,165,100,0,0),
(3549,226116,350,165,105,0,0),
(3549,226111,350,165,105,0,0),
(3549,226117,350,165,110,0,0),
(3549,2168,350,165,110,0,0),
(3549,226118,400,165,115,0,0),
(3549,7135,400,165,115,0,0),
(3549,9074,500,165,120,0,0),
(3549,2166,450,165,120,0,0),
(3549,226119,500,165,120,0,0),
(3549,226120,500,165,125,0,0),
(3549,3811,5000,165,125,0,0),
(3549,9145,500,165,125,0,0),
(3549,3766,400,165,125,0,0),
(3549,226121,500,165,130,0,0),
(3549,3768,500,165,130,0,0),
(3549,3770,500,165,135,0,0),
(3549,226122,500,165,135,0,0),
(3549,226123,500,165,140,0,0),
(3549,3764,500,165,145,0,0),
(3549,226125,700,165,150,0,0),
(3549,226124,700,165,150,0,0),
(3549,3818,500,165,150,0,0),
(3549,3780,750,165,150,0,0),
(3549,3760,600,165,150,0,0),
(3549,20649,1000,165,150,0,0),
(3549,226126,1000,165,155,0,0),
(3549,226127,1100,165,160,0,0),
(3549,7147,1000,165,160,0,0),
(3549,3774,1000,165,160,0,0),
(3549,226129,1100,165,165,0,0),
(3549,226128,1100,165,165,0,0),
(3549,226130,1100,165,165,0,0),
(3549,7151,1200,165,175,0,0),
(3549,9196,1500,165,175,0,0),
(3549,3776,1200,165,180,0,0),
(3549,9198,2000,165,180,0,0),
(3549,226131,1500,165,180,0,0);

SET @KHADGAR := 90417;
DELETE FROM `creature_text` WHERE `CreatureID` = @KHADGAR;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(@KHADGAR, 0, 0, 'Nobody touch it! Not until our guest arrives.', 12, 0, 100, 1, 0, 67263, 101006, 0, 'Archmage Khadgar to Player'),
(@KHADGAR, 1, 0, 'Any disturbance should catalyze the sequence. Just, uh, give it a poke or something.', 12, 0, 100, 1, 0, 67264, 100058, 0, 'Archmage Khadgar to Player'),
(@KHADGAR, 2, 0, 'Be careful, champion. The land of Suramar has been wild for ten thousand years.', 12, 0, 100, 0, 0, 67271, 100062, 0, 'Archmage Khadgar to Player'),
(@KHADGAR, 3, 0, 'I have just a thing. Follow me.', 12, 0, 100, 0, 0, 64653, 0, 0, 'Archmage Khadgar to Player'),
(@KHADGAR, 4, 0, 'Hold on just a moment. I fear I\'m a bit of a pack rat.', 12, 0, 100, 0, 0, 64654, 0, 0, 'Archmage Khadgar to Player'),
(@KHADGAR, 5, 0, 'Now let\'s see... apexis crystals? No, no, those won\'t do at all.', 12, 0, 100, 0, 0, 64655, 0, 0, 'Archmage Khadgar to Player'),
(@KHADGAR, 6, 0, 'Hmm, I must\'ve put it over here.', 12, 0, 100, 0, 0, 64656, 0, 0, 'Archmage Khadgar to Player'),
(@KHADGAR, 7, 0, 'Arcane powder... soul shards... that\'s definitely not it...', 12, 0, 100, 0, 0, 64657, 0, 0, 'Archmage Khadgar to Player'),
(@KHADGAR, 8, 0, 'A-ha! Here we are... a crystallized soul. That ought to do the trick!', 12, 0, 100, 0, 0, 64658, 0, 0, 'Archmage Khadgar to Player'),
(@KHADGAR, 9, 0, 'Would you mind grabbing it? These crystals tend to have an adverse effect on non-demonic beings.', 12, 0, 100, 0, 0, 64659, 0, 0, 'Archmage Khadgar to Player');

-- zone: Silverpine Forest
UPDATE `quest_template_addon` SET `PrevQuestID`=26965 WHERE `ID`=26989;
UPDATE `quest_template_addon` SET `PrevQuestID`=26965 WHERE `ID`=26992;
UPDATE `quest_template_addon` SET `PrevQuestID`=26965 WHERE `ID`=26995;
UPDATE `quest_template_addon` SET `PrevQuestID`=27096 WHERE `ID`=27097;
UPDATE `quest_template_addon` SET `PrevQuestID`=27195 WHERE `ID`=27290;
UPDATE `quest_template_addon` SET `PrevQuestID`=27098 WHERE `ID`=27180;
UPDATE `quest_template_addon` SET `PrevQuestID`=26998 WHERE `ID`=27039;

DELETE FROM `creature` WHERE `id` = 44630 AND `guid` BETWEEN 307074 AND 307076; -- orgrimmar portals
DELETE FROM `creature` WHERE `id` = 44636; -- hellscreams elites
DELETE FROM `creature` WHERE `id` = 44629 AND `guid` = 307094; -- Garrosh
DELETE FROM `creature` WHERE `guid` IN (187531, 186950, 187009, 187048, 186949, 187534, 187526, 187524, 186826, 187007, 187525, 187530); -- overspawn of fallen humans
DELETE FROM `creature` WHERE `guid` = 306723; -- invisible Cromush
DELETE FROM `creature` WHERE `guid` = 186948; -- invisible Agatha

DELETE FROM `creature_template_addon` WHERE `entry` = 44365;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `auras`) VALUES
(44365, 0, 10718, 0, 0, 0, 0, 0, 0, '');

DELETE FROM `creature_template_addon` WHERE `entry` IN (44592, 44593);
INSERT INTO `creature_template_addon` (`entry`, `mount`, `bytes1`, `bytes2`, `auras`) VALUES
(44592, 0, 0x0, 0x1, '29266'), -- 44592 - 29266
(44593, 0, 0x0, 0x1, '29266'); -- 44593 - 29266

DELETE FROM `creature_addon` WHERE `guid`=307093;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (307093,0,0,0,1,0, '');

DELETE FROM `spell_script_names` WHERE `spell_id` = 83173;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(83173, 'spell_raise_forsaken');

UPDATE `creature_template` SET `InhabitType` = 3, `HoverHeight` = 2.4 WHERE `entry` = 44608;
UPDATE `creature_template` SET `InhabitType` = 3, `HoverHeight` = 1.0 WHERE `entry` = 44592;

DELETE FROM `spell_script_names` WHERE `spell_id` = 83149;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(83149, 'spell_forsaken_trooper_master_script');

UPDATE `creature` SET `spawntimesecs` = 15 WHERE `id` in (44592, 44593);

UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_fallen_human' WHERE `entry` = 44592;
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_fallen_human' WHERE `entry` = 44593;

-- Creature Entry: 44365 (Lady Sylvanas Windrunner)
DELETE FROM `creature_text` WHERE `CreatureID`=44365 AND `GroupID` BETWEEN 0 AND 10;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(44365,  0, 0, 'Where is that ogre-headed buffoon?', 12, 0, 100, 6, 0, 20459, 44695, 0, 'Lady Sylvanas Windrunner to Player'),
(44365,  1, 0, 'Ah, speak of the devil...', 12, 0, 100, 1, 0, 20460, 44696, 0, 'Lady Sylvanas Windrunner to Player'),
(44365,  2, 0, 'Warchief, so glad you could make it.', 12, 0, 100, 1, 0, 20461, 44701, 0, 'Lady Sylvanas Windrunner to Player'),
(44365,  3, 0, 'With the death of the Lich King, many of the more intelligent Scourge became... unemployed. Those \'fiends,\' as you so delicately put it, are called val\'kyr. They are under my command now...', 12, 0, 100, 0, 0, 20462, 44702, 0, 'Lady Sylvanas Windrunner to Player'),
(44365,  4, 0, '...and they are part of the reason that I asked to see you.', 12, 0, 100, 1, 0, 20463, 44703, 0, 'Lady Sylvanas Windrunner to Player'),
(44365,  5, 0, 'Very well, Warchief. I have solved the plight of the Forsaken!', 12, 0, 100, 5, 0, 20464, 44705, 0, 'Lady Sylvanas Windrunner to Player'),
(44365,  6, 0, 'As a race, we Forsaken are unable to procreate.', 12, 0, 100, 274, 0, 20465, 44706, 0, 'Lady Sylvanas Windrunner to Player'),
(44365,  7, 0, 'With the aid of the val\'kyr, we are now able to take the corpses of the fallen and create new Forsaken.', 12, 0, 100, 0, 0, 20466, 44707, 0, 'Lady Sylvanas Windrunner to Player'),
(44365,  8, 0, 'Agatha, show the Warchief!', 12, 0, 100, 22, 0, 20467, 44709, 0, 'Lady Sylvanas Windrunner to Player'),
(44365,  9, 0, 'Warchief, without these new Forsaken my people would die out... Our hold upon Gilneas and northern Lordaeron would crumble.', 12, 0, 100, 0, 0, 20468, 44715, 0, 'Lady Sylvanas Windrunner to Player'),
(44365, 10, 0, 'Isn\'t it obvious, Warchief? I serve the Horde.', 12, 0, 100, 66, 0, 20469, 44718, 0, 'Lady Sylvanas Windrunner to Player');
-- NPC ID: 44629 (Garrosh Hellscream)
DELETE FROM `creature_text` WHERE `CreatureID`=44629 AND `GroupID` BETWEEN 0 AND 9;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(44629, 0, 0, 'This better be important, Sylvanas. You know how I detest this place and its foul stench. Why have you called for me?', 12, 0, 100, 0, 0, 20496, 44699, 0, 'Garrosh Hellscream to Player'),
(44629, 1, 0, 'And more importantly, what are those Scourge fiends doing here?', 12, 0, 100, 0, 0, 20497, 44700, 0, 'Garrosh Hellscream to Player'),
(44629, 2, 0, 'Get on with it, Sylvanas.', 12, 0, 100, 1, 0, 20498, 44704, 0, 'Garrosh Hellscream to Player'),
(44629, 3, 0, 'What you have done here, Sylvanas... it goes against the laws of nature. Disgusting is the only word I have to describe it.', 12, 0, 100, 0, 0, 20499, 44714, 0, 'Garrosh Hellscream to Player'),
(44629, 4, 0, 'Have you given any thought to what this means, Sylvanas?', 12, 0, 100, 6, 0, 20500, 44716, 0, 'Garrosh Hellscream to Player'),
(44629, 5, 0, 'What difference is there between you and the Lich King now?', 12, 0, 100, 6, 0, 20501, 44717, 0, 'Garrosh Hellscream to Player'),
(44629, 6, 0, 'Watch your clever mouth, bitch.', 12, 0, 100, 397, 0, 20502, 44719, 0, 'Garrosh Hellscream to Player'),
(44629, 7, 0, 'Cromush, you stay behind and make sure the Banshee Queen is well "guarded". I will be expecting a full report when next we meet.', 12, 0, 100, 0, 0, 20503, 44720, 0, 'Garrosh Hellscream to Player'),
(44629, 8, 0, 'Remember, Sylvanas, eventually we all have to stand before our maker and face judgment. Your day may come sooner than others....', 12, 0, 100, 0, 0, 20504, 44721, 0, 'Garrosh Hellscream to Player');
-- Entry: 44640 (High Warlord Cromush)
DELETE FROM `creature_text` WHERE `CreatureID`=44640 AND `GroupID` IN (0, 1);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(44640, 0, 0, 'ABBERATION!', 12, 0, 100, 5, 0, 0, 44713, 0, 'High Warlord Cromush to Player'),
(44640, 1, 0, 'As you command, Warchief!', 12, 0, 100, 66, 0, 0, 44738, 0, 'High Warlord Cromush to Player');
-- waypoints for the quest 26965 script
DELETE FROM `waypoint_data` WHERE `id` = 5405701;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(5405701, 1, 1403.424, 1068.805, 60.47655, 4.074228, 500, 1, 0, 100, 0),
(5405701, 2, 1403.424, 1068.805, 60.47655, 4.074228, 0, 1, 0, 100, 0),
(5405701, 3, 1407.501, 1081.586, 60.47925, 1.364602, 0, 1, 0, 100, 0),
(5405701, 4, 1406.427, 1086.022, 60.47925, 1.808352, 0, 1, 0, 100, 0),
(5405701, 5, 1400.381, 1089.976, 59.97032, 2.562335, 0, 1, 0, 100, 0),
(5405701, 6, 1378.655, 1081.227, 52.49874, 3.524448, 0, 1, 0, 100, 0),
(5405701, 7, 1371.423, 1073.132, 53.25177, 4.097788, 0, 1, 0, 100, 0),
(5405701, 8, 1371.143, 1055.494, 53.11386, 4.698616, 0, 1, 0, 100, 0),
(5405701, 9, 1377.207, 1046.097, 53.56214, 5.307295, 0, 1, 0, 100, 0),
(5405701, 10, 1377.207, 1046.097, 53.56214, 4.376599, 500, 1, 0, 100, 0);
DELETE FROM `waypoint_data` WHERE `id` = 5405702;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(5405702, 1, 1377.207, 1046.097, 53.56214, 4.376599, 500, 1, 0, 100, 0),
(5405702, 2, 1377.207, 1046.097, 53.56214, 5.307295, 0, 1, 0, 100, 0),
(5405702, 3, 1371.143, 1055.494, 53.11386, 4.698616, 0, 1, 0, 100, 0),
(5405702, 4, 1371.423, 1073.132, 53.25177, 4.097788, 0, 1, 0, 100, 0),
(5405702, 5, 1378.655, 1081.227, 52.49874, 3.524448, 0, 1, 0, 100, 0),
(5405702, 6, 1400.381, 1089.976, 59.97032, 2.562335, 0, 1, 0, 100, 0),
(5405702, 7, 1406.427, 1086.022, 60.47925, 1.808352, 0, 1, 0, 100, 0),
(5405702, 8, 1407.501, 1081.586, 60.47925, 1.364602, 0, 1, 0, 100, 0),
(5405702, 9, 1403.424, 1068.805, 60.47655, 4.074228, 0, 1, 0, 100, 0),
(5405702, 10, 1403.424, 1068.805, 60.47655, 1.189128, 500, 1, 0, 100, 0);
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_grand_executor_mortuus' WHERE `entry`=44615;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_fallen_human_44592' WHERE `entry`=44592;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_fallen_human_44592' WHERE `entry`=44593;
UPDATE `creature_template_addon` SET `auras`='' WHERE `entry`=44608;
UPDATE `creature` SET `spawndist`=0, `MovementType`=0 WHERE `id`=45120;
DELETE FROM `creature_text` WHERE `CreatureID`=44825 AND `GroupID`=0;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(44825, 0, 0, 'You better bring that bat back in one piece, $n!', 12, 0, 100, 1, 0, 0, 44906, 0, 'Bat Handler Maggotbreath to Player');
UPDATE `creature_template` SET `gossip_menu_id`=11892, `AIName`='', `ScriptName`='npc_bat_handler_maggotbreath' WHERE `entry`=44825;
DELETE FROM `gossip_menu_option` WHERE `MenuId`=11892;
INSERT INTO `gossip_menu_option` (`MenuId`, `OptionIndex`, `OptionIcon`, `OptionText`, `OptionBroadcastTextId`, `OptionType`, `OptionNpcFlag`, `VerifiedBuild`) VALUES
(11892, 0, 0, 'I need to take a bat to the Dawning Isles.', 44905, 1, 1, 25549),
(11892, 1, 0, 'Show me where I can fly.', 12271, 4, 8192, 25549);
UPDATE `creature_template` SET `spell1`=83573 WHERE `entry`=44821;
UPDATE `creature_template` SET `gossip_menu_id`=11892, `AIName`='', `ScriptName`='npc_forsaken_bat' WHERE `entry`=44821;
DELETE FROM `creature_text` WHERE `CreatureId`=44821 AND `GroupId` BETWEEN 0 AND 1;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES 
(44821, 0, 0, "Eliminate all murlocs by using the Blight Concoction!$B$B|r|TInterface\Icons\INV_ALCHEMY_POTION_05.BLP:24|t", 42, 0, 100, 0, 0, 0, 44902, 0, 'Forsaken Bat to Player'),
(44821, 1, 0, "Returning to Forsaken High Command!$B$B|r|TInterface\Icons\ACHIEVEMENT_ZONE_SILVERPINE_01.BLP:24|t", 42, 0, 100, 0, 0, 0, 44903, 0, 'Forsaken Bat to Player');
DELETE FROM `npc_spellclick_spells` WHERE `npc_entry`=44821;
INSERT INTO `npc_spellclick_spells` (`npc_entry`, `spell_id`, `cast_flags`, `user_type`) VALUES
(44821, 46598, 1, 0);
DELETE FROM `creature` WHERE `id` in (44899, 1950, 1951);
UPDATE `gameobject_template` SET `AIName`='', `ScriptName`='go_abandoned_outhouse' WHERE `entry`=205143;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_deathstalker_rane_yorick' WHERE `entry`=44882;
UPDATE `creature_template_addon` SET `auras`='' WHERE `entry`=44882;
DELETE FROM `waypoint_data` WHERE `id`=4488201;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(4488201, 0, 1299.866, 1189.733, 52.11713, 2.450426, 0, 0, 0, 100, 0),
(4488201, 1, 1290.530, 1196.473, 52.41762, 2.493623, 0, 0, 0, 100, 0),
(4488201, 2, 1289.968, 1200.791, 52.65834, 1.700370, 0, 0, 0, 100, 0),
(4488201, 3, 1290.122, 1205.708, 52.71643, 1.539364, 0, 0, 0, 100, 0),
(4488201, 4, 1293.603, 1207.071, 53.53426, 0.373047, 0, 0, 0, 100, 0),
(4488201, 5, 1299.119, 1207.071, 53.74656, 0.325923, 0, 0, 0, 100, 0),
(4488201, 6, 1303.736, 1210.398, 53.74656, 0.930680, 0, 0, 0, 100, 0),
(4488201, 7, 1304.215, 1212.665, 53.74656, 1.362649, 0, 0, 0, 100, 0),
(4488201, 8, 1303.619, 1219.871, 53.74656, 1.653246, 0, 0, 0, 100, 0),
(4488201, 9, 1300.441, 1222.615, 53.74656, 2.438645, 0, 0, 0, 100, 0),
(4488201, 10, 1297.949, 1220.368, 53.74656, 3.942683, 0, 0, 0, 100, 0),
(4488201, 11, 1297.620, 1212.439, 58.48082, 4.068350, 0, 0, 0, 100, 0),
(4488201, 12, 1297.639, 1210.122, 58.47509, 4.720230, 0, 0, 0, 100, 0),
(4488201, 13, 1301.660, 1206.269, 58.49411, 5.537040, 0, 0, 0, 100, 0),
(4488201, 14, 1311.437, 1206.490, 58.51025, 6.259605, 0, 0, 0, 100, 0),
(4488201, 15, 1312.644, 1208.443, 58.51212, 1.017072, 0, 0, 0, 100, 0);
DELETE FROM `creature_text` WHERE `CreatureID`=44882 AND `GroupID` BETWEEN 0 AND 2;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(44882, 0, 0, 'Crowley wants to get there shortly, Let\'s go! ', 12, 0, 100, 5, 0, 0, 44951, 0, 'Deathstalker Yorick to Player'),
(44882, 1, 0, 'THERE! Hide in the armoire! I\'ll hide in the shadows next to you. ', 12, 0, 100, 25, 0, 0, 44955, 0, 'Deathstalker Yorick to Player'),
(44882, 2, 0, 'I live ... and the ... for the Banshee Queen. ', 12, 0, 100, 0, 0, 0, 44971, 0, 'Deathstalker Yorick to Player');
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_armoire' WHERE `entry`=44893;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_armoire_next' WHERE `entry`=44894;
UPDATE `creature_template` SET `unit_flags`=8 WHERE `entry`=44893;
UPDATE `creature_template_addon` SET `bytes1`=131072 WHERE `entry`=44893;
DELETE FROM `waypoint_data` WHERE `id`=4488301;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(4488301, 0, 1299.36, 1206.64, 58.5706, 0, 0, 0, 0, 100, 0),
(4488301, 1, 1300.36, 1206.64, 58.5706, 0, 0, 0, 0, 100, 0),
(4488301, 2, 1302.33, 1206.44, 58.4990, 0, 0, 0, 0, 100, 0),
(4488301, 3, 1305.32, 1206.43, 58.5126, 0, 0, 0, 0, 100, 0),
(4488301, 4, 1313.48, 1206.09, 58.5119, 0, 0, 0, 0, 100, 0),
(4488301, 5, 1313.48, 1206.09, 58.5119, 0, 0, 0, 0, 100, 0);
DELETE FROM `waypoint_data` WHERE id=4488401;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(4488401, 0, 1296.20, 1210.54, 58.5533, 0, 0, 0, 0, 100, 0),
(4488401, 1, 1297.20, 1210.54, 58.5533, 0, 0, 0, 0, 100, 0),
(4488401, 2, 1302.31, 1206.61, 58.4984, 0, 0, 0, 0, 100, 0),
(4488401, 3, 1308.40, 1206.28, 58.5109, 0, 0, 0, 0, 100, 0),
(4488401, 4, 1308.40, 1206.28, 58.5109, 0, 0, 0, 0, 100, 0);
DELETE FROM `creature_text` WHERE `CreatureID`=44884;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(44884, 0, 0, 'Why trust you now, Crowley? You abandoned us. Left us to die.', 12, 0, 100, 6, 0, 0, 44959, 0, 'Ivar to Player'),
(44884, 1, 0, 'I don\'t care about your war, Crowley.', 12, 0, 100, 274, 0, 0, 44962, 0, 'Ivar to Player'),
(44884, 2, 0, 'But...', 12, 0, 100, 1, 0, 0, 44963, 0, 'Ivar to Player'),
(44884, 3, 0, 'I have seen firsthand what the Forsaken are capable of doing. It is true. They hunt us... slaughter the defenseless.', 12, 0, 100, 1, 0, 0, 44884, 0, 'Ivar to Player'),
(44884, 4, 0, 'Aye, I will gather my pack... we...', 12, 0, 100, 1, 0, 0, 44966, 0, 'Ivar to Player'),
(44884, 5, 0, 'It would appear that we are being watched, Crowley. You have grown soft... Likely Greymane\'s fault.', 12, 0, 100, 1, 0, 0, 44968, 0, 'Ivar to Player'),
(44884, 6, 0, 'Treacherous little pup!', 12, 0, 100, 15, 0, 0, 44969, 0, 'Ivar to Player'),
(44884, 7, 0, 'What say you now, spy?', 12, 0, 100, 0, 0, 0, 44970, 0, 'Ivar to Player'),
(44884, 8, 0, 'I was hoping you\'d say that...', 12, 0, 100, 0, 0, 0, 44972, 0, 'Ivar to Player'),
(44884, 9, 0, 'I will prepare the pack. It will take some time to gather them all, but we will join... for now.', 12, 0, 100, 1, 0, 0, 44973, 0, 'Ivar to Player');
DELETE FROM `creature_text` WHERE `CreatureID`=44883 AND `GroupID` IN (0, 1, 2, 3);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(44883, 0, 0, 'Have you given any more thought to my proposal, Ivar?', 12, 0, 100, 6, 0, 0, 44957, 0, 'Lord Darius Crowley to Player'),
(44883, 1, 0, 'If we\'re to win this war we will need your help. Our packs must unite! The Forsaken will destroy us otherwise.', 12, 0, 100, 396, 0, 0, 44960, 0, 'Lord Darius Crowley to Player'),
(44883, 2, 0, 'You are the alpha male, Ivar. The rest of the ferals in Silverpine will do as you command.', 12, 0, 100, 397, 0, 0, 44961, 0, 'Lord Darius Crowley to Player'),
(44883, 3, 0, 'So you will help?', 12, 0, 100, 6, 0, 0, 44965, 0, 'Lord Darius Crowley to Player');
DELETE FROM `npc_spellclick_spells` WHERE `npc_entry`=44894;
INSERT INTO `npc_spellclick_spells` (`npc_entry`, `spell_id`, `cast_flags`, `user_type`) VALUES
(44894, 46598, 1, 0);
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_lord_darius_crowley' WHERE `entry`=44883;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_packleader_ivar_bloodfang' WHERE `entry`=44884;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_44365_lady_sylvanas_windrunner' WHERE `entry`=44365;
UPDATE `creature_template` SET `npcflag`=16777216 WHERE `entry`=44894;
UPDATE `creature` SET `spawndist`='0', `MovementType`='0' WHERE `guid`='186740';
UPDATE `creature` SET `spawndist`='0', `MovementType`='0' WHERE `id`='44790';
UPDATE `quest_template_addon` SET `PrevQuestID`=27045 WHERE `ID`=27056;
UPDATE `quest_template_addon` SET `PrevQuestID`=27056 WHERE `ID`=27065;
UPDATE `quest_template_addon` SET `PrevQuestID`=27065 WHERE `ID`=27069;
UPDATE `quest_template_addon` SET `PrevQuestID`=27069 WHERE `ID`=27093;
UPDATE `quest_template_addon` SET `PrevQuestID`=27093 WHERE `ID`=27096;
UPDATE `quest_template_addon` SET `PrevQuestID`=27082 WHERE `ID`=27088;
UPDATE `quest_template_addon` SET `PrevQuestID`=27095 WHERE `ID`=27094;
UPDATE `quest_template_addon` SET `PrevQuestID`=27097 WHERE `ID`=27099;
UPDATE `quest_template_addon` SET `PrevQuestID`=27099 WHERE `ID`=27098;
UPDATE `quest_template_addon` SET `PrevQuestID`=27065 WHERE `ID`=27082;
UPDATE `quest_template_addon` SET `PrevQuestID`=27098 WHERE `ID`=27231;
UPDATE `quest_template_addon` SET `PrevQuestID`=27065 WHERE `ID`=27073;
UPDATE `quest_template_addon` SET `PrevQuestID`=27098 WHERE `ID`=27226;
UPDATE `quest_template_addon` SET `NextQuestID`=27069 WHERE `ID`=27095;
UPDATE `quest_template` SET `Flags`=8388608 WHERE `ID`=27095;
UPDATE `gameobject` SET `position_z`=27.9789 WHERE `guid`=1468 AND `id`=106319;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_orc_sea_pup' WHERE `entry`=44914;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_admiral_hatchet' WHERE `entry`=44916;
DELETE FROM `creature_text` WHERE `CreatureID`=44734 AND `GroupID`=0;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(44734, 0, 0, 'ALL ABOARD! Next stop: The Sepulcher.', 12, 0, 100, 0, 0, 0, 44796, 0, 'Creature to Player');
DELETE FROM `creature_text` WHERE `CreatureID`=44916 AND `GroupID` BETWEEN 0 AND 1;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(44916, 0, 0, 'Who\'s not drunk, Torok?', 12, 0, 100, 0, 0, 0, 45018, 0, 'Admiral Hatchet to Player'),
(44916, 1, 0, 'Yes.', 12, 0, 100, 0, 0, 0, 45020, 0, 'Admiral Hatchet to Player');

DELETE FROM `creature_text` WHERE `CreatureID`=44917 AND `GroupID` BETWEEN 0 AND 1;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(44917, 0, 0, 'Including me?', 12, 0, 100, 6, 0, 0, 45019, 0, 'Warlord Torok to Player'),
(44917, 1, 0, '<hic!> Well... Let\'s see... By my count, nobody. The whole crew\'s drunk out of their gourds, admiral... \'cept the sea pups... <hic!>', 12, 0, 100, 0, 0, 0, 45021, 0, 'Warlord Torok to Player');

DELETE FROM `creature_text` WHERE `CreatureID`=44914 AND `GroupID` BETWEEN 0 AND 7;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(44914, 0, 0, 'Where to going, captain?', 12, 0, 100, 66, 0, 0, 44990, 0, 'Orc Sea Pup to Player'),
(44914, 1, 0, 'Dis not so bad. Maybe little heavy, but me ok.', 12, 0, 100, 0, 0, 0, 44991, 0, 'Orc Sea Pup to Player'),
(44914, 2, 0, 'Maybe captain carry one box too?', 12, 0, 100, 0, 0, 0, 44994, 0, 'Orc Sea Pup to Player'),
(44914, 3, 0, 'Captain, pup need help!', 12, 0, 100, 0, 0, 0, 44996, 0, 'Orc Sea Pup to Player'),
(44914, 4, 0, 'Please, captain, I can put box down?', 12, 0, 100, 0, 0, 0, 44999, 0, 'Orc Sea Pup to Player'),
(44914, 5, 0, 'Please... Kill... Me...', 12, 0, 100, 0, 0, 0, 45001, 0, 'Orc Sea Pup to Player'),
(44914, 6, 0, 'OOF!', 12, 0, 100, 0, 0, 0, 45024, 0, 'Orc Sea Pup to Player'),
(44914, 7, 0, 'Where to put? Dey falling! HELP!', 12, 0, 100, 0, 0, 0, 45025, 0, 'Orc Sea Pup to Player');

DELETE FROM `spell_script_names` WHERE `spell_id` IN (83865, 83838);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(83865, 'spell_sea_pup_trigger_83865'),
(83838, 'spell_pick_up_orc_crate_83838');
UPDATE `quest_template_addon` SET `SourceSpellID`=83865 WHERE `ID`=27069;
DELETE FROM `creature` WHERE `id`=44915;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='' WHERE `entry`=44915;
DELETE FROM `gossip_menu_option` WHERE `MenuId`=11901;
INSERT INTO `gossip_menu_option` (`MenuId`, `OptionIndex`, `OptionIcon`, `OptionText`, `OptionBroadcastTextId`, `OptionType`, `OptionNpcFlag`, `VerifiedBuild`) VALUES
(11901, 0, 0, 'I seem to have misplaced my sea pup, admiral. Do you have another that you could lend to me?', 45023, 1, 1, 25549);
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=11901;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(15,11901,0,0,9,27069,0,0,0,'','Show gossip option 0 if player has Quest 27069 "Steel Thunder"');
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_webbed_victim_skitterweb' WHERE `entry`=44941;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_orc_sea_dog' WHERE `entry`=44942;
-- VIOLET HOLD
-- gameobjects for the special violet hold TO DO
DELETE FROM `gameobject` WHERE `guid` BETWEEN 51014366 AND 51014370;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `isActive`, `ScriptName`, `VerifiedBuild`) VALUES
(51014366,246994,1494,0,0,12,0,0,0,-1,4698.6,3996.12,96.72,4.37254,0,0,-0.8165,0.577346,7200,255,1,0,'',22423),
(51014367,246993,1494,0,0,12,0,0,0,-1,4701.84,4014.68,96.72,4.67504,0,0,-0.720187,0.69378,7200,255,1,0,'',22423),
(51014368,246992,1494,0,0,12,0,0,0,-1,4699.06,4033.99,96.72,5.01651,0,0,-0.591837,0.806058,7200,255,1,0,'',22423),
(51014369,247544,1494,0,0,12,0,0,0,-1,4646.22,4038.95,77.6499,3.14159,0,0,-1,0,7200,255,1,0,'',22423),
(51014370,247385,1494,0,0,12,0,0,0,-1,4681.17,3967.49,76.2686,3.97984,0,0,-0.913445,0.406961,7200,255,1,0,'',22423);

-- availbale ones
DELETE FROM `gameobject` WHERE `guid` in (51014371, 51014372, 51014373, 51014374);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `isActive`, `ScriptName`, `VerifiedBuild`) VALUES
(51014371,193019,1220,7502,7592,0,0,171,0,-1,-960.317,4325.154,740.212,0.890117,0,0,0.430511,0.902586,300,100,1,0,'',22423),
(51014372,193609,1220,7502,7592,0,0,171,0,-1,-969.812,4314.12,742.18,0.908608,0,0,0.438837,0.898567,180,0,1,0,'go_violethold_entrance_portal',22423),
(51014373,193020,1220,7502,7592,0,0,171,0,-1,-970.863,4317.45,739.721,0.890117,0,0,0.430511,0.902586,180,0,1,0,'',22423),
(51014374,193609,1494,0,0,12,0,0,0,-1,1245.352,-262.682,44.363,3.16211,0,0,0.430511,0.902586,180,0,1,0,'go_violethold_exit_portal',22423);

-- creatures for special violet hold
DELETE FROM `creature` WHERE `guid` in (280000402, 280000403);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(280000402,99473,1494,0,0,12,0,0,0,-1,0,0,1290.730,-264.305,44.364,0.06528,120,0,0,0,0,0,0,0,0,0,0,'npc_warden_alturas_vh',25549), -- Alturas
(280000403,103156,1494,0,0,12,0,0,0,-1,0,0,1300.655,-259.887,44.272,0.05115,120,0,0,800,0,0,2,0,0,0,0,'',25549); -- Altruis

update creature set equipment_id=0 where id=36346;

delete from vehicle_template_accessory where entry=28451 and accessory_entry=28468;
delete from vehicle_template_accessory where entry=28468 and accessory_entry=28451;

UPDATE quest_template SET RequiredNpcOrGo1=44175 WHERE Id=24968;

UPDATE creature_template SET KillCredit1=44175 WHERE entry=44794;

UPDATE locales_quest SET OfferRewardText_loc3="Gluckwunsch... Einen Schritt naher, ein Meister der dunklen Kunste zu sein. Geht und ubt was Ihr gelernt habt, und kehrt zu mir zuruck, wenn Ihr starker geworden seid. Ich werde Euch dann mehr beibringen.", CompletedText_loc3="Kehrt zuruck zu Maximillion in Todesend ", ObjectiveText1_loc3="Praktiziert Feuerbrand", QuestGiverTextWindow_loc3="Trainingsattrappe", QuestGiverTargetName_loc3="Trainingsattrappe" WHERE Id=24968;

UPDATE creature_template SET KillCredit1=1890 WHERE entry=1501;

UPDATE quest_template SET RequiredRaces=946 WHERE Id=26550;

UPDATE quest_template SET RequiredRaces=2098253 WHERE Id=26809;

UPDATE gossip_menu_option SET OptionBroadcastTextID=43278, option_id=1, npc_option_npcflag=1 WHERE menu_id=11711 AND id=1;

delete from playercreateinfo_spell where spell=21184;

delete from playercreateinfo_spell_custom where spell=21184;

UPDATE gameobject_template SET ScriptName="go_totem_of_hireek_204361" WHERE entry=204361;

UPDATE creature_template SET ScriptName="npc_wings_of_hireek_43241" WHERE entry=43241;

UPDATE creature_addon SET path_id=0 WHERE guid=23606;

update creature set MovementType=0 where guid=23606;

DELETE FROM waypoint_data WHERE id=4324101;
INSERT INTO waypoint_data VALUES 
(4324101, 0, -13355.46, -27.00635, 29.44026, 2.296905, 0, 1, 0, 100, 0),
(4324101, 1, -13414.58, 51.79816, 50.77106, 2.241927, 0, 1, 0, 100, 0),
(4324101, 2, -13437.19, 60.55619, 51.91462, 2.772071, 0, 1, 0, 100, 0),
(4324101, 3, -13461.38, 48.5985, 50.07495, 3.600666, 0, 1, 0, 100, 0),
(4324101, 4, -13512.21, -30.01856, 52.60163, 4.185785, 0, 1, 0, 100, 0),
(4324101, 5, -13554.48, -159.7719, 65.9166, 4.401769, 0, 1, 0, 100, 0),
(4324101, 6, -13579.08, -226.4927, 55.10126, 4.342866, 0, 1, 0, 100, 0),
(4324101, 7, -13632.46, -267.0449, 38.59391, 3.820577, 0, 1, 0, 100, 0),
(4324101, 8, -13656.7, -280.7307, 31.21223, 3.667424, 0, 1, 0, 100, 0),
(4324101, 9, -13668.84, -307.8107, 31.17233, 4.393916, 0, 1, 0, 100, 0),
(4324101, 10, -13657.92, -335.2852, 27.2471, 5.273562, 0, 1, 0, 100, 0),
(4324101, 11, -13646.92, -329.5979, 20.36576, 1.036335, 0, 1, 0, 100, 0),
(4324101, 12, -13645.7, -325.3626, 17.69689, 1.452596, 0, 1, 0, 100, 0),
(4324101, 13, -13649.35, -320.3016, 14.33958, 2.10055, 0, 1, 0, 100, 0),
(4324101, 14, -13649.7, -319.7023, 14.33208, 2.10055, 0, 1, 0, 100, 0);

DELETE FROM creature_text WHERE entry=43245;
INSERT INTO creature_text VALUES 
(43245, 1, 0, "Jin'do the Hexxer!  It's been a while since I've seen that mask.", 12, 0, 100, 0, 0, 0, "Zanzil the Outcast", 43362),
(43245, 2, 0, "What brings you out to my part of Stranglethorn?  I'm not accustomed to taking visitors from the esteemed Zul'Gurub.", 12, 0, 100, 0, 0, 0, "Zanzil the Outcast", 43363),
(43245, 3, 0, "What a shame... but not a concern for an old exile like Zanzil.", 12, 0, 100, 0, 0, 0, "Zanzil the Outcast", 43366),
(43245, 4, 0, "Friend?  You were among those who spit and threw stones, Jin'do.  But let's let bygones be bygones, eh?", 12, 0, 100, 0, 0, 0, "Zanzil the Outcast", 43369),
(43245, 5, 0, "So your bat and your snake need Zanzil's help?  Very well.  I'll see you inside Zul'Gurub... old friend.", 12, 0, 100, 0, 0, 0, "Zanzil the Outcast", 43370);

DELETE FROM creature_text WHERE entry=43246;
INSERT INTO creature_text VALUES 
(43246, 1, 0, "You know well enough about why I'm here, Zanzil.", 12, 0, 100, 0, 0, 0, "Shade of the Hexxer", 43364),
(43246, 2, 0, "The Gurubashi have fallen on hard times.  I live, and Mandokir has returned... but the rest of us are gone.", 12, 0, 100, 0, 0, 0, "Shade of the Hexxer", 43365),
(43246, 3, 0, "Well, Zanzil, I'd like to make it your concern.  I've recovered the bodies of High Priestess Jeklik and High Priest Venoxis.", 12, 0, 100, 0, 0, 0, "Shade of the Hexxer", 43367),
(43246, 4, 0, "I remember what you can do with those elixirs of yours.  Can your elixirs help out an old friend?", 12, 0, 100, 0, 0, 0, "Shade of the Hexxer", 43368);

delete from gossip_menu where entry=15145;

UPDATE creature_template SET InhabitType=4 WHERE entry=43241;

delete from creature where guid=66627;

UPDATE quest_template SET RequiredRaces=2098253 WHERE Id in (26810, 26811, 26812, 26813, 26814);

UPDATE quest_template SET RequiredRaces=946 WHERE Id in (26551, 26552, 26553, 26554, 26555);