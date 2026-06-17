DROP TABLE IF EXISTS `character_garrison_work_order`;
CREATE TABLE IF NOT EXISTS `character_garrison_work_order` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `garrison_id` bigint(20) unsigned NOT NULL,
  `plot_instance_id` int(10) unsigned NOT NULL,
  `shipment_id` int(10) unsigned NOT NULL,
  `creation_time` int(10) unsigned NOT NULL,
  `complete_time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `garrison_id` (`garrison_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
