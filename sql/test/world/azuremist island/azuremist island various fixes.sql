-- azuremist bloodelf scout 16521 npc flag 0

UPDATE `creature_template` SET `npcflag`='0' WHERE  `entry`=16521;
UPDATE `creature_template` SET `npcflag`='0' WHERE  `entry`=16522;

-- azuremist  fishing trainer missign template_addon
DELETE FROM `creature_template_addon` WHERE `entry`=17101;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `auras`) VALUES 
(17101, 0, 0, 0, 257, 0, 0, 0, 0, '');

-- remove extra quest-starter
DELETE FROM `creature_queststarter` WHERE `id`=17553 AND `quest`=9603;
DELETE FROM `creature_queststarter` WHERE `id`=43991 AND `quest`=9603;

-- wrong spawned creatures 17379 stillpine-ancestor-akida
DELETE FROM `creature` WHERE `id` IN (17379);

-- Totem of Akida - Quest accepted - Cast Spell on player

DELETE FROM `smart_scripts` WHERE `entryorguid`=17360 AND `id`=0 AND `source_type`=0 LIMIT 1;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(17360,0,0,0,19,0,100,0,9539,0,0,0,85,30437,0,0,0,0,0,7,0,0,0,0.0,0.0,0.0,0.0,"Totem of Akida - Quest accepted - Cast Spell on player");
