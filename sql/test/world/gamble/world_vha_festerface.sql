SET @FESTERFACE := 101995;

UPDATE `creature_template` SET 
`ScriptName` = 'freakz_boss_festerface', 
`minLevel` = 107, 
`maxLevel` = 112, 
`faction` = 16,
`unit_class` = 4,
`unit_flags` = 34880,
`mechanic_immune_mask` = `mechanic_immune_mask` |617299967
WHERE `entry` IN (@FESTERFACE);

UPDATE `creature_template` SET
`ScriptName` = 'freakz_npc_vha_congealing_goo',
`minLevel` = 105,
`maxLevel` = 111,
`faction`  = 16,
`unit_flags` = 32768,
`unit_flags2` = 2097152
WHERE `entry` = 102158;

UPDATE `creature_template` SET
`minLevel` = 111,
`maxLevel` = 111,
`faction`  = 16,
`unit_flags` = `unit_flags` |131072
WHERE `entry` = 102169;

DELETE FROM `spell_script_names` WHERE `spell_id` IN (201598, 201495);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(201598, 'freakz_spell_festerface_congealing_vomit'),
(201495, 'freakz_spell_vha_recongealing');

DELETE FROM `instance_template` WHERE `map` = 1544;
INSERT INTO `instance_template` (`map`, `parent`, `script`, `allowMount`) VALUES (1544, 0, 'freakz_instance_violet_hold_assault', 1);

DELETE FROM `areatrigger_template` WHERE `id` = 5765;
INSERT INTO `areatrigger_template` (`id`, `type`, `flags`, `Data0`, `Data1`, `Data2`,`Data3`, `Data4`, `Data5`, `ScriptName`, `VerifiedBuild`) VALUES
(5765, 0, 6, 6, 6, 0, 0, 0, 0, 'freakz_at_vha_icky_goo', 23360);

DELETE FROM `spell_areatrigger` WHERE `SpellMiscId` = 5765;
INSERT INTO `spell_areatrigger` (`SpellMiscId`, `AreaTriggerId`, `MoveCurveId`, `ScaleCurveId`, `MorphCurveId`, `FacingCurveId`, `DecalPropertiesId`, `TimeToTarget`, `TimeToTargetScale`, `VerifiedBuild`) VALUES
(5765, 5765, 0, 1707, 0, 0, 0, 0, 12000, 23360);

UPDATE `creature` SET `spawnMask` = 8388614 WHERE `map` = 1544;
UPDATE `gameobject` SET `spawnMask` = 8388614 WHERE `map` = 1544;

DELETE FROM `creature_text` WHERE `entry` IN (@FESTERFACE, 102158);
INSERT INTO `creature_text`(`entry`, `groupid`, `id`, `text`, `type`, `probability`, `sound`, `comment`) VALUES
(@FESTERFACE, '0', '0', 'Uuuugh, you pick bad time to interrupt! My. Tummy. No. Good!', '14', '100', '54387', 'FESTERFACE - AGGRO'),
(@FESTERFACE, '0', '1', 'No! You killed daddy! Now, we kill you!', '14', '100', '54371', 'FESTERFACE - AGGRO'),
(@FESTERFACE, '1', '0', 'Better look out... blegh!', '14', '100', '54378', 'FESTERFACE - CONGEALING VOMIT'),
(@FESTERFACE, '1', '1', 'Gonna lost it!', '14', '100', '54388', 'FESTERFACE - CONGEALING VOMIT'),
(@FESTERFACE, '1', '2', 'Me not feel so good!', '14', '100', '54385', 'FESTERFACE - CONGEALING VOMIT'),
(@FESTERFACE, '2', '0', 'Mmm! So good!', '14', '100', '54386', 'FESTERFACE - YUM'),
(@FESTERFACE, '2', '1', 'Yummy!', '14', '100', '54384', 'FESTERFACE - YUM'),
(@FESTERFACE, '3', '0', 'Too much stinky for you!', '14', '100', '54382', 'KILL'),
(@FESTERFACE, '3', '1', 'This one broken!', '14', '100', '54377', 'FESTERFACE - KILL'),
(@FESTERFACE, '3', '2', 'Did you get a owie?', '14', '100', '54376', 'FESTERFACE - KILL'),
(@FESTERFACE, '3', '3', 'Taste better going in!', '14', '100', '54379', 'FESTERFACE - KILL'),
(@FESTERFACE, '4', '0', 'At least... tummy... feel better...', '14', '100', '54376', 'FESTERFACE - DEATH'),
(@FESTERFACE, '5', '0', '|TInterface\Icons\Ability_Creature_Poison_06:20|t Festerface begins to wretch a |cFFFF0404|Hspell:201598|h[Congealing Vomit]|h|r!', 41, 100, 54400, 'FESTERFACE'),
(102158, '0', '0', '|TInterface\\Icons\\INV_Misc_Slime_01:20|t A Congealing Goo was able to finish |cFFFF0404|Hspell:201495|h[Recongealing]|h|r!', 41, 100, 54400, 'CONGEALING_GOO');


