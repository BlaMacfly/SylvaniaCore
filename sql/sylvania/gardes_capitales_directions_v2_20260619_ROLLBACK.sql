-- Rollback gardes capitales directions VAGUE 2 (2026-06-19)
UPDATE creature_template SET gossip_menu_id=0 WHERE entry IN (104091,19687,86413);
-- options metiers ajoutees aux menus existants
DELETE FROM gossip_menu_option_action WHERE MenuId=99916 AND OptionIndex=8;
DELETE FROM gossip_menu_option WHERE MenuId=99916 AND OptionIndex=8;
DELETE FROM gossip_menu_option_action WHERE MenuId=99917 AND OptionIndex=7;
DELETE FROM gossip_menu_option WHERE MenuId=99917 AND OptionIndex=7;
-- menus crees
DELETE FROM gossip_menu_option_action WHERE MenuId IN (99918,99919,99921,99922);
DELETE FROM gossip_menu_option WHERE MenuId IN (99918,99919,99921,99922);
DELETE FROM gossip_menu WHERE MenuID IN (99918,99919,99921,99922);
