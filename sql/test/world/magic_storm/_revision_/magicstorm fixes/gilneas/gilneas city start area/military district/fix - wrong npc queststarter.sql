-- fix - wrong queststarters in gilneas military district
DELETE FROM `creature_queststarter` WHERE `id`=35118 AND `quest`=24930;

