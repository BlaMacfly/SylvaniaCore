-- Phases utilisees par phase_area, conditions et apparitions, mais absentes du Phase.db2 de notre client (livrees par hotfix
-- chez Blizzard / LegionCore) : « Phase N defined in phase_area does not exist, skipped », 4 PNJ et 4 objets invisibles pour
-- tous (quetes de domaine Paladin 42377, Chevalier de la mort 42824, Pretre 43372, Chasseur de demons 45339, 42598 ;
-- rampe du port de Hurlevent). La visibilite est decidee par le serveur : la ligne suffit.
INSERT IGNORE INTO `phase` (`ID`, `Flags`, `VerifiedBuild`) VALUES
(5149, 0, 0), (5832, 0, 0), (6002, 0, 0), (6810, 0, 0), (7626, 0, 0), (13306, 0, 0);
