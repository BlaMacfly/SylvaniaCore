-- Butin manquant : mobs des quetes d'acces a Draenor (Terres foudroyees 6.0 + Tanaan).
--
-- Signalement joueur du 05/09/2026 : "les mobs lachent rien comme loot".
-- 26 especes hostiles de ces deux zones avaient lootid = 0, soit aucun butin du tout,
-- alors que leurs voisines immediates (Fourrageur, Legionnaire, Pillard...) ont la leur.
--
-- Taux releves un par un sur Wowhead (page rendue puis donnees Listview, methode validee
-- en recoupant deux PNJ dont les chiffres avaient d'abord ete lus a l'ecran).
-- Les objets post-Legion listes par Wowhead (Besaces et Potions mysterieuses, ids 235xxx
-- et 236xxx) sont volontairement ecartes : ils n'existent pas dans notre version.
--
-- 9 des 26 especes n'ont legitimement aucun butin sur Wowhead non plus et ne sont pas
-- touchees : Ame tourmentee (82647), Loup du Vide (82373), Demolisseur de fer (82298),
-- Gronnling de fer (82484), Lieutenant Asalra (76448), Keli'dan le Briseur (79702),
-- Ankova la Dechue (79593), Bagarreur de la Main brisee (82057), et le Sauvage Ombresanglante
-- (78820), dont le seul objet liste (110444) n'est rattache a aucune quete chez nous.

DELETE FROM `creature_loot_template` WHERE `Entry` IN (76556,76886,78345,78489,78674,78348,78670,77653,82774,77767,76651,78488,77790,77771,77845,78696,82451);
INSERT INTO `creature_loot_template`
  (`Entry`,`Item`,`Reference`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(76556,112463,0,76.6200,0,1,0,1,1,'Ironmarch Grunt'),
(76556,112684,0,31.1900,0,1,0,1,1,'Ironmarch Grunt'),
(76556,118675,0,0.4100,0,1,0,1,1,'Ironmarch Grunt'),
(76886,112463,0,76.8200,0,1,0,1,1,'Ironmarch Scout'),
(76886,112684,0,30.5500,0,1,0,1,1,'Ironmarch Scout'),
(76886,118675,0,0.3100,0,1,0,1,1,'Ironmarch Scout'),
(78345,112463,0,77.6600,0,1,0,1,1,'Dreadmaul Crusher'),
(78345,112684,0,29.1100,0,1,0,1,1,'Dreadmaul Crusher'),
(78345,81194,0,0.7700,0,1,0,1,1,'Dreadmaul Crusher'),
(78345,118675,0,0.2300,0,1,0,1,1,'Dreadmaul Crusher'),
(78345,81212,0,0.0200,0,1,0,1,1,'Dreadmaul Crusher'),
(78489,81194,0,94.0100,0,1,0,1,1,'Snickerfang Pup'),
(78489,81212,0,6.0000,0,1,0,1,1,'Snickerfang Pup'),
(78489,112463,0,0.2000,0,1,0,1,1,'Snickerfang Pup'),
(78674,112463,0,99.7200,0,1,0,1,1,'Ironmarch Scorcher'),
(78674,112684,0,37.2400,0,1,0,1,1,'Ironmarch Scorcher'),
(78674,44754,0,0.0300,0,1,0,1,1,'Ironmarch Scorcher'),
(78674,118675,0,0.0200,0,1,0,1,1,'Ironmarch Scorcher'),
(78348,112463,0,76.2600,0,1,0,1,1,'Dreadmaul Flamebelcher'),
(78348,112684,0,32.1200,0,1,0,1,1,'Dreadmaul Flamebelcher'),
(78348,118675,0,0.1700,0,1,0,1,1,'Dreadmaul Flamebelcher'),
(78348,81212,0,0.0600,0,1,0,1,1,'Dreadmaul Flamebelcher'),
(78670,112463,0,99.7500,0,1,0,1,1,'Ironmarch Warcaster'),
(78670,112684,0,38.0700,0,1,0,1,1,'Ironmarch Warcaster'),
(78670,118675,0,0.2300,0,1,0,1,1,'Ironmarch Warcaster'),
(77653,112463,0,75.1500,0,1,0,1,1,'Ironmarch Warsmith'),
(77653,112684,0,31.4200,0,1,0,1,1,'Ironmarch Warsmith'),
(77653,118675,0,0.2600,0,1,0,1,1,'Ironmarch Warsmith'),
(82774,112463,0,76.6000,0,1,0,1,1,'Ironmarch Executioner'),
(82774,112684,0,31.0100,0,1,0,1,1,'Ironmarch Executioner'),
(82774,118675,0,0.2400,0,1,0,1,1,'Ironmarch Executioner'),
(82774,2295,0,0.0400,0,1,0,1,1,'Ironmarch Executioner'),
(82774,10593,0,0.0100,0,1,0,1,1,'Ironmarch Executioner'),
(77767,112463,0,77.9300,0,1,0,1,1,'Ironmarch Shaman'),
(77767,112684,0,29.9700,0,1,0,1,1,'Ironmarch Shaman'),
(77767,118675,0,0.2200,0,1,0,1,1,'Ironmarch Shaman'),
(76651,112463,0,78.8100,0,1,0,1,1,'Ironmarch Leadspitter'),
(76651,112684,0,28.9600,0,1,0,1,1,'Ironmarch Leadspitter'),
(78488,112463,0,74.4000,0,1,0,1,1,'Dreadmaul Packmaster'),
(78488,112684,0,30.9600,0,1,0,1,1,'Dreadmaul Packmaster'),
(78488,81194,0,3.9900,0,1,0,1,1,'Dreadmaul Packmaster'),
(78488,81212,0,1.8800,0,1,0,1,1,'Dreadmaul Packmaster'),
(78488,118675,0,0.2200,0,1,0,1,1,'Dreadmaul Packmaster'),
(77790,112463,0,77.4700,0,1,0,1,1,'Ironmarch Raider'),
(77790,112684,0,31.6200,0,1,0,1,1,'Ironmarch Raider'),
(77771,112463,0,77.4700,0,1,0,1,1,'Dreadmaul Destroyer'),
(77771,112684,0,28.6900,0,1,0,1,1,'Dreadmaul Destroyer'),
(77845,106870,0,88.0300,0,1,0,1,1,'Ironmarch War Wolf'),
(77845,106889,0,9.7600,0,1,0,1,1,'Ironmarch War Wolf'),
(77845,106873,0,2.0200,0,1,0,1,1,'Ironmarch War Wolf'),
(78696,112463,0,99.4700,0,1,0,1,1,'Ironmarch Champion'),
(78696,112684,0,41.2500,0,1,0,1,1,'Ironmarch Champion'),
(82451,112463,0,99.6100,0,1,0,1,1,'Toothsmash the Annihilator'),
(82451,112684,0,38.3200,0,1,0,1,1,'Toothsmash the Annihilator');

UPDATE `creature_template` SET `lootid` = `entry` WHERE `entry` IN (76556,76886,78345,78489,78674,78348,78670,77653,82774,77767,76651,78488,77790,77771,77845,78696,82451);
