-- The Draenor profession books sold in Warspear and Stormshield taught no recipe:
-- spell_draenor_profession (the recipes of each book, as on Wowhead) was never bound to their spells.
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_draenor_profession';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(156614, 'spell_draenor_profession'), -- Draenor Alchemy
(161787, 'spell_draenor_profession'), -- Draenor Engineering
(161788, 'spell_draenor_profession'), -- Draenor Enchanting
(161789, 'spell_draenor_profession'), -- Draenor Inscription
(169923, 'spell_draenor_profession'), -- Draenor Blacksmithing
(169924, 'spell_draenor_profession'), -- Draenor Tailoring
(169925, 'spell_draenor_profession'), -- Draenor Leatherworking
(169926, 'spell_draenor_profession'); -- Draenor Jewelcrafting
