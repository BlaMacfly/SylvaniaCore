-- ============================================================
-- Lot 7 : Chasseur BM à Ulduar « Thunder of the Titans » (1068, map 1579)
--       + DK « Rescue Koltira » (1134, map 1617)
-- ============================================================

-- ---------- Ulduar / Chasseur BM (1579) ----------
REPLACE INTO scenario_artifact_config VALUES
(1579, 2340.8, 2575.4, 419.3, 0.0,  994, -4245.0, -2660.5, 17.6, 1.6,  0, 'Hunter BM - Thunder of the Titans (Ulduar)');
REPLACE INTO scenario_artifact_stage (map, stage, idx, entry, x, y, z, o, cnt, lvl, teleport) VALUES
(1579, 1, 0, 102019, 2380.0, 2575.0, 419.3, 3.2, 4, 99, 0),
(1579, 1, 1, 116763, 2390.0, 2565.0, 419.3, 3.2, 2, 100, 0),
(1579, 2, 0, 102019, 2704.0, 2569.2, 364.3, 3.2, 4, 100, 1),
(1579, 3, 0, 114362, 2730.0, 2569.0, 364.3, 3.2, 1, 102, 0);

-- ---------- Rescue Koltira (1617) ----------
REPLACE INTO scenario_artifact_config VALUES
(1617, 1668.2, 731.0, 77.3, 0.0,  994, -4245.0, -2660.5, 17.6, 1.6,  0, 'DK - Rescue Koltira');
REPLACE INTO scenario_artifact_stage (map, stage, idx, entry, x, y, z, o, cnt, lvl, teleport) VALUES
(1617, 1, 0,  99664, 1695.0, 735.0, 77.3, 3.2, 4, 99, 0),
(1617, 1, 1, 116287, 1703.0, 727.0, 77.3, 3.2, 2, 100, 0),
(1617, 2, 0, 116287, 1730.0, 740.0, 77.3, 3.2, 4, 100, 0),
(1617, 3, 0, 106669, 1760.0, 745.0, 77.3, 3.2, 1, 102, 0);

-- rattachement scénarios officiels + scripts d'instance
REPLACE INTO scenarios (map, difficulty, scenario_A, scenario_H, zoneid) VALUES (1579, 0, 1068, 1068, 0), (1617, 0, 1134, 1134, 0);
UPDATE instance_template SET script='scenario_artifact_runner_1579' WHERE map=1579;
UPDATE instance_template SET script='scenario_artifact_runner_1617' WHERE map=1617;

-- porte d'entrée : options 48/49
DELETE FROM gossip_menu_option WHERE MenuId=61000 AND OptionIndex IN (48,49);
INSERT INTO gossip_menu_option (MenuId, OptionIndex, OptionIcon, OptionText, OptionBroadcastTextId, OptionType, OptionNpcFlag, VerifiedBuild) VALUES
(61000, 48, 0, 'Scénario : Le Tonnerre des titans — Ulduar (Chasseur Maîtrise des bêtes)', 0, 1, 1, 0),
(61000, 49, 0, 'Scénario : Le sauvetage de Koltira (Chevalier de la mort)', 0, 1, 1, 0);
DELETE FROM smart_scripts WHERE entryorguid=990000 AND source_type=0 AND id IN (48,49);
INSERT INTO smart_scripts (entryorguid, source_type, id, link, event_type, event_phase_mask, event_chance, event_flags, event_param1, event_param2, event_param3, event_param4, action_type, action_param1, action_param2, action_param3, action_param4, action_param5, action_param6, target_type, target_param1, target_param2, target_param3, target_x, target_y, target_z, target_o, comment) VALUES
(990000, 0, 48, 0, 62, 0, 100, 0, 61000, 48, 0, 0, 62, 1579, 0, 0, 0, 0, 0, 7, 0, 0, 0, 2340.8, 2575.4, 419.6, 0.0, 'Gardien - teleport scenario Ulduar BM (1579)'),
(990000, 0, 49, 0, 62, 0, 100, 0, 61000, 49, 0, 0, 62, 1617, 0, 0, 0, 0, 0, 7, 0, 0, 0, 1668.2, 731.0, 77.6, 0.0, 'Gardien - teleport scenario Koltira (1617)');
