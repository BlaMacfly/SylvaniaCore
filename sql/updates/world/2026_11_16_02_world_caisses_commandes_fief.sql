-- Fief WoD : 16 caisses de commandes de travail etaient des objets decoratifs (type 5, VerifiedBuild 15595),
-- on ne pouvait pas y recolter. Type 45 et conteneur repris de LegionCore (236643 et 237665 identiques dans la TDB master),
-- conteneurs coherents avec CharShipmentContainer (metier et faction).
UPDATE `gameobject_template` SET `type`=45, `displayId`=15585, `Data0`=31 WHERE `entry`=236638; -- Alchemy Work Order (Alliance)
UPDATE `gameobject_template` SET `type`=45, `displayId`=15585, `Data0`=49 WHERE `entry`=236641; -- Blacksmithing Work Order (Alliance)
UPDATE `gameobject_template` SET `type`=45, `displayId`=15585, `Data0`=52 WHERE `entry`=236643; -- Enchanting Work Order (Alliance)
UPDATE `gameobject_template` SET `type`=45, `displayId`=15585, `Data0`=54 WHERE `entry` IN (236649,236650); -- Inscription Work Order (Alliance)
UPDATE `gameobject_template` SET `type`=45, `displayId`=15585, `Data0`=51 WHERE `entry` IN (236652,236683); -- Jewelcrafting Work Order (Alliance)
UPDATE `gameobject_template` SET `type`=45, `displayId`=15585, `Data0`=50 WHERE `entry` IN (236684,236948); -- Leatherworking Work Order (Alliance)
UPDATE `gameobject_template` SET `type`=45, `displayId`=20508, `Data0`=61 WHERE `entry`=237064; -- Inscription Work Order (Horde)
UPDATE `gameobject_template` SET `type`=45, `displayId`=20508, `Data0`=63 WHERE `entry`=237104; -- Leatherworking Work Order (Horde)
UPDATE `gameobject_template` SET `type`=45, `displayId`=20508, `Data0`=58 WHERE `entry`=237127; -- Blacksmithing Work Order (Horde)
UPDATE `gameobject_template` SET `type`=45, `displayId`=20508, `Data0`=60 WHERE `entry`=237142; -- Engineering Work Order (Horde)
UPDATE `gameobject_template` SET `type`=45, `displayId`=20508, `Data0`=64 WHERE `entry`=237186; -- Tailoring Work Order (Horde)
UPDATE `gameobject_template` SET `type`=45, `displayId`=15585, `Data0`=37 WHERE `entry` IN (237665,237666); -- Tailoring Work Order (Alliance)
