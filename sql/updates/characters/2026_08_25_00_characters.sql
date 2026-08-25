--
-- Siege des Capitales : les deux tables d etat vivent dans la base
-- characters, mais n existaient que dans sql/sylvania/capital_siege.sql,
-- hors du mecanisme de mise a jour automatique. Une installation neuve se
-- retrouvait donc avec un schema characters incomplet : le module ecrivait
-- dans des tables absentes.
--
-- Ce fichier reprend le patch a l identique. Il est idempotent
-- (CREATE TABLE IF NOT EXISTS + INSERT IGNORE) : sans effet sur une base ou
-- le patch a deja ete passe a la main.
--

--
-- SylvaniaCore - Module "Siege des Capitales"
-- Base : dc_characters (etat mutable ecrit par le worldserver, donc hors de la
--        base de contenu dc_world qui est reimportee a chaque mise a jour).
--
-- Deux tables :
--   capital_siege_state   : ligne unique, l ordonnancement du module. Elle porte
--                           le verrou anti-rejeu quotidien et l alternance de
--                           faction, qui doivent survivre a un redemarrage.
--   capital_siege_history : une ligne par evenement, ouverte au declenchement et
--                           refermee a la fin (ou au demarrage suivant du core
--                           si le serveur s est arrete en plein siege).
--
-- Toutes les ecritures passent par des requetes preparees declarees dans
-- src/server/database/Database/Implementation/CharacterDatabase.{h,cpp}.
--

-- ---------------------------------------------------------------------------
-- Etat de l ordonnanceur (une seule ligne, id = 1)
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `capital_siege_state` (
  `id`                 TINYINT(3) UNSIGNED NOT NULL DEFAULT 1
                       COMMENT 'Toujours 1 : la table ne contient qu une ligne',
  `last_event_day`     INT(10) UNSIGNED    NOT NULL DEFAULT 0
                       COMMENT 'Jour serveur (epoch local / 86400) du dernier evenement consomme. Verrou anti-rejeu quotidien',
  `last_attacker_team` TINYINT(4)          NOT NULL DEFAULT -1
                       COMMENT 'Derniere faction attaquante : 0 = Alliance, 1 = Horde, -1 = aucune. Sert a l alternance stricte',
  `scheduled_day`      INT(10) UNSIGNED    NOT NULL DEFAULT 0
                       COMMENT 'Jour serveur du tirage courant',
  `scheduled_time`     INT(10) UNSIGNED    NOT NULL DEFAULT 0
                       COMMENT 'Horodatage unix du declenchement tire pour scheduled_day',
  `scheduled_team`     TINYINT(4)          NOT NULL DEFAULT -1
                       COMMENT 'Faction attaquante tiree pour scheduled_day : 0 = Alliance, 1 = Horde, -1 = aucune',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci
  COMMENT='Siege des Capitales : ordonnancement persistant';

-- ---------------------------------------------------------------------------
-- Historique des evenements
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `capital_siege_history` (
  `id`            INT(10) UNSIGNED    NOT NULL AUTO_INCREMENT,
  `start_time`    INT(10) UNSIGNED    NOT NULL DEFAULT 0
                  COMMENT 'Horodatage unix du declenchement',
  `end_time`      INT(10) UNSIGNED    NOT NULL DEFAULT 0
                  COMMENT 'Horodatage unix de la fin, 0 tant que l evenement est en cours',
  `attacker_team` TINYINT(4)          NOT NULL DEFAULT -1
                  COMMENT '0 = Alliance, 1 = Horde',
  `target_map`    SMALLINT(5) UNSIGNED NOT NULL DEFAULT 0
                  COMMENT 'Carte de la capitale assaillie (0 = Hurlevent, 1 = Orgrimmar)',
  `boss_entry`    INT(10) UNSIGNED    NOT NULL DEFAULT 0
                  COMMENT 'creature_template du dirigeant vise',
  `outcome`       TINYINT(4)          NOT NULL DEFAULT 0
                  COMMENT '0 = en cours, 1 = victoire, 2 = temps ecoule, 3 = annule GM, 4 = arret d urgence (charge), 5 = interrompu (arret du serveur)',
  `duration`      INT(10) UNSIGNED    NOT NULL DEFAULT 0
                  COMMENT 'Duree effective en secondes',
  `bots_spawned`  SMALLINT(5) UNSIGNED NOT NULL DEFAULT 0
                  COMMENT 'Nombre de bots effectivement deployes',
  `bots_lost`     SMALLINT(5) UNSIGNED NOT NULL DEFAULT 0
                  COMMENT 'Nombre de bots tues pendant l assaut',
  `triggered_by`  VARCHAR(32)         NOT NULL DEFAULT 'auto'
                  COMMENT 'auto = ordonnanceur, sinon nom du GM declencheur',
  PRIMARY KEY (`id`),
  KEY `idx_outcome` (`outcome`),
  KEY `idx_start_time` (`start_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci
  COMMENT='Siege des Capitales : historique des evenements';

-- Ligne d etat initiale. Aucune faction n a encore attaque : le premier
-- evenement sera donc mene par l Alliance.
INSERT IGNORE INTO `capital_siege_state`
  (`id`, `last_event_day`, `last_attacker_team`, `scheduled_day`, `scheduled_time`, `scheduled_team`)
  VALUES (1, 0, -1, 0, 0, -1);
