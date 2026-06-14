-- ============================================================================
-- Gating de classe — LOT #3 : classes restantes (Démoniste, Moine, Chaman, Mage,
-- Prêtre, + DH compléments). 2026-06-14.
-- ----------------------------------------------------------------------------
-- Halls d'ordre INSTANCIÉS = maps mono-classe (confirmé par titres) :
--   1107 Dreadscar = Démoniste, 1514 = Moine, 1469 Maelström = Chaman, 1513 = Mage.
-- Prêtre : Altar Keeper Biehn + Sister Elda (Temple de Lumièrenoire).
-- DH : Khadgar « Return to Jace » (chaîne DH).
-- NON gatées volontairement : quêtes de guerre FACTION (Saurfang/Sylvanas/Anduin/
--   Danath/Tethys), et ambigus à vérifier (Tinderfell, Celadine, Filius, Marin,
--   King Phaoris). Garde `AllowableClasses=0`. Bitmask : Prêtre=16, Chaman=64,
--   Mage=128, Démoniste=256, Moine=512, DH=2048. Puis `.reload quest_template`.
-- ============================================================================

-- Démoniste (256) — hall Dreadscar Rift (map 1107)
UPDATE quest_template_addon SET AllowableClasses=256
 WHERE AllowableClasses=0 AND ID IN (40495,40684,40731,40821,40823,42128,43100,43887,43984,44089);

-- Moine (512) — hall (map 1514)
UPDATE quest_template_addon SET AllowableClasses=512
 WHERE AllowableClasses=0 AND ID IN (40236,40569,40636,40698,40793,40795,41003,42762,43359,43881,43973,44424);

-- Chaman (64) — hall Maelström / Heart of Azeroth (map 1469)
UPDATE quest_template_addon SET AllowableClasses=64
 WHERE AllowableClasses=0 AND ID IN (40276,41510,43886,43945,44006);

-- Mage (128) — hall (map 1513)
UPDATE quest_template_addon SET AllowableClasses=128
 WHERE AllowableClasses=0 AND ID IN (41113,41141);

-- Prêtre (16) — Altar Keeper Biehn + Sister Elda (Temple de Lumièrenoire)
UPDATE quest_template_addon SET AllowableClasses=16
 WHERE AllowableClasses=0 AND ID IN (40958,41047,43883);

-- Chasseur de démons (2048) — compléments (Khadgar « Return to Jace »)
UPDATE quest_template_addon SET AllowableClasses=2048
 WHERE AllowableClasses=0 AND ID IN (41804,41806);
