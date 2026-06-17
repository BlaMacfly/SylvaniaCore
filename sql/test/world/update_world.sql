
  --       MagicStorm       --
-- // Update patch by Erka // --
  --      Legion 7.3.5      --



-- Table `creature_template`
UPDATE `creature_template` SET `npcflag` = 4736 WHERE (entry = 491);
UPDATE `creature_template` SET `InhabitType` = 2 WHERE (entry = 199);
UPDATE `creature_template` SET `InhabitType` = 2 WHERE (entry = 462);
UPDATE `creature_template` SET `InhabitType` = 2 WHERE (entry = 1109);
UPDATE `creature_template` SET `InhabitType` = 2 WHERE (entry = 154);
UPDATE `creature_template` SET `npcflag` = 0 WHERE (entry = 42383);
UPDATE `creature_template` SET `ScriptName` = 'temporaire_npc_icycle_dm' WHERE (entry = 49481);
UPDATE `creature_template` SET `npcflag` = 268435456, `unit_class` = 1, `unit_flags` = 32768, `type_flags` = 4096 WHERE (entry = 54442);
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 68;
DELETE FROM `creature_template` WHERE (entry = 833);
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `HealthScalingExpansion`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `dynamicflags`, `family`, `trainer_type`, `trainer_class`, `trainer_race`, `type`, `type_flags`, `type_flags2`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `HoverHeight`, `HealthModifier`, `HealthModifierExtra`, `ManaModifier`, `ManaModifierExtra`, `ArmorModifier`, `DamageModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`) VALUES
(833, 0, 0, 0, 0, 0, 52598, 52599, 0, 0, 'Coyote Packleader', '', '', NULL, '', 0, 11, 12, 0, 0, 0, 38, 0, 1, 1.14286, 1, 0, 0, 2000, 2000, 0, 0, 1, 67108872, 2048, 0, 4, 1, 0, 0, 0, 1, 1, 0, 833, 0, 833, 0, 1, 5, 0, 0, 0, 3149, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, '', 25549);
UPDATE `creature_template` SET `type_flags` = 0 WHERE (entry = 95056);
UPDATE `creature_template` SET `minlevel` = 110, `maxlevel` = 110, `rank` = 2, `InhabitType` = 5, `HealthModifier` = 3, `ManaModifier` = 3 WHERE (entry = 121108);

-- Table smart_scripts 
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 210120041);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(210120041, 0, 1, 0, 1, 0, 100, 0, 1000, 6000, 6000, 14000, '', 5, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, '');
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 210120040);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(210120040, 0, 1, 0, 1, 0, 100, 0, 1000, 5000, 5000, 15000, '', 5, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, '');


-- Table `gameobject_template`
UPDATE `gameobject_template` SET `size` = 1 WHERE (entry = 259095);


-- Table `creature_equip_template`
UPDATE `creature_equip_template` SET `ItemID1`='45123' WHERE  `CreatureID`=86087;


-- Table `creature_addon` 
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('21011114', '1');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('21011113', '1');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('210119047', '37');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('210119046', '35');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('210119045', '37'); 
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('210119054', '45');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('210119053', '45');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('210119052', '45');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('210119051', '45');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('210119081', '35');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('210119061', '37');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('210119048', '35');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('210119049', '37');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('210119050', '38');
INSERT IGNORE INTO `creature_addon` (`guid`, `auras`) VALUES ('210119128', '149734');
INSERT IGNORE INTO `creature_addon` (`guid`, `auras`) VALUES ('210119130', '227301');
INSERT IGNORE INTO `creature_addon` (`guid`, `auras`) VALUES ('210119133', '227301');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('210119136', '234');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('210119135', '234');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('210119139', '432');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('210119151', '432');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('210119159', '432');
INSERT IGNORE INTO `creature_addon` (`guid`, `auras`) VALUES ('210119160', '208343');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('210119166', '1');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('210119167', '1');
INSERT IGNORE INTO `creature_addon` (`guid`, `auras`) VALUES ('215329', '227301');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('210119174', '233');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('210119174', '233');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('210119175', '233');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('210119175', '233');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('21011911', '1');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('21011912', '1');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('20343391', '1');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('20343390', '1');
INSERT IGNORE INTO `creature_addon` (`guid`, `auras`) VALUES ('20508433', '76701');
INSERT IGNORE INTO `creature_addon` (`guid`, `auras`) VALUES ('20508440', '76701');
INSERT IGNORE INTO `creature_addon` (`guid`, `auras`) VALUES ('20508657', '76701');
INSERT IGNORE INTO `creature_addon` (`guid`, `auras`) VALUES ('20508646', '76701');
INSERT IGNORE INTO `creature_addon` (`guid`, `auras`) VALUES ('20508438', '76701');
INSERT IGNORE INTO `creature_addon` (`guid`, `auras`) VALUES ('20508439', '76701');
INSERT IGNORE INTO `creature_addon` (`guid`, `auras`) VALUES ('20508437', '76701');
INSERT IGNORE INTO `creature_addon` (`guid`, `auras`) VALUES ('210119238', '76701');
INSERT IGNORE INTO `creature_addon` (`guid`, `auras`) VALUES ('210119246', '149734');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('265869', '432');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('20508528', '432');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('20508535', '432');
INSERT IGNORE INTO `creature_addon` (`guid`, `auras`) VALUES ('210119268', '76701');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('188867', '233');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('10181939', '469');
INSERT IGNORE INTO `creature_addon` (`guid`, `auras`) VALUES ('10181939', '157589');
INSERT IGNORE INTO `creature_addon` (`guid`, `auras`) VALUES ('10181874', '164381');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('10181869', '234');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('10181930', '234');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('20548909', '234');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('10181921', '234');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('10181919', '432');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('10181605', '432');
INSERT IGNORE INTO `creature_addon` (`guid`, `auras`) VALUES ('10181663 ', '227301');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('10181866', '432');
INSERT IGNORE INTO `creature_addon` (`guid`, `auras`) VALUES ('10181597', '76701');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('10181711', '234');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('10181937', '234');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('10181702', '233');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('10181696', '233');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('10181941', '233');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('10181888', '432');
INSERT IGNORE INTO `creature_addon` (`guid`, `auras`) VALUES ('10181626', '76701');
INSERT IGNORE INTO `creature_addon` (`guid`, `auras`) VALUES ('10181886', '76701');
INSERT IGNORE INTO `creature_addon` (`guid`, `auras`) VALUES ('10181631', '76701');
INSERT IGNORE INTO `creature_addon` (`guid`, `auras`) VALUES ('10181900', '76701');
INSERT IGNORE INTO `creature_addon` (`guid`, `auras`) VALUES ('10181911', '76701');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('10181900', '7');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('10181911', '7');
INSERT IGNORE INTO `creature_addon` (`guid`, `auras`) VALUES ('10181627', '163720');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('210120024', '1');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('210120025', '1');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('10181616', '7');
INSERT IGNORE INTO `creature_addon` (`guid`, `auras`) VALUES ('10181616', '76701');
INSERT IGNORE INTO `creature_addon` (`guid`, `auras`) VALUES ('10181782', '76701');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('210120038', '432');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('10181799', '10');
INSERT IGNORE INTO `creature_addon` (`guid`, `auras`) VALUES ('10181800', '76701');
INSERT IGNORE INTO `creature_addon` (`guid`, `auras`) VALUES ('10181787', '76701');
INSERT IGNORE INTO `creature_addon` (`guid`, `auras`) VALUES ('10181795', '76701');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('10181860', '432');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('177633', '233');
INSERT IGNORE INTO `creature_addon` (`guid`, `auras`) VALUES ('86129', '164381');
INSERT IGNORE INTO `creature_addon` (`guid`, `auras`) VALUES ('20549217', '227301');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('10124404', '233');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('10124382', '1'); 
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('20549294', '1'); 
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('212140', '1');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('212021', '1');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('212139', '1');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('20549387', '234');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('20549390', '234');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('20508287', '1');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('20508287', '1');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('20508260', '432');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('20508250 ', '432'); 
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('20508252', '432'); 
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('20549871', '10');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('20508243', '11');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('20508276', '1');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('20508381', '1');
INSERT IGNORE INTO `creature_addon` (`guid`, `auras`) VALUES ('20508699', '227301');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('20508678', '432');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('20508676', '432');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('20508713', '1');
INSERT IGNORE INTO `creature_addon` (`guid`, `auras`) VALUES ('20508666', '14915');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('20508630', '223977');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('20508429', '432');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('20549875', '432');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('20549881', '432');
INSERT IGNORE INTO `creature_addon` (`guid`, `auras`) VALUES ('20546621', '76701');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('20546621', '380');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('20546695', '461');
INSERT IGNORE INTO `creature_addon` (`guid`, `auras`) VALUES ('20549903', '174794');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('20546675', '461');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('20546662', '461');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('20546664', '461');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('20546658', '432');
INSERT IGNORE INTO `creature_addon` (`guid`, `auras`) VALUES ('20546729', '175959');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('20546729', '432');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('20546705', '483');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('20546716', '483');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('20546718', '432');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('20546707', '37');
UPDATE `creature_addon` SET `emote` = 38 WHERE (guid = 20546706);
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('20546708', '461');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('20546709', '461');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('20546704', '461');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('20546700', '461');
UPDATE `creature_addon` SET `emote` = 461 WHERE (guid = 20546698);
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('20546786', '483');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('20546837', '483');
INSERT IGNORE INTO `creature_addon` (`guid`, `emote`) VALUES ('20546823', '483');


-- Table `creature_template_addon` 
UPDATE `creature_template_addon` SET `auras`='0' WHERE  `entry`= 45165;

  
-- Table `creature_template`
UPDATE `creature_template` SET `DamageModifier` = 4.5 WHERE (entry = 1850);
UPDATE `creature_template` SET `DamageModifier` = 3.5 WHERE (entry = 50737);
UPDATE `creature_template` SET `DamageModifier` = 3.5 WHERE (entry = 33497);
UPDATE `creature_template` SET `unit_flags2` = 2048 WHERE (entry = 98618);
UPDATE `creature_template` SET `faction` = 7 WHERE (entry = 100061);
UPDATE `creature_template` SET `name` = 'Jeune scrutesang', `minlevel` = 110, `maxlevel` = 110, `faction` = 14, `HealthModifier` = 0.8 WHERE (entry = 115675);
UPDATE `creature_template` SET `speed_walk` = 1, `speed_run` = 1.2 WHERE (entry = 111383);
UPDATE `creature_template` SET `MovementType` = 1, `speed_walk` = 1, `speed_run` = 1.2, `unit_flags` = 0, `type_flags` = 0 WHERE (entry = 111383);
UPDATE `creature_template` SET `name` = 'Patriarche scrutesang', `HealthModifier` = 2, `minlevel` = 110, `maxlevel` = 110, `faction` = 14, `HealthModifier` = 3 WHERE (entry = 115670);
UPDATE `creature_template` SET `name` = 'Matriarche scrutesang', `HealthModifier` = 4, `minlevel` = 110, `maxlevel` = 110, `faction` = 14 WHERE (entry = 115674);
UPDATE `creature_template` SET `name` = 'Nid de matriarche scrutesang', `minlevel` = 110, `maxlevel` = 110, `faction` = 7 WHERE (entry = 115922);
UPDATE `creature_template` SET `name` = 'Nid de scrutesang', `minlevel` = 110, `maxlevel` = 110, `faction` = 7 WHERE (entry = 115681);
UPDATE `creature_template` SET `name` = 'Garde-nid scrutesang', `minlevel` = 110, `maxlevel` = 110, `faction` = 14 WHERE (entry = 115666);
UPDATE `creature_template` SET `spell3` = 168167, `spell4` = 0, `spell5` = 0 WHERE (entry = 78116);
UPDATE `creature_template` SET `name` = 'Illnea Roncesang', `subname` = 'Commerce de sang', `minlevel` = 110, `maxlevel` = 110, `npcflag` = 128 WHERE (entry = 115264);
UPDATE `creature_template` SET `faction` = 7, `unit_flags` = 4  WHERE (entry = 115666);
UPDATE `creature_template` SET `unit_flags` = 4 WHERE (entry = 115922);
UPDATE `creature_template` SET `unit_flags` = 4 WHERE (entry = 115681);
UPDATE `creature_template` SET `InhabitType` = 2 WHERE (entry = 44475);
UPDATE `creature_template` SET `unit_flags` = 33685510 WHERE (entry = 86062);
UPDATE `creature_template` SET `unit_flags2` = 2048 WHERE (entry = 44316);
UPDATE `creature_template` SET `unit_flags2` = 2048 WHERE (entry = 44315);
UPDATE `creature_template` SET `unit_flags` = 32768 WHERE (entry = 44475);
UPDATE `creature_template` SET `modelid1` = 26760, `modelid3` = 0, `modelid4` = 0, `minlevel` = 37, `maxlevel` = 37, `faction` = 14 WHERE (entry = 50778);
UPDATE `creature_template` SET `unit_flags` = 0 WHERE (entry = 45165);
UPDATE `creature_template` SET `unit_flags` = 0, `unit_flags2` = 2048 WHERE (entry = 90230);
UPDATE `creature_template` SET `unit_flags2` = 2048 WHERE (entry = 93619);
UPDATE `creature_template` SET `DamageModifier` = 0.7 WHERE (entry = 86969);
UPDATE `creature_template` SET `DamageModifier` = 0.7 WHERE (entry = 101943);
UPDATE `creature_template` SET `DamageModifier` = 0.7 WHERE (entry = 93619);
UPDATE `creature_template` SET `DamageModifier` = 0.8 WHERE (entry = 89016);
UPDATE creature_template SET lootid = 101967 WHERE entry = 101967 AND lootid = 0;
DELETE FROM `creature_loot_template` WHERE `entry` = '101967';
INSERT INTO `creature_loot_template` (`entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
('101967', '121015', '0', '0.07131597', '0', '1', '0', '1', '1', ''),
('101967', '121023', '0', '0.08632986', '0', '1', '0', '1', '1', ''),
('101967', '121041', '0', '0.0675625', '0', '1', '0', '1', '1', ''),
('101967', '121048', '0', '5', '0', '1', '0', '1', '1', ''),
('101967', '121059', '0', '0.1426319', '0', '1', '0', '1', '1', ''),
('101967', '121062', '0', '0.4429097', '0', '1', '0', '1', '1', ''),
('101967', '121075', '0', '0.1126042', '0', '1', '0', '1', '1', ''),
('101967', '121095', '0', '0.3040312', '0', '1', '0', '1', '1', ''),
('101967', '121096', '0', '0.1764132', '0', '1', '0', '1', '1', ''),
('101967', '121101', '0', '0.3190451', '0', '1', '0', '1', '1', ''),
('101967', '121102', '0', '0.05254861', '0', '1', '0', '1', '1', ''),
('101967', '121103', '0', '0.1726597', '0', '1', '0', '1', '1', ''),
('101967', '121104', '0', '1', '0', '1', '0', '1', '1', ''),
('101967', '121107', '0', '1', '0', '1', '0', '1', '1', ''),
('101967', '121108', '0', '0.1801666', '0', '1', '0', '1', '1', ''),
('101967', '121111', '0', '0.0675625', '0', '1', '0', '1', '1', ''),
('101967', '121155', '0', '0.2402222', '0', '1', '0', '1', '1', ''),
('101967', '121160', '0', '0.08257639', '0', '1', '0', '1', '1', ''),
('101967', '121225', '0', '0.3040312', '0', '1', '0', '1', '1', ''),
('101967', '121227', '0', '0.09008332', '0', '1', '0', '1', '1', ''),
('101967', '121236', '0', '0.3040312', '0', '1', '0', '1', '1', ''),
('101967', '121272', '0', '0.1463854', '0', '1', '0', '1', '1', ''),
('101967', '121321', '0', '0.05254861', '0', '1', '0', '1', '1', ''),
('101967', '121324', '0', '0.05254861', '0', '1', '0', '1', '1', ''),
('101967', '121331', '0', '0.127618', '0', '1', '0', '1', '1', ''),
('101967', '121332', '0', '0.2026875', '0', '1', '0', '1', '1', ''),
('101967', '121333', '0', '0.2664965', '0', '1', '0', '1', '1', ''),
('101967', '121334', '0', '1', '0', '1', '0', '1', '1', ''),
('101967', '121335', '0', '6', '0', '1', '0', '1', '1', ''),
('101967', '121336', '0', '3', '0', '1', '0', '1', '1', ''),
('101967', '121337', '0', '0.2815104', '0', '1', '0', '1', '1', ''),
('101967', '121339', '0', '0.1651528', '0', '1', '0', '1', '1', ''),
('101967', '121340', '0', '1', '0', '1', '0', '1', '1', ''),
('101967', '121341', '0', '3', '0', '1', '0', '1', '1', ''),
('101967', '121342', '0', '0.2740034', '0', '1', '0', '1', '1', ''),
('101967', '121343', '0', '0.3640868', '0', '1', '0', '1', '1', ''),
('101967', '121344', '0', '0.3002778', '0', '1', '0', '1', '1', ''),
('101967', '121345', '0', '0.07131597', '0', '1', '0', '1', '1', ''),
('101967', '121346', '0', '0.3227986', '0', '1', '0', '1', '1', ''),
('101967', '121348', '0', '0.3227986', '0', '1', '0', '1', '1', ''),
('101967', '121349', '0', '0.4541701', '0', '1', '0', '1', '1', ''),
('101967', '121350', '0', '0.2101944', '0', '1', '0', '1', '1', ''),
('101967', '121351', '0', '0.2477292', '0', '1', '0', '1', '1', ''),
('101967', '121352', '0', '0.1726597', '0', '1', '0', '1', '1', ''),
('101967', '121353', '0', '0.3077847', '0', '1', '0', '1', '1', ''),
('101967', '121354', '0', '0.1126042', '0', '1', '0', '1', '1', ''),
('101967', '121355', '0', '1', '0', '1', '0', '1', '1', ''),
('101967', '121356', '0', '0.2402222', '0', '1', '0', '1', '1', ''),
('101967', '121357', '0', '1', '0', '1', '0', '1', '1', ''),
('101967', '121358', '0', '0.07506944', '0', '1', '0', '1', '1', ''),
('101967', '121359', '0', '0.206441', '0', '1', '0', '1', '1', ''),
('101967', '121360', '0', '0.2289618', '0', '1', '0', '1', '1', ''),
('101967', '121361', '0', '0.4917048', '0', '1', '0', '1', '1', ''),
('101967', '121362', '0', '1', '0', '1', '0', '1', '1', ''),
('101967', '121363', '0', '2', '0', '1', '0', '1', '1', ''),
('101967', '121364', '0', '0.1801666', '0', '1', '0', '1', '1', ''),
('101967', '121365', '0', '1', '0', '1', '0', '1', '1', ''),
('101967', '121366', '0', '1', '0', '1', '0', '1', '1', ''),
('101967', '121367', '0', '1', '0', '1', '0', '1', '1', ''),
('101967', '121368', '0', '1', '0', '1', '0', '1', '1', ''),
('101967', '121369', '0', '5', '0', '1', '0', '1', '1', ''),
('101967', '121370', '0', '1', '0', '1', '0', '1', '1', ''),
('101967', '121371', '0', '0.1876736', '0', '1', '0', '1', '1', ''),
('101967', '121372', '0', '0.1613993', '0', '1', '0', '1', '1', ''),
('101967', '121373', '0', '0.1651528', '0', '1', '0', '1', '1', ''),
('101967', '121381', '0', '0.07131597', '0', '1', '0', '1', '1', ''),
('101967', '121391', '0', '0.05254861', '0', '1', '0', '1', '1', ''),
('101967', '121399', '0', '1', '0', '1', '0', '1', '1', ''),
('101967', '121410', '0', '0.3303055', '0', '1', '0', '1', '1', ''),
('101967', '121411', '0', '0.0675625', '0', '1', '0', '1', '1', ''),
('101967', '124437', '0', '53', '0', '1', '0', '1', '3', ''),
('101967', '130135', '0', '0.08257639', '0', '1', '0', '1', '1', ''),
('101967', '132231', '0', '0.3866076', '0', '1', '0', '1', '1', ''),
('101967', '134171', '0', '0.05254861', '0', '1', '0', '1', '1', ''),
('101967', '134180', '0', '0.05254861', '0', '1', '0', '1', '1', ''),
('101967', '134181', '0', '0.05254861', '0', '1', '0', '1', '1', ''),
('101967', '134192', '0', '0.05254861', '0', '1', '0', '1', '1', ''),
('101967', '134214', '0', '0.06380902', '0', '1', '0', '1', '1', ''),
('101967', '134328', '0', '0.262743', '0', '1', '0', '1', '1', ''),
('101967', '136764', '0', '0.07882291', '0', '1', '0', '1', '1', ''),
('101967', '138781', '0', '1', '0', '1', '0', '1', '1', ''),
('101967', '138782', '0', '0.4879514', '0', '1', '0', '1', '1', ''),
('101967', '139056', '0', '0.05630208', '0', '1', '0', '1', '1', ''),
('101967', '139119', '0', '0.05254861', '0', '1', '0', '1', '1', ''),
('101967', '139123', '0', '0.3040312', '0', '1', '0', '1', '1', ''),
('101967', '139910', '0', '0.05254861', '0', '1', '0', '1', '1', ''),
('101967', '140221', '0', '0.3190451', '0', '1', '0', '1', '1', ''),
('101967', '140222', '0', '1', '0', '1', '0', '1', '1', ''),
('101967', '140224', '0', '0.1126042', '0', '1', '0', '1', '1', ''),
('101967', '140225', '0', '0.1238646', '0', '1', '0', '1', '1', ''),
('101967', '140226', '0', '0.08257639', '0', '1', '0', '1', '1', ''),
('101967', '140227', '0', '1', '0', '1', '0', '1', '1', ''),
('101967', '141291', '0', '1', '0', '1', '0', '1', '1', ''),
('101967', '144330', '0', '0.1201111', '0', '1', '0', '1', '1', ''),
('101967', '144345', '0', '2', '0', '1', '0', '1', '1', '');




-- Table `creature` 
INSERT IGNORE INTO `creature` (`guid`, `id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `curhealth`) VALUES ('20548913', '3627', '-9039.14', '877.866', '110.196', '2.04797', '300', '164');


-- Table `creature_loot_template`
DELETE FROM `creature_loot_template` WHERE (Entry = 50778);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(50778, 7430, 0, 0.19, 0, 1, 0, 1, 1, ''),
(50778, 9875, 0, 3, 0, 1, 0, 1, 1, ''),
(50778, 7454, 0, 4, 0, 1, 0, 1, 1, ''),
(50778, 7462, 0, 4, 0, 1, 0, 1, 1, ''),
(50778, 12205, 0, 51, 0, 1, 0, 1, 1, ''),
(50778, 9863, 0, 5, 0, 1, 0, 1, 1, '');
UPDATE creature_template SET lootid = 102166 WHERE entry = 102166 AND lootid = 0;
DELETE FROM `creature_loot_template` WHERE `entry` = '102166';
INSERT INTO `creature_loot_template` (`entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
('102166', '121008', '0', '0.305724', '0', '1', '0', '1', '1', ''),
('102166', '121014', '0', '0.06422772', '0', '1', '0', '1', '1', ''),
('102166', '121020', '0', '0.2106669', '0', '1', '0', '1', '1', ''),
('102166', '121021', '0', '0.2183743', '0', '1', '0', '1', '1', ''),
('102166', '121024', '0', '4', '0', '1', '0', '1', '1', ''),
('102166', '121040', '0', '0.09248792', '0', '1', '0', '1', '1', ''),
('102166', '121049', '0', '0.07450416', '0', '1', '0', '1', '1', ''),
('102166', '121070', '0', '0.1104717', '0', '1', '0', '1', '1', ''),
('102166', '121075', '0', '0.09505703', '0', '1', '0', '1', '1', ''),
('102166', '121078', '0', '0.2569109', '0', '1', '0', '1', '1', ''),
('102166', '121114', '0', '0.2183743', '0', '1', '0', '1', '1', ''),
('102166', '121138', '0', '0.4650087', '0', '1', '0', '1', '1', ''),
('102166', '121160', '0', '0.2183743', '0', '1', '0', '1', '1', ''),
('102166', '121167', '0', '0.09505703', '0', '1', '0', '1', '1', ''),
('102166', '121168', '0', '0.07964238', '0', '1', '0', '1', '1', ''),
('102166', '121171', '0', '0.06936594', '0', '1', '0', '1', '1', ''),
('102166', '121173', '0', '0.1746994', '0', '1', '0', '1', '1', ''),
('102166', '121189', '0', '0.2183743', '0', '1', '0', '1', '1', ''),
('102166', '121213', '0', '0.06165862', '0', '1', '0', '1', '1', ''),
('102166', '121262', '0', '0.4187648', '0', '1', '0', '1', '1', ''),
('102166', '121265', '0', '1', '0', '1', '0', '1', '1', ''),
('102166', '121331', '0', '2', '0', '1', '0', '1', '1', ''),
('102166', '121332', '0', '0.2543418', '0', '1', '0', '1', '1', ''),
('102166', '121333', '0', '0.1772685', '0', '1', '0', '1', '1', ''),
('102166', '121334', '0', '0.3673826', '0', '1', '0', '1', '1', ''),
('102166', '121335', '0', '0.2337889', '0', '1', '0', '1', '1', ''),
('102166', '121336', '0', '2', '0', '1', '0', '1', '1', ''),
('102166', '121337', '0', '1', '0', '1', '0', '1', '1', ''),
('102166', '121339', '0', '0.3082931', '0', '1', '0', '1', '1', ''),
('102166', '121340', '0', '0.3211386', '0', '1', '0', '1', '1', ''),
('102166', '121341', '0', '1', '0', '1', '0', '1', '1', ''),
('102166', '121342', '0', '0.2697564', '0', '1', '0', '1', '1', ''),
('102166', '121343', '0', '1', '0', '1', '0', '1', '1', ''),
('102166', '121344', '0', '0.4316103', '0', '1', '0', '1', '1', ''),
('102166', '121345', '0', '1', '0', '1', '0', '1', '1', ''),
('102166', '121346', '0', '0.2389271', '0', '1', '0', '1', '1', ''),
('102166', '121348', '0', '0.3879355', '0', '1', '0', '1', '1', ''),
('102166', '121349', '0', '0.3956428', '0', '1', '0', '1', '1', ''),
('102166', '121350', '0', '1', '0', '1', '0', '1', '1', ''),
('102166', '121351', '0', '0.305724', '0', '1', '0', '1', '1', ''),
('102166', '121352', '0', '0.236358', '0', '1', '0', '1', '1', ''),
('102166', '121353', '0', '0.2517727', '0', '1', '0', '1', '1', ''),
('102166', '121354', '0', '1', '0', '1', '0', '1', '1', ''),
('102166', '121355', '0', '1', '0', '1', '0', '1', '1', ''),
('102166', '121356', '0', '0.4495941', '0', '1', '0', '1', '1', ''),
('102166', '121357', '0', '0.1258863', '0', '1', '0', '1', '1', ''),
('102166', '121358', '0', '0.2646182', '0', '1', '0', '1', '1', ''),
('102166', '121359', '0', '5', '0', '1', '0', '1', '1', ''),
('102166', '121360', '0', '1', '0', '1', '0', '1', '1', ''),
('102166', '121361', '0', '0.1001953', '0', '1', '0', '1', '1', ''),
('102166', '121362', '0', '2', '0', '1', '0', '1', '1', ''),
('102166', '121363', '0', '4', '0', '1', '0', '1', '1', ''),
('102166', '121364', '0', '0.2029596', '0', '1', '0', '1', '1', ''),
('102166', '121365', '0', '0.1721303', '0', '1', '0', '1', '1', ''),
('102166', '121366', '0', '0.354537', '0', '1', '0', '1', '1', ''),
('102166', '121367', '0', '0.3648135', '0', '1', '0', '1', '1', ''),
('102166', '121368', '0', '0.1746994', '0', '1', '0', '1', '1', ''),
('102166', '121369', '0', '1', '0', '1', '0', '1', '1', ''),
('102166', '121370', '0', '1', '0', '1', '0', '1', '1', ''),
('102166', '121371', '0', '0.2466345', '0', '1', '0', '1', '1', ''),
('102166', '121372', '0', '0.2183743', '0', '1', '0', '1', '1', ''),
('102166', '121373', '0', '2', '0', '1', '0', '1', '1', ''),
('102166', '121384', '0', '4', '0', '1', '0', '1', '1', ''),
('102166', '121402', '0', '0.05138218', '0', '1', '0', '1', '1', ''),
('102166', '124437', '0', '52', '0', '1', '0', '1', '3', ''),
('102166', '134249', '0', '0.05138218', '0', '1', '0', '1', '1', ''),
('102166', '134398', '0', '0.05395129', '0', '1', '0', '1', '1', ''),
('102166', '138781', '0', '1', '0', '1', '0', '1', '1', ''),
('102166', '138782', '0', '2', '0', '1', '0', '1', '1', ''),
('102166', '140220', '0', '0.09505703', '0', '1', '0', '1', '1', ''),
('102166', '140221', '0', '0.3134313', '0', '1', '0', '1', '1', ''),
('102166', '140222', '0', '1', '0', '1', '0', '1', '1', ''),
('102166', '140224', '0', '0.06422772', '0', '1', '0', '1', '1', ''),
('102166', '140225', '0', '1', '0', '1', '0', '1', '1', ''),
('102166', '140226', '0', '0.4161957', '0', '1', '0', '1', '1', ''),
('102166', '140227', '0', '0.4804234', '0', '1', '0', '1', '1', ''),
('102166', '141051', '0', '0.08734971', '0', '1', '0', '1', '1', ''),
('102166', '141284', '0', '0.09505703', '0', '1', '0', '1', '1', ''),
('102166', '141293', '0', '0.09248792', '0', '1', '0', '1', '1', ''),
('102166', '144330', '0', '0.08991881', '0', '1', '0', '1', '1', ''),
('102166', '144345', '0', '0.1541465', '0', '1', '0', '1', '1', '');


-- Table `gameobject_template`
UPDATE `gameobject_template` SET `name` = 'Salles de l\'équilibre' WHERE (entry = 259391);
UPDATE `gameobject_template` SET `name` = 'barrière invisible', `size` = 1 WHERE (entry = 259095);
UPDATE `gameobject_template` SET `name` = 'Porte domaine de classe : voleur' WHERE (entry = 251033);
UPDATE `gameobject_template` SET `name` = 'Porte de domaine de classe : Paladin' WHERE (entry = 251304);
UPDATE `gameobject_template` SET `name` = 'Domaine de classe des Paladins vers Dalaran' WHERE (entry = 251673);


-- Table `item_loot_template` 
DELETE FROM `item_loot_template` WHERE `entry`='141344';
INSERT INTO `item_loot_template` (`Entry`, `Item`, `Chance`, `LootMode`, `Groupid`, `MinCount`, `MaxCount`,`Comment`) VALUES
(141344, 139026, 4.8, 1, 0, 1, 1,''),
(141344, 139025, 14, 1, 0, 1, 1,''),
(141344, 139020, 13, 1, 0, 1, 1,''),
(141344, 139023, 12, 1, 0, 1, 1,''),
(141344, 139024, 11, 1, 0, 1, 1,''),
(141344, 139021, 12, 1, 0, 1, 1,''),
(141344, 140581, 0.04, 1, 0, 1, 1,'');

DELETE FROM `item_loot_template` WHERE `entry`='140224';
INSERT INTO `item_loot_template` (`Entry`, `Item`, `Chance`, `LootMode`, `Groupid`, `MinCount`, `MaxCount`,`Comment`) VALUES
(140224, 124115, 37, 1, 0, 10, 20,''),
(140224, 124113, 36, 1, 0, 10, 20,''),
(140224, 124117, 23, 1, 0, 10, 20,''),
(140224, 124120, 23, 1, 0, 10, 20,''),
(140224, 124119, 22, 1, 0, 10, 20,''),
(140224, 124118, 22, 1, 0, 10, 20,''),
(140224, 124121, 21, 1, 0, 10, 20,''),
(140224, 124439, 17, 1, 0, 10, 20,''),
(140224, 124438, 17, 1, 0, 10, 20,''),
(140224, 124116, 1.3, 1, 0, 1, 1,'');

DELETE FROM `item_loot_template` WHERE `entry`='140221';
REPLACE INTO `item_loot_template` (`Entry`, `Item`, `Chance`, `LootMode`, `Groupid`, `MinCount`, `MaxCount`,`Comment`) VALUES
(140221, 129100, 49, 1, 0, 3, 9,''),
(140221, 130174, 16, 1, 0, 1, 2,''),
(140221, 130176, 16, 1, 0, 1, 2,''),
(140221, 130177, 16, 1, 0, 1, 2,''),
(140221, 130172, 16, 1, 0, 1, 2,''),
(140221, 130175, 16, 1, 0, 1, 2,''),
(140221, 130173, 15, 1, 0, 1, 2,''),
(140221, 129099, 13, 1, 0, 2, 6,''),
(140221, 130202, 12, 1, 0, 2, 6,''),
(140221, 130203, 12, 1, 0, 2, 6,''),
(140221, 130204, 12, 1, 0, 2, 6,''),
(140221, 130200, 11, 1, 0, 2, 6,''),
(140221, 130201, 11, 1, 0, 2, 6,''),
(140221, 130178, 9, 1, 0, 1, 1,''),
(140221, 130179, 9, 1, 0, 1, 1,''),
(140221, 130181, 9, 1, 0, 1, 1,''),
(140221, 130180, 8, 1, 0, 1, 1,''),
(140221, 130183, 8, 1, 0, 1, 1,''),
(140221, 130182, 8, 1, 0, 1, 1,'');

DELETE FROM `item_loot_template` WHERE `entry`='140222';
REPLACE INTO `item_loot_template` (`Entry`, `Item`, `Chance`, `LootMode`, `Groupid`, `MinCount`, `MaxCount`,`Comment`) VALUES
(140222, 124104, 22, 1, 0, 10, 20,''),
(140222, 124105, 22, 1, 0, 2, 4,''),
(140222, 124102, 22, 1, 0, 10, 20,''),
(140222, 124103, 22, 1, 0, 10, 20,''),
(140222, 124101, 21, 1, 0, 10, 20,''),
(140222, 124112, 19, 1, 0, 10, 20,''),
(140222, 124109, 19, 1, 0, 10, 20,''),
(140222, 124107, 19, 1, 0, 10, 20,''),
(140222, 124111, 18, 1, 0, 10, 20,''),
(140222, 124108, 18, 1, 0, 10, 20,''),
(140222, 124110, 18, 1, 0, 10, 20,''),
(140222, 124106, 1, 1, 0, 1, 1,'');

DELETE FROM `item_loot_template` WHERE `entry`='140225';
REPLACE INTO `item_loot_template` (`Entry`, `Item`, `Chance`, `LootMode`, `Groupid`, `MinCount`, `MaxCount`,`Comment`) VALUES
(140225, 123919, 48, 1, 0, 10, 20,''),
(140225, 123918, 48, 1, 0, 10, 20,''),
(140225, 124444, 1.2, 1, 0, 1, 1,''),
(140225, 121356, 2, 1, 0, 1, 1,''),
(140225, 121342, 2, 1, 0, 1, 1,''),
(140225, 121355, 2, 1, 0, 1, 1,''),
(140225, 121338, 2, 1, 0, 1, 1,''),
(140225, 121351, 2, 1, 0, 1, 1,''),
(140225, 121336, 2, 1, 0, 1, 1,''),
(140225, 121341, 2, 1, 0, 1, 1,''),
(140225, 121343, 2, 1, 0, 1, 1,''),
(140225, 121362, 2, 1, 0, 1, 1,''),
(140225, 121344, 2, 1, 0, 1, 1,''),
(140225, 121367, 2, 1, 0, 1, 1,''),
(140225, 121334, 2, 1, 0, 1, 1,''),
(140225, 121353, 2, 1, 0, 1, 1,''),
(140225, 121360, 2, 1, 0, 1, 1,''),
(140225, 121359, 2, 1, 0, 1, 1,''),
(140225, 121335, 2, 1, 0, 1, 1,''),
(140225, 121366, 2, 1, 0, 1, 1,''),
(140225, 121363, 2, 1, 0, 1, 1,''),
(140225, 121350, 2, 1, 0, 1, 1,''),
(140225, 121365, 2, 1, 0, 1, 1,''),
(140225, 121340, 2, 1, 0, 1, 1,''),
(140225, 121333, 2, 1, 0, 1, 1,''),
(140225, 121352, 2, 1, 0, 1, 1,''),
(140225, 121346, 2, 1, 0, 1, 1,''),
(140225, 121347, 2, 1, 0, 1, 1,''),
(140225, 121349, 2, 1, 0, 1, 1,''),
(140225, 121354, 2, 1, 0, 1, 1,''),
(140225, 121332, 2, 1, 0, 1, 1,''),
(140225, 121337, 2, 1, 0, 1, 1,''),
(140225, 121373, 2, 1, 0, 1, 1,''),
(140225, 121368, 2, 1, 0, 1, 1,''),
(140225, 121357, 2, 1, 0, 1, 1,''),
(140225, 121358, 2, 1, 0, 1, 1,''),
(140225, 121372, 2, 1, 0, 1, 1,''),
(140225, 121348, 2, 1, 0, 1, 1,''),
(140225, 121345, 2, 1, 0, 1, 1,''),
(140225, 121339, 2, 1, 0, 1, 1,''),
(140225, 121370, 2, 1, 0, 1, 1,''),
(140225, 121364, 2, 1, 0, 1, 1,''),
(140225, 121371, 2, 1, 0, 1, 1,''),
(140225, 121361, 2, 1, 0, 1, 1,''),
(140225, 121369, 2, 1, 0, 1, 1,''),
(140225, 134323, 0.2, 1, 0, 1, 1,''),
(140225, 121406, 0.2, 1, 0, 1, 1,''),
(140225, 139118, 0.2, 1, 0, 1, 1,''),
(140225, 139098, 0.2, 1, 0, 1, 1,''),
(140225, 134214, 0.2, 1, 0, 1, 1,''),
(140225, 134301, 0.2, 1, 0, 1, 1,''),
(140225, 121408, 0.2, 1, 0, 1, 1,''),
(140225, 121387, 0.2, 1, 0, 1, 1,''),
(140225, 121328, 0.2, 1, 0, 1, 1,''),
(140225, 121288, 0.2, 1, 0, 1, 1,''),
(140225, 139129, 0.2, 1, 0, 1, 1,''),
(140225, 121409, 0.2, 1, 0, 1, 1,''),
(140225, 121376, 0.2, 1, 0, 1, 1,''),
(140225, 121388, 0.2, 1, 0, 1, 1,''),
(140225, 134243, 0.2, 1, 0, 1, 1,''),
(140225, 121394, 0.2, 1, 0, 1, 1,''),
(140225, 134396, 0.2, 1, 0, 1, 1,''),
(140225, 134319, 0.2, 1, 0, 1, 1,''),
(140225, 134329, 0.2, 1, 0, 1, 1,''),
(140225, 134173, 0.2, 1, 0, 1, 1,''),
(140225, 134352, 0.2, 1, 0, 1, 1,''),
(140225, 121389, 0.2, 1, 0, 1, 1,'');

-- Table `npc_vendor`
DELETE FROM `npc_vendor` WHERE `entry` = '100500';
INSERT INTO `npc_vendor` (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`, `type`, `PlayerConditionID`) VALUES
('100500', '0', '137792', '0', '0', '0', '1', '0'),
('100500', '0', '137793', '0', '0', '0', '1', '0'),
('100500', '0', '137794', '0', '0', '0', '1', '0'),
('100500', '0', '137795', '0', '0', '0', '1', '0'),
('100500', '0', '137796', '0', '0', '0', '1', '0'),
('100500', '0', '137797', '0', '0', '0', '1', '0'),
('100500', '0', '137801', '0', '0', '0', '1', '0'),
('100500', '0', '137802', '0', '0', '0', '1', '0'),
('100500', '0', '137803', '0', '0', '0', '1', '0'),
('100500', '0', '137804', '0', '0', '0', '1', '0'),
('100500', '0', '137805', '0', '0', '0', '1', '0'),
('100500', '0', '137806', '0', '0', '0', '1', '0'),
('100500', '0', '137807', '0', '0', '0', '1', '0'),
('100500', '0', '137808', '0', '0', '0', '1', '0'),
('100500', '0', '137809', '0', '0', '0', '1', '0'),
('100500', '0', '137810', '0', '0', '0', '1', '0'),
('100500', '0', '137811', '0', '0', '0', '1', '0'),
('100500', '0', '137812', '0', '0', '0', '1', '0'),
('100500', '0', '137813', '0', '0', '0', '1', '0'),
('100500', '0', '137814', '0', '0', '0', '1', '0'),
('100500', '0', '137815', '0', '0', '0', '1', '0'),
('100500', '0', '137816', '0', '0', '0', '1', '0'),
('100500', '0', '137859', '0', '0', '0', '1', '0'),
('100500', '0', '137860', '0', '0', '0', '1', '0'),
('100500', '0', '137861', '0', '0', '0', '1', '0'),
('100500', '0', '138451', '0', '0', '0', '1', '0'),
('100500', '0', '138452', '0', '0', '0', '1', '0'),
('100500', '0', '138453', '0', '0', '0', '1', '0'),
('100500', '0', '138454', '0', '0', '0', '1', '0'),
('100500', '0', '138455', '0', '0', '0', '1', '0'),
('100500', '0', '138456', '0', '0', '0', '1', '0');


-- Table `creature_loot_template`
UPDATE creature_template SET lootid = 102088 WHERE entry = 102088 AND lootid = 0;
DELETE FROM `creature_loot_template` WHERE `entry` = '102088';
INSERT INTO `creature_loot_template` (`entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
('102088', '121041', '0', '0.1807741', '0', '1', '0', '1', '1', ''),
('102088', '121054', '0', '0.1063377', '0', '1', '0', '1', '1', ''),
('102088', '121071', '0', '0.2658443', '0', '1', '0', '1', '1', ''),
('102088', '121100', '0', '0.06380264', '0', '1', '0', '1', '1', ''),
('102088', '121105', '0', '1', '0', '1', '0', '1', '1', ''),
('102088', '121110', '0', '0.05316886', '0', '1', '0', '1', '1', ''),
('102088', '121129', '0', '0.06380264', '0', '1', '0', '1', '1', ''),
('102088', '121163', '0', '0.05316886', '0', '1', '0', '1', '1', ''),
('102088', '121166', '0', '0.1169715', '0', '1', '0', '1', '1', ''),
('102088', '121171', '0', '0.09570396', '0', '1', '0', '1', '1', ''),
('102088', '121173', '0', '0.06380264', '0', '1', '0', '1', '1', ''),
('102088', '121210', '0', '0.1169715', '0', '1', '0', '1', '1', ''),
('102088', '121213', '0', '0.4572522', '0', '1', '0', '1', '1', ''),
('102088', '121228', '0', '0.08507019', '0', '1', '0', '1', '1', ''),
('102088', '121236', '0', '0.4040834', '0', '1', '0', '1', '1', ''),
('102088', '121240', '0', '0.3828158', '0', '1', '0', '1', '1', ''),
('102088', '121276', '0', '0.1063377', '0', '1', '0', '1', '1', ''),
('102088', '121283', '0', '0.07443641', '0', '1', '0', '1', '1', ''),
('102088', '121292', '0', '0.08507019', '0', '1', '0', '1', '1', ''),
('102088', '121295', '0', '0.07443641', '0', '1', '0', '1', '1', ''),
('102088', '121317', '0', '0.138239', '0', '1', '0', '1', '1', ''),
('102088', '121318', '0', '0.138239', '0', '1', '0', '1', '1', ''),
('102088', '121322', '0', '0.07443641', '0', '1', '0', '1', '1', ''),
('102088', '121327', '0', '0.07443641', '0', '1', '0', '1', '1', ''),
('102088', '121332', '0', '1', '0', '1', '0', '1', '1', ''),
('102088', '121333', '0', '0.2445768', '0', '1', '0', '1', '1', ''),
('102088', '121334', '0', '1', '0', '1', '0', '1', '1', ''),
('102088', '121335', '0', '0.2552105', '0', '1', '0', '1', '1', ''),
('102088', '121336', '0', '0.2871119', '0', '1', '0', '1', '1', ''),
('102088', '121337', '0', '1', '0', '1', '0', '1', '1', ''),
('102088', '121339', '0', '3', '0', '1', '0', '1', '1', ''),
('102088', '121340', '0', '1', '0', '1', '0', '1', '1', ''),
('102088', '121341', '0', '0.3402807', '0', '1', '0', '1', '1', ''),
('102088', '121342', '0', '1', '0', '1', '0', '1', '1', ''),
('102088', '121343', '0', '0.3083794', '0', '1', '0', '1', '1', ''),
('102088', '121345', '0', '1', '0', '1', '0', '1', '1', ''),
('102088', '121346', '0', '0.2445768', '0', '1', '0', '1', '1', ''),
('102088', '121348', '0', '0.2658443', '0', '1', '0', '1', '1', ''),
('102088', '121349', '0', '1', '0', '1', '0', '1', '1', ''),
('102088', '121350', '0', '1', '0', '1', '0', '1', '1', ''),
('102088', '121351', '0', '1', '0', '1', '0', '1', '1', ''),
('102088', '121352', '0', '0.3828158', '0', '1', '0', '1', '1', ''),
('102088', '121353', '0', '0.2658443', '0', '1', '0', '1', '1', ''),
('102088', '121354', '0', '0.4040834', '0', '1', '0', '1', '1', ''),
('102088', '121356', '0', '1', '0', '1', '0', '1', '1', ''),
('102088', '121357', '0', '0.4253509', '0', '1', '0', '1', '1', ''),
('102088', '121358', '0', '0.2764781', '0', '1', '0', '1', '1', ''),
('102088', '121360', '0', '0.233943', '0', '1', '0', '1', '1', ''),
('102088', '121361', '0', '0.2020417', '0', '1', '0', '1', '1', ''),
('102088', '121362', '0', '1', '0', '1', '0', '1', '1', ''),
('102088', '121363', '0', '0.4253509', '0', '1', '0', '1', '1', ''),
('102088', '121364', '0', '2', '0', '1', '0', '1', '1', ''),
('102088', '121365', '0', '0.2871119', '0', '1', '0', '1', '1', ''),
('102088', '121366', '0', '0.2020417', '0', '1', '0', '1', '1', ''),
('102088', '121367', '0', '0.2233092', '0', '1', '0', '1', '1', ''),
('102088', '121368', '0', '0.3083794', '0', '1', '0', '1', '1', ''),
('102088', '121369', '0', '2', '0', '1', '0', '1', '1', ''),
('102088', '121370', '0', '0.3615483', '0', '1', '0', '1', '1', ''),
('102088', '121371', '0', '0.1169715', '0', '1', '0', '1', '1', ''),
('102088', '121372', '0', '0.2552105', '0', '1', '0', '1', '1', ''),
('102088', '121373', '0', '0.4997873', '0', '1', '0', '1', '1', ''),
('102088', '121388', '0', '0.1807741', '0', '1', '0', '1', '1', ''),
('102088', '121393', '0', '0.07443641', '0', '1', '0', '1', '1', ''),
('102088', '121397', '0', '0.08507019', '0', '1', '0', '1', '1', ''),
('102088', '121403', '0', '0.1063377', '0', '1', '0', '1', '1', ''),
('102088', '121407', '0', '0.06380264', '0', '1', '0', '1', '1', ''),
('102088', '121409', '0', '0.07443641', '0', '1', '0', '1', '1', ''),
('102088', '121411', '0', '0.06380264', '0', '1', '0', '1', '1', ''),
('102088', '121413', '0', '0.07443641', '0', '1', '0', '1', '1', ''),
('102088', '124437', '0', '58', '0', '1', '0', '1', '3', ''),
('102088', '127037', '0', '0.07443641', '0', '1', '0', '1', '1', ''),
('102088', '134138', '0', '0.06380264', '0', '1', '0', '1', '1', ''),
('102088', '134141', '0', '0.1063377', '0', '1', '0', '1', '1', ''),
('102088', '134142', '0', '0.07443641', '0', '1', '0', '1', '1', ''),
('102088', '134161', '0', '0.1063377', '0', '1', '0', '1', '1', ''),
('102088', '134163', '0', '0.06380264', '0', '1', '0', '1', '1', ''),
('102088', '134168', '0', '0.07443641', '0', '1', '0', '1', '1', ''),
('102088', '134171', '0', '0.1595066', '0', '1', '0', '1', '1', ''),
('102088', '134172', '0', '0.07443641', '0', '1', '0', '1', '1', ''),
('102088', '134179', '0', '0.07443641', '0', '1', '0', '1', '1', ''),
('102088', '134180', '0', '0.07443641', '0', '1', '0', '1', '1', ''),
('102088', '134194', '0', '0.07443641', '0', '1', '0', '1', '1', ''),
('102088', '134196', '0', '0.07443641', '0', '1', '0', '1', '1', ''),
('102088', '134221', '0', '0.07443641', '0', '1', '0', '1', '1', ''),
('102088', '134255', '0', '0.07443641', '0', '1', '0', '1', '1', ''),
('102088', '134265', '0', '0.07443641', '0', '1', '0', '1', '1', ''),
('102088', '134266', '0', '0.07443641', '0', '1', '0', '1', '1', ''),
('102088', '134296', '0', '0.06380264', '0', '1', '0', '1', '1', ''),
('102088', '134316', '0', '0.07443641', '0', '1', '0', '1', '1', ''),
('102088', '134342', '0', '0.1063377', '0', '1', '0', '1', '1', ''),
('102088', '134353', '0', '0.09570396', '0', '1', '0', '1', '1', ''),
('102088', '134359', '0', '0.07443641', '0', '1', '0', '1', '1', ''),
('102088', '134383', '0', '0.06380264', '0', '1', '0', '1', '1', ''),
('102088', '134387', '0', '0.07443641', '0', '1', '0', '1', '1', ''),
('102088', '134392', '0', '0.07443641', '0', '1', '0', '1', '1', ''),
('102088', '134394', '0', '0.07443641', '0', '1', '0', '1', '1', ''),
('102088', '136748', '0', '0.07443641', '0', '1', '0', '1', '1', ''),
('102088', '136757', '0', '0.07443641', '0', '1', '0', '1', '1', ''),
('102088', '136759', '0', '0.1063377', '0', '1', '0', '1', '1', ''),
('102088', '136761', '0', '0.06380264', '0', '1', '0', '1', '1', ''),
('102088', '136762', '0', '0.06380264', '0', '1', '0', '1', '1', ''),
('102088', '138781', '0', '2', '0', '1', '0', '1', '1', ''),
('102088', '138782', '0', '0.09570396', '0', '1', '0', '1', '1', ''),
('102088', '139060', '0', '0.06380264', '0', '1', '0', '1', '1', ''),
('102088', '139061', '0', '0.06380264', '0', '1', '0', '1', '1', ''),
('102088', '139066', '0', '0.1063377', '0', '1', '0', '1', '1', ''),
('102088', '139074', '0', '0.1063377', '0', '1', '0', '1', '1', ''),
('102088', '139078', '0', '0.07443641', '0', '1', '0', '1', '1', ''),
('102088', '139085', '0', '0.07443641', '0', '1', '0', '1', '1', ''),
('102088', '139094', '0', '0.1595066', '0', '1', '0', '1', '1', ''),
('102088', '139097', '0', '0.07443641', '0', '1', '0', '1', '1', ''),
('102088', '139107', '0', '0.1488728', '0', '1', '0', '1', '1', ''),
('102088', '139129', '0', '0.1063377', '0', '1', '0', '1', '1', ''),
('102088', '139130', '0', '0.1914079', '0', '1', '0', '1', '1', ''),
('102088', '139913', '0', '0.07443641', '0', '1', '0', '1', '1', ''),
('102088', '139923', '0', '0.07443641', '0', '1', '0', '1', '1', ''),
('102088', '139929', '0', '0.05316886', '0', '1', '0', '1', '1', ''),
('102088', '139938', '0', '0.1595066', '0', '1', '0', '1', '1', ''),
('102088', '140220', '0', '1', '0', '1', '0', '1', '1', ''),
('102088', '140221', '0', '0.4253509', '0', '1', '0', '1', '1', ''),
('102088', '140222', '0', '2', '0', '1', '0', '1', '1', ''),
('102088', '140224', '0', '0.07443641', '0', '1', '0', '1', '1', ''),
('102088', '140225', '0', '5', '0', '1', '0', '1', '1', ''),
('102088', '140226', '0', '0.3083794', '0', '1', '0', '1', '1', ''),
('102088', '140227', '0', '4', '0', '1', '0', '1', '1', ''),
('102088', '141286', '0', '0.138239', '0', '1', '0', '1', '1', ''),
('102088', '141289', '0', '0.1595066', '0', '1', '0', '1', '1', ''),
('102088', '141586', '0', '0.05316886', '0', '1', '0', '1', '1', ''),
('102088', '144345', '0', '0.3509145', '0', '1', '0', '1', '1', '');


UPDATE creature_template SET lootid = 102622 WHERE entry = 102622 AND lootid = 0;
DELETE FROM `creature_loot_template` WHERE `entry` = '102622';
INSERT INTO `creature_loot_template` (`entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
('102622', '121005', '0', '1', '0', '1', '0', '1', '1', ''),
('102622', '121006', '0', '0.06123987', '0', '1', '0', '1', '1', ''),
('102622', '121048', '0', '0.05181835', '0', '1', '0', '1', '1', ''),
('102622', '121052', '0', '1', '0', '1', '0', '1', '1', ''),
('102622', '121053', '0', '0.3862823', '0', '1', '0', '1', '1', ''),
('102622', '121072', '0', '0.1413228', '0', '1', '0', '1', '1', ''),
('102622', '121095', '0', '0.4004146', '0', '1', '0', '1', '1', ''),
('102622', '121104', '0', '7', '0', '1', '0', '1', '1', ''),
('102622', '121105', '0', '0.1742981', '0', '1', '0', '1', '1', ''),
('102622', '121111', '0', '0.4004146', '0', '1', '0', '1', '1', ''),
('102622', '121115', '0', '0.4004146', '0', '1', '0', '1', '1', ''),
('102622', '121116', '0', '0.3250424', '0', '1', '0', '1', '1', ''),
('102622', '121164', '0', '0.3862823', '0', '1', '0', '1', '1', ''),
('102622', '121217', '0', '0.3815715', '0', '1', '0', '1', '1', ''),
('102622', '121227', '0', '0.3862823', '0', '1', '0', '1', '1', ''),
('102622', '121240', '0', '0.3815715', '0', '1', '0', '1', '1', ''),
('102622', '121242', '0', '0.1224797', '0', '1', '0', '1', '1', ''),
('102622', '121247', '0', '0.117769', '0', '1', '0', '1', '1', ''),
('102622', '121262', '0', '0.3862823', '0', '1', '0', '1', '1', ''),
('102622', '121274', '0', '0.3862823', '0', '1', '0', '1', '1', ''),
('102622', '121331', '0', '1', '0', '1', '0', '1', '1', ''),
('102622', '121332', '0', '0.4616544', '0', '1', '0', '1', '1', ''),
('102622', '121333', '0', '0.3297532', '0', '1', '0', '1', '1', ''),
('102622', '121334', '0', '1', '0', '1', '0', '1', '1', ''),
('102622', '121335', '0', '0.1083475', '0', '1', '0', '1', '1', ''),
('102622', '121336', '0', '0.1413228', '0', '1', '0', '1', '1', ''),
('102622', '121337', '0', '1', '0', '1', '0', '1', '1', ''),
('102622', '121338', '0', '0.4993405', '0', '1', '0', '1', '1', ''),
('102622', '121339', '0', '1', '0', '1', '0', '1', '1', ''),
('102622', '121340', '0', '0.2826456', '0', '1', '0', '1', '1', ''),
('102622', '121341', '0', '0.1837196', '0', '1', '0', '1', '1', ''),
('102622', '121342', '0', '0.4475221', '0', '1', '0', '1', '1', ''),
('102622', '121343', '0', '1', '0', '1', '0', '1', '1', ''),
('102622', '121344', '0', '0.1224797', '0', '1', '0', '1', '1', ''),
('102622', '121345', '0', '0.2072734', '0', '1', '0', '1', '1', ''),
('102622', '121346', '0', '1', '0', '1', '0', '1', '1', ''),
('102622', '121348', '0', '1', '0', '1', '0', '1', '1', ''),
('102622', '121349', '0', '0.2496703', '0', '1', '0', '1', '1', ''),
('102622', '121350', '0', '0.2214057', '0', '1', '0', '1', '1', ''),
('102622', '121351', '0', '0.1224797', '0', '1', '0', '1', '1', ''),
('102622', '121352', '0', '1', '0', '1', '0', '1', '1', ''),
('102622', '121353', '0', '0.4428114', '0', '1', '0', '1', '1', ''),
('102622', '121354', '0', '1', '0', '1', '0', '1', '1', ''),
('102622', '121356', '0', '0.08950443', '0', '1', '0', '1', '1', ''),
('102622', '121357', '0', '2', '0', '1', '0', '1', '1', ''),
('102622', '121358', '0', '0.1554551', '0', '1', '0', '1', '1', ''),
('102622', '121359', '0', '0.1601658', '0', '1', '0', '1', '1', ''),
('102622', '121360', '0', '0.1224797', '0', '1', '0', '1', '1', ''),
('102622', '121361', '0', '0.2025627', '0', '1', '0', '1', '1', ''),
('102622', '121362', '0', '0.2920671', '0', '1', '0', '1', '1', ''),
('102622', '121363', '0', '0.1742981', '0', '1', '0', '1', '1', ''),
('102622', '121364', '0', '1', '0', '1', '0', '1', '1', ''),
('102622', '121365', '0', '1', '0', '1', '0', '1', '1', ''),
('102622', '121366', '0', '0.2214057', '0', '1', '0', '1', '1', ''),
('102622', '121367', '0', '0.2119842', '0', '1', '0', '1', '1', ''),
('102622', '121368', '0', '0.136612', '0', '1', '0', '1', '1', ''),
('102622', '121369', '0', '0.3061994', '0', '1', '0', '1', '1', ''),
('102622', '121370', '0', '0.2685133', '0', '1', '0', '1', '1', ''),
('102622', '121371', '0', '0.06123987', '0', '1', '0', '1', '1', ''),
('102622', '121372', '0', '1', '0', '1', '0', '1', '1', ''),
('102622', '121373', '0', '0.2449595', '0', '1', '0', '1', '1', ''),
('102622', '121384', '0', '0.07537215', '0', '1', '0', '1', '1', ''),
('102622', '121404', '0', '0.08479367', '0', '1', '0', '1', '1', ''),
('102622', '121414', '0', '1', '0', '1', '0', '1', '1', ''),
('102622', '124437', '0', '62', '0', '1', '0', '1', '3', ''),
('102622', '134161', '0', '0.05181835', '0', '1', '0', '1', '1', ''),
('102622', '134245', '0', '0.07537215', '0', '1', '0', '1', '1', ''),
('102622', '134307', '0', '0.07066139', '0', '1', '0', '1', '1', ''),
('102622', '136766', '0', '0.05181835', '0', '1', '0', '1', '1', ''),
('102622', '138781', '0', '2', '0', '1', '0', '1', '1', ''),
('102622', '138782', '0', '0.4757867', '0', '1', '0', '1', '1', ''),
('102622', '140220', '0', '0.1507443', '0', '1', '0', '1', '1', ''),
('102622', '140221', '0', '0.3203316', '0', '1', '0', '1', '1', ''),
('102622', '140222', '0', '1', '0', '1', '0', '1', '1', ''),
('102622', '140225', '0', '0.1319013', '0', '1', '0', '1', '1', ''),
('102622', '140226', '0', '0.254381', '0', '1', '0', '1', '1', ''),
('102622', '140227', '0', '0.471076', '0', '1', '0', '1', '1', ''),
('102622', '141284', '0', '0.3862823', '0', '1', '0', '1', '1', ''),
('102622', '141285', '0', '0.3957038', '0', '1', '0', '1', '1', ''),
('102622', '144330', '0', '1', '0', '1', '0', '1', '1', ''),
('102622', '144345', '0', '0.1601658', '0', '1', '0', '1', '1', ''),
('102622', '153202', '0', '0.05181835', '0', '1', '0', '1', '1', '');


-- Table `item_loot_template`
INSERT IGNORE INTO `item_loot_template` (`entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
('153116', '124102', '0', '33.9231', '0', '1', '0', '10', '15', ''),
('153116', '124104', '0', '33.6636', '0', '1', '0', '10', '15', ''),
('153116', '151565', '0', '32.69639', '0', '1', '0', '10', '15', ''),
('153116', '124105', '0', '31.77636', '0', '1', '0', '10', '15', ''),
('153116', '124106', '0', '31.51687', '0', '1', '0', '1', '3', ''),
('153116', '124101', '0', '30.90351', '0', '1', '0', '10', '15', ''),
('153116', '124103', '0', '30.38453', '0', '1', '0', '10', '15', ''),
('153116', '128304', '0', '29.44091', '0', '1', '0', '15', '20', ''),
('153117', '127835', '0', '46.37107', '0', '1', '0', '2', '5', ''),
('153117', '152615', '0', '46.07382', '0', '1', '0', '2', '5', ''),
('153117', '127846', '0', '8.199158', '0', '1', '0', '2', '3', ''),
('153117', '127839', '0', '7.10924', '0', '1', '0', '2', '3', ''),
('153117', '151609', '0', '7.10924', '0', '1', '0', '2', '3', ''),
('153117', '142117', '0', '6.589051', '0', '1', '0', '2', '3', ''),
('153117', '127844', '0', '6.564281', '0', '1', '0', '2', '3', ''),
('153117', '151608', '0', '6.440426', '0', '1', '0', '2', '3', ''),
('153117', '127836', '0', '6.316572', '0', '1', '0', '2', '5', ''),
('153117', '130250', '0', '5.945009', '0', '1', '0', '2', '3', ''),
('153117', '141446', '0', '5.895467', '0', '1', '0', '2', '3', ''),
('153117', '127843', '0', '5.845925', '0', '1', '0', '2', '3', ''),
('153117', '142406', '0', '5.821154', '0', '1', '0', '2', '3', ''),
('153117', '132509', '0', '5.647758', '0', '1', '0', '2', '3', ''),
('153117', '127838', '0', '5.548675', '0', '1', '0', '2', '3', ''),
('153117', '123956', '0', '5.40005', '0', '1', '0', '2', '3', ''),
('153117', '127840', '0', '5.40005', '0', '1', '0', '2', '3', ''),
('153117', '132515', '0', '5.40005', '0', '1', '0', '2', '3', ''),
('153117', '132516', '0', '5.300966', '0', '1', '0', '2', '3', ''),
('153117', '127845', '0', '5.226654', '0', '1', '0', '2', '3', ''),
('153117', '132513', '0', '5.028487', '0', '1', '0', '2', '3', ''),
('153117', '132514', '0', '4.954174', '0', '1', '0', '2', '3', ''),
('153117', '132510', '0', '4.929403', '0', '1', '0', '2', '3', ''),
('153117', '139503', '0', '4.706465', '0', '1', '0', '2', '3', ''),
('153117', '127837', '0', '4.632153', '0', '1', '0', '2', '3', ''),
('153117', '136708', '0', '4.632153', '0', '1', '0', '2', '3', ''),
('153117', '136606', '0', '4.607382', '0', '1', '0', '1', '3', ''),
('153117', '132511', '0', '4.582611', '0', '1', '0', '1', '1', ''),
('153117', '127841', '0', '4.533069', '0', '1', '0', '2', '3', ''),
('153117', '127848', '0', '4.26059', '0', '1', '0', '2', '3', ''),
('153117', '127850', '0', '4.012881', '0', '1', '0', '2', '3', ''),
('153117', '131746', '0', '3.963339', '0', '1', '0', '2', '3', ''),
('153117', '127847', '0', '3.889026', '0', '1', '0', '2', '3', ''),
('153117', '127849', '0', '3.319297', '0', '1', '0', '2', '3', ''),
('153117', '133565', '0', '3.269755', '0', '1', '0', '10', '10', ''),
('153117', '133573', '0', '3.269755', '0', '1', '0', '10', '10', ''),
('153117', '133566', '0', '3.220213', '0', '1', '0', '10', '10', ''),
('153117', '133576', '0', '3.170671', '0', '1', '0', '10', '10', ''),
('153117', '133572', '0', '3.12113', '0', '1', '0', '10', '10', ''),
('153117', '133570', '0', '3.022046', '0', '1', '0', '10', '10', ''),
('153117', '133557', '0', '2.997275', '0', '1', '0', '10', '10', ''),
('153117', '133567', '0', '2.947733', '0', '1', '0', '10', '10', ''),
('153117', '133562', '0', '2.922963', '0', '1', '0', '10', '10', ''),
('153117', '133579', '0', '2.898192', '0', '1', '0', '3', '5', ''),
('153117', '133568', '0', '2.724796', '0', '1', '0', '10', '10', ''),
('153117', '133574', '0', '2.650483', '0', '1', '0', '10', '10', ''),
('153117', '133575', '0', '2.650483', '0', '1', '0', '10', '10', ''),
('153117', '133561', '0', '2.57617', '0', '1', '0', '10', '10', ''),
('153117', '133577', '0', '2.57617', '0', '1', '0', '10', '10', ''),
('153117', '133569', '0', '2.427545', '0', '1', '0', '10', '10', ''),
('153117', '133681', '0', '2.427545', '0', '1', '0', '5', '5', ''),
('153117', '133571', '0', '2.155066', '0', '1', '0', '10', '10', ''),
('153117', '133563', '0', '2.080753', '0', '1', '0', '10', '10', ''),
('153117', '133578', '0', '2.080753', '0', '1', '0', '3', '5', ''),
('153117', '133564', '0', '1.956899', '0', '1', '0', '10', '10', ''),
('153117', '127851', '0', '0.2477087', '0', '1', '0', '1', '1', ''),
('153118', '151720', '0', '25.92498', '0', '1', '0', '2', '5', ''),
('153118', '151722', '0', '21.22991', '0', '1', '0', '2', '5', ''),
('153118', '151719', '0', '21.05129', '0', '1', '0', '2', '5', ''),
('153118', '151718', '0', '20.41337', '0', '1', '0', '2', '5', ''),
('153118', '151721', '0', '19.57132', '0', '1', '0', '2', '5', ''),
('153118', '151579', '0', '19.49477', '0', '1', '0', '2', '5', ''),
('153118', '130182', '0', '15.43761', '0', '1', '0', '2', '5', ''),
('153118', '130181', '0', '14.54453', '0', '1', '0', '2', '5', ''),
('153118', '130183', '0', '13.77903', '0', '1', '0', '2', '5', ''),
('153118', '130179', '0', '13.60041', '0', '1', '0', '2', '5', ''),
('153118', '130178', '0', '13.16662', '0', '1', '0', '2', '5', ''),
('153118', '130245', '0', '12.83491', '0', '1', '0', '2', '5', ''),
('153118', '130180', '0', '12.42664', '0', '1', '0', '2', '5', ''),
('153118', '130174', '0', '8.981883', '0', '1', '0', '3', '6', ''),
('153118', '130176', '0', '7.706048', '0', '1', '0', '3', '6', ''),
('153118', '130175', '0', '7.22123', '0', '1', '0', '3', '6', ''),
('153118', '130177', '0', '7.22123', '0', '1', '0', '3', '6', ''),
('153118', '130172', '0', '6.532279', '0', '1', '0', '3', '6', ''),
('153118', '130173', '0', '6.481245', '0', '1', '0', '3', '6', ''),
('153119', '151567', '0', '94.10774', '0', '1', '0', '8', '12', ''),
('153119', '124437', '0', '72.72727', '0', '1', '0', '8', '12', ''),
('153119', '127004', '0', '7.912458', '0', '1', '0', '3', '6', ''),
('153120', '151564', '0', '80.75413', '0', '1', '0', '10', '15', ''),
('153120', '123918', '0', '58.54936', '0', '1', '0', '10', '15', ''),
('153120', '123919', '0', '58.52317', '0', '1', '0', '8', '12', ''),
('153120', '124444', '0', '8.352972', '0', '1', '0', '1', '2', ''),
('153121', '151566', '0', '61.27334', '0', '1', '0', '10', '15', ''),
('153121', '124115', '0', '43.65725', '0', '1', '0', '10', '15', ''),
('153121', '124113', '0', '41.50311', '0', '1', '0', '10', '15', ''),
('153121', '136534', '0', '30.22977', '0', '1', '0', '8', '12', ''),
('153121', '136533', '0', '29.5596', '0', '1', '0', '8', '12', ''),
('153121', '124439', '0', '15.53375', '0', '1', '0', '10', '15', ''),
('153121', '124438', '0', '14.57635', '0', '1', '0', '10', '15', ''),
('153121', '124116', '0', '5.481091', '0', '1', '0', '1', '2', ''),
('153122', '124440', '0', '90.59056', '0', '1', '0', '10', '15', ''),
('153122', '124441', '0', '77.30997', '0', '1', '0', '8', '12', ''),
('153122', '124442', '0', '5.453518', '0', '1', '0', '1', '2', ''),
('153248', '151568', '0', '100', '0', '1', '0', '1', '5', '');

 -- Table `access_requirement`
INSERT IGNORE INTO `access_requirement` VALUES (1753, 2, 110, 0, 0, 0, 0, 0, 0, NULL, 'Siège du triumvirat (Entrée) - Héroique');
INSERT IGNORE INTO `access_requirement` VALUES (1753, 23, 110, 0, 0, 0, 0, 0, 0, NULL, 'Siège du triumvirat (Entrée) - Mythique');
INSERT IGNORE INTO `access_requirement` VALUES (1712, 14, 110, 0, 0, 0, 0, 0, 0, NULL, 'Antorus, le Trône ardent (Entrée) - 30 Normal');
INSERT IGNORE INTO `access_requirement` VALUES (1712, 15, 110, 0, 0, 0, 0, 0, 0, NULL, 'Antorus, le Trône ardent (Entrée) - 30 Héroique');
INSERT IGNORE INTO `access_requirement` VALUES (1712, 16, 110, 0, 0, 0, 0, 0, 0, NULL, 'Antorus, le Trône ardent (Entrée) - 20 Mythique');
INSERT IGNORE INTO `access_requirement` VALUES (1712, 17, 110, 0, 0, 0, 0, 0, 0, NULL, 'Antorus, le Trône ardent (Entrée) - 20 LFR');
  
  
-- Table `creature_template`
UPDATE `creature_template` SET `unit_flags` = 33570944 WHERE (entry = 54638);
UPDATE `creature_template` SET `unit_flags` = 33555200 WHERE (entry = 99501);
UPDATE `creature_template` SET `HealthModifier` = 8 WHERE (entry = 86969);
UPDATE `creature_template` SET `HealthModifier` = 1.8 WHERE (entry = 93619);
UPDATE `creature_template` SET `HealthModifier` = 3 WHERE (entry = 93619);


-- Table `creature_onkill_reputation`
DELETE FROM `creature_onkill_reputation` WHERE `RewOnKillRepFaction1`=1850;
INSERT INTO `creature_onkill_reputation` (`creature_id`, `RewOnKillRepFaction1`, `RewOnKillRepFaction2`, `MaxStanding1`, `IsTeamAward1`, `RewOnKillRepValue1`, `MaxStanding2`, `IsTeamAward2`, `RewOnKillRepValue2`, `TeamDependent`) VALUES 
(89746, 1850, 0, 7, 0, 25, 0, 0, 0, 0),
(92466, 1850, 0, 7, 0, 25, 0, 0, 0, 0),
(92481, 1850, 0, 7, 0, 25, 0, 0, 0, 0),
(89695, 1850, 0, 7, 0, 25, 0, 0, 0, 0),
(89747, 1850, 0, 7, 0, 25, 0, 0, 0, 0),
(92508, 1850, 0, 7, 0, 500, 0, 0, 0, 0),
(92517, 1850, 0, 7, 0, 500, 0, 0, 0, 0),
(92495, 1850, 0, 7, 0, 500, 0, 0, 0, 0),
(92465, 1850, 0, 7, 0, 500, 0, 0, 0, 0);


-- Table `creature_addon` 
INSERT IGNORE INTO `creature_addon` (`guid`) VALUES ('20556170');
UPDATE `creature_addon` SET `emote` = 469 WHERE (guid = 20556170);
UPDATE `creature_addon` SET `auras` = 104939 WHERE (guid = 20556170);


-- Table `creature_queststarter`
DELETE FROM `creature_queststarter` WHERE `id`=915 AND `quest`=26915;
DELETE FROM `creature_questender` WHERE `id`=915 AND `quest`=26915;


-- //  HannibalRoG fix // --

-- QuarterMaster factions vendors
DELETE FROM conditions WHERE SourceGroup IN (50323, 50488, 50477, 50309, 50308, 49877, 50305, 50307, 50306, 50483, 50484, 50304);
INSERT INTO conditions (SourceTypeOrReferenceId, SourceGroup, SourceEntry, SourceId, ElseGroup, ConditionTypeOrReference, ConditionTarget, ConditionValue1, ConditionValue2, ConditionValue3, NegativeCondition, ErrorType, ErrorTextId, ScriptName, Comment) VALUES
(23, 50323, 67525, 0, 0, 5, 0, 1133, 64, 0, 0, 0, 0, '', ''),
(23, 50488, 67533, 0, 0, 5, 0, 76, 64, 0, 0, 0, 0, '', ''),
(23, 50477, 67536, 0, 0, 5, 0, 530, 64, 0, 0, 0, 0, '', ''),
(23, 50309, 67528, 0, 0, 5, 0, 47, 64, 0, 0, 0, 0, '', ''),
(23, 50308, 67530, 0, 0, 5, 0, 54, 64, 0, 0, 0, 0, '', ''),
(23, 49877, 67531, 0, 0, 5, 0, 72, 64, 0, 0, 0, 0, '', ''),
(23, 50305, 67526, 0, 0, 5, 0, 69, 64, 0, 0, 0, 0, '', ''),
(23, 50307, 67532, 0, 0, 5, 0, 1134, 64, 0, 0, 0, 0, '', ''),
(23, 50306, 67527, 0, 0, 5, 0, 930, 64, 0, 0, 0, 0, '', ''),
(23, 50483, 67534, 0, 0, 5, 0, 81, 64, 0, 0, 0, 0, '', ''),
(23, 50484, 67525, 0, 0, 5, 0, 1133, 64, 0, 0, 0, 0, '', ''),
(23, 50304, 67529, 0, 0, 5, 0, 68, 64, 0, 0, 0, 0, '', '');

-- Set only one daily quest from some trainers, add some missing pools
UPDATE pool_template SET max_limit=1, description='Catherine Leland - Daily Quests' WHERE entry=369;
UPDATE pool_template SET max_limit=1 WHERE entry=368;
DELETE FROM pool_quest WHERE entry IN (26543, 26556, 26557, 26572, 26588);
INSERT INTO pool_quest (entry, pool_entry, description) VALUES
(26543, 347, 'Clammy Hands'),
(26556, 347, 'No Dumping Allowed'),
(26557, 347, 'A Staggering Effort'),
(26572, 347, 'A Golden Opportunity'),
(26588, 347, 'A Furious Catch');
UPDATE pool_template SET description='Razgar Daily quests' WHERE entry=347;

DELETE FROM pool_quest WHERE entry IN (29345, 29346, 29348, 29349, 29354);
INSERT INTO pool_quest (entry, pool_entry, description) VALUES
(29345, 346, 'Pond Predators'),
(29346, 346, 'The Rings the Thing'),
(29348, 346, 'The Race to Restock'),
(29349, 346, 'Craving Crayfish'),
(29354, 346, 'Shiny Baubles');
UPDATE pool_template SET description='Kah Mistrunner Daily quests' WHERE entry=346;

-- When you died in Mardum you appear in Westfall (Alliance) or Northern Barrens (Horde)
DELETE FROM `graveyard_zone` WHERE `GhostZone` = 7705;
INSERT INTO `graveyard_zone` (`ID`, `GhostZone`, `Faction`, `Comment`) VALUES 
(5082, 7705, 0, '7.0 DH-Mardum - (01) Start'),
(5083, 7705, 0, '7.0 DH-Mardum - (03) Seat of Command'),
(5119, 7705, 0, '7.0 DH-Mardum - (04) Illidari Foothold'),
(5140, 7705, 0, '7.0 DH-Mardum - (05) Volcano'),
(5188, 7705, 0, '7.0 DH-Mardum - (06) The Fel Hammer'),
(5284, 7705, 0, '7.0 DH-Mardum - (02) Molten Shore');

-- Error in quest 39963 "On felbat wins" when you shoose Havoc spec
UPDATE `quest_template_addon` SET `NextQuestID`=39663 WHERE `ID` IN (39515, 39516);

/*Add some missing loot for creatures and object PART 1*/
-- NPC 93105 Inquisitor Baleful
DELETE FROM `creature_loot_template` WHERE `entry`=93105;
INSERT INTO `creature_loot_template` (`Entry`,`Item`,`Reference`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`)
VALUES  (93105, 129196, 0, 0.8, 0, 1, 0, 1, 1, 'Legion Healthstone');

-- NPC 93112 Felguard Sentry
DELETE FROM `creature_loot_template` WHERE `entry`=93112;
INSERT INTO `creature_loot_template` (`Entry`,`Item`,`Reference`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES  
(93112, 129196, 0, 2, 0, 1, 0, 1, 1, 'Legion Healthstone'),
(93112, 130267, 0, 88, 0, 1, 1, 1, 1, 'Extinguished Demon Stone'),
(93112, 130268, 0, 22, 0, 1, 2, 1, 1, 'Bone Toothpick'),     
(93112, 130317, 0, 4, 0, 1, 3, 1, 1, 'Fractured Trophy'),
(93112, 130264, 0, 20, 0, 1, 4, 1, 1, 'Fel-Stained Claw'),
(93112, 130265, 0, 2, 0, 1, 5, 1, 1, 'Sharpened Canine'),
(93112, 130266, 0, 1.2, 0, 1, 6, 1, 1, 'Trophy Spine');
UPDATE `creature_template` SET `lootid`= 93112 WHERE `Entry`=93112;

-- NPC 93221 Doom Commander Beliash
DELETE FROM `creature_loot_template` WHERE `entry`=93221;	
INSERT INTO `creature_loot_template` (`Entry`,`Item`,`Reference`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(93221, 129196, 0, 1.7, 0, 1, 0, 1, 1, 'Legion Healthstone'),
(93221, 130267, 0, 85, 0, 1, 1, 1, 1, 'Extinguished Demon Stone'),
(93221, 130268, 0, 12, 0, 1, 2, 1, 1, 'Bone Toothpick'),
(93221, 130317, 0, 4, 0, 1, 3, 1, 1, 'Fractured Trophy');
UPDATE `creature_template` SET `lootid`=93221 WHERE `Entry`=93221;

-- NPC 93115 "Foul Felstalker"
DELETE FROM `creature_loot_template` WHERE `entry`=93115;	
INSERT INTO `creature_loot_template` (`Entry`,`Item`,`Reference`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(93115, 130267, 0, 15, 0, 1, 0, 1, 1, 'Extinguished Demon Stone'),
(93115, 130268, 0, 6, 0, 1, 1, 1, 1, 'Bone Toothpick'),
(93115, 130317, 0, 0.8, 0, 1, 2, 1, 1, 'Fractured Trophy'),
(93115, 130264, 0, 87, 0, 1, 3, 1, 1, 'Fel-Stained Claw'),
(93115, 130265, 0, 10, 0, 1, 4, 1, 1, 'Sharpened Canine'),
(93115, 130266, 0, 4, 0, 1, 5, 1, 1, 'Trophy Spine');
UPDATE `creature_template` SET `lootid`=93115 WHERE `Entry`=93115;

-- NPC 93716 Doom Slayer
DELETE FROM `creature_loot_template` WHERE `entry`=93716;	
INSERT INTO `creature_loot_template` (`Entry`,`Item`,`Reference`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(93716, 129196, 0, 2, 0, 1, 0, 1, 1, 'Legion Healthstone'),
(93716, 130267, 0, 91, 0, 1, 1, 1, 1, 'Extinguished Demon Stone'),
(93716, 130268, 0, 19, 0, 1, 2, 1, 1, 'Bone Toothpick'),
(93716, 130317, 0, 5, 0, 1, 3, 1, 1, 'Fractured Trophy'),
(93716, 130264, 0, 0.5, 0, 1, 4, 1, 1, 'Fel-Stained Claw'),
(93716, 130265, 0, 0.02, 0, 1, 5, 1, 1, 'Sharpened Canine');
UPDATE `creature_template` SET `lootid`=93716 WHERE `Entry`=93716;

-- NPC 93802 Brood Queen Tyranna
DELETE FROM `creature_loot_template` WHERE `entry`=93802;
INSERT INTO `creature_loot_template` (`Entry`,`Item`,`Reference`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(93802, 129196, 0, 7, 0, 1, 0, 1, 1, 'Legion Healthstone'),
(93802, 130267, 0, 42, 0, 1, 1, 1, 1, 'Extinguished Demon Stone'),
(93802, 130268, 0, 44, 0, 1, 2, 1, 1, 'Bone Toothpick'),
(93802, 130317, 0, 15, 0, 1, 3, 1, 1, 'Fractured Trophy'),
(93802, 124672, 0, 97, 1, 1, 4, 1, 1, 'Sargerite Keystone');
UPDATE `creature_template` SET `lootid`=93802 WHERE `Entry`=93802;

-- NPC 94654 Doomguard Eradicator
DELETE FROM `creature_loot_template` WHERE `entry`=94654;	
INSERT INTO `creature_loot_template` (`Entry`,`Item`,`Reference`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(94654, 129196, 0, 1.5, 0, 1, 0, 1, 1, 'Legion Healthstone'),
(94654, 130267, 0, 86, 0, 1, 1, 1, 1, 'Extinguished Demon Stone'),
(94654, 130268, 0, 17, 0, 1, 2, 1, 1, 'Bone Toothpick'),
(94654, 130317, 0, 3, 0, 1, 3, 1, 1, 'Fractured Trophy'),
(94654, 130264, 0, 8, 0, 1, 4, 1, 1, 'Fel-Stained Claw'),
(94654, 130265, 0, 1.5, 0, 1, 5, 1, 1, 'Sharpened Canine'),
(94654, 130266, 0, 0.6, 0, 1, 6, 1, 1, 'Trophy Spine');
UPDATE `creature_template` SET `lootid`=94654 WHERE `Entry`=94654;

-- NPC 95226 Anguish Jailer
DELETE FROM `creature_loot_template` WHERE `entry`=95226;	
INSERT INTO `creature_loot_template` (`Entry`,`Item`,`Reference`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(95226, 129196, 0, 1, 0, 1, 0, 1, 1, 'Legion Healthstone'),
(95226, 130267, 0, 87, 0, 1, 1, 1, 1, 'Extinguished Demon Stone'),
(95226, 130268, 0, 13, 0, 1, 2, 1, 1, 'Bone Toothpick'),
(95226, 130317, 0, 3, 0, 1, 3, 1, 1, 'Fractured Trophy'),
(95226, 130264, 0, 6, 0, 1, 4, 1, 1, 'Fel-Stained Claw'),
(95226, 130265, 0, 1, 0, 1, 5, 1, 1, 'Sharpened Canine'),
(95226, 128227, 0, 20, 0, 1, 6, 1, 1, ''),
(95226, 130266, 0, 0.3, 0, 1, 7, 1, 1, 'Trophy Spine');
UPDATE `creature_template` SET `lootid`=95226 WHERE `Entry`=95226;

-- NPC 96277 Queen's Centurion
DELETE FROM `creature_loot_template` WHERE `entry`=96277;	
INSERT INTO `creature_loot_template` (`Entry`,`Item`,`Reference`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(96277, 129196, 0, 1, 0, 1, 0, 1, 1, 'Legion Healthstone'),
(96277, 130267, 0, 87, 0, 1, 1, 1, 1, 'Extinguished Demon Stone'),
(96277, 130268, 0, 13, 0, 1, 2, 1, 1, 'Bone Toothpick'),
(96277, 130317, 0, 3, 0, 1, 3, 1, 1, 'Fractured Trophy'),
(96277, 130264, 0, 6, 0, 1, 4, 1, 1, 'Fel-Stained Claw'),
(96277, 130265, 0, 1, 0, 1, 5, 1, 1, 'Sharpened Canine'),
(96277, 133580, 0, 0.01, 0, 1, 6, 1, 1, 'Brutarg Sword Tip'),
(96277, 130266, 0, 0.3, 0, 1, 7, 1, 1, 'Trophy Spine'),
(96277, 130261, 0, 0.01, 0, 1, 8, 1, 1, 'Brutarg´s Sword');


UPDATE `creature_template` SET `lootid`=96277 WHERE `Entry`=96277;

-- NPC 96278 Burning Soulstalker
DELETE FROM `creature_loot_template` WHERE `entry`=96278;	
INSERT INTO `creature_loot_template` (`Entry`,`Item`,`Reference`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(96278, 129196, 0, 1, 0, 1, 0, 1, 1, 'Legion Healthstone'),
(96278, 128948, 0, 0.1, 0, 1, 1, 1, 1, ''),
(96278, 130268, 0, 13, 0, 1, 2, 1, 1, 'Bone Toothpick'),
(96278, 130317, 0, 3, 0, 1, 3, 1, 1, 'Fractured Trophy'),
(96278, 130264, 0, 6, 0, 1, 4, 1, 1, 'Fel-Stained Claw'),
(96278, 130265, 0, 1, 0, 1, 5, 1, 1, 'Sharpened Canine'),
(96278, 130266, 0, 0.3, 0, 1, 7, 1, 1, 'Trophy Spine');
UPDATE `creature_template` SET `lootid`=96278 WHERE `Entry`=96278;

-- NPC 96280 Volatile Minion
DELETE FROM `creature_loot_template` WHERE `entry`=96280;	
INSERT INTO `creature_loot_template` (`Entry`,`Item`,`Reference`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(96280, 130267, 0, 87, 0, 1, 1, 1, 1, 'Extinguished Demon Stone'),
(96280, 130268, 0, 13, 0, 1, 2, 1, 1, 'Bone Toothpick'),
(96280, 130317, 0, 3, 0, 1, 3, 1, 1, 'Fractured Trophy'),
(96280, 130264, 0, 6, 0, 1, 4, 1, 1, 'Fel-Stained Claw'),
(96280, 130265, 0, 1, 0, 1, 5, 1, 1, 'Sharpened Canine'),
(96280, 130266, 0, 0.3, 0, 1, 7, 1, 1, 'Trophy Spine');
UPDATE `creature_template` SET `lootid`=96280 WHERE `Entry`=96280;

-- NPC 96402 Hulking Forgefiend
DELETE FROM `creature_loot_template` WHERE `entry`=96402;	
INSERT INTO `creature_loot_template` (`Entry`,`Item`,`Reference`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(96402, 129196, 0, 1, 0, 1, 0, 1, 1, 'Legion Healthstone'),
(96402, 130267, 0, 87, 0, 1, 1, 1, 1, 'Extinguished Demon Stone'),
(96402, 130268, 0, 13, 0, 1, 2, 1, 1, 'Bone Toothpick'),
(96402, 130317, 0, 3, 0, 1, 3, 1, 1, 'Fractured Trophy'),
(96402, 130264, 0, 6, 0, 1, 4, 1, 1, 'Fel-Stained Claw'),
(96402, 130265, 0, 1, 0, 1, 5, 1, 1, 'Sharpened Canine'),
(96402, 133580, 0, 0.6, 0, 1, 6, 1, 1, ''),
(96402, 130261, 0, 0.6, 0, 1, 7, 1, 1, 'Brutarg´s Sword');
UPDATE `creature_template` SET `lootid`=96402 WHERE `Entry`=96402;

-- NPC 96441 Fel Lord Caza
DELETE FROM `creature_loot_template` WHERE `entry`=96441;	
INSERT INTO `creature_loot_template` (`Entry`,`Item`,`Reference`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(96441, 129196, 0, 1.2, 0, 1, 0, 1, 1, 'Legion Healthstone'),
(96441, 130267, 0, 80, 0, 1, 1, 1, 1, 'Extinguished Demon Stone'),
(96441, 130268, 0, 19, 0, 1, 2, 1, 1, 'Bone Toothpick'),
(96441, 130317, 0, 3, 0, 1, 3, 1, 1, 'Fractured Trophy');
UPDATE `creature_template` SET `lootid`=96441 WHERE `Entry`=96441;

-- NPC 96473 Eredar Sorcerer
DELETE FROM `creature_loot_template` WHERE `entry`=96473;	
INSERT INTO `creature_loot_template` (`Entry`,`Item`,`Reference`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(96473, 129196, 0, 2, 0, 1, 0, 1, 1, 'Legion Healthstone'),
(96473, 130267, 0, 92, 0, 1, 1, 1, 1, 'Extinguished Demon Stone'),
(96473, 130268, 0, 15, 0, 1, 2, 1, 1, 'Bone Toothpick'),
(96473, 130317, 0, 5, 0, 1, 3, 1, 1, 'Fractured Trophy');
UPDATE `creature_template` SET `lootid`=96473 WHERE `Entry`=96473;

-- Add some missing creature text
DELETE FROM `creature_text` WHERE `CreatureID` IN (99916, 94410, 99917, 93105, 99915, 96654, 96436, 100982);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `type`, `language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `comment`) VALUES
(99916, 0, 0, 'Plenty of souls were sacrificed here. The activator is powered.', 12, 0, 100, 273, 0, 55344, '101656', 'Sevis Brightflame to Player'),
(94410, 0, 0, '$n, over here.', 12, 0, 100, 0, 0, 55011, 96441, 'Allari the Souleater to Player'),
(99917, 0, 0, '$n, hurry! You don''t have much time.', 12, 0, 100, 3, 0, 55345, '101658', 'Sevis Brightflame to Player'),
(99917, 1, 0, 'Sevis looks down at the dying broken mystic.', 16, 0, 100, 0, 0, 0, '101659', 'Sevis Brightflame to Player'),
(93105, 0, 0, 'I can see your secrets...', 12, 0, 100, 0, 0, 55222, 94930, 'Inquisitor Baleful to Player'),
(93105, 1, 0, 'My eyes... My eyes!', 14, 0, 100, 0, 0, 55223, 96010, 'Inquisitor Baleful to Player'),
(93105, 2, 0, 'Enough! My colossal infernal will crush you.', 14, 0, 100, 0, 0, 55224, 99554, 'Inquisitor Baleful to Player'),
(99915, 0, 0, '$n, we have a huge problem here.', 12, 0, 100, 0, 0, 55342, '101663', 'Sevis Brightflame to Player'),
(96654, 0, 0, '$n, you made it through!', 14, 0, 100, 22, 0, 55054, 99836, 'Belath Dawnblade to Player'),
(96436, 0, 0, '$n, will you use your spectral sight on the cave entrance? Something''s not right.', 12, 0, 100, 397, 0, 55233, 98201, 'Jace Darkweaver to Player'),
(99916, 1, 0, 'I will move ahead and find Allari.', 12, 0, 100, 0, 0, 55346, 101657, 'Sevis Brightflame to Player'),
(100982, 0, 0, 'I will meet you down at the gateway on the Molten Shore.', 12, 0, 100, 0, 0, 55352, 103349, 'Sevis Brightflame to Player');


DELETE FROM `npc_text` WHERE `ID` IN (27307, 27421, 27624, 28106, 27622, 27623, 26129, 26832, 26676, 26592, 28000, 27999, 27770, 27954, 27998, 26813, 27773, 27768, 27772, 27545, 27283, 27471, 28886, 27771, 27206, 27769);
INSERT INTO `npc_text` (`ID`, `Probability0`, `Probability1`, `Probability2`, `Probability3`, `Probability4`, `Probability5`, `Probability6`, `Probability7`, `BroadcastTextId0`, `BroadcastTextId1`, `BroadcastTextId2`, `BroadcastTextId3`, `BroadcastTextId4`, `BroadcastTextId5`, `BroadcastTextId6`, `BroadcastTextId7`, `VerifiedBuild`) VALUES
(27307, 1, 0, 0, 0, 0, 0, 0, 0, 99020, 0, 0, 0, 0, 0, 0, 0, 22908),
(27421, 1, 0, 0, 0, 0, 0, 0, 0, 99834, 0, 0, 0, 0, 0, 0, 0, 22908),
(27624, 1, 0, 0, 0, 0, 0, 0, 0, 100749, 0, 0, 0, 0, 0, 0, 0, 22908),
(28106, 1, 0, 0, 0, 0, 0, 0, 0, 103959, 0, 0, 0, 0, 0, 0, 0, 22908),
(27622, 1, 0, 0, 0, 0, 0, 0, 0, 100733, 0, 0, 0, 0, 0, 0, 0, 22908),
(27623, 1, 0, 0, 0, 0, 0, 0, 0, 100737, 0, 0, 0, 0, 0, 0, 0, 22908),
(26129, 1, 0, 0, 0, 0, 0, 0, 0, 92162, 0, 0, 0, 0, 0, 0, 0, 22908),
(26832, 1, 0, 0, 0, 0, 0, 0, 0, 96307, 0, 0, 0, 0, 0, 0, 0, 22908),
(26676, 1, 0, 0, 0, 0, 0, 0, 0, 95397, 0, 0, 0, 0, 0, 0, 0, 22908),
(26592, 1, 0, 0, 0, 0, 0, 0, 0, 94951, 0, 0, 0, 0, 0, 0, 0, 22908),
(28000, 1, 0, 0, 0, 0, 0, 0, 0, 103337, 0, 0, 0, 0, 0, 0, 0, 22908),
(27999, 1, 0, 0, 0, 0, 0, 0, 0, 103328, 0, 0, 0, 0, 0, 0, 0, 22908),
(27770, 1, 0, 0, 0, 0, 0, 0, 0, 101650, 0, 0, 0, 0, 0, 0, 0, 22908),
(27954, 1, 0, 0, 0, 0, 0, 0, 0, 103080, 0, 0, 0, 0, 0, 0, 0, 22908),
(27998, 1, 0, 0, 0, 0, 0, 0, 0, 103324, 0, 0, 0, 0, 0, 0, 0, 22908),
(26813, 1, 0, 0, 0, 0, 0, 0, 0, 96144, 0, 0, 0, 0, 0, 0, 0, 22908),
(27773, 1, 0, 0, 0, 0, 0, 0, 0, 101661, 0, 0, 0, 0, 0, 0, 0, 22908),
(27768, 1, 0, 0, 0, 0, 0, 0, 0, 101647, 0, 0, 0, 0, 0, 0, 0, 22908),
(27772, 1, 0, 0, 0, 0, 0, 0, 0, 101660, 0, 0, 0, 0, 0, 0, 0, 22908),
(27545, 1, 0, 0, 0, 0, 0, 0, 0, 100342, 0, 0, 0, 0, 0, 0, 0, 22908),
(27283, 1, 0, 0, 0, 0, 0, 0, 0, 98960, 0, 0, 0, 0, 0, 0, 0, 22908),
(27471, 1, 0, 0, 0, 0, 0, 0, 0, 100024, 0, 0, 0, 0, 0, 0, 0, 22908),
(28886, 1, 0, 0, 0, 0, 0, 0, 0, 108864, 0, 0, 0, 0, 0, 0, 0, 22995),
(27771, 1, 0, 0, 0, 0, 0, 0, 0, 101654, 0, 0, 0, 0, 0, 0, 0, 22995),
(27206, 1, 0, 0, 0, 0, 0, 0, 0, 98578, 0, 0, 0, 0, 0, 0, 0, 22995),
(27769, 1, 0, 0, 0, 0, 0, 0, 0, 101649, 0, 0, 0, 0, 0, 0, 0, 22995);

-- Add some missing conversations
DELETE FROM `conversation_actors` WHERE (`ConversationId`=585 AND `ConversationActorId`=49935 AND `Idx`=0) OR (`ConversationId`=540 AND `Idx`=0) OR (`ConversationId`=581 AND `ConversationActorId`=49947 AND `Idx`=0) OR (`ConversationId`=486 AND `Idx`=1) OR (`ConversationId`=486 AND `Idx`=0) OR (`ConversationId`=570 AND `ConversationActorId`=49942 AND `Idx`=0) OR (`ConversationId`=747 AND `ConversationActorId`=49935 AND `Idx`=1) OR (`ConversationId`=747 AND `ConversationActorId`=49947 AND `Idx`=0) OR (`ConversationId`=705 AND `ConversationActorId`=50124 AND `Idx`=0) OR (`ConversationId`=922 AND `Idx`=2) OR (`ConversationId`=922 AND `Idx`=1) OR (`ConversationId`=922 AND `Idx`=0) OR (`ConversationId`=735 AND `Idx`=0) OR (`ConversationId`=567 AND `ConversationActorId`=49935 AND `Idx`=0) OR (`ConversationId`=576 AND `ConversationActorId`=49945 AND `Idx`=0) OR (`ConversationId`=574 AND `ConversationActorId`=49935 AND `Idx`=0) OR (`ConversationId`=736 AND `ConversationActorId`=50124 AND `Idx`=0) OR (`ConversationId`=569 AND `ConversationActorId`=47908 AND `Idx`=2) OR (`ConversationId`=569 AND `ConversationActorId`=49948 AND `Idx`=4) OR (`ConversationId`=569 AND `ConversationActorId`=49496 AND `Idx`=3) OR (`ConversationId`=569 AND `ConversationActorId`=49160 AND `Idx`=1) OR (`ConversationId`=569 AND `ConversationActorId`=49935 AND `Idx`=0) OR (`ConversationId`=558 AND `ConversationActorId`=49825 AND `Idx`=0) OR (`ConversationId`=531 AND `ConversationActorId`=49821 AND `Idx`=0) OR (`ConversationId`=555 AND `Idx`=0) OR (`ConversationId`=583 AND `ConversationActorId`=49825 AND `Idx`=0);
INSERT INTO `conversation_actors` (`ConversationId`, `ConversationActorId`, `Idx`, `VerifiedBuild`) VALUES
(585, 49935, 0, 25383),
(581, 49947, 0, 25383),
(570, 49942, 0, 25383),
(747, 49935, 1, 25383),
(747, 49947, 0, 25383),
(705, 50124, 0, 25383),
(567, 49935, 0, 25383),
(576, 49945, 0, 25383),
(574, 49935, 0, 25383),
(736, 50124, 0, 25383),
(569, 47908, 2, 25383),
(569, 49948, 4, 25383),
(569, 49496, 3, 25383),
(569, 49160, 1, 25383),
(569, 49935, 0, 25383),
(558, 49825, 0, 25383),
(531, 49821, 0, 25383),
(583, 49825, 0, 25383);

DELETE FROM `conversation_actor_template` WHERE `Id` IN (49935, 49947, 49942, 50124, 49945, 49948, 49496, 47908, 49160, 49825, 49821);
INSERT INTO `conversation_actor_template` (`Id`, `CreatureId`, `CreatureModelId`, `VerifiedBuild`) VALUES
(49935, 93802, 65935, 25383),
(49947, 93127, 61698, 25383),
(49942, 97676, 60790, 25383),
(50124, 98075, 21135, 25383),
(49945, 96655, 60079, 25383),
(49948, 97425, 64013, 25383),
(49496, 97676, 60790, 25383),
(47908, 93127, 61698, 25383),
(49160, 96420, 63986, 25383),
(49825, 93221, 65308, 25383),
(49821, 93759, 60791, 25383);


DELETE FROM `conversation_template` WHERE `Id` IN (540, 555, 567, 585, 570, 574, 576, 569, 486, 747, 531, 736, 735, 583, 581, 558, 922, 705);
INSERT INTO `conversation_template` (`Id`, `FirstLineID`, `LastLineEndTime`, `VerifiedBuild`) VALUES
(540, 1409, 10961, 25383),
(555, 1437, 10021, 25383),
(567, 1469, 3588, 25383),
(585, 1519, 3685, 25383),
(570, 1482, 9983, 25383),
(574, 1493, 4026, 25383),
(576, 1496, 4681, 25383),
(569, 1476, 59154, 25383),
(486, 1298, 8031, 25383),
(747, 1779, 19099, 25383),
(531, 1383, 3347, 25383),
(736, 1756, 30860, 25383),
(735, 1754, 9361, 25383),
(583, 1514, 7207, 25383),
(581, 1511, 5541, 25383),
(558, 1445, 7913, 25383),
(922, 2529, 15140, 25383),
(705, 1683, 13608, 25383);

-- Add some missing quest details
DELETE FROM `quest_details` WHERE `ID` IN (

38729 /*Return to the Black Temple*/, 
38728 /*The Keystone*/, 
39663 /*On Felbat Wings*/, 
39516 /*Cry Havoc and Let Slip the Illidari!*/, 
40051 /*Fel Secrets*/, 
40222 /*The Imp Mother's Tome*/, 
38725 /*Into the Foul Creche*/, 
38819 /*Their Numbers Are Legion*/, 
38727 /*Stop the Bombardment*/, 
39495 /*Hidden No More*/, 
39262 /*Give Me Sight Beyond Sight*/, 
38813 /*Orders for Your Captains*/, 
38766 /*Before We're Overrun*/, 
38765 /*Enter the Illidari: Shivarra*/, 
39050 /*Meeting With the Queen*/, 
39049 /*Eye On the Prize*/, 
38759 /*Set Them Free*/, 
40379 /*Enter the Illidari: Coilskar*/, 
40378 /*Enter the Illidari: Ashtongue*/, 
40077 /*The Invasion Begins*/

);

INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES
(38729, 5, 0, 0, 0, 0, 0, 0, 0, 25383), -- Return to the Black Temple
(38728, 396, 0, 0, 0, 0, 0, 0, 0, 25383), -- The Keystone
(39663, 1, 0, 0, 0, 0, 0, 0, 0, 25383), -- On Felbat Wings
(39516, 273, 0, 0, 0, 0, 0, 0, 0, 25383), -- Cry Havoc and Let Slip the Illidari!
(40051, 1, 0, 0, 0, 0, 0, 0, 0, 25383), -- Fel Secrets
(40222, 0, 0, 0, 0, 0, 0, 0, 0, 25383), -- The Imp Mother's Tome
(38725, 1, 0, 0, 0, 0, 0, 0, 0, 25383), -- Into the Foul Creche
(38819, 1, 25, 0, 0, 0, 0, 0, 0, 25383), -- Their Numbers Are Legion
(38727, 274, 0, 0, 0, 0, 0, 0, 0, 25383), -- Stop the Bombardment
(39495, 1, 25, 0, 0, 0, 0, 0, 0, 25383), -- Hidden No More
(39262, 6, 0, 0, 0, 0, 0, 0, 0, 25383), -- Give Me Sight Beyond Sight
(38813, 1, 0, 0, 0, 0, 0, 0, 0, 25383), -- Orders for Your Captains
(38766, 1, 0, 0, 0, 0, 0, 0, 0, 25383), -- Before We're Overrun
(38765, 0, 0, 0, 0, 0, 0, 0, 0, 25383), -- Enter the Illidari: Shivarra
(39050, 1, 0, 0, 0, 0, 0, 0, 0, 25383), -- Meeting With the Queen
(39049, 0, 0, 0, 0, 0, 0, 0, 0, 25383), -- Eye On the Prize
(38759, 0, 0, 0, 0, 0, 0, 0, 0, 25383), -- Set Them Free
(40379, 1, 0, 0, 0, 0, 0, 0, 0, 25383), -- Enter the Illidari: Coilskar
(40378, 0, 0, 0, 0, 0, 0, 0, 0, 25383), -- Enter the Illidari: Ashtongue
(40077, 0, 0, 0, 0, 0, 0, 0, 0, 25383); -- The Invasion Begins


-- NPC 97059 King Voras 
DELETE FROM `creature_loot_template` WHERE `entry`=97059;
INSERT INTO `creature_loot_template` (`Entry`,`Item`,`Reference`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(97059, 130264, 0, 47, 0, 1, 0, 1, 1, 'Fel-Stained Claw'),
(97059, 130265, 0, 38, 0, 1, 0, 1, 1, 'Sharpened Canine'),
(97059, 130266, 0, 18, 0, 1, 0, 1, 1, 'Trophy Spine'),
(97059, 128944, 0, 88, 0, 1, 0, 1, 1, 'Voras Silk Drape');
UPDATE `creature_template` SET `lootid`=97059 WHERE `Entry`=97059;

-- NPC 96493 Felguard Butcher
DELETE FROM `creature_loot_template` WHERE `entry`=96493;
INSERT INTO `creature_loot_template` (`Entry`,`Item`,`Reference`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(96493, 129196, 0, 4, 0, 1, 0, 1, 1, 'Legion Healthstone'),
(96493, 130267, 0, 92, 0, 1, 1, 1, 1, 'Extinguished Demon Stone'),
(96493, 130268, 0, 24, 0, 1, 2, 1, 1, 'Bone Toothpick'),
(96493, 130317, 0, 6, 0, 1, 3, 1, 1, 'Fractured Trophy');
UPDATE `creature_template` SET `lootid`=96493 WHERE `Entry`=96493;

-- NPC 97034 Fury Champion
DELETE FROM `creature_loot_template` WHERE `entry`=97034;
INSERT INTO `creature_loot_template` (`Entry`,`Item`,`Reference`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(97034, 129196, 0, 3, 0, 1, 0, 1, 1, 'Legion Healthstone'),
(97034, 130267, 0, 93, 0, 1, 1, 1, 1, 'Extinguished Demon Stone'),
(97034, 130268, 0, 23, 0, 1, 2, 1, 1, 'Bone Toothpick'),
(97034, 130317, 0, 6, 0, 1, 3, 1, 1, 'Fractured Trophy'),
(97034, 130264, 0, 0.8, 0, 1, 4, 1, 1, 'Fel-Stained Claw'),
(97034, 130265, 0, 0.3, 0, 1, 5, 1, 1, 'Sharpened Canine'),
(97034, 130266, 0, 0.14, 0, 1, 6, 1, 1, 'Trophy Spine');
UPDATE `creature_template` SET `lootid`=97034 WHERE `Entry`=97034;

-- NPC 97058 Count Nefarious
DELETE FROM `creature_loot_template` WHERE `entry`=97058;
INSERT INTO `creature_loot_template` (`Entry`,`Item`,`Reference`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(97058, 128948, 0, 84, 0, 1, 0, 1, 1, 'Nefarious Ring'),
(97058, 130267, 0, 46, 0, 1, 1, 1, 1, 'Extinguished Demon Stone'),
(97058, 130268, 0, 43, 0, 1, 2, 1, 1, 'Bone Toothpick'),
(97058, 130317, 0, 12, 0, 1, 3, 1, 1, 'Fractured Trophy'),
(97058, 130264, 0, 5, 0, 1, 4, 1, 1, 'Fel-Stained Claw'),
(97058, 130265, 0, 0.8, 0, 1, 5, 1, 1, 'Sharpened Canine');
UPDATE `creature_template` SET `lootid`=97058 WHERE `Entry`=97058;

-- NPC 97370 General Volroth
DELETE FROM `creature_loot_template` WHERE `entry`=97370;
INSERT INTO `creature_loot_template` (`Entry`,`Item`,`Reference`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(97370, 128947, 0, 89, 0, 1, 0, 1, 1, 'Pit Lords Cuffs'),
(97370, 130267, 0, 49, 0, 1, 1, 1, 1, 'Extinguished Demon Stone'),
(97370, 130268, 0, 44, 0, 1, 2, 1, 1, 'Bone Toothpick'),
(97370, 130317, 0, 10, 0, 1, 3, 1, 1, 'Fractured Trophy'),
(97370, 133313, 0, 8, 0, 1, 4, 1, 1, 'Pit Lords Cuffs');
UPDATE `creature_template` SET `lootid`=97370 WHERE `Entry`=97370;

-- NPC 97057 Overseer Brutarg
DELETE FROM `creature_loot_template` WHERE `entry`=97057;
INSERT INTO `creature_loot_template` (`Entry`,`Item`,`Reference`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(97057, 133580, 0, 95, 0, 1, 0, 1, 1, 'Brutargs Sword Tip'),
(97057, 130261, 0, 96, 0, 1, 0, 1, 1, 'Brutargs Sword'),
(97057, 130267, 0, 48, 0, 1, 1, 1, 1, 'Extinguished Demon Stone'),
(97057, 130268, 0, 39, 0, 1, 2, 1, 1, 'Bone Toothpick'),
(97057, 130317, 0, 15, 0, 1, 3, 1, 1, 'Fractured Trophy'),
(97057, 130264, 0, 0.7, 0, 1, 4, 1, 1, 'Fel-Stained Claw');
UPDATE `creature_template` SET `lootid`=97057 WHERE `Entry`=97057;


-- Object 244689 SmallTreasure Chest
DELETE FROM `gameobject_loot_template` WHERE `Entry`=244689;
INSERT INTO `gameobject_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES (244689, 129210, 0, 100, 0, 1, 0, 2, 3, 'Fel Crystal Fragments');
REPLACE INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `RequiredLevel`, `AIName`, `ScriptName`, `VerifiedBuild`) VALUES (244689, 3, 33263, 'Cofre de Tesoros Pequeño', '', 'Abriendo', '', 1, 57, 244689, 300, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 21400, 0, 0, 0, 110, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 62193, 0, 0, 98, '', '', 22566);

-- Object 244691 SmallTreasure Chest
DELETE FROM `gameobject_loot_template` WHERE `Entry`=244691;	
INSERT INTO `gameobject_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
VALUES (244691, 129192, 0, 100, 0, 1, 0, 1, 1, 'Inquisitor´s Menacing Eye');
REPLACE INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `RequiredLevel`, `AIName`, `ScriptName`, `VerifiedBuild`) VALUES (244691, 3, 33263, 'Small Treasure Chest', '', 'Opening', '', 1, 57, 244691, 300, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 21400, 0, 0, 0, 110, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 62194, 0, 0, 98, '', '', 22566);

-- Object 244692 SmallTreasure Chest
DELETE FROM `gameobject_loot_template` WHERE `Entry`=244692;	
INSERT INTO `gameobject_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) 
VALUES (244692, 129196, 0, 100, 0, 1, 0, 2, 4, 'Legion Heartstone');
REPLACE INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `RequiredLevel`, `AIName`, `ScriptName`, `VerifiedBuild`) VALUES (244692, 3, 33263, 'Small Treasure Chest', '', 'Opening', '', 1, 57, 244692, 300, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 21400, 0, 0, 0, 110, 3, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 62195, 0, 0, 98, '', '', 22566);

-- Object 244694 SmallTreasure Chest
DELETE FROM `gameobject_loot_template` WHERE `Entry`=244694;
INSERT INTO `gameobject_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) 
VALUES (244694, 128946, 0, 100, 0, 1, 0, 1, 1, 'Mardum Lord Signet');
REPLACE INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `RequiredLevel`, `AIName`, `ScriptName`, `VerifiedBuild`) VALUES (244694, 3, 33263, 'Small Treasure Chest', '', 'Opening', '', 1, 57, 244694, 300, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 21400, 0, 0, 0, 110, 3, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 62196, 0, 0, 98, '', '', 22566);

-- Object 244698 SmallTreasure Chest
DELETE FROM `gameobject_loot_template` WHERE `Entry`=244698;	
INSERT INTO `gameobject_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES 
(244698, 129210, 0, 99, 0, 1,  0, 2, 2, 'Fel Crystal Fragments'),
(244698, 129196, 0, 100, 0, 1, 1, 2, 3, 'Legion Heartstone');
REPLACE INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `RequiredLevel`, `AIName`, `ScriptName`, `VerifiedBuild`) VALUES (244698, 3, 33263, 'Small Treasure Chest', '', 'Opening', '', 1, 57, 244698, 300, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 21400, 0, 0, 0, 110, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 62197, 0, 0, 98, '', '', 22566);

-- Object 244699 SmallTreasure Chest
DELETE FROM `gameobject_loot_template` WHERE `Entry`=244699;
INSERT INTO `gameobject_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) 
VALUES (244699, 129195, 0, 100, 0, 1,  0, 1, 1, 'Vile Stalkerskin Pouch');
REPLACE INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `RequiredLevel`, `AIName`, `ScriptName`, `VerifiedBuild`) VALUES (244699, 3, 33263, 'Small Treasure Chest', '', 'Opening', '', 1, 57, 244699, 1800, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 21400, 0, 0, 0, 110, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 62198, 0, 0, 98, '', '', 22566);

-- Object 244700 SmallTreasure Chest
DELETE FROM `gameobject_loot_template` WHERE `Entry`=244700;	
INSERT INTO `gameobject_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) 
VALUES (244700, 129210, 0, 100, 0, 1, 0, 2, 3, 'Fel Crystal Fragments');
REPLACE INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `RequiredLevel`, `AIName`, `ScriptName`, `VerifiedBuild`) VALUES (244700, 3, 33263, 'Small Treasure Chest', '', 'Opening', '', 1, 57, 244700, 300, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 21400, 0, 0, 0, 110, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 62200, 0, 0, 98, '', '', 22566);

-- Object 244701 SmallTreasure Chest
DELETE FROM `gameobject_loot_template` WHERE `Entry`=244701;	
INSERT INTO `gameobject_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) 
VALUES (244701, 129196, 0, 100, 0, 1, 0, 2, 3, 'Legion Heartstone');
REPLACE INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `RequiredLevel`, `AIName`, `ScriptName`, `VerifiedBuild`) VALUES (244701, 3, 33263, 'Small Treasure Chest', '', 'Opening', '', 1, 57, 244701, 300, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 21400, 0, 0, 0, 110, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 62201, 0, 0, 98, '', '', 22566);

-- Object 245316 SmallTreasure Chest
DELETE FROM `gameobject_loot_template` WHERE `Entry`=245316;	
INSERT INTO `gameobject_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) 
VALUES (245316, 129210, 0, 100, 0, 1, 0, 1, 1, 'Fel Crystal Fragments'),
       (245316, 129196, 0, 100, 0, 1, 1, 1, 3, 'Legion Heartstone');
REPLACE INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `RequiredLevel`, `AIName`, `ScriptName`, `VerifiedBuild`) VALUES (245316, 3, 33263, 'Small Treasure Chest', '', 'Opening', '', 1, 57, 245316, 300, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 21400, 0, 0, 0, 110, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 62838, 0, 0, 98, '', '', 22566);

-- Object 245345 SmallTreasure Chest
DELETE FROM `gameobject_loot_template` WHERE `Entry`=245345;	
INSERT INTO `gameobject_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) 
VALUES (245345, 129210, 0, 100, 0, 1, 0, 1, 3, 'Fel Crystal Fragments'),
       (245345, 129196, 0, 100, 0, 1, 1, 1, 2, 'Legion Heartstone');
REPLACE INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `RequiredLevel`, `AIName`, `ScriptName`, `VerifiedBuild`) VALUES (245345, 3, 33263, 'Small Treasure Chest', '', 'Opening', '', 1, 57, 245345, 300, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 21400, 0, 0, 0, 110, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 62839, 0, 0, 98, '', '', 22566);

-- Object 245996 SmallTreasure Chest
DELETE FROM `gameobject_loot_template` WHERE `Entry`=245996;	
INSERT INTO `gameobject_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) 
VALUES (245996, 129210, 0, 100, 0, 1, 0, 1, 1, 'Fel Crystal Fragments'),
       (245996, 129196, 0, 100, 0, 1, 1, 2, 3, 'Legion Heartstone');
REPLACE INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `RequiredLevel`, `AIName`, `ScriptName`, `VerifiedBuild`) VALUES (245996, 3, 33263, 'Small Treasure Chest', '', 'Opening', '', 1, 57, 245996, 300, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 21400, 0, 0, 0, 110, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1800, 64014, 1, 0, 0, '', '', 22566);

-- Object 246147 SmallTreasure Chest
DELETE FROM `gameobject_loot_template` WHERE `Entry`=246147;	
INSERT INTO `gameobject_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) 
VALUES (246147, 129210, 0, 100, 0, 1, 0, 2, 3, 'Fel Crystal Fragments');
REPLACE INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `RequiredLevel`, `AIName`, `ScriptName`, `VerifiedBuild`) VALUES (246147, 3, 33263, 'Small Treasure Chest', '', 'Opening', '', 1, 57, 246147, 300, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 21400, 0, 0, 0, 110, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 64109, 0, 0, 98, '', '', 22566);

-- Object 246249 SmallTreasure Chest
DELETE FROM `gameobject_loot_template` WHERE `Entry`=246249;	
INSERT INTO `gameobject_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) 
VALUES (246249, 129196, 0, 100, 0, 1, 0, 1, 3, 'Legion Heartstone');
REPLACE INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `RequiredLevel`, `AIName`, `ScriptName`, `VerifiedBuild`) VALUES (246249, 3, 33263, 'Small Treasure Chest', '', 'Opening', '', 1, 57, 246249, 300, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 21400, 0, 0, 0, 110, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 64119, 0, 0, 98, '', '', 22566);

-- Object 246269 SmallTreasure Chest
DELETE FROM `gameobject_loot_template` WHERE `Entry`=246269;	
INSERT INTO `gameobject_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) 
VALUES (246269, 129210, 0, 99, 0, 1,  0, 2, 3, 'Fel Crystal Fragments'),
       (246269, 129196, 0, 100, 0, 1, 1, 2, 4, 'Legion Heartstone');
REPLACE INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `RequiredLevel`, `AIName`, `ScriptName`, `VerifiedBuild`) VALUES (246269, 3, 33263, 'Small Treasure Chest', '', 'Opening', '', 1, 57, 246269, 300, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 21400, 0, 0, 0, 110, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 64137, 0, 0, 98, '', '', 22566);

-- Object 246309 SmallTreasure Chest
DELETE FROM `gameobject_loot_template` WHERE `Entry`=246309;	
INSERT INTO `gameobject_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) 
VALUES (246309, 129210, 0, 100, 0, 1, 0, 1, 2, 'Fel Crystal Fragments'),
       (246309, 129196, 0, 100, 0, 1, 1, 1, 2, 'Legion Heartstone');
REPLACE INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `RequiredLevel`, `AIName`, `ScriptName`, `VerifiedBuild`) VALUES (246309, 3, 33263, 'Cofre de Tesoros Pequeño', '', 'Abriendo', '', 1, 57, 246309, 300, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 21400, 0, 0, 0, 110, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 64181, 0, 0, 98, '', '', 22566);

-- Object 246353 SmallTreasure Chest
DELETE FROM `gameobject_loot_template` WHERE `Entry`=246353;	
INSERT INTO `gameobject_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`,`GroupId`, `MinCount`, `MaxCount`, `Comment`) 
VALUES (246353, 129196, 0, 100, 0, 1, 0, 2, 3, 'Legion Heartstone');
REPLACE INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `RequiredLevel`, `AIName`, `ScriptName`, `VerifiedBuild`) VALUES (246353, 3, 33263, 'Cofre de Tesoros Pequeño', '', 'Abriendo', '', 1, 57, 246353, 300, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 21400, 0, 0, 0, 110, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 64180, 0, 0, 98, '', '', 22566);


-- Table `graveyard_zone`

DELETE FROM `graveyard_zone` WHERE `GhostZone` = 7334;
INSERT INTO `graveyard_zone` (`ID`, `GhostZone`, `Faction`, `Comment`) VALUES 
(4949, 7334, 0, '7.0 Azsuna - (01) Azurewing Repose'),
(4950, 7334, 0, '7.0 Azsuna - (02) Crumbled Palace'),
(4951, 7334, 0, '7.0 Azsuna - (03) Ruins of Narthalas'),
(4952, 7334, 0, '7.0 Azsuna - (04) Shipwreck Arena'),
(4953, 7334, 0, '7.0 Azsuna - (05) Oceanus Cove'),
(4954, 7334, 0, '7.0 Azsuna - (06) Illidari Stand'),
(4983, 7334, 0, '7.0 Azsuna - (07) Rhutvan Passage'),
(4984, 7334, 0, '7.0 Azsuna - (08) The Lost Orchard'),
(5010, 7334, 0, '7.0 Azsuna - (10) Makrana'),
(5011, 7334, 0, '7.0 Azsuna - (11) Eldranil Lagoon'),
(5012, 7334, 0, '7.0 Azsuna - (12) Hatecoil Warcamp'),
(5013, 7334, 0, '7.0 Azsuna - (13)  Farondale'),
(5014, 7334, 0, '7.0 Azsuna - (14) Llothien Woods'),
(5015, 7334, 0, '7.0 Azsuna - (15) Timeworn Strand North'),
(5613, 7334, 0, '7.0 Azsuna - (16) Isle of the Watchers Central'),
(5610, 7334, 0, '7.0 Azsuna - (17) Isle of the Watchers East'),
(5612, 7334, 0, '7.0 Azsuna - (18) Isle of the Watchers North'),
(5614, 7334, 0, '7.0 Azsuna - (19) Timeworn Strand South'),
(5621, 7334, 0, '7.0 Azsuna - (20) Illidari Perch'),
(5856, 7334, 0, '7.0 Azsuna - (21) Temple of a Thousand Lights'),
(5675, 7334, 0, '7.0 Azsuna - (22) Rhutvan Divide'),
(5745, 7334, 0, '7.0 Azsuna - (23) Eldranil Peak'),
(5780, 7334, 0, '7.0 Azsuna - (24) Seabreak Isle'),
(5782, 7334, 0, '7.0 Azsuna - (25) Eye of Azshara E'),
(5781, 7334, 0, '7.0 Azsuna - (26) Eye of Azshara W'),
(5652, 7334, 0, '7.0 Azsuna - (21) Timeworn Strand Underwater');