-- horde sinkholes quest 11608 bury-those-cockroaches

-- adding missing template
DELETE FROM `gameobject_template` WHERE `entry`=187666; -- temp gameobject 300171
INSERT INTO `gameobject_template` (
`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, 
`Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, 
`Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, 
`RequiredLevel`, `AIName`, `ScriptName`, `VerifiedBuild`) VALUES 
(187666, 8, 0, 'Nerub\'ar Sinkhole', '', '', '', 1, 1489, 5, 0, 1, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0, '', '', -18019);

DELETE FROM `gameobject_template_addon` WHERE `entry`=187666;
INSERT INTO `gameobject_template_addon` (`entry`, `faction`, `flags`, `mingold`, `maxgold`, `WorldEffectID`) VALUES (187666, 0, 0, 0, 0, 0);

-- gameobjects with correct template
UPDATE `gameobject` SET `id`='187666', `spawntimesecs` = '0' WHERE  `guid` IN (45026, 45027, 45028, 45029);

-- updatre scrypt for targets
UPDATE `creature_template` SET `ScriptName`= '' where entry in (25402, 25403, 25404, 25405); -- npc_nerub_sinkhole
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE  `entry`=25401;

-- sai for sink holes horde
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (25401, 2540100);
INSERT INTO `smart_scripts` (
`entryorguid`, `source_type`, `id`, `link`, 
`event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param_string`, 
`action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, 
`target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(25401, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, '', 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Seaforium Depth Charge - On Just Summoned - Store Targetlist'),
(25401, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, '', 80, 2540100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Seaforium Depth Charge - On Just Summoned - Run Script'),
(25401, 0, 2, 0, 1, 2, 100, 1, 100, 100, 0, 0, '', 11, 45506, 2, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 'Seaforium Depth Charge - OOC (Phase 2/No repeat) - Cast Nerub ar Sinkhole Credit (SW)'),
(25401, 0, 3, 0, 1, 2, 100, 1, 100, 100, 0, 0, '', 11, 45508, 2, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 'Seaforium Depth Charge - OOC (Phase 2/No repeat) - Cast Nerub ar Sinkhole Credit (SE)'),
(25401, 0, 4, 0, 1, 2, 100, 1, 100, 100, 0, 0, '', 11, 45510, 2, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 'Seaforium Depth Charge - OOC (Phase 2/No repeat) - Cast Nerub ar Sinkhole Credit (NW)'),
(25401, 0, 5, 0, 1, 2, 100, 1, 100, 100, 0, 0, '', 11, 45512, 2, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 'Seaforium Depth Charge - OOC (Phase 2/No repeat) - Cast Nerub ar Sinkhole Credit (NE)'),
(2540100, 9, 0, 0, 0, 0, 100, 0, 0, 2000, 0, 0, '', 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Seaforium Depth Charge - Script - Say Line 0'),
(2540100, 9, 1, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, '', 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Seaforium Depth Charge - Script - Say Line 1'),
(2540100, 9, 2, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, '', 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Seaforium Depth Charge - Script - Say Line 2'),
(2540100, 9, 3, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, '', 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Seaforium Depth Charge - Script - Say Line 2'),
(2540100, 9, 4, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, '', 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Seaforium Depth Charge - Script - Say Line 2'),
(2540100, 9, 5, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, '', 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Seaforium Depth Charge - Script - Say Line 2'),
(2540100, 9, 6, 0, 0, 0, 100, 0, 900, 900, 0, 0, '', 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Seaforium Depth Charge - Script - Set Phase 2'),
(2540100, 9, 7, 0, 0, 0, 100, 0, 100, 100, 0, 0, '', 11, 45502, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Seaforium Depth Charge - Script - Cast Seaforium Depth Charge Explosion'),
(2540100, 9, 8, 0, 0, 0, 100, 0, 500, 500, 0, 0, '',  41, 0, 0, 0, 0, 0, 0,  1, 0, 0, 0, 0, 0, 0, 0, 'Seaforium Depth Charge - Script - Cast Seaforium Depth Charge Explosion');