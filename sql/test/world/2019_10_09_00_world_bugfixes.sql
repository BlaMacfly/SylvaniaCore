-- Postponing the Inevitable (Quest ID: 27420)
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` = 84973;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES 
(13, 1, 84973, 0, 0, 31, 0, 3, 45475, 0, 0, 0, 0, "", "Spell Threat targets Disseminator");

UPDATE `creature_template` SET `AIName` = "SmartAI", `ScriptName` = "" WHERE `entry` = 45475; -- Disseminator

DELETE FROM `smart_scripts` WHERE `entryorguid` = 45475 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(45475, 0, 0, 0, 8, 0, 100, 0, 84973, 0, 5000, 5000, 86, 84972, 0, 7, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Disseminator - On Spellhit - Cross Cast Overcharge Effect'),
(45475, 0, 1, 0, 8, 0, 100, 0, 84972, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Disseminator - On Spellhit - Die');

-- Amidst Death, Life (Quest ID: 27421)
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` = 84964;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES 
(13, 1, 84964, 0, 0, 31, 0, 3, 45486, 0, 0, 0, 0, "", "Spell Threat targets southeastern ziggurat"),
(13, 1, 84964, 0, 1, 31, 0, 3, 45487, 0, 0, 0, 0, "", "Spell Threat targets northeastern ziggurat"),
(13, 1, 84964, 0, 2, 31, 0, 3, 45488, 0, 0, 0, 0, "", "Spell Threat targets western ziggurat");

UPDATE `creature_template` SET `AIName` = "SmartAI", `ScriptName` = "" WHERE `entry` IN (45486, 45487, 45488); -- Ziggurat

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (45486, 45487, 45488) AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(45486, 0, 0, 1, 8, 0, 100, 0, 84964, 0, 10000, 10000, 11, 84961, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Ziggurat - On Spellhit - Cast Amidst Death, Life: Flower Aura"),
(45486, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 33, 45486, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Ziggurat - On Link - Killcredit"),
(45487, 0, 0, 1, 8, 0, 100, 0, 84964, 0, 10000, 10000, 11, 84961, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Ziggurat - On Spellhit - Cast Amidst Death, Life: Flower Aura"),
(45487, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 33, 45487, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Ziggurat - On Link - Killcredit"),
(45488, 0, 0, 1, 8, 0, 100, 0, 84964, 0, 10000, 10000, 11, 84961, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Ziggurat - On Spellhit - Cast Amidst Death, Life: Flower Aura"),
(45488, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 33, 45488, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Ziggurat - On Link - Killcredit");
