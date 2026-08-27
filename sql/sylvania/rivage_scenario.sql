-- =====================================================================
-- Assaut du Rivage brisé (carte 1666) — DÉCLARATION DU SCÉNARIO
--
-- Sans cette ligne, la carte 1666 n'a aucun scénario attaché : le suivi
-- d'objectifs ne s'affiche pas et aucune progression n'est enregistrée.
-- C'est le même manque que celui constaté sur les donjons de Pandarie.
--
-- D'OÙ VIENNENT LES VALEURS, et pourquoi elles ne sont pas supposées
--
--   Scénario 1280 : relevé dans `scenario_data` du dump de référence
--   (dufernst/LegionCore-7.3.5, même lignée uwow), puis VÉRIFIÉ dans
--   `Scenario.db2` du build 7.3.5.26972 :
--       1280, "The Assault on Broken Shore", Type 4
--
--   Difficulté 12 : relevée dans `MapDifficulty.db2` du même build —
--   la carte 1666 n'a qu'une seule difficulté déclarée, la 12, pour
--   5 joueurs. Et `Difficulty.db2` donne pour la 12 : « Normal Scenario »,
--   type d'instance 5.
--
--   Recoupement indépendant : les 593 placements extraits pour cette
--   carte portent tous `spawnMask = 4096`, soit 2¹² — la même
--   difficulté 12. Deux sources distinctes concordent.
--
--   Alliance et Horde : la référence donne `Team = 0`, c'est-à-dire les
--   deux camps. `scenario_A` et `scenario_H` reçoivent donc la même
--   valeur. C'est cohérent avec la vidéo, qui montre le même déroulé
--   des deux côtés.
--
-- CE QUE ÇA FAIT, ET CE QUE ÇA NE FAIT PAS
-- Cette ligne attache le scénario et fera apparaître ses huit étapes
-- (Into the Fray, Vanguard of the Assault, Might of the Legion, Rifts of
-- Chaos, The Doomguard's Command, Gateway to Ruin, Pillar of Fire,
-- Mephistroth). Elle ne place personne et ne déclenche rien : sans les
-- placements et sans le script d'instance, la carte restera vide.
--
-- ⚠️ Table lue au démarrage uniquement : un redémarrage est nécessaire.
-- =====================================================================

DELETE FROM `scenarios` WHERE `map`=1666;

INSERT INTO `scenarios` (`map`, `difficulty`, `scenario_A`, `scenario_H`, `zoneid`) VALUES
(1666, 12, 1280, 1280, 0);
