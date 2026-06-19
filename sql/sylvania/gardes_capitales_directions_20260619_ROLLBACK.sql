-- Rollback gardes capitales directions (2026-06-19)
-- Remet les gossip_menu_id d'origine (tous etaient 0) et supprime les menus crees.
UPDATE creature_template SET gossip_menu_id=0 WHERE entry IN (1976,3296,4262);
DELETE FROM gossip_menu_option_action WHERE MenuId IN (99916,99917);
DELETE FROM gossip_menu_option WHERE MenuId IN (99916,99917);
DELETE FROM gossip_menu WHERE MenuID IN (99916,99917);
