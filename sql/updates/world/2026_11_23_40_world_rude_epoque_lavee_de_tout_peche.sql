-- Couture « Rude epoque » (38948, Lyndras) : la robe en soie tachee (127038) et les bandelettes glissefiel (127039)
-- ne tombaient presque jamais. Nos taux (0,06 a 6 %) sont ceux de Wowhead, comptes sur TOUTES les victimes, porteurs
-- de la quete ou non ; 5 des 16 PNJ n'avaient meme pas l'objet. Repris de LegionCore : 50 % pour les porteurs de la quete.
DELETE FROM `creature_loot_template` WHERE `Item` IN (127038,127039);
INSERT INTO `creature_loot_template` (`Entry`,`Item`,`Reference`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(88084,127039,0,50,1,1,0,1,1,'Hatecoil Raider - Glidefin Bandages (38948)'),
(88086,127039,0,50,1,1,0,1,1,'Hatecoil Riptail - Glidefin Bandages (38948)'),
(88087,127039,0,50,1,1,0,1,1,'Hatecoil Stormcaller - Glidefin Bandages (38948)'),
(88089,127039,0,50,1,1,0,1,1,'Hatecoil Enchantress - Glidefin Bandages (38948)'),
(89024,127039,0,50,1,1,0,1,1,'Hatecoil Fathom-Stalker - Glidefin Bandages (38948)'),
(89025,127039,0,50,1,1,0,1,1,'Hatecoil Spitespeaker - Glidefin Bandages (38948)'),
(89199,127039,0,50,1,1,0,1,1,'Lady Sssurine - Glidefin Bandages (38948)'),
(90109,127039,0,50,1,1,0,1,1,'Hatecoil Slavemaster - Glidefin Bandages (38948)'),
(89801,127038,0,50,1,1,0,1,1,'Withered Scavenger - Stained Silk Robe (38948)'),
(90318,127038,0,50,1,1,0,1,1,'Withered Fanatic - Stained Silk Robe (38948)'),
(90379,127038,0,50,1,1,0,1,1,'Withered Exile - Stained Silk Robe (38948)'),
(90380,127038,0,50,1,1,0,1,1,'Withered Mana-Rager - Stained Silk Robe (38948)'),
(90389,127038,0,50,1,1,0,1,1,'Ishkaneth - Stained Silk Robe (38948)'),
(90390,127038,0,50,1,1,0,1,1,'Tyndrissen - Stained Silk Robe (38948)'),
(90616,127038,0,50,1,1,0,1,1,'Nightfallen Overseer - Stained Silk Robe (38948)'),
(109826,127038,0,50,1,1,0,1,1,'Nightfallen Hungerer - Stained Silk Robe (38948)');

-- Enchantement « Lavee de tout peche » (40130) : l'objectif « Rituel purificateur observe » est le credit de la
-- Pretresse dechue 98683, qui attend a la source de Nor'danil. Elle n'etait pas posee, et n'avait ni dialogue ni IA.
-- Repris de LegionCore : apparition, option de dialogue (quete en cours), replique, credit, transformation et visuel.
-- Fin de quete inchangee : Pretresse Driana (98698), comme sur Wowhead.
SET @C := (SELECT MAX(guid) FROM creature);
DELETE FROM `creature` WHERE `id`=98683;
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`dynamicflags`,`ScriptName`,`VerifiedBuild`) VALUES
(@C+1,98683,1220,7334,7341,'0',0,0,0,-1,0,0,310.703,7431.42,145.533,1.59591,300,0,0,0,0,0,0,0,0,0,0,'',0);

UPDATE `creature_template` SET `npcflag`=3, `gossip_menu_id`=98683, `AIName`='SmartAI' WHERE `entry`=98683;

DELETE FROM `gossip_menu_option` WHERE `MenuId`=98683;
INSERT INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES
(98683,0,0,'It''s time to begin.',100420,1,1,0);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=98683;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(15,98683,0,0,0,9,0,40130,0,0,0,0,0,'','Pretresse dechue : option si la quete 40130 est en cours');

DELETE FROM `creature_text` WHERE `CreatureID`=98683;
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`,`TextRange`,`comment`) VALUES
(98683,0,0,'Elune, grant me the blessing of your purity one last time.',12,0,100,0,0,0,100422,0,'Fallen Priestess - rituel');

DELETE FROM `smart_scripts` WHERE `entryorguid`=98683 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(98683,0,0,0,62,0,100,0,98683,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Fallen Priestess - On Gossip Select - Say Line 0'),
(98683,0,1,0,62,0,100,0,98683,0,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,4.69631,'Fallen Priestess - On Gossip Select - Set Orientation'),
(98683,0,2,0,62,0,100,0,98683,0,0,0,33,98683,0,0,0,0,0,7,0,0,0,0,0,0,0,'Fallen Priestess - On Gossip Select - Quest Credit'),
(98683,0,3,0,62,0,100,0,98683,0,0,0,3,0,65952,0,0,0,0,1,0,0,0,0,0,0,0,'Fallen Priestess - On Gossip Select - Morph to Driana'),
(98683,0,4,0,62,0,100,0,98683,0,0,0,11,132157,0,0,0,0,0,1,0,0,0,0,0,0,0,'Fallen Priestess - On Gossip Select - Cast Visual'),
(98683,0,5,0,62,0,100,0,98683,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Fallen Priestess - On Gossip Select - Close Gossip');
