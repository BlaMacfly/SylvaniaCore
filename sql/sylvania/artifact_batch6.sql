-- ============================================================
-- Lot 6 : Niskara « L'Invasion de Niskara » (map 1604, monde de la Légion)
--       + Terres de Feu « La Fournaise » (map 1605)
-- ============================================================

-- ---------- Niskara (1604) ----------
REPLACE INTO scenario_artifact_config VALUES
(1604, 244.2, 1962.8, -54.3, 0.65,  994, -4245.0, -2660.5, 17.6, 1.6,  0, 'Niskara - invasion (Legion world)');
REPLACE INTO scenario_artifact_stage (map, stage, idx, entry, x, y, z, o, cnt, lvl, teleport) VALUES
(1604, 1, 0, 98286, 270.0, 1980.0, -54.3, 3.8, 4, 99, 0),
(1604, 1, 1, 98785, 262.0, 1990.0, -54.3, 3.8, 2, 99, 0),
(1604, 2, 0, 97966, 300.0, 2005.0, -54.3, 3.8, 3, 100, 0),
(1604, 2, 1, 98505, 292.0, 2013.0, -54.3, 3.8, 2, 100, 0),
(1604, 3, 0, 90663, 330.0, 2030.0, -54.3, 3.8, 1, 102, 0);

-- ---------- Terres de Feu (1605) ----------
REPLACE INTO scenario_artifact_config VALUES
(1605, -531.7, 313.3, 115.5, 2.77,  994, -4245.0, -2660.5, 17.6, 1.6,  0, 'Firelands - la Fournaise');
REPLACE INTO scenario_artifact_stage (map, stage, idx, entry, x, y, z, o, cnt, lvl, teleport) VALUES
(1605, 1, 0, 104499, -560.0, 330.0, 115.5, 5.9, 4, 99, 0),
(1605, 1, 1, 109021, -568.0, 338.0, 115.5, 5.9, 2, 100, 0),
(1605, 2, 0, 109021, -590.0, 352.0, 115.5, 5.9, 3, 100, 0),
(1605, 2, 1,  96123, -598.0, 344.0, 115.5, 5.9, 2, 100, 0),
(1605, 3, 0, 102398, -622.0, 370.0, 115.5, 5.9, 1, 102, 0);

-- gabarits feu (stubs libres)
UPDATE creature_template SET faction=16, minlevel=102, maxlevel=102, HealthModifier=GREATEST(HealthModifier*10,10), `rank`=3 WHERE entry=102398;
UPDATE creature_template SET faction=16, minlevel=99, maxlevel=100, HealthModifier=GREATEST(HealthModifier*2,2) WHERE entry IN (104499,109021,96123);

UPDATE instance_template SET script='scenario_artifact_runner_1604' WHERE map=1604;
UPDATE instance_template SET script='scenario_artifact_runner_1605' WHERE map=1605;

-- porte d'entrée : options 46/47
DELETE FROM gossip_menu_option WHERE MenuId=61000 AND OptionIndex IN (46,47);
INSERT INTO gossip_menu_option (MenuId, OptionIndex, OptionIcon, OptionText, OptionBroadcastTextId, OptionType, OptionNpcFlag, VerifiedBuild) VALUES
(61000, 46, 0, 'Scénario : L''Invasion de Niskara — monde de la Légion (défi)', 0, 1, 1, 0),
(61000, 47, 0, 'Scénario : La Fournaise — Terres de Feu (défi)', 0, 1, 1, 0);
DELETE FROM smart_scripts WHERE entryorguid=990000 AND source_type=0 AND id IN (46,47);
INSERT INTO smart_scripts (entryorguid, source_type, id, link, event_type, event_phase_mask, event_chance, event_flags, event_param1, event_param2, event_param3, event_param4, action_type, action_param1, action_param2, action_param3, action_param4, action_param5, action_param6, target_type, target_param1, target_param2, target_param3, target_x, target_y, target_z, target_o, comment) VALUES
(990000, 0, 46, 0, 62, 0, 100, 0, 61000, 46, 0, 0, 62, 1604, 0, 0, 0, 0, 0, 7, 0, 0, 0, 244.2, 1962.8, -54.0, 0.65, 'Gardien - teleport scenario Niskara (1604)'),
(990000, 0, 47, 0, 62, 0, 100, 0, 61000, 47, 0, 0, 62, 1605, 0, 0, 0, 0, 0, 7, 0, 0, 0, -531.7, 313.3, 115.8, 2.77, 'Gardien - teleport scenario Terres de Feu (1605)');

-- texte FR du boss des Terres de Feu
DELETE FROM creature_text WHERE CreatureID=102398;
INSERT INTO creature_text (CreatureID, GroupID, ID, Text, Type, Language, Probability, Emote, Duration, Sound, BroadcastTextId, TextRange, comment) VALUES
(102398, 0, 0, 'La Fournaise vous consumera, chair fragile !', 14, 0, 100, 15, 0, 0, 0, 0, 'Infernal ardent spawn');

-- FIX passe QA 20/07 : Blazing Infernal 102398 etait modelid1=0 (invisible) -> modele de l Infernal Destroyer 98011
UPDATE creature_template SET modelid1=(SELECT modelid1 FROM (SELECT modelid1 FROM creature_template WHERE entry=98011) x) WHERE entry=102398;
