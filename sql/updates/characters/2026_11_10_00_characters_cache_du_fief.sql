-- Cache du fief (WoD) : date de derniere collecte (0 = jamais) et taille maximale apprise (0 = 500)
ALTER TABLE `character_garrison`
  ADD COLUMN `lastCacheCollect` INT UNSIGNED NOT NULL DEFAULT 0 AFTER `followerActivationsRemainingToday`,
  ADD COLUMN `cacheMaxSize` SMALLINT UNSIGNED NOT NULL DEFAULT 0 AFTER `lastCacheCollect`;
