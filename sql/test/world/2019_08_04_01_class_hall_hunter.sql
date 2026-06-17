INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES 
(102478, 40618);

UPDATE `quest_template_addon` SET `PrevQuestID`=40384 WHERE `ID`=41415;
UPDATE `quest_template_addon` SET `PrevQuestID`=41415 WHERE `ID`=40618;
UPDATE `quest_template_addon` SET `PrevQuestID`=41541 WHERE `ID`=41574;
UPDATE `quest_template_addon` SET `PrevQuestID`=41540 WHERE `ID`=40392;
UPDATE `quest_template_addon` SET `PrevQuestID`=41542 WHERE `ID`=39427; 
UPDATE `quest_template_addon` SET `PrevQuestID`=39427 WHERE `ID`=40385;   

INSERT INTO `gossip_menu_option` (`MenuId`, `OptionIndex`, `OptionIcon`, `OptionText`, `OptionBroadcastTextId`) VALUES
(100810, 0, 0, 'She said you know something about an anclent weapon.', 0),
(99986, 0, 0, 'Im told you know about an anclent weapon.', 0),
(100171, 0, 0, 'Do you know of a weapon that could help fight the Legion?.', 0);

UPDATE `creature_template` SET `minlevel`=98, `maxlevel`=110, `npcflag`=16777216, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=33536, `unit_flags2`=18432 WHERE `entry`=102177;
UPDATE `creature_template` SET `gossip_menu_id`=100810, `ScriptName`='npc_grif_wildheart_100810' WHERE `entry`=100810;
UPDATE `creature_template` SET `gossip_menu_id`=99986, `ScriptName`='npc_apata_highmountain_99986' WHERE `entry`=99986;
UPDATE `creature_template` SET `gossip_menu_id`=100171, `ScriptName`='npc_courier_larkspur_100171' WHERE `entry`=100171;

UPDATE  `gossip_menu_option` SET `OptionType`=1, `OptionNpcFlag`=1, `VerifiedBuild`=26124 WHERE (`MenuId`=100810 AND `OptionIndex`=0);
UPDATE  `gossip_menu_option` SET `OptionType`=1, `OptionNpcFlag`=1, `VerifiedBuild`=26124 WHERE (`MenuId`=99986 AND `OptionIndex`=0);
UPDATE  `gossip_menu_option` SET `OptionType`=1, `OptionNpcFlag`=1, `VerifiedBuild`=26124 WHERE (`MenuId`=100171 AND `OptionIndex`=0);

UPDATE `creature_template` SET `AIName` = 'SmartAI', `gossip_menu_id` = 19115, `npcflag` = 3 WHERE `entry` = 102478;
DELETE FROM `gossip_menu_option` WHERE (`menuid`=19115 AND `OptionIndex`=0);
INSERT INTO `gossip_menu_option` (`menuid`, `OptionIndex`, `optionicon`, `optiontext`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `VerifiedBuild`) VALUES
(19115, 0, 0, 'Я хочу еще раз освежить в памяти, поисками какого оружия мы можем заняться.', 0, 0, 0, 0);

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (102478);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(102478, 0, 0, 0, 10, 0, 100, 0, 1, 20, 15000, 15000, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On LOS - Say line 0'),
(102478, 0, 1, 0, 19, 0, 100, 0, 40618, 0, 0, 0, 85, 198430, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On quest accept - InvokerCast Player Choice (Hunter)'),
(102478, 0, 2, 0, 62, 0, 100, 0, 19115, 0, 0, 0, 85, 198430, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On gossip select - InvokerCast Player Choice (Hunter)');

DELETE FROM `playerchoice_response_reward_item` WHERE `ChoiceId`=240;
INSERT INTO `playerchoice_response_reward_item` (`ChoiceId`, `ResponseId`, `Index`, `ItemId`, `BonusListIDs`, `Quantity`, `VerifiedBuild`) VALUES 
(240, 505, 0, 128808, '', 0, 25549),
(240, 506, 0, 128826, '', 0, 25549),
(240, 504, 0, 128861, '', 0, 25549);


UPDATE `creature_template` SET `minlevel`=98, `maxlevel`=110, `npcflag`=16777216, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=33536, `unit_flags2`=18432 WHERE `entry`=102177;

UPDATE `creature` SET `zoneId`=7502, `areaId`=7502, `PhaseId`=7341 WHERE `guid`=280000787;
UPDATE `creature` SET `zoneId`=7581, `areaId`=7502, `PhaseId`=6764 WHERE `guid`=280000795;
UPDATE `creature` SET `zoneId`=7581, `areaId`=7502, `PhaseId`=6764 WHERE `guid`=280000797;
UPDATE `creature` SET `zoneId`=7581, `areaId`=7502, `PhaseId`=6764 WHERE `guid`=280000793;
UPDATE `creature` SET `zoneId`=7505, `areaId`=7505, `PhaseId`=6763 WHERE `guid`=20555665;
UPDATE `creature` SET `zoneId`=7505, `areaId`=7502, `PhaseId`=6763 WHERE `guid`=280000858;

REPLACE INTO `phase_area` (`AreaId`, `PhaseId`, `Comment`) VALUES (7502, 7341, 'Phase 7341 On Dalaran Hunter');
DELETE FROM conditions WHERE (SourceTypeOrReferenceId = 26) AND (ConditionTypeOrReference =47) AND (SourceGroup =7341) AND (SourceEntry =7502) AND (ConditionValue1 =40384); 
INSERT INTO conditions (SourceTypeOrReferenceId, SourceGroup, SourceEntry, SourceId, ElseGroup, ConditionTypeOrReference, ConditionTarget, ConditionValue1, ConditionValue2, ConditionValue3, NegativeCondition, ErrorType, ErrorTextId, ScriptName, Comment) VALUES 
('26', '7341', '7502', '0', '0', '47', '0', '40384', '74', '0', '0', '0', '0', '', 'hunter phase 7341 on quest 40384  taken,  complete and  rewarded'); 

REPLACE INTO `phase_area` (`AreaId`, `PhaseId`, `Comment`) VALUES (7502, 6764, 'PHASE 6764- CONDITION_QUESTSTATE'); 
Replace INTO conditions (SourceTypeOrReferenceId, SourceGroup, SourceEntry, SourceId, ElseGroup, ConditionTypeOrReference, ConditionTarget, ConditionValue1, ConditionValue2, ConditionValue3, NegativeCondition, ErrorType, ErrorTextId, ScriptName, Comment) VALUES 
('26', '6764', '7502', '0', '0', '47', '0', '41415', '10', '0', '0', '0', '0', '', 'hunter phase 6764 on quest 41415 taken,complete'),
('26', '6764', '7502', '0', '0', '47', '0', '41415', '64', '0', '1', '0', '0', '', 'hunter cancel phase 6764 on quest 41415 rewarded'); 

REPLACE INTO `phase_area` (`AreaId`, `PhaseId`, `Comment`) VALUES (7502, 6763, 'PHASE 6763- CONDITION_QUESTSTATE'); 
DELETE FROM conditions WHERE (SourceTypeOrReferenceId = 26) AND (ConditionTypeOrReference =47) AND (SourceGroup =6763) AND (SourceEntry =7502) AND (ConditionValue1 =41540); 
INSERT INTO conditions (SourceTypeOrReferenceId, SourceGroup, SourceEntry, SourceId, ElseGroup, ConditionTypeOrReference, ConditionTarget, ConditionValue1, ConditionValue2, ConditionValue3, NegativeCondition, ErrorType, ErrorTextId, ScriptName, Comment) VALUES 
('26', '6763', '7502', '0', '0', '47', '0', '41540', '74', '0', '0', '0', '0', '', 'hunter phase 6763 on quest 41540 taken complete');