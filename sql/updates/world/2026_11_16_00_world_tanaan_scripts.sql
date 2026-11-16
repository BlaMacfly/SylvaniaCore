-- Tanaan Jungle intro: scripts registered but bound to no creature (entries from the registration comments).
-- The Blood Ritual Orbs of Altar Altercation (34423) only answered a default gossip.
UPDATE `creature_template` SET `ScriptName`='npc_blood_ritual_orb' WHERE `entry`=83670 AND `ScriptName`='' AND `AIName`='';
UPDATE `creature_template` SET `ScriptName`='npc_bleeding_hollow_sauvage' WHERE `entry`=78507 AND `ScriptName`='' AND `AIName`='';
UPDATE `creature_template` SET `ScriptName`='npc_ankova_the_fallen' WHERE `entry`=79593 AND `ScriptName`='' AND `AIName`='';
UPDATE `creature_template` SET `ScriptName`='npc_keli_dan_the_breaker' WHERE `entry`=79702 AND `ScriptName`='' AND `AIName`='';
UPDATE `creature_template` SET `ScriptName`='npc_tanaan_yrel_summon' WHERE `entry`=79794 AND `ScriptName`='' AND `AIName`='';
UPDATE `creature_template` SET `ScriptName`='npc_blackrock_follower' WHERE `entry`=78430 AND `ScriptName`='' AND `AIName`='';
UPDATE `creature_template` SET `ScriptName`='npc_blackrock_grunt' WHERE `entry`=80786 AND `ScriptName`='' AND `AIName`='';
UPDATE `creature_template` SET `ScriptName`='npc_ogron_warcrusher' WHERE `entry` IN (80775, 81294) AND `ScriptName`='' AND `AIName`='';
UPDATE `creature_template` SET `ScriptName`='npc_thrall_maladaar_blackrock' WHERE `entry` IN (78553, 78554) AND `ScriptName`='' AND `AIName`='';
UPDATE `creature_template` SET `ScriptName`='npc_iron_gronnling' WHERE `entry`=82484 AND `ScriptName`='' AND `AIName`='';
