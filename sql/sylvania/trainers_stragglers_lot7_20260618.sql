-- La Légion de Sylvania — Lot 7 : 2 dresseurs résiduels (données OK, menu
-- dédié sans option type-5) que le mapping par sous-titre des lots 5-6 n a
-- pas couverts : 45286 KTC Train-a-Tron Deluxe (multi-métiers, 120 sorts),
-- 79519 Reshad (Scrollkeeper, 9 sorts). Generic : tout dresseur non-classe,
-- gossip-flaggé, menu dédié, AVEC données legacy, sans option type-5.
-- Date 2026-06-18. Effet : .reload gossip_menu_option. Rollback inline ci-dessous.
SET NAMES utf8;
INSERT INTO gossip_menu_option (MenuId, OptionIndex, OptionIcon, OptionText, OptionBroadcastTextId, OptionType, OptionNpcFlag, VerifiedBuild)
SELECT m.MenuId, m.maxidx+1, 3, "Je voudrais m'entraîner.", 0, 5, 16, 26972
FROM (
  SELECT ct.gossip_menu_id AS MenuId, COALESCE(MAX(g.OptionIndex),-1) AS maxidx
  FROM creature_template ct JOIN creature c ON c.id=ct.entry
  LEFT JOIN gossip_menu_option g ON g.MenuId=ct.gossip_menu_id
  WHERE (ct.npcflag&16)>0 AND (ct.npcflag&32)=0 AND (ct.npcflag&1)>0 AND ct.gossip_menu_id<>0
    AND EXISTS(SELECT 1 FROM npc_trainer nt WHERE nt.ID=ct.entry)
    AND NOT EXISTS(SELECT 1 FROM gossip_menu_option g2 WHERE g2.MenuId=ct.gossip_menu_id AND g2.OptionType=5)
  GROUP BY ct.gossip_menu_id
) m;
