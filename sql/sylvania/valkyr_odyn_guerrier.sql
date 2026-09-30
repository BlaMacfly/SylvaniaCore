-- Val kyr d Odin (93819) : transport des GUERRIERS vers le Fort-Celeste. Chez nous : 22 exemplaires sans
-- aucun script (le menu 93819 existait, rien ne lancait la teleportation 192085), et aucun a la Halte de
-- Krasus (Dalaran). Repris de LegionCore : SmartAI (option de dialogue -> sort 192085), option et
-- exemplaire de Dalaran reserves aux guerriers (phase 7342, condition de classe). Reperee le 01/10/2026
-- en cherchant pour Blez (chasseur, qui suivait un guide d une autre classe).
UPDATE creature_template SET AIName="SmartAI" WHERE entry=93819 AND ScriptName="";
DELETE FROM smart_scripts WHERE entryorguid=93819 AND source_type=0;
INSERT INTO smart_scripts (entryorguid,source_type,id,link,event_type,event_phase_mask,event_chance,event_flags,event_param1,event_param2,event_param3,event_param4,event_param5,event_param_string,action_type,action_param1,action_param2,action_param3,action_param4,action_param5,action_param6,target_type,target_param1,target_param2,target_param3,target_x,target_y,target_z,target_o,comment) VALUES
(93819,0,0,0,62,0,100,0,93819,0,0,0,0,"",85,192085,0,0,0,0,0,7,0,0,0,0,0,0,0,"Val kyr d Odin - option de dialogue - vers le Fort-Celeste (LegionCore)");
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=93819;
INSERT INTO conditions (SourceTypeOrReferenceId,SourceGroup,SourceEntry,SourceId,ElseGroup,ConditionTypeOrReference,ConditionTarget,ConditionValue1,ConditionValue2,ConditionValue3,NegativeCondition,ErrorType,ErrorTextId,ScriptName,Comment) VALUES
(15,93819,0,0,0,15,0,1,0,0,0,0,0,"","Val kyr d Odin : option reservee aux guerriers");
DELETE FROM phase_area WHERE AreaId=7502 AND PhaseId=7342;
INSERT INTO phase_area (AreaId,PhaseId,Comment) VALUES (7502,7342,"LC: Npc - Phase for Class - Warrior");
DELETE FROM conditions WHERE SourceTypeOrReferenceId=26 AND SourceGroup=7342 AND SourceEntry=7502;
INSERT INTO conditions (SourceTypeOrReferenceId,SourceGroup,SourceEntry,SourceId,ElseGroup,ConditionTypeOrReference,ConditionTarget,ConditionValue1,ConditionValue2,ConditionValue3,NegativeCondition,ErrorType,ErrorTextId,ScriptName,Comment) VALUES
(26,7342,7502,0,0,15,0,1,0,0,0,0,0,"","Dalaran : PNJ reserves aux guerriers");
INSERT INTO creature (guid,id,map,zoneId,areaId,spawnDifficulties,phaseUseFlags,PhaseId,PhaseGroup,terrainSwapMap,position_x,position_y,position_z,orientation,spawntimesecs,modelid,equipment_id,spawndist,currentwaypoint,curhealth,curmana,MovementType,npcflag,unit_flags,unit_flags2,unit_flags3,dynamicflags,ScriptName,movementmode,VerifiedBuild) VALUES
(290319231,93819,1220,7502,7505,"0",0,7342,0,-1,-832.826,4252.29,745.833,1.49147,120,0,0,0,0,0,0,0,0,0,0,0,0,"",0,0);
