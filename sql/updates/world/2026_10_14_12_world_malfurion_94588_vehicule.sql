-- Malfurion 94588 (cavalier du cerf 91465, quete 40122) : VehicleId=91465 etait une entree collee par erreur
-- (« non-existing VehicleId (91465). This *WILL* cause the client to freeze! » a chaque demarrage). LegionCore : 0.
UPDATE `creature_template` SET `VehicleId`=0 WHERE `entry`=94588 AND `VehicleId`=91465;
-- Accessoire du cerf : sbire qui disparait avec lui, comme chez LegionCore
UPDATE `vehicle_template_accessory` SET `minion`=1, `summontype`=8 WHERE `entry`=91465 AND `accessory_entry`=94588;
