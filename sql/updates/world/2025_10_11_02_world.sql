-- creature_template
UPDATE `creature_template` SET `ScriptName`='boss_agronox' WHERE `entry` = 117193;
UPDATE `creature_template` SET `ScriptName`='boss_domatrax' WHERE `entry` = 119542;
UPDATE `creature_template` SET `ScriptName`='npc_coen_egida' WHERE `entry`='118884';
UPDATE `creature_template` SET `ScriptName`='boss_mephistroth' WHERE `entry`='116944';
UPDATE `creature_template` SET `ScriptName`='npc_mephistroth_illidan' WHERE `entry`='117855';
UPDATE `creature_template` SET `ScriptName`='boss_thrashbite_the_scornful' WHERE `entry` = 117194;
UPDATE `creature_template` SET `ScriptName`='npc_gazerax_118723' WHERE `entry` = 118723;
UPDATE `creature_template` SET `ScriptName`='npc_mefistrot_intro' WHERE `entry`='120793';
UPDATE `creature_template` SET `ScriptName`='npc_dulzak' WHERE `entry`='118704';
UPDATE `creature_template` SET `ScriptName`='npc_coen_event_first' WHERE `entry`='119768';
UPDATE `creature_template` SET `ScriptName`='npc_coen_maiev_events' WHERE `entry`='120312';


-- spell_script_names
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_agronox_choking_vines';
DELETE FROM `spell_script_names` WHERE `spell_id`='238598';
INSERT INTO `spell_script_names` VALUES (238598, 'spell_agronox_choking_vines');
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_domatrax_portals';
DELETE FROM `spell_script_names` WHERE `spell_id`='235827';
INSERT INTO `spell_script_names` VALUES (235827, 'spell_domatrax_portals');
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_mephistroth_carrion_swarm';
DELETE FROM `spell_script_names` WHERE `spell_id`='233155';
INSERT INTO `spell_script_names` VALUES (233155, 'spell_mephistroth_carrion_swarm');
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_mephistroth_egida';
DELETE FROM `spell_script_names` WHERE `spell_id`='234114';
INSERT INTO `spell_script_names` VALUES (234114, 'spell_mephistroth_egida');
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_coen_scornful_gaze';
DELETE FROM `spell_script_names` WHERE `spell_id`='237726';
INSERT INTO `spell_script_names` VALUES (237726, 'spell_coen_scornful_gaze');
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_coen_beguiling_bio';
DELETE FROM `spell_script_names` WHERE `spell_id`='238484';
INSERT INTO `spell_script_names` VALUES (238484, 'spell_coen_beguiling_bio');
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_coen_fel_strike';
DELETE FROM `spell_script_names` WHERE `spell_id`='236737';
INSERT INTO `spell_script_names` VALUES (236737, 'spell_coen_fel_strike');
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_coen_shadow_wave';
DELETE FROM `spell_script_names` WHERE `spell_id`='238653';
INSERT INTO `spell_script_names` VALUES (238653, 'spell_coen_shadow_wave');
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_coen_blinding_glare';
DELETE FROM `spell_script_names` WHERE `spell_id`='239217';
INSERT INTO `spell_script_names` VALUES (239217, 'spell_coen_blinding_glare');
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_coen_summon_spider';
DELETE FROM `spell_script_names` WHERE `spell_id`='239052';
INSERT INTO `spell_script_names` VALUES (239052, 'spell_coen_summon_spider');
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_coen_fel_blaze';
DELETE FROM `spell_script_names` WHERE `spell_id`='239522';
INSERT INTO `spell_script_names` VALUES (239522, 'spell_coen_fel_blaze');

-- areatrigger_scripts
DELETE FROM `areatrigger_scripts` WHERE `entry`=15295;
INSERT INTO areatrigger_scripts VALUES 
(15295,'areatrigger_mephistroth_shadow_blast');