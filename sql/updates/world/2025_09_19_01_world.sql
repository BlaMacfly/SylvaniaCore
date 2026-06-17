-- Anthorus

-- instance_template
DELETE FROM `instance_template` WHERE `map`=1712;
DELETE FROM `instance_template` WHERE `script`='instance_antorus_the_burning_throne';
INSERT INTO `instance_template` VALUES (1712, 0, 'instance_antorus_the_burning_throne', 0, 0);

-- creature_template
UPDATE `creature_template` SET `ScriptName`='npc_image_of_prophet_velen_125513' WHERE `entry`=125513;
UPDATE `creature_template` SET `ScriptName`='npc_garothi_annihilator_123398' WHERE `entry`=123398;
UPDATE `creature_template` SET `ScriptName`='npc_lightforged_teleport_pod_130137' WHERE `entry`=130137;
UPDATE `creature_template` SET `ScriptName`='npc_clobex_127732' WHERE `entry`=127732;
UPDATE `creature_template` SET `ScriptName`='npc_jump_pad_124962' WHERE `entry`=124962;
UPDATE `creature_template` SET `ScriptName`='npc_lightforged_beacon_128303' WHERE `entry`=128303;
UPDATE `creature_template` SET `ScriptName`='npc_lightforged_beacon_128304' WHERE `entry`=128304;
UPDATE `creature_template` SET `ScriptName`='npc_lightforged_beacon_129449' WHERE `entry`=129449;
UPDATE `creature_template` SET `ScriptName`='npc_lightforged_beacon_125720' WHERE `entry`=125720;
UPDATE `creature_template` SET `ScriptName`='npc_lightforged_warframe_127963' WHERE `entry`=127963;
UPDATE `creature_template` SET `ScriptName`='npc_magni_bronzebeard_125584' WHERE `entry`=125584;
UPDATE `creature_template` SET `ScriptName`='boss_admiral_svirax' WHERE `entry`=122367;
UPDATE `creature_template` SET `ScriptName`='npc_chief_engineer_ishkar_122369' WHERE `entry`=122369;
UPDATE `creature_template` SET `ScriptName`='npc_general_erodus_122333' WHERE `entry`=122333;
UPDATE `creature_template` SET `ScriptName`='npc_entropic_mine_122992' WHERE `entry`=122992;
UPDATE `creature_template` SET `ScriptName`='boss_aggramar' WHERE `entry`=121975;
UPDATE `creature_template` SET `ScriptName`='npc_ember_of_taeshalach_122532' WHERE `entry`=122532;
UPDATE `creature_template` SET `ScriptName`='npc_magni_bronzebeard_128169' WHERE `entry`=128169;
UPDATE `creature_template` SET `ScriptName`='boss_argus_the_unmaker' WHERE `entry`=124828;
UPDATE `creature_template` SET `ScriptName`='npc_golganneth_126268' WHERE `entry`=126268;
UPDATE `creature_template` SET `ScriptName`='npc_constellar_designate_127192' WHERE `entry`=127192;
UPDATE `creature_template` SET `ScriptName`='npc_gift_of_the_lifebinder_129386' WHERE `entry`=129386;
UPDATE `creature_template` SET `ScriptName`='npc_reorigination_module_127809' WHERE `entry`=127809;
UPDATE `creature_template` SET `ScriptName`='boss_essence_of_eonar' WHERE `entry`=122500;
UPDATE `creature_template` SET `ScriptName`='boss_shatug' WHERE `entry`=122135;
UPDATE `creature_template` SET `ScriptName`='boss_fharg' WHERE `entry`=126916;
UPDATE `creature_template` SET `ScriptName`='npc_lightforged_teleport_pod_128289' WHERE `entry`=128289;
UPDATE `creature_template` SET `ScriptName`='boss_garothi_worldbreaker' WHERE `entry`=123371;
UPDATE `creature_template` SET `ScriptName`='boss_imonar_the_soulhunter' WHERE `entry`=125055;
UPDATE `creature_template` SET `ScriptName`='npc_bombing_run_124704' WHERE `entry`=124704;
UPDATE `creature_template` SET `ScriptName`='npc_pulse_grenade_124928' WHERE `entry`=124928;
UPDATE `creature_template` SET `ScriptName`='npc_shrapnel_blast_124776' WHERE `entry`=124776;
UPDATE `creature_template` SET `ScriptName`='boss_kingaroth' WHERE `entry`=125050;
UPDATE `creature_template` SET `ScriptName`='npc_garothi_kingaroth_mobs' WHERE `entry`=123906;
UPDATE `creature_template` SET `ScriptName`='npc_garothi_kingaroth_mobs' WHERE `entry`=123921;
UPDATE `creature_template` SET `ScriptName`='npc_garothi_kingaroth_mobs' WHERE `entry`=123929;
UPDATE `creature_template` SET `ScriptName`='boss_noura_mother_of_flames' WHERE `entry` = 122468;
UPDATE `creature_template` SET `ScriptName`='npc_asara_mother_of_night_122467' WHERE `entry` = 122467;
UPDATE `creature_template` SET `ScriptName`='npc_diima_mother_of_gloom_122469' WHERE `entry` = 122469;
UPDATE `creature_template` SET `ScriptName`='npc_torment_of_norgannon_123503' WHERE `entry` = 123503;
UPDATE `creature_template` SET `ScriptName`='npc_torment_of_amanthul_125837' WHERE `entry` = 125837;
UPDATE `creature_template` SET `ScriptName`='npc_torment_of_khazgoroth_124166' WHERE `entry` = 124166;
UPDATE `creature_template` SET `ScriptName`='npc_torment_of_golganneth_124164' WHERE `entry` = 124164;
UPDATE `creature_template` SET `ScriptName`='npc_whirling_saber_123348' WHERE `entry` = 123348;
UPDATE `creature_template` SET `ScriptName`='npc_shadow_blade_123086' WHERE `entry` = 123086;
UPDATE `creature_template` SET `ScriptName`='boss_portal_keeper_hasabel' WHERE `entry` = 124393;
UPDATE `creature_template` SET `ScriptName`='npc_felcrush_portal_122438' WHERE `entry` = 122438;
UPDATE `creature_template` SET `ScriptName`='npc_gateway_xoroth_entering_122494' WHERE `entry` = 122494;
UPDATE `creature_template` SET `ScriptName`='npc_gateway_xoroth_leaving_122533' WHERE `entry` = 122533;
UPDATE `creature_template` SET `ScriptName`='npc_gateway_rancora_entering_122543' WHERE `entry` = 122543;
UPDATE `creature_template` SET `ScriptName`='npc_gateway_rancora_leaving_122555' WHERE `entry` = 122555;
UPDATE `creature_template` SET `ScriptName`='npc_gateway_nathreza_entering_122558' WHERE `entry` = 122558;
UPDATE `creature_template` SET `ScriptName`='npc_gateway_nathreza_leaving_122559' WHERE `entry` = 122559;
UPDATE `creature_template` SET `ScriptName`='npc_collapsing_world_122425' WHERE `entry` = 122425;
UPDATE `creature_template` SET `ScriptName`='npc_lord_eilgar_122213' WHERE `entry` = 122213;
UPDATE `creature_template` SET `ScriptName`='npc_lady_dacidion_122212' WHERE `entry` = 122212;
UPDATE `creature_template` SET `ScriptName`='npc_vulcanar_122211' WHERE `entry` = 122211;
UPDATE `creature_template` SET `ScriptName`='npc_transport_portal_122761' WHERE `entry` = 122761;
UPDATE `creature_template` SET `ScriptName`='boss_varimathras' WHERE `entry` = 125075;

-- spell_script_names
DELETE FROM `spell_script_names` WHERE `scriptname` IN 
	('spell_garothi_apocalypse_drive','spell_garothi_fel_bombardment_selector',
	 'spell_garothi_fel_bombardment_warning','spell_garothi_fel_bombardment_periodic','spell_garothi_searing_barrage_dummy',
	 'spell_garothi_searing_barrage_selector', 'spell_garothi_decimation_selector','spell_garothi_decimation_warning',
	 'spell_garothi_carnage','spell_garothi_annihilation_selector','spell_garothi_annihilation_triggered',
	 'spell_garothi_eradication', 'spell_garothi_surging_fel');

INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(244152, 'spell_garothi_apocalypse_drive'),
(244150, 'spell_garothi_fel_bombardment_selector'),
(246220, 'spell_garothi_fel_bombardment_warning'),
(244536, 'spell_garothi_fel_bombardment_periodic'),
(244398, 'spell_garothi_searing_barrage_dummy'),
(246369, 'spell_garothi_searing_barrage_dummy'),
(246360, 'spell_garothi_searing_barrage_selector'),
(244399, 'spell_garothi_decimation_selector'),
(244410, 'spell_garothi_decimation_warning'),
(244106, 'spell_garothi_carnage'),
(247572, 'spell_garothi_annihilation_selector'),
(244761, 'spell_garothi_annihilation_triggered'),
(244969, 'spell_garothi_eradication'),
(246655, 'spell_garothi_surging_fel');

-- Areatriggers
DELETE FROM `areatrigger_template` WHERE `Id` IN (15496, 0);
INSERT INTO `areatrigger_template` (`Id`, `Type`, `Flags`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `ScriptName`, `VerifiedBuild`) VALUES
(15496, 0, 4, 4, 4, 0, 0, 0, 0, 'at_garothi_annihilation', 26365),
(0, 3, 4, 0, 0, 0, 0, 0, 0, '', 26365);
DELETE FROM `spell_areatrigger` WHERE `SpellMiscId` IN (10662, 10876);
INSERT INTO `spell_areatrigger` (`SpellMiscId`, `AreaTriggerId`) VALUES
(10662, 15496),
(10876, 0);
DELETE FROM `areatrigger_template_polygon_vertices` WHERE `AreaTriggerId`= 0;
INSERT INTO `areatrigger_template_polygon_vertices` (`AreaTriggerId`, `Idx`, `VerticeX`, `VerticeY`, `VerifiedBuild`) VALUES
(0, 0, 0, -15, 26365),
(0, 1, 0, 15, 26365),
(0, 2, 100, -15, 26365),
(0, 3, 100, -15, 26365);

-- Procs
DELETE FROM `spell_proc` WHERE `SpellId`= 244106;
INSERT INTO `spell_proc` (`SpellId`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `ProcFlags`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`) VALUES
(244106, 0, 0, 0, 0x00000008, 0, 0, 0, 0, 0);

-- Custom Attributes
DELETE FROM `spell_custom_attr` WHERE `entry` IN (244761, 244410);
INSERT INTO `spell_custom_attr` (`entry`, `attributes`) VALUES
(244761, 0x8),
(244410, 0x1000);

-- Vehicle Accessories
DELETE FROM `vehicle_template_accessory` WHERE `entry`= 122450;
INSERT INTO `vehicle_template_accessory` (`entry`, `accessory_entry`, `seat_id`, `minion`, `description`, `summontype`, `summontimer`) VALUES
(122450, 122773, 1, 1, 'Garothi Worldbreaker - Decimator', 6, 200), -- Garothi Worldbreaker - Decimator
(122450, 122778, 0, 1, 'Garothi Worldbreaker - Annihilator', 6, 200); -- Garothi Worldbreaker - Annihilator

-- Spellclicks
DELETE FROM `npc_spellclick_spells` WHERE `npc_entry`= 122450;
INSERT INTO `npc_spellclick_spells` (`npc_entry`, `spell_id`, `cast_flags`, `user_type`) VALUES
(122450, 237873, 1, 1);

-- Model Data
DELETE FROM `creature_model_info` WHERE `DisplayID` IN (76534, 77168, 77029);
INSERT INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `DisplayID_Other_Gender`) VALUES
(76534, 20.02365, 30, 0),
(77168, 3.944656, 75, 0),
(77029, 3.944656, 75, 0);