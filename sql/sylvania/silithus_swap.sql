-- Silithus : retirer l'echange de terrain 1815, que le serveur ne peut pas lire.
--
-- Mesure dans Map.db2 (build 26972) :
--     carte 1815 : ParentMapID = -1, CosmeticParentMapID = -1   <-- aucune parente
--     carte 1817 : ParentMapID =  1, CosmeticParentMapID =  1
--
-- Une carte d'echange de terrain doit etre rattachee a sa carte parente pour que
-- Map::GetGrid puisse la charger. 1815 ne l'est pas : le serveur mettait donc le
-- joueur en phase 1815, disait au client de dessiner ce terrain-la, et retombait
-- lui-meme en silence sur celui de la carte 1. Releve en jeu, Ruche'Zora :
--     joueur pose sur le sol du client : Z = -25.46  (terrain 1815)
--     GroundZ calcule par le serveur   :    -38.58  (terrain 1)
--
-- 1817 montre le montage correct : rattachee a la carte 1, elle remplace le terrain
-- de base pour les niveaux 110. La carte 1 EST donc l'ancienne Silithus, et un
-- joueur sous 110 n'a besoin d'aucun echange. La ligne 1 -> 1815 est en trop.
--
-- Annulation : /home/ubuntu/db-backups/silithus-swap-1815-*.sql

DELETE FROM `terrain_swap_defaults` WHERE `MapId` = 1 AND `TerrainSwapMap` = 1815;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 25 AND `SourceEntry` = 1815;

-- La ligne UI de 1815 pointait sur WorldMapArea 0, rejetee a chaque demarrage
-- (<< WorldMapArea 0 defined in `terrain_worldmap` does not exist, skipped >>).
-- Sans echange, elle n'a plus d'objet.
DELETE FROM `terrain_worldmap` WHERE `TerrainSwapMap` = 1815;
