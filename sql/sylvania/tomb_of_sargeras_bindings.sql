-- =====================================================================
-- Tombe de Sargeras (map 1676) : bindings du module porté depuis
-- mudyx/DestinyCoreNew (même famille de core, scripts lignée uwow).
-- Avant ce patch, AUCUN boss de la Tombe n'était bindé (sauf Goroth).
-- =====================================================================

-- ---------- CRÉATURES : boss ----------
UPDATE creature_template SET ScriptName='boss_goroth'                    WHERE entry=115844;
UPDATE creature_template SET ScriptName='boss_demonic_inquisition'       WHERE entry IN (116689,116691);
UPDATE creature_template SET ScriptName='boss_harjatan'                  WHERE entry=116407;
UPDATE creature_template SET ScriptName='boss_mistress_sasszine'         WHERE entry=115767;
UPDATE creature_template SET ScriptName='boss_sisters_of_the_moon'       WHERE entry=118182;
UPDATE creature_template SET ScriptName='boss_the_desolate_host_generic' WHERE entry=120988;
UPDATE creature_template SET ScriptName='boss_maiden_of_vigilance'       WHERE entry=118289;
UPDATE creature_template SET ScriptName='boss_fallen_avatar'             WHERE entry=116939;
UPDATE creature_template SET ScriptName='boss_tos_kiljaeden'             WHERE entry=117269;

-- ---------- CRÉATURES : adds / triggers ----------
-- Goroth
UPDATE creature_template SET ScriptName='npc_goroth_ember_stalker'       WHERE entry=115892;
UPDATE creature_template SET ScriptName='npc_goroth_infernal_spike'      WHERE entry=116976;
UPDATE creature_template SET ScriptName='npc_goroth_lava_stalker'        WHERE entry=117931;
UPDATE creature_template SET ScriptName='npc_goroth_brimstone_infernal'  WHERE entry=119950;
-- Inquisition démoniaque
UPDATE creature_template SET ScriptName='npc_tos_tormented_soul'         WHERE entry=117957;
-- Harjatan (les 3 variantes de têtards partagent la même IA)
UPDATE creature_template SET ScriptName='npc_tos_tadpole'                WHERE entry IN (121155,121156,120574);
-- Sassz'ine
UPDATE creature_template SET ScriptName='npc_mistress_sasszine'          WHERE entry=121184;
UPDATE creature_template SET ScriptName='npc_elder_murk_eye'             WHERE entry=121071;
UPDATE creature_template SET ScriptName='npc_sasszine_abyss_stalker'     WHERE entry=115795;
UPDATE creature_template SET ScriptName='npc_sasszine_slicing_tornado'   WHERE entry=118286;
UPDATE creature_template SET ScriptName='npc_sasszine_electrifying_jellyfish' WHERE entry=115896;
UPDATE creature_template SET ScriptName='npc_sasszine_razorjaw_waverunner' WHERE entry=115902;
UPDATE creature_template SET ScriptName='npc_sasszine_sarukel'           WHERE entry=116843;
UPDATE creature_template SET ScriptName='npc_sasszine_ossunet'           WHERE entry=116881;
UPDATE creature_template SET ScriptName='npc_sasszine_piranhado'         WHERE entry=116841;
UPDATE creature_template SET ScriptName='npc_sasszine_delicious_bufferfish' WHERE entry=119791;
-- Sœurs de la Lune (118182 = contrôleur, les 3 sœurs = IA dédiées)
UPDATE creature_template SET ScriptName='npc_sister_kasparian'           WHERE entry=118523;
UPDATE creature_template SET ScriptName='npc_sister_lunaspyre'           WHERE entry=118518;
UPDATE creature_template SET ScriptName='npc_sister_yathae'              WHERE entry=118374;
UPDATE creature_template SET ScriptName='npc_sistersmoon_moontalon'      WHERE entry=119205;
UPDATE creature_template SET ScriptName='npc_sistersmoon_glaive_target'  WHERE entry=119054;
UPDATE creature_template SET ScriptName='npc_sistersmoon_twilight_soul'  WHERE entry=121498;
-- Hôte affligé (+ miroirs mythiques)
UPDATE creature_template SET ScriptName='npc_tos_engine_of_souls'        WHERE entry=118460;
UPDATE creature_template SET ScriptName='npc_tos_soul_queen_dejahna'     WHERE entry=118462;
UPDATE creature_template SET ScriptName='npc_tos_desolate_host'          WHERE entry=119072;
UPDATE creature_template SET ScriptName='npc_tos_spiritual_font'         WHERE entry=118701;
UPDATE creature_template SET ScriptName='npc_tos_reanimated_templar'     WHERE entry IN (118715,119938);
UPDATE creature_template SET ScriptName='npc_tos_ghastly_bonewarden'     WHERE entry IN (118728,119939);
UPDATE creature_template SET ScriptName='npc_tos_fallen_priestess'       WHERE entry IN (118729,119940);
UPDATE creature_template SET ScriptName='npc_tos_soul_residue'           WHERE entry IN (118730,119941);
UPDATE creature_template SET ScriptName='npc_tos_tormented_cries'        WHERE entry=118924;
-- Jeune fille de vigilance
UPDATE creature_template SET ScriptName='npc_tos_essences'               WHERE entry IN (118640,118643);
UPDATE creature_template SET ScriptName='npc_tos_essences_intro'         WHERE entry IN (120132,120131);
-- Avatar déchu
UPDATE creature_template SET ScriptName='npc_avatara_maiden'             WHERE entry=117264;
UPDATE creature_template SET ScriptName='npc_avatara_pilones'            WHERE entry=117279;
UPDATE creature_template SET ScriptName='npc_tos_touch_of_sargeras'      WHERE entry=120838;
UPDATE creature_template SET ScriptName='npc_tos_rain_of_destroyer'      WHERE entry=120961;
-- Kil'jaeden
UPDATE creature_template SET ScriptName='npc_tos_armageddon_stalker'     WHERE entry=120839;
UPDATE creature_template SET ScriptName='npc_tos_erupting_reflection'    WHERE entry=119206;
UPDATE creature_template SET ScriptName='npc_tos_wailing_reflection'     WHERE entry=119107;
UPDATE creature_template SET ScriptName='npc_tos_hopeless_reflection'    WHERE entry=119663;
UPDATE creature_template SET ScriptName='npc_tos_shadowsoul'             WHERE entry=121193;
UPDATE creature_template SET ScriptName='npc_tos_stage4_illidan_stormrage' WHERE entry=121227;
UPDATE creature_template SET ScriptName='npc_tos_demonic_obelisk'        WHERE entry=120270;
UPDATE creature_template SET ScriptName='npc_tos_nether_rift'            WHERE entry=120390;
UPDATE creature_template SET ScriptName='npc_tos_flaming_orb'            WHERE entry=120082;
-- Trash / événements d'instance
UPDATE creature_template SET ScriptName='npc_tos_breach'                 WHERE entry=121605;
UPDATE creature_template SET ScriptName='npc_tos_kadghar_1'              WHERE entry=119726;

-- ---------- GAMEOBJECT ----------
UPDATE gameobject_template SET ScriptName='go_tos_tele_to_kiljedan'      WHERE entry=269783;

-- ---------- SORTS ----------
DELETE FROM spell_script_names WHERE ScriptName LIKE 'spell_tos_%' OR ScriptName LIKE 'spell_sasszine_%' OR ScriptName LIKE 'spell_sistersmoon_%' OR ScriptName='spell_egvin_levitation';
INSERT INTO spell_script_names (spell_id, ScriptName) VALUES
-- Inquisition démoniaque
(233652,'spell_tos_confess'),(233104,'spell_tos_torment'),(235305,'spell_tos_prisoner'),
(233435,'spell_tos_calcified_quils'),(235295,'spell_tos_adherent_fragment'),
-- Goroth
(233024,'spell_tos_goroth_crashing_comet'),(234368,'spell_tos_goroth_fel_eruption_dummy'),
(238588,'spell_tos_goroth_rain_of_brimstone'),(237333,'spell_tos_goroth_energy_tracker'),
(234386,'spell_tos_goroth_fel_periodic_trigger'),
-- Harjatan
(231854,'spell_tos_unchecked_rage'),(234016,'spell_tos_fixate'),(232061,'spell_tos_draw_in'),
-- Sassz'ine
(230143,'spell_sasszine_hydra_shot_filter'),(230201,'spell_sasszine_burden_of_pain'),
(239369,'spell_sasszine_delicious_bufferfish'),(232913,'spell_sasszine_befouling_ink'),
-- Sœurs de la Lune
(236306,'spell_sistersmoon_incorporeal_shot_filter'),
(239378,'spell_sistersmoon_glaive_storm_filter'),(239382,'spell_sistersmoon_glaive_storm_filter'),(239385,'spell_sistersmoon_glaive_storm_filter'),
(234998,'spell_sistersmoon_astral_purge'),
(233263,'spell_sistersmoon_embrace_eclipse'),(233264,'spell_sistersmoon_embrace_eclipse'),
(234664,'spell_sistersmoon_side_moon'),(234668,'spell_sistersmoon_side_moon'),
(236717,'spell_sistersmoon_lunar_barrage'),
-- Hôte affligé
(236673,'spell_tos_quietus_filter'),(236465,'spell_tos_soulbind_finder'),
(245611,'spell_tos_soulbind_visual_finder'),(245612,'spell_tos_soulbind_visual_finder'),
(236563,'spell_tos_sundering_doom'),(236564,'spell_tos_sundering_doom'),(236567,'spell_tos_sundering_doom'),(236568,'spell_tos_sundering_doom'),
(239014,'spell_tos_dissonance'),(239015,'spell_tos_dissonance'),
(239006,'spell_tos_dissonance_filter'),(239007,'spell_tos_dissonance_filter'),
(235933,'spell_tos_spear_of_anguish'),(242796,'spell_tos_spear_of_anguish'),
(238585,'spell_tos_bound_essence'),(235923,'spell_tos_spear_of_anguish_filter'),
(235988,'spell_tos_tormented_cries_filter'),(236459,'spell_tos_soulbind'),
(236515,'spell_tos_shattering_scream'),
(235113,'spell_tos_spiritual_barrier_dissonance_visual_aura'),(235620,'spell_tos_spiritual_barrier_dissonance_visual_aura'),
(235732,'spell_tos_spiritual_barrier_dissonance_phase_aura'),(235734,'spell_tos_spiritual_barrier_dissonance_phase_aura'),
-- Jeune fille de vigilance
(235271,'spell_tos_infusion'),(248812,'spell_tos_blowback'),
(234896,'spell_tos_wrath_of_the_creators'),(236432,'spell_tos_wrath_of_the_creators'),
(235117,'spell_tos_unstable_soul'),
(235213,'spell_tos_infusions'),(235240,'spell_tos_infusions'),
(241593,'spell_egvin_levitation'),
-- Avatar déchu
(239132,'spell_tos_rupture_realistic'),(235572,'spell_tos_rupture_realistic'),
(239742,'spell_tos_dark_mark'),(234873,'spell_tos_avatara_energy'),
(238460,'spell_tos_shadow_blades'),(239417,'spell_tos_black_winds'),
(236682,'spell_tos_fel_infusion'),(239739,'spell_tos_black_mark_aura'),
-- Kil'jaeden
(238502,'spell_tos_focused_dreadflame'),(242074,'spell_tos_destabilized_shadowsoul'),
(238999,'spell_tos_darkness_thousand_souls'),(239280,'spell_tos_flaming_orb_fixate'),
(243625,'spell_tos_lingering_wail_jump'),(237728,'spell_tos_hopelessness'),
(239154,'spell_tos_gravity_squeeze'),(243536,'spell_tos_lingering_eruption'),
(243624,'spell_tos_lingering_wail');

-- ---------- AREATRIGGERS (template existants seulement ; les Id custom
-- uwow 9xxxxx/1xxxxxx n'existent pas dans notre DB : dégradation douce) ----------
UPDATE areatrigger_template SET ScriptName='at_goroth_shattering_star'   WHERE Id=13412;
UPDATE areatrigger_template SET ScriptName='at_sasszine_devouring_maw'   WHERE Id=13368;
UPDATE areatrigger_template SET ScriptName='at_sistersmoon_moon'         WHERE Id IN (13559,13568);
UPDATE areatrigger_template SET ScriptName='at_sistersmoon_glaive_storm' WHERE Id IN (14928,14929,14930);
UPDATE areatrigger_template SET ScriptName='at_tos_armageddon'           WHERE Id=15115;
