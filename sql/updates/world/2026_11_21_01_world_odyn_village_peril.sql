-- Campagne du guerrier : « Maw of Souls: Message to Helya » (43586) et « Will of the Valarjar » (44667) n avaient aucun
-- donneur chez nous ; Odyn (96469) les donne et les recoit (Wowhead). [LegionCore 4e4c380]
DELETE FROM `creature_queststarter` WHERE `id` = 96469 AND `quest` IN (43586, 44667);
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (96469, 43586), (96469, 44667);
-- A Village in Peril (Val sharah) : la version de Darcy Heathrow (38643) et celle de Theo the Huntsman (39149) menent a la
-- meme chaine, une seule des deux peut etre faite. [LegionCore 796eb54]
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 38643 WHERE `ID` IN (38643, 39149);
