-- Quest 13561 "Solace for the Highborne"
-- DB: https://www.wowhead.com/quest=13561/solace-for-the-highborne
-- Core: TrinityCore 7.3.5
-- Author: Belkir (dvor-net.ptz@mail.ru)
-- Date: 02.10.2019


-- Quest state (player go reward)
DELETE FROM `quest_offer_reward` WHERE `ID` = 13561;

INSERT INTO `quest_offer_reward`
(
	`ID`,
	`Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`,
	`RewardText`,
	`VerifiedBuild`
)
VALUES
(
	13561,
	1, 0, 0, 0, 0, 0, 0, 0,
	'You have my thanks. Though they may not be able to show it, you have the thanks of the Highborne spirits as well.$B$BFare safely, traveler.',
	26972
);


DELETE FROM `quest_offer_reward_locale` WHERE `ID` = 13561 AND `locale` = 'ruRU';

INSERT INTO `quest_offer_reward_locale`
(
	`ID`,
	`locale`,
	`RewardText`,
	`VerifiedBuild`
)
VALUES
(
	13561,
	'ruRU',
	'Спасибо, $N, и знай, что души высокорожденных тоже тебе благодарны, хотя и не могут это высказать.$B$BДа будет безопасной твоя дорога, путешественник.',
	26972
);