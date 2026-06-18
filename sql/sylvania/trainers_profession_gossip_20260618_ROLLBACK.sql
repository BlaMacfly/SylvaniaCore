-- ============================================================================
-- ROLLBACK — Fix maîtres de métier muets (trainers_profession_gossip_20260618)
-- Base : dc_world  |  Date : 2026-06-18
-- Supprime UNIQUEMENT les 23 options de gossip trainer ajoutées par le patch
-- (signature exacte : OptionType=5, OptionNpcFlag=16, OptionText FR, aux
--  couples (MenuId,OptionIndex) insérés). N'affecte aucune donnée préexistante.
-- Puis .reload gossip_menu_option OU restart world.
-- ============================================================================

SET NAMES utf8;

DELETE FROM gossip_menu_option
WHERE OptionType = 5
  AND OptionNpcFlag = 16
  AND OptionText = 'Je voudrais m''entraîner.'
  AND (MenuId, OptionIndex) IN (
    ( 1041,  0), ( 1042,  0), ( 1043,  0), ( 2749,  0), ( 3202,  0),
    ( 3203,  0), ( 4129,  1), ( 4156,  0), ( 4171,  0), ( 4208,  0),
    ( 4244,  0), ( 4356,  0), ( 8460,  1), ( 8784,  2), (11637,  0),
    (12180, 13), (13283,  2), (14615,  2), (14625,  1), (14972,  0),
    (15125, 14), (18475,  3), (56340,  0)
  );
