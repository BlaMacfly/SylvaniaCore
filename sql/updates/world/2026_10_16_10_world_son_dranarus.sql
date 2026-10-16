-- Capitaine Dranarus : son 9739 joue a toute la carte ; datalong2 = 2 le rend dependant de la distance
-- (TrinityCore f7bb1d899d, #19427, via AshamaneCore 7dd1c94cb9).
UPDATE `waypoint_scripts` SET `datalong2` = 2 WHERE `id` = 14 AND `command` = 16 AND `datalong` = 9739;
