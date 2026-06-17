DELETE FROM `spell_script_names` WHERE `spell_id` IN (206150);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(206150, 'spell_challengers_might');

DELETE FROM `spell_script_names` WHERE `spell_id` IN (209859);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(209859, 'spell_challengers_bolster');

DELETE FROM `spell_script_names` WHERE `spell_id` IN (209859);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(209859, 'spell_challengers_bolster');

DELETE FROM `spell_script_names` WHERE `spell_id` IN (240443);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(240443, 'spell_challengers_burst');

DELETE FROM `spell_script_names` WHERE `spell_id` IN (226512);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(226512, 'spell_challenge_sanguine_ichor');


UPDATE `creature_template` SET `minlevel`=98, `maxlevel`=120, `unit_flags`=33554432, `ScriptName`='npc_volcanic_plume_105877' WHERE `entry`=105877;
UPDATE `creature_template_scaling` SET `LevelScalingMin`=98, `LevelScalingMax`=110 WHERE `entry`=105877;

UPDATE `creature_template` SET `ScriptName`='npc_challenger_fel_explosives' WHERE `entry`=120651;

DELETE FROM `spell_areatrigger` WHERE (`AreaTriggerId`=12765) ;
INSERT INTO `spell_areatrigger` (`SpellMiscId`, `AreaTriggerId`, `MoveCurveId`, `ScaleCurveId`, `MorphCurveId`, `FacingCurveId`, `DecalPropertiesId`, `TimeToTarget`, `TimeToTargetScale`, `VerifiedBuild`) VALUES
(8688, 12765, 0, 2234, 0, 0, 0, 0, 60000, 26365); -- SpellId : 226489

DELETE FROM `areatrigger_template` WHERE (`Id`=12765) ;
INSERT INTO `areatrigger_template` (`Id`, `Type`, `Flags`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `ScriptName`, `VerifiedBuild`) VALUES 
(12765, 4, 2, 1, 1, 3, 3, 0.3, 0.3, 'at_challenge_sanguine_ichor', 26124);