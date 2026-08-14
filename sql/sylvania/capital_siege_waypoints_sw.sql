--
-- SylvaniaCore - Module "Siege des Capitales"
-- Base : dc_world
--
-- Route d assaut de Hurlevent : de la Vallee des Heros au trone d Anduin Wrynn.
--
-- Aucune coordonnee n est inventee. Chaque point est repris soit d un trajet de
-- patrouille reel (table waypoint_data, patrouilleurs de Hurlevent), soit de la
-- position d un PNJ effectivement spawne. Ces points sont donc marchables par
-- construction, ce qui evite d avoir a valider la route a la main en jeu.
-- Detour calcule le chemin entre deux points consecutifs : la route n a pas
-- besoin d etre dense, seulement d etre ordonnee et de ne pas traverser de mur.
--
-- Plage d entrees reservee :
--   1000-1099  Hurlevent
--   2000-2099  Orgrimmar (etape E10)
--
-- La colonne `link` reste vide : comme CommandBG, CommandSiege consomme une
-- liste ordonnee d entrees et n utilise pas le graphe de liaisons.
--

DELETE FROM `aiwaypoints` WHERE `entry` BETWEEN 1000 AND 1099;

INSERT INTO `aiwaypoints` (`entry`, `map`, `x`, `y`, `z`, `link`, `helpText`) VALUES
-- Approche exterieure : le pont de la Vallee des Heros, hors les murs.
(1000, 0, -8904.1,  692.4,  99.5, '', 'Hurlevent 01/24 - Rassemblement, Vallee des Heros ouest'),
(1001, 0, -8879.3,  708.3,  98.1, '', 'Hurlevent 02/24 - Vallee des Heros, pont'),
(1002, 0, -8826.3,  733.8,  98.4, '', 'Hurlevent 03/24 - Vallee des Heros, milieu'),
(1003, 0, -8782.1,  745.9,  99.0, '', 'Hurlevent 04/24 - Vallee des Heros, est'),
(1004, 0, -8750.8,  720.9,  98.3, '', 'Hurlevent 05/24 - Approche de la porte'),
-- Entree en ville.
(1005, 0, -8717.3,  670.3,  99.0, '', 'Hurlevent 06/24 - Porte de Hurlevent'),
(1006, 0, -8703.4,  625.9, 100.5, '', 'Hurlevent 07/24 - Place du Commerce'),
-- Remontee du canal vers le quartier du Donjon.
(1007, 0, -8644.6,  658.9, 101.2, '', 'Hurlevent 08/24 - Route du canal, ouest'),
(1008, 0, -8594.2,  658.6,  98.4, '', 'Hurlevent 09/24 - Pont du canal'),
(1009, 0, -8551.4,  626.6, 101.4, '', 'Hurlevent 10/24 - Allee du Donjon, entree'),
(1010, 0, -8582.1,  599.9, 103.5, '', 'Hurlevent 11/24 - Allee du Donjon, virage'),
(1011, 0, -8591.6,  573.3, 102.7, '', 'Hurlevent 12/24 - Allee du Donjon, sud'),
(1012, 0, -8575.3,  535.4, 101.8, '', 'Hurlevent 13/24 - Approche de la cour'),
(1013, 0, -8554.0,  509.2,  98.7, '', 'Hurlevent 14/24 - Cour du Donjon, nord'),
-- Cour et perron : premiere ligne de gardes royaux.
(1014, 0, -8533.9,  461.0, 104.8, '', 'Hurlevent 15/24 - Cour du Donjon, garde royale'),
(1015, 0, -8508.2,  410.1, 108.4, '', 'Hurlevent 16/24 - Perron du Donjon'),
-- Interieur du Donjon, niveau du grand hall.
(1016, 0, -8484.8,  388.4, 115.9, '', 'Hurlevent 17/24 - Grand hall'),
(1017, 0, -8445.7,  338.7, 121.5, '', 'Hurlevent 18/24 - Salle du trone, conseil'),
-- Montee vers les appartements royaux.
(1018, 0, -8458.7,  353.1, 135.6, '', 'Hurlevent 19/24 - Escalier vers l etage'),
(1019, 0, -8434.8,  315.0, 145.4, '', 'Hurlevent 20/24 - Palier superieur'),
(1020, 0, -8407.5,  322.4, 147.0, '', 'Hurlevent 21/24 - Galerie des emissaires'),
(1021, 0, -8404.3,  276.2, 151.4, '', 'Hurlevent 22/24 - Couloir royal'),
(1022, 0, -8417.2,  211.8, 155.4, '', 'Hurlevent 23/24 - Antichambre royale'),
-- Objectif final.
(1023, 0, -8363.3,  232.5, 157.1, '', 'Hurlevent 24/24 - Trone d Anduin Wrynn');
