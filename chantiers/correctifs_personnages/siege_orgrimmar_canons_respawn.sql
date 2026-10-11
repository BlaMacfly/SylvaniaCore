-- Base : dc_characters. A jouer serveur ARRETE (sinon la carte reecrit les delais).
-- Les canons Kor'kron du Siege (GUID 290330001-290330007) tues avant que leur mort ne compte
-- pour l'evenement de Galakras (11/10/2026) gardaient 7 jours de delai de reapparition dans
-- l'instance : l'evenement etait bloque pour cette instance. Rejouable.
DELETE FROM `creature_respawn` WHERE `mapId` = 1136 AND `guid` BETWEEN 290330001 AND 290330007;
