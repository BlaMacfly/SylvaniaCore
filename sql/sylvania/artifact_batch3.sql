-- ============================================================
-- Lot 3 : Voleur Finesse « Crocs du Dévoreur » (map 1607, boss Akaari)
--       + Démoniste Destruction « Sceptre de Sargeras » (map 1630, Tol Barad)
-- ============================================================

-- ---------- Voleur Finesse (1607) — ancres officielles par étape ----------
REPLACE INTO scenario_artifact_config VALUES
(1607, 1854.6, 1409.7, 91.7, 4.7,  994, -4245.0, -2660.5, 17.6, 1.6,  0, 'Rogue Subtlety - Fangs of the Devourer (Akaari)');
REPLACE INTO scenario_artifact_stage (map, stage, idx, entry, x, y, z, o, cnt, lvl, teleport) VALUES
(1607, 1, 0, 98286, 1854.6, 1351.5, 66.4, 4.7, 4, 99, 0),
(1607, 1, 1, 97966, 1845.0, 1345.0, 66.4, 4.7, 2, 100, 0),
(1607, 2, 0, 98505, 1847.9, 1260.4, 57.1, 1.2, 3, 100, 0),
(1607, 2, 1, 98785, 1840.0, 1268.0, 57.1, 1.2, 3, 99, 0),
(1607, 3, 0, 105450, 1817.9, 1288.3, 91.7, 5.9, 1, 102, 1);

-- ---------- Démoniste Destruction (1630) — Tol Barad puis fort Baradin ----------
REPLACE INTO scenario_artifact_config VALUES
(1630, -845.7, 1186.7, 114.3, 3.1,  994, -4245.0, -2660.5, 17.6, 1.6,  0, 'Warlock Destruction - Scepter of Sargeras (Tol Barad)');
REPLACE INTO scenario_artifact_stage (map, stage, idx, entry, x, y, z, o, cnt, lvl, teleport) VALUES
(1630, 1, 0, 98286, -880.0, 1180.0, 113.0, 0.2, 4, 99, 0),
(1630, 1, 1, 98785, -890.0, 1192.0, 112.5, 0.2, 2, 99, 0),
(1630, 2, 0, 98505, -1058.1, 1149.3, 107.5, 0.3, 4, 100, 0),
(1630, 3, 0, 90663, -354.9, -4528.9, 170.2, 0.8, 1, 102, 1),
(1630, 3, 1, 98286, -365.0, -4520.0, 170.2, 0.8, 2, 100, 0);

-- gabarits
UPDATE creature_template SET faction=16, minlevel=102, maxlevel=102, HealthModifier=GREATEST(HealthModifier*10,10), `rank`=3 WHERE entry IN (105450,90663);

-- scénario Voleur Finesse identifié : 1078 « The Fangs of the Devourer »
REPLACE INTO scenarios (map, difficulty, scenario_A, scenario_H, zoneid) VALUES (1607, 0, 1078, 1078, 0);
UPDATE instance_template SET script='scenario_artifact_runner_1607' WHERE map=1607;
UPDATE instance_template SET script='scenario_artifact_runner_1630' WHERE map=1630;

-- porte d'entrée : options 40/41 du Gardien
DELETE FROM gossip_menu_option WHERE MenuId=61000 AND OptionIndex IN (40,41);
INSERT INTO gossip_menu_option (MenuId, OptionIndex, OptionIcon, OptionText, OptionBroadcastTextId, OptionType, OptionNpcFlag, VerifiedBuild) VALUES
(61000, 40, 0, 'Scénario d''acquisition : Les Crocs du Dévoreur — Akaari (Voleur Finesse)', 0, 1, 1, 0),
(61000, 41, 0, 'Scénario d''acquisition : Le Sceptre de Sargeras — Tol Barad (Démoniste Destruction)', 0, 1, 1, 0);
DELETE FROM smart_scripts WHERE entryorguid=990000 AND source_type=0 AND id IN (40,41);
INSERT INTO smart_scripts (entryorguid, source_type, id, link, event_type, event_phase_mask, event_chance, event_flags, event_param1, event_param2, event_param3, event_param4, action_type, action_param1, action_param2, action_param3, action_param4, action_param5, action_param6, target_type, target_param1, target_param2, target_param3, target_x, target_y, target_z, target_o, comment) VALUES
(990000, 0, 40, 0, 62, 0, 100, 0, 61000, 40, 0, 0, 62, 1607, 0, 0, 0, 0, 0, 7, 0, 0, 0, 1854.6, 1409.7, 92.0, 4.7, 'Gardien - teleport scenario Voleur Finesse (1607)'),
(990000, 0, 41, 0, 62, 0, 100, 0, 61000, 41, 0, 0, 62, 1630, 0, 0, 0, 0, 0, 7, 0, 0, 0, -845.7, 1186.7, 114.6, 3.1, 'Gardien - teleport scenario Demoniste Destru (1630)');

-- textes FR des boss
DELETE FROM creature_text WHERE CreatureID IN (105450,90663);
INSERT INTO creature_text (CreatureID, GroupID, ID, Text, Type, Language, Probability, Emote, Duration, Sound, BroadcastTextId, TextRange, comment) VALUES
(105450, 0, 0, 'Les Crocs sont à moi, petit voleur. Ton ombre sera ton linceul.', 14, 0, 100, 15, 0, 0, 0, 0, 'Akaari spawn'),
(90663, 0, 0, 'Le Sceptre restera scellé, mortel ! Baradin sera ta tombe !', 14, 0, 100, 15, 0, 0, 0, 0, 'Perdition spawn');
