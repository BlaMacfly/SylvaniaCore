-- ============================================================================
-- Reconstruction spawns — rendeurs manquants Iles Brisees, LOT #3 (FINITION MANUELLE).
-- 2026-06-14. Reliquat de la methode auto (batch1/2 = 68 PNJ) : ceux ecartes car
-- POI de rendu sur 1220 mais soit sort negatif (Hall de classe, hors continent),
-- soit voisin lointain pour le Z. Ici = uniquement les VRAIS PNJ statiques en
-- monde ouvert (QuestSortID positif), Z pris au plus-proche-voisin VERIFIE
-- (anchor reel, distances recalculees proprement, pas la correlation foireuse).
-- Modele via creature_template.modelid1 (ce core lit modelid1). map 1220.
-- ⚠️ Nouveaux spawns => RESTART worldserver (pas de hot-reload). Z a verifier en jeu.
-- GUID : 280000283+ (suite de batch2 qui finit a 280000282).
-- ============================================================================

-- --- LOT 3A : haute confiance (PNJ statique connu, voisin < 20y, Z fiable) -----
DELETE FROM creature WHERE guid BETWEEN 280000283 AND 280000287;
INSERT INTO creature
 (guid,id,map,zoneId,areaId,spawnDifficulties,position_x,position_y,position_z,orientation,spawntimesecs,MovementType) VALUES
 (280000283, 94977,1220,0,0,'0', 3017, 7374,  35.4, 0, 300,0),  -- Commander Jarod Shadowsong (Val'sharah) [voisin Cockroach d10]
 (280000284,102988,1220,0,0,'0',  625, 6638,  60.2, 0, 300,0),  -- Archmage Khadgar (Azsuna, "Feasting on the Dragon") [voisin Azurewing Keeper d13]
 (280000285,101927,1220,0,0,'0',  -79, 6859,  30.6, 0, 300,0),  -- Altruis the Sufferer (Azsuna, "Into the Fray") [voisin Spirit Healer d17]
 (280000286,105342,1220,0,0,'0',  826, 4412, 117.0, 0, 300,0),  -- Ly'leth Lunastre (Suramar, "The Masks We Wear") [voisin Nightborne Groundskeeper d18]
 (280000287,102142,1220,0,0,'0', 1664, 3900, 168.7, 0, 300,0);  -- Chief Telemancer Oculeth (Suramar, "Network Security") [voisin Font of Arcane Energy d25]

-- --- LOT 3B : borderline — appliquer SEULEMENT apres validation in-game --------
--   90474 "Demon Hunter" : nom generique (probable Illidari phase, Azsuna). Verifier
--          qu'il ne casse pas le rendu phase de "Saving Stellagosa"/"Fel Machinations".
--   99575 Thaedris Feathersong : voisin a 30y, Z=268.9 (peut flotter).
--   92557 Sky Admiral Rogers : sur le Skyfire (vaisseau), Z=440 (pont du gunship) ;
--          PNJ normalement sur vehicule mobile -> spawn statique a tester.
-- DELETE FROM creature WHERE guid BETWEEN 280000288 AND 280000290;
-- INSERT INTO creature
--  (guid,id,map,zoneId,areaId,spawnDifficulties,position_x,position_y,position_z,orientation,spawntimesecs,MovementType) VALUES
--  (280000288, 90474,1220,0,0,'0', -514, 7276,  16.9, 0, 300,0),  -- Demon Hunter (Azsuna) [voisin Eredar Supplicant d21]
--  (280000289, 99575,1220,0,0,'0', 2198, 4034, 268.9, 0, 300,0),  -- Thaedris Feathersong [voisin Font of Arcane Energy d30]
--  (280000290, 92557,1220,0,0,'0', 3211, 3084, 440.3, 0, 300,0);  -- Sky Admiral Rogers (Skyfire) [voisin Tinkmaster Overspark d0]
