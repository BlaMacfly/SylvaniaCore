-- quest 11664 escaping the mist

SELECT * FROM creature_template WHERE entry IN (25504);
SELECT * FROM creature_template_addon WHERE entry IN (25504);
SELECT * FROM creature WHERE id IN (25504);
SELECT * FROM creature_addon WHERE guid IN (SELECT guid FROM creature WHERE id IN (25504));
SELECT * FROM smart_scripts where entryorguid IN(25504);

/*
DELETE FROM `creature_addon` WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `id` IN (25504));
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES 
((SELECT `guid` FROM `creature` WHERE `id` IN (25504)), 0, 0, 7, 0, 0, NULL);
*/