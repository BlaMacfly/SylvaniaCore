-- =====================================================================
-- Cache du fief (WoD) : aucune ressource n'etait jamais donnee (signale par Wisstiti le 10/11/2026)
-- Les caches (237191, 236916, 237720, 237722-237724) lancent 178479, qui force 173847 (effet 77 sans script).
-- Script repris de LegionCore (spell_garrison_cache_loot) : 1 ressource toutes les 10 min, plafond 500,
-- 750 avec Logistique amelioree (189189), 1000 avec l'accord commercial des Parias arakkoa (189205).
-- Necessite la colonne lastCacheCollect (sql/updates/characters/2026_11_10_00_characters_cache_du_fief.sql).
-- =====================================================================
DELETE FROM `spell_script_names` WHERE `spell_id` IN (173847, 189189, 189205);
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(173847,'spell_garrison_cache_loot'),
(189189,'spell_garrison_cache_size'),
(189205,'spell_garrison_cache_size');

-- Modeles des caches pleines inverses (Wowhead + LegionCore) : 237722 Alliance, 237724 Horde
UPDATE `gameobject_template` SET `displayId` = 23776 WHERE `entry` = 237722;
UPDATE `gameobject_template` SET `displayId` = 23777 WHERE `entry` = 237724;
