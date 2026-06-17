-- fix - corect texts for quest 37444 inoculation

DELETE FROM `quest_offer_reward` WHERE `ID`=37444;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) 
VALUES (37444, 0, 0, 0, 0, 0, 0, 0, 0, 'With many of the owlkin now inoculated, we can focus on getting out of here and not have to worry about wiping out the owlkin population in the area.$B$BHere, choose from these.  You\'ve done good work, and you deserve to be rewarded!', 0);

DELETE FROM `quest_request_items` WHERE `ID`=37444;
INSERT INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) 
VALUES (37444, 1, 0, 0, 0, 'The more we can do to clear up Nestlewood, the faster Zhanaa can get back to work.', 0);


