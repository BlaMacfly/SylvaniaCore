-- =====================================================================
-- « La liberté à portée d'ailes » — le donneur est le champion du joueur
--
-- Troisième et dernière correction de l'attribution (après 67ed679f puis
-- vault_bastillax_giver.sql). Indication de l'utilisateur en jeu, qui
-- tranche : le donneur est le PNJ présent au point de ralliement, pas un
-- des figurants disséminés sur le parcours.
--
-- La carte 1468 compte ONZE Kayn, dont un seul portait un drapeau de
-- donneur. Mes deux tentatives précédentes visaient :
--   96666 (4161,-856,291) — la salle finale, AU-DELA de Bastillax : le
--          joueur devait dépasser sa cible pour prendre la quête ;
--   97273 (4186,-610,255) — collé à Bastillax, mais isolé.
--
-- Le bon endroit est le point de ralliement du sommet (~4280,-450,260), où
-- se tiennent ensemble Kayn 97265, Altruis 97267 et Kor'vas 97644 — cette
-- dernière étant justement celle qui vient de faire choisir son champion au
-- joueur. Le champion enchaîne donc naturellement sur la quête suivante.
--
-- On attribue le don aux DEUX champions possibles, 97265 et 97267, pour que
-- le joueur ayant choisi Altruis ne soit pas bloqué. Ni l'un ni l'autre ne
-- portait de drapeau de donneur.
--
-- 96666 reste donneur en plus : il est le récepteur déclaré des quatre
-- variantes, et cela garantit un recours si le raisonnement ci-dessus est
-- encore incomplet. 97273 est en revanche remis dans son état d'origine.
--
-- Rechargeable à chaud.
-- =====================================================================

-- annulation de la tentative precedente
UPDATE `creature_template` SET `npcflag`=0 WHERE `entry`=97273;
DELETE FROM `creature_queststarter` WHERE `id`=97273 AND `quest` IN (39688,39694,40255,40256);

-- les deux champions du point de ralliement
UPDATE `creature_template` SET `npcflag`=3 WHERE `entry` IN (97265,97267);

DELETE FROM `creature_queststarter` WHERE `id` IN (97265,97267) AND `quest` IN (39688,39694,40255,40256);
INSERT INTO `creature_queststarter` (`id`,`quest`) VALUES
(97265,39688),(97265,39694),(97265,40255),(97265,40256),
(97267,39688),(97267,39694),(97267,40255),(97267,40256);
