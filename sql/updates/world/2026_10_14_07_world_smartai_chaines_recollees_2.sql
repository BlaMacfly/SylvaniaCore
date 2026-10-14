-- SmartAI portes le 14/10 : chaines recollees apres les lignes rejetees au chargement (repliques sans texte chez nous).
DELETE FROM smart_scripts WHERE entryorguid=60973 AND source_type=0 AND id=5; -- replique sans texte
DELETE FROM smart_scripts WHERE entryorguid=60973 AND source_type=0 AND id=10; -- replique sans texte
DELETE FROM smart_scripts WHERE entryorguid=64259 AND source_type=0 AND id=5; -- replique sans texte
UPDATE smart_scripts SET event_type=52, event_phase_mask=0, event_chance=100, event_flags=0, event_param1=0, event_param2=113300, event_param3=0, event_param4=0 WHERE entryorguid=113300 AND source_type=0 AND id=3; -- reprend le declencheur de la replique 2
DELETE FROM smart_scripts WHERE entryorguid=113300 AND source_type=0 AND id=2; -- replique sans texte
