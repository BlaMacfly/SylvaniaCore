-- ============================================================================
-- Reconstruction spawns — rendeurs manquants ANCIEN MONDE / divers, LOT #5.
-- 2026-06-14. Balayage final du scan multi-maps (maps 0/1/648/540).
-- Filtre STRICT applique : on ne place un ender que si AUCUN ender de la quete
-- n'est deja spawne (evite les faux positifs des quetes multi-enders : Garrosh/
-- Vol'jin "Message for Saurfang" deja rendable via Saurfang ; Je'neu/Aluwyn deja
-- couverts). Coords = POI ObjectiveIndex=32 ; Z = plus-proche-voisin. modelid1.
-- ⚠️ Nouveaux spawns => RESTART worldserver.
--
-- ECARTES : 38928 Sassy Hardwrench (Iles Perdues, depart goblin ultra-phase ->
--   spawn statique inop.) ; enders d'autre timeline (Garrosh 39605, Vol'jin 86832) ;
--   "Black War Tiger" (monture, pas un PNJ) ; instances (map 540).
-- NOTE : 113547 = intro Rive Brisee cote HORDE (quete 44281 "To Be Prepared",
--   donneur Holgar Stormaxe spawne). Equivalent du fix Alliance 42782 ; comme
--   pour l'Alliance, la chaine peut necessiter un muster scripte en plus du spawn.
-- GUID 280000330+.
-- ============================================================================
DELETE FROM creature WHERE guid BETWEEN 280000330 AND 280000331;
INSERT INTO creature
 (guid,id,map,zoneId,areaId,spawnDifficulties,position_x,position_y,position_z,orientation,spawntimesecs,MovementType) VALUES
 (280000330,113547,   1,0,0,'0', 1322,-4395,  26.3, 0, 300,0),  -- Stone Guard Mukar — Orgrimmar — intro Rive Brisee Horde (q44281)
 (280000331,100429,   0,0,0,'0',-8400, 1374, 135.5, 0, 300,0);  -- Anduin Wrynn — Hurlevent — The Fallen Lion (q, niv110)
