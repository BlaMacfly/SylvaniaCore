-- =====================================================================
-- Transcription ArgusCore — lot Chasseur de démons (recheck 7.3.5)
-- Réf. commits ArgusCore : aa54261d, 82dbceb4, 4c770493.
--
-- 1) Barrage gangrené : nos deux scripts étaient bindés sur les sorts
--    INVERSÉS — le script d'aura (procs de charges) sur 211052 (le sort
--    de dégâts, sans aura) et le script de dégâts sur 222703 (le passif
--    à procs). Aucun des deux ne pouvait fonctionner. Échange.
-- 2) Aura d'immolation : le binding n'existait que pour la version Havoc
--    (178740) ; ajout de la version Vengeance (219830), structurellement
--    identique (même hook EFFECT_1/TRIGGER_SPELL).
-- =====================================================================

UPDATE `spell_script_names` SET `ScriptName`='spell_dh_fel_barrage_damage' WHERE `spell_id`=211052 AND `ScriptName`='spell_dh_fel_barrage_aura';
UPDATE `spell_script_names` SET `ScriptName`='spell_dh_fel_barrage_aura' WHERE `spell_id`=222703 AND `ScriptName`='spell_dh_fel_barrage_damage';

DELETE FROM `spell_script_names` WHERE `spell_id`=219830 AND `ScriptName`='spell_dh_immolation_aura';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(219830, 'spell_dh_immolation_aura');
