-- gundrak fixes

-- dificulty to give reputation for npc 29768 Unyielding Constrictor, 29774 Spitting Cobra.
UPDATE `creature_template` SET `difficulty_entry_1`='30941' WHERE  `entry`=29774;
UPDATE `creature_template` SET `difficulty_entry_1`='30942' WHERE  `entry`=29768;
DELETE FROM `creature_onkill_reputation` WHERE `creature_id`=30942;
INSERT INTO `creature_onkill_reputation` 
(`creature_id`, `RewOnKillRepFaction1`, `RewOnKillRepFaction2`, `MaxStanding1`, `IsTeamAward1`, `RewOnKillRepValue1`, `MaxStanding2`, `IsTeamAward2`, `RewOnKillRepValue2`, `TeamDependent`) VALUES 
(30942, 1037, 1052, 7, 0, 15, 7, 0, 15, 1);
