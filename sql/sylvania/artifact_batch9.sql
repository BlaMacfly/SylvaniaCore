-- ============================================================
-- Lot 9 : Guerrier Fureur « Les Épées de guerre des Valarjar » (map 1511, Helheim)
--       + Chaman Amélioration « Marteau-du-Destin » (map 1503)
-- ============================================================

-- ---------- Guerrier Fureur / Helheim (1511) — 4 ancres officielles ----------
REPLACE INTO scenario_artifact_config VALUES
(1511, 3380.3, 1401.9, 69.5, 0.8,  994, -4245.0, -2660.5, 17.6, 1.6,  0, 'Warrior Fury - Warswords (Helheim)');
REPLACE INTO scenario_artifact_stage (map, stage, idx, entry, x, y, z, o, cnt, lvl, teleport) VALUES
(1511, 1, 0, 111332, 3366.9, 1568.3, 11.0, 4.7, 4, 99, 0),
(1511, 1, 1, 116601, 3358.0, 1560.0, 11.0, 4.7, 2, 99, 0),
(1511, 2, 0, 116601, 3515.3, 1671.7, 1.0, 2.4, 3, 100, 0),
(1511, 2, 1, 116335, 3507.0, 1663.0, 1.0, 2.4, 2, 100, 0),
(1511, 3, 0, 115753, 3483.1, 1849.3, 2.7, 5.2, 1, 102, 0);

-- ---------- Chaman Amélioration (1503) ----------
REPLACE INTO scenario_artifact_config VALUES
(1503, 2458.1, 67.7, -157.7, 3.85,  994, -4245.0, -2660.5, 17.6, 1.6,  0, 'Shaman Enhancement - Doomhammer');
REPLACE INTO scenario_artifact_stage (map, stage, idx, entry, x, y, z, o, cnt, lvl, teleport) VALUES
(1503, 1, 0, 104499, 2428.0, 50.0, -157.7, 0.7, 4, 99, 0),
(1503, 1, 1, 109021, 2420.0, 58.0, -157.7, 0.7, 2, 100, 0),
(1503, 2, 0, 109021, 2395.0, 30.0, -157.7, 0.7, 3, 100, 0),
(1503, 2, 1,  96123, 2387.0, 38.0, -157.7, 0.7, 2, 100, 0),
(1503, 3, 0, 102398, 2365.0, 10.0, -157.7, 0.7, 1, 102, 0);

-- gabarits Helheim (stubs libres)
UPDATE creature_template SET faction=16, minlevel=102, maxlevel=102, HealthModifier=GREATEST(HealthModifier*10,10), `rank`=3 WHERE entry=115753;
UPDATE creature_template SET faction=16, minlevel=99, maxlevel=100, HealthModifier=GREATEST(HealthModifier*2,2) WHERE entry IN (111332,116601,116335);

UPDATE instance_template SET script='scenario_artifact_runner_1511' WHERE map=1511;
UPDATE instance_template SET script='scenario_artifact_runner_1503' WHERE map=1503;

-- porte d'entrée : options 52/53
DELETE FROM gossip_menu_option WHERE MenuId=61000 AND OptionIndex IN (52,53);
INSERT INTO gossip_menu_option (MenuId, OptionIndex, OptionIcon, OptionText, OptionBroadcastTextId, OptionType, OptionNpcFlag, VerifiedBuild) VALUES
(61000, 52, 0, 'Scénario : Les Épées de guerre des Valarjar — Helheim (Guerrier Fureur)', 0, 1, 1, 0),
(61000, 53, 0, 'Scénario : Marteau-du-Destin — la forge des éléments (Chaman Amélioration)', 0, 1, 1, 0);
DELETE FROM smart_scripts WHERE entryorguid=990000 AND source_type=0 AND id IN (52,53);
INSERT INTO smart_scripts (entryorguid, source_type, id, link, event_type, event_phase_mask, event_chance, event_flags, event_param1, event_param2, event_param3, event_param4, action_type, action_param1, action_param2, action_param3, action_param4, action_param5, action_param6, target_type, target_param1, target_param2, target_param3, target_x, target_y, target_z, target_o, comment) VALUES
(990000, 0, 52, 0, 62, 0, 100, 0, 61000, 52, 0, 0, 62, 1511, 0, 0, 0, 0, 0, 7, 0, 0, 0, 3380.3, 1401.9, 69.8, 0.8, 'Gardien - teleport scenario Guerrier Fureur (1511)'),
(990000, 0, 53, 0, 62, 0, 100, 0, 61000, 53, 0, 0, 62, 1503, 0, 0, 0, 0, 0, 7, 0, 0, 0, 2458.1, 67.7, -157.4, 3.85, 'Gardien - teleport scenario Chaman Amelioration (1503)');

-- texte FR du boss Helheim
DELETE FROM creature_text WHERE CreatureID=115753;
INSERT INTO creature_text (CreatureID, GroupID, ID, Text, Type, Language, Probability, Emote, Duration, Sound, BroadcastTextId, TextRange, comment) VALUES
(115753, 0, 0, 'Helheim garde ses trésors, mortel. Ton âme rejoindra la brume !', 14, 0, 100, 15, 0, 0, 0, 0, 'Gardien Helarjar spawn');
