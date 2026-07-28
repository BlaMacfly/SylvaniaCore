-- ============================================================
-- Runner générique de scénarios d'artefact : tables de config
-- + 1re config : « The Thundering Heavens » (WW moine, map 1528)
-- ============================================================

CREATE TABLE IF NOT EXISTS scenario_artifact_config (
  map        SMALLINT UNSIGNED NOT NULL PRIMARY KEY,
  entrance_x FLOAT NOT NULL, entrance_y FLOAT NOT NULL, entrance_z FLOAT NOT NULL, entrance_o FLOAT NOT NULL DEFAULT 0,
  exit_map   SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  exit_x     FLOAT NOT NULL DEFAULT 0, exit_y FLOAT NOT NULL DEFAULT 0, exit_z FLOAT NOT NULL DEFAULT 0, exit_o FLOAT NOT NULL DEFAULT 0,
  credit_entry MEDIUMINT UNSIGNED NOT NULL DEFAULT 0,
  comment    VARCHAR(120) DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS scenario_artifact_stage (
  map   SMALLINT UNSIGNED NOT NULL,
  stage TINYINT UNSIGNED NOT NULL,
  idx   TINYINT UNSIGNED NOT NULL DEFAULT 0,
  entry MEDIUMINT UNSIGNED NOT NULL,
  x FLOAT NOT NULL, y FLOAT NOT NULL, z FLOAT NOT NULL, o FLOAT NOT NULL DEFAULT 0,
  cnt   TINYINT UNSIGNED NOT NULL DEFAULT 1,
  lvl   TINYINT UNSIGNED NOT NULL DEFAULT 0,
  teleport TINYINT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (map, stage, idx)
);

-- ---------- WW moine : The Thundering Heavens (scénario 983, Skywall 1528) ----------
-- Ancres officielles WorldSafeLocs : entrée 5740, GY mi-parcours 5291, GY final 5292.
REPLACE INTO scenario_artifact_config VALUES
(1528, -428.0, 334.6, 739.7, 3.14,  1514, 882.9, 3605.6, 192.2, 3.0,  0, 'WW monk - Thundering Heavens (Typhinius)');

REPLACE INTO scenario_artifact_stage (map, stage, idx, entry, x, y, z, o, cnt, lvl, teleport) VALUES
-- étape 1 : plateau d''entrée, soldats des vents
(1528, 1, 0, 104604, -455.0, 340.0, 739.7, 0.2, 4, 99, 0),
(1528, 1, 1, 100647, -462.0, 328.0, 739.7, 0.2, 2, 100, 0),
-- étape 2 : terrasse médiane (téléport groupe)
(1528, 2, 0, 109768, -731.9, 436.6, 644.5, 1.4, 4, 99, 1),
(1528, 2, 1, 100796, -742.0, 445.0, 644.5, 1.4, 2, 100, 0),
-- étape 3 : plateforme finale — Typhinius (téléport groupe)
(1528, 3, 0, 100760, -1244.4, 413.9, 662.2, 5.3, 1, 102, 1),
(1528, 3, 1, 100762, -1252.0, 405.0, 662.2, 5.3, 1, 100, 0);

-- gabarits du cast (stubs 1/1 faction 35)
UPDATE creature_template SET faction=16, minlevel=102, maxlevel=102, HealthModifier=GREATEST(HealthModifier*12,12), `rank`=3 WHERE entry=100760;
UPDATE creature_template SET faction=16, minlevel=100, maxlevel=100, HealthModifier=GREATEST(HealthModifier*2,2) WHERE entry IN (100647,100796,100762);
UPDATE creature_template SET faction=16, minlevel=99, maxlevel=99 WHERE entry IN (104604,109768);

-- rattachement scénario + script d'instance
REPLACE INTO scenarios (map, difficulty, scenario_A, scenario_H, zoneid) VALUES (1528, 0, 983, 983, 0);
UPDATE instance_template SET script='scenario_artifact_runner_1528' WHERE map=1528;

-- texte FR du boss
DELETE FROM creature_text WHERE CreatureID=100760;
INSERT INTO creature_text (CreatureID, GroupID, ID, Text, Type, Language, Probability, Emote, Duration, Sound, BroadcastTextId, TextRange, comment) VALUES
(100760, 0, 0, 'Les Poings des Cieux m''appartiennent, moine ! Les vents eux-mêmes se dresseront contre toi !', 14, 0, 100, 15, 0, 0, 0, 0, 'Typhinius spawn');
