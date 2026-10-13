-- DB/World: 8 scenarios d acquisition d arme prodigieuse tournaient sans script d instance.
-- Chaque carte a un script C++ dedie (import amont du 17/06) mais la base portait un nom
-- 'scenario_7.0_artifact_...' qui n existe pas dans le code. Les UPDATE prevus par l amont
-- etaient dans sql/test/world, jamais applique ; insideResurrection=1 repris de l amont
-- pour les cartes ou il l activait avec le script.
UPDATE `instance_template` SET `script` = 'scenario_the_violet_hold' WHERE `map` = 1494;
UPDATE `instance_template` SET `script` = 'scenario_artifact_brokenshore', `insideResurrection` = 1 WHERE `map` = 1500;
UPDATE `instance_template` SET `script` = 'scenario_artifact_karazhan_catacombs', `insideResurrection` = 1 WHERE `map` = 1533;
UPDATE `instance_template` SET `script` = 'scenario_artifact_ursocslair' WHERE `map` = 1536;
UPDATE `instance_template` SET `script` = 'scenario_artifact_tirisfal_glades', `insideResurrection` = 1 WHERE `map` = 1539;
UPDATE `instance_template` SET `script` = 'scenario_mage_art' WHERE `map` = 1583;
UPDATE `instance_template` SET `script` = 'scenario_artifact_restoacqusition', `insideResurrection` = 1 WHERE `map` = 1599;
UPDATE `instance_template` SET `script` = 'scenario_artifact_ruins_of_falanaar', `insideResurrection` = 1 WHERE `map` = 1612;
