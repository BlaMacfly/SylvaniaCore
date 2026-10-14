-- SmartAI portes le 14/10 : chaines recollees apres les lignes rejetees au chargement (repliques sans texte chez nous).
UPDATE smart_scripts SET event_type=62, event_phase_mask=0, event_chance=100, event_flags=0, event_param1=10567, event_param2=1, event_param3=0, event_param4=0 WHERE entryorguid=3467 AND source_type=0 AND id=2; -- reprend le declencheur de la replique 1
DELETE FROM smart_scripts WHERE entryorguid=3467 AND source_type=0 AND id=1; -- replique sans texte
DELETE FROM smart_scripts WHERE entryorguid=36297 AND source_type=0 AND id=10; -- replique sans texte
DELETE FROM smart_scripts WHERE entryorguid=36958 AND source_type=0 AND id=0; -- replique sans texte
DELETE FROM smart_scripts WHERE entryorguid=36958 AND source_type=0 AND id=1; -- replique sans texte
DELETE FROM smart_scripts WHERE entryorguid=36958 AND source_type=0 AND id=2; -- replique sans texte
UPDATE smart_scripts SET link=0 WHERE entryorguid=36958 AND source_type=0 AND id=5; -- saute la replique 6
DELETE FROM smart_scripts WHERE entryorguid=36958 AND source_type=0 AND id=6; -- replique sans texte
DELETE FROM smart_scripts WHERE entryorguid=39326 AND source_type=0 AND id=2; -- replique sans texte
UPDATE smart_scripts SET event_type=62, event_phase_mask=0, event_chance=100, event_flags=1, event_param1=11759, event_param2=0, event_param3=0, event_param4=0 WHERE entryorguid=43659 AND source_type=0 AND id=3; -- reprend le declencheur de la replique 2
DELETE FROM smart_scripts WHERE entryorguid=43659 AND source_type=0 AND id=2; -- replique sans texte
UPDATE smart_scripts SET event_type=62, event_phase_mask=0, event_chance=100, event_flags=1, event_param1=11760, event_param2=0, event_param3=0, event_param4=0 WHERE entryorguid=43660 AND source_type=0 AND id=3; -- reprend le declencheur de la replique 2
DELETE FROM smart_scripts WHERE entryorguid=43660 AND source_type=0 AND id=2; -- replique sans texte
UPDATE smart_scripts SET event_type=62, event_phase_mask=0, event_chance=100, event_flags=1, event_param1=11761, event_param2=0, event_param3=0, event_param4=0 WHERE entryorguid=43661 AND source_type=0 AND id=1; -- reprend le declencheur de la replique 0
DELETE FROM smart_scripts WHERE entryorguid=43661 AND source_type=0 AND id=0; -- replique sans texte
UPDATE smart_scripts SET link=4 WHERE entryorguid=46425 AND source_type=0 AND id=2; -- saute la replique 3
DELETE FROM smart_scripts WHERE entryorguid=46425 AND source_type=0 AND id=3; -- replique sans texte
UPDATE smart_scripts SET link=8 WHERE entryorguid=46425 AND source_type=0 AND id=6; -- saute la replique 7
DELETE FROM smart_scripts WHERE entryorguid=46425 AND source_type=0 AND id=7; -- replique sans texte
UPDATE smart_scripts SET link=3 WHERE entryorguid=60973 AND source_type=0 AND id=1; -- saute la replique 2
DELETE FROM smart_scripts WHERE entryorguid=60973 AND source_type=0 AND id=2; -- replique sans texte
UPDATE smart_scripts SET link=0 WHERE entryorguid=60973 AND source_type=0 AND id=2; -- saute la replique 3
DELETE FROM smart_scripts WHERE entryorguid=60973 AND source_type=0 AND id=3; -- replique sans texte
UPDATE smart_scripts SET event_type=52, event_phase_mask=0, event_chance=100, event_flags=0, event_param1=1, event_param2=60973, event_param3=0, event_param4=0 WHERE entryorguid=60973 AND source_type=0 AND id=5; -- reprend le declencheur de la replique 4
DELETE FROM smart_scripts WHERE entryorguid=60973 AND source_type=0 AND id=4; -- replique sans texte
UPDATE smart_scripts SET link=7 WHERE entryorguid=60973 AND source_type=0 AND id=5; -- saute la replique 6
DELETE FROM smart_scripts WHERE entryorguid=60973 AND source_type=0 AND id=6; -- replique sans texte
DELETE FROM smart_scripts WHERE entryorguid=60973 AND source_type=0 AND id=8; -- replique sans texte
UPDATE smart_scripts SET event_type=52, event_phase_mask=0, event_chance=100, event_flags=0, event_param1=4, event_param2=60973, event_param3=0, event_param4=0 WHERE entryorguid=60973 AND source_type=0 AND id=10; -- reprend le declencheur de la replique 9
DELETE FROM smart_scripts WHERE entryorguid=60973 AND source_type=0 AND id=9; -- replique sans texte
DELETE FROM smart_scripts WHERE entryorguid=62774 AND source_type=0 AND id=9; -- replique sans texte
DELETE FROM smart_scripts WHERE entryorguid=62774 AND source_type=0 AND id=10; -- replique sans texte
DELETE FROM smart_scripts WHERE entryorguid=64259 AND source_type=0 AND id=3; -- replique sans texte
UPDATE smart_scripts SET event_type=52, event_phase_mask=0, event_chance=100, event_flags=0, event_param1=0, event_param2=64259, event_param3=0, event_param4=0 WHERE entryorguid=64259 AND source_type=0 AND id=5; -- reprend le declencheur de la replique 4
DELETE FROM smart_scripts WHERE entryorguid=64259 AND source_type=0 AND id=4; -- replique sans texte
DELETE FROM smart_scripts WHERE entryorguid=90916 AND source_type=0 AND id=0; -- replique sans texte
DELETE FROM smart_scripts WHERE entryorguid=92195 AND source_type=0 AND id=2; -- replique sans texte
DELETE FROM smart_scripts WHERE entryorguid=92458 AND source_type=0 AND id=1; -- replique sans texte
DELETE FROM smart_scripts WHERE entryorguid=93526 AND source_type=0 AND id=6; -- replique sans texte
DELETE FROM smart_scripts WHERE entryorguid=93526 AND source_type=0 AND id=8; -- replique sans texte
DELETE FROM smart_scripts WHERE entryorguid=93620 AND source_type=0 AND id=0; -- replique sans texte
DELETE FROM smart_scripts WHERE entryorguid=96979 AND source_type=0 AND id=2; -- replique sans texte
DELETE FROM smart_scripts WHERE entryorguid=96979 AND source_type=0 AND id=3; -- replique sans texte
DELETE FROM smart_scripts WHERE entryorguid=96979 AND source_type=0 AND id=4; -- replique sans texte
UPDATE smart_scripts SET link=7 WHERE entryorguid=104369 AND source_type=0 AND id=1; -- saute la replique 2
DELETE FROM smart_scripts WHERE entryorguid=104369 AND source_type=0 AND id=2; -- replique sans texte
UPDATE smart_scripts SET event_type=62, event_phase_mask=0, event_chance=100, event_flags=0, event_param1=19519, event_param2=0, event_param3=0, event_param4=0 WHERE entryorguid=104394 AND source_type=0 AND id=1; -- reprend le declencheur de la replique 0
DELETE FROM smart_scripts WHERE entryorguid=104394 AND source_type=0 AND id=0; -- replique sans texte
DELETE FROM smart_scripts WHERE entryorguid=105760 AND source_type=0 AND id=1; -- replique sans texte
DELETE FROM smart_scripts WHERE entryorguid=113300 AND source_type=0 AND id=0; -- replique sans texte
UPDATE smart_scripts SET event_type=52, event_phase_mask=0, event_chance=100, event_flags=0, event_param1=0, event_param2=113300, event_param3=0, event_param4=0 WHERE entryorguid=113300 AND source_type=0 AND id=2; -- reprend le declencheur de la replique 1
DELETE FROM smart_scripts WHERE entryorguid=113300 AND source_type=0 AND id=1; -- replique sans texte
UPDATE smart_scripts SET link=2 WHERE entryorguid=120533 AND source_type=0 AND id=0; -- saute la replique 1
DELETE FROM smart_scripts WHERE entryorguid=120533 AND source_type=0 AND id=1; -- replique sans texte
UPDATE smart_scripts SET event_type=19, event_phase_mask=0, event_chance=100, event_flags=0, event_param1=46941, event_param2=0, event_param3=0, event_param4=0 WHERE entryorguid=120533 AND source_type=0 AND id=6; -- reprend le declencheur de la replique 5
DELETE FROM smart_scripts WHERE entryorguid=120533 AND source_type=0 AND id=5; -- replique sans texte
DELETE FROM smart_scripts WHERE entryorguid=124070 AND source_type=0 AND id=2; -- replique sans texte
DELETE FROM smart_scripts WHERE entryorguid=124312 AND source_type=0 AND id=1; -- replique sans texte
DELETE FROM smart_scripts WHERE entryorguid=124312 AND source_type=0 AND id=5; -- replique sans texte
UPDATE smart_scripts SET link=0 WHERE entryorguid=6334 AND source_type=2 AND id=0; -- lien vers une ligne absente
UPDATE smart_scripts SET link=0 WHERE entryorguid=36958 AND source_type=0 AND id=5; -- lien vers une ligne absente
UPDATE smart_scripts SET link=0 WHERE entryorguid=46425 AND source_type=0 AND id=2; -- lien vers une ligne absente
UPDATE smart_scripts SET link=0 WHERE entryorguid=46425 AND source_type=0 AND id=6; -- lien vers une ligne absente
UPDATE smart_scripts SET link=0 WHERE entryorguid=46991 AND source_type=0 AND id=4; -- lien vers une ligne absente
UPDATE smart_scripts SET link=0 WHERE entryorguid=52225 AND source_type=0 AND id=6; -- lien vers une ligne absente
UPDATE smart_scripts SET link=0 WHERE entryorguid=52978 AND source_type=0 AND id=6; -- lien vers une ligne absente
UPDATE smart_scripts SET link=0 WHERE entryorguid=60973 AND source_type=0 AND id=1; -- lien vers une ligne absente
UPDATE smart_scripts SET link=0 WHERE entryorguid=60973 AND source_type=0 AND id=5; -- lien vers une ligne absente
UPDATE smart_scripts SET link=0 WHERE entryorguid=62774 AND source_type=0 AND id=1; -- lien vers une ligne absente
UPDATE smart_scripts SET link=0 WHERE entryorguid=103733 AND source_type=0 AND id=0; -- lien vers une ligne absente
UPDATE smart_scripts SET link=0 WHERE entryorguid=104369 AND source_type=0 AND id=1; -- lien vers une ligne absente
UPDATE smart_scripts SET link=0 WHERE entryorguid=120533 AND source_type=0 AND id=0; -- lien vers une ligne absente
