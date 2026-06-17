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
-- NO ESCAPE
DELETE FROM `creature` WHERE `id`=44951 AND `guid`=20343401;
UPDATE `creature_template` SET `InhabitType`=4 WHERE `entry`=45003;
UPDATE `creature_template` SET `InhabitType`=4, `HoverHeight`=2 WHERE `entry`=44951;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_agatha_44951' WHERE `entry`=44951;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_camera_45003' WHERE `entry`=45003;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_fenris_keep_stalker_45032' WHERE `entry`=45032;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_lord_darius_crowley_44989' WHERE `entry`=44989;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_phin_odelic_44993' WHERE `entry`=44993;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_bartolo_ginsetti_44994' WHERE `entry`=44994;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_loremaster_dibbs_44995' WHERE `entry`=44995;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_magistrate_henry_maleb_44996' WHERE `entry`=44996;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_caretaker_smithers_44997' WHERE `entry`=44997;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_sophia_zwoski_45002' WHERE `entry`=45002;
DELETE FROM `creature_text` WHERE `CreatureID`=44989 AND `GroupID` BETWEEN 0 AND 5;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(44989, 0, 0, 'The Forsaken have broken through your defenses, magistrate.', 12, 0, 100, 396, 0, 0, 45161, 0, 'Lord Darius Crowley to Magistrate'),
(44989, 1, 0, 'You are out of time.', 12, 0, 100, 274, 0, 0, 45162, 0, 'Lord Darius Crowley to Magistrate'),
(44989, 2, 0, 'A decision must be made!', 12, 0, 100, 5, 0, 0, 45163, 0, 'Lord Darius Crowley to Magistrate'),
(44989, 3, 0, 'Die in battle and be raised as a servant of the Forsaken or...', 12, 0, 100, 396, 0, 0, 45164, 0, 'Lord Darius Crowley to Magistrate'),
(44989, 4, 0, 'Drink in my blood and be reborn as worgen, immune to the depravity of the Forsaken.', 12, 0, 100, 396, 0, 0, 45165, 0, 'Lord Darius Crowley to Magistrate'),
(44989, 5, 0, 'Help us destroy the Forsaken and retake Lordaeron for the Alliance!', 12, 0, 100, 5, 0, 0, 45166, 0, 'Lord Darius Crowley to Magistrate');
DELETE FROM `creature_text` WHERE `CreatureID`=44996 AND `GroupID` IN (0, 1);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(44996, 0, 0, 'We would rather die than be turned into worgen, but seeing as how even death provides no relief from the atrocities of this war...', 12, 0, 100, 1, 0, 0, 45167, 0, 'Magistrate Henry to Player'),
(44996, 1, 0, 'We choose vengeance!', 12, 0, 100, 5, 0, 0, 45168, 0, 'Magistrate Henry to Player');
DELETE FROM `creature_text` WHERE `CreatureID`=44951 AND `GroupID` BETWEEN 0 AND 3;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(44951, 0, 0, 'This way, $n. We will take them by surprise.', 12, 0, 100, 457, 0, 0, 45193, 0, 'Agatha to Player'),
(44951, 1, 0, 'Rise, $n! Become Forsaken!', 14, 0, 100, 0, 0, 0, 45091, 0, 'Agatha to Player'),
(44951, 2, 0, 'Run...', 12, 0, 100, 457, 0, 0, 45184, 0, 'Agatha to Player'),
(44951, 3, 0, 'RUN!', 12, 0, 100, 457, 0, 0, 45185, 0, 'Agatha to Player');
SET @GUID=4495101;
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(@GUID, 1, 978.1359, 701.0002, 74.89857, 1.469464, 0, 1, 0, 100, 0),
(@GUID, 2, 980.0945, 707.5026, 74.89857, 0.53484, 0, 1, 0, 100, 0),
(@GUID, 3, 983.2339, 707.6531, 74.79117, 0.047892, 0, 1, 0, 100, 0),
(@GUID, 4, 993.0419, 708.1599, 69.7968, 0.051819, 0, 1, 0, 100, 0),
(@GUID, 5, 996.8337, 706.6511, 69.7968, 5.903038, 0, 1, 0, 100, 0),
(@GUID, 6, 997.8134, 685.7626, 69.7968, 4.756361, 0, 1, 0, 100, 0),
(@GUID, 7, 1000.605, 683.2662, 69.7968, 5.55354, 0, 1, 0, 100, 0),
(@GUID, 8, 1008.984, 683.5966, 64.96407, 0.051824, 0, 1, 0, 100, 0),
(@GUID, 9, 1011.667, 683.7565, 64.90376, 0.201049, 0, 1, 0, 100, 0),
(@GUID, 10, 1013.713, 686.3148, 64.90376, 0.93147, 0, 1, 0, 100, 0),
(@GUID, 11, 1012.84, 692.0942, 60.97515, 1.720795, 0, 1, 0, 100, 0),
(@GUID, 12, 1009.927, 696.0195, 60.97515, 2.247012, 0, 1, 0, 100, 0),
(@GUID, 13, 999.3065, 695.5478, 60.97515, 3.162001, 0, 1, 0, 100, 0),
(@GUID, 14, 995.6049, 697.9961, 60.97515, 2.557245, 0, 1, 0, 100, 0),
(@GUID, 15, 996.0381, 708.152, 60.97515, 1.744357, 0, 1, 0, 100, 0),
(@GUID, 16, 991.2772, 712.1159, 60.97515, 2.447289, 0, 1, 0, 100, 0),
(@GUID, 17, 987.5659, 711.0661, 60.97515, 3.417256, 0, 1, 0, 100, 0),
(@GUID, 18, 983.5695, 705.4751, 60.97515, 4.120186, 0, 1, 0, 100, 0),
(@GUID, 19, 983.7156, 694.2731, 59.48418, 4.701381, 0, 1, 0, 100, 0),
(@GUID, 20, 978.3207, 688.5763, 59.45862, 3.939546, 0, 1, 0, 100, 0),
(@GUID, 21, 972.1443, 689.1495, 59.73647, 3.18618, 0, 1, 0, 100, 0),
(@GUID, 22, 947.125, 688.8077, 59.73647, 3.119421, 0, 1, 0, 100, 0),
(@GUID, 23, 940.7419, 692.6727, 59.28345, 2.58535, 0, 1, 0, 100, 0),
(@GUID, 24, 942.0499, 710.1451, 59.30516, 1.411179, 0, 1, 0, 100, 0),
(@GUID, 25, 962.5223, 728.5516, 59.28381, 0.70432, 0, 1, 0, 100, 0),
(@GUID, 26, 1005.039, 732.6902, 59.26571, 6.10786, 0, 1, 0, 100, 0),
(@GUID, 27, 1011.227, 727.5854, 59.5486, 5.593425, 0, 1, 0, 100, 0),
(@GUID, 28, 1027.919, 725.5515, 58.62294, 6.186398, 0, 1, 0, 100, 0),
(@GUID, 29, 1034.905, 726.7658, 54.57361, 6.151052, 0, 1, 0, 100, 0),
(@GUID, 30, 1045.765, 725.6252, 53.04143, 6.178541, 0, 1, 0, 100, 0),
(@GUID, 31, 1075.915, 722.2546, 45.57275, 6.16676, 0, 1, 0, 100, 0),
(@GUID, 32, 1093.561, 720.1909, 40.58342, 6.16676, 0, 1, 0, 100, 0),
(@GUID, 33, 1117.21, 719.6275, 32.31801, 0.068142, 0, 1, 0, 100, 0),
(@GUID, 34, 1192.305, 909.5518, 32.97552, 1.226605, 0, 1, 0, 100, 0),
(@GUID, 35, 1204.633, 938.8166, 35.41784, 1.1677, 0, 1, 0, 100, 0),
(@GUID, 36, 1222.831, 979.2708, 36.98741, 1.12843, 0, 1, 0, 100, 0),
(@GUID, 37, 1229.703, 991.4185, 36.01954, 1.061671, 0, 1, 0, 100, 0),
(@GUID, 38, 1252.699, 1031.865, 42.21674, 1.053817, 0, 1, 0, 100, 0),
(@GUID, 39, 1265.049, 1043.249, 45.64476, 0.712169, 0, 1, 0, 100, 0),
(@GUID, 40, 1275.689, 1048.93, 54.42715, 0.331248, 0, 1, 0, 100, 0),
(@GUID, 41, 1311.694, 1060.33, 54.59864, 0.327321, 0, 1, 0, 100, 0),
(@GUID, 42, 1367.728, 1050.514, 53.25192, 6.103925, 0, 1, 0, 100, 0),
(@GUID, 43, 1379.508, 1044.309, 54.09616, 5.793697, 0, 1, 0, 100, 0);
-- make summoned Sylvanas sitting on a horse
DELETE FROM `creature_template_addon` WHERE `entry` = 45051;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `auras`) VALUES
(45051, 0, 10718, 0, 0, 0, 0, 0, 0, '');
-- Lordaeron
DELETE FROM `creature_text` WHERE `CreatureID`=45051 AND `GroupID` BETWEEN 0 AND 21;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(45051, 0, 0, 'I have not always been the Banshee Queen, $n', 12, 0, 100, 0, 0, 0, 20470, 0, 'Lady Sylvanas Windrunner To Player'),
(45051, 1, 0, 'And my peopel have not always been the Forsaken.', 12, 0, 100, 0, 0, 0, 20471, 0, 'Lady Sylvanas Windrunner To Player'),
(45051, 2, 0, 'Long ago this land comprised the northern kingdoms of Lordaeron, ruled by King Terenas Menethil.', 12, 0, 100, 0, 0, 0, 20472, 0, 'Lady Sylvanas Windrunner To Player'),
(45051, 3, 0, 'Terenas had a son named Arthas.', 12, 0, 100, 0, 0, 0, 20473, 0, 'Lady Sylvanas Windrunner To Player'),
(45051, 4, 0, 'Arthas... even saying his name makes my body quiver in rage.', 12, 0, 100, 0, 0, 0, 20474, 0, 'Lady Sylvanas Windrunner To Player'),
(45051, 5, 0, 'This man-child, Arthas, took for himself a cursed blade known as Frostmourne.', 12, 0, 100, 0, 0, 0, 20475, 0, 'Lady Sylvanas Windrunner To Player'),
(45051, 6, 0, 'Through Frostmourne, Arthas killed his own father and razed this land along with every living creature in it!', 12, 0, 100, 0, 0, 0, 20476, 0, 'Lady Sylvanas Windrunner To Player'),
(45051, 7, 0, 'My own death came at the hands of Arthas when he and his armies sacked my homeland, Quel\'Thalas, and murdered my people.', 12, 0, 100, 0, 0, 0, 20477, 0, 'Lady Sylvanas Windrunner To Player'),
(45051, 8, 0, 'In his vast cruelty, Arthas severed my spirit from my body and raised me as a banshee to serve in his Scourge army.', 12, 0, 100, 0, 0, 0, 20478, 0, 'Lady Sylvanas Windrunner To Player'),
(45051, 9, 0, 'A similar fate befell all that would die to the Scourge war machine.', 12, 0, 100, 0, 0, 0, 20479, 0, 'Lady Sylvanas Windrunner To Player'),
(45051, 10, 0, 'In death, they were reborn as mindless undead.', 12, 0, 100, 0, 0, 0, 20480, 0, 'Lady Sylvanas Windrunner To Player'),
(45051, 11, 0, 'But Arthas was not invincible! With each passing day his power waned - his grip over the will of the damned loosening.', 12, 0, 100, 0, 0, 0, 20481, 0, 'Lady Sylvanas Windrunner To Player'),
(45051, 12, 0, 'It was when Arthas was at his weakest that I struck!', 12, 0, 100, 0, 0, 0, 20482, 0, 'Lady Sylvanas Windrunner To Player'),
(45051, 13, 0, 'And though the hour of his atonement had come, the worm managed to escape his fate, returning to the frozen wastes of Northrend.', 12, 0, 100, 0, 0, 0, 20483, 0, 'Lady Sylvanas Windrunner To Player'),
(45051, 14, 0, 'With Arthas gone, so too was the control he held over the undead masses of Lordaeron. After recovering my body, I freed the remaining Scourge that were left behind.', 12, 0, 100, 0, 0, 0, 20484, 0, 'Lady Sylvanas Windrunner To Player'),
(45051, 15, 0, 'From the cruelty and mercilessness of Arthas, the man who would be the Lich King, the Forsaken were born.', 12, 0, 100, 0, 0, 0, 20485, 0, 'Lady Sylvanas Windrunner To Player'),
(45051, 16, 0, 'Our goal... Our sole purpose was to destroy the Lich King. We threw our lot in with the Horde and began our journey towards redemption.', 12, 0, 100, 0, 0, 0, 20486, 0, 'Lady Sylvanas Windrunner To Player'),
(45051, 17, 0, 'Now the Lich King is dead and we have returned.', 12, 0, 100, 0, 0, 0, 20487, 0, 'Lady Sylvanas Windrunner To Player'),
(45051, 18, 0, 'The people who called this land their home in life, do so in death as well.', 12, 0, 100, 0, 0, 0, 20488, 0, 'Lady Sylvanas Windrunner To Player'),
(45051, 19, 0, 'But the Alliance does not recognize our rights. They claim this land is their own while attempting to invalidate the claims of the founders of this kingdom.', 12, 0, 100, 0, 0, 0, 20489, 0, 'Lady Sylvanas Windrunner To Player'),
(45051, 20, 0, 'I will never allow it.... Never!', 12, 0, 100, 0, 0, 0, 20490, 0, 'Lady Sylvanas Windrunner To Player'),
(45051, 21, 0, 'Lordaeron belongs to the Forsaken - always and forever.', 12, 0, 100, 0, 0, 0, 20491, 0, 'Lady Sylvanas Windrunner To Player');
SET @GUID=4505701;
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(@GUID, 1, 1354.1536, 1021.3851, 52.38039, 3.586764, 0, 1, 0, 100, 0),
(@GUID, 2, 1341.8688, 1011.3289, 54.59922, 3.586764, 0, 1, 0, 100, 0),
(@GUID, 3, 1326.9110, 1009.5746, 54.59922, 3.021277, 0, 1, 0, 100, 0),
(@GUID, 4, 1317.4199, 1013.5382, 54.59922, 2.028532, 0, 1, 0, 100, 0),
(@GUID, 5, 1283.3730, 1070.9077, 53.37197, 2.362329, 0, 1, 0, 100, 0),
(@GUID, 6, 1258.4970, 1098.5913, 51.47762, 2.308790, 0, 1, 0, 100, 0),
(@GUID, 7, 1243.2491, 1110.7161, 51.01573, 2.469797, 0, 1, 0, 100, 0),
(@GUID, 8, 1193.5955, 1148.6325, 49.49488, 2.489432, 0, 1, 0, 100, 0),
(@GUID, 9, 1105.2985, 1204.6529, 46.48838, 2.568757, 0, 1, 0, 100, 0),
(@GUID, 10, 1089.7988, 1217.8898, 46.34733, 2.453304, 0, 1, 0, 100, 0),
(@GUID, 11, 1070.6142, 1234.5732, 46.24262, 2.425815, 0, 1, 0, 100, 0),
(@GUID, 12, 1032.4326, 1273.4902, 46.02033, 2.599710, 0, 1, 0, 100, 0),
(@GUID, 13, 945.0678, 1328.3918, 46.71963, 2.580538, 0, 1, 0, 100, 0),
(@GUID, 14, 926.3798, 1338.3869, 47.25944, 2.694421, 0, 1, 0, 100, 0),
(@GUID, 15, 895.2805, 1350.9622, 49.68106, 2.780029, 0, 1, 0, 100, 0),
(@GUID, 16, 871.0656, 1356.4820, 53.67734, 2.917474, 0, 1, 0, 100, 0),
(@GUID, 17, 862.8825, 1358.3472, 54.92165, 2.917474, 0, 1, 0, 100, 0),
(@GUID, 18, 848.6384, 1359.6978, 55.42436, 3.215925, 0, 1, 0, 100, 0),
(@GUID, 19, 820.0228, 1358.7645, 56.41104, 3.178226, 0, 1, 0, 100, 0),
(@GUID, 20, 748.6945, 1358.4659, 69.44759, 3.138171, 0, 1, 0, 100, 0),
(@GUID, 21, 723.1749, 1350.9353, 73.37368, 3.641611, 0, 1, 0, 100, 0),
(@GUID, 22, 683.4259, 1320.9855, 79.61323, 3.834034, 0, 1, 0, 100, 0),
(@GUID, 23, 648.3973, 1299.3040, 84.76816, 3.466467, 0, 1, 0, 100, 0),
(@GUID, 24, 645.0045, 1299.9880, 85.07080, 2.805947, 0, 1, 0, 100, 0),
(@GUID, 25, 640.4437, 1303.3983, 85.34098, 2.508281, 0, 1, 0, 100, 0),
(@GUID, 26, 630.6345, 1313.0195, 83.93389, 2.311146, 0, 1, 0, 100, 0),
(@GUID, 27, 619.7167, 1332.3671, 85.35432, 2.078668, 0, 1, 0, 100, 0),
(@GUID, 28, 599.6586, 1369.7771, 88.74443, 2.062960, 0, 1, 0, 100, 0),
(@GUID, 29, 583.6837, 1408.0041, 94.51779, 2.069243, 0, 1, 0, 100, 0),
(@GUID, 30, 576.2428, 1423.0537, 97.55828, 2.132075, 0, 1, 0, 100, 0),
(@GUID, 31, 555.8312, 1447.9395, 103.65572, 2.257739, 0, 1, 0, 100, 0),
(@GUID, 32, 534.9779, 1469.4705, 112.33334, 2.340206, 0, 1, 0, 100, 0),
(@GUID, 33, 509.6081, 1489.6441, 123.12377, 2.469797, 0, 1, 0, 100, 0),
(@GUID, 34, 501.7248, 1505.1267, 127.12670, 2.041754, 0, 1, 0, 100, 0),
(@GUID, 35, 496.9183, 1532.4189, 129.50436, 1.730737, 0, 1, 0, 100, 0),
(@GUID, 36, 494.8780, 1551.0817, 128.88194, 1.679686, 0, 1, 0, 100, 0);
SET @GUID=4505101;
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
-- INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
-- (@GUID, 1, 1351.3326, 1023.5604, 52.49290, 3.794896, 0, 1, 0, 100, 0),
-- (@GUID, 2, 1341.0969, 1015.6601, 54.55842, 3.476024, 0, 1, 0, 100, 0),
-- (@GUID, 3, 1326.8812, 1014.2476, 54.59922, 2.851635, 0, 1, 0, 100, 0),
-- (@GUID, 4, 1323.0731, 1020.3032, 54.59922, 2.592453, 0, 1, 0, 100, 0),
-- (@GUID, 5, 1287.9075, 1075.5198, 53.46790, 2.364687, 0, 1, 0, 100, 0),
-- (@GUID, 6, 1261.2916, 1103.7098, 51.42205, 2.502132, 0, 1, 0, 100, 0),
-- (@GUID, 7, 1245.8872, 1115.0850, 50.81323, 2.506059, 0, 1, 0, 100, 0),
-- (@GUID, 8, 1198.5935, 1152.2131, 49.44096, 2.658294, 0, 1, 0, 100, 0),
-- (@GUID, 9, 1109.2337, 1209.0124, 46.59064, 2.407288, 0, 1, 0, 100, 0),
-- (@GUID, 10, 1093.3975, 1221.9399, 46.33885, 2.415142, 0, 1, 0, 100, 0),
-- (@GUID, 11, 1075.2797, 1239.9503, 46.22900, 2.368018, 0, 1, 0, 100, 0),
-- (@GUID, 12, 1035.4653, 1278.9564, 46.00826, 2.635053, 0, 1, 0, 100, 0),
-- (@GUID, 13, 947.5699, 1334.1583, 46.36019, 2.714379, 0, 1, 0, 100, 0),
-- (@GUID, 14, 928.7150, 1344.7327, 47.32204, 2.788991, 0, 1, 0, 100, 0),
-- (@GUID, 15, 896.6491, 1356.9969, 49.57093, 2.918682, 0, 1, 0, 100, 0),
-- (@GUID, 16, 870.8812, 1361.7207, 53.70751, 3.122786, 0, 1, 0, 100, 0),
-- (@GUID, 17, 862.8340, 1362.1898, 54.94648, 3.154202, 0, 1, 0, 100, 0),
-- (@GUID, 18, 848.4928, 1362.7254, 55.44739, 3.197399, 0, 1, 0, 100, 0),
-- (@GUID, 19, 819.8353, 1362.2593, 56.44017, 3.154202, 0, 1, 0, 100, 0),
-- (@GUID, 20, 747.8422, 1362.3352, 69.48340, 3.358405, 0, 1, 0, 100, 0),
-- (@GUID, 21, 720.9816, 1354.3851, 73.56366, 3.707908, 0, 1, 0, 100, 0),
-- (@GUID, 22, 681.3668, 1323.4702, 79.91288, 3.790375, 0, 1, 0, 100, 0), -- fix
-- (@GUID, 23, 644.8774, 1303.9456, 84.95144, 3.790375, 0, 1, 0, 100, 0),
-- (@GUID, 24, 642.8243, 1303.5966, 85.16318, 3.091370, 0, 1, 0, 100, 0),
-- (@GUID, 25, 640.1527, 1308.0874, 84.79577, 3.087443, 0, 1, 0, 100, 0),
-- (@GUID, 26, 634.2171, 1315.6269, 83.82943, 2.199943, 0, 1, 0, 100, 0),
-- (@GUID, 27, 622.9302, 1334.6844, 84.96324, 2.192089, 0, 1, 0, 100, 0),
-- (@GUID, 28, 604.1992, 1373.0546, 88.62355, 2.196016, 0, 1, 0, 100, 0),
-- (@GUID, 29, 587.1557, 1410.5729, 94.52041, 2.207797, 0, 1, 0, 100, 0),
-- (@GUID, 30, 579.6567, 1426.0507, 97.99942, 2.298117, 0, 1, 0, 100, 0),
-- (@GUID, 31, 559.6369, 1451.3808, 104.46113, 2.305971, 0, 1, 0, 100, 0),
-- (@GUID, 32, 538.0384, 1473.1732, 112.81736, 2.482686, 0, 1, 0, 100, 0),
-- (@GUID, 33, 512.9638, 1493.9776, 123.20586, 2.482686, 0, 1, 0, 100, 0),
-- (@GUID, 34, 505.3227, 1508.1033, 126.81208, 2.219578, 0, 1, 0, 100, 0),
-- (@GUID, 35, 500.6704, 1535.3819, 129.32786, 2.239213, 0, 1, 0, 100, 0),
-- (@GUID, 36, 496.8941, 1552.6738, 128.83305, 2.239213, 0, 1, 0, 100, 0);
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_forsaken_warhorse_45057' WHERE `entry`=45057;
-- UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_sylvanas_windrunner_45051' WHERE `entry`=45051;