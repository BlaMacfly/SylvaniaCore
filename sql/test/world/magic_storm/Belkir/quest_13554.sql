-- Quest 13554 "A Cure In The Dark"
-- DB: https://www.wowhead.com/quest=13554/a-cure-in-the-dark
-- Core: TrinityCore 7.3.5
-- Author: Belkir (dvor-net.ptz@mail.ru)
-- Date: 01.10.2019



-- Quest state (player has items)
DELETE FROM `quest_request_items` WHERE `ID` = 13554;

INSERT INTO `quest_request_items`
(
	`ID`,
	`EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`,
	`CompletionText`,
	`VerifiedBuild`
)
VALUES
(
	13554,
	3, 0, 0, 0,
	'Did you get to the stuff? The sooner I can start working on a cure, the more animals we can save!',
	26972
);



DELETE FROM `quest_request_items_locale` WHERE `ID` = 13554 AND `locale` = 'ruRU';

INSERT INTO `quest_request_items_locale`
(
	`ID`,
	`locale`,
	`CompletionText`,
	`VerifiedBuild`
)
VALUES
(
	13554,
	'ruRU',
	'Ты принес образцы? Чем раньше я приступлю к исследованиям – тем больше животных мы сможем спасти!',
	26972
);



-- Quest state (player go reward)
DELETE FROM `quest_offer_reward` WHERE `ID` = 13554;

INSERT INTO `quest_offer_reward`
(
	`ID`,
	`Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`,
	`RewardText`,
	`VerifiedBuild`
)
VALUES
(
	13554,
	5, 0, 0, 0, 0, 0, 0, 0,
	'This should be plenty! Thanks so much! I\'ll get working on a cure for this nastiness immediately.',
	26972
);


DELETE FROM `quest_offer_reward_locale` WHERE `ID` = 13554 AND `locale` = 'ruRU';

INSERT INTO `quest_offer_reward_locale`
(
	`ID`,
	`locale`,
	`RewardText`,
	`VerifiedBuild`
)
VALUES
(
	13554,
	'ruRU',
	'Этого вполне хватит! Спасибо тебе огромное! Я немедленно займусь изготовлением лекарства.',
	26972
);