-- Scenario 1122 The Mage Hunter: Conjuring (214283, triggered by the ward click 214277) hits the Fel Dampening Ward (LegionCore)
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=214283;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,1,214283,0,0,31,0,3,107939,0,0,0,0,'','Conjuring - Fel Dampening Ward');
