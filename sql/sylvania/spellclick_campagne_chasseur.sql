-- Clics de sort (npc_spellclick_spells) absents ou sans drapeau UNIT_NPC_FLAG_SPELLCLICK : PNJ non cliquables.
-- Cas vecu : la statue d Ohn ahra (102694) de « Un serment d allegeance » (40955), Blez le 29/09/2026.
-- Notre core n ajoute PAS le drapeau tout seul (ObjectMgr::LoadNPCSpellClickSpells ne fait que le retirer).
-- Lignes reprises de LegionCore ; 64367 Invisible Man ecarte (siege de vehicule, pas un PNJ a cliquer).
INSERT IGNORE INTO npc_spellclick_spells (npc_entry,spell_id,cast_flags,user_type) VALUES (108243,215243,1,0);
INSERT IGNORE INTO npc_spellclick_spells (npc_entry,spell_id,cast_flags,user_type) VALUES (108244,215243,1,0);
INSERT IGNORE INTO npc_spellclick_spells (npc_entry,spell_id,cast_flags,user_type) VALUES (108245,215243,1,0);
INSERT IGNORE INTO npc_spellclick_spells (npc_entry,spell_id,cast_flags,user_type) VALUES (109721,215243,1,0);
INSERT IGNORE INTO npc_spellclick_spells (npc_entry,spell_id,cast_flags,user_type) VALUES (109759,215243,1,0);
INSERT IGNORE INTO npc_spellclick_spells (npc_entry,spell_id,cast_flags,user_type) VALUES (110075,219297,1,0);
INSERT IGNORE INTO npc_spellclick_spells (npc_entry,spell_id,cast_flags,user_type) VALUES (110076,213297,1,0);
INSERT IGNORE INTO npc_spellclick_spells (npc_entry,spell_id,cast_flags,user_type) VALUES (117245,233571,1,0);
INSERT IGNORE INTO npc_spellclick_spells (npc_entry,spell_id,cast_flags,user_type) VALUES (117272,233554,1,0);
INSERT IGNORE INTO npc_spellclick_spells (npc_entry,spell_id,cast_flags,user_type) VALUES (117397,233758,1,0);
INSERT IGNORE INTO npc_spellclick_spells (npc_entry,spell_id,cast_flags,user_type) VALUES (117398,233758,1,0);
INSERT IGNORE INTO npc_spellclick_spells (npc_entry,spell_id,cast_flags,user_type) VALUES (118071,234519,1,0);
INSERT IGNORE INTO npc_spellclick_spells (npc_entry,spell_id,cast_flags,user_type) VALUES (118321,46598,1,0);
INSERT IGNORE INTO npc_spellclick_spells (npc_entry,spell_id,cast_flags,user_type) VALUES (118635,235436,1,0);
INSERT IGNORE INTO npc_spellclick_spells (npc_entry,spell_id,cast_flags,user_type) VALUES (118664,235436,1,0);
INSERT IGNORE INTO npc_spellclick_spells (npc_entry,spell_id,cast_flags,user_type) VALUES (118671,235436,1,0);
INSERT IGNORE INTO npc_spellclick_spells (npc_entry,spell_id,cast_flags,user_type) VALUES (118674,235436,1,0);
INSERT IGNORE INTO npc_spellclick_spells (npc_entry,spell_id,cast_flags,user_type) VALUES (119153,233554,1,0);
UPDATE creature_template SET npcflag = npcflag | 16777216 WHERE entry IN (95869,102694,108243,108244,108245,109721,109759,110075,110076,117245,117272,117397,117398,118071,118321,118635,118664,118671,118674,119153);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=18 AND SourceGroup IN (102694,117245);
INSERT INTO conditions (SourceTypeOrReferenceId,SourceGroup,SourceEntry,SourceId,ElseGroup,ConditionTypeOrReference,ConditionTarget,ConditionValue1,ConditionValue2,ConditionValue3,NegativeCondition,ErrorType,ErrorTextId,ScriptName,Comment) VALUES
(18,102694,203240,0,0,9,0,40955,0,0,0,0,0,"","Statue d Ohn ahra cliquable avec Un serment d allegeance en cours"),
(18,117245,233571,0,0,9,0,45552,0,0,0,0,0,"","D Bynn : quete 45552 en cours"),
(18,117245,233571,0,0,48,0,288173,0,0,0,0,0,"","D Bynn : objectif 117450 de 45552 accompli (LegionCore)");
