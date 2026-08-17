-- =====================================================================
-- Asaad, 3e boss de la Cime du Vortex — triangle de runes inopérant
--
-- Repéré en auditant le crash d'Altairus (voir vortex_altairus_crash.sql).
-- Contrairement à lui, ceci ne fait PAS tomber le serveur : tous les appels
-- concernés sont correctement protégés. C'est un défaut de gameplay.
--
-- La mécanique (boss_asaad.cpp) : le PNJ « Unstable Grounding Field »
-- (46492, script npc_asaad_grounding_field_trigger) parcourt un triangle et,
-- à chaque sommet, invoque une ancre « Storm Target » (46387) plus un
-- émetteur qui se déplace vers le sommet suivant en canalisant un faisceau
-- sur l'ancre — c'est ce qui dessine la rune au sol, la zone où les joueurs
-- doivent se tenir pour survivre à la tempête.
--
-- Cinq entrées de balises invisibles étaient référencées par le script mais
-- ABSENTES de la base (elles n'existent ni chez nous, ni dans la base
-- officielle 7.3.5 : ce sont des entrées propres au core, formées sur
-- « 46387 » + un chiffre) :
--   463870 — émetteur mobile, canalise 86981 sur l'ancre en longeant l'arête
--   463871 / 463872 / 463873 — les trois marqueurs de sommet persistants
--   463874 — ancre des trois faisceaux finaux (86921 / 86923 / 86925)
-- Sans elles, `SummonCreature` renvoyait nullptr, les gardes `if` sautaient
-- silencieusement les faisceaux, et le triangle ne s'affichait jamais.
--
-- Vérifications préalables :
--   * 46492 (le traceur) et 46387 (l'ancre) existent bien : la mécanique
--     démarre, seul le tracé manquait.
--   * Les 4 sorts de faisceau sont présents dans Spell.db2 du client
--     (86981, 86921, 86923, 86925) — le visuel est donc disponible.
--
-- Correctif : création des 5 entrées par clonage exact de 46387 « Storm
-- Target » (modèle invisible 1126, faction 14, non sélectionnable, drapeau
-- déclencheur 128). Aucun ScriptName : ce sont de pures balises, le script
-- du boss pilote tout. Les noms sont descriptifs pour le débogage, ils ne
-- sont visibles par aucun joueur.
--
-- REDÉMARRAGE OBLIGATOIRE : vérifié en jeu, la commande console
-- « reload creature_template <entry> » refuse explicitement les entrées
-- nouvelles (« you can not add new creatures without restarting, only
-- modifying is allowed »). Le rechargement à chaud ne sert qu'à modifier
-- une entrée existante.
-- =====================================================================

DROP TEMPORARY TABLE IF EXISTS `tmp_rune`;
CREATE TEMPORARY TABLE `tmp_rune` AS SELECT * FROM `creature_template` WHERE `entry`=46387;

DELETE FROM `creature_template` WHERE `entry` IN (463870,463871,463872,463873,463874);

UPDATE `tmp_rune` SET `entry`=463870, `name`='Storm Rune Beam Emitter';
INSERT INTO `creature_template` SELECT * FROM `tmp_rune`;
UPDATE `tmp_rune` SET `entry`=463871, `name`='Storm Rune Marker 1';
INSERT INTO `creature_template` SELECT * FROM `tmp_rune`;
UPDATE `tmp_rune` SET `entry`=463872, `name`='Storm Rune Marker 2';
INSERT INTO `creature_template` SELECT * FROM `tmp_rune`;
UPDATE `tmp_rune` SET `entry`=463873, `name`='Storm Rune Marker 3';
INSERT INTO `creature_template` SELECT * FROM `tmp_rune`;
UPDATE `tmp_rune` SET `entry`=463874, `name`='Storm Rune Beam Anchor';
INSERT INTO `creature_template` SELECT * FROM `tmp_rune`;

DROP TEMPORARY TABLE `tmp_rune`;
