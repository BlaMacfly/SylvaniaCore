-- Seigneur Walden (Donjon d Ombrecroc) : l emote permanente 69 (travailler debout) restait jouee en combat.
-- LegionCore n a pas d addon sur cette apparition.
UPDATE `creature_addon` SET `emote`=0 WHERE `guid`=325939;
