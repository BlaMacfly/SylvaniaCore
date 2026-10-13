-- DB/Instances: Retour a Karazhan s'ouvre a pied, comme les autres donjons Legion (le client 7.3.5 n'a pas de declencheur pour eux).
-- L'entree (spawn 21) etait posee sur les Iles brisees (carte 1220) aux coordonnees du Defile de Deuillevent : on la remet sur la carte 0.
-- La sortie (spawn 22, dans l'instance 1651) n'avait aucune teleportation : elle ramene a la porte haute (WorldSafeLocs 3771, destination
-- officielle, la meme que Titans-Project). Le declencheur client 4135 (porte haute de l'ancien raid, carte 532) est a 21 m : pas de chevauchement.
UPDATE `areatrigger` SET `map_id` = 0 WHERE `guid` = 21 AND `map_id` = 1220;
DELETE FROM `areatrigger_teleport` WHERE `ID` = -22;
INSERT INTO `areatrigger_teleport` (`ID`, `PortLocID`, `Name`) VALUES (-22, 3771, 'Return to Karazhan Exit');
