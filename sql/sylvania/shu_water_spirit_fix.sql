-- =====================================================================
-- Île Vagabonde — Quêtes « Shu, l'esprit de l'eau » (29678) et
-- « Un nouvel ami » (29679), à la Mare des Reflets (map 860).
--
-- Deux bugs empêchaient de finir « Un nouvel ami » (jouer 5x avec Shu) :
--
--  1) Shu jouable (creature 65493) portait l'aura 89304 (invisibilité,
--     normalement réservée au « Water Spout Bunny » 60488). Résultat :
--     Shu spawné mais INVISIBLE — impossible de jouer avec lui.
--
--  2) Le script C++ spell_water_spout_quest_credit (qui invoque l'Esprit
--     de l'eau, le « nouvel ami », une fois la quête complétée) existait
--     dans le core mais n'était lié à AUCUN sort en base. Le PNJ final
--     n'apparaissait donc jamais.
--
-- Diagnostic : joueur (Anouky) signale Shu absent de la Mare + capture
-- d'écran ; vérif spawn/aura/bindings côté DB.
-- =====================================================================

-- 1) Rendre Shu visible : retirer l'aura d'invisibilité (garde le reste vide)
UPDATE `creature_template_addon` SET `auras`='' WHERE `entry`=65493;

-- 2) Brancher le script du final (invocation de l'Esprit de l'eau)
DELETE FROM `spell_script_names` WHERE `spell_id`=117063 AND `ScriptName`='spell_water_spout_quest_credit';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(117063, 'spell_water_spout_quest_credit');
