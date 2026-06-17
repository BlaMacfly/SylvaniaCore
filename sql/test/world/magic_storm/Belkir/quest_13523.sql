-- Quest 13523 "Power Over the Tides"
-- DB: https://www.wowhead.com/quest=13523/power-over-the-tides
-- Core: TrinityCore 7.3.5
-- Author: Belkir (dvor-net.ptz@mail.ru)
-- Date: 02.10.2019


-- Delete summonable creature in area
-- https://www.wowhead.com/npc=32937/tranquil-tidal-spirit
DELETE FROM `creature` WHERE `id` = 32937 AND `zoneId` = 148 AND `areaId` = 452;

-- Quest state (player go reward)
DELETE FROM `quest_offer_reward` WHERE `ID` = 13523;

INSERT INTO `quest_offer_reward`
(
	`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`,
	`RewardText`,
	`VerifiedBuild`
)
VALUES
(
	13523, 0, 0, 0, 0, 0, 0, 0, 0,
	'You\'ve succeeded... it hasn\'t all been in vain...$B$BMy time approaches.  Go now, $N, and may Elune protect you.',
	26972
);


DELETE FROM `quest_offer_reward_locale` WHERE `ID` = 13523 AND `locale` = 'ruRU';

INSERT INTO `quest_offer_reward_locale`
(
	`ID`,
	`locale`,
	`RewardText`,
	`VerifiedBuild`
)
VALUES
(
	13523,
	'ruRU',
	'Ты преуспел... Значит, все было не напрасно.$B$BМое время пришло. Теперь ступай, $N, и пусть Элуна хранит тебя.',
	26972
);