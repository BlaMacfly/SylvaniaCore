-- fix - delete wrong quest ender for furlbrow's deed quest 184
DELETE FROM `creature_questender` WHERE `id`=237 AND `quest`=184;

-- fix - corect texts for the furlbrow's deed quest 184
DELETE FROM `quest_request_items` WHERE `ID`=184;
INSERT INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) 
VALUES (184, 1, 0, 0, 0, 'We don\'t need any civilian vigilante types getting involved, kid. Leave this one to the professionals.', 0);
DELETE FROM `quest_offer_reward` WHERE `ID`=184;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (184, 1,0, 0, 0, 0, 0, 0, 0, 'This is useless. Look at the date on this letter. The Furlbrows have been squatting on the Jansen Steed for five years.

They never could quite get their wagon... fixed.', 0);

-- fix - corect answers for quest heros call westfall 
DELETE FROM `quest_offer_reward` WHERE `ID`=26378;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (26378, 1, 0, 0, 0, 0, 0, 0, 0, 'Murder, rookie. That\'s what you\'re looking at on the ground in front of us.', 0);
DELETE FROM `quest_offer_reward` WHERE `ID`=28562;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (28562, 1, 0, 0, 0, 0, 0, 0, 0, 'Murder, rookie. That\'s what you\'re looking at on the ground in front of us.', 0);