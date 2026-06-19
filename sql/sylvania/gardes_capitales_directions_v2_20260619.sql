-- =====================================================================
-- Gardes capitales directions - VAGUE 2 (2026-06-19)
-- Etend le fix aux capitales restantes + sous-menus metiers.
--  - Dalaran-Legion (Kirin Tor Guardian 104091, map 1220) -> menu 99918
--    (POI serie 5xxx = Dalaran Iles Brisees, coords coherentes avec les spawns)
--  - Shattrath (City Peacekeeper 19687) -> menu 99919 (neutre, Aldor+Scryer)
--  - WoD Stormshield (Guard 86413, doublon) -> menu 17334 existant
--  - Orgrimmar/Darnassus : sous-menu "Profession Trainer" (99921/99922)
--    ajoute aux menus 99916/99917.
-- Note: Warspear (Grunt 86472) NON traite = aucun POI Warspear en base.
-- =====================================================================

-- ====================== DALARAN-LEGION (menu 99918) ======================
DELETE FROM gossip_menu WHERE MenuID=99918;
INSERT INTO gossip_menu (MenuID, TextID) VALUES (99918, 933);
DELETE FROM gossip_menu_option WHERE MenuId=99918;
INSERT INTO gossip_menu_option
 (MenuId, OptionIndex, OptionIcon, OptionText, OptionBroadcastTextId, OptionType, OptionNpcFlag, VerifiedBuild) VALUES
(99918,0,0,'Bank',0,1,1,0),
(99918,1,0,'Inn',0,1,1,0),
(99918,2,0,'Flight Master',0,1,1,0),
(99918,3,0,'Barber',0,1,1,0),
(99918,4,0,'Trade District',0,1,1,0);
DELETE FROM gossip_menu_option_action WHERE MenuId=99918;
INSERT INTO gossip_menu_option_action (MenuId, OptionIndex, ActionMenuId, ActionPoiId) VALUES
(99918,0,0,5122),  -- Bank          : Dalaran Northern Bank
(99918,1,0,5128),  -- Inn           : Dalaran Inn (neutral)
(99918,2,0,5124),  -- Flight Master : Dalaran Flight Master
(99918,3,0,5123),  -- Barber        : Dalaran Barber
(99918,4,0,5139);  -- Trade District: Dalaran Trade District
UPDATE creature_template SET gossip_menu_id=99918 WHERE entry=104091;

-- ====================== SHATTRATH (menu 99919) ======================
DELETE FROM gossip_menu WHERE MenuID=99919;
INSERT INTO gossip_menu (MenuID, TextID) VALUES (99919, 933);
DELETE FROM gossip_menu_option WHERE MenuId=99919;
INSERT INTO gossip_menu_option
 (MenuId, OptionIndex, OptionIcon, OptionText, OptionBroadcastTextId, OptionType, OptionNpcFlag, VerifiedBuild) VALUES
(99919,0,0,'Taxi (Flight Master)',0,1,1,0),
(99919,1,0,'Bank - Aldor',0,1,1,0),
(99919,2,0,'Bank - Scryer',0,1,1,0),
(99919,3,0,'Inn - Aldor',0,1,1,0),
(99919,4,0,'Inn - Scryer',0,1,1,0),
(99919,5,0,'Guild Services',0,1,1,0),
(99919,6,0,'City Center',0,1,1,0);
DELETE FROM gossip_menu_option_action WHERE MenuId=99919;
INSERT INTO gossip_menu_option_action (MenuId, OptionIndex, ActionMenuId, ActionPoiId) VALUES
(99919,0,0,10243),  -- Taxi            : Shattrath Taxi
(99919,1,0,10260),  -- Bank Aldor      : Shattrath Bank Aldor
(99919,2,0,10241),  -- Bank Scryer     : Shattrath Bank Scryer
(99919,3,0,10261),  -- Inn Aldor       : Shattrath Inn Aldor
(99919,4,0,10242),  -- Inn Scryer      : Shattrath Inn Scryer
(99919,5,0,10610),  -- Guild Services  : Shattrath Guild Services
(99919,6,0,10611);  -- City Center     : Shattrath City Center
UPDATE creature_template SET gossip_menu_id=99919 WHERE entry=19687;

-- ====================== WoD STORMSHIELD: doublon -> menu existant ======================
UPDATE creature_template SET gossip_menu_id=17334 WHERE entry=86413;

-- ====================== ORGRIMMAR: sous-menu Metiers (99921) ======================
-- ajoute l'option "Profession Trainer" (index 8) au menu principal 99916
DELETE FROM gossip_menu_option WHERE MenuId=99916 AND OptionIndex=8;
INSERT INTO gossip_menu_option
 (MenuId, OptionIndex, OptionIcon, OptionText, OptionBroadcastTextId, OptionType, OptionNpcFlag, VerifiedBuild) VALUES
(99916,8,0,'Profession Trainer',0,1,1,0);
DELETE FROM gossip_menu_option_action WHERE MenuId=99916 AND OptionIndex=8;
INSERT INTO gossip_menu_option_action (MenuId, OptionIndex, ActionMenuId, ActionPoiId) VALUES
(99916,8,99921,0);
-- le sous-menu lui-meme
DELETE FROM gossip_menu WHERE MenuID=99921;
INSERT INTO gossip_menu (MenuID, TextID) VALUES (99921, 933);
DELETE FROM gossip_menu_option WHERE MenuId=99921;
INSERT INTO gossip_menu_option
 (MenuId, OptionIndex, OptionIcon, OptionText, OptionBroadcastTextId, OptionType, OptionNpcFlag, VerifiedBuild) VALUES
(99921,0,0,'Alchemy',0,1,1,0),
(99921,1,0,'Cooking',0,1,1,0),
(99921,2,0,'Enchanting',0,1,1,0),
(99921,3,0,'Engineering',0,1,1,0),
(99921,4,0,'Fishing',0,1,1,0),
(99921,5,0,'Herbalism',0,1,1,0),
(99921,6,0,'Inscription',0,1,1,0),
(99921,7,0,'Jewelcrafting',0,1,1,0),
(99921,8,0,'Leatherworking',0,1,1,0),
(99921,9,0,'Mining',0,1,1,0),
(99921,10,0,'Tailoring',0,1,1,0);
DELETE FROM gossip_menu_option_action WHERE MenuId=99921;
INSERT INTO gossip_menu_option_action (MenuId, OptionIndex, ActionMenuId, ActionPoiId) VALUES
(99921,0,0,10279),
(99921,1,0,10281),
(99921,2,0,10282),
(99921,3,0,10307),
(99921,4,0,10284),
(99921,5,0,10285),
(99921,6,0,10189),
(99921,7,0,12639),
(99921,8,0,10287),
(99921,9,0,10288),
(99921,10,0,10289);

-- ====================== DARNASSUS: sous-menu Metiers (99922) ======================
DELETE FROM gossip_menu_option WHERE MenuId=99917 AND OptionIndex=7;
INSERT INTO gossip_menu_option
 (MenuId, OptionIndex, OptionIcon, OptionText, OptionBroadcastTextId, OptionType, OptionNpcFlag, VerifiedBuild) VALUES
(99917,7,0,'Profession Trainer',0,1,1,0);
DELETE FROM gossip_menu_option_action WHERE MenuId=99917 AND OptionIndex=7;
INSERT INTO gossip_menu_option_action (MenuId, OptionIndex, ActionMenuId, ActionPoiId) VALUES
(99917,7,99922,0);
DELETE FROM gossip_menu WHERE MenuID=99922;
INSERT INTO gossip_menu (MenuID, TextID) VALUES (99922, 933);
DELETE FROM gossip_menu_option WHERE MenuId=99922;
INSERT INTO gossip_menu_option
 (MenuId, OptionIndex, OptionIcon, OptionText, OptionBroadcastTextId, OptionType, OptionNpcFlag, VerifiedBuild) VALUES
(99922,0,0,'Alchemy',0,1,1,0),
(99922,1,0,'Blacksmithing',0,1,1,0),
(99922,2,0,'Cooking',0,1,1,0),
(99922,3,0,'Enchanting',0,1,1,0),
(99922,4,0,'First Aid',0,1,1,0),
(99922,5,0,'Fishing',0,1,1,0),
(99922,6,0,'Inscription',0,1,1,0),
(99922,7,0,'Leatherworking',0,1,1,0),
(99922,8,0,'Skinning',0,1,1,0),
(99922,9,0,'Tailoring',0,1,1,0);
DELETE FROM gossip_menu_option_action WHERE MenuId=99922;
INSERT INTO gossip_menu_option_action (MenuId, OptionIndex, ActionMenuId, ActionPoiId) VALUES
(99922,0,0,10102),
(99922,1,0,10462),
(99922,2,0,10103),
(99922,3,0,10104),
(99922,4,0,10105),
(99922,5,0,10106),
(99922,6,0,10107),
(99922,7,0,10108),
(99922,8,0,10109),
(99922,9,0,10110);
