-- =====================================================================
-- Rivage brise, phase 7 : la passerelle du gouffre.
--
-- Le scenario officiel fait conjurer a Jaina un pont de glace pour
-- franchir la faille qui separe l'armee de Tirion. Verifie sur la video
-- de reference : Gelbin demande « Comment est-ce qu'on va traverser ? »,
-- Jaina repond « Je m'en occupe », et gele un passage.
--
-- POURQUOI PAS LE PONT DE GLACE OFFICIEL. Son modele est identifie --
-- world/expansion06/doodads/brokenshore/7bs_brokenshore_icebridge01.m2,
-- FileDataID 1349000, affichage 35871 -- mais il est inutilisable pour
-- deux raisons independantes :
--
--   1. Son en-tete M2 ne declare AUCUNE collision : zero triangle, zero
--      sommet, zero normale. Une re-extraction des vmaps ne produirait
--      rien. Blizzard fait donc traverser ses joueurs autrement.
--
--   2. Le client de ce serveur recoit ses donnees par notre miroir CASC,
--      qui ne sert que ce que les cartes reclament. Huit modeles de pont
--      ont ete essayes a la main : tous correctement crees cote serveur,
--      tous invisibles en jeu. Un modele absent de la carte n'est jamais
--      telecharge.
--
-- REGLE QUI EN DECOULE, et qui vaut pour tout ce qu'on posera ici :
-- n'employer que des modeles DEJA presents sur la carte.
--
-- On copie donc l'objet 243468 (affichage 31700), retenu apres essais en
-- jeu parce qu'il s'affiche. Entree propre plutot que modification d'un
-- objet partage, echelle 4 pour couvrir la faille, et drapeau
-- GO_FLAG_NOT_SELECTABLE : une passerelle de decor n'a pas a repondre au
-- clic.
--
-- ORIENTATION. Les commandes de maitre de jeu ne savent poser qu'un cap
-- -- « .gobject turn » ne tourne qu'autour de la verticale -- alors que
-- la table porte un quaternion complet. La pente a donc ete calculee et
-- ecrite ici. Position et cap choisis en jeu par l'utilisateur ; pente
-- de 16,12 degres, autour de l'axe et dans le sens valides a l'essai.
-- =====================================================================

DELETE FROM `gameobject` WHERE `guid` BETWEEN 210300200 AND 210300220;
DELETE FROM `gameobject_template_addon` WHERE `entry` = 1000203;
DELETE FROM `gameobject_template` WHERE `entry` IN (1000200, 1000201, 1000202, 1000203);

INSERT INTO `gameobject_template`
  (`entry`,`type`,`displayId`,`name`,`IconName`,`castBarCaption`,`unk1`,`size`,`ScriptName`) VALUES
(1000203, 0, 31700, 'Passerelle du gouffre', '', '', '', 4, '');

INSERT INTO `gameobject_template_addon` (`entry`,`faction`,`flags`,`mingold`,`maxgold`) VALUES
(1000203, 0, 16, 0, 0);

INSERT INTO `gameobject`
  (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,
   `position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,
   `spawntimesecs`,`animprogress`,`state`,`isActive`,`ScriptName`,`VerifiedBuild`) VALUES
(210300217, 1000203, 1460, 0, 0, '12', 0, 0, 0, -1,
 1419.867, 2106.993, 23.278, 0.4621,
 -0.136484, -0.032108, 0.226738, 0.963811, 300, 100, 1, 0, '', 0);
