-- =====================================================================
-- Quete 39800 "Greymane's Gambit" - CORRECTIF v3 (2026-06-19)
-- v2 (gossip-hello + condition SMART_EVENT) ne s'est pas declenche :
--   Genn = donneur (pas rendeur) d'une quete en cours -> le clic n'ouvrait
--   pas d'interaction / l'event ne partait pas.
-- v3 = OPTION DE DIALOGUE explicite (mecanisme le plus fiable) :
--   Genn recoit gossip_menu 99923 + npcflag gossip, avec une option
--   "Lancer le stratageme" visible UNIQUEMENT si le joueur a la quete 39800
--   (condition gossip_menu_option type 15). La selectionner (event 62
--   GOSSIP_SELECT) -> credit 113320 + fermeture gossip + teleport Stormheim.
-- Necessite un RESTART (re-init IA + npcflag + gossip de Genn).
-- =====================================================================

-- 1) Nettoyer l'approche v2 (event 64 + conditions SMART_EVENT type 22)
DELETE FROM smart_scripts WHERE entryorguid=96663 AND source_type=0 AND id IN (1,2);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=96663 AND SourceId=0 AND SourceGroup IN (2,3);

-- 2) Genn : gossip_menu + npcflag gossip (garde questgiver)
UPDATE creature_template SET gossip_menu_id=99923 WHERE entry=96663;
UPDATE creature SET npcflag=3 WHERE guid=280001398;  -- 1 gossip + 2 questgiver

-- 3) Le menu + l'option
DELETE FROM gossip_menu WHERE MenuID=99923;
INSERT INTO gossip_menu (MenuID, TextID) VALUES (99923, 933);
DELETE FROM gossip_menu_option WHERE MenuId=99923;
INSERT INTO gossip_menu_option
 (MenuId, OptionIndex, OptionIcon, OptionText, OptionBroadcastTextId, OptionType, OptionNpcFlag, VerifiedBuild) VALUES
(99923, 0, 0, 'Lancer le stratageme de Grisetete.', 0, 1, 1, 0);

-- 4) Condition : option visible seulement si le joueur a la quete 39800 (type 9 QUEST_TAKEN)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=99923 AND SourceEntry=0;
INSERT INTO conditions
(SourceTypeOrReferenceId,SourceGroup,SourceEntry,SourceId,ElseGroup,ConditionTypeOrReference,ConditionTarget,
 ConditionValue1,ConditionValue2,ConditionValue3,NegativeCondition,ErrorType,ErrorTextId,ScriptName,Comment) VALUES
(15, 99923, 0, 0, 0, 9, 0, 39800, 0, 0, 0, 0, 0, '', 'Greymane Gambit - option visible si quete 39800 prise');

-- 5) SmartAI gossip-select (event 62) -> credit + close + teleport (chaine via link)
INSERT INTO smart_scripts
(entryorguid,source_type,id,link,event_type,event_phase_mask,event_chance,event_flags,
 event_param1,event_param2,event_param3,event_param4,event_param5,
 action_type,action_param1,action_param2,action_param3,action_param4,action_param5,action_param6,
 target_type,target_param1,target_param2,target_param3,target_x,target_y,target_z,target_o,comment) VALUES
(96663,0,1,2,62,0,100,0, 99923,0,0,0,0, 33,113320,0,0,0,0,0, 7,0,0,0, 0,0,0,0,        'Greymane Gambit - gossip select 99923/0: credit Scenario Complete 113320'),
(96663,0,2,3,61,0,100,0, 0,0,0,0,0,      72,0,0,0,0,0,0,       1,0,0,0, 0,0,0,0,        'Greymane Gambit - link: close gossip'),
(96663,0,3,0,61,0,100,0, 0,0,0,0,0,      62,1220,0,0,0,0,0,    7,0,0,0, 3207,3077,440,3.14, 'Greymane Gambit - link: teleport player to Stormheim near Rogers 90749');
