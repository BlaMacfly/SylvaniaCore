SET @MELANDRUS := 104218;

UPDATE `creature_template` SET 
`ScriptName` = 'boss_advisor_melandrus', 
`minLevel` = 112, 
`maxLevel` = 112, 
`faction` = 16,
`unit_class` = 4,
`unit_flags2` = `unit_flags2` |2048,
`mechanic_immune_mask` = `mechanic_immune_mask` |617299967
WHERE `entry` IN (@MELANDRUS, 10421801, 10421802);

UPDATE `creature_template` SET 
`ScriptName` = 'npc_cots_image_of_melandrus',
`minLevel` = 112, 
`maxLevel` = 112,
`unit_flags` = `unit_flags` |2|33554432,
`faction` = 14,
`InhabitType` = 1
WHERE `entry` IN (105754, 10575401, 10575402);

UPDATE `creature_template` SET 
`ScriptName` = 'npc_cots_enveloping_wind',
`minLevel` = 112, 
`maxLevel` = 112,
`flags_extra` = `flags_extra` |128,
`faction` = 14,
`InhabitType` = 1
WHERE `entry` IN (112687, 11268701, 11268702);

UPDATE `creature_template` SET 
`ScriptName` = '',
`minLevel` = 112, 
`maxLevel` = 112,
`unit_flags` = `unit_flags` &~256,
`faction` = 14,
`InhabitType` = 8,
`flags_extra` = `flags_extra` |128
WHERE `entry` IN (105765, 10576501, 10576502);

DELETE FROM `creature` WHERE `id` = 105765;

DELETE FROM `spell_script_names` WHERE `spell_id` IN (209676, 209741, 224327, 209667, 209628, 209630);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(224327, 'spell_melandrus_enveloping_winds'),
(209667, 'spell_melandrus_blade_surge'),
(209628, 'spell_melandrus_piercing_gale'),
(209630, 'spell_melandrus_piercing_gale');

DELETE FROM `areatrigger_template` WHERE `id` = 8425;
INSERT INTO `areatrigger_template` (`id`, `type`, `flags`, `Data0`, `Data1`, `Data2`, `ScriptName`) VALUES
(8425, 0, 0, 2, 2, 0, '');


DELETE FROM `spell_areatrigger` WHERE `SpellMiscId` = 8425;
INSERT INTO `spell_areatrigger` (`SpellMiscId`, `AreaTriggerId`, `MoveCurveId`, `ScaleCurveId`, `MorphCurveId`, `FacingCurveId`, `DecalPropertiesId`, `TimeToTarget`, `TimeToTargetScale`, `VerifiedBuild`) VALUES
(8425, 8425, 0, 0, 0, 0, 0, 0, 0, 23420);


DELETE FROM `creature_text` WHERE `entry` = @MELANDRUS;
INSERT INTO `creature_text`(`entry`, `groupid`, `id`, `text`, `type`, `probability`, `sound`, `comment`) VALUES
(@MELANDRUS, '0', '0', 'Must you leave so soon, Grand Magistrix?', '14', '100', '67729', 'MELANDRUS - EVENT_1'),
(@MELANDRUS, '1', '0', 'Impossible! My guards would never permit such an intrusion!', '14', '100', '67728', 'MELANDRUS - EVENT_2'),
(@MELANDRUS, '2', '0', 'I assure you, Grand Magistrix, the situation is being addressed. It will be a simple matter to track down a few random dissidents and--', '14', '100', '67726', 'MELANDRUS - EVENT_3'),
(@MELANDRUS, '3', '0', 'I... I\'m not sure what you\'re getting at, Grand Magistrix.', '14', '100', '67727', 'MELANDRUS - EVENT_4'),
(@MELANDRUS, '4', '1', 'Finally. I\'ll make this quick!', '14', '100', '58650', 'MELANDRUS - AGGRO'),
(@MELANDRUS, '5', '0', 'Death by a thousand cuts!', '14', '100', '58656', 'MELANDRUS - SLICING_MAELSTROM'),
(@MELANDRUS, '5', '1', 'You can\'t counter what you can\'t see!', '14', '100', '58652', 'MELANDRUS - SLICING_MAELSTROM'),
(@MELANDRUS, '5', '2', 'Bleed for the Grand Magistrix!', '14', '100', '58657', 'MELANDRUS -SLICING_MAELSTROM'),
(@MELANDRUS, '6', '0', 'I will speed you towards your demise!', '14', '100', '58653', 'MELANDRUS - BLADE_SURGE'),
(@MELANDRUS, '6', '1', 'The wind slices to the bone!', '14', '100', '58655', 'MELANDRUS - BLADE_SURGE'),
(@MELANDRUS, '6', '2', 'If you blink... you bleed!', '14', '100', '58654', 'MELANDRUS - BLADE_SURGE'),
(@MELANDRUS, '7', '0', 'Another victim of my artistry!', '14', '100', '58659', 'MELANDRUS - KILL'),
(@MELANDRUS, '7', '1', 'Never heard my blade coming!', '14', '100', '58660', 'MELANDRUS - KILL'),
(@MELANDRUS, '7', '2', 'Let your names be forgotten!', '14', '100', '58661', 'MELANDRUS - KILL'),
(@MELANDRUS, '8', '0', 'How dare you interrupt your betters!', '14', '100', '58651', 'MELANDRUS - WIPE'),
(@MELANDRUS, '9', '0', 'Elisande... forgive me!', '14', '100', '58658', 'MELANDRUS - DEATH');
