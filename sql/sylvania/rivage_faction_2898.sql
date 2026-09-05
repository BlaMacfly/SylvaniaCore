-- =====================================================================
-- Rivage brisé — les démons passent en faction 2898
--
-- ÉTABLI PAR TEST EN JEU, et il résout le paradoxe d'août.
--
-- En août on avait basculé tous les démons de cette carte en faction 16
-- parce que la 2780 les rendait inattaquables — sans comprendre
-- pourquoi, la théorie disant l'inverse. La 16 fonctionnait, on l'a
-- prise.
--
-- Ce qu'on ignorait, c'est le prix : la faction 16 porte
-- `EnemyGroup = 1`, elle n'est hostile QU'AUX JOUEURS. Nos alliés, eux,
-- ont `EnemyGroup = 0` et une liste d'ennemis qui désigne la faction
-- 1786. Alliés et démons ne se reconnaissaient donc pas — d'où les
-- soldats qui entrent en combat puis n'ont personne à frapper, relevé
-- par la sonde : « liste de menace vide », onze fois pour la garde
-- royale gilnéenne, dix fois pour Jaina, dix fois pour Varian.
--
-- On avait réparé le joueur en supprimant la bataille.
--
-- La 2898 porte la faction 1786 comme la 2780, mais avec
-- `EnemyGroup = 15` — hostile à tous les groupes, joueurs compris.
-- Vérifié en jeu sur le Molosse de l'effroi gangrené : attaquable.
--
-- PORTÉE : uniquement les entrées exclusives à la carte 1460, comme en
-- août. Celles partagées avec d'autres cartes sont écartées.
--
-- Retour arrière : rebasculer les mêmes entrées en 16.
-- =====================================================================

UPDATE `creature_template` ct
   JOIN (SELECT DISTINCT c.`id`
           FROM `creature` c
           JOIN `creature_template` t ON t.`entry` = c.`id`
          WHERE c.`map` = 1460
            AND t.`faction` = 16
            AND c.`id` NOT IN (SELECT DISTINCT `id` FROM `creature` WHERE `map` <> 1460)) AS cible
     ON cible.`id` = ct.`entry`
    SET ct.`faction` = 2898;
