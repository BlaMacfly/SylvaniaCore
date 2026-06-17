UPDATE `creature_template` SET `npcflag`=`npcflag`|8192 WHERE `entry`=96679;
UPDATE `creature_template` SET `gossip_menu_id`=0 WHERE `entry`=112392;

-- fix QUEST 40077 Phase On Complete
DELETE FROM `phase_area` WHERE `AreaId`=7741 AND `PhaseId`=171 ;
INSERT INTO `phase_area` (`AreaId`, `PhaseId`, `Comment`) VALUES 
(7741, 171, 'Phase 171 until Quest 40077 complete');
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=26 AND `ConditionValue1`=40077;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES 
(26, 169, 7741, 0, 0, 28, 0, 40077, 0, 0, 1, 0, 0, '', 'Phase 169 until Quest 40077 not complete'),
(26, 171, 7741, 0, 0, 28, 0, 40077, 0, 0, 0, 0, 0, '', 'Phase 171 until Quest 40077 complete');

DELETE FROM `creature_addon` WHERE `guid` NOT IN (SELECT `guid` FROM `creature`);
DELETE FROM `gameobject_addon` WHERE `guid` NOT IN (SELECT `guid` FROM `gameobject`);
DELETE FROM `creature_template_addon` WHERE `entry` NOT IN (SELECT `entry` FROM `creature_template`);
DELETE FROM `gameobject_template_addon` WHERE `entry` NOT IN (SELECT `entry` FROM `gameobject_template`);
