-- ============================================================================
-- Reconstruction spawns — rendeurs manquants Îles Brisées, LOT #1 (top blocages).
-- 2026-06-14. Débloque ~18 quêtes (joueur prenait la quête mais rendeur jamais
-- spawné). Coords = POI de rendu réel (quest_poi) ; Z = spawns voisins ; modèle
-- via creature_template.modelid1 (ce core lit modelid1).
-- ⚠️ Z des PNJ à 1 voisin = À VÉRIFIER EN JEU (.go xyz puis .gps ; UPDATE si flotte).
--   Alard Schmied = Z fiable (11 voisins, Dalaran). Application : SQL puis RESTART.
-- ============================================================================
DELETE FROM creature WHERE guid IN (280000211,280000212,280000213,280000214,280000215);
INSERT INTO creature
 (guid,id,map,zoneId,areaId,spawnDifficulties,position_x,position_y,position_z,orientation,spawntimesecs,MovementType) VALUES
 (280000211, 97261,1220,0,0,'0', -745, 4514, 731.88, 0, 300,0),  -- Alard Schmied (forge Leystone, Dalaran) — 6 quêtes
 (280000212,102334,1220,0,0,'0', 1388, 2770,   1.45, 0, 300,0),  -- Brandolf — 3 quêtes  [Z à vérifier]
 (280000213,103484,1220,0,0,'0', 1238, 4960,  72.02, 0, 300,0),  -- Brann Bronzebeard — 3 quêtes  [Z à vérifier]
 (280000214,107632,1220,0,0,'0', 1236, 4057,  93.32, 0, 300,0),  -- Ly'leth Lunastre (Suramar) — 3 quêtes  [Z à vérifier]
 (280000215,108434,1220,0,0,'0', 4653, 4476, 676.46, 0, 300,0);  -- Mayla Highmountain (Thunder Totem) — 3 quêtes  [Z à vérifier]
