-- Butin de Morjirn (102852) : Recette du breuvage des tempetes, objectif de la quete
-- 41039 "Un savoir vole". Ne peut fonctionner qu'apres le hotfix DB2 creant l'objet
-- 133995 (voir sql/updates/hotfixes/2026_09_07_00) : sans lui le core rejette la ligne.
-- Taux 99,95 % releve sur la fiche PNJ de Wowhead, QuestRequired = 1.
DELETE FROM `creature_loot_template` WHERE `Entry` = 102852 AND `Item` = 133995;
INSERT INTO `creature_loot_template`
  (`Entry`,`Item`,`Reference`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(102852,133995,0,99.9500,1,1,0,1,1,'Morjirn - Recette du breuvage des tempetes (quete 41039)');
UPDATE `creature_template` SET `lootid` = `entry` WHERE `entry` = 102852;
