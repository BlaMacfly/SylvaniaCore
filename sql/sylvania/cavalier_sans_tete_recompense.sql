-- Cavalier sans tete (donjon d'evenement 285) : pas de butin a la fin du donjon.
-- Base : dc_world. Rejouable. Signalement du 25/10/2026 (le baltring) : « nikel, les 3 phases, le HF
-- est valide aussi, sauf qu'il n'y a pas de loot ».
-- La recompense du donjon passe par la quete 25482 « World Event Dungeon - Headless Horseman » donnee
-- par la recherche de groupe :
-- 1. lfg_dungeon_rewards s'arretait au niveau 85 : rien pour un niveau 110. LegionCore : jusqu'a 110.
-- 2. La quete ne rapportait que 100 cuivres. LegionCore : Citrouille remplie de butin (117392) x1
--    et 148000 cuivres. Le sac 117392 a deja son contenu chez nous (31 lignes : bonbons, masques,
--    balai magique, renes du Cavalier).
DELETE FROM `lfg_dungeon_rewards` WHERE `dungeonId` = 285 AND `maxLevel` = 110;
INSERT INTO `lfg_dungeon_rewards` (`dungeonId`,`maxLevel`,`firstQuestId`,`otherQuestId`) VALUES (285,110,25482,0);
UPDATE `quest_template` SET `RewardItem1` = 117392, `RewardAmount1` = 1, `RewardMoney` = 148000 WHERE `ID` = 25482;
-- Retour arriere :
-- DELETE FROM `lfg_dungeon_rewards` WHERE `dungeonId` = 285 AND `maxLevel` = 110;
-- UPDATE `quest_template` SET `RewardItem1` = 0, `RewardAmount1` = 0, `RewardMoney` = 100 WHERE `ID` = 25482;
