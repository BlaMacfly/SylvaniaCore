-- =====================================================================
-- Fin du Caveau des Gardiennes — quêtes sans aucun donneur
--
-- Après « Une nouvelle direction » (40373), la campagne s'arrêtait net :
-- les deux dernières étapes existent, ont des récepteurs et des objectifs
-- cohérents, mais AUCUNE ligne creature_queststarter.
--
-- 1) « LA LIBERTÉ À PORTÉE D'AILES » — 4 variantes (Dévastation/Vengeance
--    x Alliance/Horde), objectifs : tuer Bastillax et s'emparer de son
--    pouvoir, puis assister à l'arrivée de Khadgar.
--    Récepteurs déclarés : Kayn 96666 ET Altruis 96669.
--    On attribue le don à KAYN 96666 pour les quatre :
--      * il en est déjà récepteur ;
--      * il est le seul des deux à être SPAWNÉ (96669 n'a aucun spawn,
--        ni sur cette carte ni ailleurs) ;
--      * il porte npcflag=3, il est donc déjà prêt à donner ;
--      * le champ AllowableRaces filtre déjà Alliance/Horde, on ne risque
--        donc pas de proposer la mauvaise variante de faction.
--    ⚠️ Limite connue : rien ne filtre la SPÉCIALISATION (ce core n'a
--    aucun type de condition pour cela), un joueur verra donc les deux
--    variantes de sa faction. Même limite que les deux « Arrêtez Gul'dan ! ».
--
-- 2) « LE DÉPART DES ILLIDARI » (39689 Alliance / 39690 Horde), récepteur
--    Archimage Khadgar 97978, dont le script gère justement le
--    OnQuestReward de ces deux quêtes (téléportation vers Hurlevent ou
--    Orgrimmar). On lui attribue aussi le don : il « arrive » à la fin de
--    la quête précédente, c'est donc lui qui enchaîne.
--
-- Rechargeable à chaud : reload creature_queststarter
-- =====================================================================

DELETE FROM `creature_queststarter` WHERE `id`=96666 AND `quest` IN (39688,39694,40255,40256);
INSERT INTO `creature_queststarter` (`id`,`quest`) VALUES
(96666,39688),(96666,39694),(96666,40255),(96666,40256);

DELETE FROM `creature_queststarter` WHERE `id`=97978 AND `quest` IN (39689,39690);
INSERT INTO `creature_queststarter` (`id`,`quest`) VALUES
(97978,39689),(97978,39690);
