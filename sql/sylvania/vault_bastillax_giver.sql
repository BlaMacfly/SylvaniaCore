-- =====================================================================
-- « La liberté à portée d'ailes » — donneur placé au mauvais endroit
--
-- Correction de vault_final_starters.sql (67ed679f). J'y avais attribué le
-- don des 4 variantes à Kayn 96666, faute de mieux : il en est le récepteur
-- déclaré et le seul Kayn porteur du drapeau de donneur.
--
-- Mauvais choix : 96666 se tient en (4161, -856, 291), c'est-à-dire dans la
-- salle FINALE aux côtés de Khadgar — donc AU-DELÀ de Bastillax (4184, -628),
-- alors que la quête consiste précisément à tuer Bastillax. Le joueur devait
-- dépasser la cible, prendre la quête, puis revenir sur ses pas.
--
-- Le bon donneur est Kayn 97273, planté en (4186, -610, 255), à quelques
-- mètres de Bastillax. L'enchaînement devient cohérent avec les objectifs
-- de la quête (« Bastillax tué et pouvoir obtenu », puis « arrivée de
-- Khadgar ») : le champion désigne la cible sur place, on la tue, Khadgar
-- arrive, on rend la quête au bout du couloir chez 96666.
--
-- Il lui manque le drapeau de donneur (npcflag = 0, comme les dix autres
-- Kayn décoratifs de la carte).
--
-- 96666 est CONSERVÉ comme donneur en plus de 97273 : les deux sont
-- atteignables, la quête n'apparaîtra qu'une fois dans le journal, et cela
-- évite de rebloquer la campagne si mon raisonnement sur 97273 est faux.
--
-- Rechargeable à chaud : reload creature_template 97273
--                        reload creature_queststarter
-- =====================================================================

UPDATE `creature_template` SET `npcflag`=3 WHERE `entry`=97273;

DELETE FROM `creature_queststarter` WHERE `id`=97273 AND `quest` IN (39688,39694,40255,40256);
INSERT INTO `creature_queststarter` (`id`,`quest`) VALUES
(97273,39688),(97273,39694),(97273,40255),(97273,40256);
