SET @BETRUG := 102446;

UPDATE `creature_template` SET 
`ScriptName` = 'freakz_boss_fel_lord_betrug', 
`minLevel` = 107, 
`maxLevel` = 112, 
`faction` = 16,
`unit_class` = 4,
`mechanic_immune_mask` = `mechanic_immune_mask` |617299967
WHERE `entry` IN (@BETRUG);

UPDATE `creature_template` SET 
`ScriptName` = 'freakz_npc_vha_stasis_crystal',
`unit_flags` = 0,
`unit_flags2`= 0,
`npcflag` = `npcflag` |16777216,
`faction` = 14
WHERE `entry` = 103672;

DELETE FROM `spell_script_names` WHERE `spell_id` IN (203622, 202328, 202339, 202340, 202343, 202364, 210879);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(203622, 'freakz_spell_betrug_chaotic_energy'),
(202328, 'freakz_spell_betrug_mighty_slash'),
(202339, 'freakz_spell_betrug_mighty_slash_jump'),
(202340, 'freakz_spell_betrug_mighty_slash_jump'),
(202343, 'freakz_spell_betrug_mighty_slash_jump'),
(202364, 'freakz_spell_betrug_execution'),
(210879, 'freakz_spell_betrug_seed_of_destruction');

DELETE FROM `areatrigger_template` WHERE `id` IN (6104, 6838);
INSERT INTO `areatrigger_template` (`id`, `type`, `flags`, `Data0`, `Data1`, `Data2`,`Data3`, `Data4`, `Data5`, `ScriptName`, `VerifiedBuild`) VALUES
(6104, 0, 0, 3, 3, 0, 0, 0, 0, '', 22566),
(6838, 3, 0, 0, 0, 0, 0, 0, 0, 'freakz_at_vha_wake_of_destruction', 24015);

DELETE FROM `areatrigger_template_polygon_vertices` WHERE `AreaTriggerId` = 6838;
INSERT IGNORE INTO `areatrigger_template_polygon_vertices` (`AreaTriggerId`, `Idx`, `VerticeX`, `VerticeY`, `VerticeTargetX`, `VerticeTargetY`, `VerifiedBuild`) VALUES
(6838, 3, 0.75, 3, 0, 0, 24015),
(6838, 2, 0.75, -3, 0, 0, 24015),
(6838, 1, -0.75, -3, 0, 0, 24015),
(6838, 0, -0.75, 3, 0, 0, 24015);

DELETE FROM `spell_areatrigger` WHERE `SpellMiscId` IN (6104, 6838);
INSERT INTO `spell_areatrigger` (`SpellMiscId`, `AreaTriggerId`, `MoveCurveId`, `ScaleCurveId`, `MorphCurveId`, `FacingCurveId`, `DecalPropertiesId`, `TimeToTarget`, `TimeToTargetScale`, `VerifiedBuild`) VALUES
(6104, 6104, 0, 0, 0, 0, 0, 0, 20000, 22566),
(6838, 6838, 0, 0, 0, 0, 0, 12534, 30000, 24015);

DELETE FROM `creature_text` WHERE `entry` = (@BETRUG);
INSERT INTO `creature_text`(`entry`, `groupid`, `id`, `text`, `type`, `probability`, `sound`, `comment`) VALUES
(@BETRUG, '0', '0', 'Even the best laid plans don''t survive contact with the enemy.', 14, 100, 57579, 'FEL LORD - AGGRO'),
(@BETRUG, '1', '1', 'Such insolence! We will make your death terrible, and your suffering long.', 14, 100, 57579, 'Fel Lord Betrug'),
(@BETRUG, '2', '0', 'Our hatred knows no bounds!', 14, 100, 57582, 'Fel Lord Betrug to Player'),
(@BETRUG, '3', '0', 'A death most deserved.', 14, 100, 57582, 'Fel Lord Betrug to Player'),
(@BETRUG, '3', '1', 'Your souls will fuel our engines!', 14, 100, 57582, 'Fel Lord Betrug to Player'),
(@BETRUG, '3', '2', 'Pathetic worm.', 14, 100, 57582, 'Fel Lord Betrug to Player'),
(@BETRUG, '3', '3', 'Another soul harvested.', 14, 100, 57582, 'Fel Lord Betrug to Player'),
(@BETRUG, '4', '0', '|TInterface\\Icons\\INV_Sword_48:20|tFree $n from their bonds before they are |cFFFF0000|Hspell:202361|h[Executed!]|h|r', 41, 100, 57582, 'Fel Lord Betrug to Player'),
(@BETRUG, '5', '0', 'We will unleash a scourge upon this citadel never before known to your kind!', 14, 100, 57586,'Fel Lord Betrug to Player'),
(@BETRUG, '6', '0', 'My lord... I have... failed you...', 14, 100, 57586,'Fel Lord Betrug to Player');


