-- =====================================================================
-- Rivage brisé — les alliés en position de combat
--
-- DEMANDÉ EN JEU : « tous les PNJ alliés doivent être en
-- .npc playemote 27 ».
--
-- L'emote 27 est EMOTE_STATE_READY_UNARMED, une posture d'état — donc
-- permanente, contrairement aux emotes ponctuelles. Des soldats plantés
-- au repos au milieu d'une bataille, c'était l'essentiel du « ça n'a
-- pas d'âme » signalé plus tôt.
--
-- Elle se pose dans `creature_addon`, table qui ne contenait AUCUNE
-- ligne pour cette carte — d'où l'absence totale de posture, d'aura et
-- d'emote sur les 748 créatures.
--
-- PORTÉE : les 263 créatures alliées de la carte 1460, reconnues à leur
-- faction — 2879 Alliance, 2876 Horde, 35 amical à tous, 1819. Les
-- démons en faction 16 sont écartés : ils ont leur propre animation de
-- combat, et une posture d'état la figerait.
-- =====================================================================

INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`,
                              `emote`, `aiAnimKit`, `movementAnimKit`,
                              `meleeAnimKit`, `visibilityDistanceType`, `auras`)
SELECT c.`guid`, 0, 0, 0, 1, 0, 0, 0, 0, 0, ''
  FROM `creature` c
  JOIN `creature_template` ct ON ct.`entry` = c.`id`
 WHERE c.`map` = 1460
   AND ct.`faction` IN (2879, 2876, 35, 1819)
ON DUPLICATE KEY UPDATE `emote` = 0;
