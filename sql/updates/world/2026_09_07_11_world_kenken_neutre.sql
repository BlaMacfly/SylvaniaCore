-- Ken-Ken (60979) : faction 14, donc hostile a TOUT LE MONDE, alors qu'il porte le
-- drapeau de dialogue (npcflag 1). Personne ne pouvait lui parler.
--
-- Meme classe d'erreur que Khadgar 78288, trouvee par le meme signal : sur les 8 entrees
-- "Ken-Ken" de la base, six sont en faction 35 et celle-ci est la seule en 14.
-- Wowhead le donne amical envers l'Alliance ET la Horde.
--
-- Deux spawns concernes, foret de Jade (carte 870, zone 5841).
UPDATE `creature_template` SET `faction` = 35 WHERE `entry` = 60979;
