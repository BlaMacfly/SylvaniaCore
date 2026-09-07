-- Butin manquant : suite du Draenor (carte 1116), apres les zones d'acces.
--
-- 245 especes hostiles avaient lootid = 0. Relevees une par une sur Wowhead avec
-- controle du statut HTTP 200 et du marqueur g_npcs de la fiche : sans ce controle,
-- une page de refus 403 se lit exactement comme un PNJ sans butin (8 refus rencontres).
--
-- Resultat : 222 des 245 n'ont effectivement aucun butin sur les royaumes officiels
-- non plus (decors, critters, PNJ scenarises, envahisseurs de fief). 8 autres n'ont
-- que des objets post-Legion, absents de notre Item.db2. Restent 15 especes.
--
-- Les materiaux type Fourrure somptueuse (111557) sont bien du butin de cadavre ici :
-- ils apparaissent 196 fois dans creature_loot_template et jamais dans skinning_loot_template.

DELETE FROM `creature_loot_template` WHERE `Entry` IN (73227,73805,74414,76663,76686,77091,77522,78458,78662,78665,78700,80192,82515,82728,86443);
INSERT INTO `creature_loot_template`
  (`Entry`,`Item`,`Reference`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(73227,106870,0,3.1100,0,1,0,1,1,'Wastes Rockworm'),
(73227,106875,0,0.1400,0,1,0,1,1,'Wastes Rockworm'),
(73227,106877,0,0.0900,0,1,0,1,1,'Wastes Rockworm'),
(73227,109131,0,0.7000,0,1,0,1,1,'Wastes Rockworm'),
(73227,111557,0,1.1200,0,1,0,1,1,'Wastes Rockworm'),
(73805,107528,0,1.6200,0,1,0,1,1,'Corrupted Toad'),
(73805,108906,0,0.8400,0,1,0,1,1,'Corrupted Toad'),
(73805,111557,0,0.1700,0,1,0,1,1,'Corrupted Toad'),
(73805,116703,0,0.8400,0,1,0,1,1,'Corrupted Toad'),
(74414,106297,0,0.5200,0,1,0,1,1,'Juvenile Bonestripper'),
(74414,106317,0,1.2200,0,1,0,1,1,'Juvenile Bonestripper'),
(74414,107603,0,3.6700,0,1,0,1,1,'Juvenile Bonestripper'),
(76663,113000,0,4.6200,0,1,0,1,1,'Shadow Infiltrator'),
(76663,113006,0,33.8500,0,1,0,1,1,'Shadow Infiltrator'),
(76663,113007,0,9.2300,0,1,0,1,1,'Shadow Infiltrator'),
(76686,112995,0,6.5200,0,1,0,1,1,'Shadow Pillager'),
(76686,113004,0,13.0400,0,1,0,1,1,'Shadow Pillager'),
(76686,113007,0,6.5200,0,1,0,1,1,'Shadow Pillager'),
(77091,106825,0,15.3800,0,1,0,1,1,'Wild Rylak'),
(77091,107528,0,76.9200,0,1,0,1,1,'Wild Rylak'),
(77091,109133,0,46.1500,0,1,0,1,1,'Wild Rylak'),
(77091,111557,0,38.4600,0,1,0,1,1,'Wild Rylak'),
(77522,106291,0,1.9500,0,1,0,1,1,'Gul''var Peon'),
(77522,106298,0,0.3500,0,1,0,1,1,'Gul''var Peon'),
(77522,106301,0,0.8900,0,1,0,1,1,'Gul''var Peon'),
(77522,106302,0,0.1800,0,1,0,1,1,'Gul''var Peon'),
(77522,106312,0,1.9500,0,1,0,1,1,'Gul''var Peon'),
(77522,106322,0,0.8900,0,1,0,1,1,'Gul''var Peon'),
(77522,106323,0,0.1800,0,1,0,1,1,'Gul''var Peon'),
(77522,106324,0,1.0600,0,1,0,1,1,'Gul''var Peon'),
(77522,106489,0,0.8900,0,1,0,1,1,'Gul''var Peon'),
(77522,106540,0,0.1800,0,1,0,1,1,'Gul''var Peon'),
(77522,106556,0,0.1800,0,1,0,1,1,'Gul''var Peon'),
(77522,106574,0,0.4100,0,1,0,1,1,'Gul''var Peon'),
(77522,106581,0,0.1800,0,1,0,1,1,'Gul''var Peon'),
(77522,106583,0,0.3500,0,1,0,1,1,'Gul''var Peon'),
(77522,106870,0,1.6500,0,1,0,1,1,'Gul''var Peon'),
(77522,111364,0,1.1200,0,1,0,1,1,'Gul''var Peon'),
(77522,111387,0,0.4100,0,1,0,1,1,'Gul''var Peon'),
(77522,111557,0,0.3500,0,1,0,1,1,'Gul''var Peon'),
(77522,113295,0,0.3500,0,1,0,1,1,'Gul''var Peon'),
(77522,113478,0,1.1200,0,1,0,1,1,'Gul''var Peon'),
(77522,116709,0,0.3500,0,1,0,1,1,'Gul''var Peon'),
(78458,106867,0,8.4500,0,1,0,1,1,'Abyssal Invader'),
(78458,116122,0,16.4300,0,1,0,1,1,'Abyssal Invader'),
(78662,106459,0,22.7300,0,1,0,1,1,'Thunderlord Cutter'),
(78662,107603,0,4.5500,0,1,0,1,1,'Thunderlord Cutter'),
(78665,106304,0,1.9600,0,1,0,1,1,'Thunderlord Shaman'),
(78665,106472,0,1.9600,0,1,0,1,1,'Thunderlord Shaman'),
(78665,106876,0,5.8800,0,1,0,1,1,'Thunderlord Shaman'),
(78665,113381,0,4.5800,0,1,0,1,1,'Thunderlord Shaman'),
(78700,106295,0,2.1300,0,1,0,1,1,'Thunderlord Provisioner'),
(78700,106464,0,23.4000,0,1,0,1,1,'Thunderlord Provisioner'),
(80192,111953,0,4.5000,0,1,0,1,1,'Icecave Bat'),
(82515,106824,0,27.7400,0,1,0,1,1,'Darktalon Hatchling'),
(82515,106825,0,18.0600,0,1,0,1,1,'Darktalon Hatchling'),
(82728,106870,0,33.2800,0,1,0,1,1,'Agitated Piglet'),
(82728,107517,0,13.5500,0,1,0,1,1,'Agitated Piglet'),
(82728,108977,0,18.1800,0,1,0,1,1,'Agitated Piglet'),
(82728,109136,0,19.7300,0,1,0,1,1,'Agitated Piglet'),
(82728,111557,0,13.8900,0,1,0,1,1,'Agitated Piglet'),
(82728,118200,0,3.6000,0,1,0,1,1,'Agitated Piglet'),
(82728,118281,0,1.0300,0,1,0,1,1,'Agitated Piglet'),
(86443,106315,0,2.1300,0,1,0,1,1,'Ogron Pitfighter'),
(86443,106735,0,6.3800,0,1,0,1,1,'Ogron Pitfighter');

UPDATE `creature_template` SET `lootid` = `entry` WHERE `entry` IN (73227,73805,74414,76663,76686,77091,77522,78458,78662,78665,78700,80192,82515,82728,86443);
