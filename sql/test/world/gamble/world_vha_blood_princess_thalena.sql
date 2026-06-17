SET @THALENA := 102431;

UPDATE `creature_template` SET 
`ScriptName` = 'freakz_boss_blood_princess_thalena', 
`minLevel` = 107, 
`maxLevel` = 112, 
`faction` = 16,
`unit_class` = 4,
`mechanic_immune_mask` = `mechanic_immune_mask` |617299967
WHERE `entry` IN (@THALENA);

UPDATE `creature_template` SET
`ScriptName` = 'freakz_npc_vha_congealing_blood',
`minLevel` = 105,
`maxLevel` = 111,
`speed_run` = 0.6,
`faction`  = 16
WHERE `entry` = 102941;

UPDATE `creature_template` SET `flags_extra` = `flags_extra` |128 WHERE `entry` = 102659;

DELETE FROM `spell_script_names` WHERE `spell_id` IN (202659, 202792, 202676, 203381, 203033, 203035, 202805);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(202659, 'freakz_spell_thalena_blood_swarn'),
(203381, 'freakz_spell_thalena_blood_call'),
(202792, 'freakz_spell_thalena_frenzied_bloodthirst'),
(203033, 'freakz_spell_thalena_shroud_of_sorrow'),
(203035, 'freakz_spell_thalena_shroud_of_sorrow_dmg'),
(202805, 'freakz_spell_thalena_vampiric_kiss_player'),
(202676, 'freakz_spell_thalena_vampiric_kiss');

DELETE FROM `spell_linked_spell` WHERE `spell_trigger`  IN (203405, 202779);
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
(203405, 203452, 0, 'Blood Call Summon - Blood Princess Thalena'),
(202779, 202781, 2, 'Essence of Blood Princess - Blood Princess Thalena');

DELETE FROM `areatrigger_template` WHERE `id` = 5876;
INSERT INTO `areatrigger_template` (`id`, `type`, `flags`, `Data0`, `Data1`, `Data2`,`Data3`, `Data4`, `Data5`, `ScriptName`, `VerifiedBuild`) VALUES
(5876, 0, 6, 2, 2, 0, 0, 0, 0, 'freakz_at_vha_blood_swarn', 23360);

DELETE FROM `spell_areatrigger` WHERE `SpellMiscId` = 5876;
INSERT INTO `spell_areatrigger` (`SpellMiscId`, `AreaTriggerId`, `MoveCurveId`, `ScaleCurveId`, `MorphCurveId`, `FacingCurveId`, `DecalPropertiesId`, `TimeToTarget`, `TimeToTargetScale`, `VerifiedBuild`) VALUES
(5876, 5876, 0, 0, 0, 0, 0, 0, 30000, 23360);

DELETE FROM `creature_text` WHERE `entry` = (@THALENA);
INSERT INTO `creature_text`(`entry`, `groupid`, `id`, `text`, `type`, `probability`, `sound`, `comment`) VALUES
(@THALENA, '0', '0', 'Some of you will be food, some will be thralls, but all of you will die.', '12', '100', '54387', 'THALENA - AGGRO'),
(@THALENA, '1', '1', 'Submit to the thirst.', '12', '100', '54371', 'THALENA - VAMPIRIC_KISS'),
(@THALENA, '2', '0', 'Now your will is mine!', '12', '100', '54378', 'THALENA - UNCONTROLLABLE_FRENZY'),
(@THALENA, '3', '1', 'None can resist my thirst!', '12', '100', '54388', 'THALENA - KILL'),
(@THALENA, '4', '2', 'The hunger never ends...', '12', '100', '54385', 'THALENA - DEATH');


