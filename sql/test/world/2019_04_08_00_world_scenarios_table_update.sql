ALTER TABLE `scenarios` ADD COLUMN `zoneid` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Zone Identifier' AFTER `scenario_H`;
