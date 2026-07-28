-- ============================================================
-- Lot 1 de configs du runner d'artefact :
--  - DK Givre « The Blades of the Fallen Prince » (901, map 1480)
--  - Paladin Sacré « The Silver Hand » (1092, map 1611)
-- Ancres officielles WorldSafeLocs ; sortie = hub Gardien des Artefacts (994)
-- ============================================================

-- ---------- DK Givre (1480) ----------
REPLACE INTO scenario_artifact_config VALUES
(1480, -737.1, 2204.7, 535.7, 0.0,  994, -4245.0, -2660.5, 17.6, 1.6,  0, 'DK Frost - Blades of the Fallen Prince');
REPLACE INTO scenario_artifact_stage (map, stage, idx, entry, x, y, z, o, cnt, lvl, teleport) VALUES
-- étape 1 : parvis d'Achérus en Couronne de glace — âmes agitées
(1480, 1, 0,  99664, -700.0, 2205.0, 535.7, 3.1, 4, 99, 0),
(1480, 1, 1, 116287, -690.0, 2215.0, 535.7, 3.1, 2, 100, 0),
-- étape 2 : la Flèche (téléport) — gardiens du sommet
(1480, 2, 0, 116287, 4132.1, 2769.1, 351.0, 3.1, 4, 100, 1),
(1480, 2, 1,  99664, 4120.0, 2780.0, 351.0, 3.1, 2, 100, 0),
-- étape 3 : le Trône de glace (téléport) — la Purge : 3 grandes âmes malveillantes
(1480, 3, 0, 116287, 530.6, -2124.8, 840.9, 3.1, 3, 102, 1);

-- ---------- Paladin Sacré (1611) ----------
REPLACE INTO scenario_artifact_config VALUES
(1611, 2253.1, -5137.0, 62.1, 2.4,  994, -4245.0, -2660.5, 17.6, 1.6,  0, 'Paladin Holy - The Silver Hand');
REPLACE INTO scenario_artifact_stage (map, stage, idx, entry, x, y, z, o, cnt, lvl, teleport) VALUES
-- étape 1 : approche de la chapelle — morts-vivants du site
(1611, 1, 0, 116287, 2179.8, -5056.7, 78.6, 5.5, 4, 99, 0),
(1611, 1, 1,  99664, 2170.0, -5065.0, 78.6, 5.5, 2, 99, 0),
-- étape 2 : crypte de Tyr (téléport) — gardiens corrompus
(1611, 2, 0,  99664, 2177.4, -5276.5, 83.6, 1.2, 4, 100, 1),
-- étape 3 : l'Aberration horrifiante (boss de la prison)
(1611, 3, 0, 106669, 2185.0, -5285.0, 83.6, 1.2, 1, 102, 0);

-- gabarits du cast
UPDATE creature_template SET faction=16, minlevel=102, maxlevel=102, HealthModifier=GREATEST(HealthModifier*10,10), `rank`=3 WHERE entry=106669;
UPDATE creature_template SET faction=16, minlevel=99, maxlevel=100, HealthModifier=GREATEST(HealthModifier*2,2) WHERE entry IN (99664,116287);

-- rattachement scénarios + scripts d'instance
REPLACE INTO scenarios (map, difficulty, scenario_A, scenario_H, zoneid) VALUES (1480, 0, 901, 901, 0), (1611, 0, 1092, 1092, 0);
UPDATE instance_template SET script='scenario_artifact_runner_1480' WHERE map=1480;
UPDATE instance_template SET script='scenario_artifact_runner_1611' WHERE map=1611;

-- porte d'entrée : options 37/38 du Gardien des Artefacts
DELETE FROM gossip_menu_option WHERE MenuId=61000 AND OptionIndex IN (37,38);
INSERT INTO gossip_menu_option (MenuId, OptionIndex, OptionIcon, OptionText, OptionBroadcastTextId, OptionType, OptionNpcFlag, VerifiedBuild) VALUES
(61000, 37, 0, 'Scénario d''acquisition : Les Lames du prince déchu — Couronne de glace (DK Givre)', 0, 1, 1, 0),
(61000, 38, 0, 'Scénario d''acquisition : La Main d''argent — Espoir de Lumière (Paladin Sacré)', 0, 1, 1, 0);
DELETE FROM smart_scripts WHERE entryorguid=990000 AND source_type=0 AND id IN (37,38);
INSERT INTO smart_scripts (entryorguid, source_type, id, link, event_type, event_phase_mask, event_chance, event_flags, event_param1, event_param2, event_param3, event_param4, action_type, action_param1, action_param2, action_param3, action_param4, action_param5, action_param6, target_type, target_param1, target_param2, target_param3, target_x, target_y, target_z, target_o, comment) VALUES
(990000, 0, 37, 0, 62, 0, 100, 0, 61000, 37, 0, 0, 62, 1480, 0, 0, 0, 0, 0, 7, 0, 0, 0, -737.1, 2204.7, 536.0, 0.0, 'Gardien - teleport scenario DK Givre (1480)'),
(990000, 0, 38, 0, 62, 0, 100, 0, 61000, 38, 0, 0, 62, 1611, 0, 0, 0, 0, 0, 7, 0, 0, 0, 2253.1, -5137.0, 62.4, 2.4, 'Gardien - teleport scenario Paladin Sacre (1611)');
