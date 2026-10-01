-- « Recruiting The Troops » (42524, chasseur) : objectif « Train a Squad of Archers » (credit 106398).
-- Le recrutement passe par les commandes de travail du domaine, non gerees par notre core : Lenara proposait
-- les archers mais le clic ne faisait rien (Blez, 01/10/2026). Patron du fief : parler a Lenara (106444)
-- donne le credit tant que la quete est en cours. Le systeme de commandes de travail reste a construire.
UPDATE creature_template SET AIName="SmartAI" WHERE entry=106444 AND ScriptName="";
DELETE FROM smart_scripts WHERE entryorguid=106444 AND source_type=0;
INSERT INTO smart_scripts (entryorguid,source_type,id,link,event_type,event_phase_mask,event_chance,event_flags,event_param1,event_param2,event_param3,event_param4,event_param5,event_param_string,action_type,action_param1,action_param2,action_param3,action_param4,action_param5,action_param6,target_type,target_param1,target_param2,target_param3,target_x,target_y,target_z,target_o,comment) VALUES
(106444,0,0,0,64,0,100,0,0,0,0,0,0,"",33,106398,0,0,0,0,0,7,0,0,0,0,0,0,0,"Lenara : parler = escouade d archers formee (quete 42524)");
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceGroup=1 AND SourceEntry=106444;
INSERT INTO conditions (SourceTypeOrReferenceId,SourceGroup,SourceEntry,SourceId,ElseGroup,ConditionTypeOrReference,ConditionTarget,ConditionValue1,ConditionValue2,ConditionValue3,NegativeCondition,ErrorType,ErrorTextId,ScriptName,Comment) VALUES
(22,1,106444,0,0,9,0,42524,0,0,0,0,0,"","Lenara : quete 42524 en cours");
