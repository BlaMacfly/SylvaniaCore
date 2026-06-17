-- Quest 13601 "In Aid of the Refugees"
-- DB: https://www.wowhead.com/quest=13601/in-aid-of-the-refugees
-- Core: TrinityCore 7.3.5
-- Author: Belkir (dvor-net.ptz@mail.ru)
-- Date: 03.10.2019


-- Quest state (player go reward)
DELETE FROM `quest_offer_reward` WHERE `ID` = 13601;

INSERT INTO `quest_offer_reward`
(
	`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`,
	`RewardText`,
	`VerifiedBuild`
)
VALUES
(
	13601, 0, 0, 0, 0, 0, 0, 0, 0,
	'I thank you for coming to our assistance.  As you can see, the refugees\' situation is dire.',
	26972
);


DELETE FROM `quest_offer_reward_locale` WHERE `ID` = 13601 AND `locale` = 'ruRU';

INSERT INTO `quest_offer_reward_locale`
(
	`ID`,
	`locale`,
	`RewardText`,
	`VerifiedBuild`
)
VALUES
(
	13601,
	'ruRU',
	'Спасибо за то, что пришел нам на помощь. Как видишь, у выживших беженцев дела плохи.',
	26972
);