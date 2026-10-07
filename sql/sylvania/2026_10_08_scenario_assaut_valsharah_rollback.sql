-- Annule 2026_10_08_scenario_assaut_valsharah.sql
DELETE FROM scenarios WHERE map=1704;
DELETE FROM creature WHERE guid BETWEEN 290320124 AND 290320285;
UPDATE creature_template SET AIName = '', ScriptName = '' WHERE entry = 117833;
UPDATE creature_template SET AIName = '', ScriptName = '' WHERE entry = 117838;
UPDATE creature_template SET AIName = '', ScriptName = '' WHERE entry = 117908;
UPDATE creature_template SET AIName = '', ScriptName = '' WHERE entry = 117909;
UPDATE creature_template SET AIName = '', ScriptName = '' WHERE entry = 117930;
UPDATE creature_template SET AIName = '', ScriptName = '' WHERE entry = 118180;
UPDATE creature_template SET AIName = '', ScriptName = '' WHERE entry = 118183;
UPDATE creature_template SET AIName = '', ScriptName = '' WHERE entry = 118426;
UPDATE creature_template SET AIName = '', ScriptName = '' WHERE entry = 118687;
UPDATE creature_template SET AIName = '', ScriptName = '' WHERE entry = 118749;
DELETE FROM smart_scripts WHERE source_type=0 AND entryorguid IN (117908,117909,118180,118426);
DELETE FROM npc_spellclick_spells WHERE npc_entry IN (117930,118630,118687);
DELETE FROM creature_queststarter WHERE id=118183 AND quest=45856;
DELETE FROM creature_questender WHERE id=118440 AND quest=45856;
DELETE FROM conditions WHERE SourceTypeOrReferenceId=19 AND SourceEntry=45856;
