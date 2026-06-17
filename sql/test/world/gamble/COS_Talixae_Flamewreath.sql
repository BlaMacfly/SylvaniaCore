SET @TALIXAE := 104217;

UPDATE `creature_template` SET 
`ScriptName` = 'boss_talixae_flamewreath', 
`minLevel` = 112, 
`maxLevel` = 112, 
`faction` = 16,
`unit_class` = 4,
`unit_flags2` = `unit_flags2` |2048,
`mechanic_immune_mask` = `mechanic_immune_mask` |617299967
WHERE `entry` IN (@TALIXAE, 10421701, 10421702);

UPDATE `creature_template` SET 
`ScriptName` = 'npc_cots_infernal_imp',
`minLevel` = 100, 
`maxLevel` = 110, 
`faction` = 14,
`InhabitType` = 1
WHERE `entry` IN (112668, 11266801, 11266802);

UPDATE `creature_template` SET 
`ScriptName` = 'npc_cots_talixae_minion',
`minLevel` = 100, 
`maxLevel` = 110, 
`faction` = 14,
`InhabitType` = 1
WHERE `entry` IN (104274, 10427401, 10427402, 104273, 10427301, 10427302, 104275, 10427501, 10427502);

DELETE FROM `spell_script_names` WHERE `spell_id` IN (208165, 207881, 207887, 207906, 224375, 224376);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(208165, 'spell_talixae_whitering_soul'),
(207881, 'spell_talixae_infernal_eruption'),
(207887, 'spell_talixae_infernal_eruption_dmg'),
(224376, 'spell_cots_drifting_embers_dmg');

-- Burning Intensity
DELETE FROM `spell_dbc_override` WHERE spell = 207906;
INSERT INTO `spell_dbc_override` VALUES (207906, 24, 0, 20, 0, '', 5);
INSERT INTO `spell_dbc_override` VALUES (207906, 40, 0, 0, 0, '', 5);

-- Infernal Eruption
DELETE FROM `spell_dbc_override` WHERE spell = 207881;
INSERT INTO `spell_dbc_override` VALUES (207881, 40, 0, 0, 0, '', 5);

-- Withering Soul
DELETE FROM `spell_dbc_override` WHERE spell = 208165;
INSERT INTO `spell_dbc_override` VALUES (208165, 40, 0, 0, 0, '', 5);

DELETE FROM `areatrigger_template` WHERE `id` = 6881;
INSERT INTO `areatrigger_template` (`id`, `type`, `flags`, `Data0`, `Data1`, `Data2`, `ScriptName`) VALUES
(6881, 0, 4, 3, 3, 0, 'at_cots_infernal_eruption');


DELETE FROM `spell_areatrigger` WHERE `SpellMiscId` = 6881;
INSERT INTO `spell_areatrigger` (`SpellMiscId`, `AreaTriggerId`, `MoveCurveId`, `ScaleCurveId`, `MorphCurveId`, `FacingCurveId`, `DecalPropertiesId`, `TimeToTarget`, `TimeToTargetScale`, `VerifiedBuild`) VALUES
(6881, 6881, 0, 0, 0, 0, 0, 0, 0, 23420);

DELETE FROM `instance_template` WHERE `map` = 1571;
INSERT INTO `instance_template` (`map`, `parent`, `script`, `allowMount`) VALUES (1571, 0, 'instance_court_of_stars', 0);

DELETE FROM `creature_text` WHERE `entry` = @TALIXAE;
INSERT INTO `creature_text`(`entry`, `groupid`, `id`, `text`, `type`, `probability`, `sound`, `comment`) VALUES
(@TALIXAE, '0', '0', 'Make yourself useful and take a look around!', '14', '100', '58644', 'TALIXAE - EVENT_1'),
(@TALIXAE, '1', '0', 'What are you waiting for? Check out that noise!', '14', '100', '58645', 'TALIXAE - EVENT_2'),
(@TALIXAE, '2', '0', 'You! Have a look over there!', '14', '100', '58646', 'TALIXAE - EVENT_3'),
(@TALIXAE, '3', '0', 'Who needs henchmen? I\'ll burn you myself!', '14', '100', '58639', 'TALIXAE - AGGRO'),
(@TALIXAE, '4', '1', 'Not very clever of you to challenge all of us!', '14', '100', '58638', 'TALIXAE - AGGRO_TEAM'),
(@TALIXAE, '5', '0', 'Mortal flesh... so pretty when it burns!', '14', '100', '58640', 'TALIXAE - BURNING_INTESITY'),
(@TALIXAE, '5', '1', 'It will amuse me to watch you melt!', '14', '100', '58642', 'TALIXAE - BURNING_INTESITY_2'),
(@TALIXAE, '5', '2', 'Scorched bones... so delightful!', '14', '100', '58647', 'TALIXAE - BURNING_INTESITY_3'),
(@TALIXAE, '6', '0', 'More kindling for the bonfire!', '14', '100', '58648', 'TALIXAE - KILL_1'),
(@TALIXAE, '6', '1', 'I\'m feeling positively radiant!', '14', '100', '58641', 'TALIXAE - KILL_2'),
(@TALIXAE, '7', '0', 'Looks like I have a roast to prepare!', '14', '100', '58649', 'TALIXAE - WIPE'),
(@TALIXAE, '8', '0', 'My funeral pyre... will be... glorious...', '14', '100', '58643', 'TALIXAE - DEATH');
