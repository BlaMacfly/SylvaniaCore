DELETE FROM `npc_text` WHERE `ID`=101727;
INSERT INTO `npc_text` (`ID`, `Probability0`, `Probability1`, `Probability2`, `Probability3`, `Probability4`, `Probability5`, `Probability6`, `Probability7`, `BroadcastTextID0`, `BroadcastTextID1`, `BroadcastTextID2`, `BroadcastTextID3`, `BroadcastTextID4`, `BroadcastTextID5`, `BroadcastTextID6`, `BroadcastTextID7`, `VerifiedBuild`) VALUES 
('101727', '0', '0', '0', '0', '0', '0', '0', '0', '101727', '101727', '0', '0', '0', '0', '0', '0', '0');

DELETE FROM `gossip_menu` WHERE `MenuId` IN (1017220);

DELETE FROM `gossip_menu` WHERE `MenuId`=1017220;
INSERT INTO `gossip_menu` (`MenuId`, `TextId`, `VerifiedBuild`) VALUES
('1017220', '101727', '0');

 


DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup = 101722;
INSERT INTO`conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES 
('15', '101722', '0', '0', '1', '47', '0', '40241', '8', '0', '0', '0', '0', '', 'Only see the gossip with quest 40241'),
('15', '101722', '0', '0', '2', '47', '0', '40200', '8', '0', '0', '0', '0', '', 'Only see the gossip with quest 40200');


DELETE FROM `gossip_menu_option` WHERE `MenuId` IN (101722);
INSERT INTO `gossip_menu_option` (`MenuId`, `OptionIndex`, `OptionIcon`, `OptionText`, `OptionBroadcastTextId`, `OptionType`, `OptionNpcFlag`, `VerifiedBuild`) VALUES
(101722, 0, 0, 1, 1, 1017220, 0, 0, 0,"", 101722),
(101722, 1, 1, 3, 128, 0, 0, 0, 0,"", 87415);


UPDATE creature_template SET gossip_menu_id = 101722, npcflag = 131, AIName="SmartAI"  WHERE entry = 98725;
UPDATE creature_template SET gossip_menu_id = 101722, npcflag = 131, AIName="SmartAI"  WHERE entry = 115287;


DELETE FROM `smart_scripts` WHERE `entryorguid` IN (115287,98725);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
('115287', '0', '0', '1', '62', '0', '100', '0', '101722', '0', '0', '0', '', '33', '99199', '0', '0', '0', '0', '0', '7', '0', '0', '0', '0', '0', '0', '0', 'Give Killcredit Quest ID 40241'),
('98725', '0', '0', '1', '62', '0', '100', '0', '101722', '0', '0', '0', '', '33', '99199', '0', '0', '0', '0', '0', '7', '0', '0', '0', '0', '0', '0', '0', 'Give KillCredit Quest ID 40200');
