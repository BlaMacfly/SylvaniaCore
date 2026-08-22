-- =====================================================================
-- Zone de départ Chasseur de démons — butin comparé au butin officiel
--
-- Méthode : les tables `creature_loot_template` des 17 créatures tuables
-- de Mardum (1481) et du Caveau des Gardiennes (1468) ont été comparées
-- une à une aux tables de butin de Wowhead, relevées sur les pages PNJ
-- elles-mêmes (les données de butin y sont rendues en JavaScript : ni
-- curl — 403 — ni un simple export de page ne les voit).
--
-- CE QUI ÉTAIT DÉJÀ CONFORME
-- Le menu fretin de Mardum n'a aucune table de butin, et c'est CORRECT :
-- Foul Felstalker, Dread Felbat, Legion Razorwing, Hellish Imp, Wrath
-- Warrior, Queen's Centurion, Ash'golm et Questioner Arev'naal ne lâchent
-- officiellement RIEN. Aucune correction de ce côté.
-- Les tables des créatures qui en ont une contiennent bien les bons
-- objets ; il n'y avait aucun objet en trop.
--
-- CE QUI MANQUAIT
--   132753 « Rations de la Légion » — absente de TOUTES les tables de la
--           zone, et même des 46 000 lignes de butin du serveur entier.
--           Wowhead la donne sur 14 des 17 créatures, entre 1,4 et 3,1 %.
--   129196 « Pierre de soin de la Légion » — déjà présente 28 fois
--           ailleurs, mais oubliée sur quatre créatures.
--   147430 « Parchemin runique mystérieux » — objet de la 7.3, jamais
--           référencé sur le serveur. Taux officiel 0,01 à 0,02 %.
--   132138 « Cendres gangrenées radieuses » — oubliée sur l'Éclat abyssal.
--   93105 Inquisiteur Funeste n'avait qu'UNE SEULE ligne sur les huit.
--
-- CE QUI A ÉTÉ ÉCARTÉ VOLONTAIREMENT
--   * Les objets 235052, 235911, 236854, 236856, 236857 et 236870, que
--     Wowhead attribue à ces mêmes créatures : leurs identifiants sont
--     très au-dessus de la plage de Legion, ils viennent d'extensions
--     postérieures et n'existent pas dans un client 7.3.5.
--   * 129888 et 134819 sur le Sombrepiste sauvage : taux officiel
--     inférieur à 0,005 %, sous le seuil du bruit statistique.
--   * Les TAUX des lignes déjà présentes n'ont PAS été touchés, même
--     lorsqu'ils s'écartent de Wowhead (le plus gros écart : Kethrazor,
--     128945 à 70 % chez nous contre 95 % chez Wowhead). Les
--     pourcentages de Wowhead sont une moyenne de relevés joueurs sur
--     toute l'extension, pas une donnée serveur ; les nôtres semblent
--     issus de captures. Réaligner l'ensemble serait un choix de
--     réglage, pas une correction de bug — à décider séparément.
--
-- Les taux ci-dessous sont ceux de Wowhead. `lootid` vaut l'entrée de la
-- créature pour les 17 concernées.
-- Rechargeable à chaud : reload creature_loot_template
-- =====================================================================

-- --- 132753 Rations de la Légion ---------------------------------------
DELETE FROM `creature_loot_template` WHERE `Item`=132753 AND `Entry` IN
 (97058,97057,97370,96997,97069,98986,98497,93221,93105,93802,92776,97225,96682,96783);
INSERT INTO `creature_loot_template`
 (`Entry`,`Item`,`Reference`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(97058,132753,0,3.00,0,1,0,1,1,'Count Nefarious - Legion Rations'),
(97057,132753,0,1.64,0,1,0,1,1,'Overseer Brutarg - Legion Rations'),
(97370,132753,0,1.94,0,1,0,1,1,'General Volroth - Legion Rations'),
(96997,132753,0,1.75,0,1,0,1,1,'Kethrazor - Legion Rations'),
(97069,132753,0,1.94,0,1,0,1,1,'Wrath-Lord Lekos - Legion Rations'),
(98986,132753,0,1.39,0,1,0,1,1,'Prolifica - Legion Rations'),
(98497,132753,0,3.12,0,1,0,1,1,'Imp Mother - Legion Rations'),
(93221,132753,0,1.97,0,1,0,1,1,'Doom Commander Beliash - Legion Rations'),
(93105,132753,0,1.79,0,1,0,1,1,'Inquisitor Baleful - Legion Rations'),
(93802,132753,0,1.72,0,1,0,1,1,'Brood Queen Tyranna - Legion Rations'),
(92776,132753,0,2.18,0,1,0,1,1,'Fel Shocktrooper - Legion Rations'),
(97225,132753,0,2.59,0,1,0,1,1,'Wrathguard Legate - Legion Rations'),
(96682,132753,0,1.57,0,1,0,1,1,'Immolanth - Legion Rations'),
(96783,132753,0,1.70,0,1,0,1,1,'Bastillax - Legion Rations');

-- --- 129196 Pierre de soin de la Légion (oubliée sur quatre) -----------
DELETE FROM `creature_loot_template` WHERE `Item`=129196 AND `Entry` IN (97057,97370,96997,96783);
INSERT INTO `creature_loot_template`
 (`Entry`,`Item`,`Reference`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(97057,129196,0,0.92,0,1,0,1,1,'Overseer Brutarg - Legion Healthstone'),
(97370,129196,0,0.81,0,1,0,1,1,'General Volroth - Legion Healthstone'),
(96997,129196,0,0.48,0,1,0,1,1,'Kethrazor - Legion Healthstone'),
(96783,129196,0,1.14,0,1,0,1,1,'Bastillax - Legion Healthstone');

-- --- 147430 Parchemin runique mystérieux -------------------------------
-- Ajouté uniquement là où Wowhead le référence. Les relevés à 0,00 %
-- (Sombrepiste sauvage, Fantassin gangrené, Lekos, Funeste) sont
-- remontés au plancher de 0,01 % : l'écart entre 0,00 et 0,01 n'est que
-- la taille de l'échantillon.
DELETE FROM `creature_loot_template` WHERE `Item`=147430 AND `Entry` IN
 (97058,97057,97059,97370,96997,97069,98986,98497,93221,93105,92782,92776,97225,97228);
INSERT INTO `creature_loot_template`
 (`Entry`,`Item`,`Reference`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(97058,147430,0,0.02,0,1,0,1,1,'Count Nefarious - Mysterious Runebound Scroll'),
(97057,147430,0,0.01,0,1,0,1,1,'Overseer Brutarg - Mysterious Runebound Scroll'),
(97059,147430,0,0.01,0,1,0,1,1,'King Voras - Mysterious Runebound Scroll'),
(97370,147430,0,0.01,0,1,0,1,1,'General Volroth - Mysterious Runebound Scroll'),
(96997,147430,0,0.01,0,1,0,1,1,'Kethrazor - Mysterious Runebound Scroll'),
(97069,147430,0,0.01,0,1,0,1,1,'Wrath-Lord Lekos - Mysterious Runebound Scroll'),
(98986,147430,0,0.01,0,1,0,1,1,'Prolifica - Mysterious Runebound Scroll'),
(98497,147430,0,0.02,0,1,0,1,1,'Imp Mother - Mysterious Runebound Scroll'),
(93221,147430,0,0.01,0,1,0,1,1,'Doom Commander Beliash - Mysterious Runebound Scroll'),
(93105,147430,0,0.01,0,1,0,1,1,'Inquisitor Baleful - Mysterious Runebound Scroll'),
(92782,147430,0,0.01,0,1,0,1,1,'Savage Felstalker - Mysterious Runebound Scroll'),
(92776,147430,0,0.01,0,1,0,1,1,'Fel Shocktrooper - Mysterious Runebound Scroll'),
(97225,147430,0,0.01,0,1,0,1,1,'Wrathguard Legate - Mysterious Runebound Scroll'),
(97228,147430,0,0.01,0,1,0,1,1,'Abyssal Shard - Mysterious Runebound Scroll');

-- --- 132138 Cendres gangrenées radieuses -------------------------------
DELETE FROM `creature_loot_template` WHERE `Item`=132138 AND `Entry`=97228;
INSERT INTO `creature_loot_template`
 (`Entry`,`Item`,`Reference`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(97228,132138,0,0.04,0,1,0,1,1,'Abyssal Shard - Radiant Fel Ash');

-- --- 93105 Inquisiteur Funeste : sept lignes sur huit manquaient -------
-- Sa table ne contenait QUE la pierre de soin à 0,8 %. C'est le PNJ le
-- plus incomplet de la zone, et c'est celui qui garde une quête de la
-- campagne (« L'œil rivé sur l'objectif »).
DELETE FROM `creature_loot_template` WHERE `Entry`=93105 AND `Item` IN (130264,130265,130267,130268,130317);
INSERT INTO `creature_loot_template`
 (`Entry`,`Item`,`Reference`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(93105,130267,0,85.35,0,1,0,1,1,'Inquisitor Baleful - Extinguished Demon Stone'),
(93105,130268,0,11.19,0,1,0,1,1,'Inquisitor Baleful - Bone Toothpick'),
(93105,130317,0,3.53,0,1,0,1,1,'Inquisitor Baleful - Fractured Trophy'),
(93105,130264,0,0.94,0,1,0,1,1,'Inquisitor Baleful - Fel-Stained Claw'),
(93105,130265,0,0.07,0,1,0,1,1,'Inquisitor Baleful - Sharpened Canine');
