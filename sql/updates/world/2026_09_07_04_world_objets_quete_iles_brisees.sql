-- Objets de quete manquants : Iles Brisees.
--
-- Trois objets sont des objectifs de quete reels chez nous (quest_objectives Type 1)
-- et n'existaient dans AUCUNE table de butin du serveur.
--
-- QuestRequired = 1 : le core ne fait tomber l'objet que pour un joueur ayant la quete.
--
-- Taux repris de la fiche PNJ de Wowhead, PAS de la fiche objet : les deux divergent
-- (Gemme pulsatile donnee a 19,66 % cote objet contre 82 % cote PNJ). C'est la fiche
-- PNJ qui est juste, verifiee a l'ecran : 879 421 sur 1 074 500 kills.
--
-- 44748, 46198 et 46236 sont des quetes MONDIALES (QuestType 3, QuestInfoID 109,
-- zone 7543 Rivage brise). Elles n'ont ni donneur ni rendeur par construction : leur
-- butin est desormais correct, mais leur disponibilite depend du systeme de quetes
-- mondiales, qui n'est pas verifie ici.
--
-- 41039 "Un savoir vole" NON TRAITEE. C'est pourtant la seule quete classique du lot,
-- avec donneur et rendeur presents, donc la seule reellement jouable et bloquee. Mais
-- son objet 133995 "Recette de biere de tempete" n'existe pas dans nos donnees : le
-- serveur rejette la ligne au chargement, avec
--   Table 'creature_loot_template' Entry 102852 Item 133995: item entry not listed
--   in `item_template` - skipped
-- L'objet figure dans Item.db2 mais pas dans ItemSparse.db2, et c'est ItemSparse qui
-- compte pour le serveur. Debloquer cette quete demande un enregistrement DB2 custom
-- par hotfix, pas une ligne de butin.
--
-- Non traite egalement : 147430, objectif de la quete 46765. Wowhead le donne sur
-- environ 200 PNJ de tout le jeu, de 0,01 a 100 pour cent : c'est un butin mondial,
-- qui releve d'une table de reference et non d'une ligne par creature.

DELETE FROM `creature_loot_template` WHERE (`Entry`,`Item`) IN ((115054,142079),(118943,144362),(119139,147396));
INSERT INTO `creature_loot_template`
  (`Entry`,`Item`,`Reference`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(115054,142079,0,24.8100,1,1,0,1,1,'Wyrmtongue Scavenger - Ravitaillement naufrage (quete mondiale 44748)'),
(118943,144362,0,81.8600,1,1,0,1,1,'Felborne Abjurer - Gemme pulsatile (quete mondiale 46198)'),
(119139,147396,0,61.9000,1,1,0,1,1,'Stoneblood Basilisk - Oeil de basilic (quete mondiale 46236)');
