-- =====================================================================
-- Quête 40373 « Une nouvelle direction » — aucun donneur déclaré
--
-- La quête existe, a un récepteur (Kor'vas Bloodthorn 97644) et deux
-- objectifs cohérents (crédit 99278 « choisir entre Kayn et Altruis »,
-- crédit 100166 « Bassin du Jugement consulté »), mais AUCUNE ligne
-- creature_queststarter : personne ne pouvait la donner.
--
-- On l'attribue à Kor'vas 97644, et ce n'est pas un choix arbitraire :
--   * elle en est déjà la RÉCEPTRICE (creature_questender) ;
--   * c'est son propre script, npc_korvas_bloodthorn, qui déclenche la
--     fenêtre de choix Kayn/Altruis via OnGossipSelect ;
--   * elle est aussi réceptrice de la quête précédente, 39686
--     « Jusqu'au sommet », donc le joueur se trouve devant elle au bon
--     moment de la chaîne ;
--   * elle porte npcflag=3 (dialogue + donneur), elle est donc déjà
--     techniquement prête à donner une quête.
--
-- Rechargeable à chaud : reload creature_queststarter
-- =====================================================================

DELETE FROM `creature_queststarter` WHERE `id`=97644 AND `quest`=40373;
INSERT INTO `creature_queststarter` (`id`,`quest`) VALUES (97644,40373);
