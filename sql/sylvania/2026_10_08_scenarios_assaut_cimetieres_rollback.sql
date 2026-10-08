-- Annule 2026_10_08_scenarios_assaut_cimetieres.sql
DELETE FROM graveyard_zone WHERE GhostZone IN (8570, 8625, 8646, 8596) AND Comment LIKE "Assaut %";
