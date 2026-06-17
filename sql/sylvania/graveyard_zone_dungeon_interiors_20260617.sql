-- ============================================================================
-- Sylvania : liaisons graveyard_zone manquantes pour interieurs de donjons post-WotLK
-- Date    : 2026-06-17
-- Symptome: mort dans un donjon/raid refonte (Cata/WoD/Legion) -> fantome envoye
--           a l'autre bout du monde + cadavre verrouille dans l'instance -> rez
--           impossible. Cause : aucune ligne graveyard_zone pour la zone interieure.
-- Fix     : lier la zoneId interieure du donjon a un WorldSafeLoc EXISTANT (deja
--           dans WorldSafeLocs.db2) de la zone d'entree exterieure. Faction 0.
-- Applique en live + .reload graveyard_zone (1569 -> 1587 liens, 18 ajouts valides).
-- Idempotent (ON DUPLICATE KEY).
-- ============================================================================
INSERT INTO graveyard_zone (ID, GhostZone, Faction, Comment) VALUES
-- Refontes Cataclysm (zones d'entree : Maleterres O. / Tirisfal)
(1878, 6066, 0, 'Scholomance -> Scholo entrance GY [Sylvania]'),
(1874, 6109, 0, 'Scarlet Monastery -> SM entrance GY [Sylvania]'),
(1874, 6052, 0, 'Scarlet Halls -> SM entrance GY [Sylvania]'),
-- Legion (Azsuna / Stormheim / Highmountain / Val'sharah)
(5782, 8040, 0, 'Eye of Azshara -> Azsuna Eye of Azshara GY [Sylvania]'),
(5651, 7812, 0, 'Maw of Souls -> Stormheim Shields Rest GY [Sylvania]'),
(4954, 7814, 0, 'Vault of the Wardens -> Azsuna Illidari Stand GY [Sylvania]'),
(5094, 7672, 0, 'Halls of Valor -> Stormheim Skold-Ashil GY [Sylvania]'),
(5204, 7546, 0, 'Neltharions Lair -> Highmountain Feltotem GY [Sylvania]'),
(5066, 7673, 0, 'Darkheart Thicket -> Valsharah Temple of Elune GY [Sylvania]'),
(5045, 7805, 0, 'Black Rook Hold -> Valsharah Bradensbrook GY [Sylvania]'),
-- WoD (Gorgrond / Frostfire / Spires of Arak / Nagrand)
(4875, 6951, 0, 'Iron Docks -> Gorgrond GY [Sylvania]'),
(4875, 6967, 0, 'Blackrock Foundry -> Gorgrond GY [Sylvania]'),
(4875, 7109, 0, 'The Everbloom -> Gorgrond GY [Sylvania]'),
(4600, 6874, 0, 'Bloodmaul Slag Mines -> Frostfire Ridge GY [Sylvania]'),
(4902, 6988, 0, 'Skyreach -> Spires of Arak GY [Sylvania]'),
(4803, 6996, 0, 'Highmaul -> Nagrand GY [Sylvania]'),
-- Legion Suramar
(5287, 8025, 0, 'The Nighthold -> Suramar GY [Sylvania]'),
(5287, 8079, 0, 'Court of Stars -> Suramar GY [Sylvania]')
ON DUPLICATE KEY UPDATE Comment=VALUES(Comment);
