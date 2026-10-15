-- Bloodtalons (155672) : le script se declenche au lancer de Regrowth ou d Entangling Roots (description officielle),
-- il etait rattache au talent passif lui-meme et ne se declenchait donc jamais.
DELETE FROM `spell_script_names` WHERE `ScriptName` = "spell_dru_bloodtalons" AND `spell_id` IN (8936, 339);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (8936, "spell_dru_bloodtalons"), (339, "spell_dru_bloodtalons");
