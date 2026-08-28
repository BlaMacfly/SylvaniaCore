-- =====================================================================
-- Rivage brisé (carte 1460) — alignement des phases
--
-- Signalé en jeu : « les ennemis sont bien affichés en rouge mais mon
-- curseur ne m'indique pas qu'ils sont attaquables ; en revanche eux
-- peuvent m'attaquer ».
--
-- LA CAUSE
-- `scenario_broken_shore_intro::OnPlayerEnter` place chaque joueur en
-- phase 169 :
--
--     PhasingHandler::AddPhase(player, PHASE_NORMAL, true);
--
-- Le script porte d'ailleurs son propre avertissement, écrit par qui l'a
-- rédigé : « Toute invocation doit partager la phase des joueurs
-- (OnPlayerEnter les met en 169), sinon elle est invisible/intangible :
-- cible de quête introuvable, vague intuable. » C'est pourquoi
-- `FinalizeSummon` ajoute la phase 169 à tout ce qu'il invoque.
--
-- Or les 757 placements importés sont en phase 0. Le script n'en
-- attendait aucun : il invoquait la totalité de ses acteurs. En
-- important le décor statique, on a introduit des créatures qui ne
-- partagent pas la phase du joueur.
--
-- Vérifié : la référence donne bien `PhaseId` vide pour les 757 lignes,
-- la conversion en 0 était donc fidèle. Le décalage vient de notre
-- script, pas de la transposition.
--
-- LE CHOIX
-- On aligne les placements sur la convention du script plutôt que de
-- retirer le phasage. Retirer la phase 169 du joueur obligerait aussi à
-- la retirer de toutes les invocations, soit bien plus de code touché
-- pour le même résultat.
--
-- Les objets sont inclus : les Flèches de la Détresse doivent être
-- actionnables, sans quoi le critère des 3 flèches reste bloqué.
--
-- ⚠️ Nécessite un redémarrage : les placements sont lus au démarrage.
-- =====================================================================

UPDATE `creature`
   SET `PhaseId` = 169
 WHERE `map` = 1460;

UPDATE `gameobject`
   SET `PhaseId` = 169
 WHERE `map` = 1460;
