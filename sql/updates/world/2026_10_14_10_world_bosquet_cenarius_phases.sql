-- Bosquet de Cenarius (Val'sharah, zone 7601) : Elothir et Koda Griffe-d'Acier n'apparaissent qu'aux etapes officielles
-- Source : Krigsgaldrnet/AshamaneCore 2026_09_28_00 et _01 (memes GUID que chez nous, entree verifiee dans la clause).
-- Ecarte : leur _02 (Ysera 98584 cachee des la prise de 38663 alors qu'elle en est la destinataire chez nous).

UPDATE `creature` SET `PhaseId`=4571 WHERE `guid`=20535552 AND `id`=91496; -- Elothir
UPDATE `creature` SET `PhaseId`=4570 WHERE `guid`=20535553 AND `id`=91042; -- Koda Griffe-d'Acier

DELETE FROM `phase_area` WHERE `AreaId`=7601 AND `PhaseId` IN (4570,4571);
INSERT INTO `phase_area` (`AreaId`, `PhaseId`, `Comment`) VALUES
(7601, 4571, 'Cosmetic - Elothir - Grove of Cenarius'),
(7601, 4570, 'Cosmetic - Koda Steelclaw - Grove of Cenarius');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=26 AND `SourceGroup` IN (4570,4571) AND `SourceEntry`=7601;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES
(26, 4571, 7601, 0, 1, 47, 0, 38322, 64, 0, 0, 'Phase 4571 (Elothir) si Return to the Grove (38322) rendue'),
(26, 4571, 7601, 0, 1, 47, 0, 38663, 64, 0, 1, 'Phase 4571 (Elothir) si The Die is Cast (38663) non rendue'),
(26, 4570, 7601, 0, 1, 47, 0, 38147, 64, 0, 0, 'Phase 4570 (Koda) si Entangled Dreams (38147) rendue'),
(26, 4570, 7601, 0, 1, 47, 0, 38663, 64, 0, 1, 'Phase 4570 (Koda) si The Die is Cast (38663) non rendue');
