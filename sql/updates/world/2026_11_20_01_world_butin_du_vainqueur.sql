-- Le butin du vainqueur (42987 / 42982) : la scene 1343 n a pas de paquet de script connu,
-- l aura Hero's Honor donne le credit directement (spell_heros_honor_play_scene).
DELETE FROM `spell_script_names` WHERE `spell_id`=218084 AND `ScriptName`='spell_heros_honor_play_scene';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES (218084,'spell_heros_honor_play_scene');
