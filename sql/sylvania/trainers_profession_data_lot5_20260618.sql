-- ============================================================================
-- La Légion de Sylvania — Lot 5 : données d'entraînement pour les maîtres de
--   métier « sans données » (hors Ingénierie, traitée séparément lot 6).
-- Base : dc_world (LIVE)  |  Date : 2026-06-18
-- ----------------------------------------------------------------------------
-- CONTEXTE
--   ~103 maîtres de métier spawnés n'avaient AUCUNE donnée d'entraînement (ni
--   schéma moderne `trainer`, ni legacy `npc_trainer`) -> fenêtre vide même
--   quand l'option de gossip existait. Le contenu manque à la source TC
--   (TDB735 officiel n'a que 93 trainers modernes et pas de npc_trainer).
--   MAIS chaque profession dispose déjà, dans ce monde, d'un maître COMPLET
--   (donneur « feuille pure ») dont on réutilise la liste de sorts.
--
--   Découverte : le menu 0 est le menu universel auto-généré ; il contient
--   déjà l'option « Train me! » (OptionType=5, OptionNpcFlag=16). Donc tout
--   trainer à gossip_menu_id=0 propose déjà l'entraînement DÈS qu'il a des
--   données. Seuls les menus DÉDIÉS (<>0) ont besoin d'une option explicite.
-- ----------------------------------------------------------------------------
-- DONNEURS feuilles pures (entry -> nb sorts) :
--   Alchimie 1215(143) Forge 7230(248) Enchantement 1317(193)
--   Joaillerie 65098(290) Cuir 1385(278) Couture 57405(235)
--   Calligraphie 92195(148) Premiers soins 126022(36) Pêche 1680(17)
--   Herboristerie 1218(8) Minage 93189(36) Dépeçage 1292(8)
--   Archéologie 93538(10) Cuisine 93536(52)
--   Réutilisation via le mécanisme natif npc_trainer (SpellID négatif =
--   « hérite de tous les sorts du donneur », cf ObjectMgr::LoadTrainerSpell).
-- PÉRIMÈTRE : professions hors Ingénierie. Maîtres de CLASSE intacts
--   (en Legion les sorts de classe s'apprennent au niveau, pas d'un PNJ).
-- EFFET : restart world OU `.reload npc_trainer`(si dispo) + `.reload
--   gossip_menu_option`. ROLLBACK : ..._lot5_ROLLBACK.sql
-- ============================================================================

SET NAMES utf8;

-- ---------------------------------------------------------------------------
-- PART A — Données : 1 ligne de référence-donneur par maître de métier vide.
-- ---------------------------------------------------------------------------
INSERT INTO npc_trainer (ID, SpellID, MoneyCost, ReqSkillLine, ReqSkillRank, ReqLevel, `Index`)
SELECT ct.entry,
  -(CASE
     WHEN ct.subname LIKE '%Alchem%' THEN 1215
     WHEN ct.subname LIKE '%Blacksmith%' THEN 7230
     WHEN ct.subname LIKE '%Enchant%' THEN 1317
     WHEN ct.subname LIKE '%Jewelcraft%' THEN 65098
     WHEN ct.subname LIKE '%Leatherwork%' OR ct.subname LIKE '%Tanner%' THEN 1385
     WHEN ct.subname LIKE '%Tailor%' THEN 57405
     WHEN ct.subname LIKE '%Inscription%' THEN 92195
     WHEN ct.subname LIKE '%First Aid%' THEN 126022
     WHEN ct.subname LIKE '%Fish%' OR ct.subname LIKE '%Angler%' THEN 1680
     WHEN ct.subname LIKE '%Herbal%' THEN 1218
     WHEN ct.subname LIKE '%Mining%' THEN 93189
     WHEN ct.subname LIKE '%Skinning%' THEN 1292
     WHEN ct.subname LIKE '%Archaeology%' THEN 93538
     WHEN ct.subname LIKE '%Cook%' OR ct.subname LIKE '%Chef%' OR ct.subname LIKE '%Brewmaster%' OR ct.subname LIKE '%Noodle%' OR ct.subname LIKE '%Wok%' THEN 93536
     ELSE NULL END), 0, 0, 0, 0, 0
FROM creature_template ct JOIN creature c ON c.id=ct.entry
WHERE (ct.npcflag&16)>0 AND (ct.npcflag&32)=0
  AND ct.subname NOT LIKE '%Engineer%'
  AND NOT EXISTS(SELECT 1 FROM creature_default_trainer cdt WHERE cdt.CreatureId=ct.entry)
  AND NOT EXISTS(SELECT 1 FROM npc_trainer nt WHERE nt.ID=ct.entry)
  AND NOT EXISTS(SELECT 1 FROM gossip_menu_option g JOIN gossip_menu_option_trainer t
                 ON t.MenuId=g.MenuId AND t.OptionIndex=g.OptionIndex
                 WHERE g.MenuId=ct.gossip_menu_id AND g.OptionType=5)
  AND (CASE
     WHEN ct.subname LIKE '%Alchem%' THEN 1215
     WHEN ct.subname LIKE '%Blacksmith%' THEN 7230
     WHEN ct.subname LIKE '%Enchant%' THEN 1317
     WHEN ct.subname LIKE '%Jewelcraft%' THEN 65098
     WHEN ct.subname LIKE '%Leatherwork%' OR ct.subname LIKE '%Tanner%' THEN 1385
     WHEN ct.subname LIKE '%Tailor%' THEN 57405
     WHEN ct.subname LIKE '%Inscription%' THEN 92195
     WHEN ct.subname LIKE '%First Aid%' THEN 126022
     WHEN ct.subname LIKE '%Fish%' OR ct.subname LIKE '%Angler%' THEN 1680
     WHEN ct.subname LIKE '%Herbal%' THEN 1218
     WHEN ct.subname LIKE '%Mining%' THEN 93189
     WHEN ct.subname LIKE '%Skinning%' THEN 1292
     WHEN ct.subname LIKE '%Archaeology%' THEN 93538
     WHEN ct.subname LIKE '%Cook%' OR ct.subname LIKE '%Chef%' OR ct.subname LIKE '%Brewmaster%' OR ct.subname LIKE '%Noodle%' OR ct.subname LIKE '%Wok%' THEN 93536
     ELSE NULL END) IS NOT NULL
GROUP BY ct.entry;

-- ---------------------------------------------------------------------------
-- PART B — Option « s'entraîner » sur les MENUS DÉDIÉS (<>0) des maîtres de
--   métier gossip-flaggés qui n'en ont pas. (menu 0 jamais touché.)
--   OptionNpcFlag=16 -> visible uniquement pour les dresseurs. TrainerId=0 ->
--   fallback legacy. OptionIndex = MAX+1 par menu. À exécuter APRÈS Part A.
-- ---------------------------------------------------------------------------
INSERT INTO gossip_menu_option
  (MenuId, OptionIndex, OptionIcon, OptionText, OptionBroadcastTextId, OptionType, OptionNpcFlag, VerifiedBuild)
SELECT m.MenuId, m.maxidx+1, 3, 'Je voudrais m''entraîner.', 0, 5, 16, 26972
FROM (
  SELECT ct.gossip_menu_id AS MenuId, COALESCE(MAX(g.OptionIndex),-1) AS maxidx
  FROM creature_template ct JOIN creature c ON c.id=ct.entry
  LEFT JOIN gossip_menu_option g ON g.MenuId=ct.gossip_menu_id
  WHERE (ct.npcflag&16)>0 AND (ct.npcflag&32)=0 AND (ct.npcflag&1)>0
    AND ct.gossip_menu_id<>0
    AND ct.subname NOT LIKE '%Engineer%'
    AND EXISTS(SELECT 1 FROM npc_trainer nt WHERE nt.ID=ct.entry)
    AND NOT EXISTS(SELECT 1 FROM gossip_menu_option g2 WHERE g2.MenuId=ct.gossip_menu_id AND g2.OptionType=5)
    AND (CASE
       WHEN ct.subname LIKE '%Alchem%' THEN 1 WHEN ct.subname LIKE '%Blacksmith%' THEN 1
       WHEN ct.subname LIKE '%Enchant%' THEN 1 WHEN ct.subname LIKE '%Jewelcraft%' THEN 1
       WHEN ct.subname LIKE '%Leatherwork%' OR ct.subname LIKE '%Tanner%' THEN 1
       WHEN ct.subname LIKE '%Tailor%' THEN 1 WHEN ct.subname LIKE '%Inscription%' THEN 1
       WHEN ct.subname LIKE '%First Aid%' THEN 1 WHEN ct.subname LIKE '%Fish%' OR ct.subname LIKE '%Angler%' THEN 1
       WHEN ct.subname LIKE '%Herbal%' THEN 1 WHEN ct.subname LIKE '%Mining%' THEN 1
       WHEN ct.subname LIKE '%Skinning%' THEN 1 WHEN ct.subname LIKE '%Archaeology%' THEN 1
       WHEN ct.subname LIKE '%Cook%' OR ct.subname LIKE '%Chef%' OR ct.subname LIKE '%Brewmaster%' OR ct.subname LIKE '%Noodle%' OR ct.subname LIKE '%Wok%' THEN 1
       ELSE NULL END) IS NOT NULL
  GROUP BY ct.gossip_menu_id
) m;
