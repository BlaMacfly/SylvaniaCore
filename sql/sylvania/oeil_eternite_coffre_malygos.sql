-- L'Oeil de l'eternite (carte 616) - Malygos ne lachait aucun butin.
-- Base : dc_world. Rejouable. Signalement du 16/10/2026 (le baltring).
--
-- Malygos n'a pas de table de butin : son butin est le coffre « Don d'Alexstrasza » (193905 en 10,
-- 193967 en 25). Chaine (boss_malygos.cpp, identique a TrinityCore 3.3.5) : a la mort, Malygos
-- invoque Alexstrasza (32295) ; elle vole jusqu'au point 788 1276 246.9 et lance le Rayon du don
-- (61028) sur le PNJ invisible 32448 ; l'aura 61023 (spell_alexstrasza_gift_beam_visual) invoque le
-- coffre et le rend cliquable a sa fin. Chez nous Alexstrasza n'avait AUCUNE IA (AIName vide) :
-- ni rayon, ni coffre, ni dialogue. SmartAI reprise de LegionCore (lc_world_ref) ; les textes
-- (creature_text 32295) et la condition de ciblage (13/1/61028 -> 32448) existaient deja.

UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = 32295;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 32295 AND `source_type` = 0) OR (`entryorguid` = 3229500 AND `source_type` = 9);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`event_param_string`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(32295,0,0,0,54,0,100,0,0,0,0,0,0,'',69,1,0,0,0,0,0,8,0,0,0,788.07,1276.09,246.9,0,'Alexstrasza - On just summoned - Move to pos'),
(32295,0,1,0,34,0,100,0,8,1,0,0,0,'',80,3229500,2,0,0,0,0,1,0,0,0,0,0,0,0,'Alexstrasza - On point 1 reached - Start actionlist'),
(3229500,9,0,0,0,0,100,0,0,0,0,0,0,'',11,61028,0,0,0,0,0,1,0,0,0,0,0,0,0,'Alexstrasza - Action 0 - Cast Gift Beam'),
(3229500,9,1,0,0,0,100,0,4000,4000,0,0,0,'',1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Alexstrasza - Action 1 - Yell 0'),
(3229500,9,2,0,0,0,100,0,6000,6000,0,0,0,'',1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Alexstrasza - Action 2 - Yell 1'),
(3229500,9,3,0,0,0,100,0,5000,5000,0,0,0,'',1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Alexstrasza - Action 3 - Yell 2'),
(3229500,9,4,0,0,0,100,0,24000,24000,0,0,0,'',1,3,0,0,0,0,0,1,0,0,0,0,0,0,0,'Alexstrasza - Action 4 - Yell 3');

-- Alexstrasza posee en permanence (guid 357466) exactement au point ou Malygos l'invoque a sa mort
-- (AlexstraszaSpawnPos 854.551 1225.31 300.901) : doublon d'une invocation, absent chez LegionCore.
DELETE FROM `creature_addon` WHERE `guid` = 357466;
DELETE FROM `creature` WHERE `guid` = 357466;

-- Retour arriere : sauvegarde db-backups/oeil-eternite-avant-*.sql (creature + creature_addon 357466,
-- creature_template 32295) ; DELETE FROM `smart_scripts` WHERE `entryorguid` IN (32295, 3229500);
