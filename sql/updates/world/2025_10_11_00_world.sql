-- creature_template
UPDATE `creature_template` SET `ScriptName`='npc_anima_golem' WHERE `entry`=69701;
UPDATE `creature_template` SET `ScriptName`='npc_massive_anima_golem' WHERE `entry`=69699;
UPDATE `creature_template` SET `ScriptName`='npc_large_anima_golem' WHERE `entry`=69700;
UPDATE `creature_template` SET `ScriptName`='npc_crimson_wake' WHERE `entry`=69951;
UPDATE `creature_template` SET `ScriptName`='boss_dark_animus' WHERE `entry`=69427;
UPDATE `creature_template` SET `ScriptName`='npc_anima_orb' WHERE `entry`=69756;
UPDATE `creature_template` SET `ScriptName`='boss_dark_animus' WHERE `entry`=69427;

-- spell_script_names
DELETE FROM `spell_script_names` WHERE `spell_id` IN (138400,138373,138609,138644,138729,138451);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(138400,'spell_critically_damaged'),
(138373,'spell_powered_down'),
(138609,'spell_matter_swap'),
(138644,'spell_siphon_anima'),
(138729,'spell_full_power'),
(138451,'spell_acceleration_link');
