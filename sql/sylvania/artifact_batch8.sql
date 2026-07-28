-- ============================================================
-- Lot 8 : Druide « Le Rêvechemin corrompu » (map 1540)
--       + Mage Givre « Sombreglace » (map 1616, 2 zones)
-- ============================================================

-- ---------- Rêvechemin (1540) ----------
REPLACE INTO scenario_artifact_config VALUES
(1540, 1752.6, 1604.3, 8.7, 3.5,  994, -4245.0, -2660.5, 17.6, 1.6,  0, 'Druid - Dreamway corrompu');
REPLACE INTO scenario_artifact_stage (map, stage, idx, entry, x, y, z, o, cnt, lvl, teleport) VALUES
(1540, 1, 0, 98286, 1696.1, 1640.4, 7.7, 3.9, 4, 99, 0),
(1540, 1, 1, 98785, 1688.0, 1632.0, 7.7, 3.9, 2, 99, 0),
(1540, 2, 0, 97966, 1568.0, 1555.4, 17.8, 0.5, 3, 100, 0),
(1540, 2, 1, 98505, 1576.0, 1563.0, 17.8, 0.5, 2, 100, 0),
(1540, 3, 0, 120487, 1507.4, 1650.4, 30.6, 5.6, 1, 102, 0);

-- ---------- Mage Givre (1616) ----------
REPLACE INTO scenario_artifact_config VALUES
(1616, -158.4, 7814.9, 112.7, 3.1,  994, -4245.0, -2660.5, 17.6, 1.6,  0, 'Mage Frost - Ebonchill (2 zones)');
REPLACE INTO scenario_artifact_stage (map, stage, idx, entry, x, y, z, o, cnt, lvl, teleport) VALUES
(1616, 1, 0, 104604, -190.0, 7800.0, 112.7, 0.0, 4, 99, 0),
(1616, 1, 1, 100796, -198.0, 7808.0, 112.7, 0.0, 2, 100, 0),
(1616, 2, 0, 104604, -225.0, 7785.0, 112.7, 0.0, 3, 100, 0),
(1616, 3, 0, 116763, -4351.9, 407.3, 437.6, 2.0, 1, 102, 1),
(1616, 3, 1, 100796, -4360.0, 398.0, 437.6, 2.0, 2, 100, 0);

-- gabarit boss Rêvechemin
UPDATE creature_template SET faction=16, minlevel=102, maxlevel=102, HealthModifier=GREATEST(HealthModifier*10,10), `rank`=3 WHERE entry=120487;

UPDATE instance_template SET script='scenario_artifact_runner_1540' WHERE map=1540;
UPDATE instance_template SET script='scenario_artifact_runner_1616' WHERE map=1616;

-- porte d'entrée : options 50/51
DELETE FROM gossip_menu_option WHERE MenuId=61000 AND OptionIndex IN (50,51);
INSERT INTO gossip_menu_option (MenuId, OptionIndex, OptionIcon, OptionText, OptionBroadcastTextId, OptionType, OptionNpcFlag, VerifiedBuild) VALUES
(61000, 50, 0, 'Scénario : Le Rêvechemin corrompu (Druide)', 0, 1, 1, 0),
(61000, 51, 0, 'Scénario : Sombreglace — l''épreuve du givre (Mage Givre)', 0, 1, 1, 0);
DELETE FROM smart_scripts WHERE entryorguid=990000 AND source_type=0 AND id IN (50,51);
INSERT INTO smart_scripts (entryorguid, source_type, id, link, event_type, event_phase_mask, event_chance, event_flags, event_param1, event_param2, event_param3, event_param4, action_type, action_param1, action_param2, action_param3, action_param4, action_param5, action_param6, target_type, target_param1, target_param2, target_param3, target_x, target_y, target_z, target_o, comment) VALUES
(990000, 0, 50, 0, 62, 0, 100, 0, 61000, 50, 0, 0, 62, 1540, 0, 0, 0, 0, 0, 7, 0, 0, 0, 1752.6, 1604.3, 9.0, 3.5, 'Gardien - teleport scenario Revechemin (1540)'),
(990000, 0, 51, 0, 62, 0, 100, 0, 61000, 51, 0, 0, 62, 1616, 0, 0, 0, 0, 0, 7, 0, 0, 0, -158.4, 7814.9, 113.0, 3.1, 'Gardien - teleport scenario Mage Givre (1616)');

-- texte FR du boss Rêvechemin
DELETE FROM creature_text WHERE CreatureID=120487;
INSERT INTO creature_text (CreatureID, GroupID, ID, Text, Type, Language, Probability, Emote, Duration, Sound, BroadcastTextId, TextRange, comment) VALUES
(120487, 0, 0, 'Le Rêve se meurt... et vous mourrez avec lui !', 14, 0, 100, 15, 0, 0, 0, 0, 'Horreur cauchemardesque spawn');
