-- =====================================================================
-- Choix du compagnon (234) — les boutons ne confirmaient pas le choix
--
-- Signalé en jeu : la fenêtre s'affiche correctement (et en français depuis
-- e2300ba4), mais cliquer sur « Kayn Chassesoleil » ou « Altruis le
-- Souffrant » ne confirme rien et ne valide pas la quête.
--
-- Le handler serveur est pourtant sain : HandlePlayerChoiceResponse appelle
-- OnPlayerChoiceResponse puis n'exige aucune récompense (`if (Reward)`).
-- Le clic n'arrive donc pas jusqu'au serveur — c'est le client qui refuse.
--
-- Seule différence structurelle avec le choix 231 (choix de spécialisation,
-- qui fonctionne) : celui-ci possède une ligne playerchoice_response_reward
-- par réponse, entièrement à zéro, alors que 234 n'en a AUCUNE.
-- Conséquence côté paquet : dans Player::SendPlayerChoice, le bloc Reward
-- n'est émis que `if (playerChoiceResponseTemplate.Reward)`. Les réponses de
-- 234 partaient donc sans ce bloc, là où celles de 231 le portent (vide).
-- Les deux choix partagent par ailleurs le même jeton de confirmation
-- CONFIRM_ARTIFACT_CHOICE et le même style d'interface.
--
-- On aligne donc 234 sur 231 : deux lignes de récompense entièrement à
-- zéro, qui n'accordent rien mais rétablissent la structure du paquet.
--
-- ⚠️ HYPOTHÈSE EMPIRIQUE, pas une cause prouvée : je n'ai pas pu observer
-- ce que le client fait du bloc manquant. C'est la seule divergence entre
-- un choix qui marche et un qui ne marche pas, et le changement n'accorde
-- rien à personne — donc sans risque à tester.
--
-- Pas de rechargement à chaud : LoadPlayerChoices() n'est appelée qu'au
-- démarrage, il n'existe aucune commande reload pour cette table.
-- =====================================================================

DELETE FROM `playerchoice_response_reward` WHERE `ChoiceId`=234;
INSERT INTO `playerchoice_response_reward`
  (`ChoiceId`,`ResponseId`,`TitleId`,`PackageId`,`SkillLineId`,`SkillPointCount`,`ArenaPointCount`,`HonorPointCount`,`Money`,`Xp`,`SpellID`,`VerifiedBuild`) VALUES
(234,486,0,0,0,0,0,0,0,0,0,0),
(234,487,0,0,0,0,0,0,0,0,0,0);
