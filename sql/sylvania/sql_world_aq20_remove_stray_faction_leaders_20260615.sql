-- ============================================================================
-- CORRECTIF durable — Ruines d Ahn Qiraj (AQ20, map 509) : retrait de 2 chefs de
-- faction parasites. 2026-06-15.
--
-- Detecte par l audit couche 1 (Q1 : PNJ donneurs de quete en instance) puis
-- CONFIRME par la couche 2 (reference AzerothCore) :
--   42443  King Varian Wrynn   (faction 1802 Alliance, questgiver)
--   42600  Cairne Bloodhoof    (faction 1801 Horde,    questgiver)
-- Tous deux poses a l entree de l AQ20 (~ -8435, 1532). Entries ere Cataclysm
-- (Cairne est mort en jeu depuis Cata) => lore-impossibles dans un raid vanilla.
-- Reference : AzerothCore ne connait pas ces entries et son AQ20 (map 509) ne
-- les contient pas => spawns parasites (probable mixup d import Cata).
--
-- On retire UNIQUEMENT les spawns de la map 509 ; creature_template + liens de
-- quete (par entry) CONSERVES (re-plaçables sur leur vraie map via ref TC 4.3.4
-- si on veut un jour le contenu Cata). Idempotent.
-- ============================================================================
DELETE FROM creature_addon
 WHERE guid IN (SELECT guid FROM creature WHERE id IN (42443,42600) AND map = 509);

DELETE FROM creature
 WHERE id IN (42443,42600) AND map = 509;
