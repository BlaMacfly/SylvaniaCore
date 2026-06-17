-- searches
SELECT * FROM creature_template WHERE entry IN (24849, 24083, 24082);
SELECT * FROM creature_template_addon WHERE entry IN (24849, 24083, 24082);
SELECT * FROM creature WHERE id IN (24849, 24083, 24083);
SELECT * FROM creature_addon WHERE guid IN (SELECT guid FROM creature WHERE id IN (24849, 24083, 24082));
SELECT * FROM smart_scripts WHERE entryorguid IN (24849, 24083, 24083);
-- utgarde keep fixes magicstorm_legion

-- missig addons and waypoints for prince Prince Keleseth 23953
DELETE FROM `creature_template_addon` WHERE `entry`=23953;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES 
(23953, 0, 0, 0, 0, 0, NULL);

DELETE FROM `creature_addon` WHERE `guid`=1168900;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES 
(116890, 1168900, 0, 0, 1, 5, '');

DELETE FROM `waypoint_data` WHERE `id`=1168900;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES 
(1168900, 1, 188.578, 217.181, 40.8161, 0, 0, 0, 0, 100, 0),
(1168900, 2, 189.28, 217.307, 40.8161, 0, 5000, 0, 0, 100, 0),
(1168900, 3, 189.676, 207.039, 40.8161, 0, 0, 0, 0, 100, 0),
(1168900, 4, 196.131, 196.306, 40.8161, 0, 0, 0, 0, 100, 0),
(1168900, 5, 196.648, 196.778, 40.8161, 0, 5000, 0, 0, 100, 0);

-- update for rider 24849
UPDATE `creature_template_addon` SET `mount`='0' WHERE  `entry`=24849;-- ex mount - 22657

