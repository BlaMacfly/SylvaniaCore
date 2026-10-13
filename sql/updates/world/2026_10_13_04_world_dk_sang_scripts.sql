-- DB/Spells: trois passifs du chevalier de la mort Sang ne faisaient rien (aucun script rattache) et
-- spammaient "Could not trigger spell 0 from aura X proc" : leur effet 0 est un DUMMY que notre moteur
-- envoie au gestionnaire de declenchement generique.
-- 81136 Fleau cramoisi : le script existait deja, jamais rattache.
-- 206960 Trembler devant moi, 192548 Festin sanglant : scripts ajoutes.
DELETE FROM `spell_script_names` WHERE `spell_id` IN (81136, 206960, 192548);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(81136, 'spell_dk_crimson_scourge'),
(206960, 'spell_dk_tremble_before_me'),
(192548, 'spell_dk_blood_feast');
