UPDATE creature_template_addon SET auras = "170133 186895" WHERE entry IN (98278, 98251, 98279, 98245, 98250, 98247, 98269);
UPDATE creature_template_addon SET auras = "186895" WHERE entry = 98249;
DELETE FROM creature_addon WHERE guid IN (20546891, 20546893, 20546863, 20546878, 20546865, 20546894, 20546898);

DELETE FROM `creature_queststarter` WHERE `id` = '92909';
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES
('92909', '38710'),
('90369', '40408');

REPLACE INTO `phase_area` (`AreaId`, `PhaseId`, `Comment`) VALUES (7502, 6765, 'PHASE 6764- CONDITION_QUESTSTATE'); 
INSERT INTO conditions (SourceTypeOrReferenceId, SourceGroup, SourceEntry, SourceId, ElseGroup, ConditionTypeOrReference, ConditionTarget, ConditionValue1, ConditionValue2, ConditionValue3, NegativeCondition, ErrorType, ErrorTextId, ScriptName, Comment) VALUES 
('26', '6764', '7502', '0', '0', '47', '0', '38710', '10', '0', '0', '0', '0', '', 'phase 6764 on quest 38710 taken,complete'),
('26', '6764', '7502', '0', '0', '47', '0', '38710', '64', '0', '1', '0', '0', '', 'cancel phase 6764 on quest 38710 rewarded'); 

UPDATE `creature` SET `zoneId`=7581, `areaId`=7502, `PhaseId`=6764 WHERE `guid`=280000818;
UPDATE `creature` SET `zoneId`=7581, `areaId`=7502, `PhaseId`=6764 WHERE `guid`=280000820;
UPDATE `creature` SET `zoneId`=7581, `areaId`=7502, `PhaseId`=6764 WHERE `guid`=280000905;


UPDATE `quest_template_addon` SET `PrevQuestID`=42000 WHERE `ID`=42002;
UPDATE `quest_template_addon` SET `PrevQuestID`=42002 WHERE `ID`=42005;

UPDATE `creature_template` SET `npcflag` = '2', `minlevel`=98, `maxlevel`=110, `ScriptName`='npc_npc_lord_maxwell_tyrosus_92909'  WHERE `entry`=92909; -- lord_maxwell_tyrosus

DELETE FROM `gossip_menu_option` WHERE (`MenuId`=19858 AND `OptionIndex`=0) OR (`MenuId`=19856 AND `OptionIndex`=0);
INSERT INTO `gossip_menu_option` (`MenuId`, `OptionIndex`, `OptionIcon`, `OptionText`, `OptionBroadcastTextId`) VALUES
(19858, 0, 0, 'Тебе нужно как можно скорее прибыть на Площадку Краса. Меня послал Тиросс.', 0),
(19856, 0, 0, 'Ступай на Площадку Краса. Возможно, мы сумеем помочь твоему ордену.', 0);


DELETE FROM `gossip_menu` WHERE (`MenuId`=19858 AND `TextId`=29494) OR (`MenuId`=19856 AND `TextId`=29489);
INSERT INTO `gossip_menu` (`MenuId`, `TextId`) VALUES
(19858, 29494), -- 108693 (Orik Trueheart)
(19856, 29489); -- 108692 (Travard)

UPDATE `creature_template` SET `gossip_menu_id`=19856, `minlevel`=98, `maxlevel`=110, `npcflag`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=33536,  `ScriptName`='npc_travard_108692', `unit_flags2`=2048 WHERE `entry`=108692; -- Travard
UPDATE `creature_template` SET `gossip_menu_id`=19858, `minlevel`=98, `maxlevel`=110, `npcflag`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=33536, `ScriptName`='npc_orik_trueheart_108693', `unit_flags2`=2048 WHERE `entry`=108693; -- Orik Trueheart

UPDATE  `gossip_menu_option` SET `OptionType`=1, `OptionNpcFlag`=1, `VerifiedBuild`=26124 WHERE (`MenuId`=19858 AND `OptionIndex`=0);
UPDATE  `gossip_menu_option` SET `OptionType`=1, `OptionNpcFlag`=1, `VerifiedBuild`=26124 WHERE (`MenuId`=19856 AND `OptionIndex`=0);

SET NAMES 'utf8';
SET @GROUP_ID=0;
SET @ID=0;
DELETE FROM `creature_text` WHERE (`CreatureID`=91866) OR (`CreatureID`=92460) OR (`CreatureID`=92909) OR (`CreatureID`=93532) OR (`CreatureID`=103092) OR (`CreatureID`=108692) OR (`CreatureID`=108693) OR (`CreatureID`=108783);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `comment`) VALUES
(108692, @GROUP_ID+0, @ID+0, 'Если есть шанс найти помощь, мы с Эфриной согласны. Останься, Рассвет.', 12, 0, 100, 0, 0, 0, 0, 'Travard to Player'),
(92909, @GROUP_ID+0, @ID+0, 'Хвала Свету, $n, я нашел тебя. Нам надо срочно поговорить.', 12, 0, 100, 0, 0, 0, 0, 'Lord Maxwell Tyrosus to Player'),
(108693, @GROUP_ID+0, @ID+0, 'Тиросс хороший человек. Я с вами! Дело слишком опасное, так что помощь лишней не будет!', 12, 0, 100, 0, 0, 0, 0, 'Orik Trueheart to Player');

UPDATE `quest_poi` SET `AlwaysAllowMergingBlobs`=0, `VerifiedBuild`=26124 WHERE (`QuestID`=40408 AND `BlobIndex`=0 AND `Idx1`=2); -- Weapons of Legend
UPDATE `quest_poi` SET `AlwaysAllowMergingBlobs`=0, `VerifiedBuild`=26124 WHERE (`QuestID`=40408 AND `BlobIndex`=0 AND `Idx1`=1); -- Weapons of Legend
UPDATE `quest_poi` SET `AlwaysAllowMergingBlobs`=0, `VerifiedBuild`=26124 WHERE (`QuestID`=40408 AND `BlobIndex`=0 AND `Idx1`=0); -- Weapons of Legend

UPDATE `quest_template_addon` SET `PrevQuestID`=38710 WHERE `ID`=40408; 

UPDATE `creature_template` SET `AIName` = 'SmartAI', `gossip_menu_id` = 19044, `npcflag` = 3 WHERE `entry` = 90369;
DELETE FROM `gossip_menu_option` WHERE (`menuid`=19044 AND `OptionIndex`=0);
INSERT INTO `gossip_menu_option` (`menuid`, `OptionIndex`, `optionicon`, `optiontext`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `VerifiedBuild`) VALUES
(19044, 0, 0, 'Я хочу еще раз освежить в памяти, поисками какого оружия мы можем заняться.', 0, 0, 0, 0);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = 19044;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES 
(15, 19044, 0, 0, 0, 8, 0, 38710, 0, 0, 0, 0, 0, '', 'Show gossip only if player reward quest 38710');

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (90369);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(90369, 0, 0, 0, 10, 0, 100, 0, 1, 30, 60000, 60000, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On LOS - Say line 0'),
(90369, 0, 1, 0, 19, 0, 100, 0, 40408, 0, 0, 0, 85, 197124, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On quest accept - InvokerCast Player Choice (Paladin)'),
(90369, 0, 2, 0, 62, 0, 100, 0, 19044, 0, 0, 0, 85, 197124, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On gossip select - InvokerCast Player Choice (Paladin)');

quest 42000

UPDATE `creature_template` SET `gossip_menu_id`=19854, `minlevel`=98, `maxlevel`=110, `npcflag`=1, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_class`=2, `unit_flags`=33536, `ScriptName`='', `unit_flags2`=2048 WHERE `entry`=105689; -- Orik Trueheart

INSERT INTO `gossip_menu` (`MenuId`, `TextId`, `VerifiedBuild`) VALUES
(19854, 29486, 22624);

INSERT INTO `gossip_menu_option` (`MenuId`, `OptionIndex`, `OptionIcon`, `OptionText`, `OptionBroadcastTextId`, `VerifiedBuild`) VALUES
(19854, 0, 0, 'Tel me you plan!', 0, 22624);


INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `comment`) VALUES
(105689, @GROUP_ID+0, @ID+, '???????,?????????????????????????????????????', 12, 0, 100, 1, 0, 63272, UNKNOWN, '???·??? to Player'),
(105689, @GROUP_ID+1, @ID+, '??????????,?????????????????????', 12, 0, 100, 1, 0, 63273, UNKNOWN, '???·??? to Player'),
(105689, @GROUP_ID+2, @ID+, '?,?????????,????????????', 12, 0, 100, 5, 0, 63275, UNKNOWN, '???·??? to Player'),
(105689, @GROUP_ID+3, @ID+, '????????????????????,??????????????,??????', 12, 0, 100, 1, 0, 63278, UNKNOWN, '???·??? to Player'),
(105691, @GROUP_ID+0, @ID+, '???????????????????????????????', 12, 0, 100, 6, 0, 63274, UNKNOWN, '??·?? to Player'),
(105691, @GROUP_ID+1, @ID+, '??????????,???????????????,????', 12, 0, 100, 1, 0, 63279, UNKNOWN, '??·?? to Player'),

INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `comment`) VALUES
(105813, 0, 0, 'Ride this bird, come with me!Go to Stormheim!', 12, 0, 100, 0, 0, 63276, 0, ' to Player');

quest 42002

UPDATE `creature_template` SET `minlevel`=98, `maxlevel`=110, `AIName`="SmartAI" WHERE `entry`= 105724;
DELETE FROM `smart_scripts` WHERE (`entryorguid`=105724 AND `source_type`=0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(105724, 0, 0, 0, 10, 0, 100, 512, 1, 10, 2000, 2000, '', 33, 105726, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Kill Moster On quest 38710");

need add text

UPDATE `creature_template` SET `gossip_menu_id`=105727, `minlevel`=98, `maxlevel`=110, `unit_class`=2, `unit_flags`=33536, `npcflag` = 1, `ScriptName`='npc_tahu_sagewind_105727' WHERE `entry`= 105727;

quest 42005
Replace INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `RequiredLevel`, `AIName`, `ScriptName`, `VerifiedBuild`) VALUES 
(249044, 10, 33241, 'Gravestone', 'questinteract', 'Concentrating', '', 1, 2173, 0, 0, 0, 0, 0, 0, 0, 0, 0, 209575, 0, 0, 1, 108602, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 22522),
(249045, 10, 33241, 'Gravestone', 'questinteract', 'Concentrating', '', 1, 2173, 0, 0, 0, 0, 0, 0, 0, 0, 0, 227053, 0, 0, 1, 108602, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 22522),
(251288, 10, 33241, 'Gravestone', 'questinteract', 'Concentrating', '', 1.2, 2173, 0, 0, 3000, 0, 0, 0, 0, 0, 0, 209576, 0, 0, 1, 108602, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 22522);

UPDATE `creature_template` SET `gossip_menu_id`=105727, `minlevel`=98, `maxlevel`=110, `unit_class`=2, `unit_flags`=33536, `npcflag` = 1, `ScriptName`='npc_tahu_sagewind_105727' WHERE `entry`= 105727;
UPDATE `gameobject_template` SET `ScriptName`='go_broken_sword_250364' WHERE `entry`= 250364;
UPDATE `creature_template` SET `ScriptName`='npc_orik_trueheart_105813' WHERE `entry`= 105813;
UPDATE `creature_template` SET `type` = 7, `ScriptName`='npc_argent_hippogryph_105886' WHERE `entry`= 105886;
UPDATE `creature_template` SET `minlevel` = 99, `maxlevel` = 99, `faction` = 2395, `BaseAttackTime` = 2000, `RangeAttackTime` = 2000, `unit_flags` = 33587720, `unit_flags2` = 2048, `VehicleId` = 4197, `MovementId` = 150, `InhabitType` = 4 WHERE `entry` = 105886;
need do Complete the ritual spell 209576

DELETE FROM `gossip_menu_option` WHERE (`MenuId`=105727 AND `OptionIndex`=0);
INSERT INTO `gossip_menu_option` (`MenuId`, `OptionIndex`, `OptionIcon`, `OptionText`, `OptionBroadcastTextId`) VALUES
(105727, 0, 0, 'Orik says you can speak to these spirits how do we begin?', 0);

UPDATE  `gossip_menu_option` SET `OptionType`=1, `OptionNpcFlag`=1, `VerifiedBuild`=26124 WHERE (`MenuId`=105727 AND `OptionIndex`=0);

UPDATE `creature_template` SET  `minlevel`=98, `maxlevel`=110,  `AIName`="SmartAI" WHERE `entry`= 105736;

DELETE FROM `quest_objectives` WHERE `ID` IN (283335, 284706, 283331, 283334, 284704, 284705);
Replace INTO `quest_objectives` (`ID`, `QuestID`, `Type`, `Order`, `StorageIndex`, `ObjectID`, `Amount`, `Flags`, `Flags2`, `ProgressBarWeight`, `VerifiedBuild`) VALUES
(283335, 42005, 0, 5, 6, 105788, 1, 2, 0, 0, 22624), -- 283335
(283334, 42005, 0, 4, 5, 108670, 1, 0, 0, 0, 22624), -- 283334
(284705, 42005, 2, 3, 1, 249045, 1, 12, 0, 0, 22624), -- 284705
(284704, 42005, 2, 2, 0, 249044, 1, 12, 0, 0, 22624), -- 284704
(284706, 42005, 2, 1, 3, 251288, 1, 14, 0, 0, 22624), -- 284706
(283331, 42005, 0, 0, 2, 108669, 1, 0, 0, 0, 22624); -- 283331

UPDATE `gameobject_template` SET `ScriptName`='',  `AIName`="SmartAI" WHERE `entry`= 251288;
DELETE FROM `smart_scripts` WHERE (`entryorguid`=251288 AND `source_type`=0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(251288, 0, 0, 0, 64, 0, 100, 512, 1, 10, 2000, 2000, '', 33, 105788, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "");