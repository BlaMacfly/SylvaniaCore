-- creature_template
UPDATE `creature_template` SET `ScriptName`='boss_hoptallus' WHERE `entry`=56717;
UPDATE `creature_template` SET `ScriptName`='npc_explosive_hopper' WHERE `entry`=56718;
UPDATE `creature_template` SET `ScriptName`='npc_hammer_bopper' WHERE `entry`=59426;
UPDATE `creature_template` SET `ScriptName`='npc_hammer' WHERE `entry`=59539;
UPDATE `creature_template` SET `ScriptName`='npc_carrot_breath_stalker' WHERE `entry`=59018;
UPDATE `creature_template` SET `ScriptName`='npc_nibbler' WHERE `entry`=65392;
UPDATE `creature_template` SET `ScriptName`='npc_sb_hopling' WHERE `entry`=56631;
UPDATE `creature_template` SET `ScriptName`='boss_ook_ook' WHERE `entry`=56637;
UPDATE `creature_template` SET `ScriptName`='npc_barrel' WHERE `entry`=56682;
UPDATE `creature_template` SET `ScriptName`='npc_hozen_hollerer' WHERE `entry`=56783;
UPDATE `creature_template` SET `ScriptName`='npc_uncle_gao' WHERE `entry`=59074;
UPDATE `creature_template` SET `ScriptName`='npc_chen_yanzhu' WHERE `entry`=64361;
UPDATE `creature_template` SET `ScriptName`='boss_yanzhu' WHERE `entry`=59479;
UPDATE `creature_template` SET `ScriptName`='npc_bubble_shield' WHERE `entry`=65522;
UPDATE `creature_template` SET `ScriptName`='npc_yeasty_alemental' WHERE `entry`=59494;
UPDATE `creature_template` SET `ScriptName`='npc_sudsy_alemental' WHERE `entry`=59522;
UPDATE `creature_template` SET `ScriptName`='npc_fizzy_alemental' WHERE `entry`=59520;
UPDATE `creature_template` SET `ScriptName`='npc_bloated_alemental' WHERE `entry`=59518;
UPDATE `creature_template` SET `ScriptName`='npc_stout_alemental' WHERE `entry`=59519;
UPDATE `creature_template` SET `ScriptName`='npc_bubbling_alemental' WHERE `entry`=59521;
UPDATE `creature_template` SET `ScriptName`='npc_carbonate_trigger' WHERE `entry`=56746;
UPDATE `creature_template` SET `ScriptName`='npc_suds_trigger' WHERE `entry`=56748;
UPDATE `creature_template` SET `ScriptName`='npc_fizzy_bubble' WHERE `entry`=59799;
UPDATE `creature_template` SET `ScriptName`='npc_wall_of_suds' WHERE `entry`=59512;
UPDATE `creature_template` SET `ScriptName`='npc_chen_stormstout' WHERE `entry`=59704;
UPDATE `creature_template` SET `ScriptName`='npc_auntie_stormstout' WHERE `entry`=59822;
UPDATE `creature_template` SET `ScriptName`='npc_aqua_dancer' WHERE `entry`=56865;
UPDATE `creature_template` SET `ScriptName`='sb_npc_fiery_trickster' WHERE `entry`=56867;
UPDATE `creature_template` SET `ScriptName`='npc_hozen_party_animal' WHERE `entry`=56927;
UPDATE `creature_template` SET `ScriptName`='npc_hozen_party_animal' WHERE `entry`=57097;
UPDATE `creature_template` SET `ScriptName`='npc_hozen_party_animal' WHERE `entry`=59684;
UPDATE `creature_template` SET `ScriptName`='npc_hozen_bouncer' WHERE `entry`=56849;
UPDATE `creature_template` SET `ScriptName`='npc_controlled_hozen' WHERE `entry`=56924;
UPDATE `creature_template` SET `ScriptName`='npc_controlled_hozen' WHERE `entry`=59605;
UPDATE `creature_template` SET `ScriptName`='npc_habanero_brew' WHERE `entry`=56731;

-- spell_script_names
DELETE FROM `spell_script_names` WHERE `spell_id` IN (111666,112944,112992,114291,122169,107351,106807,106614,106851,106546,114386,128254,128256,128258,114459,107205);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(111666,'spell_hammer_smash'),
(112944,'spell_carrot_breath'),
(112992,'spell_furlwind'),
(114291,'spell_sb_explosive_brew'),
(122169,'spell_ook_ook_barrel_ride'),
(107351,'spell_barrel_hostile'),
(106807,'spell_ground_pound'),
(106614,'spell_brew_barrel_ride'),
(106851,'spell_blackout_brew'),
(106546,'spell_bloat_aura'),
(114386,'spell_carbonation'),
(128254,'spell_brew_finale_wheat_effect'),
(128256,'spell_brew_finale_wheat_effect'),
(128258,'spell_brew_finale_wheat_effect'),
(114459,'spell_fizzi_buble'),
(107205,'spell_spicy_explosion');

-- areatrigger_scripts
DELETE FROM `areatrigger_scripts` WHERE `entry`=7998;
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES
(7998,'at_stormstout_intro');
