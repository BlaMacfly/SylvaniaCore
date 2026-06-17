SET @HELYA := 96759;

UPDATE `creature_template` SET 
`ScriptName` = 'freakz_boss_helya_maw', 
`minLevel` = 112, 
`maxLevel` = 112, 
`faction` = 16,
`unit_class` = 4,
`unit_flags` = 32832,
`InhabitType` = 4,
`mechanic_immune_mask` = `mechanic_immune_mask` |617299967
WHERE `entry` IN (@HELYA);

UPDATE `creature_template` SET 
`ScriptName` = 'freakz_npc_mos_destructor_tentacle',
`minLevel` = 112, 
`maxLevel` = 112,
`faction` = 16,
`InhabitType` = 1
WHERE `entry` = 99801;

UPDATE `creature_template` SET 
`ScriptName` = 'freakz_npc_mos_grasping_tentacle',
`minLevel` = 112, 
`maxLevel` = 112,
`faction` = 16,
`unit_flags` = `unit_flags` |131072,
`flags_extra` = `flags_extra` |2,
`InhabitType` = 1
WHERE `entry` IN (100360, 100362, 98363);

UPDATE `creature_template` SET 
`ScriptName` = 'freakz_npc_mos_piercing_tentacle',
`minLevel` = 112, 
`maxLevel` = 112,
`faction` = 16,
`unit_flags` = 33554432,
`unit_flags2` = 4196352,
`flags_extra` = 0
WHERE `entry` = 100188;

UPDATE `creature_template` SET `VehicleId` = 4496 WHERE `entry` = 100361;
UPDATE `creature_template` SET `VehicleId` = 4495 WHERE `entry` = 100359;
UPDATE `creature_template` SET `VehicleId` = 4471 WHERE `entry` = 99803;
UPDATE `creature_template` SET `VehicleId` = 4470 WHERE `entry` = 99800;
UPDATE `gameobject_template` SET `data4` = 31853, `data10` = 31853 WHERE `entry` = 246919;

UPDATE `creature_model_info` SET `CombatReach` = 18 WHERE `DisplayId` = 66618;
UPDATE `creature_model_info` SET `CombatReach` = 22.5 WHERE `DisplayId` = 66619;
UPDATE `creature_model_info` SET `CombatReach` = 31.5 WHERE `DisplayId` = 65778;
UPDATE `creature_model_info` SET `CombatReach` = 33 WHERE `DisplayId` = 66238;

DELETE FROM `creature` WHERE `id` IN (100188, 99801, 100360, 100362, 98363) AND `map` = 1492;

UPDATE `creature_template` SET 
`minLevel` = 112, 
`maxLevel` = 112,
`faction` = 16,
`flags_extra` = `flags_extra` |128,
`ScriptName` = 'freakz_npc_mos_helya_dummy'
WHERE `entry` IN (100361, 100359, 99803, 99800, 102306, 97099);

UPDATE `creature` SET `spawnMask` = 8388870 WHERE `map` = 1492;
UPDATE `gameobject` SET `spawnMask` = 8388870 WHERE `map` = 1492;

DELETE FROM `creature` WHERE `id` = 59018 AND `map` = 1492;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `PhaseId`, `PhaseGroup`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
('1025620','59018','1492','0','0','8388608','0','0','0','0','2917.3','917.827','512.319','4.66261','300','0','0','22988','0','0','0','33554432','0','','0'),
('1025623','59018','1492','0','0','8388608','0','0','0','0','2933.7','914.794','512.383','4.6147','300','0','0','22988','0','0','0','33554432','0','','0'),
('1025619','59018','1492','0','0','8388608','0','0','0','0','2948.84','917.392','512.285','4.77727','300','0','0','22988','0','0','0','33554432','0','','0');

DELETE FROM `gameobject` WHERE `id` IN (246842, 246843, 246844, 246839, 246838, 246834, 246835, 246837, 246841) AND `map` = 1492;
INSERT INTO `gameobject` (`id`, `map`, `zoneId`, `areaId`, `spawnMask`, `PhaseId`, `PhaseGroup`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`) VALUES
('246844','1492','7812','7811','8388870','0','1','2948.42','921.305','511.89','3.14159','0','0','-1','0','7200','255','1','','23360'),
('246841','1492','7812','7811','8388870','0','1','2933.19','920.7','512.045','3.14159','0','0','-1','0','7200','255','1','','23360'),
('246840','1492','7812','7811','8388870','0','1','2939.47','928.678','511.501','3.14159','0','0','-1','0','7200','255','1','','23360'),
('246843','1492','7812','7811','8388870','0','1','2918.25','921.305','511.89','3.14159','0','0','-1','0','7200','255','1','','23360'),
('246842','1492','7812','7811','8388870','0','1','2927.26','928.678','511.501','3.14159','0','0','-1','0','7200','255','1','','23360'),
('246839','1492','7812','7811','8388870','0','1','2944.44','936.729','512.037','3.14159','0','0','-1','0','7200','255','1','','23360'),
('246838','1492','7812','7811','8388870','0','1','2933.33','940.862','511.86','3.14159','0','0','-1','0','7200','255','1','','23360'),
('246835','1492','7812','7811','8388870','0','1','2933.33','960.275','511.941','3.14159','0','0','-1','0','7200','255','1','','23360'),
('246837','1492','7812','7811','8388870','0','1','2939.92','952.155','512.001','3.14159','0','0','-1','0','7200','255','1','','23360'),
('246837','1492','7812','7811','8388870','0','1','2927.03','951.372','512.001','0','0','0','-1','0','7200','255','1','','23360'),
('246834','1492','7812','7811','8388870','0','1','2922.23','936.729','512.037','3.14159','0','0','-1','0','7200','255','1','','23360');

DELETE FROM `areatrigger_template` WHERE `id` IN (5070, 4048, 8856, 5179);
INSERT INTO `areatrigger_template` (`id`, `type`, `flags`, `Data0`, `Data1`, `Data2`,`Data3`, `Data4`, `Data5`, `ScriptName`) VALUES
(5070, 1, 0, 4.5, 4.5, 0.5, 4.5, 4.5, 0.5, 'freakz_at_mos_swirling_water'),
(4048, 1, 0, 0, 0, 0, 0, 0, 0, ''),
(8856, 0, 0, 1, 1, 0, 0, 0, 0, ''),
(5179, 0, 0, 0, 0, 0, 0, 0, 0, '');

DELETE FROM `areatrigger_template_polygon_vertices` WHERE `AreaTriggerId` = 4048;
INSERT INTO`areatrigger_template_polygon_vertices` (`AreaTriggerId`, `Idx`, `VerticeX`, `VerticeY`, `VerticeTargetX`, `VerticeTargetY`, `VerifiedBuild`) VALUES
(4048, 3, 200, 30, 0, 0, 23360),
(4048, 2, 200, -30, 0, 0, 23360),
(4048, 1, 0, -30, 0, 0, 23360),
(4048, 0, 0, 30, 0, 0, 23360);

DELETE FROM `spell_areatrigger` WHERE `SpellMiscId` IN (5070, 4048, 8856, 5179);
INSERT INTO `spell_areatrigger` (`SpellMiscId`, `AreaTriggerId`, `MoveCurveId`, `ScaleCurveId`, `MorphCurveId`, `FacingCurveId`, `DecalPropertiesId`, `TimeToTarget`, `TimeToTargetScale`, `VerifiedBuild`) VALUES
(5070, 5070, 0, 0, 0, 0, 0, 0, 0, 23420),
(8856, 8856, 0, 0, 0, 0, 0, 0, 0, 23420),
(4048, 4048, 0, 0, 0, 0, 0, 0, 1000, 23420),
(5179, 5179, 0, 0, 0, 0, 0, 0, 1000, 23420);

DELETE FROM `spell_script_names` WHERE `spell_id` IN (197262, 197753, 202088, 195231, 197734, 197653, 196534, 194839, 227233, 227234, 198520, 196947);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(197262, 'freakz_spell_helya_maw_taint_of_sea'),
(197753, 'freakz_spell_helya_maw_turbulent_waters'),
(202088, 'freakz_spell_helya_maw_brackwater_barrage'),
(195231, 'freakz_spell_helya_maw_emerge'),
(197734, 'freakz_spell_helya_maw_phase_two_model'),
(197653, 'freakz_spell_helya_maw_knockdown'),
(196534, 'freakz_spell_mos_smash'),
(194839, 'freakz_spell_mos_knockdown'),
(227233, 'freakz_spell_helya_maw_corrupted_bellow'),
(227234, 'freakz_spell_helya_maw_corrupted_bellow_dmg'),
(198520, 'freakz_spell_helya_maw_wing_buffet'),
(196947, 'freakz_spell_helya_maw_submerged');

DELETE FROM `creature_text` WHERE `entry` = @HELYA;
INSERT INTO `creature_text`(`entry`, `groupid`, `id`, `text`, `type`, `probability`, `sound`, `comment`) VALUES
(@HELYA, '0', '0', 'You ALL will regret trespassing in my realm.', '14', '100', '54387', 'HELYA - INTRO'),
(@HELYA, '1', '0', 'You have come far enough. Time to die.', '14', '100', '54371', 'HELYA - AGGRO'),
(@HELYA, '2', '0', 'Your fate rains down!', '14', '100', '54378', 'HELYA - TAIN_OF_SEA'),
(@HELYA, '2', '1', 'Embrace your fate, fools!', '14', '100', '54388', 'HELYA - TAIN_OF_SEA'),
(@HELYA, '3', '0', 'You will pay for that.', '14', '100', '54385', 'HELYA - TENTACLE DIE'),
(@HELYA, '3', '1', 'I am losing my patience.', '14', '100', '54386', 'HELYA - TENTACLE DIE'),
(@HELYA, '3', '2', 'No! This is not possible!', '14', '100', '54384', 'HELYA - TENTACLE DIE'),
(@HELYA, '3', '3', 'What manner of creatures ARE you??', '14', '100', '54382', 'TENTACLE DIE'),
(@HELYA, '3', '4', 'Odyn values these creatures?', '14', '100', '54377', 'HELYA - TENTACLE DIE'),
(@HELYA, '4', '0', 'An eternity of agony awaits you.', '14', '100', '54376', 'HELYA - CORRUPTED BELLOW'),
(@HELYA, '4', '1', 'I will drown you all like rats!', '14', '100', '54379', 'HELYA - CORRUPTED BELLOW'),
(@HELYA, '4', '2', 'Hold still!', '14', '100', '54376', 'HELYA - CORRUPTED BELLOW'),
(@HELYA, '4', '3', 'Stop squirming!', '14', '100', '54376', 'HELYA - CORRUPTED BELLOW'),
(@HELYA, '5', '0', 'Your soul will not find shelter here.', '14', '100', '54376', 'HELYA - KILL'),
(@HELYA, '5', '1', 'Begone to the next life.', '14', '100', '54376', 'HELYA - KILL'),
(@HELYA, '6', '0', 'It is finished. I banish your weak mortal souls forever more.', '14', '100', '54376', 'HELYA - WIPE'),
(@HELYA, '7', '0', 'Do you think you have won? You have merely survived the storm... The seas are unstoppable.', '14', '100', '54376', 'HELYA - DEATH'),
(@HELYA, '8', '0', '|TInterface\Icons\Spell_Frost_SummonWaterElemental_2.blp:20|t %s begins to cast |cFFFF0000|Hspell:202098|h[Brackwater Barrage]|h|r. Look out!', '41', '100', '0', 'HELYA - BRACKWATER BARRAGE'),
(@HELYA, '9', '0', '|TInterface\\Icons\\Spell_Shadow_Possession:20|t %s begins to cast |cFFFF0000|Hspell:227233|h[Corrupted Bellow]|h|r. Look out!', 41, 100, 54400, 'Helya');


