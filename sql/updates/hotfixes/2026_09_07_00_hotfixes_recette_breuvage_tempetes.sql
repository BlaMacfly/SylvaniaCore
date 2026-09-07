-- Objet 133995 "Recette du breuvage des tempetes" : enregistrement DB2 custom.
--
-- La quete 41039 "Un savoir vole" (Suramar) exige cet objet, lache par Morjirn (102852).
-- L'objet existe dans Item.db2 mais PAS dans ItemSparse.db2 : le core ne construit un
-- ItemTemplate que si les deux sont presents (ObjectMgr::LoadItemTemplates), donc le
-- serveur l'ignorait et rejetait toute ligne de butin le referencant :
--   Table 'creature_loot_template' Entry 102852 Item 133995: item entry not listed
--   in `item_template` - skipped
-- Verifie : 104 011 ItemTemplate charges pour 103 967 enregistrements ItemSparse, donc
-- le fichier est bien lu en entier et l'objet en est reellement absent.
--
-- Methode : ligne dans la table miroir + ligne hotfix_data (sans quoi l'enregistrement
-- n'existerait que cote serveur) + bump de HotfixCacheVersion pour invalider le cache
-- ADB des clients. TableHash d'ItemSparse.db2 = 0x919BE54E, lu a l'offset 20 de l'en-tete WDC1.
--
-- Nom en francais dans la colonne de base : le serveur ne sert que la locale enUS
-- (DBC.Locale = 0), donc item_sparse_locale ne serait jamais consulte. Le libelle reprend
-- celui de l'objectif de quete traduit : "Recette du breuvage des tempetes".

DELETE FROM `item_sparse` WHERE `ID` = 133995;
INSERT INTO `item_sparse`
  (`ID`,`AllowableRace`,`AllowableClass`,`Display`,`OverallQualityID`,`ItemLevel`,`Stackable`,`MaxCount`,`Bonding`,`ExpansionID`,`VerifiedBuild`)
VALUES
  (133995, -1, -1, 'Recette du breuvage des tempêtes', 1, 1, 1, 1, 4, 6, 0);

DELETE FROM `hotfix_data` WHERE `TableHash` = 2442913102 AND `RecordId` = 133995;
INSERT INTO `hotfix_data` (`Id`,`TableHash`,`RecordId`,`Deleted`) VALUES (391, 2442913102, 133995, 0);
