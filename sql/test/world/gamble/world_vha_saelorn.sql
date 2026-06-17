SET @SAELORN := 102387;

UPDATE `creature_template` SET 
`ScriptName` = 'freakz_boss_saelorn', 
`minLevel` = 107, 
`maxLevel` = 112, 
`faction` = 16,
`unit_class` = 4,
`mechanic_immune_mask` = `mechanic_immune_mask` |617299967
WHERE `entry` IN (@SAELORN);

UPDATE `creature_template` SET 
`ScriptName` = 'freakz_npc_vha_phase_spider',
`unit_flags` = 33587264,
`unit_flags2`= 2048,
`minLevel` = 107,
`maxLevel` = 112,
`faction` = 16
WHERE `entry` = 102434;

DELETE FROM `spell_script_names` WHERE `spell_id` IN (202306, 210504);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(202306, 'freakz_spell_vha_creeping_slaughter'),
(210504, 'freakz_spell_saelorn_toxic_blood');

DELETE FROM `creature_text` WHERE `entry` = (@SAELORN);
INSERT INTO `creature_text`(`entry`, `groupid`, `id`, `text`, `type`, `probability`, `sound`, `comment`) VALUES
(@SAELORN, '0', '0', 'You can\'t get away. You are MINE!', 14, 100, 57579, 'SAELORN - AGGRO'),
(@SAELORN, '1', '0', 'If you scream loud enough, maybe I will let you die.', 14, 100, 57579, 'SAELORN '),
(@SAELORN, '1', '1', 'Which do you like more, screaming or crying? I like to hear you do both.', 14, 100, 57582, 'SAELORN  to Player'),
(@SAELORN, '2', '0', 'You can\'t leave, you can NEVER LEAVE!', 14, 100, 57582, 'SAELORN  to Player'),
(@SAELORN, '2', '1', 'Get over here, I want to play with your blood.', 14, 100, 57582, 'SAELORN  to Player'),
(@SAELORN, '3', '0', 'On a scale of 1 to 10, how bad does that hurt?', 14, 100, 57582, 'SAELORN  to Player'),
(@SAELORN, '3', '1', 'Your screams are funny... Make me laugh!', 14, 100, 57582, 'SAELORN  to Player'),
(@SAELORN, '4', '0', 'Don\'t look behind you.', 41, 100, 57582, 'SAELORN  to Player'),
(@SAELORN, '4', '1', 'And along came a spider...', 14, 100, 57586,'SAELORN  to Player'),
(@SAELORN, '5', '0', 'Run. Heh, it\'s fun to watch you run.', 14, 100, 57586,'SAELORN  to Player'),
(@SAELORN, '5', '1', 'Don\'t run, I want to see your tears.', 14, 100, 57586,'SAELORN  to Player'),
(@SAELORN, '6', '0', 'I have tried to teach them to kill you slowly... But they just don\'t listen.', 14, 100, 57586,'SAELORN  to Player'),
(@SAELORN, '6', '1', 'I hope this doesn\'t kill you... I want to play more...', 14, 100, 57586,'SAELORN  to Player'),
(@SAELORN, '7', '0', 'I hope the next one doesn\'t break so quickly.', 14, 100, 57586,'SAELORN  to Player'),
(@SAELORN, '7', '1', 'I hate it when my toys stop screaming.', 14, 100, 57586,'SAELORN  to Player'),
(@SAELORN, '7', '2', 'This is why I can\'t have nice things.', 14, 100, 57586,'SAELORN  to Player'),
(@SAELORN, '7', '3', 'Why do they break so easy?', 14, 100, 57586,'SAELORN  to Player'),
(@SAELORN, '8', '0', 'What!? Why would you do this?', 14, 100, 57586,'SAELORN  to Player');



