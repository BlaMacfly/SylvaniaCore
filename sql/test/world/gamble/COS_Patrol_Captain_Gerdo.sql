SET @GERDO := 104215;

UPDATE `creature_template` SET 
`ScriptName` = 'boss_patrol_captain_gerdo', 
`minLevel` = 112, 
`maxLevel` = 112, 
`faction` = 16,
`unit_class` = 4,
`unit_flags2` = `unit_flags2` |2048,
`mechanic_immune_mask` = `mechanic_immune_mask` |617299967
WHERE `entry` IN (@GERDO, 10421501, 10421502);

UPDATE `creature_template` SET 
`ScriptName` = 'npc_cos_streetsweeper',
`minLevel` = 112, 
`maxLevel` = 112,
`unit_flags` = 0,
`faction` = 14,
`InhabitType` = 1,
`flags_extra` = `flags_extra` |128
WHERE `entry` IN (110403, 11040301, 11040302);

UPDATE `creature_template` SET 
`ScriptName` = 'npc_cos_arcane_beacon',
`npcflag` = `npcflag` |16777216,
`type_flags` = `type_flags` |1048576|16,
`unit_flags` = `unit_flags` |2|256,
`IconName` = 'Pickup',
`minLevel` = 112, 
`maxLevel` = 112,
`faction` = 7,
`InhabitType` = 8
WHERE `entry` IN (104245, 10424501, 10424502);

UPDATE `creature_template` SET 
`faction` = 14,
`ScriptName` = 'npc_cos_vigilant_duskwatch',
`minLevel` = 112,
`maxLevel` = 112
WHERE `entry` IN (104918, 10491801, 10491802);

UPDATE `creature_template` SET
`faction` = 14,
`flags_extra` = `flags_extra` |128,
`minLevel` = 112,
`maxLevel` = 112,
`InhabitType` = 8
WHERE `entry` IN (104384, 10438401, 10438402);

DELETE FROM `npc_spellclick_spells` WHERE `npc_entry` = 104245;
INSERT INTO `npc_spellclick_spells` (`npc_entry`, `spell_id`, `cast_flags`, `user_type`) VALUES
(104245, 210253, 1, 0);

UPDATE `creature_template` SET 
`ScriptName` = 'npc_cos_flask_of_the_solemn_night',
`faction` = 7,
`npcflag` = `npcflag` |16777216,
`type_flags` = `type_flags` |1048576|16,
`unit_flags` = `unit_flags` |2|256,
`flags_extra` = `flags_extra` &~128,
`InhabitType` = 1
WHERE `entry` IN (105117, 10511701, 10511702);

DELETE FROM `spell_script_names` WHERE `spell_id` IN (207278, 207806, 219498);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(207278, 'spell_gerdo_arcane_lockdown'),
(207806, 'spell_gerdo_signal_beacon'),
(219498, 'spell_gerdo_streetsweeper_dmg');

DELETE FROM `areatrigger_template` WHERE `id` = 7870;
INSERT INTO `areatrigger_template` (`id`, `type`, `flags`, `Data0`, `Data1`, `Data2`,`Data3`, `ScriptName`) VALUES
(7870, 3, 4, 0, 0, 0, 0, '');

DELETE FROM `areatrigger_template_polygon_vertices` WHERE `AreaTriggerId` = 7870;
INSERT IGNORE INTO `areatrigger_template_polygon_vertices` (`AreaTriggerId`, `Idx`, `VerticeX`, `VerticeY`, `VerticeTargetX`, `VerticeTargetY`, `VerifiedBuild`) VALUES
(7870, 0, 0, 2.5, 0, 0, 23420),
(7870, 1, 0, -2.5, 0, 0, 23420),
(7870, 2, 150, -2.5, 0, 0, 23420),
(7870, 3, 150, 2.5, 0, 0, 23420);

DELETE FROM `spell_areatrigger` WHERE `SpellMiscId` = 7870;
INSERT INTO `spell_areatrigger` (`SpellMiscId`, `AreaTriggerId`, `MoveCurveId`, `ScaleCurveId`, `MorphCurveId`, `FacingCurveId`, `DecalPropertiesId`, `TimeToTarget`, `TimeToTargetScale`, `VerifiedBuild`) VALUES
(7870, 7870, 0, 0, 0, 0, 0, 0, 0, 23420);

DELETE FROM creature_text WHERE entry=104215;
INSERT INTO creature_text VALUES
(104215,0,0,'No trespassers allowed!',14,0,100,0,0,0,0,0,'SAY_AGGRO'),
(104215,1,0,'My watch... is ended',14,0,100,0,0,0,0,0,'SAY_DEATH'),
(104215,2,0,'Basely done... cowards!',14,0,100,0,0,0,0,0,'SAY_DEATH_SOLEMN_NIGHT'),
(104215,3,0,'Just what you deserved!',14,0,100,0,0,0,0,0,'SAY_PLAYER_KILL'),
(104215,3,1,'That should teach you!',14,0,100,0,0,0,0,0,'SAY_PLAYER_KILL'),
(104215,3,2,'A job well done!',14,0,100,0,0,0,0,0,'SAY_PLAYER_KILL'),
(104215,4,0,'Guards! To me!',14,0,100,0,0,0,0,0,'SAY_SIGNAL_BEACON'),
(104215,4,1,'I need reinforcements!',14,0,100,0,0,0,0,0,'SAY_SIGNAL_BEACON'),
(104215,5,0,'Stay were you are!',14,0,100,0,0,0,0,0,'SAY_ARCANE_LOCKDOWN'),
(104215,5,1,'Halt!',14,0,100,0,0,0,0,0,'SAY_ARCANE_LOCKDOWN'),
(104215,6,0,'This will even the odds!',14,0,100,0,0,0,0,0,'SAY_FLASH_OF_SOLEMN_NIGHT'),
(104215,7,0,'|TInterface\\Icons\\ability_socererking_arcaneacceleration|t%s begins to cast |cFFFF0000|Hspell:207278|h[Arcane Lockdown]|h|r! Jump to remove the effect!',41,0,100,0,0,0,0,0,'EMOTE_ARCANE_LOCKDOWN');
