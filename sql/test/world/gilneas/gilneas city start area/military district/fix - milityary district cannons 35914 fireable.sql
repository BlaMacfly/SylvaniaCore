-- fix - milityary district cannons 35914 fireable

DELETE FROM `npc_spellclick_spells` WHERE `npc_entry`=35914 AND `spell_id`=43671;
INSERT INTO `npc_spellclick_spells` (`npc_entry`, `spell_id`, `cast_flags`, `user_type`) 
VALUES (35914, 43671, 0, 0);

DELETE FROM `creature_template_addon` WHERE `entry`=35914;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `auras`) 
VALUES (35914, 0, 0, 0, 1, 0, 0, 0, 0, '');



