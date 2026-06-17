-- Quest 13596 "Twilight Plans"
-- DB: https://www.wowhead.com/quest=13596/twilight-plans
-- Core: TrinityCore 7.3.5
-- Author: Belkir (dvor-net.ptz@mail.ru)
-- Date: 03.10.2019


-- Quest state (player has items)
DELETE FROM `quest_request_items` WHERE `ID` = 13596;

INSERT INTO `quest_request_items`
(
	`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`,
	`CompletionText`,
	`VerifiedBuild`
)
VALUES
(
	13596, 0, 0, 0, 0,
	'Have you obtained the plans yet, $N?',
	26972
);


DELETE FROM `quest_request_items_locale` WHERE `ID` = 13596 AND `locale` = 'ruRU';

INSERT INTO `quest_request_items_locale`
(
	`ID`,
	`locale`,
	`CompletionText`,
	`VerifiedBuild`
)
VALUES
(
	13596,
	'ruRU',
	'Планы уже у тебя в руках, $N?',
	26972
);


-- Quest state (player go reward)
DELETE FROM `quest_offer_reward` WHERE `ID` = 13596;

INSERT INTO `quest_offer_reward`
(
	`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`,
	`RewardText`,
	`VerifiedBuild`
)
VALUES
(
	13596, 0, 0, 0, 0, 0, 0, 0, 0,
	'Excellent job, $N. Now give me a moment to examine the plans you\'ve brought me.',
	26972
);


DELETE FROM `quest_offer_reward_locale` WHERE `ID` = 13596 AND `locale` = 'ruRU';

INSERT INTO `quest_offer_reward_locale`
(
	`ID`,
	`locale`,
	`RewardText`,
	`VerifiedBuild`
)
VALUES
(
	13596,
	'ruRU',
	'Молодец, $N. А теперь дай-ка мне взглянуть на эти планы...',
	26972
);