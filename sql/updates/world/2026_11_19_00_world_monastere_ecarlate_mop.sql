-- Monastere ecarlate refait (carte 1004) : scripts LegionCore de Thalnos, Korloff, Blanchetete et Durand.
-- Blanchetete restait bloquee a 1 % (script classique qui attendait Mograine, absent de la carte 1004).
-- Les Esprits surpuissants sont des invocations de Thalnos : les 18 poses en dur patrouillaient au niveau 33-92.

UPDATE `creature_template` SET `ScriptName`='boss_thalnos_the_soulrender' WHERE `entry`=59789;
UPDATE `creature_template` SET `ScriptName`='npc_empowering_spirit' WHERE `entry`=59893;
UPDATE `creature_template` SET `ScriptName`='npc_fallen_crusader' WHERE `entry`=59884;
UPDATE `creature_template` SET `ScriptName`='npc_empowered_zombie' WHERE `entry`=59930;
UPDATE `creature_template` SET `ScriptName`='boss_brother_korloff' WHERE `entry`=59223;
UPDATE `creature_template` SET `ScriptName`='npc_korloff_training_dummy' WHERE `entry`=64446;
UPDATE `creature_template` SET `ScriptName`='npc_commander_durand' WHERE `entry`=60040;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_scarlet_judicator' WHERE `entry`=58605;
DELETE FROM `smart_scripts` WHERE `entryorguid`=58605 AND `source_type`=0;

DELETE FROM `areatrigger_scripts` WHERE `entry`=7496;
INSERT INTO `areatrigger_scripts` (`entry`,`ScriptName`) VALUES (7496,'at_enter_durand_room');

DELETE FROM `spell_script_names` WHERE `spell_id`=114460 AND `ScriptName`='spell_korloff_scorched_earth';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES (114460,'spell_korloff_scorched_earth');

-- Cibles (LegionCore) : Resurrection de masse -> Judicateurs, Esprit surpuissant -> Croises dechus,
-- Resurrection ecarlate -> Durand (en plus de Mograine pour l ancienne carte)
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry` IN (113134,115157);
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=9232 AND `ConditionValue2`=60040;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,1,113134,0,0,31,0,3,58605,0,0,0,0,'','Mass Resurrection - Scarlet Judicator'),
(13,1,115157,0,0,31,0,3,59884,0,0,0,0,'','Empowering Spirit - Fallen Crusader'),
(13,3,9232,0,1,31,0,3,60040,0,0,0,0,'','Scarlet Resurrection - Commander Durand');

-- Textes : BroadcastText officiels (groupes de LegionCore)
DELETE FROM `creature_text` WHERE `CreatureID` IN (3977,60040,59789,59223);
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`,`TextRange`,`comment`) VALUES
(3977,0,0,'You shall pay for this treachery!',14,0,100,0,0,29616,2973,0,'High Inquisitor Whitemane - Aggro'),
(3977,1,0,'Arise, my champion!',14,0,100,0,0,5840,6532,0,'High Inquisitor Whitemane - Resurrect Durand'),
(3977,2,0,'Mograine...',14,0,100,0,0,29617,66876,0,'High Inquisitor Whitemane - Death'),
(60040,0,0,'To think you''ve come so far, only to perish here. I''ll honor you with clean deaths.',14,0,100,0,0,27529,63305,0,'Commander Durand - Intro'),
(60040,1,0,'My legend begins NOW!',14,0,100,0,0,27527,63304,0,'Commander Durand - Aggro'),
(60040,2,0,'But... my legend!',14,0,100,0,0,27528,63303,0,'Commander Durand - Fall'),
(59789,0,0,'Destroy the Piles of Corpses to stop the Zombified Corpses!',41,0,100,0,0,0,61734,0,'Thalnos the Soulrender - Raise Fallen Crusader'),
(59789,1,0,'My endless agony shall be yours, as well!',14,0,100,0,0,27832,63265,0,'Thalnos the Soulrender - Aggro'),
(59789,2,0,'No rest... for the angry dead!',14,0,100,0,0,27831,63271,0,'Thalnos the Soulrender - Empowering Spirits'),
(59789,3,0,'Can this be... the end, at last...?',14,0,100,0,0,27830,63267,0,'Thalnos the Soulrender - Death'),
(59223,0,0,'I will break you.',14,0,100,0,0,29496,63297,0,'Brother Korloff - Aggro'),
(59223,1,0,'You are like... piece of iron...',14,0,100,0,0,29497,66586,0,'Brother Korloff - Death');

-- Invocations sans mise a l echelle (niveau tire entre 32/33 et 90/92) : echelle de la carte (28-60)
DELETE FROM `creature_template_scaling` WHERE `Entry` IN (59884,59893,59930,59974,64827,60106,60107);
INSERT INTO `creature_template_scaling` (`Entry`,`LevelScalingMin`,`LevelScalingMax`,`LevelScalingDeltaMin`,`LevelScalingDeltaMax`,`VerifiedBuild`) VALUES
(59884,28,60,0,0,0),(59893,28,60,0,0,0),(59930,28,60,0,0,0),(59974,28,60,0,0,0),
(64827,28,60,0,0,0),(60106,28,60,0,0,0),(60107,28,60,0,0,0);

DELETE FROM `creature_addon` WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `id`=59893 AND `map`=1004);
DELETE FROM `creature` WHERE `id`=59893 AND `map`=1004;
