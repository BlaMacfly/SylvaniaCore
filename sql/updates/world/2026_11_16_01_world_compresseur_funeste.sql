-- Doomroller (Tanaan Jungle rare elite near Hellfire Citadel) could not be fought: its script made it non attackable
-- until it reached a point, and added new passengers at each reset. As LegionCore: spawned at that point,
-- its SmartAI (Siege Nova) instead of the script, the five riders as vehicle accessories.
UPDATE `creature_template` SET `ScriptName`='' WHERE `entry`=95056 AND `ScriptName`='npc_doomroller';
UPDATE `creature` SET `position_x`=4090.57, `position_y`=-756.123, `position_z`=2.31386, `orientation`=5.25873 WHERE `guid`=10672877 AND `id`=95056;
DELETE FROM `vehicle_template_accessory` WHERE `entry`=95056;
INSERT INTO `vehicle_template_accessory` (`entry`, `accessory_entry`, `seat_id`, `minion`, `description`, `summontype`, `summontimer`) VALUES
(95056, 95062, 0, 1, 'Doomroller - Gorebound Dragoon', 8, 0),
(95056, 95062, 2, 1, 'Doomroller - Gorebound Dragoon', 8, 0),
(95056, 95062, 3, 1, 'Doomroller - Gorebound Dragoon', 8, 0),
(95056, 95062, 5, 1, 'Doomroller - Gorebound Dragoon', 8, 0),
(95056, 94807, 7, 1, 'Doomroller - Gorebound Siegerider', 8, 0);
