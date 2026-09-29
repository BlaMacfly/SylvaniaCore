-- =====================================================================
-- Trône des Quatre Vents — le « Courant d'air » ne se dissipait jamais
-- =====================================================================
--
-- SIGNALÉ EN JEU par un joueur, sur son chasseur : « un bug visuel, un
-- halo de lumière qui éblouit autour de lui, on ne voit plus rien ».
-- Puis, question posée : « non, il n'y a rien comme buff ou autre ; on
-- dirait l'aura des boss du Trône des Quatre Vents, un tourbillon de
-- lumière ».
--
-- MESURE. Le personnage portait trois auras enregistrées. Deux sont
-- normales — Trouver des minerais (2580) et Éclaireur (231390), talent
-- de chasseur. La troisième est le sort 87713, « Slipstream » : la
-- mécanique de vent qui transporte le joueur d'une plateforme à l'autre
-- du Trône des Quatre Vents, précisément le raid qu'il venait de faire.
--
-- Elle était posée en PERMANENCE : maxDuration et remainTime à −1. Le
-- sort n'a aucune durée propre, c'est le raid qui doit l'ôter à la
-- sortie -- et rien chez nous ne le faisait. Étant un effet « factice »,
-- elle n'apparaît dans aucune barre de buff : le joueur ne pouvait ni la
-- voir ni l'annuler, et elle survivait aux reconnexions puisqu'elle est
-- sauvegardée en base.
--
-- CORRECTION. Le core sait faire, à condition qu'on le lui dise. Le
-- commentaire de `SpellArea` est formel : une aura rattachée à une aire
-- « sera toujours retirée en quittant l'aire, même sans le drapeau ».
-- On déclare donc le sort dans l'unique aire de la carte 754, la 5638,
-- avec des drapeaux à zéro : pas d'application automatique à l'entrée --
-- le courant d'air se prend en l'empruntant, pas en entrant -- mais
-- retrait garanti à la sortie.
--
-- Et on décolle celle qui reste accrochée au personnage concerné.
-- =====================================================================

DELETE FROM `spell_area` WHERE `spell` = 87713 AND `area` = 5638;
INSERT INTO `spell_area`
  (`spell`,`area`,`quest_start`,`quest_end`,`aura_spell`,`teamId`,`racemask`,
   `gender`,`flags`,`quest_start_status`,`quest_end_status`)
VALUES
  (87713, 5638, 0, 0, 0, -1, 0, 2, 0, 64, 64);
