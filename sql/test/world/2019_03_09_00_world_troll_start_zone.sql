//Territory_Fetish
DELETE FROM `creature_template_addon` WHERE  `entry`=38560;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (13,17) AND `sourceEntry` IN (72070);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `sourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES 
(13, 4, 72070, 0, 0, 31, 1, 3, 38300, 0, 0, 0, 0, '', 'SPELL_IMPLICIT_TARGET OBJECT_ENTRY'),
(13, 4, 72070, 0, 0, 31, 0, 3, 38301, 0, 0, 0, 0, '', 'SPELL_IMPLICIT_TARGET OBJECT_ENTRY'),
(13, 1, 72070, 0, 0, 31, 0, 3, 38560, 0, 0, 0, 0, '', 'SPELL_IMPLICIT_TARGET OBJECT_ENTRY'),
(13, 1, 72070, 0, 0, 1, 0, 72072, 0, 0, 1, 0, 0, '', 'SPELL_IMPLICIT_TARGET AURA'),
(17, 0, 72070, 0, 0, 29, 0, 38560, 4, 0, 0, 0, 0, '', 'SPELL OBJECT_ENTRY');

UPDATE `creature_template` SET `npcflag`=0, `AIName`='SmartAI', `flags_extra`=128 WHERE `entry`=38560;
UPDATE `creature_template` SET `npcflag`=0  WHERE `entry` IN (38301,38300);
DELETE FROM `creature_queststarter` WHERE `id` IN (38560,38300,38301);

DELETE FROM `smart_scripts` WHERE `entryorguid`=38560;
DELETE FROM `smart_scripts` WHERE `entryorguid`=3856000;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(38560, 0, 0, 1, 8, 0, 100, 0, 72070, 0, 0, 0, '', 11, 72072, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spitescale Flag Bunny - On Spellhit \'Place Territorial Fetish\' - Cast \'Territorial Fetish\''),
(38560, 0, 1, 0, 61, 0, 100, 0, 72070, 0, 0, 0, '', 80, 3856000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spitescale Flag Bunny - On Spellhit \'Place Territorial Fetish\' - Run Script'),
(3856000, 9, 0, 0, 0, 0, 100, 0, 60000, 60000, 0, 0, '', 28, 72072, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spitescale Flag Bunny - On Script - Remove Aura \'Territorial Fetish\'');


UPDATE `creature_template` SET `unit_flags`='0' WHERE  `entry`=38038;
UPDATE `creature_template` SET `InhabitType`='8' WHERE  `entry`=38038;

