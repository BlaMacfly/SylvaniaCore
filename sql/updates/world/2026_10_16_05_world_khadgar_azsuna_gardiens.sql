-- Apparitions manquantes reprises d AshamaneCore, avec des GUID NEUFS chez nous (290400000+) ; leurs GUID ne sont pas
-- les notres. Verifie : aucune apparition de meme entree a moins de 15 m chez nous.

-- Archmage Khadgar (93337) a l entree d Azsuna, phase 4741 (AshamaneCore b73f5ac45b) : seul donneur de « Into the Fray »
-- 44137, il n avait aucune apparition chez nous. Visible tant que ni 38834 ni 44137 n est prise.
DELETE FROM `creature` WHERE `guid` = 290400000;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `PhaseId`, `PhaseGroup`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`) VALUES
(290400000, 93337, 1220, 7334, 7334, '0', 4741, 0, 0, 1, -79.12674, 6859.2212, 31.059425, 2.138637, 7200, 0, 0, 3765600, 950250, 0);
DELETE FROM `creature_equip_template` WHERE `CreatureID` = 93337 AND `ID` = 1;
INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `AppearanceModID1`, `ItemVisual1`, `ItemID2`, `AppearanceModID2`, `ItemVisual2`, `ItemID3`, `AppearanceModID3`, `ItemVisual3`, `VerifiedBuild`) VALUES
(93337, 1, 28067, 0, 0, 0, 0, 0, 0, 0, 0, 0);
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 26 AND `SourceGroup` = 4741 AND `SourceEntry` = 7334;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES
(26, 4741, 7334, 0, 0, 47, 0, 38834, 74, 0, 1, 'Phase 4741 (Khadgar) si Into the Fray 38834 non prise'),
(26, 4741, 7334, 0, 0, 47, 0, 44137, 74, 0, 1, 'Phase 4741 (Khadgar) si Into the Fray 44137 non prise');
DELETE FROM `phase_area` WHERE `AreaId` = 7334 AND `PhaseId` = 4741;
INSERT INTO `phase_area` (`AreaId`, `PhaseId`, `Comment`) VALUES (7334, 4741, 'Archmage Khadgar en Azsuna (Into the Fray)');

-- Gardiens des ames (6491) manquants a sept cimetieres (AshamaneCore 63657d36bd, releve TrinityCore)
DELETE FROM `creature` WHERE `guid` BETWEEN 290400001 AND 290400007;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnDifficulties`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `MovementType`) VALUES
(290400001, 6491, 530, '0', 0, 0, 6724.2768, -7935.263, 170.098, 5.784735, 72000, 0, 0),
(290400002, 6491, 530, '0', 0, 0, -1423.50, 4358.489, 241.566, 5.185481, 72000, 0, 0),
(290400003, 6491, 530, '0', 0, 0, -2438.868, 4665.473, 161.979, 4.648291, 72000, 0, 0),
(290400004, 6491, 571, '0', 0, 0, 8466.29, 442.502, 596.0717, 1.601781, 72000, 0, 0),
(290400005, 6491, 571, '0', 0, 0, 4686.022, 52.123, 73.449, 4.463720, 72000, 0, 0),
(290400006, 6491, 571, '0', 0, 0, 6445.856, 2062.501, 563.705, 5.488712, 72000, 0, 0),
(290400007, 6491, 571, '0', 0, 0, 2583.27, -5802.575, 295.615, 3.652452, 72000, 0, 0);
