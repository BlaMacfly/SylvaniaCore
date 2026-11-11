-- The Hexweave Cloth work order of the Horde (Turga, 79863) was set on the Alliance garrison site (2):
-- no work order could be started in a Horde Tailoring Emporium, nor "Your First Tailoring Work Order" (37575) done
UPDATE `garrison_shipment` SET `SiteID`=71 WHERE `ContainerID`=64 AND `NpcEntry`=79863 AND `SiteID`=2;
