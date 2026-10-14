-- Val'sharah : Cenarius, gardien du Bosquet (40122) - impossible a valider (Malfurion 91462 sans menu ni script)
-- Deroule officiel porte de LegionCore (SmartAI, trajet) ; repliques sur les broadcast_text officiels (ceux de Krigsgaldrnet sont faux).
-- Le sort 181481 (Invocation de Malfurion) donne lui-meme le credit 91461 (effet 90) ; le reste est le trajet a dos de cerf.

UPDATE `creature_template` SET `gossip_menu_id`=18273, `AIName`='SmartAI' WHERE `entry`=91462 AND `ScriptName`='';
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry` IN (91465,91109,91651) AND `ScriptName`='';

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=18273 AND `SourceEntry`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`Comment`) VALUES
(15,18273,0,0,0,9,0,40122,0,0,0,'Malfurion - option seulement avec la quete 40122');

DELETE FROM `smart_scripts` WHERE (`source_type`=0 AND `entryorguid` IN (91462,91465,91109,91651)) OR (`source_type`=9 AND `entryorguid` IN (9146500,9146501,9110900,9165100));
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_param1`,`event_param2`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`target_type`,`target_param1`,`target_param2`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(91462,0,0,1,62,18273,0,72,0,0,0,7,0,0,0,0,0,0,'Malfurion - gossip pret - fermer'),
(91462,0,1,0,61,0,0,85,181481,2,0,7,0,0,0,0,0,0,'Malfurion - gossip pret - le joueur lance Invocation de Malfurion (credit 91461)'),
(91465,0,0,1,54,0,0,85,46598,2,0,1,0,0,0,0,0,0,'Malfurion (cerf) - invoque - le joueur monte'),
(91465,0,1,0,61,0,0,80,9146500,0,2,1,0,0,0,0,0,0,'Malfurion (cerf) - invoque - trajet et repliques'),
(91465,0,2,0,40,13,91465,80,9146501,0,2,1,0,0,0,0,0,0,'Malfurion (cerf) - arrivee au bosquet'),
(9146500,9,0,0,0,0,0,3,0,45092,0,1,0,0,0,0,0,0,'Malfurion (cerf) - forme de cerf'),
(9146500,9,1,0,0,1000,1000,1,0,0,0,1,0,0,0,0,0,0,'Malfurion (cerf) - Ahh, Val sharah'),
(9146500,9,2,0,0,500,500,53,1,91465,0,1,0,0,0,0,0,0,'Malfurion (cerf) - depart du trajet'),
(9146500,9,3,0,0,5500,5500,1,1,0,0,1,0,0,0,0,0,0,'Malfurion (cerf) - replique 1'),
(9146500,9,4,0,0,4000,4000,1,2,0,0,1,0,0,0,0,0,0,'Malfurion (cerf) - replique 2'),
(9146500,9,5,0,0,12000,12000,1,3,0,0,1,0,0,0,0,0,0,'Malfurion (cerf) - replique 3'),
(9146500,9,6,0,0,13000,13000,1,4,0,0,1,0,0,0,0,0,0,'Malfurion (cerf) - replique 4'),
(9146501,9,0,0,0,0,0,12,91651,8,0,8,0,0,2604.27,6726.43,104.7,4.9,'Malfurion (cerf) - invoquer Nyandra'),
(9146501,9,1,0,0,0,0,12,91109,8,0,8,0,0,2610.05,6695.21,105.41,1.68,'Malfurion (cerf) - invoquer Malfurion a pied'),
(9146501,9,2,0,0,0,0,41,0,0,0,1,0,0,0,0,0,0,'Malfurion (cerf) - disparition (le joueur descend)');
-- Malfurion a pied (91109) et Nyandra (91651), portes tels quels par port_smart.py
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`event_type`,`action_type`,`target_type`,`event_param5`,`event_param_string`,`comment`) VALUES (91109,0,0,0,0,100,0,0,0,0,0,9110900,2,0,0,0,0,0,0,0,0.0,0.0,0.0,0.0,54,80,1,0,'','LegionCore : JUST_SUMMONED / CALL_TIMED_ACTIONLIST');
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`event_type`,`action_type`,`target_type`,`event_param5`,`event_param_string`,`comment`) VALUES (91109,0,1,2,0,100,0,1,91109,0,0,40122,0,0,0,0,0,10,0,0,0.0,0.0,0.0,0.0,40,15,18,0,'','LegionCore : WAYPOINT_REACHED / CALL_AREAEXPLOREDOREVENTHAPPENS');
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`event_type`,`action_type`,`target_type`,`event_param5`,`event_param_string`,`comment`) VALUES (91109,0,2,3,0,100,0,0,0,0,0,156263,0,0,0,0,0,20,0,0,0.0,0.0,0.0,0.0,61,11,18,0,'','LegionCore : LINK / CAST');
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`event_type`,`action_type`,`target_type`,`event_param5`,`event_param_string`,`comment`) VALUES (91109,0,3,0,0,100,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.0,0.0,0.0,0.0,61,41,1,0,'','LegionCore : LINK / FORCE_DESPAWN');
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`event_type`,`action_type`,`target_type`,`event_param5`,`event_param_string`,`comment`) VALUES (9110900,9,0,0,0,100,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.0,0.0,0.0,0.0,0,81,1,0,'','LegionCore : UPDATE_IC / SET_NPC_FLAG');
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`event_type`,`action_type`,`target_type`,`event_param5`,`event_param_string`,`comment`) VALUES (9110900,9,1,0,0,100,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.0,0.0,0.0,0.0,0,1,1,0,'','LegionCore : UPDATE_IC / TALK');
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`event_type`,`action_type`,`target_type`,`event_param5`,`event_param_string`,`comment`) VALUES (9110900,9,2,0,0,100,0,1000,1000,0,0,0,0,0,0,0,0,0,0,0,2606.07,6720.25,104.6,1.4,0,69,1,0,'','LegionCore : UPDATE_IC / MOVE_TO_POS');
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`event_type`,`action_type`,`target_type`,`event_param5`,`event_param_string`,`comment`) VALUES (9110900,9,3,0,0,100,0,4500,4500,0,0,1,0,0,0,0,0,0,0,0,0.0,0.0,0.0,0.0,0,1,1,0,'','LegionCore : UPDATE_IC / TALK');
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`event_type`,`action_type`,`target_type`,`event_param5`,`event_param_string`,`comment`) VALUES (9110900,9,4,0,0,100,0,5000,5000,0,0,2,0,0,0,0,0,0,0,0,0.0,0.0,0.0,0.0,0,1,1,0,'','LegionCore : UPDATE_IC / TALK');
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`event_type`,`action_type`,`target_type`,`event_param5`,`event_param_string`,`comment`) VALUES (9110900,9,5,0,0,100,0,0,0,0,0,1,91109,0,0,0,0,0,0,0,0.0,0.0,0.0,0.0,0,53,1,0,'','LegionCore : UPDATE_IC / WP_START');
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`event_type`,`action_type`,`target_type`,`event_param5`,`event_param_string`,`comment`) VALUES (91651,0,0,0,0,100,0,0,0,0,0,9165100,2,0,0,0,0,0,0,0,0.0,0.0,0.0,0.0,54,80,1,0,'','LegionCore : JUST_SUMMONED / CALL_TIMED_ACTIONLIST');
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`event_type`,`action_type`,`target_type`,`event_param5`,`event_param_string`,`comment`) VALUES (91651,0,1,0,0,100,0,1,91651,0,0,2000,0,0,0,0,0,0,0,0,0.0,0.0,0.0,0.0,40,41,1,0,'','LegionCore : WAYPOINT_REACHED / FORCE_DESPAWN');
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`event_type`,`action_type`,`target_type`,`event_param5`,`event_param_string`,`comment`) VALUES (9165100,9,0,0,0,100,0,4000,4000,0,0,0,0,0,0,0,0,0,0,0,0.0,0.0,0.0,0.0,0,1,1,0,'','LegionCore : UPDATE_IC / TALK');
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`event_type`,`action_type`,`target_type`,`event_param5`,`event_param_string`,`comment`) VALUES (9165100,9,1,0,0,100,0,2500,2500,0,0,1,0,0,0,0,0,0,0,0,0.0,0.0,0.0,0.0,0,1,1,0,'','LegionCore : UPDATE_IC / TALK');
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`event_type`,`action_type`,`target_type`,`event_param5`,`event_param_string`,`comment`) VALUES (9165100,9,2,0,0,100,0,3000,3000,0,0,2,0,0,0,0,0,0,0,0,0.0,0.0,0.0,0.0,0,1,1,0,'','LegionCore : UPDATE_IC / TALK');
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`event_type`,`action_type`,`target_type`,`event_param5`,`event_param_string`,`comment`) VALUES (9165100,9,3,0,0,100,0,2000,2000,0,0,3,0,0,0,0,0,0,0,0,0.0,0.0,0.0,0.0,0,1,1,0,'','LegionCore : UPDATE_IC / TALK');
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`event_type`,`action_type`,`target_type`,`event_param5`,`event_param_string`,`comment`) VALUES (9165100,9,4,0,0,100,0,0,0,0,0,1,91651,0,0,0,0,0,0,0,0.0,0.0,0.0,0.0,0,53,1,0,'','LegionCore : UPDATE_IC / WP_START');

DELETE FROM `waypoints` WHERE `entry` IN (91465,91109,91651);
INSERT INTO `waypoints` (`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`) VALUES
(91465,1,2291.9,6630.22,135.2,'LegionCore'),
(91465,2,2332.56,6669.77,134.8,'LegionCore'),
(91465,3,2358.84,6667.65,139.4,'LegionCore'),
(91465,4,2393.4,6661.75,140.8,'LegionCore'),
(91465,5,2416.17,6646,138.2,'LegionCore'),
(91465,6,2435.19,6627.65,138.06,'LegionCore'),
(91465,7,2472.34,6592.7,135.23,'LegionCore'),
(91465,8,2529.82,6592.57,132.35,'LegionCore'),
(91465,9,2565.57,6606.51,129.09,'LegionCore'),
(91465,10,2605.7,6640.78,117.42,'LegionCore'),
(91465,11,2616.26,6664.81,110.6,'LegionCore'),
(91465,12,2614.04,6685.72,106.54,'LegionCore'),
(91465,13,2610.05,6695.21,105.41,'LegionCore'),
(91109,1,2610.6,6745.27,106,'LegionCore'),
(91651,1,2606.79,6744.06,105.9,'LegionCore');

DELETE FROM `creature_text` WHERE `CreatureID` IN (91465,91109,91651);
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`,`TextRange`,`comment`) VALUES
(91465,0,0,'Ahh, Val\'sharah...',12,0,100,0,0,0,95552,0,'Val sharah - quete 40122'),
(91465,1,0,'Every step in this forest brings back precious memories.',12,0,100,0,0,0,93557,0,'Val sharah - quete 40122'),
(91465,2,0,'Ages ago, the first druids molded this land to be a reflection of the Emerald Dream.',12,0,100,0,0,0,93558,0,'Val sharah - quete 40122'),
(91465,3,0,'Merely an echo, but Val\'sharah is as close to the Dream as this world can come.',12,0,100,0,0,0,93560,0,'Val sharah - quete 40122'),
(91465,4,0,'Make ready, hero. We shall soon stand in the presence of the Lord of the Forest.',12,0,100,0,0,0,95284,0,'Val sharah - quete 40122'),
(91109,0,0,'Follow me.',12,0,100,0,0,0,93565,0,'Val sharah - quete 40122'),
(91109,1,0,'It is good to see you agai--',12,0,100,0,0,0,93567,0,'Val sharah - quete 40122'),
(91109,2,0,'What is this... corruption?',12,0,100,0,0,0,93570,0,'Val sharah - quete 40122'),
(91651,0,0,'Malfurion! Thank Elune you\'ve come!',12,0,100,0,0,0,93566,0,'Val sharah - quete 40122'),
(91651,1,0,'You must come quickly; something\'s happened!',12,0,100,0,0,0,93568,0,'Val sharah - quete 40122'),
(91651,2,0,'He was in the Dream, but now he won\'t wake. We cannot stir him.',12,0,100,0,0,0,93569,0,'Val sharah - quete 40122'),
(91651,3,0,'We--we don\'t know. It only just appeared.',12,0,100,0,0,0,93571,0,'Val sharah - quete 40122');
