-- Kharanos : Tognus Flintfire (1241) et Kogan Forgestone (1245) travaillent a la forge (Titans 095ae1f, adapte a nos GUID, entree verifiee)
DELETE FROM `creature_addon` WHERE `guid` IN (167406, 167407);
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`)
SELECT `guid`, 0, 0, 0, 257, 233, '' FROM `creature` WHERE (`guid`, `id`) IN ((167406, 1245), (167407, 1241));
