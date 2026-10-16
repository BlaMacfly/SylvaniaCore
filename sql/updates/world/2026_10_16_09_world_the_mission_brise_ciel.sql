-- The Mission (29548), introduction Alliance de la Pandarie : le Brise-ciel au-dessus du port de Hurlevent.
-- Chez nous ses 73 creatures (zone 6555) etaient en phase 0, donc visibles de tous en permanence ; officiellement en
-- phase 1686, appliquee tant que la quete est en cours (capture AshamaneCore 0883ff29d5, 05/2026 : 75 de ses 78
-- creatures sont deja chez nous a moins de 15 m). Repris de la capture : la phase, Airman Ellis et les 7 objets
-- (GUID neufs), les textes de Nodd Codejack (BroadcastText 67697-67699 verifies) et les emotes de l equipage.
-- Non repris : leurs GUID, leurs trajets (waypoint_data), leurs unit_flags.
-- Amiral Rogers : son menu 66292 (option qui donne le credit, lance le film et teleporte en Pandarie) n etait attribue
-- a rien et son ScriptName pointait sur un script inexistant (npc_q42740) : le joueur ne pouvait pas partir.
-- Texte de l option remplace par l officiel « I am ready to depart. » (BroadcastText 67429, version DestinyCore).

DELETE FROM `phase_area` WHERE `AreaId` = 6555 AND `PhaseId` = 1686;
INSERT INTO `phase_area` (`AreaId`, `PhaseId`, `Comment`) VALUES (6555, 1686, 'Brise-ciel au-dessus de Hurlevent (The Mission)');
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 26 AND `SourceGroup` = 1686;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES
(26, 1686, 6555, 0, 0, 47, 0, 29548, 8, 0, 0, 'Phase 1686 (Brise-ciel) si The Mission 29548 en cours');
UPDATE `creature` SET `PhaseId` = 1686 WHERE `map` = 0 AND `areaId` = 6555 AND `PhaseId` = 0 AND `PhaseGroup` = 0;

UPDATE `creature_template` SET `gossip_menu_id` = 66292, `ScriptName` = '' WHERE `entry` = 66292;
UPDATE `gossip_menu_option` SET `OptionText` = 'I am ready to depart.', `OptionBroadcastTextId` = 67429 WHERE `MenuId` = 66292 AND `OptionIndex` = 0;

DELETE FROM `creature` WHERE `guid` = 290400069;
DELETE FROM `creature_addon` WHERE `guid` = 290400069;
DELETE FROM `gameobject` WHERE `guid` BETWEEN 290400000 AND 290400006;
DELETE FROM `creature_text` WHERE `CreatureID` = 55832;
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` IN (55819, 55823, 55830, 55832);
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (55819, 55823, 55830, 55832) AND `source_type` = 0;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `PhaseId`, `PhaseGroup`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `dynamicflags`, `VerifiedBuild`) VALUES
(290400069, 64862, 0, 1519, 6555, '0', 1686, 0, 0, 0, -7883.44970703125, 1340.9635009765625, 338.9415283203125, 0.084910094738006591, 120, 0, 14270, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `visibilityDistanceType`, `auras`) VALUES
(290400069, 0, 0, 0, 0, 0, 0, 0, '');
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `PhaseId`, `PhaseGroup`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`) VALUES
(290400000, 215648, 0, 1519, 6555, '0', 1686, 0, -7894.48974609375, 1354.6822509765625, 339.892852783203125, 0, 0, 0, 0, 1, 120, 255, 1, 0),
(290400001, 215648, 0, 1519, 6555, '0', 1686, 0, -7892.52783203125, 1354.90625, 338.81634521484375, 0, 0, 0, 0, 1, 120, 255, 1, 0),
(290400002, 215648, 0, 1519, 6555, '0', 1686, 0, -7893.98095703125, 1355.5555419921875, 338.81695556640625, 0, 0, 0, 0, 1, 120, 255, 1, 0),
(290400003, 216056, 0, 1519, 6555, '0', 1686, 0, -7879.80029296875, 1279.515625, 358.560516357421875, 4.728822231292724609, 0, 0, -0.70127296447753906, 0.712892889976501464, 120, 255, 1, 0),
(290400004, 215648, 0, 1519, 6555, '0', 1686, 0, -7892.501953125, 1353.515625, 338.827392578125, 0, 0, 0, 0, 1, 120, 255, 1, 0),
(290400005, 215648, 0, 1519, 6555, '0', 1686, 0, -7895.234375, 1354.65283203125, 338.831878662109375, 0, 0, 0, 0, 1, 120, 255, 1, 0),
(290400006, 215648, 0, 1519, 6555, '0', 1686, 0, -7893.88525390625, 1354.171875, 338.818756103515625, 0, 0, 0, 0, 1, 120, 255, 1, 0);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(55832, 0, 0, '13 gyromantic destabilizers? Check. 10 gnumatic flangegrips? Check. Now where did I put my favorite wrench?', 12, 0, 100, 0, 0, 0, 67697, 0, 'Nodd Codejack <SI:7>'),
(55832, 0, 1, 'Hmm. Only 2 tons of explosives for this mission? Seems a bit light to me. This seems like the kind of mission we are going to need way more explosives for. Like... goblin pyromaniac explosives.', 12, 0, 100, 0, 0, 0, 67698, 0, 'Nodd Codejack <SI:7>'),
(55832, 0, 2, 'Only thirty gyrocopters? We are going to need way more than that before this is over.', 12, 0, 100, 0, 0, 0, 67699, 0, 'Nodd Codejack <SI:7>');
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(55819, 0, 0, 0, 1, 0, 100, 0, 4000, 8000, 4000, 8000, 0, '', 5, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, '\"The Pickle\" McLeary - Out of Combat - Play Emote 1'),
(55823, 0, 0, 0, 1, 0, 100, 0, 4000, 8000, 4000, 8000, 0, '', 5, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mishka - Out of Combat - Play Emote 1'),
(55830, 0, 0, 0, 1, 0, 100, 0, 4000, 8000, 4000, 8000, 0, '', 5, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nimm Codejack - Out of Combat - Play Emote 1'),
(55832, 0, 0, 0, 1, 0, 100, 0, 5000, 10000, 50000, 70000, 0, '', 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nodd Codejack <SI:7> - OOC - talking');
