DELETE FROM `item_script_names` WHERE `Id` IN (74142);
INSERT INTO `item_script_names` (`Id`, `ScriptName`) VALUES
(74142, 'item_darkmoon_faire_fireworks');

UPDATE `creature_template` SET `ScriptName` = 'npc_darkmoon_faire_mystic_mage_alianza' WHERE `entry` IN (54334);
UPDATE `creature_template` SET `ScriptName` = 'npc_darkmoon_faire_mystic_mage_horda' WHERE `entry` IN (55382);
UPDATE `creature_template` SET `ScriptName` = 'npc_jessica_rogers' WHERE `entry` IN (54485);
UPDATE `creature_template` SET `ScriptName` = 'npc_selina_dourman' WHERE `entry` IN (10445);
UPDATE `creature_template` SET `ScriptName` = 'npc_rinling' WHERE `entry` IN (14841);
UPDATE `creature_template` SET `ScriptName` = 'npc_finlay_coolshot' WHERE `entry` IN (54605);
UPDATE `creature_template` SET `ScriptName` = 'npc_teleportologist_fozlebub' WHERE `entry` IN (57850);

DELETE FROM `spell_script_names` WHERE (`spell_id`) IN (102058, 101838, 101847, 102053, 101883, 101992, 108941, 101612, 43469);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(102058, 'spell_ring_toss'),
(101838, 'spell_gen_repair_damaged_tonk'),
(101847, 'spell_gen_shoe_baby'),
(102053, 'spell_cook_crunchy_frog'),
(101883, 'spell_heal_injuried_carnie'),
(101992, 'spell_put_up_darkmoon_banner'),
(108941, 'spell_darkmoon_deathmatch'),
(101612, 'spell_whack_a_gnoll_sap'),
(43469, 'spell_shoot_gallery_shoot');