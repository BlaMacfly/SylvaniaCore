-- =====================================================================
-- Rivage brise : postures, mouvements, et la vie de Krosus.
--
-- 1. LES ALLIES NE POUVAIENT PAS SE DEPLACER.
--
-- SIGNALE EN JEU : « Jaina et Genn s'orientent toujours du meme sens,
-- ils pivotent en continu sur un cote -- sauf quand ils me suivent ».
--
-- Ils portaient EMOTE_STATE_READY1H (333), pose en aout pour qu'ils
-- tiennent leur arme. Cette posture INTERDIT le deplacement : le PNJ ne
-- peut jouer ni marche ni virage, et toute reorientation se fait par
-- a-coups. Le core offre la variante prevue pour ce cas :
--
--     EMOTE_STATE_READY1H                = 333
--     EMOTE_STATE_READY1H_ALLOW_MOVEMENT = 505
--
-- 131 allies de la carte etaient concernes. Le suivi masquait le defaut
-- en reprenant la main sur les animations, d'ou l'observation exacte de
-- l'utilisateur.
--
-- 2. QUATRE-VINGT-TROIS CREATURES SANS CHEMIN.
--
-- SIGNALE EN JEU : « le demon de la p2 fait ca aussi ».
--
-- 83 creatures etaient en MovementType 2 (points de passage) sans AUCUN
-- chemin defini -- verifie : pas une seule n'avait de path_id. Le
-- generateur echouait a chaque tick, laissant la creature dans un etat
-- de mouvement bancal. Le journal d'erreurs le criait depuis des jours :
--
--     WaypointMovementGenerator::LoadPath: creature ... doesn't have
--     waypoint path id: 0
--
-- Faute de trajets authentiques a leur donner, on les remet au repos.
-- Elles cessent de pivoter ; elles ne patrouillent pas pour autant.
--
-- 3. KROSUS.
--
-- Demande d'equilibrage : vie divisee par deux. HealthModifier 600 ->
-- 300. Le gabarit n'est apparu que sur cette carte, une seule fois.
-- =====================================================================

UPDATE `creature_addon` ca
  JOIN `creature` c ON c.`guid` = ca.`guid`
   SET ca.`emote` = 505
 WHERE c.`map` = 1460 AND ca.`emote` = 333;

UPDATE `creature`
   SET `MovementType` = 0
 WHERE `map` = 1460 AND `MovementType` = 2;

UPDATE `creature_template`
   SET `HealthModifier` = 300
 WHERE `entry` = 90544;

-- Le Tortionnaire mo'arg : classe « creature de compagnie » et fige en
-- simulacre de mort, il ne comptait pour aucun objectif et gisait intact.
UPDATE `creature_template`
   SET `type` = 3,
       `unit_flags2` = `unit_flags2` & ~1
 WHERE `entry` = 101632;

-- Le Command Ship tombait du ciel : InhabitType 3 (sol et eau) pour une
-- creature posee entre 150 et 201 metres d'altitude.
UPDATE `creature_template` SET `InhabitType` = 4 WHERE `entry` = 101103;

-- Un Porte-aube d'argent hostile : seul des cinq gabarits de ce nom a
-- porter la faction demoniaque, heritee de notre balayage d'aout.
UPDATE `creature_template` SET `faction` = 2879 WHERE `entry` = 110615;
