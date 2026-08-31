-- =====================================================================
-- Rivage brisé (carte 1460) — factions démoniaques ramenées à 16
--
-- ÉTABLI PAR TEST A/B, pas par raisonnement.
-- Une seule entrée a été basculée en faction 16 — le Molosse de l'effroi
-- gangrené (90686) — toutes choses égales par ailleurs. Résultat en jeu :
-- « les molosses sont maintenant attaquables », les autres non.
--
-- La sonde SPAWNDBG confirme que seule la faction distingue les deux :
--   Felstalker Dreadhound  faction=16    drapeaux=32768 drapeaux2=0  → OK
--   Felguard Legionnaire   faction=2780  drapeaux=32768 drapeaux2=0  → bloqué
-- Mêmes drapeaux, même niveau, même vie, mêmes phases.
--
-- POURQUOI 2780 ÉCHOUE, ALORS QUE LA THÉORIE DIT L'INVERSE
-- `FactionTemplate.db2` donne pour 2780 : Faction=1786, EnemyGroup=15,
-- soit ennemi de tous les groupes, joueurs compris. Et 1786 (« Burning
-- Legion Invaders ») a ReputationIndex=-1, donc aucune réputation
-- n'intervient. Sur le papier, 2780 devrait être hostile.
--
-- Elle ne l'est pas dans les faits, et je n'ai pas élucidé pourquoi. Le
-- refus vient du client, qui n'interroge jamais le serveur — aucune sonde
-- côté serveur ne peut l'observer.
--
-- CHOIX ASSUMÉ : on retient la faction 16, qui fonctionne de façon
-- démontrée dans ce scénario même — c'est celle qu'emploient les démons
-- invoqués par le script. C'est un écart avec la donnée de référence,
-- consenti parce qu'il rend le contenu jouable.
--
-- Effet secondaire bienvenu : les démons cessent de s'entretuer. La
-- faction 16 les rend amis entre eux (Friend_0=14), ce qui met fin au
-- « démons inattaquables qui se battent avec les attaquables ».
--
-- PORTÉE : uniquement les entrées exclusives à la carte 1460, comme pour
-- les correctifs précédents. Les entrées partagées avec d'autres cartes
-- sont écartées.
--
-- Retour arrière : chantiers/rivage_brise/retour_faction16_1460.sql
-- =====================================================================

UPDATE `creature_template` ct
   JOIN (SELECT DISTINCT c.id
           FROM creature c
           JOIN creature_template t ON t.entry = c.id
          WHERE c.map = 1460
            AND t.faction IN (2780, 1768)
            AND c.id NOT IN (SELECT DISTINCT id FROM creature WHERE map <> 1460)) AS cible
     ON cible.id = ct.entry
    SET ct.faction = 16;
