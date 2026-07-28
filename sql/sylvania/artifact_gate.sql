-- Porte d'entrée des scénarios d'artefact : option gossip sur le Gardien des Artefacts (990000)
DELETE FROM gossip_menu_option WHERE MenuId=61000 AND OptionIndex=36;
INSERT INTO gossip_menu_option (MenuId, OptionIndex, OptionIcon, OptionText, OptionBroadcastTextId, OptionType, OptionNpcFlag, VerifiedBuild)
VALUES (61000, 36, 0, 'Scénario d''acquisition : Les Cieux tonnants — affronter Typhinius (Marche-vent)', 0, 1, 1, 0);
DELETE FROM smart_scripts WHERE entryorguid=990000 AND source_type=0 AND id=36;
INSERT INTO smart_scripts (entryorguid, source_type, id, link, event_type, event_phase_mask, event_chance, event_flags, event_param1, event_param2, event_param3, event_param4, action_type, action_param1, action_param2, action_param3, action_param4, action_param5, action_param6, target_type, target_param1, target_param2, target_param3, target_x, target_y, target_z, target_o, comment)
VALUES (990000, 0, 36, 0, 62, 0, 100, 0, 61000, 36, 0, 0, 62, 1528, 0, 0, 0, 0, 0, 7, 0, 0, 0, -428.0, 334.6, 739.7, 3.14, 'Gardien - teleport scenario Cieux tonnants (1528)');
