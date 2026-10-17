-- Assaut sur le Fort Pourpre (carte 1544) - plantage du serveur a chaque essai.
-- Base : dc_world. Rejouable. Signalement du 17/10/2026 01h23 (le baltring) ; deux plantages
-- (01h20:59, 01h23:16), meme pile : instance_violet_hold_assault::Update ->
-- CriteriaHandler::CheckCompletedCriteriaTree sur GetInstanceScenario() == nullptr.
-- La carte 1544 n'avait AUCUNE ligne `scenarios` : pas de scenario d'instance.
-- Scenarios d'apres ScenarioStep.db2 7.3.5, qui portent les arbres de criteres attendus par le
-- script (CRITERIA_*_STAGE_1..3) :
--   1027 « The Violet Hold » : 52867 / 52913 / 52929 (normal)
--   1029 « The Violet Hold » : 52948 / 52963 / 52980 (heroique)
--   1251 « The Violet Hold » : 56177 / 56192 / 56209 (mythique)
DELETE FROM `scenarios` WHERE `map` = 1544 AND `difficulty` IN (1, 2, 23);
INSERT INTO `scenarios` (`map`,`difficulty`,`scenario_A`,`scenario_H`,`zoneid`) VALUES
(1544, 1, 1027, 1027, 0),
(1544, 2, 1029, 1029, 0),
(1544, 23, 1251, 1251, 0);
-- Retour arriere : DELETE FROM `scenarios` WHERE `map` = 1544 AND `difficulty` IN (1, 2, 23);
