-- fix - corect saronite arrows mob drop
DELETE FROM `creature_questitem` WHERE `CreatureEntry`=28766 AND `Idx`=0;
DELETE FROM `creature_questitem` WHERE `CreatureEntry`=28576 AND `Idx`=0;
INSERT INTO `creature_questitem` (`CreatureEntry`, `Idx`, `ItemId`, `VerifiedBuild`) 
VALUES (28576, 0, 39160, 25549);
DELETE FROM `creature_questitem` WHERE `CreatureEntry`=28577 AND `Idx`=0;
INSERT INTO `creature_questitem` (`CreatureEntry`, `Idx`, `ItemId`, `VerifiedBuild`) 
VALUES (28577, 0, 39160, 25549);

-- fix - scarlet infantryman agro
UPDATE creature_template SET flags_extra='0' WHERE entry IN (28609);