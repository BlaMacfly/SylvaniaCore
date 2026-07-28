-- ============================================================
-- Lot 10 (FINAL) : les 6 dernières maps de scénario d'artefact
-- 1553 Gloaming Reef (Druide Farouche, scén. 1108) / 1580 Maelstrom titan
-- 1572 Chaman intro / 1512 Prêtre Netherlight / 1502 Citadelle Shadowgore / 1513 Hall du Gardien
-- ============================================================

REPLACE INTO scenario_artifact_config VALUES
(1553, 2570.1, 8275.2, 2.1, 2.4,   994, -4245.0, -2660.5, 17.6, 1.6, 0, 'Druide Farouche - Fangs of Ashamane (Gloaming Reef)'),
(1580, 2486.0, 376.0, -122.0, 2.9, 994, -4245.0, -2660.5, 17.6, 1.6, 0, 'Maelstrom - epreuve titanique'),
(1572, 824.1, 1046.7, 48.2, 0.0,   994, -4245.0, -2660.5, 17.6, 1.6, 0, 'Chaman - intro du Maelstrom'),
(1512, 1249.5, 1344.1, 185.0, 6.2, 994, -4245.0, -2660.5, 17.6, 1.6, 0, 'Pretre - temple Netherlight'),
(1502, -850.7, 4401.8, 717.0, 1.4, 994, -4245.0, -2660.5, 17.6, 1.6, 0, 'Citadelle Shadowgore (Akaari)'),
(1513, -935.9, 4706.3, 928.6, 6.1, 994, -4245.0, -2660.5, 17.6, 1.6, 0, 'Hall du Gardien - incursion');

REPLACE INTO scenario_artifact_stage (map, stage, idx, entry, x, y, z, o, cnt, lvl, teleport) VALUES
-- 1553 Gloaming Reef : cauchemar
(1553, 1, 0, 98286, 2545.0, 8260.0, 2.1, 5.5, 4, 99, 0),
(1553, 1, 1, 98785, 2537.0, 8268.0, 2.1, 5.5, 2, 99, 0),
(1553, 2, 0, 97966, 2515.0, 8240.0, 2.1, 5.5, 3, 100, 0),
(1553, 3, 0, 120487, 2490.0, 8220.0, 2.1, 5.5, 1, 102, 0),
-- 1580 Maelstrom titan : orage
(1580, 1, 0, 104604, 2460.0, 360.0, -122.0, 6.0, 4, 99, 0),
(1580, 1, 1, 100796, 2452.0, 368.0, -122.0, 6.0, 2, 100, 0),
(1580, 2, 0, 102019, 2430.0, 340.0, -122.0, 6.0, 3, 100, 0),
(1580, 3, 0, 116763, 2405.0, 320.0, -122.0, 6.0, 1, 102, 0),
-- 1572 Chaman intro : feu
(1572, 1, 0, 104499, 850.0, 1060.0, 48.2, 3.3, 4, 99, 0),
(1572, 1, 1, 109021, 858.0, 1052.0, 48.2, 3.3, 2, 100, 0),
(1572, 2, 0, 96123, 880.0, 1075.0, 48.2, 3.3, 3, 100, 0),
(1572, 3, 0, 102398, 905.0, 1090.0, 48.2, 3.3, 1, 102, 0),
-- 1512 Prêtre Netherlight : Vide
(1512, 1, 0, 99664, 1275.0, 1355.0, 185.0, 3.3, 4, 99, 0),
(1512, 1, 1, 116287, 1283.0, 1347.0, 185.0, 3.3, 2, 100, 0),
(1512, 2, 0, 116287, 1305.0, 1365.0, 185.0, 3.3, 3, 100, 0),
(1512, 3, 0, 106669, 1330.0, 1375.0, 185.0, 3.3, 1, 102, 0),
-- 1502 Citadelle Shadowgore : Légion + Akaari
(1502, 1, 0, 98286, -825.0, 4415.0, 717.0, 4.6, 4, 99, 0),
(1502, 1, 1, 98505, -817.0, 4407.0, 717.0, 4.6, 2, 100, 0),
(1502, 2, 0, 97966, -795.0, 4435.0, 717.0, 4.6, 3, 100, 0),
(1502, 3, 0, 105450, -770.0, 4455.0, 717.0, 4.6, 1, 102, 0),
-- 1513 Hall du Gardien : arcanes (Guet crépusculaire)
(1513, 1, 0, 113166, -910.0, 4715.0, 928.6, 3.0, 4, 99, 0),
(1513, 1, 1, 115253, -902.0, 4707.0, 928.6, 3.0, 2, 100, 0),
(1513, 2, 0, 113166, -880.0, 4730.0, 928.6, 3.0, 3, 100, 0),
(1513, 3, 0, 115594, -855.0, 4745.0, 928.6, 3.0, 1, 102, 0);

-- scénario officiel identifié : Farouche 1108 « The Fangs of Ashamane »
REPLACE INTO scenarios (map, difficulty, scenario_A, scenario_H, zoneid) VALUES (1553, 0, 1108, 1108, 0);

UPDATE instance_template SET script='scenario_artifact_runner_1553' WHERE map=1553;
UPDATE instance_template SET script='scenario_artifact_runner_1580' WHERE map=1580;
UPDATE instance_template SET script='scenario_artifact_runner_1572' WHERE map=1572;
UPDATE instance_template SET script='scenario_artifact_runner_1512' WHERE map=1512;
UPDATE instance_template SET script='scenario_artifact_runner_1502' WHERE map=1502;
UPDATE instance_template SET script='scenario_artifact_runner_1513' WHERE map=1513;

-- porte d'entrée : options 54-59
DELETE FROM gossip_menu_option WHERE MenuId=61000 AND OptionIndex BETWEEN 54 AND 59;
INSERT INTO gossip_menu_option (MenuId, OptionIndex, OptionIcon, OptionText, OptionBroadcastTextId, OptionType, OptionNpcFlag, VerifiedBuild) VALUES
(61000, 54, 0, 'Scénario : Les Crocs d''Ashamane — récif du Crépuscule (Druide Farouche)', 0, 1, 1, 0),
(61000, 55, 0, 'Scénario : L''épreuve titanique — Maelstrom (défi)', 0, 1, 1, 0),
(61000, 56, 0, 'Scénario : Le cœur du Maelstrom (Chaman)', 0, 1, 1, 0),
(61000, 57, 0, 'Scénario : Le temple Netherlight assiégé (Prêtre)', 0, 1, 1, 0),
(61000, 58, 0, 'Scénario : La citadelle Shadowgore (défi)', 0, 1, 1, 0),
(61000, 59, 0, 'Scénario : L''incursion du hall du Gardien (Mage)', 0, 1, 1, 0);
DELETE FROM smart_scripts WHERE entryorguid=990000 AND source_type=0 AND id BETWEEN 54 AND 59;
INSERT INTO smart_scripts (entryorguid, source_type, id, link, event_type, event_phase_mask, event_chance, event_flags, event_param1, event_param2, event_param3, event_param4, action_type, action_param1, action_param2, action_param3, action_param4, action_param5, action_param6, target_type, target_param1, target_param2, target_param3, target_x, target_y, target_z, target_o, comment) VALUES
(990000, 0, 54, 0, 62, 0, 100, 0, 61000, 54, 0, 0, 62, 1553, 0, 0, 0, 0, 0, 7, 0, 0, 0, 2570.1, 8275.2, 2.4, 2.4, 'Gardien - teleport Gloaming Reef (1553)'),
(990000, 0, 55, 0, 62, 0, 100, 0, 61000, 55, 0, 0, 62, 1580, 0, 0, 0, 0, 0, 7, 0, 0, 0, 2486.0, 376.0, -121.7, 2.9, 'Gardien - teleport Maelstrom titan (1580)'),
(990000, 0, 56, 0, 62, 0, 100, 0, 61000, 56, 0, 0, 62, 1572, 0, 0, 0, 0, 0, 7, 0, 0, 0, 824.1, 1046.7, 48.5, 0.0, 'Gardien - teleport Chaman intro (1572)'),
(990000, 0, 57, 0, 62, 0, 100, 0, 61000, 57, 0, 0, 62, 1512, 0, 0, 0, 0, 0, 7, 0, 0, 0, 1249.5, 1344.1, 185.3, 6.2, 'Gardien - teleport Netherlight (1512)'),
(990000, 0, 58, 0, 62, 0, 100, 0, 61000, 58, 0, 0, 62, 1502, 0, 0, 0, 0, 0, 7, 0, 0, 0, -850.7, 4401.8, 717.3, 1.4, 'Gardien - teleport Shadowgore (1502)'),
(990000, 0, 59, 0, 62, 0, 100, 0, 61000, 59, 0, 0, 62, 1513, 0, 0, 0, 0, 0, 7, 0, 0, 0, -935.9, 4706.3, 928.9, 6.1, 'Gardien - teleport Hall du Gardien (1513)');
