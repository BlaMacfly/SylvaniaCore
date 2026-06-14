-- ============================================================================
-- Scenario Rive Brisee (786) — INCREMENT 1 : fondation (SQL only, pas de C++).
-- 2026-06-14. But = valider que map 1460 charge, coords d'entree OK, et que le
-- moteur de scenario demarre (UI 9 etapes) — AVANT d'ecrire l'InstanceScript.
-- Aucun risque de crash custom (zero code). Reversible (DELETE + restart).
-- Test : GM -> ".tele brokenshoretest" -> doit arriver sur la Rive Brisee,
--        sur sol solide, avec l'UI du scenario "The Battle for Broken Shore".
-- ⚠️ Charge au boot (scenarios/instance_template) => RESTART requis.
-- ============================================================================

-- 1) mapping map->scenario (Alliance ET Horde = 786 pour le test ; Horde reel a affiner)
DELETE FROM scenarios WHERE map=1460;
INSERT INTO scenarios (map, difficulty, scenario_A, scenario_H) VALUES (1460, 0, 786, 786);

-- 2) instance_template minimal (map instanciee, sans script C++ pour l'instant)
DELETE FROM instance_template WHERE map=1460;
INSERT INTO instance_template (map, parent, script, allowMount) VALUES (1460, 1220, '', 1);

-- 3) point de teleport GM pour tester (coord WorldSafeLocs certaine de map 1460)
DELETE FROM game_tele WHERE name='brokenshoretest';
INSERT INTO game_tele (id, position_x, position_y, position_z, orientation, map, name)
 VALUES (990001, 1094.9, 2350.7, 20.0, 283.5, 1460, 'brokenshoretest');
