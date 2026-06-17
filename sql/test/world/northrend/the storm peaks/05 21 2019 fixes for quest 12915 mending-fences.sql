-- fixes for quest 12915 mending-fences
/*
SELECT * FROM creature_template WHERE entry IN (29375, 29503);
SELECT * FROM creature_template_addon WHERE entry IN (29375, 29503);
SELECT * FROM creature WHERE id IN (29375, 29503);
SELECT * FROM creature_addon WHERE guid IN (SELECT guid FROM creature WHERE id IN (30121, 29503));
SELECT * FROM smart_scripts WHERE entryorguid IN (29375, 29503);
SELECT * FROM waypoint_data WHERE id IN (883080, 1045650);
SELECT * FROM conditions where sourceentry IN (55818);
SELECT * FROM creature_model_info WHERE displayid IN (27092, 28013);
*/
UPDATE `creature_template` SET `unit_flags`='131072' WHERE  `entry`=30121;

DELETE FROM `creature_addon` WHERE `guid`=88308;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES 
(104565, 1045650, 0, 0, 1, 0, '');

DELETE FROM `waypoint_data` WHERE `id`=883080;
DELETE FROM `waypoint_data` WHERE `id`=1045650;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES 
(1045650, 1, 7174.86, -3647.9, 828.423, 0, 0, 0, 0, 100, 0),
(1045650, 2, 7190.95, -3657.83, 823.731, 0, 0, 0, 0, 100, 0),
(1045650, 3, 7203.09, -3661.86, 823.814, 0, 0, 0, 0, 100, 0),
(1045650, 4, 7217.11, -3659.16, 823.213, 2.02458, 24000, 0, 0, 100, 0),
(1045650, 5, 7178.15, -3646.86, 826.076, 0, 0, 0, 0, 100, 0),
(1045650, 6, 7166.44, -3625.11, 830.974, 0, 0, 0, 0, 100, 0),
(1045650, 7, 7166.76, -3600.56, 830.737, 0, 35000, 0, 0, 100, 0);


DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=17 AND `SourceEntry`=55818;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES 
(17, 0, 55818, 0, 1, 31, 1, 3, 29375, 0, 0, 0, 0, '', NULL),
(17, 0, 55818, 0, 2, 31, 1, 3, 29503, 0, 0, 0, 0, '', NULL);
