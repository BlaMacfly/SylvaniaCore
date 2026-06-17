SET @ENTRY := 107588;
DELETE FROM smart_scripts WHERE entryOrGuid = 107588 AND source_type = 0;
UPDATE creature_template SET AIName="SmartAI", spell1="215000" ,spell2="215041",spell3="215075",IconName="openhand", npcflag="0" WHERE entry= @ENTRY;
INSERT INTO smart_scripts (entryorguid, source_type, id, link, event_type, event_phase_mask, event_chance, event_flags, event_param1, event_param2, event_param3, event_param4, action_type, action_param1, action_param2, action_param3, action_param4, action_param5, action_param6, target_type, target_param1, target_param2, target_param3, target_x, target_y, target_z, target_o, comment) VALUES
(@ENTRY, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 18, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On respawn  - Self: Set UNIT_FLAGS to UNIT_FLAG_IMMUNE_TO_PC"),
(@ENTRY, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 18, 32768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On link - Self: Set UNIT_FLAGS to UNIT_FLAG_UNK_15"),
(@ENTRY, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 82, 16777216, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On link - Self: Add npc flags UNIT_NPC_FLAG_SPELLCLICK"),
(@ENTRY, 0, 3, 0, 4, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On aggro - Self: Attack Self"),
(@ENTRY, 0, 4, 5, 73, 0, 100, 0, 0, 0, 0, 0, 11, 214669, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On spellclick - Self: Cast spell 214669 on Self"),
(@ENTRY, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "On link - Self: Set event phase to 1"),
(@ENTRY, 0, 6, 7, 60, 1, 100, 0, 60, 60, 0, 0, 83, 16777216, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Time = 60 seconds - Self: Remove npc flags UNIT_NPC_FLAG_SPELLCLICK"),
(@ENTRY, 0, 7, 8, 61, 0, 100, 0, 0, 0, 0, 0, 19, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On link - Self: Remove UNIT_FLAGS to UNIT_FLAG_IMMUNE_TO_PC"),
(@ENTRY, 0, 8, 9, 61, 0, 100, 0, 0, 0, 0, 0, 19, 32768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On link - Self: Remove UNIT_FLAGS to UNIT_FLAG_UNK_15"),
(@ENTRY, 0, 9, 0, 61, 0, 100, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "On link - Self: Set event phase to 0"),
(@ENTRY, 0, 10, 0, 19, 0, 100, 0, 42641, 0, 0, 0, 82, 16777216, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "When player accepts quest 42641 - Self: Add npc flags UNIT_NPC_FLAG_SPELLCLICK"),
(@ENTRY, 0, 11,0,0,0,100,0,1000,3000,26000,28000,11,213738,0,0,0,0,0,5,0,0,0,0,0,0,0,"Blood-Thane Lucard - In Combat - 'Taste of Blood'"),	
(@ENTRY, 0, 12,0,0,0,100,0,6000,8000,31000,33000,11,215000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Blood-Thane Lucard - In Combat - 'Consume the Living'"),
(@ENTRY, 0, 13,0,0,0,100,0,11000,13000,36000,38000,11,215041,0,0,0,0,0,8,0,0,0,0,0,0,0,"Blood-Thane Lucard - In Combat - 'Lingering Hunger'"),	
(@ENTRY, 0, 14,0,0,0,100,0,16000,18000,41000,43000,11,215075,0,0,0,0,0,1,0,0,0,0,0,0,0,"Blood-Thane Lucard - In Combat - 'Blood Ritual'"),	
(@ENTRY, 0, 16,0,0,0,100,0,21000,23000,46000,48000,11,215377,0,0,0,0,0,5,0,0,0,0,0,0,0,"Blood-Thane Lucard - In Combat - 'The Maw Must Feed'");
