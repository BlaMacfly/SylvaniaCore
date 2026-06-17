-- Class Trial: Fix BattlePay store for character boost unlock
-- Client hardcodes WOW_SERVICES_CATEGORY_ID = 22 for boost products

-- 1. Fix product group: Services must use GroupID=22 (client requirement)
UPDATE `battlepay_product_group` SET `GroupID`=22 WHERE `GroupID`=3;
UPDATE `battlepay_shop_entry` SET `GroupID`=22 WHERE `GroupID`=3;

-- 2. Fix product 110 (Level 100 boost): add price and WebsiteType
UPDATE `battlepay_product` SET `NormalPriceFixedPoint`=100, `CurrentPriceFixedPoint`=100, `WebsiteType`=29, `DisplayInfoID`=109 WHERE `ProductID`=110;

-- 3. Add Level 110 Character Boost product
INSERT INTO `battlepay_display_info` (`DisplayInfoId`, `CreatureDisplayInfoID`, `FileDataID`, `Flags`, `Name1`, `Name2`, `Name3`, `Name4`)
VALUES (111, 614740, 614740, 0, 'Level 110 Character Boost', '', 'Instantly boost a character to level 110 with a full set of gear, ready for the Broken Isles.', '')
ON DUPLICATE KEY UPDATE `Name1`=VALUES(`Name1`), `Name3`=VALUES(`Name3`);

INSERT INTO `battlepay_product` (`ProductID`, `NormalPriceFixedPoint`, `CurrentPriceFixedPoint`, `Type`, `ChoiceType`, `Flags`, `DisplayInfoID`, `ScriptName`, `ClassMask`, `WebsiteType`)
VALUES (111, 150, 150, 0, 2, 0, 111, 'battlepay_service_level110', 0, 29)
ON DUPLICATE KEY UPDATE `NormalPriceFixedPoint`=VALUES(`NormalPriceFixedPoint`), `CurrentPriceFixedPoint`=VALUES(`CurrentPriceFixedPoint`), `WebsiteType`=VALUES(`WebsiteType`);

-- 4. Add shop entry for Level 110 boost in Services group (GroupID=22)
INSERT INTO `battlepay_shop_entry` (`EntryID`, `GroupID`, `ProductID`, `Ordering`, `Flags`, `BannerType`, `DisplayInfoID`)
VALUES (111, 22, 111, 15, 0, 0, 0)
ON DUPLICATE KEY UPDATE `GroupID`=VALUES(`GroupID`);
