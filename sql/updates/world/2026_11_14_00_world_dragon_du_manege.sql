-- Carousel Dragon (Darkmoon Island) could not be ridden: no spellclick npcflag (TrinityCore master, LegionCore),
-- vehicle of LegionCore (7.3.5).
UPDATE `creature_template` SET `npcflag`=`npcflag`|16777216, `VehicleId`=2587 WHERE `entry`=68231;
