-- Points de resurrection des scenarios d assaut : aucun cimetiere n etait rattache a leurs zones (8570 Val sharah,
-- 8625 Azsuna, 8646 Haut-Roc, 8596 Tornheim). WorldSafeLocs utilises par LegionCore selon l etape ; notre moteur
-- prend le plus proche du lieu de la mort. Rollback : ..._cimetieres_rollback.sql
INSERT INTO graveyard_zone (ID, GhostZone, Faction, Comment) VALUES
(5885, 8570, 0, Assaut Val sharah - debut),
(5887, 8570, 0, Assaut Val sharah - etapes 1 a 6),
(5888, 8570, 0, Assaut Val sharah - etape 7+),
(5917, 8625, 0, Assaut Azsuna - etapes 0 a 2),
(5918, 8625, 0, Assaut Azsuna - sommet),
(5945, 8646, 0, Assaut Haut-Roc - etapes 0 a 5),
(5946, 8646, 0, Assaut Haut-Roc - sommet),
(5913, 8596, 0, Assaut Tornheim - debut),
(5911, 8596, 0, Assaut Tornheim - forteresse);
