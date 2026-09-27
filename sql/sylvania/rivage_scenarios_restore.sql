-- =====================================================================
-- Rivage brise : rendre a la carte 1460 son vrai scenario.
--
-- SIGNALE EN JEU : « la p1 ne se lance pas, le serveur considere
-- toujours la phase finale », et -- intuition juste de l'utilisateur --
-- « un cherry-pick a ete fait sur une autre session, ca a peut-etre
-- casse le scenario ».
--
-- C'etait bien cela. Les deux lots de correctifs repris le 27/09
-- (2026_09_27_00 et _01) contiennent tous deux :
--
--     DELETE FROM `scenarios` WHERE `map`=1460;
--     INSERT INTO `scenarios` VALUES (1460, 12, 1018, 1017);
--
-- Or 1018 « Broken Shore - Alliance » et 1017 « Broken Shore - Horde »
-- sont de TYPE 0 : une autre famille de scenarios. Notre implementation
-- vise le type 4, celui de la campagne d'introduction.
--
-- Verifie sur wago.tools, build 7.3.5.26972 :
--     786  « The Battle for Broken Shore », type 4, 9 etapes,
--          dont « Find Varian » et « Stop Gul'dan »   -> ALLIANCE
--     1189 « The Battle for Broken Shore », type 4, 9 etapes,
--          dont « Find The Others » et « Hold The Ridge » -> HORDE
--
-- L'etape « Raze the Black City » de 786 porte l'arbre 42770, celui-la
-- meme dont nous avons releve les poids (1, 2, 5, 10 pour 300 points).
--
-- Table lue au DEMARRAGE uniquement : un redemarrage est necessaire.
-- =====================================================================

DELETE FROM `scenarios` WHERE `map` = 1460;

INSERT INTO `scenarios` (`map`, `difficulty`, `scenario_A`, `scenario_H`, `zoneid`) VALUES
(1460, 12, 786, 1189, 0);
