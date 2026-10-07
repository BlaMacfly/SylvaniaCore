-- Annule 2026_10_08_scenario_assaut_hautroc.sql
DELETE FROM scenarios WHERE map=1706;
DELETE FROM creature WHERE guid BETWEEN 290320286 AND 290320465;
DELETE FROM gameobject WHERE guid BETWEEN 210313798 AND 210313804;
UPDATE creature_template SET AIName = '', ScriptName = '' WHERE entry = 119676;
UPDATE creature_template SET AIName = '', ScriptName = '' WHERE entry = 119850;
UPDATE creature_template SET AIName = '', ScriptName = '' WHERE entry = 119855;
UPDATE creature_template SET AIName = '', ScriptName = '' WHERE entry = 119857;
UPDATE creature_template SET AIName = '', ScriptName = '' WHERE entry = 119981;
UPDATE creature_template SET AIName = '', ScriptName = '' WHERE entry = 119994;
UPDATE creature_template SET AIName = '', ScriptName = '' WHERE entry = 120048;
UPDATE creature_template SET AIName = '', ScriptName = '' WHERE entry = 120081;
DELETE FROM npc_spellclick_spells WHERE npc_entry IN (117451,119855,119857,119974,119981,119994,120048,120965);
DELETE FROM creature_queststarter WHERE id=119676 AND quest=46182;
DELETE FROM creature_questender WHERE id=119944 AND quest=46182;
DELETE FROM conditions WHERE SourceTypeOrReferenceId=19 AND SourceEntry=46182;
