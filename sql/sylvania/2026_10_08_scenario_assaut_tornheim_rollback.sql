-- Annule 2026_10_08_scenario_assaut_tornheim.sql
DELETE FROM scenarios WHERE map=1707;
DELETE FROM creature WHERE guid BETWEEN 290320466 AND 290320726;
DELETE FROM gameobject WHERE guid BETWEEN 210313805 AND 210313805;
UPDATE creature_template SET AIName = '', ScriptName = '' WHERE entry = 116868;
UPDATE creature_template SET AIName = '', ScriptName = '' WHERE entry = 118789;
UPDATE creature_template SET AIName = '', ScriptName = '' WHERE entry = 118838;
UPDATE creature_template SET AIName = '', ScriptName = '' WHERE entry = 118859;
UPDATE creature_template SET AIName = '', ScriptName = '' WHERE entry = 119016;
UPDATE creature_template SET AIName = '', ScriptName = '' WHERE entry = 119196;
UPDATE creature_template SET AIName = '', ScriptName = '' WHERE entry = 119200;
UPDATE creature_template SET AIName = '', ScriptName = '' WHERE entry = 119201;
DELETE FROM smart_scripts WHERE source_type=0 AND entryorguid IN (118838,119016);
DELETE FROM npc_spellclick_spells WHERE npc_entry IN (118789,118833,118835,118858,118859,119200,119201,119224,119225,120380,120381,120382);
DELETE FROM creature_queststarter WHERE id=116868 AND quest=46110;
DELETE FROM creature_questender WHERE id=118781 AND quest=46110;
DELETE FROM conditions WHERE SourceTypeOrReferenceId=19 AND SourceEntry=46110;
