-- Emmarel Shadewarden (102478) : ramenee a Dalaran.
--
-- Signalement d'un joueur : le PNJ a qui rendre la quete d'arme prodigieuse du
-- chasseur, a Dalaran, n'y est pas.
--
-- Verifie : l'entree 102478 est bien le point de rendez-vous de l'introduction aux
-- armes prodigieuses. Elle donne ET rend << Weapons of Legend >> (40618), et rend
-- aussi << The Hunter's Call >> (41415), << The Spear in the Shadow >> (40385),
-- << Needs of the Hunters >> (40384) et << Hunter to Hunter >> (40952, 41009).
-- Wowhead la place en zone 7502, Dalaran. Nous l'avions au Pavillon du tir
-- infaillible, avec les entrees 102574, 102578 et 107317 -- qui, elles, y sont bien
-- a leur place (zone 7877).
--
-- Position etablie par deux methodes independantes qui concordent :
--   X/Y : regression pin -> monde sur trente PNJ de Dalaran, les bornes de cette
--         zone etant nulles dans WorldMapArea.db2 -- Dalaran est une ville flottante.
--         Ses deux pins sont serres (2,9 m d'ecart), donc la position est nette.
--   Z   : les trois PNJ les plus proches du point calcule -- Koraud a 8,8 m, une
--         jardiniere a 6,4 m, Aerith Primrose a 11,2 m -- sont tous a 738,0. C'est
--         le niveau de la place principale.
--
-- L'orientation est arbitraire : aucune source ne la donne.
--
-- Annulation : db-backups/emmarel-dalaran-*.sql

UPDATE `creature`
   SET `position_x` = -868.50,
       `position_y` = 4395.90,
       `position_z` = 738.05,
       `orientation` = 3.1416,
       `zoneId` = 0,
       `areaId` = 0
 WHERE `guid` = 280000602 AND `id` = 102478;
