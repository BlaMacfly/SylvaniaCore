-- =====================================================================
-- CRASH SERVEUR — Altairus, 2e boss de la Cime du Vortex (carte 657)
--
-- Signalé par un joueur : le boss « bugue à 1 % » et le serveur tombe.
-- Reproduit deux fois (dumps SIGSEGV du 17/08 à 22:09:26 et 22:15:39).
--
-- Pile d'appel du dump :
--   Object::SetUInt32Value  <- this = NULL (rdi=0, champ 125, valeur 1)
--   Unit::Kill
--   Unit::DealDamage / DealSpellDamage / Spell::cast
-- Le champ 125 est UNIT_NPC_FLAGS (OBJECT_END + 0x71) et la valeur 1 est
-- UNIT_NPC_FLAG_GOSSIP : cela désigne sans ambiguïté boss_altairus.cpp:168.
--
-- Cause : à la mort du boss, JustDied() invoque un « Slipstream » d'entrée
-- 45457 (NPC_SLIPSTREAM_TWO) pour ouvrir le passage vers la 2e plateforme,
-- puis lui pose son drapeau de dialogue :
--     Creature* Slipstream = me->SummonCreature(NPC_SLIPSTREAM_TWO, ...);
--     Slipstream->SetUInt32Value(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
-- Or l'entrée 45457 N'EXISTE PAS en base (trou entre 45456 et 45460), ni
-- chez nous ni dans les bases de référence 7.3.5 et TDB. SummonCreature
-- renvoie donc nullptr, que le script déréférence sans contrôle : segfault
-- systématique à chaque mort d'Altairus.
--
-- Le script npc_slipstream_two existe pourtant et est bien enregistré
-- (vortex_pinnacle.cpp:336) : il propose « Teleport me to the second
-- platform » vers (-1188.86, 475.83, 635.59), c'est-à-dire l'accès à Asaad,
-- le 3e boss. Sans lui, le donjon serait de toute façon infranchissable.
--
-- Correctif SQL : création de l'entrée 45457 par clonage exact de 45455
-- (« Slipstream », déjà spawné au même endroit, -1198.79/107.05/740.71),
-- avec le script npc_slipstream_two et le drapeau de dialogue.
--
-- Un garde-fou est ajouté en parallèle côté C++ (contrôle du nullptr) pour
-- qu'aucune donnée manquante ne puisse plus jamais faire tomber le serveur
-- à cet endroit.
--
-- NOTE : le drapeau de dialogue fonctionne dès le rechargement du template,
-- mais la LIAISON DU SCRIPT 'npc_slipstream_two' n'est établie qu'au
-- démarrage (la liste des noms de scripts est figée au boot). Un
-- redémarrage est donc nécessaire pour que la téléportation soit réellement
-- proposée.
-- =====================================================================

DROP TEMPORARY TABLE IF EXISTS `tmp_slipstream`;
CREATE TEMPORARY TABLE `tmp_slipstream` AS SELECT * FROM `creature_template` WHERE `entry`=45455;
UPDATE `tmp_slipstream` SET `entry`=45457, `ScriptName`='npc_slipstream_two', `npcflag`=1;

DELETE FROM `creature_template` WHERE `entry`=45457;
INSERT INTO `creature_template` SELECT * FROM `tmp_slipstream`;
DROP TEMPORARY TABLE `tmp_slipstream`;
