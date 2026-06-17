SET @ANUBESSET := 102246;

UPDATE `creature_template` SET 
`ScriptName` = 'boss_anubesset', 
`minLevel` = 106, 
`maxLevel` = 112, 
`faction` = 16,
`unit_class` = 1,
`unit_flags` = `unit_flags` |64,
`unit_flags` = `unit_flags` |2099200
WHERE `entry` = @ANUBESSET;

UPDATE `creature_template` SET 
`ScriptName` = 'npc_vha_spitting_scarab',
`minLevel` = 106, 
`maxLevel` = 111, 
`faction` = 16,
`InhabitType` = 8
WHERE `entry` = 102271;

UPDATE `creature_template` SET 
`ScriptName` = 'npc_vha_blistering_bettle',
`minLevel` = 111, 
`maxLevel` = 111, 
`faction` = 16 
WHERE `entry` = 102540;

DELETE FROM `spell_script_names` WHERE `spell_id` IN (202341, 201863, 202526);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES 
(202341, 'spell_anubesset_impale'),
(202526, 'spell_freakz_anubesset_summon_blistering_ooze'),
(201863, 'spell_freakz_anubesset_call_of_swarm');

DELETE FROM `areatrigger_template` WHERE `id` IN (5829, 5832);
INSERT INTO `areatrigger_template` (`id`, `type`, `flags`, `Data0`, `Data1`, `Data2`, `ScriptName`) VALUES
(5829, 0, 0, 5, 5, 0, ''),
(5832, 0, 0, 5, 5, 0, 'at_freakz_blistering_ooze');


DELETE FROM `spell_areatrigger` WHERE `SpellMiscId` IN (5829, 5832);
INSERT INTO `spell_areatrigger` (`SpellMiscId`, `AreaTriggerId`, `MoveCurveId`, `ScaleCurveId`, `MorphCurveId`, `FacingCurveId`, `DecalPropertiesId`, `TimeToTarget`, `TimeToTargetScale`, `VerifiedBuild`) VALUES
(5829, 5829, 0, 0, 0, 0, 0, 0, 15000, 23420),
(5832, 5832, 0, 0, 0, 0, 0, 0, 0, 23420);


DELETE FROM `creature_text` WHERE `entry` = @ANUBESSET;
INSERT INTO `creature_text`(`entry`, `groupid`, `id`, `text`, `type`, `probability`, `sound`, `comment`) VALUES
(@ANUBESSET, '1', '0', 'Finally free... and you will NOT imprison me again.', '14', '100', '57810', 'ANUBESSET - AGRRO'),
(@ANUBESSET, '2', '0', 'Your strength means NOTHING!', '14', '100', '57822', 'ANUBESSET - MANDIBLE_STRIKE'),
(@ANUBESSET, '2', '1', 'I\'ll crush your bones to POWDER!', '14', '100', '57823', 'ANUBESSET - MANDIBLE_STRIKE_1'),
(@ANUBESSET, '2', '2', 'Bleed, and die, vermin.', '14', '100', '57817', 'ANUBESSET - MANDIBLE_STRIKE_2'),
(@ANUBESSET, '3', '0', 'Only scraps will remain!', '14', '100', '57816', 'ANUBESSET - IMPALE'),
(@ANUBESSET, '4', '0', 'Consume their flesh!', '14', '100', '57812', 'ANUBESSET - CALL_OF_SWARN'),
(@ANUBESSET, '4', '1', 'A feast for my brethren...', '14', '100', '57813', 'ANUBESSET - CALL_OF_SWARN_2'),
(@ANUBESSET, '5', '0', 'You should have died in Northrend!', '14', '100', '57818', 'ANUBESSET - KILL'),
(@ANUBESSET, '5', '1', 'Did you expect me to be an simple obstacle, fools?', '14', '100', '57821', 'ANUBESSET - KILL_2'),
(@ANUBESSET, '5', '2', 'Another one crushed between my pincers.', '14', '100', '57819', 'ANUBESSET - KILL_3'),
(@ANUBESSET, '6', '0', 'Too easy an end. How disappointing.', '14', '100', '57820', 'ANUBESSET - WIPE'),
(@ANUBESSET, '7', '0', 'I cannot hear the Lich King... Has he abandoned me...?', '14', '100', '57814', 'ANUBESSET - DEATH'),
(@ANUBESSET, '7', '1', 'But it is MY destiny to rule Azjol-Nerub...', '14', '100', '57815', 'ANUBESSET - DEATH_2');


DELETE FROM `creature_template` WHERE `entry` = 999850;
INSERT INTO `creature_template` (`entry`, `modelid1`, `modelid2`, `name`, `femaleName`, `minlevel`, `maxlevel`, `faction`, `scale`, `flags_extra`, `ScriptName`) VALUES (999850, 1126, 11686, 'Impale Dummy', '', 112, 112, 16, 1 ,128, 'npc_freakz_vha_impale_dummy');