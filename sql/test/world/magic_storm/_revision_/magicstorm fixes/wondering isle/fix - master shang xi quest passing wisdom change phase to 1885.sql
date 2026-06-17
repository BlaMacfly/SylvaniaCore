DELETE FROM `smart_scripts` WHERE `entryorguid`=55672 AND `source_type`=0 AND `id`=1 AND `link`=3;
DELETE FROM `smart_scripts` WHERE `entryorguid`=55672 AND `source_type`=0 AND `id`=1 AND `link`=2;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) 
VALUES (55672, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, '', 44, 1885, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Master Shang - On Accepted Quest - Add Phase');

