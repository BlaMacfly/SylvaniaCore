-- A Hero's Weapon (one quest per class): the action button to raise the weapon before the class hall forge
-- was never given. LegionCore casts aura 219567 from EventObjects asking the quest; server areatriggers
-- at the same places (sphere of 2 yards), at_class_hall_hero_weapon asks the quest.
DELETE FROM `areatrigger` WHERE `ScriptName`='at_class_hall_hero_weapon';
INSERT INTO `areatrigger` (`id`, `map_id`, `spawn_mask`, `position_x`, `position_y`, `position_z`, `ScriptName`) VALUES
(100002, 1514, 1, 915.913, 3604.71, 197.328, 'at_class_hall_hero_weapon'),   -- 43359
(100002, 1513, 1, -846.561, 4661.83, 940.048, 'at_class_hall_hero_weapon'),  -- 43415, mage
(100002, 1519, 1, 1624.4, 1414.26, 208.741, 'at_class_hall_hero_weapon'),    -- 43412
(100002, 1220, 1, 4510.55, 5249.3, 862.132, 'at_class_hall_hero_weapon'),    -- 43423
(100002, 1107, 1, 3127.32, 1125.67, 286.662, 'at_class_hall_hero_weapon'),   -- 43414
(100002, 1479, 1, 1030.7, 7355.66, 107.313, 'at_class_hall_hero_weapon'),    -- 43425
(100002, 1220, 1, 3959.23, 7508.06, 52.9821, 'at_class_hall_hero_weapon'),   -- 43409
(100002, 0, 1, 2491.58, -5472.05, 48.917, 'at_class_hall_hero_weapon'),      -- 43424
(100002, 1469, 1, 1046.51, 1018.68, 20.2887, 'at_class_hall_hero_weapon'),   -- 43418
(100002, 1512, 1, 1423.98, 1344.24, 184.227, 'at_class_hall_hero_weapon'),   -- 43420
(100002, 1220, 1, -922.319, 4569.85, 704.967, 'at_class_hall_hero_weapon'),  -- 43422 / 43407
(100002, 1220, 1, -1532.93, 1009.81, 313.647, 'at_class_hall_hero_weapon');  -- 43422 / 43407
