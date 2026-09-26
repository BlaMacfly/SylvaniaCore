DELETE FROM spell_script_names
WHERE spell_id IN (108194, 221562)
   OR ScriptName = 'spell_dk_asphyxiate';

INSERT INTO spell_script_names
(spell_id,ScriptName)
VALUES
(108194,'spell_dk_asphyxiate'),
(221562,'spell_dk_asphyxiate');DELETE FROM spell_script_names
WHERE spell_id IN (194913, 195975)
  AND ScriptName IN (
    'spell_dk_glacial_advance',
    'spell_dk_glacial_advance_damage_filter'
  );

INSERT INTO spell_script_names (spell_id, ScriptName) VALUES
(194913, 'spell_dk_glacial_advance'),
(195975, 'spell_dk_glacial_advance_damage_filter');