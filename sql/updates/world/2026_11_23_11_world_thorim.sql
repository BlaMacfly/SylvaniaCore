-- Ulduar : rencontre de Thorim, d'apres TrinityCore 3.3.5 (5e90c76fd4 + 4a69f5bda5, 2017_05_16_01_world.sql).
-- Notre boss_thorim.cpp etait une coquille de 101 lignes, jamais enregistree : Thorim ne passait jamais a DONE, donc
-- la Porte ancienne des Gardiens (Vezax, Yogg-Saron) restait fermee. Adaptations au schema 7.3.5 :
-- - spell_dbc / spelldifficulty_dbc / difficulty_entry_1 absents : non repris (sorts 10 joueurs partout) ;
-- - criteria_data type 12 (difficulte 3.3.5) non lu ici : seules les lignes de script sont reprises ;
-- - GUID TrinityCore remplaces par les notres : herse 8151, lapin du blizzard 131923 (le plus proche, 3,4 m) ;
-- - levier 194264 absent chez nous : pose d'apres LegionCore (103530).

-- Repliques (numerotation du nouveau script)
DELETE FROM `creature_text` WHERE `CreatureID` IN (32865,32872,32873,33196);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(32865, 0,0,'Interlopers! You mortals who dare to interfere with my sport will pay... Wait--you...',14,0,100,0,0,15733,33145,0,'Thorim SAY_AGGRO_1'),
(32865, 1,0,'I remember you... In the mountains... But you... what is this? Where am--',14,0,100,0,0,15734,33270,0,'Thorim SAY_AGGRO_2'),
(32865, 2,0,'Do not hold back! Destroy them!',14,0,100,0,0,15736,34241,0,'Thorim SAY_SPECIAL'),
(32865, 3,0,'Impertinent whelps, you dare challenge me atop my pedestal? I will crush you myself!',14,0,100,0,0,15738,33148,0,'Thorim SAY_JUMPDOWN'),
(32865, 4,0,'Can''t you at least put up a fight!?',14,0,100,0,0,15739,34239,0,'Thorim SAY_SLAY_1'),
(32865, 4,1,'Pathetic.',14,0,100,0,0,15740,35768,0,'Thorim SAY_SLAY_2'),
(32865, 5,0,'My patience has reached its limit!',14,0,100,0,0,15741,33365,0,'Thorim SAY_BERSERK'),
(32865, 6,0,'Failures! Weaklings!',14,0,100,0,0,15742,33274,0,'Thorim SAY_WIPE'),
(32865, 7,0,'Stay your arms! I yield!',14,0,100,0,0,15743,33948,0,'Thorim SAY_DEATH'),
(32865, 8,0,'I feel as though I am awakening from a nightmare, but the shadows in this place yet linger.',14,0,100,0,0,15744,33949,0,'Thorim SAY_END_NORMAL_1'),
(32865, 9,0,'Sif... was Sif here? Impossible--she died by my brother''s hand. A dark nightmare indeed....',14,0,100,0,0,15745,33950,0,'Thorim SAY_END_NORMAL_2'),
(32865,10,0,'I need time to reflect.... I will aid your cause if you should require it. I owe you at least that much. Farewell.',14,0,100,0,0,15746,33951,0,'Thorim SAY_END_NORMAL_3'),
(32865,11,0,'You! Fiend! You are not my beloved! Be gone!',14,0,100,0,0,15747,33952,0,'Thorim SAY_END_HARD_1'),
(32865,12,0,'Behold the hand behind all the evil that has befallen Ulduar, left my kingdom in ruins, corrupted my brother, and slain my wife.',14,0,100,0,0,15748,33953,0,'Thorim SAY_END_HARD_2'),
(32865,13,0,'And now it falls to you, champions, to avenge us all. The task before you is great, but I will lend you my aid as I am able. You must prevail.',14,0,100,0,0,15749,33954,0,'Thorim SAY_END_HARD_3'),
(32872, 0,0,'%s surrounds itself with a crackling Runic Barrier!',41,0,100,0,0,0,33267,0,'Runic Colossus'),
(32873, 0,0,'%s fortifies nearby allies with runic might!',41,0,100,0,0,0,33523,0,'Ancient Rune Giant'),
(33196, 0,0,'Thorim, my lord!  Why else would these invaders have come into your sanctum but to slay you?  They must be stopped!',14,0,100,0,0,15668,33325,0,'Sif - Start'),
(33196, 1,0,'These pathetic mortals are harmless, beneath my station.  Dispose of them!',14,0,100,0,0,15669,33368,0,'Sif - Despawn'),
(33196, 2,0,'Impossible!  Lord Thorim, I will bring your foes a frigid death!',14,0,100,0,0,15670,33369,0,'Sif - Event');

-- Levier : pose (absent chez nous), ouvre la herse sombrefer (notre GUID 8151)
SET @OGUID := (SELECT MAX(`guid`) + 1 FROM `gameobject`);
INSERT INTO `gameobject` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`,`isActive`,`ScriptName`,`VerifiedBuild`)
SELECT @OGUID,194264,603,`zoneId`,`areaId`,`spawnDifficulties`,0,0,0,-1,2173.27,-252.867,420.146,0.104719,0,0,0.0523356,0.9986295,7200,255,1,0,'',0 FROM `gameobject` WHERE `guid`=8151;
UPDATE `gameobject_template` SET `AIName`='SmartGameObjectAI' WHERE `entry`=194264;
INSERT INTO `gameobject_template_addon` (`entry`,`faction`,`flags`) VALUES (194264,0,32) ON DUPLICATE KEY UPDATE `flags`=32;
DELETE FROM `smart_scripts` WHERE `entryorguid`=194264 AND `source_type`=1;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(194264,1,0,0,70,0,100,0,2,0,0,0,9,0,0,0,0,0,0,14,8151,194560,0,0,0,0,0,'Lever - On Gameobject State Changed - Activate Gameobject (Dark Iron Portcullis)');

-- Lapins pieges (Champ paralysant)
UPDATE `creature_template` SET `AIName`='SmartAI', `flags_extra`=2 WHERE `entry` IN (33054,33725);
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (33054,33725) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(33054,0,0,0,10,0,100,0,0,12,17000,17000,11,62241,0,0,0,0,0,1,0,0,0,0,0,0,0,'Thorim Trap Bunny - Within 0-12 Range Out of Combat LoS - Cast Paralytic Field'),
(33725,0,0,0,10,0,100,0,0,12,17000,17000,11,63540,0,0,0,0,0,1,0,0,0,0,0,0,0,'Thorim Trap Bunny - Within 0-12 Range Out of Combat LoS - Cast Paralytic Field');

-- Scripts de sorts
DELETE FROM `spell_script_names` WHERE `ScriptName` IN ('spell_thorim_blizzard_effect','spell_thorim_frostbolt_volley','spell_thorim_charge_orb','spell_thorim_runic_smash','spell_thorim_stormhammer','spell_thorim_lightning_charge','spell_thorim_stormhammer_sif','spell_thorim_stormhammer_boomerang','spell_thorim_activate_lightning_orb_periodic','spell_iron_ring_guard_impale','spell_thorim_arena_leap');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(62576,'spell_thorim_blizzard_effect'),
(62602,'spell_thorim_blizzard_effect'),
(62580,'spell_thorim_frostbolt_volley'),
(62604,'spell_thorim_frostbolt_volley'),
(62016,'spell_thorim_charge_orb'),
(62057,'spell_thorim_runic_smash'),
(62058,'spell_thorim_runic_smash'),
(62042,'spell_thorim_stormhammer'),
(62466,'spell_thorim_lightning_charge'),
(64767,'spell_thorim_stormhammer_sif'),
(64909,'spell_thorim_stormhammer_boomerang'),
(62184,'spell_thorim_activate_lightning_orb_periodic'),
(62331,'spell_iron_ring_guard_impale'),
(62418,'spell_iron_ring_guard_impale'),
(61934,'spell_thorim_arena_leap');

DELETE FROM `spell_linked_spell` WHERE `spell_trigger` IN (62042,-62320);
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
(-62320, -62398, 0, 'Aura of Celerity - Remove Visual');

-- Modeles
UPDATE `creature_template` SET `ScriptName`='boss_thorim' WHERE `entry`=32865;
UPDATE `creature_template` SET `ScriptName`='npc_sif' WHERE `entry`=33196;
UPDATE `creature_template` SET `ScriptName`='npc_thorim_pre_phase', `AIName`='' WHERE `entry` IN (32885,32883,32908,32907,32882,32886);
UPDATE `creature_template` SET `ScriptName`='npc_thorim_arena_phase', `AIName`='' WHERE `entry` IN (32876,32904,32878,32877,32874,32875,33110);
UPDATE `creature_template` SET `ScriptName`='npc_runic_colossus', `AIName`='' WHERE `entry`=32872;
UPDATE `creature_template` SET `ScriptName`='npc_ancient_rune_giant', `AIName`='' WHERE `entry`=32873;
UPDATE `creature_template` SET `flags_extra`=`flags_extra`|0x40000000 WHERE `entry` IN (32872,32873,33148,33149);
UPDATE `creature_template` SET `InhabitType`=4, `flags_extra`=128, `ScriptName`='' WHERE `entry` IN (33140,33141);
UPDATE `creature_template` SET `InhabitType`=4, `flags_extra`=128 WHERE `entry` IN (33378,32879);
UPDATE `creature_template` SET `InhabitType`=4 WHERE `entry`=32892;
UPDATE `creature_template` SET `faction`=1692 WHERE `entry` IN (32885,32883,33152,33153,32908,33150,32907,33151);
UPDATE `creature_template` SET `faction`=1693 WHERE `entry` IN (32882,33154);
UPDATE `creature_template` SET `speed_walk`=1, `speed_run`=2, `BaseAttackTime`=1500, `RangeAttackTime`=1500, `flags_extra`=`flags_extra`|0x00000200 WHERE `entry` IN (32865,33147);

-- Conditions de cible (lapin du blizzard : notre 131923)
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry` IN (62577,62603,62016,62976,63238,64098,62466,62565,62942,64767,62560,61964,61934);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 62577, 0, 0, 31, 0, 3, 32892, 131923, 0, 0, 0, '', 'Blizzard (effect 0) : Thorim Event Bunny du blizzard'),
(13, 1, 62603, 0, 0, 31, 0, 3, 32892, 131923, 0, 0, 0, '', 'Blizzard (effect 0) : Thorim Event Bunny du blizzard'),
(13, 1, 62016, 0, 0, 31, 0, 3, 33378, 0, 0, 0, 0, '', 'Charge Orb (effect 0) : Thunder Orb'),
(13, 1, 62976, 0, 0, 31, 0, 3, 33378, 0, 0, 0, 0, '', 'Lightning Pillar (effect 0) : Thunder Orb'),
(13, 1, 62976, 0, 0, 33, 0, 1, 0, 0, 1, 0, 0, '', 'Lightning Pillar (effect 0) : pas la cible de la condition'),
(13, 1, 63238, 0, 0, 31, 0, 3, 33378, 0, 0, 0, 0, '', 'Lightning Pillar (effect 0) : Thunder Orb'),
(13, 1, 63238, 0, 0, 33, 0, 1, 0, 0, 1, 0, 0, '', 'Lightning Pillar (effect 0) : pas la cible de la condition'),
(13, 1, 64098, 0, 0, 31, 0, 3, 32865, 0, 0, 0, 0, '', 'Lightning Bolt (effect 0) : Thorim'),
(13, 4, 62466, 0, 0, 31, 0, 3, 32780, 0, 0, 0, 0, '', 'Lightning Charge (effect 2) : Invisible Stalker (All Phases)'),
(13, 3, 62565, 0, 0, 31, 0, 3, 32865, 0, 0, 0, 0, '', 'Touch of Dominion (effects 0 et 1) : Thorim'),
(13, 7, 62942, 0, 0, 31, 0, 3, 32874, 0, 0, 0, 0, '', 'Runic Fortification : Iron Ring Guard'),
(13, 7, 62942, 0, 1, 31, 0, 3, 32875, 0, 0, 0, 0, '', 'Runic Fortification : Iron Honor Guard'),
(13, 7, 62942, 0, 2, 31, 0, 3, 33110, 0, 0, 0, 0, '', 'Runic Fortification : Dark Rune Acolyte'),
(13, 1, 64767, 0, 0, 31, 0, 3, 33196, 0, 0, 0, 0, '', 'Stormhammer (effect 0) : Sif'),
(13, 7, 62560, 0, 0, 31, 0, 3, 32876, 0, 0, 0, 0, '', 'Berserk : Dark Rune Champion'),
(13, 7, 62560, 0, 1, 31, 0, 3, 32877, 0, 0, 0, 0, '', 'Berserk : Dark Rune Warbringer'),
(13, 7, 62560, 0, 2, 31, 0, 3, 32878, 0, 0, 0, 0, '', 'Berserk : Dark Rune Evoker'),
(13, 7, 62560, 0, 3, 31, 0, 3, 32904, 0, 0, 0, 0, '', 'Berserk : Dark Rune Commoner'),
(13, 1, 61964, 0, 0, 31, 0, 3, 32882, 0, 0, 0, 0, '', 'Circle of Healing : Jormungar Behemoth'),
(13, 1, 61964, 0, 1, 31, 0, 3, 32883, 0, 0, 0, 0, '', 'Circle of Healing : Captured Mercenary Soldier'),
(13, 1, 61964, 0, 2, 31, 0, 3, 32885, 0, 0, 0, 0, '', 'Circle of Healing : Captured Mercenary Soldier'),
(13, 1, 61964, 0, 3, 31, 0, 3, 32886, 0, 0, 0, 0, '', 'Circle of Healing : Dark Rune Acolyte'),
(13, 1, 61964, 0, 4, 31, 0, 3, 32907, 0, 0, 0, 0, '', 'Circle of Healing : Captured Mercenary Captain'),
(13, 1, 61964, 0, 5, 31, 0, 3, 32908, 0, 0, 0, 0, '', 'Circle of Healing : Captured Mercenary Captain'),
(13, 1, 61934, 0, 0, 31, 0, 3, 32892, 0, 0, 0, 0, 'condition_thorim_arena_leap', 'Leap (effect 0) : Thorim Event Bunny'),
(13, 1, 61934, 0, 0, 31, 0, 3, 32892, 131923, 1, 0, 0, '', 'Leap (effect 0) : pas le lapin du blizzard');

-- Marteau-tempete et rayon : ligne de vue ignoree
DELETE FROM `disables` WHERE `sourceType`=0 AND `entry` IN (62042,64767,45537);
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `params_0`, `params_1`, `comment`) VALUES
(0, 62042, 64, '', '', 'Stormhammer - Ignore LOS'),
(0, 64767, 64, '', '', 'Stormhammer - Ignore LOS'),
(0, 45537, 64, '', '', 'Lightning Beam Channel - Ignore LOS');

-- Hauts faits scriptes (la restriction de difficulte 3.3.5, type 12, n'est pas lue sur ce core)
DELETE FROM `criteria_data` WHERE `criteria_id` IN (10305,10309,10440,10457,10287,10288,10311,10312) AND `type`=11;
INSERT INTO `criteria_data` (`criteria_id`,`type`,`value1`,`value2`,`ScriptName`) VALUES
(10305,11,0,0,'achievement_dont_stand_in_the_lightning'),
(10309,11,0,0,'achievement_dont_stand_in_the_lightning'),
(10440,11,0,0,'achievement_lose_your_illusion'),
(10457,11,0,0,'achievement_lose_your_illusion'),
(10287,11,0,0,'achievement_i_ll_take_you_all_on'),
(10288,11,0,0,'achievement_i_ll_take_you_all_on'),
(10311,11,0,0,'achievement_i_ll_take_you_all_on'),
(10312,11,0,0,'achievement_i_ll_take_you_all_on');

-- Renforts : invoques par le script (aucune apparition fixe chez nous, rien a supprimer)
DELETE FROM `creature` WHERE `id` IN (32882,32908,32907,32885,32883,32886,32874,32875,33110);

-- Controleur de Thorim : position TrinityCore
UPDATE `creature` SET `position_x`=2134.774, `position_y`=-262.3073, `position_z`=428.6936, `orientation`=1.343904 WHERE `guid`=131860 AND `id`=32879;

-- Coffres de tempetes : au sol de l'arene (TrinityCore), verrouilles jusqu'a la fin
UPDATE `gameobject_template` SET `size`=3 WHERE `entry`=194315;
INSERT INTO `gameobject_template_addon` (`entry`,`faction`,`flags`) VALUES (194313,94,16),(194314,94,16),(194315,94,16)
ON DUPLICATE KEY UPDATE `faction`=94, `flags`=16;
UPDATE `gameobject` SET `position_x`=2134.948, `position_y`=-286.436, `position_z`=419.5051, `orientation`=1.588249, `rotation0`=0, `rotation1`=0, `rotation2`=0.7132502, `rotation3`=0.7009096
WHERE `guid` IN (40131,40132,7143,6710) AND `id` IN (194312,194313,194314,194315);

-- Lapin du blizzard (notre 131923) : trajet autour de l'arene
UPDATE `creature` SET `spawndist`=0, `MovementType`=2, `position_x`=2148.425, `position_y`=-276.7478, `position_z`=419.5923 WHERE `guid`=131923 AND `id`=32892;
DELETE FROM `creature_addon` WHERE `guid`=131923;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (131923,1319230,0,0,1,0,'');
DELETE FROM `waypoint_data` WHERE `id`=1319230;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(1319230,1,2148.425,-276.7478,419.5923,0,0,0,0,100,0),
(1319230,2,2145.229,-278.5732,419.6016,0,0,0,0,100,0),
(1319230,3,2142.105,-280.7194,419.5932,0,0,0,0,100,0),
(1319230,4,2138.419,-281.2838,419.5999,0,0,0,0,100,0),
(1319230,5,2134.843,-281.9885,419.5996,0,0,0,0,100,0),
(1319230,6,2131.128,-281.278,419.5985,0,0,0,0,100,0),
(1319230,7,2127.415,-280.8166,419.5875,0,0,0,0,100,0),
(1319230,8,2124.459,-278.4777,419.6088,0,0,0,0,100,0),
(1319230,9,2121.098,-276.7148,419.5924,0,0,0,0,100,0),
(1319230,10,2119.281,-273.4217,419.6069,0,0,0,0,100,0),
(1319230,11,2116.933,-270.4605,419.5851,0,0,0,0,100,0),
(1319230,12,2116.359,-266.7142,419.6042,0,0,0,0,100,0),
(1319230,13,2115.436,-263.0562,419.5847,0,0,0,0,100,0),
(1319230,14,2116.543,-259.411,419.6082,0,0,0,0,100,0),
(1319230,15,2116.943,-255.605,419.5851,0,0,0,0,100,0),
(1319230,16,2119.377,-252.7493,419.6096,0,0,0,0,100,0),
(1319230,17,2121.183,-249.3546,419.5858,0,0,0,0,100,0),
(1319230,18,2124.49,-247.5925,419.6089,0,0,0,0,100,0),
(1319230,19,2127.329,-245.1714,419.5925,0,0,0,0,100,0),
(1319230,20,2131.097,-244.8609,419.6089,0,0,0,0,100,0),
(1319230,21,2134.792,-243.7036,419.585,0,0,0,0,100,0),
(1319230,22,2138.466,-244.3162,419.5979,0,0,0,0,100,0),
(1319230,23,2142.386,-244.7266,419.5746,0,0,0,0,100,0),
(1319230,24,2145.455,-247.1502,419.5968,0,0,0,0,100,0),
(1319230,25,2148.564,-249.0781,419.5791,0,0,0,0,100,0),
(1319230,26,2150.63,-252.4069,419.598,0,0,0,0,100,0),
(1319230,27,2153.104,-255.5907,419.5758,0,0,0,0,100,0),
(1319230,28,2153.286,-259.4698,419.6053,0,0,0,0,100,0),
(1319230,29,2154.193,-263.0425,419.6039,0,0,0,0,100,0),
(1319230,30,2153.279,-266.768,419.6026,0,0,0,0,100,0),
(1319230,31,2152.758,-270.5462,419.5822,0,0,0,0,100,0),
(1319230,32,2150.38,-273.4614,419.605,0,0,0,0,100,0);
