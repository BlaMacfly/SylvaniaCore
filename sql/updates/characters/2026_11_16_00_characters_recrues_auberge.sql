-- Recruteur de l'auberge du fief : recrues tirees de la semaine et date de la derniere embauche
CREATE TABLE IF NOT EXISTS `character_garrison_recruits` (
  `guid` bigint(20) unsigned NOT NULL,
  `generated` int(10) unsigned NOT NULL DEFAULT 0,
  `lastRecruit` int(10) unsigned NOT NULL DEFAULT 0,
  `recruits` varchar(255) NOT NULL DEFAULT '' COMMENT 'sujet capacite capacite ...;sujet ...',
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
