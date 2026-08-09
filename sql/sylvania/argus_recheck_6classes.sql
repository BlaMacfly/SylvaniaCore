-- =====================================================================
-- Transcription ArgusCore — lots Prêtre/Chasseur/Guerrier/Druide (+Mage,
-- Voleur, Démoniste analysés). Recheck 7.3.5 sur nos hooks morts au boot.
--
-- Dernier recours guerrier (12975) et Dernier recours familier (53478) :
-- l'effet réel est un APPLY_AURA natif (MOD_INCREASE_HEALTH_PERCENT /
-- MOD_INCREASE_HEALTH_2) — le script qui castait manuellement le bonus
-- de vie était un hook mort ; l'effet natif fait déjà tout. Même
-- conclusion qu'ArgusCore (scripts supprimés chez eux).
-- =====================================================================

DELETE FROM `spell_script_names` WHERE `spell_id`=12975 AND `ScriptName`='spell_warr_last_stand';
DELETE FROM `spell_script_names` WHERE `spell_id`=53478 AND `ScriptName`='spell_hun_pet_last_stand';
