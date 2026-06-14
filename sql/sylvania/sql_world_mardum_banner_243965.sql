-- ============================================================================
-- Fix quete "Stop the Bombardment" (quest 38727) - Mardum (map 1481, ArgusCore)
-- ----------------------------------------------------------------------------
-- Symptome : impossible de detruire le Devastator du Soul Engine, la banniere
--            cliquable etait ABSENTE en jeu (presente dans les videos retail).
--
-- Cause : la banniere "Illidari Banner" 243965 (zone Soul Engine, liee au
--         Devastator 93762, kill-credit 96692) n'avait AUCUNE ligne de spawn
--         dans la table `gameobject`. Le template 243965 et le script C++
--         `go_mardum_illidari_banner` (zone_mardum.cpp) sont corrects ; seule
--         la ligne de spawn manquait.
--         Les 2 autres bannieres etaient deja presentes :
--           - 243967 Forge of Corruption (Devastator 96731, credit 96733)
--           - 243968 Doom Fortress      (Devastator 96732, credit 96734)
--
-- Note : un spawn GO se charge au demarrage du worldserver -> redemarrer le
--        world pour que la banniere apparaisse.
-- ============================================================================
DELETE FROM gameobject WHERE id=243965 AND map=1481;
INSERT INTO gameobject
  (guid,id,map,zoneId,areaId,spawnDifficulties,phaseUseFlags,PhaseId,PhaseGroup,terrainSwapMap,
   position_x,position_y,position_z,orientation,rotation0,rotation1,rotation2,rotation3,
   spawntimesecs,animprogress,state,isActive)
VALUES
  (210120136,243965,1481,7705,7747,'0',0,0,0,-1,
   1791.77,1574.91,87.1311,2.6141,0,0,0.96586,0.25867,
   7200,255,1,0);
