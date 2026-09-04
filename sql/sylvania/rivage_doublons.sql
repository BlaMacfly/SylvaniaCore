-- =====================================================================
-- Rivage brisé — créatures posées deux fois au même endroit
--
-- SIGNALÉ EN JEU : « il est spawn 2 fois au même endroit » (entrée
-- 92564, guid 290200360).
--
-- Neuf créatures de la carte 1460 occupent une position strictement
-- identique à une autre — même entrée, mêmes coordonnées au centimètre.
-- En jeu, deux modèles se superposent exactement.
--
-- L'IMPORT N'EST PAS EN CAUSE. La référence les porte déjà en double :
--   (294825,92564,1460,…,1254.48,2438.92,47.0961,…)
--   (294827,92564,1460,…,1254.48,2438.92,47.0961,…)
-- La transposition était fidèle ; c'est la donnée d'origine qui l'est
-- moins. Écart assumé avec la référence, au bénéfice du rendu.
--
-- On conserve le plus petit guid de chaque paire.
-- =====================================================================

DELETE c FROM `creature` c
  JOIN (
        SELECT `id`, ROUND(`position_x`,1) AS px, ROUND(`position_y`,1) AS py,
               MIN(`guid`) AS garder
          FROM `creature`
         WHERE `map` IN (1460, 1666)
         GROUP BY `id`, px, py
        HAVING COUNT(*) > 1
       ) AS d
    ON  c.`id` = d.`id`
    AND ROUND(c.`position_x`,1) = d.px
    AND ROUND(c.`position_y`,1) = d.py
    AND c.`guid` <> d.garder
 WHERE c.`map` IN (1460, 1666);
