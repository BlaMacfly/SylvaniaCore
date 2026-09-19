-- Silithus : reparer la chaine de dialogue des guides temporels.
--
-- Constat : les deux PNJ n'avaient aucun dialogue.
--   creature_template.gossip_menu_id = 0 pour Rhonormu comme pour Zidormi
--   gossip_menu 21720 -> npc_text 33093 : present, VerifiedBuild 26124, donc sniffe
--   npc_text 33093 : BroadcastTextID0 = 0  <-- la chaine se brisait ici
--
-- Le vrai texte a ete retrouve dans notre depot de reference Ashamane :
--   (33093, 1, 0,0,0,0,0,0,0, 138522, 0,0,0,0,0,0,0, 26124)
-- Nous n'avons pas de table broadcast_text : c'est le client qui resoudra 138522
-- depuis son propre BroadcastText.db2, donc dans sa langue.

UPDATE `npc_text` SET `Probability0` = 1, `BroadcastTextID0` = 138522 WHERE `ID` = 33093;

-- Le menu sniffe 21720 est celui de ce type de dialogue. On le pose sur les deux
-- gabarits : le script construit ses propres lignes cliquables, mais le menu donne
-- au client le corps de la fenetre.
UPDATE `creature_template` SET `gossip_menu_id` = 21720 WHERE `entry` IN (133263, 128607);

-- Annulation : db-backups/silithus-gossip-*.sql
