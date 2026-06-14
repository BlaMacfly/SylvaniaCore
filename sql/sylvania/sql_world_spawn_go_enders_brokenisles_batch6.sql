-- ============================================================================
-- Reconstruction spawns — rendeurs GAMEOBJECT manquants Iles Brisees, LOT #6.
-- 2026-06-14. Classe de blocage = quete rendue a un OBJET (gameobject_questender)
-- type=2 (QUESTGIVER) non spawne, AUCUN autre ender (creature ni GO) spawne,
-- donneur spawne. Coords = POI ObjectiveIndex=32 (map 1220) ; Z = plus-proche-
-- voisin creature. Convention copiee d'un GO type-2 1220 existant : spawntimesecs
-- 7200, animprogress 255, state 1, terrainSwapMap -1, phaseUseFlags 0 (=> visible
-- toutes phases, adapte a ce core a phasing incomplet), rotation identite.
-- ⚠️ Nouveaux spawns => RESTART worldserver.
--
-- ECARTE : 251870 "The Sixtriggers' Premium..." (quete 43331 Time to Collect) =
--   displayId 0 (modele INVISIBLE) -> un spawn statique serait invisible/non
--   cliquable ; turn-in gere autrement (script). A NE PAS placer.
-- NOTE : ces 3 quetes sont des chaines d'histoire (Suramar/Val'sharah/Stormheim) ;
--   placer l'objet de rendu leve le blocage "objet inexistant" mais la jouabilite
--   complete depend du reste de la chaine (souvent scriptee/phasee). Z a verif en jeu.
-- GUID gameobject 280000400+.
-- ============================================================================
DELETE FROM gameobject WHERE guid BETWEEN 280000400 AND 280000402;
INSERT INTO gameobject
 (guid,id,map,zoneId,areaId,spawnDifficulties,phaseUseFlags,PhaseId,PhaseGroup,terrainSwapMap,
  position_x,position_y,position_z,orientation,rotation0,rotation1,rotation2,rotation3,
  spawntimesecs,animprogress,state,isActive) VALUES
 (280000400,251991,1220,0,0,'0',0,0,0,-1, 2498, 957,241.53,0, 0,0,0,1, 7200,255,1,0),  -- The Aegis of Aggramar — q40072 (Stormheim)
 (280000401,250383,1220,0,0,'0',0,0,0,-1, 1734,4599, 96.37,0, 0,0,0,1, 7200,255,1,0),  -- Moonshade Relic — q42224 Cloaked in Moonshade (Suramar)
 (280000402,265435,1220,0,0,'0',0,0,0,-1, 2193,5480, 97.26,0, 0,0,0,1, 7200,255,1,0);  -- Ancient Seed Holder — q42230 The Valewalker's Burden (Val'sharah)
