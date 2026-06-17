
-- reward texts for quests
DELETE FROM `quest_offer_reward` WHERE `ID` IN (28709, 28790, 28711);
INSERT INTO `quest_offer_reward` 
(`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES 
(28709, 0, 0, 0, 0, 0, 0, 0, 0, 'The expedition needs your help, $C.', 12340),
(28790, 0, 0, 0, 0, 0, 0, 0, 0, 'May your sense of honor and duty serve Azeroth well, $C.', 12340),
(28711, 0, 0, 0, 0, 0, 0, 0, 0, 'The Warsong Offensive could use more like you, $C.', 12340);

-- deprecated quests
DELETE FROM `disables` WHERE `sourceType`=1 AND `entry`=11790;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `params_0`, `params_1`, `comment`) VALUES 
(1, 11790, 0, '', '', 'Deprecated quest: Cultists among us');


