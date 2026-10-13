-- DB/Quests: Uldum, enchainements de quetes verifies contre Wowhead (Cataclysm Classic) et TDB 7.3.5 / 12.1.
-- Notre core transforme NextQuestID en prerequis de la quete suivante (ObjectMgr::LoadQuests -> prevQuests) :
-- les quatre preludes facultatifs vers Easy Money (27003) en rendaient un obligatoire, et un joueur arrive
-- sans prelude ne pouvait pas commencer Uldum.
UPDATE `quest_template_addon` SET `NextQuestID` = 0 WHERE `ID` IN (28295, 28296, 28557, 28558) AND `NextQuestID` = 27003;
-- Angered Spirits (27943) suit The Desert Fox (27939) ; avec 27928 seulement elle se prenait trop tot.
UPDATE `quest_template_addon` SET `PrevQuestID` = 27939 WHERE `ID` = 27943;
-- The Pit of Scales (27738) n'est donnee que par le vizir Tanotep (46136) ; les Acolytes du soleil (47709) la proposaient aussi.
DELETE FROM `creature_queststarter` WHERE `id` = 47709 AND `quest` = 27738;
