-- sister mercy ship problems with vmaps
/*
SELECT * FROM gameobject_template WHERE entry IN (187038);
SELECT * FROM gameobject_template_addon WHERE entry IN (187038); -- flags 1048616
SELECT * FROM creature_template WHERE entry IN (23826, 24973, 24992, 24911, 25026, 24914);
SELECT * FROM creature_template_addon WHERE entry IN (23826, 24973, 24992, 24911, 25026, 24914);
SELECT * FROM creature WHERE id IN (23826, 24973, 24992, 24911, 25026, 24914);
SELECT * FROM creature_addon WHERE guid IN (SELECT guid FROM creature WHERE id IN (23826, 24973, 24992, 24911, 25026, 24914));
SELECT * FROM smart_scripts where entryorguid IN(23826, 24973, 24992, 24911, 25026, 24914);
*/