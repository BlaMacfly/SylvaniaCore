-- Péninsule des Flammes infernales (repris de LegionCore, identique à TrinityCore)
-- 10087 « Brûlez-les... pour la Horde ! » : la torche (33067) touchait les engins de siège invisibles,
-- mais ces repères n'avaient aucun script : jamais de crédit.
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` IN (18849, 19008);
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (18849, 19008) AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`event_param_string`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(18849,0,0,0,8,0,100,0,33067,0,0,0,0,'',33,18849,0,0,0,0,0,7,0,0,0,0,0,0,0,'Invis Alliance Siege Engine - East - On Spellhit Flaming Torch - Quest Credit'),
(19008,0,0,0,8,0,100,0,33067,0,0,0,0,'',33,19008,0,0,0,0,0,7,0,0,0,0,0,0,0,'Invis Alliance Siege Engine - West - On Spellhit Flaming Torch - Quest Credit');

-- 10813 « Les yeux de Grillok » : au chaudron, l'aura de l'œil (38495) lance 38530 sur le repère 22177 ;
-- le repère attendait 38554 (le sort qui absorbe l'œil, lancé loin de là) : jamais de crédit.
UPDATE `smart_scripts` SET `event_param1` = 38530 WHERE `entryorguid` = 22177 AND `source_type` = 0 AND `id` = 0 AND `event_type` = 8;
