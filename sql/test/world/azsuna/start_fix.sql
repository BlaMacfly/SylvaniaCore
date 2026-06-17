UPDATE `quest_template_addon` SET `PrevQuestID`=39718 WHERE `ID`=41220; 
UPDATE `quest_template_addon` SET `PrevQuestID`=39874 WHERE `ID`=39875;   
UPDATE `quest_template_addon` SET `PrevQuestID`=39875 WHERE `ID`=39876;   
UPDATE `quest_template_addon` SET `PrevQuestID`=39876 WHERE `ID`=39877;   
UPDATE `quest_template_addon` SET `PrevQuestID`=40048 WHERE `ID`=39878;
UPDATE `quest_template_addon` SET `PrevQuestID`=42567 WHERE `ID`=42756;
UPDATE `quest_template_addon` SET `PrevQuestID`=38443 WHERE `ID`=37853;



REPLACE INTO `phase_area` (`AreaId`, `PhaseId`, `Comment`) VALUES (7502, 7302, 'PHASE 6764- CONDITION_QUESTSTATE'); 
REPLACE INTO conditions (SourceTypeOrReferenceId, SourceGroup, SourceEntry, SourceId, ElseGroup, ConditionTypeOrReference, ConditionTarget, ConditionValue1, ConditionValue2, ConditionValue3, NegativeCondition, ErrorType, ErrorTextId, ScriptName, Comment) VALUES 
('26', '7302', '7502', '0', '0', '47', '0', '39718', '10', '0', '0', '0', '0', '', 'phase 7302 on quest 39718 taken,complete'),
('26', '7302', '7502', '0', '0', '47', '0', '39718', '64', '0', '1', '0', '0', '', 'cancel phase 7302 on quest 42815 rewarded'); 


REPLACE INTO `phase_area` (`AreaId`, `PhaseId`, `Comment`) VALUES (7502, 7302, 'PHASE 6764- CONDITION_QUESTSTATE'); 
REPLACE INTO conditions (SourceTypeOrReferenceId, SourceGroup, SourceEntry, SourceId, ElseGroup, ConditionTypeOrReference, ConditionTarget, ConditionValue1, ConditionValue2, ConditionValue3, NegativeCondition, ErrorType, ErrorTextId, ScriptName, Comment) VALUES 
('26', '7302', '7502', '0', '0', '47', '0', '42815', '10', '0', '0', '0', '0', '', 'phase 7302 on quest 42815 taken,complete'),
('26', '7302', '7502', '0', '0', '47', '0', '42815', '64', '0', '1', '0', '0', '', 'cancel phase 7302 on quest 42815 rewarded'); 

UPDATE `creature` SET `zoneId`=7505, `areaId`=7502, `PhaseId`=7302 WHERE `guid`=20544383;



