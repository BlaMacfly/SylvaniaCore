DELETE FROM `spell_proc` WHERE `SpellId` = 78203;
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `ProcFlags`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`) VALUES
(78203, 0, 6, 32768, 0, 0, 327680, 1, 2, 2);

DELETE FROM `spell_script_names` WHERE `spell_id`=78203;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(78203, 'spell_pri_shadowy_apparitions');