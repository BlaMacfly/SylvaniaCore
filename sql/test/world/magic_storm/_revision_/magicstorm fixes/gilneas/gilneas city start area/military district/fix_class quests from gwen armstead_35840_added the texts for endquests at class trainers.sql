-- fix - endquest texts for gilneas class trainers, quests given by gwen armstead npc: 35840

DELETE FROM `quest_offer_reward` WHERE `ID`=14277;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (14277, 0, 0, 0, 0, 0, 0, 0, 0, 'A disciple of the arcane always finds a way forward. I\'m glad to see you, $N.', 0);
DELETE FROM `quest_offer_reward` WHERE `ID`=14278;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (14278, 0, 0, 0, 0, 0, 0, 0, 0, 'The Light is with you, $N. It\'s still quite a relief to see you.', 0);
DELETE FROM `quest_offer_reward` WHERE `ID`=14273;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (14273, 0, 0, 0, 0, 0, 0, 0, 0, 'A darkness has descended over our lands. And not our kind of darkness, if you know what I mean.', 0);
DELETE FROM `quest_offer_reward` WHERE `ID`=14275;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (14275, 0, 0, 0, 0, 0, 0, 0, 0, '$N! I knew you had to be around here.', 0);
DELETE FROM `quest_offer_reward` WHERE `ID`=14269;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (14269, 0, 0, 0, 0, 0, 0, 0, 0, 'Oh, hey! There you are!', 0);
DELETE FROM `quest_offer_reward` WHERE `ID`=14272;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (14272, 0, 0, 0, 0, 0, 0, 0, 0, 'Don\'t get ahead of yourself now.  Just remember who taught you everything you know.

And now let\'s see if we can get out of this city with our skins attached.', 0);
DELETE FROM `quest_offer_reward` WHERE `ID`=14280;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (14280, 0, 0, 0, 0, 0, 0, 0, 0, 'We have been blessed today! You are alive and well!', 0);
DELETE FROM `quest_offer_reward` WHERE `ID`=14265;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (14265, 0, 0, 0, 0, 0, 0, 0, 0, '<name>!  Where have you been?
Anyway... it\'s great to see you in one piece.', 0);

-- fix - 35112 king genn greymane endquests texts
DELETE FROM `quest_offer_reward` WHERE `ID`=14291;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (14291, 0, 0, 0, 0, 0, 0, 0, 0, 'You\'ve done well in coming here. If we Gilneans stick together we might yet defeat this terrible enemy.', 0);
DELETE FROM `quest_offer_reward` WHERE `ID`=14290;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (14290, 0, 0, 0, 0, 0, 0, 0, 0, 'You\'ve done well in coming here. If we Gilneans stick together we might yet defeat this terrible enemy.', 0);
DELETE FROM `quest_offer_reward` WHERE `ID`=14289;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (14289, 0, 0, 0, 0, 0, 0, 0, 0, 'You\'ve done well in coming here. If we Gilneans stick together we might yet defeat this terrible enemy.', 0);
DELETE FROM `quest_offer_reward` WHERE `ID`=14288;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (14288, 0, 0, 0, 0, 0, 0, 0, 0, 'You\'ve done well in coming here. If we Gilneans stick together we might yet defeat this terrible enemy.', 0);
DELETE FROM `quest_offer_reward` WHERE `ID`=14287;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (14287, 0, 0, 0, 0, 0, 0, 0, 0, 'You\'ve done well in coming here. If we Gilneans stick together we might yet defeat this terrible enemy.', 0);
DELETE FROM `quest_offer_reward` WHERE `ID`=14286;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (14286, 0, 0, 0, 0, 0, 0, 0, 0, 'You\'ve done well in coming here. If we Gilneans stick together we might yet defeat this terrible enemy.', 0);
DELETE FROM `quest_offer_reward` WHERE `ID`=14285;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (14285, 0, 0, 0, 0, 0, 0, 0, 0, 'You\'ve done well in coming here. If we Gilneans stick together we might yet defeat this terrible enemy.', 0);

