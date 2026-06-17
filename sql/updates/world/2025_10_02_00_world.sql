-- creature_template
UPDATE `creature_template` SET `ScriptName`='boss_frost_king_malakk' WHERE `entry`=69131;
UPDATE `creature_template` SET `ScriptName`='boss_kazrajin'  WHERE entry = 69134;
UPDATE `creature_template` SET `ScriptName`='boss_sul_the_sandcrawler' WHERE `entry`=69078;
UPDATE `creature_template` SET `ScriptName`='boss_high_priestess_marli' WHERE entry = 69132;
UPDATE `creature_template` SET `ScriptName`='mob_garajal' WHERE entry = 69135;
UPDATE `creature_template` SET `ScriptName`='mob_garajals_soul' WHERE entry = 69182;
UPDATE `creature_template` SET `ScriptName`='mob_living_sand' WHERE entry = 69153;
UPDATE `creature_template` SET `ScriptName`='mob_blessed_loa_spirit' WHERE entry = 69480;
UPDATE `creature_template` SET `ScriptName`='mob_shadowed_loa_spirit' WHERE entry = 69548;
UPDATE `creature_template` SET `ScriptName`='npc_twisted_fate_second' WHERE entry = 69746;
UPDATE `creature_template` SET `ScriptName`='npc_twisted_fate_first' WHERE entry = 69740;

-- spell_script_names
DELETE FROM `spell_script_names` WHERE `spell_id` IN (136442,136903,136917,136990,136922,136937,137084,137107,137149,137166,136860,136857,136894,137203,137350,137893,137963,137986,136507,137645,137643,137359,137121,137579,137614,137629,137085,137641,137122,137133,137124,136922);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(136442, 'spell_garajal_possessed'),
(136903, 'spell_malakk_frigid_assault'),
(136917, 'spell_malakk_biting_cold'),
(136990, 'spell_malakk_frostbite'),
(136922, 'spell_malakk_frostbite_periodic'),
(136937, 'spell_malakk_frostbite_allies'),
(137084, 'spell_malakk_body_heat'),
(137107, 'spell_kazrajin_reckless_charge_targeting'),
(137149, 'spell_kazrajin_overload'),
(137166, 'spell_kazrajin_discharge'),
(136860, 'spell_quicksand_periodic'),
(136857, 'spell_quicksand_entrapped'),
(136894, 'spell_sul_sandstorm'),
(137203, 'spell_marli_summon_blessed_loa_spirit'),
(137350, 'spell_marli_summon_shadowed_loa_spirit'),
(137893, 'spell_marli_twisted_fate_first'),
(137963, 'spell_marli_twisted_fate_second'),
(137986, 'spell_marli_twisted_fate_damages'),
(136507, 'spell_dark_power'),
(137645, 'spell_soul_fragment_target_selector'),
(137643, 'spell_soul_fragment_switcher'),
(137359, 'spell_marked_soul'),
(137121, 'spell_reckless_charge_initialize'),
(137579, 'spell_biting_cold_immunities'),
(137614, 'spell_treacherous_ground'),
(137629, 'spell_treacherous_ground'),
(137085, 'spell_chilled_to_the_bone'),
(137641, 'spell_soul_fragment_shadowed_soul'),
(137122, 'spell_reckless_charge_spell_onhit_script'),
(137133, 'spell_reckless_charge_spell_onhit_script'),
(137124, 'spell_reckless_charge_failsafe'),
(136922, 'spell_malakk_frostbite_visual');
