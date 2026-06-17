-- Quest 13519 "The Twilight's Hammer"
-- DB: https://www.wowhead.com/quest=13519/the-twilights-hammer
-- Core: TrinityCore 7.3.5
-- Author: Belkir (dvor-net.ptz@mail.ru)
-- Date: 03.10.2019


-- Quest state (player go reward)
DELETE FROM `quest_offer_reward` WHERE `ID` = 13519;

INSERT INTO `quest_offer_reward`
(
	`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`,
	`RewardText`,
	`VerifiedBuild`
)
VALUES
(
	13519, 0, 0, 0, 0, 0, 0, 0, 0,
	'You\'ve done well, $N. The Twilight\'s Hammer is a dangerous cult. It would be foolish to underestimate the danger they represent.',
	26972
);


DELETE FROM `quest_offer_reward_locale` WHERE `ID` = 13519 AND `locale` = 'ruRU';

INSERT INTO `quest_offer_reward_locale`
(
	`ID`,
	`locale`,
	`RewardText`,
	`VerifiedBuild`
)
VALUES
(
	13519,
	'ruRU',
	'Ты все сделал правильно, $N. Культ Сумеречного Молота – опасная секта, и ее нельзя недооценивать.',
	26972
);