-- Fix LFG WotLK: 9 donjons normaux avec niv requis 73-75 alors que la recherche
-- de donjon les propose dès ~70-72 => teleport refuse (reason 6, "position invalide")
-- pour joueurs 70-74. Aligne le niveau requis normal a 70 (Solocraft scale le joueur).
-- Heroiques (diff 2, niv 80) NON touches. Hot-reload: .reload access_requirement.
-- Rollback: voir backup_access_wotlk_lfg_before.txt. 2026-06-21
UPDATE access_requirement SET level_min=70
WHERE difficulty=1 AND mapId IN (575,578,595,599,602,604,632,650,658);
