-- Caches de parangon : la serie 152102-152108 (7.2.5) a ete livree par Blizzard en hotfix, absente des fichiers
-- de notre client 7.3.5 (Item.db2) : le serveur ne la connait pas (« isn't item entry »). On revient a la serie
-- 7.2.0, memes noms et memes caches, presente dans le client. Argus (152922/152923) est dans le client : inchange.
UPDATE `quest_template` SET `RewardItem1` = 146899 WHERE `ID` = 46743 AND `RewardItem1` = 152104; -- Highmountain Supplies
UPDATE `quest_template` SET `RewardItem1` = 146897 WHERE `ID` = 46745 AND `RewardItem1` = 152102; -- Farondis Chest
UPDATE `quest_template` SET `RewardItem1` = 146901 WHERE `ID` = 46746 AND `RewardItem1` = 152106; -- Valarjar Strongbox
UPDATE `quest_template` SET `RewardItem1` = 146898 WHERE `ID` = 46747 AND `RewardItem1` = 152103; -- Dreamweaver Cache
UPDATE `quest_template` SET `RewardItem1` = 146900 WHERE `ID` = 46748 AND `RewardItem1` = 152105; -- Nightfallen Cache
UPDATE `quest_template` SET `RewardItem1` = 146902 WHERE `ID` = 46749 AND `RewardItem1` = 152107; -- Warden's Supply Kit
UPDATE `quest_template` SET `RewardItem1` = 147361 WHERE `ID` = 46777 AND `RewardItem1` = 152108; -- Legionfall Chest

DELETE FROM `item_loot_template` WHERE `Entry` IN (146897, 146898, 146899, 146900, 146901, 146902, 147361);
UPDATE `item_loot_template` SET `Entry` = CASE `Entry`
    WHEN 152102 THEN 146897 WHEN 152103 THEN 146898 WHEN 152104 THEN 146899 WHEN 152105 THEN 146900
    WHEN 152106 THEN 146901 WHEN 152107 THEN 146902 WHEN 152108 THEN 147361 END
WHERE `Entry` IN (152102, 152103, 152104, 152105, 152106, 152107, 152108);

-- 8 objets du butin livres eux aussi par hotfix, inconnus de notre client : retires
DELETE FROM `item_loot_template` WHERE `Entry` IN (146897, 146898, 146899, 146900, 146901, 146902, 147361, 152922, 152923)
    AND `Item` IN (147555, 147563, 147565, 147571, 140495, 152440, 152442, 152446);
