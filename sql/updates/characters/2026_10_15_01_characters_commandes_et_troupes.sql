-- Commandes de travail : type de fief (un joueur peut avoir un fief WoD ET un domaine de classe ; la sauvegarde de
-- l un effacait les commandes de l autre). Troupes : vitalite (missions restantes) sauvegardee.
ALTER TABLE `character_garrison_work_order` ADD COLUMN `garrison_type` tinyint(3) unsigned NOT NULL DEFAULT 0 AFTER `garrison_id`;
ALTER TABLE `character_garrison_followers` ADD COLUMN `durability` int(10) unsigned NOT NULL DEFAULT 0 AFTER `status`;
