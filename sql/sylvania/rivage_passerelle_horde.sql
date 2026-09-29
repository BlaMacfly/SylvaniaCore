-- =====================================================================
-- Rivage brisé — la passerelle du gouffre, côté Horde
-- =====================================================================
--
-- Le gouffre de la phase 7 se franchit par une passerelle de décor,
-- entrée custom 1000203, posée côté Alliance en (1419.9, 2107.0).
-- Côté Horde l'itinéraire passe ailleurs et rien ne l'enjambait.
--
-- Position et cap relevés en jeu par l'utilisateur. Restait la pente :
-- les commandes de maître de jeu ne savent poser qu'un cap — `.gobject
-- turn` ne tourne qu'autour de la verticale — si bien que le quaternion
-- écrit par `.gobject add` ne porte AUCUNE inclinaison. La passerelle
-- était donc parfaitement horizontale au-dessus d'une faille en pente.
--
-- CALCUL. On ne réinvente pas l'inclinaison : on la reprend telle quelle
-- de la passerelle Alliance, qui a été validée à l'essai. En retirant de
-- son quaternion complet la part de cap — q_pente = q_cap⁻¹ · q_total —
-- il reste une rotation pure de 16,1197° autour de l'axe X PROPRE de
-- l'objet, ce qui confirme au centième la valeur inscrite dans
-- rivage_passerelle.sql.
--
-- Cette pente est ensuite recomposée avec le cap hordeux :
-- q = q_cap(1.86159) · q_pente. Le contrôle inverse redonne bien
-- 16,1200° et la norme vaut 1. La passerelle penche donc dans le même
-- sens et du même angle que sa jumelle, sur son propre axe.
--
-- L'entrée 1000203 porte déjà GO_FLAG_NOT_SELECTABLE : décor muet au
-- clic, comme l'autre.
-- =====================================================================

DELETE FROM `gameobject` WHERE `guid` = 210300271;

INSERT INTO `gameobject`
  (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,
   `position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,
   `spawntimesecs`,`animprogress`,`state`,`isActive`,`ScriptName`,`VerifiedBuild`) VALUES
(210300271, 1000203, 1460, 0, 0, '12', 0, 0, 0, -1,
 1329.920, 1723.380, 25.170, 1.86159,
 -0.083732, -0.112462, 0.794175, 0.591293, 300, 255, 1, 0, '', 0);
