-- ============================================================================
-- CORRECTIF durable — fix deconnexion (streaming error WOW51900322) a la
-- connexion d un worgen/gobelin neuf. 2026-06-16.
--
-- Symptome : worgen cree dans Gilneas (apres fix du lieu de depart) -> a la
-- connexion le client se deconnecte instantanement (erreur flux continu) ;
-- serveur OK (pas de crash), il envoyait dans un socket deja ferme.
-- Cause (diff vs ref Cataclysm Preservation Project, qui fonctionne) : 2 ecarts
-- sur le setup de depart Cata, absents du CPP :
--   1) playercreateinfo_cast_spell : 3 sorts worgen en trop (72792,72857,95759)
--      + 1 gobelin (77534) lances a la creation. CPP ne garde que 79596/79595.
--   2) terrain_swap_defaults : map 654 (Gilneas) avait un terrain swap 656 PAR
--      DEFAUT (en plus de 638/655) = mauvaise version de terrain forcee a tous
--      ceux qui entrent -> le client streame un terrain invalide -> ejection.
--      CPP n a que 638/655.
-- Necessite RESTART (cast_spell + terrain_swap charges au boot). Idempotent.
-- ============================================================================
DELETE FROM playercreateinfo_cast_spell WHERE spell IN (72792,72857,95759) AND raceMask=2097152;
DELETE FROM playercreateinfo_cast_spell WHERE spell=77534 AND raceMask=256;
DELETE FROM terrain_swap_defaults WHERE MapId=654 AND TerrainSwapMap=656;
