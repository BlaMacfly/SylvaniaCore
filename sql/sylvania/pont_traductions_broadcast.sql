-- =====================================================================
-- PONT DE TRADUCTIONS : broadcast_text_locale -> tables locale de TC
--
-- Constat : le client 7.3.5 embarque 88 288 traductions frFR officielles
-- (dc_hotfixes.broadcast_text_locale), mais TrinityCore lit les dialogues
-- de créatures dans dc_world.creature_text_locale (11 lignes !) et les
-- options de gossip dans gossip_menu_option_locale (18 lignes). Résultat :
-- tous les dialogues scriptés et menus s'affichaient en anglais alors que
-- les traductions officielles étaient déjà sur le serveur.
--
-- Ce patch construit le pont via les BroadcastTextId (déjà renseignés sur
-- 13 459 creature_text et 6 310 gossip_menu_option) :
--   +12 288 dialogues de créatures en frFR (91 % du serveur)
--   +5 605 options de gossip en frFR
-- Rejouable sans risque (INSERT IGNORE). Rechargeable à chaud :
--   reload locales_creature_text / reload locales_gossip_menu_option
-- =====================================================================

INSERT IGNORE INTO `creature_text_locale` (CreatureID, GroupID, ID, Locale, Text)
SELECT ct.CreatureID, ct.GroupID, ct.ID, 'frFR',
  CASE WHEN bt.Text1 IS NOT NULL AND bt.Text1 <> '' AND ct.Text = bt.Text1
       THEN COALESCE(NULLIF(l.Text1_lang, ''), NULLIF(l.Text_lang, ''))
       ELSE COALESCE(NULLIF(l.Text_lang, ''), NULLIF(l.Text1_lang, '')) END AS fr
FROM `creature_text` ct
JOIN `dc_hotfixes`.`broadcast_text` bt ON bt.ID = ct.BroadcastTextId
JOIN `dc_hotfixes`.`broadcast_text_locale` l ON l.ID = ct.BroadcastTextId AND l.locale = 'frFR'
WHERE ct.BroadcastTextId > 0
HAVING fr IS NOT NULL;

INSERT IGNORE INTO `gossip_menu_option_locale` (MenuId, OptionIndex, Locale, OptionText, BoxText)
SELECT g.MenuId, g.OptionIndex, 'frFR',
  COALESCE(NULLIF(lo.Text_lang, ''), NULLIF(lo.Text1_lang, '')), ''
FROM `gossip_menu_option` g
JOIN `dc_hotfixes`.`broadcast_text_locale` lo ON lo.ID = g.OptionBroadcastTextId AND lo.locale = 'frFR'
WHERE g.OptionBroadcastTextId > 0;
