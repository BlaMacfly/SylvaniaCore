-- Quest 13831 "A Troubling Prescription"
-- DB: https://www.wowhead.com/quest=13831/a-troubling-prescription
-- Core: TrinityCore 7.3.5
-- Author: Belkir (dvor-net.ptz@mail.ru)
-- Author: Alexkulya (al.kulya@angelic.com)
-- Date: 01.10.2019


-- World object: Disgusting Workbench
DELETE FROM `gameobject_template` WHERE `entry` = 194714;

INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `RequiredLevel`, `AIName`, `ScriptName`, `VerifiedBuild`)
VALUES
(
	194714,
	2, 4391,
	'Disgusting Workbench',
	'', '', '', 0.75, 0, 9610, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	'SmartGameObjectAI', '', 15595
);


DELETE FROM `gameobject_template_locale` WHERE `entry` = 194714 AND `locale` = 'ruRU';

INSERT INTO `gameobject_template_locale`
(`entry`, `locale`, `name`, `castBarCaption`, `unk1`, `VerifiedBuild`)
VALUES
(
	194714,
	'ruRU',
	'Отвратительная рабочая скамья',
	NULL, NULL,
	26972
);


DELETE FROM `smart_scripts` WHERE `entryorguid` = 194714 AND `source_type` = 1;

INSERT INTO `smart_scripts`
(
	`entryorguid`,
	`source_type`,
	`id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`,
	`comment`
)
VALUES
(
	194714,
	1,
	0, 0, 19, 0, 100, 1, 13831, 0, 0, 0, '', 85, 64197, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0,
	'Disgusting Workbench - On Quest Accept (13831) - Invoker Cast Spell (64197)'
);

INSERT INTO `smart_scripts`
(
	`entryorguid`,
	`source_type`,
	`id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`,
	`comment`
)
VALUES
(
	194714,
	1,
	1, 0, 19, 0, 100, 1, 13831, 0, 0, 0, '', 12, 83816, 3, 4000, 0, 0, 0, 8, 0, 0, 0, 6768.38, -695.881, 71.2074, 2.91315,
	'Disgusting Workbench - On Quest Accept (13831) - Summon Creature World Trigger'
);



-- Creature: World trigger
DELETE FROM `creature_template` WHERE `entry` = 83816;

INSERT INTO `creature_template`
(
	`entry`,
	`difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`,
	`name`,
	`femaleName`, `subname`, `TitleAlt`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `HealthScalingExpansion`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `dynamicflags`, `family`, `trainer_type`, `trainer_class`, `trainer_race`, `type`, `type_flags`, `type_flags2`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `VehicleId`, `mingold`, `maxgold`,
	`AIName`,
	`MovementType`, `InhabitType`, `HoverHeight`, `HealthModifier`, `HealthModifierExtra`, `ManaModifier`, `ManaModifierExtra`, `ArmorModifier`, `DamageModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`
)
VALUES
(
	83816,
	0, 0, 0, 0, 0, 1126, 31379, 25942, 0,
	'World Trigger',
	'', '', NULL, '', 0, 1, 1, 5, 0, 0, 35, 0, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 10, 1095763008, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	'SmartAI',
	0, 3, 1, 9, 1, 7, 1, 1, 1, 1, 0, 122, 1, 0, 128, '', 25549
);


DELETE FROM `smart_scripts` WHERE `entryorguid` = 83816 AND `source_type` = 0;

INSERT INTO `smart_scripts`
(
	`entryorguid`,
	`source_type`,
	`id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`,
	`comment`
)
VALUES
(
	83816,
	0,
	0, 0, 63, 0, 100, 1, 0, 0, 0, 0, '', 80, 8381600, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,
	'World Trigger - On Just Summoned - Start Script'
);


DELETE FROM `smart_scripts` WHERE `entryorguid` = 83816*100 AND `source_type` = 9;

INSERT INTO `smart_scripts`
(
	`entryorguid`,
	`source_type`,
	`id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`,
	`comment`
)
VALUES
(
	83816*100,
	9,
	0, 0, 0, 0, 100, 0, 0, 0, 0, 0, '', 11, 64194, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,
	'Disgusting Workbench - On Script - Cast Spell (64194)'
);

INSERT INTO `smart_scripts`
(
	`entryorguid`,
	`source_type`,
	`id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`,
	`comment`
)
VALUES
(
	83816*100,
	9,
	1, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, '', 11, 64196, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,
	'Disgusting Workbench - On Script - Cast Spell (64196)'
);



-- Quest template
DELETE FROM `quest_template` WHERE `ID` = 13831;

INSERT INTO `quest_template` (`ID`, `QuestType`, `QuestLevel`, `MaxScalingLevel`, `QuestPackageID`, `MinLevel`, `QuestSortID`, `QuestInfoID`, `SuggestedGroupNum`, `RewardNextQuest`, `RewardXPDifficulty`, `RewardXPMultiplier`, `RewardMoney`, `RewardMoneyDifficulty`, `RewardMoneyMultiplier`, `RewardBonusMoney`, `RewardDisplaySpell1`, `RewardDisplaySpell2`, `RewardDisplaySpell3`, `RewardSpell`, `RewardHonor`, `RewardKillHonor`, `StartItem`, `RewardArtifactXPDifficulty`, `RewardArtifactXPMultiplier`, `RewardArtifactCategoryID`, `Flags`, `FlagsEx`, `RewardItem1`, `RewardAmount1`, `RewardItem2`, `RewardAmount2`, `RewardItem3`, `RewardAmount3`, `RewardItem4`, `RewardAmount4`, `ItemDrop1`, `ItemDropQuantity1`, `ItemDrop2`, `ItemDropQuantity2`, `ItemDrop3`, `ItemDropQuantity3`, `ItemDrop4`, `ItemDropQuantity4`, `RewardChoiceItemID1`, `RewardChoiceItemQuantity1`, `RewardChoiceItemDisplayID1`, `RewardChoiceItemID2`, `RewardChoiceItemQuantity2`, `RewardChoiceItemDisplayID2`, `RewardChoiceItemID3`, `RewardChoiceItemQuantity3`, `RewardChoiceItemDisplayID3`, `RewardChoiceItemID4`, `RewardChoiceItemQuantity4`, `RewardChoiceItemDisplayID4`, `RewardChoiceItemID5`, `RewardChoiceItemQuantity5`, `RewardChoiceItemDisplayID5`, `RewardChoiceItemID6`, `RewardChoiceItemQuantity6`, `RewardChoiceItemDisplayID6`, `POIContinent`, `POIx`, `POIy`, `POIPriority`, `RewardTitle`, `RewardArenaPoints`, `RewardSkillLineID`, `RewardNumSkillUps`, `PortraitGiver`, `PortraitTurnIn`, `RewardFactionID1`, `RewardFactionValue1`, `RewardFactionOverride1`, `RewardFactionCapIn1`, `RewardFactionID2`, `RewardFactionValue2`, `RewardFactionOverride2`, `RewardFactionCapIn2`, `RewardFactionID3`, `RewardFactionValue3`, `RewardFactionOverride3`, `RewardFactionCapIn3`, `RewardFactionID4`, `RewardFactionValue4`, `RewardFactionOverride4`, `RewardFactionCapIn4`, `RewardFactionID5`, `RewardFactionValue5`, `RewardFactionOverride5`, `RewardFactionCapIn5`, `RewardFactionFlags`, `RewardCurrencyID1`, `RewardCurrencyQty1`, `RewardCurrencyID2`, `RewardCurrencyQty2`, `RewardCurrencyID3`, `RewardCurrencyQty3`, `RewardCurrencyID4`, `RewardCurrencyQty4`, `AcceptedSoundKitID`, `CompleteSoundKitID`, `AreaGroupID`, `TimeAllowed`, `AllowableRaces`, `QuestRewardID`, `Expansion`, `LogTitle`, `LogDescription`, `QuestDescription`, `AreaDescription`, `PortraitGiverText`, `PortraitGiverName`, `PortraitTurnInText`, `PortraitTurnInName`, `QuestCompletionLog`, `VerifiedBuild`)
VALUES
(13831, 2, -1, 60, 0, 10, 148, 0, 0, 0, 5, 1, 350, 5, 1, 960, 0, 0, 0, 0, 0, 0, 45898, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 69, 5, 25000, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 890, 878, 0, 0, 18446744073709551615, 0, 0, 'A Troubling Prescription', 'Deliver the Apothecary\'s notes to Tharnariun Treetender in Lor\'danel.', 'A crude, hastily-assembled apothecary\'s workbench stands here, heaped with scrawled notes and noxious brews. It looks as though the Forsaken have also been studying Foulhoof\'s handiwork. You grab the most important-looking notes and prepare to smash the laboratory before notifying Treetender of your discovery.', '', '', '', '', '', '', 26365);


DELETE FROM `quest_template_locale` WHERE `ID` = 13831 AND `locale` = 'ruRU';

INSERT INTO `quest_template_locale`
(
	`ID`,
	`locale`,
	`LogTitle`,
	`LogDescription`,
	`QuestDescription`, `AreaDescription`, `PortraitGiverText`, `PortraitGiverName`, `PortraitTurnInText`, `PortraitTurnInName`, `QuestCompletionLog`,
	`VerifiedBuild`
)
VALUES
(
	13831,
	'ruRU',
	'Странное предписание',
	'Доставьте записи аптекаря Тарнариуну Исцелителю Деревьев в Лор\'данел.',
	'Неподалеку стоит грубо вытесанная аптекарская скамья, вся заваленная исписанными пергаментами и причудливыми склянками. Похоже, Отрекшиеся также изучали работы Грязного Копыта. Вы хватаете несколько свитков, которые кажутся наиболее важными, и готовитесь разгромить лабораторию. Несомненно, Целителя Деревьев заинтересует ваша находка.',
	'', '', '', '', '', '',
	25549
);


DELETE FROM `quest_template_addon` WHERE `ID` = 13831;

INSERT INTO `quest_template_addon`
(`ID`, `MaxLevel`, `AllowableClasses`, `SourceSpellID`, `PrevQuestID`, `NextQuestID`, `ExclusiveGroup`, `RewardMailTemplateID`, `RewardMailDelay`, `RequiredSkillID`, `RequiredSkillPoints`, `RequiredMinRepFaction`, `RequiredMaxRepFaction`, `RequiredMinRepValue`, `RequiredMaxRepValue`, `ProvidedItemCount`, `SpecialFlags`, `ScriptName`)
VALUES
(13831, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, '');



-- Quest objectives
DELETE FROM `quest_objectives` WHERE `QuestID` = 13831;

INSERT INTO `quest_objectives`
(
	`ID`,
	`QuestID`,
	`Type`,
	`Order`,
	`StorageIndex`,
	`ObjectID`,
	`Amount`,
	`Flags`,
	`Flags2`,
	`ProgressBarWeight`,
	`Description`,
	`VerifiedBuild`
)
VALUES
(
	256013,
	13831,
	1,
	0,
	0,
	45898,
	1,
	0,
	1,
	0,
	'',
	25996
);



-- Quest points
DELETE FROM `quest_poi` WHERE `QuestID` = 13831;

INSERT INTO `quest_poi`
(
	`QuestID`,
	`BlobIndex`,
	`Idx1`,
	`ObjectiveIndex`,
	`QuestObjectiveID`,
	`QuestObjectID`,
	`MapID`,
	`WorldMapAreaId`,
	`Floor`,
	`Priority`,
	`Flags`,
	`WorldEffectID`,
	`PlayerConditionID`,
	`WoDUnk1`,
	`AlwaysAllowMergingBlobs`,
	`VerifiedBuild`
)
VALUES
(
	13831,
	1,
	0,
	-1,
	0,
	0,
	1,
	42,
	0,
	0,
	1,
	0,
	0,
	0,
	0,
	22908
);


DELETE FROM `quest_poi_points` WHERE `QuestID` = 13831;

INSERT INTO `quest_poi_points`
(
	`QuestID`,
	`Idx1`,
	`Idx2`,
	`X`,
	`Y`,
	`VerifiedBuild`
)
VALUES
(
	13831,
	0,
	0,
	7373,
	-289,
	22908
);



-- Quest state (player has items)
DELETE FROM `quest_request_items` WHERE `ID` = 13831;

INSERT INTO `quest_request_items`
(
	`ID`,
	`EmoteOnComplete`,
	`EmoteOnIncomplete`,
	`EmoteOnCompleteDelay`,
	`EmoteOnIncompleteDelay`,
	`CompletionText`,
	`VerifiedBuild`
)
VALUES
(
	13831,
	1,
	0,
	0,
	0,
	'What\'s this? You found something else in the cave?',
	0
);


DELETE FROM `quest_request_items_locale` WHERE `ID` = 13831 AND `locale` = 'ruRU';

INSERT INTO `quest_request_items_locale`
(
	`ID`,
	`locale`,
	`CompletionText`,
	`VerifiedBuild`
)
VALUES
(
	13831,
	'ruRU',
	'Это что? Ты нашел это в пещере?',
	26972
);



-- Quest state (player go reward)
DELETE FROM `quest_offer_reward` WHERE `ID` = 13831;

INSERT INTO `quest_offer_reward`
(
	`ID`,
	`Emote1`,
	`Emote2`,
	`Emote3`,
	`Emote4`,
	`EmoteDelay1`,
	`EmoteDelay2`,
	`EmoteDelay3`,
	`EmoteDelay4`,
	`RewardText`,
	`VerifiedBuild`
)
VALUES
(
	13831,
	6,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	'<Tharnariun Treetender pages through the notes as you relate your story, the lines in his face deepening with concern.>$B$BSo the Forsaken have been studying Foulhoof\'s work? My gut crawls at the thought of what they might have done were they able to weaponize his corruption. You\'ve done well to destroy their work, but this raises deeper concerns. What brought the Forsaken to our doorstep? Are they working with the Shatterspear trolls to our north? Sorrows are heaping upon sorrows, $C. I\'m glad you\'re here.',
	26972
);


DELETE FROM `quest_offer_reward_locale` WHERE `ID` = 13831 AND `locale` = 'ruRU';

INSERT INTO `quest_offer_reward_locale`
(
	`ID`,
	`locale`,
	`RewardText`,
	`VerifiedBuild`
)
VALUES
(
	13831,
	'ruRU',
	'<Тарнариун Исцелитель Деревьев листает записи, одновременно прислушиваясь к вашему рассказу, и лицо его мрачнеет.>$B$BЗначит, Отрекшиеся изучали работы Зенна Грязное Копыто? Страшно подумать, что они смогут натворить, если поставят себе на службу его разработки. Ты правильно поступил, уничтожив все записи... но что привело сюда Отрекшихся? Неужели они и правда как-то связаны с троллями Пронзающего Копья на севере? Беда не приходит одна, $C. Я рад, что ты с нами.',
	26972
);