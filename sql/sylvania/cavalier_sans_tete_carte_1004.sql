-- Cavalier sans tete (Sanssaint) - donjon d'evenement 285 de la recherche de groupe.
-- Base : dc_world. Rejouable. Signalement du 24/10/2026 (le baltring) : « l'instance du Cavalier sans
-- tete beugue enormement, on est en apesanteur sous la map ».
-- LFGDungeons.db2 7.3.5 : le donjon 285 se joue sur la carte 1004 (Monastere ecarlate refait a MoP),
-- difficulte 19 (evenement). Trois defauts :

-- 1. Entree : nos coordonnees etaient celles du vieux Cimetiere (carte 189) -> dans le vide de 1004.
--    Valeurs LegionCore (lfg_entrances 285, identiques a l'entree du Monastere ecarlate 164).
UPDATE `lfg_dungeon_template` SET `position_x` = 1124.57, `position_y` = 511.299, `position_z` = 0.9892, `orientation` = 1.53889
WHERE `dungeonId` = 285;

-- 2. Instance vide : toutes les apparitions de 1004 etaient en difficultes 1,2,8. LegionCore ne met en 19
--    que le decor de l'evenement : sanctuaire-citrouille 186267, 7 bougies 186269, table 186327 (deja
--    chez nous) et le monticule 186314. (1533228 = table en double au meme endroit, laissee hors 19.)
UPDATE `gameobject` SET `spawnDifficulties` = CONCAT(`spawnDifficulties`, ',19')
WHERE `map` = 1004 AND `guid` IN (1533220,1533221,1533222,1533223,1533224,1533225,1533226,1533227,1533229)
  AND FIND_IN_SET('19', `spawnDifficulties`) = 0;

-- 3. Monticule de Terre retournee (186314, go_loosely_turned_soil) absent de la carte 1004.
--    Position, rotation, delai et difficultes (masque 524550 = 1,2,8,19) de LegionCore ; lie a la
--    Sanssaint (evenement 12) comme le reste du decor.
DELETE FROM `game_event_gameobject` WHERE `guid` = 290400300;
DELETE FROM `gameobject` WHERE `guid` = 290400300;
INSERT INTO `gameobject` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`,`isActive`,`ScriptName`,`VerifiedBuild`) VALUES
(290400300,186314,1004,6109,6384,'1,2,8,19',0,0,0,-1,1088.97,611.826,0.0735657,5.0091,0,0,0.209902,0.977722,300,0,1,0,'',0);
INSERT INTO `game_event_gameobject` (`eventEntry`,`guid`) VALUES (12,290400300);

-- Retour arriere :
-- UPDATE `lfg_dungeon_template` SET `position_x` = 1797.52, `position_y` = 1347.38, `position_z` = 18.8876, `orientation` = 3.142 WHERE `dungeonId` = 285;
-- UPDATE `gameobject` SET `spawnDifficulties` = '1,2,8' WHERE `guid` IN (1533220,1533221,1533222,1533223,1533224,1533225,1533226,1533227,1533229);
-- DELETE FROM `game_event_gameobject` WHERE `guid` = 290400300; DELETE FROM `gameobject` WHERE `guid` = 290400300;
