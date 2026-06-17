-- item_script_names
DELETE FROM `item_script_names` WHERE `Id`=147432;
INSERT INTO `item_script_names` (`Id`, `ScriptName`) VALUES
(147432, 'loot_item_champion_equipment_147432');

-- spell_script_names
DELETE FROM `spell_script_names` WHERE `spell_id`=262946;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(262946, 'spell_synthesize_legendary');