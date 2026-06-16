-- ============================================================================
-- CORRECTIF durable — normalisation des spawns en MovementType=2 (waypoint) SANS
-- chemin (etat invalide). 2026-06-16. Detecte par audit couche 1 (Q4).
--
-- 237 spawns avaient MovementType=2 mais aucun chemin (ni waypoint_data par guid,
-- ni creature_addon.path_id) => le worldserver spam "doesn't have waypoint path"
-- au boot et la creature reste FIGEE (ni patrouille ni errance).
--
-- Reference AzerothCore (couche 2) pour ces memes creatures : 35 entries en idle,
-- 17 en aleatoire, 76 en waypoint-AVEC-chemin, 43 inconnues d AC (Cata+/Legion).
-- Comme NOS spawns n ont pas de chemin, on ne peut pas honorer MT=2 ; on remet un
-- MovementType coherent (sans perte, elles etaient deja figees) :
--   spawndist > 0  -> 1 (errance aleatoire dans le rayon)   [7 spawns]
--   spawndist = 0  -> 0 (stationnaire / idle)               [230 spawns]
--
-- NOTE : pour les ~76 entries qu AzerothCore fait reellement PATROUILLER,
-- restaurer les vrais chemins (import waypoint_data depuis AC) = amelioration
-- future a part. Ce correctif elimine d abord l etat casse + le spam.
-- Idempotent (ne cible que les MT=2 sans chemin restants).
-- ============================================================================
UPDATE creature SET MovementType = 1
 WHERE MovementType = 2 AND spawndist > 0
   AND guid NOT IN (SELECT id FROM waypoint_data)
   AND guid NOT IN (SELECT guid FROM creature_addon WHERE path_id <> 0);

UPDATE creature SET MovementType = 0
 WHERE MovementType = 2 AND spawndist = 0
   AND guid NOT IN (SELECT id FROM waypoint_data)
   AND guid NOT IN (SELECT guid FROM creature_addon WHERE path_id <> 0);
