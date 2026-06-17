-- spell_script_names
DELETE FROM `spell_script_names` WHERE `spell_id`=15407;
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_pri_mind_flay';
DELETE FROM `spell_script_names` WHERE `spell_id`=234702;
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_pri_mind_sear';
INSERT INTO `spell_script_names` VALUES
(15407, 'spell_pri_mind_flay'),
(234702, 'spell_pri_mind_sear');