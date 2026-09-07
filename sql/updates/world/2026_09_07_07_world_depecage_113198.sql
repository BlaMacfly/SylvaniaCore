-- 113198 "Trapped Thicket Hunter" : bete des Iles Brisees sans table de depecage.
--
-- Son releve Wowhead ne donnait que des materiaux de depecage (124113 Cuir de rochepeau
-- a 100 %, plus trois objets a 12,5 %). Ces objets relevent de skinning_loot_template,
-- pas de creature_loot_template : chez nous 124113 apparait 284 fois en depecage contre
-- 19 fois en butin de cadavre.
--
-- Les 12,5 % correspondent a 1 observation sur 8 : statistiquement sans valeur, ecartes.
-- Le taux retenu pour le Cuir de rochepeau est celui d'une bete Legion comparable deja
-- configuree chez nous (90134 Llothien Grizzly, 99,6779 %, 1 a 2 unites) plutot qu'un
-- 100 % tire d'un echantillon de huit.
DELETE FROM `skinning_loot_template` WHERE `Entry` = 113198;
INSERT INTO `skinning_loot_template`
  (`Entry`,`Item`,`Reference`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(113198,124113,0,99.6779,0,1,0,1,2,'Trapped Thicket Hunter - Cuir de rochepeau');
UPDATE `creature_template` SET `skinloot` = `entry` WHERE `entry` = 113198;
