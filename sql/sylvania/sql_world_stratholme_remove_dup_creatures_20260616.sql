-- ============================================================================
-- CORRECTIF durable — Stratholme (map 329) : retrait de 2 doublons de creatures.
-- 2026-06-16. Detecte par audit (doublons de nom), TRANCHE par couche 2 (AC).
--
-- Notre map 329 avait 2 entries pour le meme mob (copie ere Cata en doublon des
-- classiques). AzerothCore (WotLK) confirme les entries CANONIQUES sur map 329 :
--   Plague Ghoul       : 10405 (canonique, AC 329)  vs 42975 (copie Cata) -> RETIRER 42975
--   Eye of Naxxramas   : 10411 (canonique, AC 329)  vs 42973 (copie Cata) -> RETIRER 42973
-- Les copies 42973/42975 n ont AUCUN lien de quete (juste des SmartAI dupliques).
-- On garde 10405/10411 (le role reste assure).
--
-- NON touche (ambigu, AC ne connait pas - Cata) : paires Argent Crusade 453xx
-- (Eligor 45200/45329, Wilhelm 45201/45331, Stonebruiser 45323/45328, Argent
-- Crusader 45346/45456) = questgivers a valider via ref TrinityCore 4.3.4.
--
-- Retrait des spawns map 329 seulement ; templates + scripts conserves. Idempotent.
-- ============================================================================
DELETE FROM creature_addon
 WHERE guid IN (SELECT guid FROM creature WHERE id IN (42973,42975) AND map = 329);

DELETE FROM creature
 WHERE id IN (42973,42975) AND map = 329;
