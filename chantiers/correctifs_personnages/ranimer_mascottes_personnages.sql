-- Revive Battle Pets for the characters who already have Battle Pet Training (server STOPPED)
INSERT IGNORE INTO `character_spell` (`guid`, `spell`, `active`, `disabled`)
SELECT `guid`, 125439, 1, 0 FROM `character_spell` WHERE `spell`=119467;
