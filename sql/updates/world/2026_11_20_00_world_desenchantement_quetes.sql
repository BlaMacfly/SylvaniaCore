-- Quetes d enchantement de Legion (Volte-face et traitrise, etc.) : la rune ou le sigil se desenchante
-- d apres une table indexee sur l objet lui-meme (ITEM_FLAG2_DISENCHANT_TO_LOOT_TABLE). Lignes de LegionCore.
DELETE FROM `disenchant_loot_template` WHERE `Entry` IN (137195,137221,137286);
INSERT INTO `disenchant_loot_template` (`Entry`,`Item`,`Reference`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(137195,137196,0,100,0,1,0,1,1,'Highmountain Armor - Thunder Dust'),
(137221,137213,0,100,0,1,0,1,1,'Enchanted Raven Sigil - Raven Dust'),
(137286,129751,0,100,0,1,0,1,1,'Fel-Crusted Rune - Dust of Foul Lies');
