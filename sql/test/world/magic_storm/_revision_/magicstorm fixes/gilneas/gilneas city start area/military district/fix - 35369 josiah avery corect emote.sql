-- fix - corect emotes 35369 josiah avery
DELETE FROM `creature_addon` WHERE `guid`=20556546;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `auras`) 
VALUES (20556546, 0, 0, 65536, 1, 431, 0, 0, 0, 'null');
