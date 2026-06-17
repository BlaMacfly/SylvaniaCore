SET @MILLIFICENT := 101976;

UPDATE `creature_template` SET 
`ScriptName` = 'freakz_boss_millificent_manastorm', 
`minLevel` = 107, 
`maxLevel` = 112, 
`faction` = 16,
`unit_class` = 4,
`mechanic_immune_mask` = `mechanic_immune_mask` |617299967
WHERE `entry` IN (@MILLIFICENT);

UPDATE `creature_template` SET
`ScriptName` = 'freakz_npc_vha_rocket_chicken',
`minLevel` = 105,
`maxLevel` = 111,
`faction`  = 16
WHERE `entry` IN (102103, 102139);

-- Rocket Chicken Rocket
DELETE FROM freakz_spell_dbc_override WHERE spell = 201369;
INSERT INTO freakz_spell_dbc_override VALUES (201369, 3, 0, 104, 0, 'TARGET_UNIT_CONE_ENEMY_104', 698272);
INSERT INTO freakz_spell_dbc_override VALUES (201369, 3, 2, 104, 0, 'TARGET_UNIT_CONE_ENEMY_104', 698272);

UPDATE `creature_template` SET
`ScriptName` = 'freakz_npc_vha_squirrel_bomb',
`minLevel` = 111,
`maxLevel` = 111,
`faction`  = 7,
`InhabitType` = 8,
`npcflag` = `npcflag` |16777216,
`type_flags` = `type_flags` |1048576|16,
`unit_flags` = `unit_flags` |2|256
WHERE `entry` IN (102043, 102136);

UPDATE `creature_template` SET
`ScriptName` = 'freakz_npc_vha_mechanical_squirrel_bomb',
`minLevel` = 106,
`maxLevel` = 110,
`unit_flags` = `unit_flags`|2,
`faction` = 16
WHERE `entry` = 102137;

DELETE FROM `npc_spellclick_spells` WHERE `npc_entry` = 102043;
INSERT INTO `npc_spellclick_spells` (`npc_entry`, `spell_id`, `cast_flags`, `user_type`) VALUES
(102043, 201265, 1, 0);

DELETE FROM `spell_script_names` WHERE `spell_id` IN (201385, 201386, 201369);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(201385, 'freakz_spell_vha_swarn_rockets'),
(201386, 'freakz_spell_vha_swarn_rockets'),
(201369, 'freakz_spell_vha_rocket_chicken_rocket');


DELETE FROM `creature_text` WHERE `entry` IN (@MILLIFICENT);
INSERT INTO `creature_text`(`entry`, `groupid`, `id`, `text`, `type`, `probability`, `sound`, `comment`) VALUES
(@MILLIFICENT, '0', '0', 'Finally free from that cursed mage trap! Such a-', '14', '100', '54387', 'FESTERFACE - AGGRO'),
(@MILLIFICENT, '1', '0', 'Wait, I recognize that voice...', '14', '100', '54371', 'FESTERFACE - AGGRO'),
(@MILLIFICENT, '2', '0', 'MILLHOUSE!! You\'re next!', '14', '100', '54378', 'FESTERFACE - CONGEALING VOMIT'),
(@MILLIFICENT, '3', '1', 'Are you ready to EXPLODE?', '14', '100', '54388', 'FESTERFACE - CONGEALING VOMIT'),
(@MILLIFICENT, '4', '0', 'Here comes the heat!', '14', '100', '54386', 'FESTERFACE - YUM'),
(@MILLIFICENT, '5', '1', 'Why you... No one insults my hair! NO ONE!', '14', '100', '54384', 'FESTERFACE - YUM'),
(@MILLIFICENT, '6', '0', 'I know it was you, Millhouse!', '14', '100', '54382', 'KILL'),
(@MILLIFICENT, '7', '1', 'There\'s no place you can hide from me, Millhouse! No place!', '14', '100', '54377', 'FESTERFACE - KILL'),
(@MILLIFICENT, '8', '2', 'Don\'t "Milly" me, Millhouse Jerimus Manastorm! I\'m coming for you!', '14', '100', '54376', 'FESTERFACE - KILL');


