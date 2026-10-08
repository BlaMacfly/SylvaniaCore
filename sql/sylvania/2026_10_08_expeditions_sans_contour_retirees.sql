-- Expeditions sans aucun contour possible (ni source, ni cible posee : commandes de metiers, dresseurs
-- absents...) : affichees sur la carte mais impossibles a prendre. Retirees du registre. Rollback : ..._rollback.sql
DELETE FROM world_quest WHERE id IN (47828,48094,48102,48286,48337,48349,48359,48953,49045,49052,49056,49057);
