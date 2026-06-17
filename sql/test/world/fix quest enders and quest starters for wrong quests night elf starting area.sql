-- fix - remove quest starters for wrong quest 6344
DELETE FROM `creature_queststarter` WHERE `id`=4241 AND `quest`=6344;
DELETE FROM `creature_queststarter` WHERE `id`=40553 AND `quest`=6344;
-- fix - remove quest enders for wrong quest 6344
DELETE FROM `creature_questender` WHERE `id`=10118 AND `quest`=6344;
-- fix - remove quest starters for wrong quest 6341
DELETE FROM `creature_queststarter` WHERE `id`=10118 AND `quest`=6341;
-- fix - remove quest enders for wrong quest 6341
DELETE FROM `creature_questender` WHERE `id`=3838 AND `quest`=6341;
-- fix - remove quest starters for wrong quest 6342
DELETE FROM `creature_queststarter` WHERE `id`=3838 AND `quest`=6342;
DELETE FROM `creature_queststarter` WHERE `id`=40552 AND `quest`=6342;
-- fix - remove quest enders for wrong quest 6342
DELETE FROM `creature_questender` WHERE `id`=4200 AND `quest`=6342;
-- fix - remove quest starters for wrong quest 6343
DELETE FROM `creature_queststarter` WHERE `id`=4200 AND `quest`=6343;
DELETE FROM `creature_queststarter` WHERE `id`=4265 AND `quest`=6343;
-- fix -remove quest enders for wrong quest 6343
DELETE FROM `creature_questender` WHERE `id`=10118 AND `quest`=6343;
