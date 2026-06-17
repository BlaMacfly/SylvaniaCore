-- fix - pinned down quest completion text
DELETE FROM `quest_offer_reward` WHERE `ID`=27670;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (27670, 1, 0, 0, 0, 0, 0, 0, 0, 'Well done, $n. My men can take it from here. Let\'s focus on getting the other survivors out now.', 0);

-- fix - pinned down quest completion text
DELETE FROM `quest_offer_reward` WHERE `ID`=28167;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (28167, 1, 0, 0, 0, 0, 0, 0, 0, 'Did Nevin send you ahead? That means he\'s getting ready to end the mission, but there are still survivors to be rescued. We have to help them!', 0);

-- fix - see to the survivors completion text
DELETE FROM `quest_offer_reward` WHERE `ID`=27671;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (27671, 1, 0, 0, 0, 0, 0, 0, 0, 'I know Nevin will be pleased with all the survivors you managed to help. I still can\'t believe you managed to stay so strong down here in the radiation. You\'ve seen the shape the other survivors are in.

Let\'s get you to the loading room for decontamination.', 0);

-- fix - widraw to the loading room completion text
DELETE FROM `quest_offer_reward` WHERE `ID`=28169;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (28169, 1, 0, 0, 0, 0, 0, 0, 0, 'It\'s good to meet you, $c. We rarely come across survivors as strong and capable as you are. I can help get you decontaminated and on your way out of here.', 0);

-- fix - decontamination completion text
DELETE FROM `quest_offer_reward` WHERE `ID`=27635;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (27635, 1, 0, 0, 0, 0, 0, 0, 0, 'There, now you\'re fit to head off to the surface and start your new life. The High Tinker will be delighted to hear of your arrival.', 0);

-- fix - to the surface completion text
DELETE FROM `quest_offer_reward` WHERE `ID`=27674;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (27674, 1, 0, 0, 0, 0, 0, 0, 0, 'It\'s good to see you again, $n. Without your help, we wouldn\'t have been able to get so many survivors out of Gnomeregan this time. Everyone is going to be thrilled to meet you and hear your story.', 0);

-- fix - the future of gnomeregan completion text
DELETE FROM `quest_offer_reward` WHERE `ID`=26197;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (26197, 1, 0, 0, 0, 0, 0, 0, 0, '$n, isn\'t it? It\'s a pleasure to finally meet you. While you were getting cleaned up, Nevin\'s team told me about your escape from Gnomeregan.', 0);
DELETE FROM `quest_offer_reward` WHERE `ID`=26199;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (26199, 1, 0, 0, 0, 0, 0, 0, 0, 'It\'s good to meet you, $n. I\'m sure your time in Gnomeregan afforded you ample opportunity to practice your arts. Things are somewhat safer here, but your talents will never go to waste.', 0);
DELETE FROM `quest_offer_reward` WHERE `ID`=26202;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (26202, 1, 0, 0, 0, 0, 0, 0, 0, 'So, another one of Nevin\'s "rescued" survivors, eh? More than likely, you saved his life from the troggs down there. Did he stumble over his words when he mentioned me? The man has a healthy respect for the demonic powers we channel.', 0);
DELETE FROM `quest_offer_reward` WHERE `ID`=26203;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (26203, 1, 0, 0, 0, 0, 0, 0, 0, 'For a $r who has spent so much time inside Gnomeregan, you look positively fit and healthy, $n. That\'s good. Before we can complete what Operation: Gnomeregan began, we\'re going to need more warriors like you.', 0);
DELETE FROM `quest_offer_reward` WHERE `ID`=26206;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (26206, 1, 0, 0, 0, 0, 0, 0, 0, 'It\'s good to meet you, $n. Nevin tells me that you managed to survive the dangers in Gnomeregan by using your wits. That\'s exactly what we need up here. Clever minds and quick blades.', 0);
DELETE FROM `quest_offer_reward` WHERE `ID`=31135;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (31135, 1, 0, 0, 0, 0, 0, 0, 0, 'Why, you look great! I\'ve heard bad things about what happens down there.

Well, are you ready to start your training in the ways of the $c?', 0);
DELETE FROM `quest_offer_reward` WHERE `ID`=41217;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (41217, 1, 0, 0, 0, 0, 0, 0, 0, 'For a $r who has spent so much time inside Gnomeregan, you look positively fit and healthy, $n. That\'s good. Before we can complete what Operation: Gnomeregan began, we\'re going to need more hunters like you.', 0);

-- fix - meet the high tinker quest completion text
DELETE FROM `quest_offer_reward` WHERE `ID`=26421;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (26421, 1, 0, 0, 0, 0, 0, 0, 0, 'It\'s good to meet you, $n. You\'ve probably heard others speaking of Operation: Gnomeregan. Let me tell you a bit about what happened and why we left the dwarven city of Ironforge.', 0);
DELETE FROM `quest_offer_reward` WHERE `ID`=26422;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (26422, 1, 0, 0, 0, 0, 0, 0, 0, 'It\'s good to meet you, $n. You\'ve probably heard others speaking of Operation: Gnomeregan. Let me tell you a bit about what happened and why we left the dwarven city of Ironforge.', 0);
DELETE FROM `quest_offer_reward` WHERE `ID`=26423;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (26423, 1, 0, 0, 0, 0, 0, 0, 0, 'It\'s good to meet you, $n. You\'ve probably heard others speaking of Operation: Gnomeregan. Let me tell you a bit about what happened and why we left the dwarven city of Ironforge.', 0);
DELETE FROM `quest_offer_reward` WHERE `ID`=26424;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (26424, 1, 0, 0, 0, 0, 0, 0, 0, 'It\'s good to meet you, $n. You\'ve probably heard others speaking of Operation: Gnomeregan. Let me tell you a bit about what happened and why we left the dwarven city of Ironforge.', 0);
DELETE FROM `quest_offer_reward` WHERE `ID`=26425;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (26425, 1, 0, 0, 0, 0, 0, 0, 0, 'It\'s good to meet you, $n. You\'ve probably heard others speaking of Operation: Gnomeregan. Let me tell you a bit about what happened and why we left the dwarven city of Ironforge.', 0);
DELETE FROM `quest_offer_reward` WHERE `ID`=31137;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (31137, 1, 0, 0, 0, 0, 0, 0, 0, 'It\'s good to meet you, $n. You\'ve probably heard others speaking of Operation: Gnomeregan. Let me tell you a bit about what happened and why we left the dwarven city of Ironforge.', 0);
DELETE FROM `quest_offer_reward` WHERE `ID`=41218;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (41218, 1, 0, 0, 0, 0, 0, 0, 0, 'It\'s good to meet you, $n. You\'ve probably heard others speaking of Operation: Gnomeregan. Let me tell you a bit about what happened and why we left the dwarven city of Ironforge.', 0);

-- fix - the fight continues quest completion text
DELETE FROM `quest_offer_reward` WHERE `ID`=26208;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (26208, 1, 0, 0, 0, 0, 0, 0, 0, 'Even now, only the S.A.F.E. teams dare to venture far into the city to search for survivors. Meanwhile, Thermaplugg has sent one of his followers, Crushcog, to distract us and buy time for him to dig in.', 0);


-- fix - the fight continues quest completion text
DELETE FROM `quest_request_items` WHERE `ID`=26222;
INSERT INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) 
VALUES (26222, 1, 0, 0, 0, 'Did you get those parts?', 0);
DELETE FROM `quest_offer_reward` WHERE `ID`=26222;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (26222, 1, 0, 0, 0, 0, 0, 0, 0, 'These are fantastic! Let\'s see what we can put together. Would you be interested in testing out the prototype once I\'m done?', 0);


DELETE FROM `quest_offer_reward` WHERE `ID`=26205;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (26205, 1, 0, 0, 0, 0, 0, 0, 0, 'Wow, I never expected it to work on the first trial!

Uh, I mean, we\'ve succeeded! I wonder what other uses I we can find for this handy little guy.', 0);