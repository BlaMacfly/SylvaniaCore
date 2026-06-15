-- ============================================================================
-- CORRECTIF durable — Hellfire Ramparts (map 543) : retrait de 2 PNJ Alliance
-- parasites a l'entree du donjon. 2026-06-15.
--
-- Signale en jeu : un joueur Horde se fait attaquer des l'entree par 2 mobs
-- Alliance. Cause = 2 spawns de faction 1737 (Honfort / Alliance Outreterre),
-- hostiles aux Horde, poses a l'entree (~ -1344, 1651, 69) :
--   54746  Honor Hold Recon        (aucun script, aucune quete)
--   54603  Advance Scout Chadwick   (questgiver : 29528,29529,29532,29543,29594)
--
-- La zone et le donjon = The Burning Crusade. Ces 2 PNJ (entries 54xxx) et leurs
-- quetes (29xxx) sont des ajouts ere Cataclysm greffes par erreur sur la map du
-- donjon TBC (mixup import : surface 530 <-> instance 543).
--
-- Base AzerothCore : les Remparts (map 543) ne contiennent AUCUN PNJ de faction
-- Honfort/Thrallmar => ces spawns sont parasites et sont retires.
-- On ne retire QUE les spawns de la map 543 ; creature_template + liens de quete
-- (par entry) sont CONSERVES (Chadwick reste replacable en surface map 530).
--
-- /!\ DELETE de spawns potentiellement deja charges => ils disparaissent a la
--     regeneration de l'instance / au RESTART worldserver. (Applique en live le
--     2026-06-15.) Idempotent : re-executable sans effet si deja propre.
-- ============================================================================
DELETE FROM creature_addon
 WHERE guid IN (SELECT guid FROM creature WHERE id IN (54603,54746) AND map = 543);

DELETE FROM creature
 WHERE id IN (54603,54746) AND map = 543;
