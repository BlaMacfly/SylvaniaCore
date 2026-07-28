-- ============================================================
-- Lot 4 : Chaman Élémentaire « Poing de Ra-den » (map 1602, pic du Vortex)
--       + Chasseur BM « Frappe-titan » (map 1609, temple des Orages)
-- ============================================================

-- ---------- Chaman Élémentaire (1602) ----------
REPLACE INTO scenario_artifact_config VALUES
(1602, -338.2, 14.6, 627.0, 0.8,  994, -4245.0, -2660.5, 17.6, 1.6,  0, 'Shaman Ele - Fist of Ra-den (Vortex Pinnacle)');
REPLACE INTO scenario_artifact_stage (map, stage, idx, entry, x, y, z, o, cnt, lvl, teleport) VALUES
(1602, 1, 0, 104604, -310.0, 30.0, 627.0, 3.9, 4, 99, 0),
(1602, 1, 1, 100796, -302.0, 20.0, 627.0, 3.9, 2, 100, 0),
(1602, 2, 0, 104604, -270.0, 60.0, 627.0, 3.9, 3, 100, 0),
(1602, 2, 1, 102019, -262.0, 52.0, 627.0, 3.9, 2, 100, 0),
(1602, 3, 0, 116763, -240.0, 90.0, 627.0, 3.9, 1, 102, 0);

-- ---------- Chasseur BM (1609) ----------
REPLACE INTO scenario_artifact_config VALUES
(1609, 7383.2, -548.2, 1897.5, 0.2,  994, -4245.0, -2660.5, 17.6, 1.6,  0, 'Hunter BM - Titanstrike (Temple of Storms)');
REPLACE INTO scenario_artifact_stage (map, stage, idx, entry, x, y, z, o, cnt, lvl, teleport) VALUES
(1609, 1, 0, 102019, 7420.0, -540.0, 1897.5, 3.3, 4, 99, 0),
(1609, 1, 1, 116763, 7428.0, -550.0, 1897.5, 3.3, 2, 100, 0),
(1609, 2, 0, 102019, 7460.0, -530.0, 1897.5, 3.3, 4, 100, 0),
(1609, 3, 0, 114362, 7490.0, -520.0, 1897.5, 3.3, 1, 102, 0);

-- gabarits
UPDATE creature_template SET faction=16, minlevel=102, maxlevel=102, HealthModifier=GREATEST(HealthModifier*10,10), `rank`=3 WHERE entry IN (114362,116763);
UPDATE creature_template SET faction=16, minlevel=99, maxlevel=100, HealthModifier=GREATEST(HealthModifier*2,2) WHERE entry=102019;

UPDATE instance_template SET script='scenario_artifact_runner_1602' WHERE map=1602;
UPDATE instance_template SET script='scenario_artifact_runner_1609' WHERE map=1609;

-- porte d'entrée : options 42/43
DELETE FROM gossip_menu_option WHERE MenuId=61000 AND OptionIndex IN (42,43);
INSERT INTO gossip_menu_option (MenuId, OptionIndex, OptionIcon, OptionText, OptionBroadcastTextId, OptionType, OptionNpcFlag, VerifiedBuild) VALUES
(61000, 42, 0, 'Scénario d''acquisition : Le Poing de Ra-den — pic du Vortex (Chaman Élémentaire)', 0, 1, 1, 0),
(61000, 43, 0, 'Scénario d''acquisition : Frappe-titan — temple des Orages (Chasseur Maîtrise des bêtes)', 0, 1, 1, 0);
DELETE FROM smart_scripts WHERE entryorguid=990000 AND source_type=0 AND id IN (42,43);
INSERT INTO smart_scripts (entryorguid, source_type, id, link, event_type, event_phase_mask, event_chance, event_flags, event_param1, event_param2, event_param3, event_param4, action_type, action_param1, action_param2, action_param3, action_param4, action_param5, action_param6, target_type, target_param1, target_param2, target_param3, target_x, target_y, target_z, target_o, comment) VALUES
(990000, 0, 42, 0, 62, 0, 100, 0, 61000, 42, 0, 0, 62, 1602, 0, 0, 0, 0, 0, 7, 0, 0, 0, -338.2, 14.6, 627.3, 0.8, 'Gardien - teleport scenario Chaman Ele (1602)'),
(990000, 0, 43, 0, 62, 0, 100, 0, 61000, 43, 0, 0, 62, 1609, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7383.2, -548.2, 1897.8, 0.2, 'Gardien - teleport scenario Chasseur BM (1609)');
