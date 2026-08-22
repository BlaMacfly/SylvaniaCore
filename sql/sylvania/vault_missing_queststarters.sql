-- =====================================================================
-- Caveau des Gardiennes — quêtes que PERSONNE ne proposait
--
-- Relevé par l'audit du 22/08/2026 : trois quêtes de la campagne Chasseur
-- de démons n'avaient AUCUNE ligne `creature_queststarter`. Elles étaient
-- donc rigoureusement impossibles à obtenir en jeu ; seule une commande
-- GM permettait de poursuivre la chaîne.
--
--   38668 « Notre dernier espoir » — parler à Maiev (aucun objectif :
--          la quête se valide à l'acceptation), récepteur Maiev 92718
--   38669 « Notre dernier espoir » — récupérer les glaives de guerre,
--          récepteur Maiev 92718
--   38689 « Infusion gangrenée »  — 100 points d'énergie gangrenée,
--          récepteur Altruis 92986
--
-- Attribution : au récepteur déjà en place dans chaque cas. Ce n'est pas
-- un choix arbitraire :
--   * Maiev 92718 porte déjà npcflag 3 (papotage + donneur de quête),
--     elle donne déjà « La gangr'évasion » (38672), et le texte officiel
--     de 38668 la place explicitement devant la porte ouverte de votre
--     cellule : « Your jailor, Maiev Shadowsong, stands outside the open
--     door to your cell. »
--   * Altruis 92986 porte npcflag 2 (donneur de quête). Il est le pendant
--     exact de Kayn 92980, qui donne déjà « Le soulèvement des Illidari »
--     (38690) : Altruis donne l'étape qui précède, Kayn celle qui suit.
--
-- Écart assumé : sur les serveurs officiels 38668 est acceptée
-- automatiquement à l'arrivée dans le caveau. Ce core n'a aucun mécanisme
-- rattaché pour cela (le drapeau QUEST_FLAGS_AUTO_ACCEPT 0x00080000 est
-- absent de la quête, et `On100DHArrival` ne fait qu'apprendre des sorts).
-- La faire proposer par Maiev produit exactement le même parcours pour le
-- joueur — il lui parle, c'est l'objectif même de la quête — avec une
-- fenêtre d'acceptation en plus.
--
-- ORDRE DE LA CHAÎNE (`PrevQuestID`)
-- Sans contrainte d'ordre, Maiev proposerait 38668, 38669 et 38672 en même
-- temps. Or accepter 38672 la fait disparaître : le joueur perdait alors
-- l'accès aux deux autres. C'est précisément le blocage signalé en jeu.
-- L'ordre officiel (source : chaîne « Vault of the Wardens » de Wowhead)
-- est rétabli :
--   38668 → 38669 → 38672 → 38689 → 38690 → 38723 / 40253
-- 38668 ne reçoit VOLONTAIREMENT aucun prérequis : la quête qui la précède
-- (38729 « Retourner au Temple noir ») n'a aucun récepteur sur ce serveur
-- et ne peut donc jamais passer à l'état « récompensée » — l'exiger
-- bloquerait la chaîne pour de bon.
--
-- LIGNE FANTÔME
-- Maiev 92718 était déclarée donneuse de la quête 41226, absente de
-- `quest_template`. Supprimée.
--
-- Rechargeable à chaud : reload quest_template ; reload creature_questender
-- (il n'existe pas de commande de rechargement pour creature_queststarter,
--  un redémarrage est nécessaire pour que les quêtes apparaissent).
-- =====================================================================

-- --- donneurs manquants ------------------------------------------------
DELETE FROM `creature_queststarter` WHERE `quest` IN (38668,38669,38689);
INSERT INTO `creature_queststarter` (`id`,`quest`) VALUES
(92718,38668),
(92718,38669),
(92986,38689);

-- --- ligne pointant vers une quête inexistante --------------------------
DELETE FROM `creature_queststarter` WHERE `id`=92718 AND `quest`=41226;
DELETE FROM `creature_questender`   WHERE `quest`=41226;

-- --- ordre de la chaîne -------------------------------------------------
UPDATE `quest_template_addon` SET `PrevQuestID`=38668 WHERE `ID`=38669;
UPDATE `quest_template_addon` SET `PrevQuestID`=38669 WHERE `ID`=38672;
UPDATE `quest_template_addon` SET `PrevQuestID`=38672 WHERE `ID`=38689;
UPDATE `quest_template_addon` SET `PrevQuestID`=38689 WHERE `ID`=38690;
UPDATE `quest_template_addon` SET `PrevQuestID`=38690 WHERE `ID` IN (38723,40253);
