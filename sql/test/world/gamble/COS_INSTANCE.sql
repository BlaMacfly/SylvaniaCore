UPDATE `creature_template` SET
`ScriptName` = 'npc_cos_nightborne_boat',
`faction` = 190,
`unit_flags` = 33587264,
`unit_flags2` = 2048,
`VehicleId` = 4711,
`InhabitType` = 5,
`speed_run` = 4,
`speed_walk` = 4
WHERE `entry` = 105264;

UPDATE `creature_template` SET
`ScriptName` = 'npc_cos_signal_lantern',
`npcflag` = 1,
`type_flags` = `type_flags` |1048576|16,
`unit_flags` = 256,
`unit_flags2` = 69240832,
`minLevel` = 110, 
`maxLevel` = 110,
`faction` = 190,
`gossip_menu_id` = 19515
WHERE `entry` IN (105729, 10572901, 10572902);

DELETE FROM `creature_template_addon` WHERE `entry` = 105729;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES
(105729, 0, 0, 0, 1, 0, '209519');

DELETE FROM `gossip_menu` WHERE `entry` = 19515;
INSERT INTO `gossip_menu` (`entry`, `text_id`) VALUES
(19515, 28836); -- 105729

DELETE FROM `gossip_menu_option` WHERE `menu_id` = 19515;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `OptionBroadcastTextID`, `action_poi_id`, `box_coded`, `box_money`, `box_text`, `BoxBroadcastTextID`) VALUES
(19515, 0, 0, 'Send a signal to Ly''leth Lunastre.', 0, 0, 0, 0, '', 0);

DELETE FROM `spell_target_position` WHERE `ID` = 208631;
INSERT INTO `spell_target_position` (`ID`, `EffectIndex`,  `MapID`, `positionX`, `positionY`, `positionZ`) VALUES
(208631, 0, 1571, 940.44, 3841.49, 0);

DELETE FROM `waypoint_data` WHERE `id` IN (10526410, 10526411);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`) VALUES
(10526410, 0, 936.4217, 3846.488, 0.07702298),
(10526410, 1, 940.44, 3841.49, 0.08333334),
(10526410, 2, 944.4583, 3836.492, 0.08964369),
(10526410, 3, 950.3229, 3823.648, 0.0776825),
(10526410, 4, 957.7969, 3816.115, 0.02872213),
(10526410, 5, 964.25, 3806.104, -0.0001780192),
(10526410, 6, 971.7639, 3795.925, 0.05193922),
(10526410, 7, 981.7031, 3784.842, 0.3207923),
(10526410, 8, 995.0555, 3778.045, 0.06988695),
(10526410, 9, 1007.372, 3774.398, 0.1934967),
(10526410, 10, 1007.372, 3774.398, 0.1934967),
(10526411, 0, 1024.154, 3768.146, -0.0861008),
(10526411, 1, 1026.404, 3755.146, -0.0861008),
(10526411, 2, 1027.154, 3747.146, 0.1638992),
(10526411, 3, 1033.404, 3726.396, -0.0861008),
(10526411, 4, 1033.404, 3699.896, -0.0861008),
(10526411, 5, 1027.654, 3675.146, -0.0861008),
(10526411, 6, 1026.404, 3641.646, -0.0861008),
(10526411, 7, 1019.904, 3611.146, -0.0861008),
(10526411, 8, 1005.404, 3586.396, 0.1638992),
(10526411, 9, 991.1537, 3561.396, -0.0861008),
(10526411, 10, 987.1537, 3543.896, -0.0861008),
(10526411, 11, 984.1537, 3522.146, -0.0861008),
(10526411, 12, 987.1537, 3504.146, -0.0861008),
(10526411, 13, 984.4037, 3490.396, -0.0861008),
(10526411, 14, 981.4358, 3477.893, -0.3656983);

