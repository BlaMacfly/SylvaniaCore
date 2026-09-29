-- Aludane Whitecloud (96813, Point d atterrissage de Krasus) n avait AUCUN menu : simple maitre de vol.
-- Consequence : « Sur les ailes de l aigle » (40953) etait bloquee, le vol vers le Pavillon du
-- Traqueur (sort 202752) passe par une option de son menu 18723. Signale en jeu par Blez le 29/09.
-- Menu repris de LegionCore, textes officiels de broadcast_text. Ecartes : l option 4 (condition
-- LC sur une quete WotLK sans rapport) et le lancement de scenario de l option 3 (action LC 204 =
-- SET_SCENATIO_ID, qui vaut CIRCLE_PATH chez nous).
UPDATE creature_template SET gossip_menu_id=18723, AIName="SmartAI" WHERE entry=96813 AND ScriptName="";
DELETE FROM gossip_menu_option WHERE MenuId=18723;
INSERT INTO gossip_menu_option (MenuId,OptionIndex,OptionIcon,OptionText,OptionBroadcastTextId,OptionType,OptionNpcFlag,VerifiedBuild) VALUES
(18723,0,2,"I need a ride.",3409,4,8192,0),
(18723,1,0,"Aludane, I have urgent business in Val\x27sharah. Can you secure a flight for me?",102282,1,1,0),
(18723,2,0,"I need to fly to the Trueshot Lodge.",104935,1,1,0),
(18723,3,0,"Meryl Felstorm says you have a ride for me to Faronaar.",112817,1,1,0),
(18723,6,0,"Fly me to the Broken Shore!",125941,1,1,0);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=18723;
INSERT INTO conditions (SourceTypeOrReferenceId,SourceGroup,SourceEntry,SourceId,ElseGroup,ConditionTypeOrReference,ConditionTarget,ConditionValue1,ConditionValue2,ConditionValue3,NegativeCondition,ErrorType,ErrorTextId,ScriptName,Comment) VALUES
(15,18723,1,0,0,9,0,39861,0,0,0,0,0,"","Aludane : vol vers Val sharah (39861 en cours)"),
(15,18723,2,0,0,9,0,40953,0,0,0,0,0,"","Aludane : vol vers le Pavillon (40953 en cours)"),
(15,18723,3,0,0,9,0,42479,0,0,0,0,0,"","Aludane : vol vers Faronaar (42479 en cours)"),
(15,18723,6,0,0,9,0,45571,0,0,0,0,0,"","Aludane : vol vers le Rivage brise (45571 en cours)");
DELETE FROM smart_scripts WHERE entryorguid=96813 AND source_type=0;
INSERT INTO smart_scripts (entryorguid,source_type,id,link,event_type,event_phase_mask,event_chance,event_flags,event_param1,event_param2,event_param3,event_param4,event_param5,event_param_string,action_type,action_param1,action_param2,action_param3,action_param4,action_param5,action_param6,target_type,target_param1,target_param2,target_param3,target_x,target_y,target_z,target_o,comment) VALUES
(96813,0,0,1,62,0,100,0,18723,1,0,0,0,"",33,97545,0,0,0,0,0,7,0,0,0,0,0,0,0,"Aludane - option Val sharah - credit 97545"),
(96813,0,1,0,61,0,100,0,0,0,0,0,0,"",62,1220,0,0,0,0,0,7,0,0,0,2300.1,6575.72,142,2.5,"Aludane - lie - teleportation Val sharah"),
(96813,0,2,4,62,0,100,0,18723,3,0,0,0,"",33,108025,0,0,0,0,0,7,0,0,0,0,0,0,0,"Aludane - option Faronaar - credit 108025"),
(96813,0,4,0,61,0,100,0,0,0,0,0,0,"",62,1616,0,0,0,0,0,7,0,0,0,-174.112,7809.9,112.378,2.169,"Aludane - lie - teleportation Faronaar"),
(96813,0,8,0,62,0,100,0,18723,2,0,0,0,"",85,202752,0,0,0,0,0,7,0,0,0,0,0,0,0,"Aludane - option Pavillon du Traqueur - le joueur lance 202752"),
(96813,0,9,10,62,0,100,0,18723,6,0,0,0,"",33,96813,0,0,0,0,0,7,0,0,0,0,0,0,0,"Aludane - option Rivage brise - credit 96813"),
(96813,0,10,0,61,0,100,0,0,0,0,0,0,"",62,1220,0,0,0,0,0,7,0,0,0,-1225.96,2198.87,0.98,6.07,"Aludane - lie - teleportation Rivage brise");
