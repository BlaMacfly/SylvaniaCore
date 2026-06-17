-- fixes for quest 12919

UPDATE `creature_template` SET `AIName`='SmartAI' WHERE  `entry`=29647;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE  `entry`=29872;
UPDATE `creature_template` SET `speed_walk`='4', `speed_run`='4', `AIName`='SmartAI' WHERE  `entry`=29884;

UPDATE `creature` SET `position_z`='234.052' WHERE `id`=29872;

UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry` IN (
29887, -- Vargul Doombringer
29889, -- Vargul Blighthound
29890, -- Vargul Deathwaker
29891, -- Vargul Runelord
29892, -- Vargul Slayer
29893, -- Banshee Soulclaimer
29894, -- Vargul Plaguetalon
29897, -- Reanimated Corpse
29934, -- Acolyte of Agony
29935, -- Acolyte of Pain
29943, -- Scourge Proxy (phased)
37893, -- Vegard the Unforgiven
37976  -- Vegard the Unforgiven
);

UPDATE `creature` SET `PhaseID`=177 WHERE `id` IN (
29887, -- Vargul Doombringer
29889, -- Vargul Blighthound
29890, -- Vargul Deathwaker
29891, -- Vargul Runelord
29892, -- Vargul Slayer
29893, -- Banshee Soulclaimer
29894, -- Vargul Plaguetalon
29897, -- Reanimated Corpse
29934, -- Acolyte of Agony
29935, -- Acolyte of Pain
29943, -- Scourge Proxy (phased)
37893, -- Vegard the Unforgiven
37976, -- Vegard the Unforgiven
29939  -- storm cloud
);

UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry` IN (
29821, -- Prince Navarius
29872, -- Algar the Chosen
29895  -- Thrym
);

UPDATE `creature` SET `PhaseID`=177 WHERE `id` IN (
29821, -- Prince Navarius
29872, -- Algar the Chosen
29895  -- Thrym
);

UPDATE `gameobject` SET `PhaseId`='177' WHERE  `id`=191791;

DELETE FROM `npc_spellclick_spells` WHERE `npc_entry`=29884 AND `spell_id`=46598;
-- INSERT INTO `npc_spellclick_spells` (`npc_entry`, `spell_id`, `cast_flags`, `user_type`) VALUES (29884, 46598, 1, 0);


-- sai for gymer npc 29647
DELETE FROM `smart_scripts` WHERE `entryorguid`=29647;
INSERT INTO `smart_scripts` 
(`entryorguid`, `source_type`, `id`, `link`, 
`event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param_string`, 
`action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, 
`target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)

VALUES 
(29647, 0, 0, 1, 62, 0, 100, 512, 9852, 2, 0, 0, '', 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Gymer - On Gossip Option 2 Selected - Close Gossip'),
(29647, 0, 1, 0, 61, 0, 100, 512, 0, 0, 0, 0, '', 11, 55568, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Gymer - On Gossip Option 2 Selected - Cast Summon Gymer (Force)'),
(29647, 0, 4, 0,  1, 0, 100, 512, 10000, 20000, 30000, 40000, '', 1, 1, 5000, 0, 0, 0, 0,1, 0, 0, 0, 0, 0, 0, 0, 'Gymer - Out of Combat - Say Line 1'),
(29647, 0, 5, 0, 20, 0, 100, 512, 12916, 0, 0, 0, '', 1, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gymer - On Quest reward - Say Line 7');

-- sai for gymer verhicle 29884
DELETE FROM `smart_scripts` WHERE `entryorguid`=29884;
INSERT INTO `smart_scripts` 
(`entryorguid`, `source_type`, `id`, `link`, 
`event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param_string`, 
`action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, 
`target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES 
(29884, 0, 0, 1, 54, 0, 100, 512, 0, 0, 0, 0, '', 86, 55430, 2, 7, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gymer - On Just Summoned - Cast Gymers Buddy'),
(29884, 0, 1, 0, 61, 0, 100, 512, 0, 0, 0, 0, '', 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gymer - On Just Summoned - Set Passive'),
(29884, 0, 2, 3, 27, 0, 100, 512, 0, 0, 0, 0, '', 44, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gymer - On Passenger Boarded - Set Phase 256'),
(29884, 0, 3, 4, 61, 0, 100, 512, 0, 0, 0, 0, '', 1, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gymer - On Passenger Boarded - Say Line 8 (No Repeat)'),
(29884, 0, 4, 0, 61, 0, 100, 512, 0, 0, 0, 0, '', 11, 55461, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gymer - On Passenger Boarded - Cast Storms Fury'),
(29884, 0, 5, 6, 28, 0, 100, 512, 0, 0, 0, 0, '', 44, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gymer - On Passenger Removed - Set Phase 1'),
(29884, 0, 6, 7, 61, 0, 100, 512, 0, 0, 0, 0, '', 1, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gymer - On Passenger Removed - Say Line 10'),
(29884, 0, 7, 0, 61, 0, 100, 512, 0, 0, 0, 0, '', 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gymer - On Passenger Removed - Despawn after 5 seconds');

DELETE FROM `gameobject_template_addon` WHERE `entry`=191791;
INSERT INTO `gameobject_template_addon` 
(`entry`, `faction`, `flags`, `mingold`, `maxgold`, `WorldEffectID`) 
VALUES 
(191791, 0, 0, 0, 0, 0);

DELETE FROM `creature_template_addon` WHERE `entry`=29647;
INSERT INTO `creature_template_addon` 
(`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `auras`) 
VALUES 
(29647, 0, 0, 1, 0, 0, 0, 0, 0, NULL);

-- sai for npcs with killcredit for quest 12919
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid` IN  (
29887, -- Vargul Doombringer
29889, -- Vargul Blighthound
29890, -- Vargul Deathwaker
29891, -- Vargul Runelord
29892, -- Vargul Slayer
29893, -- Banshee Soulclaimer
29894, -- Vargul Plaguetalon
29897, -- Reanimated Corpse
29934, -- Acolyte of Agony
29935, -- Acolyte of Pain
29943, -- Scourge Proxy (phased)
37893, -- Vegard the Unforgiven
37976  -- Vegard the Unforgiven
);
INSERT INTO `smart_scripts`
(`entryorguid`,`source_type`,`id`,`link`,
`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,
`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,
`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(29887,0,0,0,0,0,100,0,2000,20000,30000,40000,1,1,5000,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Vargul Doombringer - In Combat - Say Line 1 (Phase 1) (No Repeat)"),
(29887,0,1,0,8,0,100,0,55569,0,100,200,33,29943,0,0,0,0,0,7,0,0,0,0.0,0.0,0.0,0.0,"Vargul Doombringer - On Spellhit Explosion - Get Kill credit"),
(29889,0,0,0,0,0,100,0,6000,10000,16000,23000,11,50047,0,0,0,0,0,2,0,0,0,0.0,0.0,0.0,0.0,"Vargul Blighthound - In Combat - Cast 'Broken Bone' (Phase 1) (No Repeat)"),
(29889,0,1,0,0,0,100,0,2000,15000,26000,33000,11,50046,0,0,0,0,0,2,0,0,0,0.0,0.0,0.0,0.0,"Vargul Blighthound - In Combat - Cast 'Gnaw Bone' (Phase 1) (No Repeat)"),
(29889,0,2,0,8,0,100,0,55569,0,100,200,33,29943,0,0,0,0,0,7,0,0,0,0.0,0.0,0.0,0.0,"Vargul Blighthound - On Spellhit Explosion - Get Kill credit"),
(29890,0,0,0,0,0,100,0,3000,13000,19000,26000,11,56038,0,0,0,0,0,2,0,0,0,0.0,0.0,0.0,0.0,"Vargul Deathwaker - In Combat - Cast 'Plaguebolt' (Phase 1) (No Repeat)"),
(29890,0,1,0,8,0,100,0,55569,0,100,200,33,29943,0,0,0,0,0,7,0,0,0,0.0,0.0,0.0,0.0,"Vargul Deathwaker - On Spellhit Explosion - Get Kill credit"),
(29891,0,0,0,0,0,100,0,3000,13000,19000,26000,11,56036,0,0,0,0,0,2,0,0,0,0.0,0.0,0.0,0.0,"Vargul Runelord - In Combat - Cast 'Rune of Destruction' (Phase 1) (No Repeat)"),
(29891,0,10,0,8,0,100,0,55569,0,100,200,33,29943,0,0,0,0,0,7,0,0,0,0.0,0.0,0.0,0.0,"Vargul Runelord - On Spellhit Explosion - Get Kill credit"),
(29892,0,0,0,8,0,100,0,55569,0,100,200,33,29943,0,0,0,0,0,7,0,0,0,0.0,0.0,0.0,0.0,"Vargul Slayer - On Spellhit Explosion - Get Kill credit"),
(29893,0,0,0,0,0,100,0,4000,7000,9000,12000,11,28993,0,0,0,0,0,2,0,0,0,0.0,0.0,0.0,0.0,"Banshee Soulclaimer - In Combat - Cast 'Banshee Wail' (Phase 1) (No Repeat)"),
(29893,0,1,0,8,0,100,0,55569,0,100,200,33,29943,0,0,0,0,0,7,0,0,0,0.0,0.0,0.0,0.0,"Banshee Soulclaimer - On Spellhit Explosion - Get Kill credit"),
(29894,0,0,0,0,0,100,0,3000,9000,14000,21000,11,55079,0,0,0,0,0,2,0,0,0,0.0,0.0,0.0,0.0,"Vargul Plaguetalon - In Combat - Cast 'Swoop' (Phase 1) (No Repeat)"),
(29894,0,1,0,8,0,100,0,55569,0,100,200,33,29943,0,0,0,0,0,7,0,0,0,0.0,0.0,0.0,0.0,"Vargul Plaguetalon - On Spellhit Explosion - Get Kill credit"),
(29897,0,0,0,8,0,100,0,55569,0,100,200,33,29943,0,0,0,0,0,7,0,0,0,0.0,0.0,0.0,0.0,"Reanimated Corpse - On Spellhit Explosion - Get Kill credit"),
(29934,0,0,0,8,0,100,0,55569,0,100,200,33,29943,0,0,0,0,0,7,0,0,0,0.0,0.0,0.0,0.0,"Acolyte of Agony - On Spellhit Explosion - Get Kill credit"),
(29935,0,0,0,8,0,100,0,55569,0,100,200,33,29943,0,0,0,0,0,7,0,0,0,0.0,0.0,0.0,0.0,"Acolyte of Pain - On Spellhit Explosion - Get Kill credit"),
(29943,0,0,0,8,0,100,0,55569,0,100,200,33,29943,0,0,0,0,0,7,0,0,0,0.0,0.0,0.0,0.0,"Scourge Proxy - On Spellhit Explosion - Get Kill credit"),
(37893,0,0,0,54,0,100,512,0,0,0,0,80,3789300,2,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Vegard the Unforgiven - On Just Summoned - Run Script"),
(37893,0,1,2,8,0,100,512,70792,0,0,0,37,0,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Vegard the Unforgiven - On Spell Hit(Kill Vegard) - Die"),
(37893,0,2,0,61,0,100,512,0,0,0,0,41,5000,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Vegard the Unforgiven - On Spell Hit(Kill Vegard) - Despawn"),
(37893,0,3,0,8,0,100,0,55569,0,100,200,33,29943,0,0,0,0,0,7,0,0,0,0.0,0.0,0.0,0.0,"Vegard the Unforgiven - On Spellhit Explosion - Get Kill credit"),
(37976,0,0,1,54,0,100,512,0,0,0,0,11,7398,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Vegard the Unforgiven - On Just Summoned - Cast Rebirth"),
(37976,0,1,0,61,0,100,512,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Vegard the Unforgiven - On Just Summoned - Say Line 0"),
(37976,0,2,3,6,0,100,0,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Vegard the Unforgiven - On Death - Say Line 1"),
(37976,0,3,4,61,0,100,512,0,0,0,0,45,2,2,0,0,0,0,19,38001,0,0,0.0,0.0,0.0,0.0,"Vegard the Unforgiven - On Death - Say Line Set Data 2 2 on Light's Vengeance Bunny 2"),
(37976,0,4,0,61,0,100,512,0,0,0,0,45,1,1,0,0,0,0,20,201937,0,0,0.0,0.0,0.0,0.0,"Vegard the Unforgiven - On Death - Say Line Set Data 1 1 on Light's Vengeance"),
(37976,0,5,0,9,0,100,0,0,10,20000,35000,11,70866,0,0,0,0,0,7,0,0,0,0.0,0.0,0.0,0.0,"Vegard the Unforgiven - On Range - Cast Shadow Blast"),
(37976,0,6,0,2,0,100,0,0,30,15000,25000,11,70886,0,0,0,0,0,2,0,0,0,0.0,0.0,0.0,0.0,"Vegard the Unforgiven - On Less than 30% HP - Cast Vegard's Thirst"),
(37976,0,7,0,0,0,100,0,3000,7000,25000,35000,11,71003,0,0,0,0,0,2,0,0,0,0.0,0.0,0.0,0.0,"Vegard the Unforgiven - IC - Cast 'Vegard's Touch'"),
(37976,0,8,9,7,0,100,0,0,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Vegard the Unforgiven - On Evade - Say Line 2"),
(37976,0,9,0,61,0,100,512,0,0,0,0,41,5000,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Vegard the Unforgiven - On Evade - Despawn"),
(37976,0,10,0,8,0,100,0,55569,0,100,200,33,29943,0,0,0,0,0,7,0,0,0,0.0,0.0,0.0,0.0,"Vegard the Unforgiven - On Spellhit Explosion - Get Kill credit");

SET @ALGAR                  := 29872; -- Algar the Chosen
SET @NAVARIUS               := 29821; -- Prince Navarius
SET @THRYM                  := 29895; -- Thrym <The Hope Ender>
SET @NAVARIUS_CREDIT        := 55660; -- Navarius Kill Credit
SET @ALGAR_CREDIT           := 55661; -- Algar Kill Credit
SET @THRYM_CREDIT           := 55662; -- Thrym Kill Credit

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@ALGAR, @NAVARIUS, @THRYM);
INSERT INTO `smart_scripts` 
(`entryorguid`, `source_type`, `id`, `link`, 
`event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param_string`, 
`action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, 
`target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@NAVARIUS, 0, 0, 0, 25, 0, 100, 512, 0, 0, 0, 0, '', 11, 55706, 0, 0, 0, 0, 0, 1,  0, 0, 0, 0, 0, 0, 0, 'Prince Navarius - On Respawn - Cast \'Sinister Shield\' (No Repeat) (Dungeon)'),
(@NAVARIUS, 0, 1, 0,  0, 0, 100, 512, 7000, 16000, 15000, 19000, '', 11, 51009, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Prince Navarius - In Combat - Cast \'Soul Deflection\' (No Repeat) (Dungeon)'),
(@NAVARIUS, 0, 2, 0,  0, 0, 100, 512, 9000, 15000, 18000, 21000, '', 11, 51016, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Prince Navarius - In Combat - Cast \'Vampiric Bolt\' (No Repeat) (Dungeon)'),
(@NAVARIUS, 0, 3, 0,  0, 0, 100, 512, 16000, 28000, 26000, 34000, '', 11, 50992, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Prince Navarius - In Combat - Cast \'Soul Blast\' (No Repeat) (Dungeon)'),
(@NAVARIUS, 0, 4, 5,  6, 0, 100, 512, 0, 0, 0, 0, '', 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Prince Navarius - On Just Died - Say Line 1 (No Repeat)'),
(@NAVARIUS, 0, 5, 6, 61, 0, 100, 512, 0, 0, 0, 0, '', 12, 29895, 1, 120000, 0, 0, 0, 8, 0, 0, 0, 5611.73, -2302.77, 289.465, 1.74533, 'Prince Navarius - On Just Died - Summon Creature \'Thrym\' (No Repeat)'),
(@NAVARIUS, 0, 6, 0, 61, 0, 100, 512, 0, 0, 0, 0, '', 11, 55660, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Prince Navarius - On Just Died - Cast \'Navarius Kill Credit\' (No Repeat)'),
(@NAVARIUS, 0, 7, 0,  4, 0, 100, 512, 0, 0, 0, 0, '', 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Prince Navarius - On Aggro - Say Line 0 (No Repeat)'),
(@ALGAR, 0, 0, 0,  0, 0, 100, 512, 6000, 10000, 16000, 23000, '', 11, 42729, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Algar the Chosen - In Combat - Cast \'Dreadful Roar\''),
(@ALGAR, 0, 1, 0,  6, 0, 100, 512, 0, 0, 0, 0, '', 11, 55661, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Algar the Chosen - On Just Died - Cast \'Algar Kill Credit\''),
(@THRYM, 0, 0, 1, 11, 0, 100, 512, 0, 0, 0, 0, '', 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Thrym - On Respawn - Say Line 0 (No Repeat)'),
(@THRYM, 0, 1, 0, 61, 0, 100, 512, 0, 0, 0, 0, '', 97, 40, 30, 0, 0, 0, 0, 1, 0, 0, 0, 5555.58, -2223.97, 235.967, 0, 'Thrym - Between 0-7% Mana - Jump To Pos (Phase 1) (No Repeat)'),
(@THRYM, 0, 2, 0,  1, 0, 100, 512, 3000, 3000, 3000, 3000, '', 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Thrym - Out of Combat - Set Home Position (No Repeat)'),
(@THRYM, 0, 3, 0,  4, 0, 100, 512, 0, 0, 0, 0, '', 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Thrym - On Aggro - Say Line 1 (Phase 1) (No Repeat)'),
(@THRYM, 0, 4, 0,  0, 0, 100, 512, 8000, 16000, 15000, 21000, '', 11, 28167, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Thrym - In Combat - Cast \'Chain Lightning\' (Phase 1) (No Repeat)'),
(@THRYM, 0, 5, 0,  6, 0, 100, 512, 0, 0, 0, 0, '', 11, 55662, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Thrym - On Just Died - Cast \'Thrym Kill Credit\' (No Repeat)');





