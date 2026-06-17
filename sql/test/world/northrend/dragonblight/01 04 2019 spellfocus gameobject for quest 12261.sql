-- delete unneeded spawns
DELETE FROM `creature` WHERE `id` IN (28820, 27430);
DELETE FROM `creature` WHERE `id` IN (33016, 33017);

-- smartai for spawns of npcs 33016 and 33017 and unitflags and extraflags for npc 27430
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry` IN (33016, 33017);
UPDATE `creature_template` SET `unit_flags`='4', `flags_extra`='64' WHERE  `entry`=27430;-- unit_flags=256

-- add missing template
DELETE FROM `gameobject_template` WHERE `entry`=188707;
INSERT INTO `gameobject_template` 
(`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, 
`Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, 
`Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, 
`RequiredLevel`, `AIName`, `ScriptName`, `VerifiedBuild`) 
VALUES 
(188707, 8, 2770, 'Obsidian Dragonshrine Path End', '', '', '', 1, 1530, 40, 0, 1, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0, 0, 0, 0, 0, 0, '', '', -18019);

-- add missing template addon
DELETE FROM `gameobject_template_addon` WHERE `entry`=188707;
INSERT INTO `gameobject_template_addon` 
(`entry`, `faction`, `flags`, `mingold`, `maxgold`, `WorldEffectID`) 
VALUES 
(188707, 0, 0, 0, 0, 0);

-- add missing spawn of spellfocus object 188707
DELETE FROM `gameobject` WHERE `id` IN (188707);
INSERT INTO `gameobject` 
(`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, 
`position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `isActive`, `ScriptName`, `VerifiedBuild`) 
VALUES 
(99756 , 188707, 571,   65, 4167, '0', 0, 0, 0, -1,  4379.38, 1280.39, 158.122, 1.46024, 0, 0, 0.666959,  0.745094,  25 ,  0, 1, 0, '', 0);

-- add missing spawn addon
DELETE FROM `gameobject_addon` WHERE `guid`=99756;
INSERT INTO `gameobject_addon` 
(`guid`, `parent_rotation0`, `parent_rotation1`, `parent_rotation2`, `parent_rotation3`, `invisibilityType`, `invisibilityValue`, `WorldEffectID`) 
VALUES 
(99756, 0, 0, 0.666961, 0.745093, 0, 0, 0);

-- update of the smartscripts
DELETE FROM `smart_scripts` WHERE `entryorguid`=27430;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2743000 AND `source_type`=9;
INSERT INTO `smart_scripts` 
(`entryorguid`, `source_type`, `id`, `link`, 
`event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param_string`, 
`action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, 
`target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES 
(27430  , 0, 0, 1, 54, 0, 100, 512, 0, 0, 0, 0, '',  80, 2743000, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Destructive Ward - On spawn Start Script'),
(27430  , 0, 1, 2, 25, 0, 100,   0, 0, 0, 0, 0, '', 103,       1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Destructive Ward - On Reset - Set root on'),
(27430  , 0, 2, 0, 61, 0, 100,   0, 0, 0, 0, 0, '',   8,       0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Destructive Ward - On Reset - Set passive'),
(2743000, 9, 0, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, '', 11, 48715, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Destructive Ward - Summon Smoldering Skeleton'),
(2743000, 9, 1, 0, 0, 0, 100, 0, 15000, 15000, 0, 0, '', 11, 48715, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Destructive Ward - Summon Smoldering Skeleton'),
(2743000, 9, 2, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, '', 11, 48735, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Destructive Ward - Destructive Ward Powerup'),
(2743000, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, '', 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Destructive Ward - Raid Emote'),
(2743000, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, '', 11, 48733, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Destructive Ward - Destructive Pulse'),
(2743000, 9, 5, 0, 0, 0, 100, 0, 15000, 15000, 0, 0, '', 11, 48718, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Destructive Ward - Summon Smoldering Construct'),
(2743000, 9, 6, 0, 0, 0, 100, 0, 15000, 15000, 0, 0, '', 11, 48718, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Destructive Ward - Summon Smoldering Construct'),
(2743000, 9, 7, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, '', 11, 48735, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Destructive Ward - Destructive Ward Powerup'),
(2743000, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, '', 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Destructive Ward - Raid Emote'),
(2743000, 9, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, '', 11, 48733, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Destructive Ward - Destructive Pulse'),
(2743000, 9, 10, 0, 0, 0, 100, 0, 25000, 25000, 0, 0, '', 11, 48715, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Destructive Ward - Summon Smoldering Skeleton'),
(2743000, 9, 11, 0, 0, 0, 100, 0, 0, 0, 0, 0, '', 11, 48715, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Destructive Ward - Summon Smoldering Skeleton'),
(2743000, 9, 12, 0, 0, 0, 100, 0, 0, 0, 0, 0, '', 11, 48718, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Destructive Ward - Summon Smoldering Construct'),
(2743000, 9, 13, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, '', 11, 48735, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Destructive Ward - Destructive Ward Powerup'),
(2743000, 9, 14, 0, 0, 0, 100, 0, 0, 0, 0, 0, '', 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Destructive Ward - Raid Emote'),
(2743000, 9, 15, 0, 0, 0, 100, 0, 0, 0, 0, 0, '', 11, 48734, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Destructive Ward - Destructive Barrage'),
(2743000, 9, 16, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, '', 11, 48734, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Destructive Ward - Destructive Barrage'),
(2743000, 9, 17, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, '', 11, 48734, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Destructive Ward - Destructive Barrage'),
(2743000, 9, 18, 0, 0, 0, 100, 0, 0, 0, 0, 0, '', 11, 52409, 2, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 'Destructive Ward - Destructive Ward Kill Credit'),
(2743000, 9, 19, 0, 0, 0, 100, 0, 0, 0, 0, 0, '', 41, 1000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Destructive Ward - Despawn');







