-- spell_script_names
DELETE FROM `spell_script_names` WHERE `spell_id`=15290;

DELETE FROM `spell_proc` WHERE `SpellId`=15286;
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `SpellFamilyMask3`, `ProcFlags`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES
(15286, 0, 0, 0, 0, 0, 0, 2424832, 0, 1, 0, 0, 0, 0, 0, 0);
