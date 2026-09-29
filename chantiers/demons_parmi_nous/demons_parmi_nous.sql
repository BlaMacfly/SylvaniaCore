-- Des demons parmi nous (40607) et Demons parmi eux (40983) : les 12 demons abattus.
-- Les infiltres sont des Felblade Assassin (101100), invisibles (type 22, sort 81717)
-- pour qui n'a pas la vision d'Allari (sort 81742, meme type).

UPDATE creature_template SET
  minlevel=98, maxlevel=110, HealthScalingExpansion=6, faction=14, npcflag=0,
  unit_class=1, unit_flags=32768, unit_flags2=2048, type=3,
  BaseAttackTime=2000, RangeAttackTime=2000, HealthModifier=1.25, DamageModifier=1,
  KillCredit1=101105, MovementType=1
WHERE entry=101100;

DELETE FROM creature_template_addon WHERE entry=101100;
INSERT INTO creature_template_addon (entry,path_id,mount,bytes1,bytes2,emote,aiAnimKit,movementAnimKit,meleeAnimKit,visibilityDistanceType,auras)
VALUES (101100,0,0,0,1,0,0,0,0,0,'81717');

DELETE FROM creature WHERE guid BETWEEN 290300103 AND 290300118;
INSERT INTO creature (guid,id,map,zoneId,areaId,spawnDifficulties,phaseUseFlags,PhaseId,PhaseGroup,terrainSwapMap,modelid,equipment_id,position_x,position_y,position_z,orientation,spawntimesecs,spawndist,currentwaypoint,curhealth,curmana,MovementType,npcflag,unit_flags,unit_flags2,unit_flags3,dynamicflags,ScriptName,VerifiedBuild) VALUES
(290300103,101100,1,14,4982,'0',0,0,0,-1,0,0,1198,-4358,22.28,0.8,60,3,0,1,0,1,0,0,0,0,0,'',0),
(290300104,101100,1,14,4982,'0',0,0,0,-1,0,0,1212,-4361,23.66,2.1,60,3,0,1,0,1,0,0,0,0,0,'',0),
(290300105,101100,1,14,4982,'0',0,0,0,-1,0,0,1230,-4352,22.00,4.0,60,3,0,1,0,1,0,0,0,0,0,'',0),
(290300106,101100,1,14,4982,'0',0,0,0,-1,0,0,1245,-4395,28.03,5.5,60,3,0,1,0,1,0,0,0,0,0,'',0),
(290300107,101100,1,14,4982,'0',0,0,0,-1,0,0,1268,-4372,28.47,1.3,60,3,0,1,0,1,0,0,0,0,0,'',0),
(290300108,101100,1,14,4982,'0',0,0,0,-1,0,0,1290,-4366,32.81,3.3,60,3,0,1,0,1,0,0,0,0,0,'',0),
(290300109,101100,1,14,4982,'0',0,0,0,-1,0,0,1302,-4350,33.10,0.2,60,3,0,1,0,1,0,0,0,0,0,'',0),
(290300110,101100,1,14,4982,'0',0,0,0,-1,0,0,1316,-4347,32.58,2.7,60,3,0,1,0,1,0,0,0,0,0,'',0),
(290300111,101100,1,14,4982,'0',0,0,0,-1,0,0,1310,-4400,25.30,4.6,60,3,0,1,0,1,0,0,0,0,0,'',0),
(290300112,101100,1,14,4982,'0',0,0,0,-1,0,0,1285,-4445,27.48,1.9,60,3,0,1,0,1,0,0,0,0,0,'',0),
(290300113,101100,1,14,4982,'0',0,0,0,-1,0,0,1298,-4468,25.67,5.9,60,3,0,1,0,1,0,0,0,0,0,'',0),
(290300114,101100,1,14,4982,'0',0,0,0,-1,0,0,1255,-4440,27.67,3.7,60,3,0,1,0,1,0,0,0,0,0,'',0),
(290300115,101100,1,14,4982,'0',0,0,0,-1,0,0,1200,-4420,21.58,0.5,60,3,0,1,0,1,0,0,0,0,0,'',0),
(290300116,101100,1,14,4982,'0',0,0,0,-1,0,0,1178,-4405,21.72,2.4,60,3,0,1,0,1,0,0,0,0,0,'',0),
(290300117,101100,1,14,4982,'0',0,0,0,-1,0,0,1225,-4410,22.82,4.9,60,3,0,1,0,1,0,0,0,0,0,'',0),
(290300118,101100,1,14,4982,'0',0,0,0,-1,0,0,1270,-4410,26.09,1.1,60,3,0,1,0,1,0,0,0,0,0,'',0);

-- Vision : retiree des qu'on quitte la Durotar ou que l'objectif n'est plus en cours.
-- 40607 : posee par Allari (proxy 112731) une fois son savoir livre. 40983 : des l'acceptation.
DELETE FROM spell_area WHERE spell=81742;
INSERT INTO spell_area (spell,area,quest_start,quest_end,aura_spell,teamId,racemask,gender,flags,quest_start_status,quest_end_status) VALUES
(81742,14,40607,0,0,-1,0,2,2,8,0),
(81742,14,40983,0,0,-1,0,2,3,8,0);

DELETE FROM smart_scripts WHERE entryorguid=112731 AND source_type=0 AND id=1;
INSERT INTO smart_scripts (entryorguid,source_type,id,link,event_type,event_phase_mask,event_chance,event_flags,event_param1,event_param2,event_param3,event_param4,action_type,action_param1,action_param2,action_param3,action_param4,action_param5,action_param6,target_type,target_param1,target_param2,target_param3,target_x,target_y,target_z,target_o,comment)
VALUES (112731,0,1,0,10,0,100,0,1,10,2000,0,75,81742,0,0,0,0,0,7,0,0,0,0,0,0,0,'Proxy Parler a Allari - A vue hors combat - Vision d Allari (quete 40607)');

DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceGroup=2 AND SourceEntry=112731 AND SourceId=0;
INSERT INTO conditions (SourceTypeOrReferenceId,SourceGroup,SourceEntry,SourceId,ElseGroup,ConditionTypeOrReference,ConditionTarget,ConditionValue1,ConditionValue2,ConditionValue3,NegativeCondition,ErrorType,ErrorTextId,ScriptName,Comment) VALUES
(22,2,112731,0,0,9,0,40607,0,0,0,0,0,'','Vision d Allari : quete 40607 en cours'),
(22,2,112731,0,0,1,0,81742,0,0,1,0,0,'','Vision d Allari : pas deja active');
