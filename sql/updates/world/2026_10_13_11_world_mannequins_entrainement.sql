-- DB/Creature: les mannequins d'entrainement de Dalaran, des domaines de classe et du fief n'avaient aucun script (113 apparitions) :
-- ils perdaient leur vie et mouraient comme une creature ordinaire. Meme liste que LegionCore (18 entrees, aucune n'est une cible de quete).
UPDATE `creature_template` SET `ScriptName` = 'npc_training_dummy' WHERE `ScriptName` = '' AND `entry` IN
(48304, 87320, 87322, 87329, 92164, 92165, 92166, 108420, 113858, 113859, 113860, 113862, 113863, 113864, 113871, 113966, 114832, 114840);
