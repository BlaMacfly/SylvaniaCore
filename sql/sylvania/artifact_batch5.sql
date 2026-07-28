-- ============================================================
-- Lot 5 : Voleur Assassinat « Les Tueurs-de-rois » (map 1620, manoir Ravenholdt)
--       + « L'Arcway » (map 1632, Suramar)
-- ============================================================

-- ---------- Voleur Assassinat (1620) — ancres officielles par étapes ----------
REPLACE INTO scenario_artifact_config VALUES
(1620, -9127.9, 389.1, 91.2, 0.6,  994, -4245.0, -2660.5, 17.6, 1.6,  0, 'Rogue Assassination - Kingslayers (Ravenholdt)');
REPLACE INTO scenario_artifact_stage (map, stage, idx, entry, x, y, z, o, cnt, lvl, teleport) VALUES
(1620, 1, 0, 98286, -8847.8, 568.4, 94.7, 4.3, 4, 99, 0),
(1620, 1, 1, 98785, -8858.0, 560.0, 94.7, 4.3, 2, 99, 0),
(1620, 2, 0, 97966, -8637.6, 419.2, 103.7, 5.4, 3, 100, 0),
(1620, 2, 1, 98505, -8647.0, 428.0, 103.7, 5.4, 2, 100, 0),
(1620, 3, 0, 98217, -8346.1, 268.4, 155.3, 0.7, 1, 102, 1);

-- ---------- L'Arcway (1632) — couloirs de Suramar ----------
REPLACE INTO scenario_artifact_config VALUES
(1632, 3161.9, 5161.2, 623.2, 4.6,  994, -4245.0, -2660.5, 17.6, 1.6,  0, 'Arcway (Suramar) - Duskwatch');
REPLACE INTO scenario_artifact_stage (map, stage, idx, entry, x, y, z, o, cnt, lvl, teleport) VALUES
(1632, 1, 0, 113166, 3150.0, 5130.0, 623.2, 1.5, 4, 99, 0),
(1632, 1, 1, 115253, 3142.0, 5138.0, 623.2, 1.5, 2, 100, 0),
(1632, 2, 0, 113166, 3130.0, 5100.0, 623.2, 1.5, 3, 100, 0),
(1632, 2, 1, 115253, 3122.0, 5108.0, 623.2, 1.5, 2, 100, 0),
(1632, 3, 0, 115594, 3110.0, 5075.0, 623.2, 1.5, 1, 102, 0);

-- gabarits
UPDATE creature_template SET faction=16, minlevel=102, maxlevel=102, HealthModifier=GREATEST(HealthModifier*10,10), `rank`=3 WHERE entry=115594;
UPDATE creature_template SET faction=16, minlevel=99, maxlevel=100, HealthModifier=GREATEST(HealthModifier*2,2) WHERE entry IN (113166,115253);

UPDATE instance_template SET script='scenario_artifact_runner_1620' WHERE map=1620;
UPDATE instance_template SET script='scenario_artifact_runner_1632' WHERE map=1632;

-- porte d'entrée : options 44/45
DELETE FROM gossip_menu_option WHERE MenuId=61000 AND OptionIndex IN (44,45);
INSERT INTO gossip_menu_option (MenuId, OptionIndex, OptionIcon, OptionText, OptionBroadcastTextId, OptionType, OptionNpcFlag, VerifiedBuild) VALUES
(61000, 44, 0, 'Scénario d''acquisition : Les Tueurs-de-rois — manoir Ravenholdt (Voleur Assassinat)', 0, 1, 1, 0),
(61000, 45, 0, 'Scénario : L''Arcway — les profondeurs de Suramar (défi)', 0, 1, 1, 0);
DELETE FROM smart_scripts WHERE entryorguid=990000 AND source_type=0 AND id IN (44,45);
INSERT INTO smart_scripts (entryorguid, source_type, id, link, event_type, event_phase_mask, event_chance, event_flags, event_param1, event_param2, event_param3, event_param4, action_type, action_param1, action_param2, action_param3, action_param4, action_param5, action_param6, target_type, target_param1, target_param2, target_param3, target_x, target_y, target_z, target_o, comment) VALUES
(990000, 0, 44, 0, 62, 0, 100, 0, 61000, 44, 0, 0, 62, 1620, 0, 0, 0, 0, 0, 7, 0, 0, 0, -9127.9, 389.1, 91.5, 0.6, 'Gardien - teleport scenario Voleur Assassinat (1620)'),
(990000, 0, 45, 0, 62, 0, 100, 0, 61000, 45, 0, 0, 62, 1632, 0, 0, 0, 0, 0, 7, 0, 0, 0, 3161.9, 5161.2, 623.5, 4.6, 'Gardien - teleport scenario Arcway (1632)');

-- texte FR du boss Arcway
DELETE FROM creature_text WHERE CreatureID=115594;
INSERT INTO creature_text (CreatureID, GroupID, ID, Text, Type, Language, Probability, Emote, Duration, Sound, BroadcastTextId, TextRange, comment) VALUES
(115594, 0, 0, 'Nul ne profane l''Arcway. La sentence est la mort.', 14, 0, 100, 15, 0, 0, 0, 0, 'Adjudicateur spawn');
