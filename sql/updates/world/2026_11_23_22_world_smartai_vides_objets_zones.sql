-- Objets et zones de declenchement marques SmartAI sans aucune ligne : SmartAI de LegionCore (credits de quete des temples,
-- zones 4857/4858/4860, donnees envoyees au clic des objets 195004 et 215133).
-- SmartAI porte de LegionCore (vides_go)

-- objet 195004
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`event_type`,`action_type`,`target_type`,`event_param5`,`event_param_string`,`comment`) VALUES (195004,1,0,0,0,100,0,0,0,0,0,1,1,0,0,0,0,34285,6,0,0.0,0.0,0.0,0.0,64,45,19,0,'','LegionCore : GOSSIP_HELLO / SET_DATA');
UPDATE gameobject_template SET AIName='SmartGameObjectAI' WHERE entry=195004 AND ScriptName='';

-- objet 215133
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`event_type`,`action_type`,`target_type`,`event_param5`,`event_param_string`,`comment`) VALUES (215133,1,0,0,0,100,0,0,0,0,0,0,1,0,0,0,0,66209,10,0,0.0,0.0,0.0,0.0,64,45,11,0,'','LegionCore : GOSSIP_HELLO / SET_DATA');
UPDATE gameobject_template SET AIName='SmartGameObjectAI' WHERE entry=215133 AND ScriptName='';

-- zone de declenchement 4990
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`event_type`,`action_type`,`target_type`,`event_param5`,`event_param_string`,`comment`) VALUES (4990,2,0,0,0,100,0,4990,0,0,0,0,1,0,0,0,0,27620,30,0,0.0,0.0,0.0,0.0,46,45,11,0,'','LegionCore : AREATRIGGER_ONTRIGGER / SET_DATA');
INSERT IGNORE INTO areatrigger_scripts (entry, ScriptName) VALUES (4990, 'SmartTrigger');

-- zone de declenchement 4857
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`event_type`,`action_type`,`target_type`,`event_param5`,`event_param_string`,`comment`) VALUES (4857,2,0,1,0,100,0,4857,0,0,0,45627,2,0,0,0,0,0,0,0,0.0,0.0,0.0,0.0,46,85,7,0,'','LegionCore : AREATRIGGER_ONTRIGGER / INVOKER_CAST');
INSERT IGNORE INTO areatrigger_scripts (entry, ScriptName) VALUES (4857, 'SmartTrigger');

-- zone de declenchement 4858
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`event_type`,`action_type`,`target_type`,`event_param5`,`event_param_string`,`comment`) VALUES (4858,2,0,1,0,100,0,4858,0,0,0,45628,2,0,0,0,0,0,0,0,0.0,0.0,0.0,0.0,46,85,7,0,'','LegionCore : AREATRIGGER_ONTRIGGER / INVOKER_CAST');
INSERT IGNORE INTO areatrigger_scripts (entry, ScriptName) VALUES (4858, 'SmartTrigger');

-- zone de declenchement 4860
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`event_type`,`action_type`,`target_type`,`event_param5`,`event_param_string`,`comment`) VALUES (4860,2,0,1,0,100,0,4860,0,0,0,45629,2,0,0,0,0,0,0,0,0.0,0.0,0.0,0.0,46,85,7,0,'','LegionCore : AREATRIGGER_ONTRIGGER / INVOKER_CAST');
INSERT IGNORE INTO areatrigger_scripts (entry, ScriptName) VALUES (4860, 'SmartTrigger');
