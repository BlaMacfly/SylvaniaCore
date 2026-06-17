-- prophet of sseratus fix say line 1 on combat while hit by spell modify mojo - quest 12516
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE  `entry`=28068;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE  `entry`=28151;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (28151, 28068, -119009);
INSERT INTO `smart_scripts` 
(`entryorguid`, `source_type`, `id`, `link`, 
`event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param_string`, 
`action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, 
`target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `COMMENT`) VALUES 
(28068 , 0 , 0 , 0 ,  4 , 0 , 100 , 1 ,     0 ,     0 ,      0 ,      0 , '' ,  1 ,     0 , 0 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 'Cast  Say  on  Aggro'), 
(28068 , 0 , 1 , 0 ,  6 , 0 , 100 , 1 ,     0 ,     0 ,      0 ,      0 , '' ,  1 ,     1 , 0 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 'Cast  Say  on  Death'),
(28068 , 0 , 2 , 0 ,  0 , 0 , 100 , 0 ,  6000 , 10000 ,  10000 ,  15000 , '' , 11 , 48287 , 0 , 0 , 0 , 0 , 0 , 2 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 'Cast  Powerful  Bite'),
(28068 , 0 , 3 , 0 ,  0 , 0 , 100 , 0 ,  1000 ,  4000 , 120000 , 120000 , '' , 11 , 54483 , 0 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 'Cast  Vigor  of  Sseratus'), 
(28068 , 0 , 4 , 5 ,  8 , 0 , 100 , 1 , 50706 ,     0 ,      0 ,      0 , '' , 36 , 28151 , 0 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 'Modify  Mojo  on  Spellhit'), 
(28068 , 0 , 5 , 0 , 61 , 0 , 100 , 0 ,     0 ,     0 ,      0 ,      0 , '' ,  1 ,     1 , 0 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 'On Spell Hit Say Text'),
(28068 , 0 , 6 , 0 ,  1 , 0 , 100 , 0 , 65000 , 95000 ,  65000 ,  95000 , '' ,  1 ,     2 , 0 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 'Say  Text  OOC');