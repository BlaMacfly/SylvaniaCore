-- PNJ marques SmartAI sans aucune ligne, que ni LegionCore ni la TDB 7.3.5 n'ont : TDB 1200 (TrinityCore master, 2026-02-06).
-- Archmage Vargoth (19481) : le familier du Kirin Tor (recompense du haut fait Haute instruction, 1956) se recupere par
-- dialogue. Menu 10212 et textes 14192/14194 presents chez nous, option absente : reprise de la TDB (texte officiel 33039,
-- conditions officielles). La TDB declenche le sort sur le sous-menu 10213, qui n'a pas d'option chez nous non plus :
-- le sort est lance au choix de l'option elle-meme.
UPDATE `creature_template` SET `gossip_menu_id`=10212, `npcflag`=`npcflag`|1 WHERE `entry`=19481 AND `gossip_menu_id`=0;
DELETE FROM `gossip_menu_option` WHERE `MenuId`=10212 AND `OptionIndex`=0;
INSERT INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES
(10212,0,0,'I have a book that might interest you. Would you like to take a look?',33039,1,1,0);
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=10212 AND `SourceEntry`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(15,10212,0,0,0,2,0,44738,1,1,1,0,0,'','Archmage Vargoth : option si le joueur n a pas le familier du Kirin Tor'),
(15,10212,0,0,0,17,0,1956,0,0,0,0,0,'','Archmage Vargoth : option si le haut fait Haute instruction est accompli');
DELETE FROM `smart_scripts` WHERE `entryorguid`=19481 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(19481,0,0,1,62,0,100,0,10212,0,0,0,11,61457,0,0,0,0,0,7,0,0,0,0,0,0,0,'Archmage Vargoth - On Gossip Option 0 Selected - Cast Kirin Tor Familiar'),
(19481,0,1,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Archmage Vargoth - On Link - Close Gossip');

-- Cave Explosion Bunny (29999) : TDB 1200
DELETE FROM `smart_scripts` WHERE `entryorguid`=29999 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(29999,0,0,0,38,0,100,0,0,1,0,0,11,59383,0,0,0,0,0,1,0,0,0,0,0,0,0,'Cave Explosion Bunny - On Data Set 0 1 - Cast Cave Explosion');
