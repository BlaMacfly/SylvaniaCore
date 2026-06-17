-- fix - wrong queststrarters in gilneas
DELETE FROM `creature_queststarter` WHERE `id`=35118 AND `quest`=24930;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (35118, 24930);
