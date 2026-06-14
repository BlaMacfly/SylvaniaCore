-- ============================================================================
-- Reconstruction spawns — rendeurs de HALL DE CLASSE / instances, LOT #7.
-- 2026-06-14. Scan strict (aucun ender spawne + donneur spawne) sur les maps de
-- Hall (POI ObjectiveIndex=32 sur la map du Hall, pas 1220). Le gating d'acces
-- (86 quetes) etait fait ; ces turn-ins manquaient a l'interieur des Halls.
-- Coords = POI ; Z = plus-proche-voisin de la map ; modelid1. spawn creature.
-- Petit etalement (+/-5y) pour les PNJ groupes au meme POI (hub de Hall) afin
-- d'eviter le z-fighting. ⚠️ RESTART worldserver. Z/positions a verifier en jeu.
--
-- LIMITES ASSUMEES (documentees) :
--  * Core SANS phasing complet : Calydus (109698+106610, 2 chapitres) se placerait
--    aux memes coords -> 2e entry decale de qq y ; sur un vrai core le phasing
--    n'en montrerait qu'un. Ritssyn (101921+105951) sont a des spots differents.
--  * Gin Lai 106985 ET 105019 = MEME quete "The Way of the Tiger" -> on place 1 (106985).
--  * Malorne (106905, map 1608) ECARTE : map vide (0 creature) => pas de voisin Z.
--  * Campagnes de classe tres phasees : lever ce blocage "ender absent" ne garantit
--    pas la jouabilite complete de la chaine (autres etapes possiblement cassees).
-- GUID creature 280000340-360.
-- ============================================================================
DELETE FROM creature WHERE guid BETWEEN 280000340 AND 280000360;
INSERT INTO creature
 (guid,id,map,zoneId,areaId,spawnDifficulties,position_x,position_y,position_z,orientation,spawntimesecs,MovementType) VALUES
-- --- 646 Deepholm (Chaman) ---
 (280000340,105995, 646,0,0,'0', 2384,  178, 182.4, 0, 300,0),  -- Muln Earthfury — The Return of Twilight
-- --- 870 Pandarie (Chaman) ---
 (280000341, 96541, 870,0,0,'0', 3249,  642, 538.9, 0, 300,0),  -- Rehgar Earthfury — The Codex of Ra
-- --- 1107 Faille de l'Effroi (Demoniste) ---
 (280000342,101921,1107,0,0,'0', 3121, 1106, 286.6, 0, 300,0),  -- Ritssyn Flamescowl — Rebuilding the Council
 (280000343,109698,1107,0,0,'0', 3126, 1110, 286.6, 0, 300,0),  -- Calydus — Finding the Scepter
 (280000344,100323,1107,0,0,'0', 3117, 1110, 286.6, 0, 300,0),  -- Revil Kost — Ulthalesh, the Deadwind Harvester
 (280000345,106610,1107,0,0,'0', 3129, 1103, 286.6, 0, 300,0),  -- Calydus — Ritual Reagents (entry phase chapitre 2, decale)
 (280000346,106199,1107,0,0,'0', 3124, 1105, 286.6, 0, 300,0),  -- Gakin the Darkbind — Rise, Champions
 (280000347,105816,1107,0,0,'0', 3037,  894, 247.6, 0, 300,0),  -- Kira Iresoul — An Unlikely Ally
 (280000348,105951,1107,0,0,'0', 3089,  975, 258.8, 0, 300,0),  -- Ritssyn Flamescowl — Summoning the Sisters
-- --- 1469 Maelstrom (Chaman) ---
 (280000349,106316,1469,0,0,'0',  943, 1061,  18.3, 0, 300,0),  -- Farseer Nobundo — Nobundo Awaits
 (280000350,112208,1469,0,0,'0',  940, 1057,  18.3, 0, 300,0),  -- Felinda Frye — Recruiting Earthcallers
 (280000351,105207,1469,0,0,'0',  937, 1059,  18.3, 0, 300,0),  -- Rehgar Earthfury — Ascendant of Flames
-- --- 1512 Temple de la Lumiere Noire (Pretre) ---
 (280000352,111009,1512,0,0,'0', 1335, 1353, 177.2, 0, 300,0),  -- Prophet Velen — Velen's Vision
 (280000353,110686,1512,0,0,'0', 1340, 1357, 177.2, 0, 300,0),  -- Zabra Hexx — The Best and Brightest
-- --- 1514 Pic de la Serenite (Moine) ---
 (280000354,104784,1514,0,0,'0',  924, 3606, 196.6, 0, 300,0),  -- Taran Zhu — The Defense of Tian Monastery
 (280000355,102843,1514,0,0,'0',  929, 3610, 196.6, 0, 300,0),  -- Aegira — The Mead Master
 (280000356,100475,1514,0,0,'0',  919, 3610, 196.6, 0, 300,0),  -- Li Li Stormstout — The Legend of the Sands
 (280000357,108700,1514,0,0,'0',  929, 3602, 196.6, 0, 300,0),  -- The Monkey King — The Wanderer's Companion
 (280000358,106985,1514,0,0,'0',  919, 3602, 196.6, 0, 300,0),  -- Gin Lai — The Way of the Tiger
 (280000359,105045,1514,0,0,'0',  924, 3612, 196.6, 0, 300,0),  -- Angus Ironfist — The Iron Fist
-- --- 1540 (Druide) ---
 (280000360,106250,1540,0,0,'0', 1747, 1521,  20.3, 0, 300,0);  -- Keeper Remulos — Communing With Malorne
