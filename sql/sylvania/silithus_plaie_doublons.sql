-- Silithus, La Plaie : retirer les doublons de service que j'avais inventes.
--
-- Pour rendre la zone jouable, j'avais double les deux maitres de vol et les huit
-- guerisseurs d'esprit en phase 2407, a la meme position mais au Z de la carte 1817.
-- Aucune source ne les place dans La Plaie : le bloc de carte de Wowhead pour
-- Cloud Skydancer (15177) ne porte pas le marqueur uiMapPhaseId 9491, contrairement
-- a Rhonormu. C'etait donc une invention de confort, pas une reconstitution.
--
-- Choix assume : la fidelite plutot que le confort. Un joueur de La Plaie n'a donc
-- ni vol ni guerisseur d'esprit -- il rentre a pied, par pierre de foyer, ou par
-- Rhonormu, qui est justement le moyen officiel de quitter la zone ravagee.
--
-- Annulation : db-backups/silithus-doublons-service-*.sql

DELETE FROM `creature` WHERE `guid` BETWEEN 290201812 AND 290201821;
