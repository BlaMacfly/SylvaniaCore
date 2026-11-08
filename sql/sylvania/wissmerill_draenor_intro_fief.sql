-- Signalement Wisstiti / Wissmerill (guid 339), 08/11/2026 - trois quetes Draenor (Horde)
-- Sauvegarde : ~/db-backups/wissmerill-draenor-20261108_100123/

-- ---------------------------------------------------------------------------
-- 1) 34420 « Le prix de la guerre » (The Cost of War) - Tanaan, carte 1265
-- Le C++ npc_archmage_khadgar (tanaan_intro_global.cpp, « 78558/78559 ») joue la scene 806
-- a l'acceptation ; playerScript_cost_of_war valide la quete a la fin de la scene.
-- Il n'etait rattache a aucun PNJ (log du boot : « Script named 'npc_archmage_khadgar' does
-- not have a script name assigned »). Sans lui : spell_area retire la phase 173 (Khadgar
-- donneur) des que la quete est prise, la scene ne joue jamais, la quete ne se valide pas,
-- donc la phase 182 (Khadgar receveur, aire 7041) n'apparait jamais.
-- Effet au prochain demarrage (liaison des ScriptName figee au boot).
UPDATE `creature_template` SET `ScriptName`='npc_archmage_khadgar' WHERE `entry` IN (78558,78559) AND `ScriptName`='';

-- ---------------------------------------------------------------------------
-- 2) 34824 « Ce que nous avons » (What We Got) - objectif « Examiner la cache du fief »
-- Arbre 41325 -> critere 27157 (type 28, etre la cible du sort 173847) ; le cache 237191
-- (goober, sort 178479 -> force 173847) n'avait AUCUNE apparition dans le fief Horde.
-- Positions LegionCore (lc_world_ref.gameobject 129572/106735/130621/106902/106644), Z verifie
-- par mapheight.py ; quaternion recalcule depuis l'orientation (LC : 0,0,0,1).
DELETE FROM `gameobject` WHERE `guid` BETWEEN 290400401 AND 290400405;
INSERT INTO `gameobject` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`,`isActive`,`ScriptName`,`VerifiedBuild`) VALUES
(290400401,237191,1152,7004,7096,'1',0,0,0,-1,5569.71,4500.63,131.508,0.601347,0,0,0.296164,0.955137,7200,255,1,0,'',0), -- Horde niveau 1 (Gelfrimas)
(290400402,237191,1153,7004,7103,'1',0,0,0,-1,5593.19,4589.77,136.62,0.218651,0,0,0.109108,0.99403,7200,255,1,0,'',0),  -- Horde niveau 2
(290400403,237191,1330,7004,7210,'1',0,0,0,-1,5590.86,4595.55,136.587,6.07954,0,0,0.101647,-0.994821,7200,255,1,0,'',0), -- Horde niveau 3
(290400404,236916,1159,7078,7086,'1',0,0,0,-1,1946.55,292.625,88.9659,3.72107,0,0,0.958319,-0.285702,7200,255,1,0,'',0), -- Alliance niveau 2
(290400405,237722,1331,7078,7211,'1',0,0,0,-1,1947.87,291.875,88.9659,3.59205,0,0,0.974743,-0.223329,7200,255,1,0,'',0); -- Alliance niveau 3

-- ---------------------------------------------------------------------------
-- 3) 36594 « Pieces "detachees" » ("Spare" Parts) - 50 Pieces de canon de siege (116430)
-- a) Butin indexe sur l'entree 236043 au lieu de Data1 = 55758 : correctif LegionCore
--    sql/updates/world/2024_11_15_gameobject_loot_template_chest_fixes.sql (ligne 835).
UPDATE `gameobject_loot_template` SET `Entry`=55758 WHERE `Entry`=236043 AND `Item`=116430;
-- b) Les Debris de canon en fer (236043-236045) n'ont d'apparition nulle part (ni chez nous,
--    ni LC, ni TDB 7.3.5 / 1200) : ils apparaissent quand on lance les outils de Blixthraz
--    (116645, sort 171604 « Lance une bombe explosive sur un Canon de siege de fer », qui
--    declenche 171603 « Rapid Disassembly Tag », effet DUMMY) sur un Canon de siege de fer
--    85820, qui explose (commentaires Wowhead de la quete). Pins Wowhead des debris = positions
--    des 3 canons. Aucun script de reference : mecanique reconstruite au plus simple.
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry` IN (171603,171604);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,1,171604,0,0,31,0,3,85820,0,0,0,0,'','Rapid Disassembly - cible Iron Siege Cannon'),
(13,1,171603,0,0,31,0,3,85820,0,0,0,0,'','Rapid Disassembly Tag - cible Iron Siege Cannon');

UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=85820 AND `AIName`='' AND `ScriptName`='';
-- Le canon lance les trois sorts officiels de projection des debris (DB2 SpellEffect) :
-- 171668 -> 171667 (invoque 236043), 171671 -> 171670 (236044), 171665 -> 171663 (236045),
-- chacun TRIGGER_MISSILE vers un point aleatoire autour du lanceur, debris 60 s ; puis il disparait
-- (reapparition 300 s, spawntimesecs). Le chargeur SmartAI signale lui-meme ces sorts d'invocation.
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (-1415595,-1415606,-1415607,85820) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`event_param_string`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(85820,0,0,1,8,0,100,0,171603,0,0,0,0,'',11,171668,2,0,0,0,0,1,0,0,0,0,0,0,0,'Iron Siege Cannon - Rapid Disassembly Tag - Debris 236043'),
(85820,0,1,2,61,0,100,0,0,0,0,0,0,'',11,171671,2,0,0,0,0,1,0,0,0,0,0,0,0,'Iron Siege Cannon - Rapid Disassembly Tag - Debris 236044'),
(85820,0,2,3,61,0,100,0,0,0,0,0,0,'',11,171665,2,0,0,0,0,1,0,0,0,0,0,0,0,'Iron Siege Cannon - Rapid Disassembly Tag - Debris 236045'),
(85820,0,3,0,61,0,100,0,0,0,0,0,0,'',41,3000,0,0,0,0,0,1,0,0,0,0,0,0,0,'Iron Siege Cannon - Rapid Disassembly Tag - Disparait (reapparition 300 s)');
