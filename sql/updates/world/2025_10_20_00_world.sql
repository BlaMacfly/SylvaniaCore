-- creature_template
UPDATE `creature_template` SET `ScriptName`='auchindoun_mob_tuulani' WHERE `entry`=79248;
UPDATE `creature_template` SET `ScriptName`='auchindoun_mob_sargerei_soulbinder' WHERE `entry`=77812;
UPDATE `creature_template` SET `ScriptName`='auchindoun_mob_sargerei_cleric' WHERE `entry`=77134;
UPDATE `creature_template` SET `ScriptName`='auchindoun_mob_sargerei_ritualist' WHERE `entry`=77130;
UPDATE `creature_template` SET `ScriptName`='auchindoun_mob_sargerei_zealot' WHERE `entry`=77132;
UPDATE `creature_template` SET `ScriptName`='auchindoun_mob_sargerei_spirit_tender' WHERE `entry`=77131;
UPDATE `creature_template` SET `ScriptName`='auchindoun_mob_sargerei_hopilite' WHERE `entry`=77133;
UPDATE `creature_template` SET `ScriptName`='auchindoun_mob_sargeri_warden' WHERE `entry`=77935;
UPDATE `creature_template` SET `ScriptName`='auchindoun_mob_sargerei_magus' WHERE `entry`=76263;
UPDATE `creature_template` SET `ScriptName`='auchindoun_mob_sargerei_defender' WHERE `entry`=77042;
UPDATE `creature_template` SET `ScriptName`='auchindoun_mob_felborne_abyssal' WHERE `entry`=77905;
UPDATE `creature_template` SET `ScriptName`='auchindoun_mob_soul_priest' WHERE `entry`=76595;
UPDATE `creature_template` SET `ScriptName`='auchindoun_mob_felguard' WHERE `entry`=76259;
UPDATE `creature_template` SET `ScriptName`='auchindoun_mob_cackling_pyromaniac' WHERE `entry`=76260;
UPDATE `creature_template` SET `ScriptName`='auchindoun_mob_blazing_trickster' WHERE `entry`=79511;
UPDATE `creature_template` SET `ScriptName`='auchindoun_mob_blazing_trickster' WHERE `entry`=79510;
UPDATE `creature_template` SET `ScriptName`='auchindoun_mob_warden_hammer' WHERE `entry`=76655;
UPDATE `creature_template` SET `ScriptName`='boss_azzakel' WHERE `entry`=75927;
UPDATE `creature_template` SET `ScriptName`='auchindoun_azzakel_mob_controller' WHERE `entry`=76216;
UPDATE `creature_template` SET `ScriptName`='boss_kaathar' WHERE `entry`=75839;
UPDATE `creature_template` SET `ScriptName`='auchindoun_kaathar_mob_holy_shield' WHERE `entry`=76071;
UPDATE `creature_template` SET `ScriptName`='auchindoun_kaathar_mob_nyami' WHERE `entry`=77810;
UPDATE `creature_template` SET `ScriptName`='boss_nyami' WHERE `entry`=76177;
UPDATE `creature_template` SET `ScriptName`='auchindoun_nyami_mob_malefic_defender' WHERE `entry`=76283;
UPDATE `creature_template` SET `ScriptName`='auchindoun_nyami_mob_spiteful_arbitrer' WHERE `entry`=76284;
UPDATE `creature_template` SET `ScriptName`='auchindoun_nyami_mob_twisted_magus' WHERE `entry`=76296;
UPDATE `creature_template` SET `ScriptName`='boss_teronogor' WHERE `entry`=77734;
UPDATE `creature_template` SET `ScriptName`='auchindoun_teronogor_mob_gromkash' WHERE `entry`=77889;
UPDATE `creature_template` SET `ScriptName`='auchindoun_teronogor_mob_abyssal' WHERE `entry`=77905;
UPDATE `creature_template` SET `ScriptName`='auchindoun_teronogor_mob_durag' WHERE `entry`=77890;
UPDATE `creature_template` SET `ScriptName`='auchindoun_teronogor_mob_gulkosh' WHERE `entry`=78437;
UPDATE `creature_template` SET `ScriptName`='auchindoun_teronogor_mob_shaadum' WHERE `entry`=78728;
UPDATE `creature_template` SET `ScriptName`='auchindoun_teronogor_mob_spirit' WHERE `entry`=77762;
UPDATE `creature_template` SET `ScriptName`='auchindoun_nyami_mob_warden_cosmetic' WHERE `entry`=76572;

DELETE FROM `creature_template` WHERE `entry` IN (543536,537324,3242352,342652,326527,326526);
INSERT INTO `creature_template` (  `entry`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`,  `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`,  `gossip_menu_id`, `minlevel`, `maxlevel`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`,  `speed_walk`, `speed_run`, `scale`, `dmgschool`,  `BaseAttackTime`, `RangeAttackTime`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`,  `dynamicflags`, `family`, `trainer_type`, `trainer_class`, `trainer_race`,  `type`, `type_flags`, `type_flags2`, `lootid`, `pickpocketloot`, `skinloot`,  `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`,  `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`,  `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`,  `RacialLeader`, `movementId`, `mechanic_immune_mask`, `RegenHealth`,  `flags_extra`, `ScriptName`, `VerifiedBuild`) VALUES
(543536, 0, 0, 0, 11686, 0, 0, 'Kaathar Spawn Fissures', '', '', '', '', 0, 60, 85, 6, 0, 114, 0, 1, 1.14286, 1, 0, 2000, 2000, 1, 33587968, 2048, 0, 8, 0, 0, 0, 0, 10, 0, 0, 72, 106, 26, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1.35, 1, 1, 1, 0, 0, 0, 1, 128, 'auchindoun_kaathar_mob_spawn_fissures', 26972),
(537324, 0, 0, 0, 11686, 0, 0, 'Kaathar Hallowed Ground', '', '', '', '', 0, 60, 85, 6, 0, 114, 0, 1, 1.14286, 1, 0, 2000, 2000, 1, 33587968, 2048, 0, 8, 0, 0, 0, 0, 10, 0, 0, 72, 106, 26, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1.35, 1, 1, 1, 0, 0, 0, 1, 128, 'auchindoun_kaathar_mob_hallowed_ground', 26972),
(3242352, 0, 0, 0, 11686, 0, 0, 'Kaathar Teleport Players', '', '', '', '', 0, 60, 85, 6, 0, 114, 0, 1, 1.14286, 1, 0, 2000, 2000, 1, 33587968, 2048, 0, 8, 0, 0, 0, 0, 10, 0, 0, 72, 106, 26, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1.35, 1, 1, 1, 0, 0, 0, 1, 128, 'auchindoun_kaathar_mob_teleport_players', 26972),
(342652, 0, 0, 0, 11686, 0, 0, 'Nyami Bubble', '', '', '', '', 0, 60, 85, 6, 0, 114, 0, 1, 1.14286, 1, 0, 2000, 2000, 1, 33587968, 2048, 0, 8, 0, 0, 0, 0, 10, 0, 0, 72, 106, 26, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1.35, 1, 1, 1, 0, 0, 0, 1, 128, 'auchindoun_nyami_mob_bubble', 26972),
(326527, 0, 0, 0, 11686, 0, 0, 'Azzakel Fel Spark Trigger', '', '', '', '', 0, 60, 85, 6, 0, 114, 0, 1, 1.14286, 1, 0, 2000, 2000, 1, 33587968, 2048, 0, 8, 0, 0, 0, 0, 10, 0, 0, 72, 106, 26, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1.35, 1, 1, 1, 0, 0, 0, 1, 128, 'auchindoun_azzakel_mob_fel_spark_trigger', 26972),
(326526, 0, 0, 0, 11686, 0, 0, 'Azzakel Fel Pool', '', '', '', '', 0, 60, 85, 6, 0, 114, 0, 1, 1.14286, 1, 0, 2000, 2000, 1, 33587968, 2048, 0, 8, 0, 0, 0, 0, 10, 0, 0, 72, 106, 26, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1.35, 1, 1, 1, 0, 0, 0, 1, 128, 'auchindoun_azzakel_mob_fel_pool', 26972);
		
-- spell_script_names
DELETE FROM `spell_script_names` WHERE `spell_id` IN (155524,154623,160312,154356,160415,157505,154831,156920,153392,153764,153006,157465,153430,156746,153994,154187,155327,157001,148969,156921,157039);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
('155524', 'auchindoun_spell_void_shift'),
('154623', 'auchindoun_spell_void_mending'),
('160312', 'auchindoun_spell_void_shell_filter'),
('154356', 'auchindoun_spell_psychic_terror'),
('160415', 'auchindoun_spell_tuulani_unlock'),
('157505', 'auchindoun_spell_arcane_bolt'),
('154831', 'auchindoun_warden_chain_aura'),
('156920', 'auchindoun_spell_void_beam'),
('153392', 'auchindoun_azzakel_spell_curtain_flames'),
('153764', 'auchindoun_azzakel_spell_claws_of_argus'),
('153006', 'auchindoun_kaathar_spell_consecrated_light'),
('157465', 'auchindoun_kaathar_spell_fate'),
('153430', 'auchindoun_kaathar_spell_sanctified_ground'),
('156746', 'auchindoun_kaathar_spell_conscreated_damage'),
('153994', 'auchindoun_nyami_spell_torn_spirits'),
('154187', 'auchindoun_nyami_spell_soul_vessel'),
('155327', 'auchindoun_nyami_spell_soul_vessel_dummy'),
('157001', 'auchindoun_teronogor_spell_chaos_wave'),
('148969', 'auchindoun_teronogor_spell_demonic_leap'),
('156921', 'auchindoun_teronogor_spell_seed_of_malevolence'),
('157039', 'auchindoun_teronogor_spell_demonic_leap_jump');

-- areatrigger_scripts
DELETE FROM `areatrigger_scripts` WHERE `entry` IN (157793,153725,165065,157787,157001);
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES
(157793, 'auchindoun_at_arcane_bomb'),
(153725, 'auchindoun_azzakel_at_fel_spark'),
(165065, 'auchindoun_kaathar_at_fissure'),
(157787, 'auchindoun_nyami_at_radiant_star'),
(157001, 'auchindoun_teronogor_areatrigger_chaos_wave');

-- gameobject_template
UPDATE `gameobject_template` SET `ScriptName`='auchindoun_gob_talador_portal' WHERE `entry`=236689;
UPDATE `gameobject_template` SET `ScriptName`='auchindoun_teronogor_gameobject_soul_transporter_01' WHERE `entry`=231736;
UPDATE `gameobject_template` SET `ScriptName`='auchindoun_teronogor_gameobject_soul_transporter_02' WHERE `entry`=231739;
UPDATE `gameobject_template` SET `ScriptName`='auchindoun_teronogor_gameobject_soul_transporter_03' WHERE `entry`=231740;
UPDATE `gameobject_template` SET `ScriptName`='auchindoun_teronogor_gameobject_soul_transporter_04' WHERE `entry`=231741;

-- instance_template
UPDATE `instance_template` SET `script`='instance_auchindoun' WHERE `map`=1182;