DELETE FROM `creature` WHERE `guid` = 318975 AND `id` = 51966;

UPDATE `creature` SET position_x = 1775.81, `position_y` = 2239.91, `position_z` = 150.5989, `orientation` = 6.277467 WHERE `guid` = 318976;
UPDATE `creature` SET position_x = 1786.41, `position_y` = 2224.48, `position_z` = 150.0046, `orientation` = 0.7584109 WHERE `guid` = 318977;
UPDATE `creature` SET position_x = 1786.3, `position_y` = 2256.17, `position_z` = 150.2935, `orientation` = 5.492332 WHERE `guid` = 318969;
UPDATE `creature` SET position_x = 1808.94, `position_y` = 2257.56, `position_z` = 149.792, `orientation` = 4.367029 WHERE `guid` = 318970;
UPDATE `creature` SET position_x = 1821.78, `position_y` = 2244.59, `position_z` = 149.917, `orientation` = 3.387632 WHERE `guid` = 318968;
UPDATE `creature` SET position_x = 1818.64, `position_y` = 2228.44, `position_z` = 149.8509, `orientation` = 2.529057 WHERE `guid` = 318979;
UPDATE `creature` SET position_x = 1804.69, `position_y` = 2218.8, `position_z` = 149.9511, `orientation` = 1.673273 WHERE `guid` = 318978;

UPDATE `creature_template` SET `AIName` = "SmartAI" WHERE `entry` IN (51963, 51966);

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (51966, 51963, -318976, -318977, -318969, -318970, -318968, -318979, -318978) AND `source_type` = 0;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (51966*100, 51963*100) AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(51966, 0, 0, 0, 1, 0, 100, 0, 10000, 10000, 4510000, 4510000, 80, 51966*100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Faerie Circle - OOC (Every 75 min) - Start Script"),

(-318976, 0, 0, 0, 60, 0, 100, 1, 1000, 1000, 0, 0, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Fey-Drunk Darter - On Update - Set Visiblity (0) (No Repeat)"),
(-318976, 0, 1, 0, 38, 0, 100, 0, 1, 1, 0, 0, 47, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Fey-Drunk Darter - On Data Set 1 1 - Set Visiblity (1)"),
(-318976, 0, 2, 0, 38, 0, 100, 0, 2, 2, 0, 0, 80, 51963*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Fey-Drunk Darter - On Data Set 2 2 - Start Script"),
(-318976, 0, 3, 0, 38, 0, 100, 0, 3, 3, 0, 0, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Fey-Drunk Darter - On Data Set 3 3 - Set Visiblity (0)"),

(-318977, 0, 0, 0, 60, 0, 100, 1, 1000, 1000, 0, 0, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Fey-Drunk Darter - On Update - Set Visiblity (0) (No Repeat)"),
(-318977, 0, 1, 0, 38, 0, 100, 0, 1, 1, 0, 0, 47, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Fey-Drunk Darter - On Data Set 1 1 - Set Visiblity (1)"),
(-318977, 0, 2, 0, 38, 0, 100, 0, 2, 2, 0, 0, 80, 51963*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Fey-Drunk Darter - On Data Set 2 2 - Start Script"),
(-318977, 0, 3, 0, 38, 0, 100, 0, 3, 3, 0, 0, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Fey-Drunk Darter - On Data Set 3 3 - Set Visiblity (0)"),

(-318969, 0, 0, 0, 60, 0, 100, 1, 1000, 1000, 0, 0, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Fey-Drunk Darter - On Update - Set Visiblity (0) (No Repeat)"),
(-318969, 0, 1, 0, 38, 0, 100, 0, 1, 1, 0, 0, 47, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Fey-Drunk Darter - On Data Set 1 1 - Set Visiblity (1)"),
(-318969, 0, 2, 0, 38, 0, 100, 0, 2, 2, 0, 0, 80, 51963*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Fey-Drunk Darter - On Data Set 2 2 - Start Script"),
(-318969, 0, 3, 0, 38, 0, 100, 0, 3, 3, 0, 0, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Fey-Drunk Darter - On Data Set 3 3 - Set Visiblity (0)"),

(-318970, 0, 0, 0, 60, 0, 100, 1, 1000, 1000, 0, 0, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Fey-Drunk Darter - On Update - Set Visiblity (0) (No Repeat)"),
(-318970, 0, 1, 0, 38, 0, 100, 0, 1, 1, 0, 0, 47, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Fey-Drunk Darter - On Data Set 1 1 - Set Visiblity (1)"),
(-318970, 0, 2, 0, 38, 0, 100, 0, 2, 2, 0, 0, 80, 51963*100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Fey-Drunk Darter - On Data Set 2 2 - Start Script"),
(-318970, 0, 3, 0, 38, 0, 100, 0, 3, 3, 0, 0, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Fey-Drunk Darter - On Data Set 3 3 - Set Visiblity (0)"),

(-318968, 0, 0, 0, 60, 0, 100, 1, 1000, 1000, 0, 0, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Fey-Drunk Darter - On Update - Set Visiblity (0) (No Repeat)"),
(-318968, 0, 1, 0, 38, 0, 100, 0, 1, 1, 0, 0, 47, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Fey-Drunk Darter - On Data Set 1 1 - Set Visiblity (1)"),
(-318968, 0, 2, 0, 38, 0, 100, 0, 2, 2, 0, 0, 80, 51963*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Fey-Drunk Darter - On Data Set 2 2 - Start Script"),
(-318968, 0, 3, 0, 38, 0, 100, 0, 3, 3, 0, 0, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Fey-Drunk Darter - On Data Set 3 3 - Set Visiblity (0)"),

(-318979, 0, 0, 0, 60, 0, 100, 1, 1000, 1000, 0, 0, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Fey-Drunk Darter - On Update - Set Visiblity (0) (No Repeat)"),
(-318979, 0, 1, 0, 38, 0, 100, 0, 1, 1, 0, 0, 47, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Fey-Drunk Darter - On Data Set 1 1 - Set Visiblity (1)"),
(-318979, 0, 2, 0, 38, 0, 100, 0, 2, 2, 0, 0, 80, 51963*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Fey-Drunk Darter - On Data Set 2 2 - Start Script"),
(-318979, 0, 3, 0, 38, 0, 100, 0, 3, 3, 0, 0, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Fey-Drunk Darter - On Data Set 3 3 - Set Visiblity (0)"),

(-318978, 0, 0, 0, 60, 0, 100, 1, 1000, 1000, 0, 0, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Fey-Drunk Darter - On Update - Set Visiblity (0) (No Repeat)"),
(-318978, 0, 1, 0, 38, 0, 100, 0, 1, 1, 0, 0, 47, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Fey-Drunk Darter - On Data Set 1 1 - Set Visiblity (1)"),
(-318978, 0, 2, 0, 38, 0, 100, 0, 2, 2, 0, 0, 80, 51963*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Fey-Drunk Darter - On Data Set 2 2 - Start Script"),
(-318978, 0, 3, 0, 38, 0, 100, 0, 3, 3, 0, 0, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Fey-Drunk Darter - On Data Set 3 3 - Set Visiblity (0)"),

(51966*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 318977, 51963, 0, 0, 0, 0, 0, "Faerie Circle - On Script - Set Data 1 1 (Creature GUID: 318977) (0)"),
(51966*100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 318979, 51963, 0, 0, 0, 0, 0, "Faerie Circle - On Script - Set Data 1 1 (Creature GUID: 318979) (0)"),
(51966*100, 9, 2, 0, 0, 0, 100, 0, 360000, 360000, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 318969, 51963, 0, 0, 0, 0, 0, "Faerie Circle - On Script - Set Data 1 1 (Creature GUID: 318969) (6 min)"),
(51966*100, 9, 3, 0, 0, 0, 100, 0, 900000, 900000, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 318968, 51963, 0, 0, 0, 0, 0, "Faerie Circle - On Script - Set Data 1 1 (Creature GUID: 318968) (15 min)"),
(51966*100, 9, 4, 0, 0, 0, 100, 0, 480000, 480000, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 318978, 51963, 0, 0, 0, 0, 0, "Faerie Circle - On Script - Set Data 1 1 (Creature GUID: 318978) (8 min)"),
(51966*100, 9, 5, 0, 0, 0, 100, 0, 120000, 120000, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 318976, 51963, 0, 0, 0, 0, 0, "Faerie Circle - On Script - Set Data 1 1 (Creature GUID: 318976) (2 min)"),
(51966*100, 9, 6, 0, 0, 0, 100, 0, 960000, 960000, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 318970, 51963, 0, 0, 0, 0, 0, "Faerie Circle - On Script - Set Data 1 1 (Creature GUID: 318970) (16 min)"),
(51966*100, 9, 7, 0, 0, 0, 100, 0, 1440000, 1440000, 0, 0, 45, 2, 2, 0, 0, 0, 0, 19, 51963, 30, 0, 0, 0, 0, 0, "Faerie Circle - On Script - Set Data 2 2 (Creature ID: 51963, 30 Yards) (24 min)"),
(51966*100, 9, 8, 0, 0, 0, 100, 0, 500, 500, 0, 0, 11, 96181, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Faerie Circle - On Script - Cast Spell (500 ms)"),
(51966*100, 9, 9, 0, 0, 0, 100, 0, 500, 500, 0, 0, 11, 96186, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Faerie Circle - On Script - Cast Spell (500 ms)"),
(51966*100, 9, 10, 0, 0, 0, 100, 0, 138000, 138000, 0, 0, 45, 3, 3, 0, 0, 0, 0, 19, 51963, 30, 0, 0, 0, 0, 0, "Faerie Circle - On Script - Set Data 3 3 (Creature ID: 51963, 30 Yards) (2.3 min)"),

(51963*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 96187, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Fey-Drunk Darter - On Script - Cast Spell"),
(51963*100, 9, 1, 0, 0, 0, 100, 0, 500, 500, 0, 0, 11, 96184, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Fey-Drunk Darter - On Script - Cast Spell");
-- (51963*100, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 96184, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Fey-Drunk Darter - On Script - Cast Spell");

UPDATE `creature_template` SET `flags_extra` = 128, `scale` = 3 WHERE `entry` = 51966;
