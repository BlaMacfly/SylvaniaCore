-- ============================================================================
-- Reconstruction spawns — rendeurs manquants DRAENOR (WoD, map 1116), LOT #4.
-- 2026-06-14. Meme methode que les Iles Brisees : rendeur non spawne + donneur
-- spawne + POI de rendu (ObjectiveIndex=32) sur map 1116 + QuestSortID>0 (zone
-- ouverte). Coords = POI ; Z = plus-proche-voisin VERIFIE (corr. propre).
-- Modele via creature_template.modelid1. ⚠️ Nouveaux spawns => RESTART worldserver.
--
-- 4A = PNJ statiques de zone ouverte, haute confiance (26 PNJ). GUID 280000300+.
-- ECARTES volontairement (phase campagne/fief, doublons d'entry, placeholders) :
--   Durotan x6 (73886,74273,75188,77485,79604,88120) + Yrel (74877) = campagne phasee ;
--   Baros Alexston x2 (79327/79328) = architecte de fief phase ;
--   "Find the Hideout [INTERNAL]" (82925) = placeholder/trigger ; Iron Shredder
--   Prototype (75968) = vehicule ; Horde Grunt (80341, generique, voisin 36y) ;
--   Hansel Heavyhands (75710, voisin 43y, Z incertain) ; Qiana Moonshadow (81948,
--   follower a recruter) -> a traiter au cas par cas plus tard.
-- ⚠️ WoD = forte densite de phasing : placer le rendeur leve le blocage "PNJ
--   inexistant" mais ne garantit pas la jouabilite complete de la chaine phasee.
--   Z a verifier en jeu (.go xyz / .gps), surtout Ombrelune (Z negatifs normaux).
-- ============================================================================
DELETE FROM creature WHERE guid BETWEEN 280000300 AND 280000325;
INSERT INTO creature
 (guid,id,map,zoneId,areaId,spawnDifficulties,position_x,position_y,position_z,orientation,spawntimesecs,MovementType) VALUES
-- --- Spires d'Arak (6662) ---
 (280000300, 80627,1116,0,0,'0', 3620, 1665, 177.1, 0, 300,0),  -- Miall — Going to the Gordunni
 (280000301, 75941,1116,0,0,'0', 3614, 2316,  67.1, 0, 300,0),  -- Gazlowe — Vol. X Pages
 (280000302, 80193,1116,0,0,'0', 3205,  788,  80.9, 0, 300,0),  -- Kirin Tor Magus — inscription (3q)
 (280000303, 75469,1116,0,0,'0', 2690, 1200, 197.5, 0, 300,0),  -- Raksi — What the Draenei Found
 (280000304, 80608,1116,0,0,'0', 1723, 2149,  63.5, 0, 300,0),  -- Magister Serena — Dropping In
 (280000305, 80260,1116,0,0,'0', 3185,  771,  78.5, 0, 300,0),  -- Magister Serena — inscription (3q)
-- --- Vallee d'Ombrelune (6719) ---
 (280000306, 76239,1116,0,0,'0',   93,-1547,  35.6, 0, 300,0),  -- Fiona — Crippled Caravan
 (280000307, 74043,1116,0,0,'0',  971, -847, -30.8, 0, 300,0),  -- Prophet Velen — Embaari (3q)
 (280000308, 73877,1116,0,0,'0', 1356, -381,   5.6, 0, 300,0),  -- Jarrod Hamby — Gloomshade Grove
 (280000309, 72413,1116,0,0,'0',  604,-1231, -21.4, 0, 300,0),  -- Exarch Akama — The Righteous March
-- --- Crete du Feu Noir (6720) ---
 (280000310, 76616,1116,0,0,'0', 5913, 6220,  49.3, 0, 300,0),  -- Farseer Drek'Thar — Honor Has Its Rewards
 (280000311, 70878,1116,0,0,'0', 7222, 5617, 125.8, 0, 300,0),  -- Ga'nar — Let the Hunt Begin!
-- --- Gorgrond (6721) ---
 (280000312, 81202,1116,0,0,'0', 5764, 1297, 107.0, 0, 300,0),  -- Bony Xuk — Rage and Wisdom
 (280000313, 81600,1116,0,0,'0', 5401, 1299,  96.1, 0, 300,0),  -- Burrian Coalpart — Dark Iron Down
 (280000314, 81927,1116,0,0,'0', 5411, 1301,  95.9, 0, 300,0),  -- Burrian Coalpart — Coalpart's Revenge
 (280000315, 82254,1116,0,0,'0', 5691, 1257,  83.4, 0, 300,0),  -- Cutter — Cutter
 (280000316, 85130,1116,0,0,'0', 5669,  401,  98.2, 0, 300,0),  -- Glirin — Arboretum (3q)
 (280000317, 85601,1116,0,0,'0', 4907, 1627, 117.9, 0, 300,0),  -- Cutter — Thieving Dwarves
 (280000318, 85089,1116,0,0,'0', 6513, 1114,  58.0, 0, 300,0),  -- Rakthoth — Arboretum (3q)
-- --- Talador (6722) ---
 (280000319, 82194,1116,0,0,'0', -667, 2406,  27.5, 0, 300,0),  -- Sir Edward — Second in Command
 (280000320, 82621,1116,0,0,'0',  116, 1553,  -1.7, 0, 300,0),  -- Reshad — All Due Respect
 (280000321, 82720,1116,0,0,'0', -413, 1738,  49.0, 0, 300,0),  -- Shadow-Sage Iskar — A Gathering of Shadows
 (280000322, 82375,1116,0,0,'0', -789, 2385,  38.2, 0, 300,0),  -- Admiral Taylor — Admiral Taylor (2q)
 (280000323, 83899,1116,0,0,'0',  264, 1436,  22.8, 0, 300,0),  -- Dark Ranger Velonara — Gardul Venomshiv
 (280000324, 82124,1116,0,0,'0', -584, 2311,  29.3, 0, 300,0),  -- Alice Finn — A Parting Favor
 (280000325, 84259,1116,0,0,'0',    3, 1241,  34.4, 0, 300,0);  -- Lunzul — No Time to Waste
