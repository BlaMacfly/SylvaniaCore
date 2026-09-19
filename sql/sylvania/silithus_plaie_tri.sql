-- Silithus, La Plaie : retirer ce qui n'y appartient pas.
--
-- Wowhead etiquette chaque bloc de carte avec uiMapPhaseId quand la position est
-- propre a une phase de la zone. La Plaie porte le marqueur 9491. Verification des
-- 96 PNJ poses : 55 le portent, 41 non. Le marqueur absent ne prouve pas l'absence
-- -- Wowhead n'etiquette que les positions specifiques a une phase -- d'ou le tri.
--
-- 1. Contenu Cataclysm (entrees < 125000). Aucun doute : les quatre Ducs
--    elementaires, Prince Skaldrenox, Baron Kazum, Lord Skwol, High Marshal
--    Whirlaxis, les trois Colosses des ruches et les quatre sergents PvP
--    appartiennent a l'ancienne Silithus. Leurs apparitions dispersees sont bien
--    leur mecanique -- mais dans l'autre version de la zone.
DELETE FROM `creature` WHERE `PhaseId` = 2407 AND `id` IN
 (117432,117433,117434,117435,117489,117490,117491,
  117662,117663,117664,117665,117666,117667,117670,117672,121513);

-- 2. Equipages de vaisseaux volants. Sans marqueur de phase, et surtout sans
--    interet au sol : ces PNJ n'ont de sens qu'a bord, et notre Z vient du terrain.
--    Les reposer correctement demanderait les hauteurs de leur vaisseau, qu'aucune
--    de nos sources ne donne.
DELETE FROM `creature` WHERE `PhaseId` = 2407 AND `id` IN
 (133176,133177,133180,133188,133311,133313,133315);

-- Laisses en place, faute de preuve dans un sens ou dans l'autre : les champions de
-- classe de la scene de Magni (Halduron, Liadrin, Valeera, Rehgar, Ritssyn,
-- Eitrigg), et le decor de camp (guerisseur d'esprit, gardes, ouvriers Bilgewater).
--
-- Annulation : db-backups/silithus-plaie-tri-*.sql
