-- =====================================================================
-- Rivage brisé (carte 1460) — retrait de l'immunité aux joueurs
--
-- Signalé en jeu : « les démons invoqués c'est ok mais pas les autres
-- au fond ». Les créatures invoquées par le script étaient frappables,
-- les placements statiques non.
--
-- LA CAUSE, et elle est de mon fait
-- La transposition des modèles de créatures depuis le dump de référence
-- a importé `unit_flags` sur 136 entrées. Parmi les valeurs reprises,
-- 33536 et 537166592 contiennent le bit 256 — UNIT_FLAG_IMMUNE_TO_PC,
-- qui empêche tout joueur d'attaquer la créature.
--
-- Dans le cœur de référence, un script retire vraisemblablement ce
-- drapeau à l'instant voulu. Le nôtre ne gère aucun drapeau : les
-- démons restaient donc immunisés en permanence.
--
-- Cela explique aussi pourquoi la sonde ATTDBG ne produisait plus rien :
-- le client refusait de lui-même, sans jamais interroger le serveur.
--
-- PORTÉE : uniquement les factions HOSTILES —
--   2780 (30 entrées), 1768 (20 : Anetheron, Balnazzar, Brutallus…),
--   2878 (Krosus), 14 (Gul'dan), 2877 (Lave gangrenée).
--
-- Volontairement ÉPARGNÉS, car l'immunité y est légitime :
--   35, 2876, 2879, 1819 — alliés, prêtres, montures, vaisseaux.
--
-- UNE SIMPLIFICATION ASSUMÉE
-- Krosus et Gul'dan perdent aussi leur immunité, alors qu'une
-- implémentation fidèle la retirerait au début de leur étape. Notre
-- script ne gère aucun drapeau : la conserver rendrait les étapes 7 et 8
-- infranchissables. La progression reste pilotée par la machine à états
-- du script.
--
-- Retour arrière : chantiers/rivage_brise/retour_immunite_1460.sql
-- =====================================================================

UPDATE `creature_template` ct
   JOIN (SELECT DISTINCT c.id
           FROM creature c
           JOIN creature_template t ON t.entry = c.id
          WHERE c.map = 1460
            AND (t.unit_flags & 256)
            AND t.faction IN (2780, 1768, 2877, 2878, 14)) AS cible
     ON cible.id = ct.entry
    SET ct.unit_flags = ct.unit_flags & ~256;
