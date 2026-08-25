-- =====================================================================
-- Brasserie brune d'Orage — le script du tonneau d'Ook-Ook était
-- accroché au mauvais sort, ses deux accroches ne s'exécutaient jamais.
--
-- CONSTAT
-- Le cœur le signale à chaque démarrage :
--   Spell `122169` Effect `Index: EFFECT_0 AuraName: 236` of script
--   `spell_ook_ook_barrel_ride` did not match dbc effect data —
--   handler bound to hook `OnEffectApply` won't be executed
-- (idem pour `OnEffectRemove`).
--
-- POURQUOI
-- `spell_ook_ook_barrel_ride` est un AuraScript qui attend un effet
-- SPELL_AURA_CONTROL_VEHICLE (236) à l'index 0. Or, d'après les DB2 du
-- build 7.3.5.26972, le sort 122169 n'a qu'un seul effet et ce n'est pas
-- une aura du tout :
--
--   122169 : Effect = 140 (SPELL_EFFECT_FORCE_CAST)
--            EffectTriggerSpell = 122163
--
-- Autrement dit, 122169 ne fait que FORCER la cible à lancer 122163.
-- C'est 122163 qui porte l'aura de véhicule :
--
--   122163 : index 0, Effect = 6 (APPLY_AURA), EffectAura = 236
--
-- Le script était donc accroché au maillon déclencheur au lieu du sort
-- qui porte réellement l'aura. Structurellement, ses accroches ne
-- pouvaient jamais s'attacher.
--
-- La sémantique du script confirme la cible : dans `OnApply`, GetTarget()
-- est le tonneau et GetCaster() le joueur qui le chevauche — exactement
-- ce que donne une aura de contrôle de véhicule.
--
-- Rechargeable à chaud : reload spell_script_names
-- =====================================================================

DELETE FROM `spell_script_names`
 WHERE `ScriptName`='spell_ook_ook_barrel_ride';

INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(122163, 'spell_ook_ook_barrel_ride');
