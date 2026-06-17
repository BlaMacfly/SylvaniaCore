-- Quest 13563 "A Love Eternal"
-- DB: https://www.wowhead.com/quest=13563/a-love-eternal
-- Core: TrinityCore 7.3.5
-- Author: Belkir (dvor-net.ptz@mail.ru)
-- Date: 03.10.2019


-- Delete Anaya NPC in LorDanel village
-- backup: INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `dynamicflags`, `ScriptName`, `movementmode`, `VerifiedBuild`) VALUES (308273, 3843, 1, 148, 4659, '0', 0, 0, 0, -1, 1937, 0, 7452.14, -270.897, 12.7761, 1.61559, 300, 3, 0, 5900, 0, 1, 0, 0, 0, 0, 0, '', 0, 0);
DELETE FROM `creature` WHERE `guid` = 308273;


-- Move Kirillian NPC to correct place
DELETE FROM `creature` WHERE `guid` = 245702;

INSERT INTO `creature`
(
	`guid`,
	`id`,
	`map`,
	`zoneId`,
	`areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`,
	`position_x`, `position_y`, `position_z`,
	`orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `dynamicflags`, `ScriptName`, `movementmode`,
	`VerifiedBuild`
)
VALUES
(
	245702,
	32959,
	1,
	148,
	4659, '0', 0, 0, 0, -1, 1757, 0,
	7450.85, -269.189, 12.7064,
	0.0571458, 300, 0, 0, 328, 0, 0, 0, 0, 0, 0, 0, '', 0,
	26972
);


-- Quest state (start and get details)
DELETE FROM `quest_details` WHERE `ID` = 13563;

INSERT INTO `quest_details`
(
	`ID`,
	`Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`,
	`VerifiedBuild`
)
VALUES
(
	13563,
	1, 0, 0, 0, 0, 0, 0, 0,
	26972
);


-- Quest state (player has items)
DELETE FROM `quest_request_items` WHERE `ID` = 13563;

INSERT INTO `quest_request_items`
(
	`ID`,
	`EmoteOnComplete`,
	`EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`,
	`CompletionText`,
	`VerifiedBuild`
)
VALUES
(
	13563,
	1,
	1, 0, 0,
	'I somehow avoided being inflicted with the same toxin that the other survivors now endure. I cannot help but be envious of them to a degree though... living an eternity alone seems not worth living at all.$B$BI miss you so much, Anaya.',
	26972
);


DELETE FROM `quest_request_items_locale` WHERE `ID` = 13563 AND `locale` = 'ruRU';

INSERT INTO `quest_request_items_locale`
(
	`ID`,
	`locale`,
	`CompletionText`,
	`VerifiedBuild`
)
VALUES
(
	13563,
	'ruRU',
	'Мне как-то удалось избежать заражения тем ядом, от которого страдают остальные выжившие. Я ничем не могу помочь им, только позавидовать... лучше уж умереть, чем жить целую вечность в одиночестве.$B$BЯ так скучаю по тебе, Анайя.',
	26972
);


-- Quest state (player go reward)
DELETE FROM `quest_offer_reward` WHERE `ID` = 13563;

INSERT INTO `quest_offer_reward`
(
	`ID`,
	`Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`,
	`RewardText`,
	`VerifiedBuild`
)
VALUES
(
	13563,
	2, 0, 0, 0, 0, 0, 0, 0,
	'Thank you, $N. Perhaps it would have been better... if I had done it myself. But even after these thousands of years, I could not bear to raise my hand against my beloved.$B$BPlease, I would be alone with my grief...',
	26972
);


DELETE FROM `quest_offer_reward_locale` WHERE `ID` = 13563 AND `locale` = 'ruRU';

INSERT INTO `quest_offer_reward_locale`
(
	`ID`,
	`locale`,
	`RewardText`,
	`VerifiedBuild`
)
VALUES
(
	13563,
	'ruRU',
	'Благодарю тебя, $N. Может быть, было бы лучше... если бы я сам это сделал. Но даже после прошедших тысячелетий у меня нет сил поднять руку на свою возлюбленную.$B$BПожалуйста, оставь меня наедине с моим горем...',
	26972
);