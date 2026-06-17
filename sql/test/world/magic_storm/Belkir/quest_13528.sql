-- Quest 13528 "Buzzbox 723"
-- DB: https://www.wowhead.com/quest=13528/buzzbox-723
-- Core: TrinityCore 7.3.5
-- Author: Belkir (dvor-net.ptz@mail.ru)
-- Date: 01.10.2019


-- Quest details
DELETE FROM `quest_details` WHERE `ID` = 13528;

INSERT INTO `quest_details`
(
	`ID`,
	`Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`,
	`VerifiedBuild`
)
VALUES
(
	13528,
	1, 0, 0, 0, 0, 0, 0, 0,
	26972
);



-- Quest state (player has items)
DELETE FROM `quest_request_items` WHERE `ID` = 13528;

INSERT INTO `quest_request_items`
(
	`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`,
	`CompletionText`,
	`VerifiedBuild`
)
VALUES
(
	13528, 0, 0, 0, 0,
	'<Buzzbox 723 hums at you expectantly.>',
	26972
);


DELETE FROM `quest_request_items_locale` WHERE `ID` = 13528 AND `locale` = 'ruRU';

INSERT INTO `quest_request_items_locale`
(
	`ID`,
	`locale`,
	`CompletionText`,
	`VerifiedBuild`
)
VALUES
(
	13528,
	'ruRU',
	'<Жужжалка 723 выжидательно гудит.>',
	26972
);



-- Quest state (player go reward)
DELETE FROM `quest_offer_reward` WHERE `ID` = 13528;

INSERT INTO `quest_offer_reward`
(
	`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`,
	`RewardText`,
	`VerifiedBuild`
)
VALUES
(
	13528, 0, 0, 0, 0, 0, 0, 0, 0,
	'<Static precedes Wizbang\'s distorted voice.>$B$BThe results are coming in now. We should have some information on how the bears contracted this in just a moment.',
	26972
);


DELETE FROM `quest_offer_reward_locale` WHERE `ID` = 13528 AND `locale` = 'ruRU';

INSERT INTO `quest_offer_reward_locale`
(
	`ID`,
	`locale`,
	`RewardText`,
	`VerifiedBuild`
)
VALUES
(
	13528,
	'ruRU',
	'<Среди помех пробивается искаженный голос Бацбаха.>$B$BРезультаты скоро будут готовы. Еще минутка – и мы узнаем, что случилось с этими медведями.',
	26972
);