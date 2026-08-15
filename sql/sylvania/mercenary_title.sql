-- =====================================================================
--  Sylvania Legion — Titre custom « Mercenaire » pour les PlayerBots
--  Base : dc_hotfixes
--
--  CharTitles.db2 (7.3.5, build 26972) : 364 enregistrements,
--  ID max = 522, MaskID max = 373. MAX_TITLE_INDEX du core = 384.
--  On prend donc un ID hors plage Blizzard (600) et un MaskID libre (380).
--
--  La ligne hotfix_data est indispensable : c'est elle qui pousse
--  l'enregistrement au client (SMSG_AVAILABLE_HOTFIXES -> CMSG_HOTFIX_REQUEST).
--  TableHash CharTitles = 0x85DF9E8E = 2246024846.
-- =====================================================================

DELETE FROM `char_titles` WHERE `ID` = 600;
INSERT INTO `char_titles` (`ID`, `Name`, `Name1`, `MaskID`, `Flags`, `VerifiedBuild`) VALUES
(600, 'Mercenaire %s', 'Mercenaire %s', 380, 0, 0);

DELETE FROM `hotfix_data` WHERE `TableHash` = 2246024846 AND `RecordId` = 600;
INSERT INTO `hotfix_data` (`TableHash`, `RecordId`, `Deleted`) VALUES
(2246024846, 600, 0);
