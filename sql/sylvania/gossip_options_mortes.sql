-- =====================================================================
-- Options de dialogue mortes qui doublonnent une option fonctionnelle
--
-- Une ligne de type 1 (bavardage) est affichee sans aucune verification
-- par Player::PrepareGossipMenu (« no checks »), mais sa selection ne
-- declenche aucune action. Lorsqu'une telle ligne porte le MEME texte
-- qu'une option reellement fonctionnelle du meme menu -- aubergiste (8),
-- marchand (3), transmogrification (16) -- le joueur voit la ligne en
-- double et celle du haut ne fait rien.
--
-- PREMIERE VERSION ERRONEE, CORRIGEE ICI
-- La version precedente supprimait aussi huit options portant des
-- CONDITIONS : evenement 12 (Halloween) actif et absence de l'aura
-- 24755 « Tricked or Treated ». C'etait l'option « Des bonbons ou un
-- sort ! », que la base habille du meme texte que l'option d'auberge.
-- Hors periode d'Halloween elle n'est jamais affichee : la supprimer
-- ne corrigeait rien et retirait du contenu saisonnier.
--
-- D'ou la clause NOT EXISTS : toute option soumise a une condition est
-- desormais preservee, sans avoir a juger de la condition elle-meme.
--
-- CE CORRECTIF NE RESOUT PAS le probleme de liaison de pierre de foyer
-- signale en jeu : le menu 342 fait partie des huit cas conditionnes,
-- son option morte n'etait donc pas affichee. La cause reste a trouver.
-- Il est conserve parce qu'il corrige un vrai defaut d'affichage
-- ailleurs, pas parce qu'il repond au symptome signale.
--
-- Retour arriere : chantiers/gossip_menu_option_retour_20260831.sql
-- =====================================================================

DELETE g1
  FROM `gossip_menu_option` g1
  JOIN `gossip_menu_option` g2
    ON  g2.`MenuId`     = g1.`MenuId`
    AND g2.`OptionText` = g1.`OptionText`
    AND g2.`OptionType` IN (3, 8, 16)
 WHERE g1.`OptionType` = 1
   AND NOT EXISTS (SELECT 1
                     FROM `conditions` c
                    WHERE c.`SourceTypeOrReferenceId` = 15
                      AND c.`SourceGroup`             = g1.`MenuId`
                      AND c.`SourceEntry`             = g1.`OptionIndex`);
