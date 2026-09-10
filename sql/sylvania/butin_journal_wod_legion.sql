-- =====================================================================
-- Butin des donjons et raids WoD / Legion
--
-- Signalement Discord : « les instances HL ne loot pas de stuff ».
-- Cause : sur ce core, le butin d'equipement des boss modernes ne vient
-- PAS de `creature_loot_template` mais du Guide d'aventure de Blizzard :
-- `Unit::Kill` lit `creature_template_journal` (entree -> JournalEncounterID)
-- puis tire 2 objets au hasard dans JournalEncounterItem.db2, avec le
-- masque de difficulte et le contexte d'objet corrects.
-- Or `creature_template_journal` ne contenait que 45 lignes, toutes
-- Burning Crusade : aucun boss de Draenor ni de Legion n'y figurait,
-- et ces boss ont `lootid = 0` -> ils ne lachaient rigoureusement rien.
--
-- Correspondances etablies a partir des DB2 officiels du client :
--   JournalInstance (MapID) -> JournalEncounter -> JournalEncounterCreature
--   (CreatureDisplayInfoID) -> creature_template.modelid1..4
-- Une seule creature par rencontre (celle qui la conclut), et uniquement
-- celles qui n'ont aucune table de butin, pour ne rien doubler.
--
-- Applique le 2026-09-10.
-- =====================================================================

DELETE FROM `creature_template_journal` WHERE `entry` IN (
 74366,81297,80816,83612,87420,76865,76814,76906,76806,76974,76877,77692,77182,77557,
 75964,76141,76143,82682,84550,83846,76413,76021,77120,76585,91005,94960,95674,96759,
 102682,104154,106643,116407,115767,116691,118462,117269,118518,122316,122313,122056,
 124729,98965,79852,79912);

INSERT INTO `creature_template_journal` (`entry`,`JournalEncounterID`) VALUES
-- Mines de Sangyre (1175)
(74366, 893),   -- Forgemaster Gog'duh
-- Docks de fer (1195)
(81297, 1235),  -- Dreadfang (Fleshrender Nok'gar)
(80816, 1236),  -- Ahri'ok Dugru (Contremaitres du Rail-de-fer)
(79852, 1237),  -- Oshir
(83612, 1238),  -- Skulloc
-- Auchindoun (1182) : PAS de ligne pour Azzakel. Le vrai boss (75927,
-- niveau 97, script boss_azzakel, 49 lignes de butin) n'est PAS apparu ;
-- le PNJ pose dans le donjon est un doublon de niveau 1 sans script.
-- C'est un defaut d'apparition, pas de butin : a corriger separement.
-- Aire de Haut-perchoir (1209)
(75964, 965),   -- Ranjit
(76141, 966),   -- Araknath
(76143, 967),   -- Rukhran
-- Floraison eternelle (1279)
(82682, 1208),  -- Archmage Sol
(84550, 1209),  -- Xeri'tac
(83846, 1210),  -- Yalnu
-- Pic Rochenoire, sommet (1358)
(76413, 1226),  -- Orebender Gor'ashan
(76021, 1227),  -- Kyrak
(79912, 1228),  -- Commander Tharbek
(76585, 1229),  -- Ragewing the Untamed
(77120, 1234),  -- Warlord Zaela
-- Fonderie des Rochenoire (1205) - raid entier sans butin
(77182, 1202),  -- Oregorger
(76974, 1155),  -- Franzok (Hans'gar et Franzok)
(76865, 1122),  -- Beastlord Darmac
(76877, 1161),  -- Gruul
(76814, 1123),  -- Flamebender Ka'graz
(76906, 1147),  -- Operator Thogar
(76806, 1154),  -- Heart of the Mountain (Haut fourneau)
(77692, 1162),  -- Kromog
(77557, 1203),  -- Admiral Gar'an (Vierges de fer)
(87420, 959),   -- Blackhand
-- Repaire de Neltharion (1458)
(91005, 1673),  -- Naraxas
-- Salles des Valeureux (1477)
(94960, 1485),  -- Hymdall
(95674, 1487),  -- Fenryr
-- Gouffre des ames (1492)
(96759, 1663),  -- Helya
-- Donjon de Tenebreterre (1501)
(98965, 1672),  -- Kur'talos Ravencrest
-- Cauchemar d'emeraude (1520)
(102682, 1704), -- Lethon (Dragons du Cauchemar)
-- Nighthold (1530)
(104154, 1737), -- Gul'dan
(106643, 1743), -- Grande magistrix Elisande
-- Tombeau de Sargeras (1676)
(116407, 1856), -- Harjatan
(115767, 1861), -- Mistress Sassz'ine
(116691, 1867), -- Belac (Inquisition demoniaque)
(118518, 1903), -- Priestess Lunaspyre (Soeurs de la Lune)
(118462, 1896), -- Soul Queen Dejahna (Hote desole)
(117269, 1898), -- Kil'jaeden
-- Siege du Triumvirat (1753) - donjon entier sans butin
(122313, 1979), -- Zuraal the Ascended
(122316, 1980), -- Saprish
(122056, 1981), -- Viceroy Nezhar
(124729, 1982); -- L'ura
