-- ============================================================
-- Lot 2 : DK Impie « Apocalypse » — monastère Écarlate (map 1618)
-- (pas de ligne scenarios : ID officiel non identifié, runner sans UI d'étapes)
-- ============================================================
REPLACE INTO scenario_artifact_config VALUES
(1618, 1124.7, 518.7, 0.7, 1.6,  994, -4245.0, -2660.5, 17.6, 1.6,  0, 'DK Unholy - Apocalypse (Scarlet Monastery)');
REPLACE INTO scenario_artifact_stage (map, stage, idx, entry, x, y, z, o, cnt, lvl, teleport) VALUES
-- étape 1 : parvis du monastère — soldats écarlates
(1618, 1, 0, 108840, 1124.7, 560.0, 0.9, 4.7, 3, 99, 0),
(1618, 1, 1, 108841, 1116.0, 570.0, 0.9, 4.7, 3, 99, 0),
-- étape 2 : cimetière — la garde rapprochée
(1618, 2, 0, 108841, 1124.6, 688.6, 1.2, 4.7, 4, 100, 0),
(1618, 2, 1, 108840, 1114.0, 695.0, 1.2, 4.7, 2, 100, 0),
-- étape 3 : la grande inquisitrice Whitemane
(1618, 3, 0, 109374, 1130.0, 700.0, 1.2, 4.7, 1, 102, 0);

UPDATE creature_template SET faction=16, minlevel=102, maxlevel=102, HealthModifier=GREATEST(HealthModifier*10,10), `rank`=3 WHERE entry=109374;
UPDATE creature_template SET faction=16, minlevel=99, maxlevel=100, HealthModifier=GREATEST(HealthModifier*2,2) WHERE entry IN (108840,108841);
UPDATE instance_template SET script='scenario_artifact_runner_1618' WHERE map=1618;

DELETE FROM gossip_menu_option WHERE MenuId=61000 AND OptionIndex=39;
INSERT INTO gossip_menu_option (MenuId, OptionIndex, OptionIcon, OptionText, OptionBroadcastTextId, OptionType, OptionNpcFlag, VerifiedBuild) VALUES
(61000, 39, 0, 'Scénario d''acquisition : Apocalypse — monastère Écarlate (DK Impie)', 0, 1, 1, 0);
DELETE FROM smart_scripts WHERE entryorguid=990000 AND source_type=0 AND id=39;
INSERT INTO smart_scripts (entryorguid, source_type, id, link, event_type, event_phase_mask, event_chance, event_flags, event_param1, event_param2, event_param3, event_param4, action_type, action_param1, action_param2, action_param3, action_param4, action_param5, action_param6, target_type, target_param1, target_param2, target_param3, target_x, target_y, target_z, target_o, comment) VALUES
(990000, 0, 39, 0, 62, 0, 100, 0, 61000, 39, 0, 0, 62, 1618, 0, 0, 0, 0, 0, 7, 0, 0, 0, 1124.7, 518.7, 1.0, 1.6, 'Gardien - teleport scenario DK Impie (1618)');
-- texte FR du boss
DELETE FROM creature_text WHERE CreatureID=109374;
INSERT INTO creature_text (CreatureID, GroupID, ID, Text, Type, Language, Probability, Emote, Duration, Sound, BroadcastTextId, TextRange, comment) VALUES
(109374, 0, 0, 'Profanateur ! La Croisade écarlate purifiera ce monastère de ta présence !', 14, 0, 100, 15, 0, 0, 0, 0, 'Whitemane spawn');
