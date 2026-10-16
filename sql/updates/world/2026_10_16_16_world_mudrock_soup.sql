-- Mudrock Soup and Bugs (1204, Morgan Stern, Theramore) exigeait Morgan Stern 1260, quete DEPRECATED depuis Cataclysm :
-- impossible a prendre. Wowhead : aucun prerequis, premiere quete de sa serie (suivie de « ... and Bugs » 1258).
UPDATE `quest_template_addon` SET `PrevQuestID` = 0 WHERE `ID` = 1204 AND `PrevQuestID` = 1260;
UPDATE `quest_template_addon` SET `NextQuestID` = 0 WHERE `ID` = 1260 AND `NextQuestID` = 1204;
