-- delete spawn of old deprecated npc 3066 - narm-skychaser
DELETE FROM creature where id IN (3066);

-- corect spell 79733 commanding shout for npc 3051 suoervisor fizsproket
UPDATE `smart_scripts` SET `action_param1`='79733' WHERE  `entryorguid`=3051 AND `source_type`=0 AND `id`=0 AND `link`=0;

-- deprecated quests
DELETE FROM `disables` WHERE `sourceType`=1 AND `entry` IN (764, 765);
INSERT INTO `disables` 
(`sourceType`, `entry`, `flags`, `params_0`, `params_1`, `comment`) VALUES 
(1, 764, 0, '', '', 'Deprecated quest: The Venture Co.'),
(1, 765, 0, '', '', 'Deprecated quest: Supervisor Fizsprocket');

-- corect quest sequence from rewarded quest 751 the ravaged crate
UPDATE `quest_template_addon` SET `PrevQuestID`='751' WHERE  `ID`=26179;
UPDATE `quest_template_addon` SET `PrevQuestID`='751' WHERE  `ID`=26180;

DELETE FROM `quest_poi_points` WHERE `QuestID`=751 AND `Idx1`=0 AND `Idx2`=0;
INSERT INTO `quest_poi_points` (`QuestID`, `Idx1`, `Idx2`, `X`, `Y`, `VerifiedBuild`) VALUES 
(751, 0, 0, -2364, -905, 22908);

-- wrongly spawned gob 186265 kyle's lunch
DELETE FROM `gameobject` WHERE `id` IN (186265);

