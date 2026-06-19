-- =====================================================================
-- Gardes des capitales: gossip "directions" (ou se trouvent les PNJ)
-- Probleme: gardes spawnes ont le flag gossip mais gossip_menu_id=0
--   -> fenetre vide, aucune direction.
-- Hurlevent: menu directions 435 existe deja (garde 68 OK) -> on relie
--   le patrouilleur 1976.
-- Orgrimmar (Grunt 3296) et Darnassus (Sentinel 4262): AUCUN menu
--   directions -> on construit (menus 99916 / 99917), pointant vers les
--   points_of_interest deja presents en base.
-- Motif option: OptionType=1, OptionNpcFlag=1, ActionMenuId=0,
--   ActionPoiId=<poi> (envoie le POI sur la carte). Greeting reutilise
--   le texte 933 (greeting guide generique).
-- Date: 2026-06-19
-- =====================================================================

-- ---------- HURLEVENT: relier le patrouilleur au menu existant 435 ----------
UPDATE creature_template SET gossip_menu_id=435 WHERE entry=1976;

-- ====================== ORGRIMMAR (menu 99916) ======================
DELETE FROM gossip_menu WHERE MenuID=99916;
INSERT INTO gossip_menu (MenuID, TextID) VALUES (99916, 933);

DELETE FROM gossip_menu_option WHERE MenuId=99916;
INSERT INTO gossip_menu_option
 (MenuId, OptionIndex, OptionIcon, OptionText, OptionBroadcastTextId, OptionType, OptionNpcFlag, VerifiedBuild) VALUES
(99916,0,0,'Bank',0,1,1,0),
(99916,1,0,'Auction House',0,1,1,0),
(99916,2,0,'Inn',0,1,1,0),
(99916,3,0,'Flight Master',0,1,1,0),
(99916,4,0,'Mailbox',0,1,1,0),
(99916,5,0,'Barber',0,1,1,0),
(99916,6,0,'Battle Pet Trainer',0,1,1,0),
(99916,7,0,'Battlemasters',0,1,1,0);

DELETE FROM gossip_menu_option_action WHERE MenuId=99916;
INSERT INTO gossip_menu_option_action (MenuId, OptionIndex, ActionMenuId, ActionPoiId) VALUES
(99916,0,0,10267),  -- Bank             : Orgrimmar Bank
(99916,1,0,10347),  -- Auction House    : Orgrimmar Auction House
(99916,2,0,10179),  -- Inn              : Orgrimmar Inn
(99916,3,0,10268),  -- Flight Master    : Orgrimmar Flight Master
(99916,4,0,10180),  -- Mailbox          : Orgrimmar Mailbox
(99916,5,0,10188),  -- Barber           : Orgrimmar Barber
(99916,6,0,12888),  -- Battle Pet       : Orgrimmar Battle Pet Trainer
(99916,7,0,10187);  -- Battlemasters    : Battlemasters Orgrimmar

UPDATE creature_template SET gossip_menu_id=99916 WHERE entry=3296;

-- ====================== DARNASSUS (menu 99917) ======================
DELETE FROM gossip_menu WHERE MenuID=99917;
INSERT INTO gossip_menu (MenuID, TextID) VALUES (99917, 933);

DELETE FROM gossip_menu_option WHERE MenuId=99917;
INSERT INTO gossip_menu_option
 (MenuId, OptionIndex, OptionIcon, OptionText, OptionBroadcastTextId, OptionType, OptionNpcFlag, VerifiedBuild) VALUES
(99917,0,0,'Bank',0,1,1,0),
(99917,1,0,'Auction House',0,1,1,0),
(99917,2,0,'Inn',0,1,1,0),
(99917,3,0,'Hippogryph Master',0,1,1,0),
(99917,4,0,'Guild Master',0,1,1,0),
(99917,5,0,'Mailbox',0,1,1,0),
(99917,6,0,'Battlemasters',0,1,1,0);

DELETE FROM gossip_menu_option_action WHERE MenuId=99917;
INSERT INTO gossip_menu_option_action (MenuId, OptionIndex, ActionMenuId, ActionPoiId) VALUES
(99917,0,0,10090),  -- Bank              : Darnassus Bank
(99917,1,0,10089),  -- Auction House     : Darnassus Auction House
(99917,2,0,10093),  -- Inn               : Darnassus Inn
(99917,3,0,10091),  -- Hippogryph Master : Darnassus Hippogryph Master
(99917,4,0,10092),  -- Guild Master      : Darnassus Guild Master
(99917,5,0,10094),  -- Mailbox           : Darnassus Mailbox
(99917,6,0,10097);  -- Battlemasters     : Battlemasters Darnassus

UPDATE creature_template SET gossip_menu_id=99917 WHERE entry=4262;
