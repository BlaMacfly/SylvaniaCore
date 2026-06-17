-- Muddled prophet of sseratus texts 28151
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE  `entry`=28151;

DELETE FROM `creature_text` WHERE `CreatureID`=28151;
INSERT INTO `creature_text` 
(`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES 
(28151, 0, 0, 'NOOOOOOOOooooooo.........!', 14, 0, 100, 0, 0, 0, 27532, 0, 'Muddled prophet of sseratus -  text 1');
DELETE FROM `smart_scripts` WHERE `entryorguid`=28151 AND `source_type`=0 AND `id`=0 AND `link`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(28151, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, '', 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, ' Muddled Prophet of Sseratus - On Just spawned - Say Line 0');



