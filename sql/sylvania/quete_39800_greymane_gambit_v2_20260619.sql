-- =====================================================================
-- Quete 39800 "Greymane's Gambit" - CORRECTIF v2 (2026-06-19)
-- L'event 19 (ACCEPTED_QUEST) ne se declenche PAS sur ce core (le re-accept
-- ne creditait ni ne teleportait). On bascule sur l'event 64 (GOSSIP_HELLO,
-- PROUVE fonctionnel sur Genn via le credit 38206), CONDITIONNE a avoir la
-- quete 39800 (sinon tout cliqueur serait teleporte).
--
-- => Le joueur, ayant 39800 en journal, CLIQUE Genn (96663) :
--    credit 113320 (Scenario Complete) + teleport Stormheim pres de Rogers 90749.
-- Conditions: type 22 (SMART_EVENT), SourceGroup = (smart id + 1),
--   ConditionType 9 (QUEST_TAKEN) sur quete 39800.
-- =====================================================================

-- retire l'ancienne approche event-19 (inoperante)
DELETE FROM smart_scripts WHERE entryorguid=96663 AND source_type=0 AND id IN (1,2);
INSERT INTO smart_scripts
(entryorguid,source_type,id,link,event_type,event_phase_mask,event_chance,event_flags,
 event_param1,event_param2,event_param3,event_param4,event_param5,
 action_type,action_param1,action_param2,action_param3,action_param4,action_param5,action_param6,
 target_type,target_param1,target_param2,target_param3,target_x,target_y,target_z,target_o,comment) VALUES
(96663,0,1,0,64,0,100,0, 0,0,0,0,0, 33,113320,0,0,0,0,0, 7,0,0,0, 0,0,0,0, 'Greymane Gambit - gossip hello (si quete 39800): credit Scenario Complete 113320'),
(96663,0,2,0,64,0,100,0, 0,0,0,0,0, 62,1220,0,0,0,0,0,    7,0,0,0, 3207,3077,440,3.14, 'Greymane Gambit - gossip hello (si quete 39800): teleport Stormheim pres Rogers 90749');

-- conditions: gate les deux regles a "joueur a la quete 39800 en journal"
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=96663 AND SourceId=0 AND SourceGroup IN (2,3);
INSERT INTO conditions
(SourceTypeOrReferenceId,SourceGroup,SourceEntry,SourceId,ElseGroup,ConditionTypeOrReference,ConditionTarget,
 ConditionValue1,ConditionValue2,ConditionValue3,NegativeCondition,ErrorType,ErrorTextId,ScriptName,Comment) VALUES
(22,2,96663,0,0, 9,0, 39800,0,0, 0,0,0,'','Greymane Gambit - credit only if player on quest 39800'),
(22,3,96663,0,0, 9,0, 39800,0,0, 0,0,0,'','Greymane Gambit - teleport only if player on quest 39800');
