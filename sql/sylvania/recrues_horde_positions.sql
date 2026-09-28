-- =====================================================================
-- « Fin prêts » Horde : les recrues aux positions officielles.
--
-- Premier essai : les treize recrues avaient ete massees en arc devant
-- Holgar Hachetempete, faute de savoir ou elles allaient. L'utilisateur
-- a releve en jeu que la minicarte designait tout autre chose.
--
-- La quete porte ses propres points d'interet, et ils sont officiels.
-- Releves dans quest_poi / quest_poi_points pour la quete 44281 :
--
--   objectif 0, armure astiquee (credit 108787) -> (1301, -4584)
--   objectif 1, arme renforcee  (credit 108788) -> (1376, -4679)
--   objectif 2, dernier repas   (credit 108789) -> (1320, -4482)
--   objectif 3, duel            (credit 108722) -> polygone autour
--                                                  de (1425, -4745)
--
-- Recoupe en jeu par l'utilisateur, qui s'est place sur deux d'entre
-- eux : « d'apres la minicarte par ici on devrait avoir Dernier repas
-- consomme » en (1320.8, -4478.4), et « Armure polie ici » en
-- (1303.5, -4581.2) avec un sol a 23.11 -- pour 22.88 calcule a quatre
-- metres de la. Les altitudes sont lues dans les fichiers .map, pas
-- estimees.
--
-- Les trois postes ont ensuite ete AFFINES sur les releves exacts de
-- l utilisateur, plus precis que les points arrondis : l ecart allait de
-- trois a onze metres.
--
-- Les trois PNJ d'objectif prennent donc leur poste, et les dix autres
-- se repartissent en cercle dans l'aire de duel.
-- =====================================================================

UPDATE `creature` SET `position_x`=1303.472, `position_y`=-4581.246, `position_z`=23.110, `orientation`=4.5619 WHERE `id`=113539;
UPDATE `creature` SET `position_x`=1372.291, `position_y`=-4668.044, `position_z`=27.403, `orientation`=4.1182 WHERE `id`=113541;
UPDATE `creature` SET `position_x`=1320.847, `position_y`=-4478.394, `position_z`=24.188, `orientation`=4.1967 WHERE `id`=113540;

UPDATE `creature` SET `position_x`=1443.000, `position_y`=-4745.000, `position_z`=39.295, `orientation`=3.1416 WHERE `id`=113542;
UPDATE `creature` SET `position_x`=1439.562, `position_y`=-4734.420, `position_z`=39.360, `orientation`=3.7699 WHERE `id`=113543;
UPDATE `creature` SET `position_x`=1430.562, `position_y`=-4727.881, `position_z`=32.595, `orientation`=4.3982 WHERE `id`=113544;
UPDATE `creature` SET `position_x`=1419.438, `position_y`=-4727.881, `position_z`=29.879, `orientation`=5.0265 WHERE `id`=113545;
UPDATE `creature` SET `position_x`=1410.438, `position_y`=-4734.420, `position_z`=29.613, `orientation`=5.6549 WHERE `id`=113546;
UPDATE `creature` SET `position_x`=1407.000, `position_y`=-4745.000, `position_z`=28.833, `orientation`=0.0000 WHERE `id`=113547;
UPDATE `creature` SET `position_x`=1410.438, `position_y`=-4755.580, `position_z`=28.040, `orientation`=0.6283 WHERE `id`=113548;
UPDATE `creature` SET `position_x`=1419.438, `position_y`=-4762.119, `position_z`=28.645, `orientation`=1.2566 WHERE `id`=113549;
UPDATE `creature` SET `position_x`=1430.562, `position_y`=-4762.119, `position_z`=30.523, `orientation`=1.8850 WHERE `id`=113550;
UPDATE `creature` SET `position_x`=1439.562, `position_y`=-4755.580, `position_z`=33.591, `orientation`=2.5133 WHERE `id`=113551;
