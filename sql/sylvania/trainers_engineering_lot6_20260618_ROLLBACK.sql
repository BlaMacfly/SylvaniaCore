-- ============================================================================
-- ROLLBACK — Lot 6 Ingénierie (trainers_engineering_lot6_20260618)
-- Base : dc_world  |  Date : 2026-06-18
-- A) recettes du donneur 3290 ; B) références -3290 ; C) options gossip.
-- (3290 n'avait aucune ligne npc_trainer avant ce lot.)
-- ============================================================================

SET NAMES utf8;

-- A) recettes donneur
DELETE FROM npc_trainer WHERE ID = 3290 AND SpellID > 0;
-- B) références
DELETE FROM npc_trainer WHERE SpellID = -3290;
-- C) options gossip (menus dédiés ingénierie)
DELETE FROM gossip_menu_option
WHERE OptionType = 5 AND OptionNpcFlag = 16 AND OptionText = 'Je voudrais m''entraîner.'
  AND (MenuId, OptionIndex) IN (
    (1465,0),(1467,0),(1468,1),(1469,0),(4136,0),(4137,0),(4147,0)
  );
