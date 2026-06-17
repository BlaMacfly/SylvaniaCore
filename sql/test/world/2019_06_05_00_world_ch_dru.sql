UPDATE `creature_template` SET `minlevel`=98,`maxlevel`=110,`npcflag`=2 WHERE `entry`=101061;
UPDATE `creature_template` SET `minlevel`=98,`maxlevel`=110 WHERE `entry`=101064;

UPDATE `creature_template` SET `ScriptName`='npc_archdruid_hamuul_runetotem' WHERE `entry`=101061;
UPDATE `creature_template` SET `ScriptName`='npc_archdruid_hamuul_runetotem' WHERE `entry`=101064;

INSERT IGNORE INTO `creature_queststarter` (`id`, `quest`) VALUES (101061, 40643);

DELETE FROM `creature_text` WHERE (`CreatureID`=101061) OR (`CreatureID`=101064) OR (`CreatureID`=103133)  OR (`CreatureID`=103135);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `comment`) VALUES
(101061, @GROUP_ID+0, @ID+0, 'Завершай дела в Даларане и скорее приходи. Увидимся на месте.', 12, 0, 100, 0, 0, 0, 0, 'Archdruid Hamuul Runetotem to Player'),
(101064, @GROUP_ID+0, @ID+0, 'Лагерь Зен''табры на западном берегу озера. Наралекса видели на восточном, но он часто переходит с места на место. Смотри в оба и найди его.', 12, 0, 100, 0, 0, 0, 0, 'Archdruid Hamuul Runetotem to Player'),
(103133, @GROUP_ID+0, @ID+0, 'Я не сплю! Я НЕ СПЛЮ! Я просто... просто решил дать глазам немного отдохнуть.', 12, 0, 100, 0, 0, 0, 0, 'Naralex to Player'),
(103133, @GROUP_ID+1, @ID+0, 'Подошло время ритуала? Хорошо. Встретимся на месте.', 12, 0, 100, 0, 0, 0, 0, 'Naralex to Player'),
(103135, @GROUP_ID+0, @ID+0, '', 12, 0, 100, 0, 0, 0, 125613, 'Zen''tabra to Player'); 

UPDATE `creature` SET `zoneId`=7581, `areaId`=7502, `PhaseId`=6764 WHERE `guid`=280000908;

DELETE FROM `creature_addon` WHERE `guid` = @CGUID+0 ;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `auras`) VALUES
(280000908, 0, 0, 0, 1, 0, 0, 0, 0, ''); -- rensar-greathoof

DELETE FROM `phase_area` WHERE `AreaId` = 7846;
INSERT INTO `phase_area` (`AreaId`, `PhaseId`, `Comment`) VALUES (7846, 5685, 'phase before quest 41332 complete');


SET NAMES 'utf8';
DELETE FROM `creature_text` WHERE (`CreatureID`=97923 AND `GroupID`='0' AND `ID`='0') OR (`CreatureID`=97923 AND `GroupID`='1' AND `ID`='0') ;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `comment`) VALUES
(97923, 0, 0, 'That's goodThis seed bears the magic of the world at birth.You will soon see its usefulness.?', 12, 0, 100, 0, 0, 62251, 106390, ''),
(97923, 1, 0, 'Your weapon contains deep magic.It will grow with you.', 12, 0, 100, 0, 0, 62252, 103776, '');

DELETE FROM `creature_text` WHERE (`CreatureID`=101195 AND `GroupID`='1' AND `ID`='0')  ;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `comment`) VALUES
(101195, 1, 0, 'This seed needs plenty of air and water.To the mountains behind us to find an ideal place.', 12, 0, 100, 0, 0, 62250, 106382, '??·?? to Player');


DELETE FROM `spell_target_position` WHERE `ID`=205013;
INSERT INTO `spell_target_position` (`ID`, `EffectIndex`, `MapID`, `PositionX`, `PositionY`, `PositionZ`, `VerifiedBuild`) VALUES 
(205013, 0, 0, -10383.7, -424.56, 64.03, 22624);
