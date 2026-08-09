-- =====================================================================
-- Transcription ArgusCore — lot Moine (recheck 7.3.5)
-- Réf. commits ArgusCore : 8ffc9d55, 603df7a1, debce376 (méthodologie :
-- vérifier NOS scripts contre les données client réelles avant de copier).
-- Preuve locale : erreurs « did not match dbc effect data » au boot
-- (Server.log) pour chaque hook corrigé côté C++.
--
-- 1) Éclair de jade crépitant (117952) : script supprimé côté C++ —
--    le proc de chi 123333 à 25%/tick était un reliquat MoP ; en 7.3.5 le
--    canal ne génère aucune ressource (dégâts purs via spell data).
-- 2) Thé de mana (197908) : en Legion c'est un simple
--    SPELL_AURA_MOD_POWER_COST_SCHOOL_PCT natif (-50% mana, 10 s) —
--    aucun script nécessaire ; l'ancien script visait le design MoP.
-- =====================================================================

DELETE FROM `spell_script_names` WHERE `spell_id`=117952 AND `ScriptName`='spell_monk_crackling_jade_lightning';
DELETE FROM `spell_script_names` WHERE `spell_id`=197908 AND `ScriptName`='spell_monk_mana_tea';
