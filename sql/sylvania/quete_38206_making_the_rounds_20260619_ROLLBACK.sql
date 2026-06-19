-- Rollback quete 38206 "Making the Rounds" (2026-06-19)
-- NOTE: ne touche PAS la correction AIName de Rogers (96644) : la laisser
--   corrigee (sinon on re-casse le fix 38035). Pour re-casser volontairement :
--   UPDATE creature_template SET AIName='', ScriptName='SmartAI' WHERE entry=96644;
DELETE FROM creature WHERE guid BETWEEN 280001398 AND 280001402;
DELETE FROM smart_scripts WHERE entryorguid IN (96663,110712,-280001401,-280001402) AND source_type=0;
UPDATE creature_template SET AIName='' WHERE entry IN (96663,110712,92933);
