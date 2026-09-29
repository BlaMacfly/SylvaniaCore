-- =====================================================================
-- « La Bataille du Rivage brisé » (40518) — le capitaine Russo manquait
-- =====================================================================
--
-- La quête Horde envoie le joueur à la baie de Lamepoing pour embarquer.
-- Son deuxième objectif, « Navire pris pour le Rivage brisé », attend un
-- crédit sur la créature 113118, Captain Russo. Ce PNJ portait déjà son
-- script (`npc_q40518`, enregistré) mais n'avait AUCUNE apparition dans
-- la table `creature` : le joueur arrivait sur un quai désert.
--
-- Son homologue Alliance, Captain Angelica (108920), est posée sur le
-- port de Hurlevent avec le drapeau de dialogue et le menu 19870.
-- Russo n'avait ni l'un ni l'autre : même sans apparition, il aurait été
-- impossible de lui parler.
--
-- Le menu 19870 convient aux deux camps : son unique option, « Je suis
-- prêt à affronter la Légion », ne mentionne aucune faction, elle est
-- déjà traduite en français, et aucune condition ne la restreint.
--
-- Le script se charge du reste : il crédite l'objectif puis lance la
-- scène d'embarquement (sort 225147). Aucun navire n'est donc nécessaire
-- côté monde — le bateau appartient à la scène, exactement comme du
-- côté Alliance où Angelica se tient sur le quai, pas sur un pont.
--
-- Position : le point officiel de l'objectif, donné par `quest_poi`,
-- est (1440, -5016). L'altitude reprend le plan des PNJ officiels
-- voisins (Nazgrim, Budd, Adarrah), tous entre 11,9 et 12,7. Zone et
-- aire reprises d'eux également : 14 (Durotar) / 374 (baie de
-- Lamepoing), sans phase, pour qu'il soit visible de tous.
-- =====================================================================

UPDATE `creature_template`
   SET `npcflag` = 1, `gossip_menu_id` = 19870
 WHERE `entry` = 113118;

DELETE FROM `creature` WHERE `guid` = 290300100;
INSERT INTO `creature`
  (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`,
   `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`,
   `position_x`, `position_y`, `position_z`, `orientation`,
   `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`,
   `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
   `dynamicflags`, `ScriptName`, `movementmode`, `VerifiedBuild`)
VALUES
  (290300100, 113118, 1, 14, 374, '0', 0,
   0, 0, -1, 0, 0,
   1440.50, -5016.40, 12.16, 1.8133,
   120, 0, 0, 6472, 0,
   0, 0, 0, 0, 0,
   0, '', 0, 26972);
