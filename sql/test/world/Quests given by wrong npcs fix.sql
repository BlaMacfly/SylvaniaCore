-- NPC - quests given by wrong npc fix
DELETE FROM `creature_queststarter` WHERE `id`=1416 AND `quest`=1097;
DELETE FROM `creature_queststarter` WHERE `id`=16144 AND `quest`=9067;
DELETE FROM `creature_queststarter` WHERE `id`=16187 AND `quest`=9130;
DELETE FROM `creature_queststarter` WHERE `id`=44036 AND `quest`=9130;