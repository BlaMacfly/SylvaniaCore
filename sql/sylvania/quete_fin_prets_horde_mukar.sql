-- =====================================================================
-- « Fin prêts » (44281) — Stone Guard Mukar redevient rendeur de quête
-- =====================================================================
--
-- En posant le script de duel `npc_q42782` sur les treize recrues du
-- Blocus de Dranosh'ar, je l'ai aussi posé sur Mukar. Or Mukar est le
-- rendeur de la quête (creature_questender), pas un partenaire de duel.
--
-- Son `OnGossipHello` renvoie toujours « traité », ce qui empêche le
-- core d'afficher le menu de quête par défaut. Et lorsque la quête est
-- terminée — donc plus INCOMPLETE — la condition du script tombe : il
-- n'ajoute aucune option et rend la main. Le clic ne produisait rien,
-- et la quête était impossible à rendre.
--
-- Son homologue Alliance, Knight Dameron (108916), ne porte ni script
-- ni menu : npcflag = 2, questgiver seul. La liste Alliance en tête du
-- script confirme la règle — les 21 duellistes y figurent, le rendeur
-- non. Mukar s'aligne sur lui.
--
-- Les douze autres recrues gardent le script : elles restent des
-- partenaires de duel, ce qui suffit largement à l'objectif.
-- =====================================================================

UPDATE `creature_template`
   SET `ScriptName` = '', `gossip_menu_id` = 0, `npcflag` = 2
 WHERE `entry` = 113547;
