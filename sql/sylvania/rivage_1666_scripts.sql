-- =====================================================================
-- Assaut du Rivage brisé (carte 1666) — rattachement des scripts
--
-- Le C++ porté (scenario_assault_broken_shore.cpp) ne sert à rien tant
-- que ses scripts ne sont liés à aucune entrée : c'est la classe de bug
-- la plus fréquente de ce cœur, des IA complètes jamais appelées.
--
-- PORTÉE VÉRIFIÉE : les onze entrées ci-dessous n'existent QUE sur la
-- carte 1666 — contrôlé par un GROUP BY sur (id, map). Un ScriptName
-- s'appliquant à toutes les cartes, ce contrôle n'est pas facultatif.
--
-- NE SONT PAS RATTACHÉES, volontairement : Arganoth (118551),
-- Mephistroth (120746), Illidan (119130) et Lord Kalgorath (116291).
-- L'instance les pilote depuis OnCreatureCreate et OnCreatureKilled ;
-- leur donner un ScriptName ferait double emploi.
--
-- CONCORDANCE RELEVÉE, pas supposée :
--   120743 Arcane Bomb   → 7 exemplaires posés, critère 57574 × 7
--   118558 Legion Portal → 7 exemplaires, dont 3 à fermer (critère 56778)
-- =====================================================================

-- Les huit alliés qui accompagnent l'assaut : rotations de sorts et
-- recherche d'adversaire à portée.
UPDATE `creature_template` SET `ScriptName` = 'npc_assaut_allie'
 WHERE `entry` IN (119133, 118412, 121232, 118966, 121146, 118969, 118945, 118444);

-- Le corbeau arcanique : véhicule d'arrivée, sa fin de trajet vaut
-- l'étape 0 du scénario. Aucun spawn en base, il est invoqué par sort.
UPDATE `creature_template` SET `ScriptName` = 'npc_assaut_corbeau_arcanique'
 WHERE `entry` = 118517;

-- Portails de la Légion et bombes arcaniques : activés au clic de sort.
UPDATE `creature_template` SET `ScriptName` = 'npc_assaut_interactif'
 WHERE `entry` IN (118558, 120743);

-- La passerelle démoniaque, objet de type 10 (goober) : notre cœur ne
-- lui offre que le point d'entrée OnGossipHello.
UPDATE `gameobject_template` SET `ScriptName` = 'go_assaut_passerelle_demoniaque'
 WHERE `entry` = 267955;
