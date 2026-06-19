-- Rollback quete 38035 fix (2026-06-19)
DELETE FROM smart_scripts WHERE entryorguid=96644 AND source_type=0;
UPDATE creature_template SET ScriptName='' WHERE entry=96644;
