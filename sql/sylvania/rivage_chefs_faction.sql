-- =====================================================================
-- Rivage brisé — les chefs de faction n'existaient nulle part
--
-- Audit du 23/08/2026 : quatre PNJ portent le drapeau de donneur ou de
-- récepteur de quête, mais n'ont AUCUNE ligne dans `creature`. Tout le
-- retour dans les capitales après la défaite du Rivage brisé était donc
-- inaccessible, pour les deux factions :
--
--   100973 Anduin Wrynn   donne  44120 « Des alliés illidari »
--                                44473 « Une arme de l'Alliance »
--   100429 Anduin Wrynn   reçoit 40517 « Le lion terrassé »
--   101035 Sylvanas       donne  40605 « Surveillance rapprochée »
--                                41002 « Une arme de la Horde »
--   100866 Sylvanas       reçoit 40522 « Le destin de la Horde »
--                                (et donne déjà 40760)
--
-- D'OÙ VIENNENT LES COORDONNÉES
-- Aucune position n'est inventée. Les X/Y sortent de `quest_poi_points`,
-- la table des points d'intérêt de quête, qui vient des données client :
-- pour chaque quête, l'entrée d'indice 0 (ObjectiveIndex -1) marque
-- l'emplacement du donneur ou du récepteur.
--   44120 / 44473 -> carte 0, (-8896, 1023)
--   40605 / 41002 -> carte 1, (1824, -4417)
--   40517         -> carte 0, (-8362, 231)
--   40522         -> carte 1, (1251, -4376)
-- Ces tables ne fournissent pas l'altitude ; elle est reprise des
-- créatures déjà posées au même endroit, à moins de 3 m :
--   (-8896, 1023) -> z 124.414, orientation 4.0987 (Elerion Chantelame
--                    101004, à 0,5 m — c'est le camp illidari de
--                    Hurlevent : Falara Chantenuit, Trafiquant illidari,
--                    Exécuteur illidari et gardes de la ville)
--   (1824, -4417) -> z 103.39, orientation 2.29 (Elthyn Da'rai 95234, à
--                    0,2 m — le camp illidari d'Orgrimmar, exactement le
--                    pendant Horde du précédent)
--   (1251, -4376) -> z 28.99 (faune à 2,4 m). Aucune créature orientée à
--                    proximité : orientation laissée à 0, faute de
--                    référence. C'est le seul point non déduit.
--
-- POURQUOI 100429 N'EST PAS APPARU
-- Son point d'intérêt (-8362, 231) est occupé par un AUTRE Anduin déjà
-- posé : l'entrée 107574, à 2 m, avec le drapeau de donneur et déjà
-- récepteur de trois quêtes. Sur les serveurs officiels les deux entrées
-- coexistent dans des phases différentes ; ici, poser 100429 mettrait
-- deux Anduin côte à côte sur le trône. On attribue donc le rôle de
-- récepteur de 40517 à celui qui est déjà en place — même expérience de
-- jeu, sans doublon visible. C'est la méthode déjà employée pour Maiev
-- dans le Caveau des Gardiennes.
--
-- Phasage : volontairement ignoré. Le développeur de LegionCore a fait
-- le même choix dans son propre correctif d'introduction Legion (« not
-- bothering with phasing as it is a single npc and we have bigger things
-- to worry about »). Ces PNJ seront donc visibles en permanence.
--
-- `RegenHealth` vaut 1 sur les trois entrées : `curhealth` est ignoré,
-- aucun risque du défaut « PNJ mort à l'apparition ».
--
-- ⚠️ REDÉMARRAGE NÉCESSAIRE : aucune commande ne recharge à chaud la
-- table `creature`.
-- =====================================================================

DELETE FROM `creature` WHERE `guid` BETWEEN 290000100 AND 290000102;
INSERT INTO `creature`
 (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,
  `terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,
  `spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,
  `npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`dynamicflags`,`ScriptName`,`movementmode`,`VerifiedBuild`) VALUES
-- Anduin Wrynn, camp illidari de Hurlevent — donne « Des alliés illidari » et « Une arme de l'Alliance »
(290000100,100973,0,1519,1519,0,0,0,0,-1,0,0, -8896.0,1023.0,124.414,4.0987, 300,0,0,1,0,0, 0,0,0,0,0,'',0,0),
-- Lady Sylvanas, camp illidari d'Orgrimmar — donne « Surveillance rapprochée » et « Une arme de la Horde »
(290000101,101035,1,1637,1637,0,0,0,0,-1,0,0, 1824.0,-4417.0,103.39,2.29, 300,0,0,1,0,0, 0,0,0,0,0,'',0,0),
-- Lady Sylvanas, abords d'Orgrimmar — reçoit « Le destin de la Horde », donne « Vers le Rivage brisé »
(290000102,100866,1,14,4982,0,0,0,0,-1,0,0, 1251.0,-4376.0,28.99,0.0, 300,0,0,1,0,0, 0,0,0,0,0,'',0,0);

-- --- 40517 : le rôle de récepteur va à l'Anduin déjà en place ----------
DELETE FROM `creature_questender` WHERE `id`=107574 AND `quest`=40517;
INSERT INTO `creature_questender` (`id`,`quest`) VALUES (107574,40517);
