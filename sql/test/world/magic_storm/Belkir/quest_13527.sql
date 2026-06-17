-- Quest 13527 "No Accounting for Taste"
-- DB: https://www.wowhead.com/quest=13527/no-accounting-for-taste#videos
-- Core: TrinityCore 7.3.5
-- Author: Belkir (dvor-net.ptz@mail.ru)
-- Date: 01.10.2019


-- Quest state (player has items)
DELETE FROM `quest_request_items` WHERE `ID` = 13527;

INSERT INTO `quest_request_items`
(
	`ID`,
	`EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`,
	`CompletionText`,
	`VerifiedBuild`
)
VALUES
(
	13527,
	6, 0, 0, 0,
	'Welcome back! Did you find that bear sample that I was looking for?',
	26972
);


DELETE FROM `quest_request_items_locale` WHERE `ID` = 13527 AND `locale` = 'ruRU';

INSERT INTO `quest_request_items_locale`
(
	`ID`,
	`locale`,
	`CompletionText`,
	`VerifiedBuild`
)
VALUES
(
	13527,
	'ruRU',
	'Добро пожаловать обратно! Ты нашел образец медвежьей плоти?',
	26972
);


-- Quest state (player go reward)
DELETE FROM `quest_offer_reward` WHERE `ID` = 13527;

INSERT INTO `quest_offer_reward`
(
	`ID`,
	`Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`,
	`RewardText`,
	`VerifiedBuild`
)
VALUES
(
	13527,
	1, 0, 0, 0, 0, 0, 0, 0,
	'This definitely looks like the stuff they were eating. Let me take a closer peek...',
	26972
);


DELETE FROM `quest_offer_reward_locale` WHERE `ID` = 13527 AND `locale` = 'ruRU';

INSERT INTO `quest_offer_reward_locale`
(
	`ID`,
	`locale`,
	`RewardText`,
	`VerifiedBuild`
)
VALUES
(
	13527,
	'ruRU',
	'Да, это похоже на то, чем они питаются. Дай-ка мне взглянуть поближе...',
	26972
);

