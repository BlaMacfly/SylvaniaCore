-- A JOUER SERVEUR ARRETE (base personnages).
-- Wissmerill (339) a rendu « 38946 » avant que « Un jeu d'enfant... non ? » (38945) ne soit exigee (PrevQuestID pose le 23/11).
-- 38945 a RewardNextQuest=38946 : le core cache une quete dont la suite est deja faite (SatisfyQuestNextChain),
-- donc Tanithria ne la lui propose plus jamais. On retire 38946 des quetes rendues : 38945 redevient proposee,
-- puis 38946 (qui ne donne que de l'experience) sera a refaire.
DELETE FROM `character_queststatus_rewarded` WHERE `guid`=339 AND `quest`=38946;
