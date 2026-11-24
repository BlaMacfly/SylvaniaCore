-- SmartAI portes le 24/11 (PNJ absents, objets) : chaines recollees apres les lignes rejetees au chargement (repliques, sorts ou trajets absents chez nous).
DELETE FROM smart_scripts WHERE entryorguid=1679 AND source_type=0 AND id=0; -- replique sans texte
DELETE FROM smart_scripts WHERE entryorguid=1679 AND source_type=0 AND id=1; -- replique sans texte
DELETE FROM smart_scripts WHERE entryorguid=2744 AND source_type=0 AND id=0; -- replique sans texte
DELETE FROM smart_scripts WHERE entryorguid=3940 AND source_type=0 AND id=0; -- replique sans texte
DELETE FROM smart_scripts WHERE entryorguid=3940 AND source_type=0 AND id=1; -- replique sans texte
DELETE FROM smart_scripts WHERE entryorguid=3940 AND source_type=0 AND id=2; -- replique sans texte
DELETE FROM smart_scripts WHERE entryorguid=13219 AND source_type=0 AND id=0; -- replique sans texte
DELETE FROM smart_scripts WHERE entryorguid=17360 AND source_type=0 AND id=0; -- replique sans texte
DELETE FROM smart_scripts WHERE entryorguid=17364 AND source_type=0 AND id=0; -- replique sans texte
DELETE FROM smart_scripts WHERE entryorguid=72623 AND source_type=0 AND id=0; -- replique sans texte
DELETE FROM smart_scripts WHERE entryorguid=72623 AND source_type=0 AND id=1; -- replique sans texte
UPDATE smart_scripts SET link=0 WHERE entryorguid=95893 AND source_type=0 AND id=0; -- saute la replique 1
DELETE FROM smart_scripts WHERE entryorguid=95893 AND source_type=0 AND id=1; -- replique sans texte
DELETE FROM smart_scripts WHERE entryorguid=97762 AND source_type=0 AND id=0; -- replique sans texte
DELETE FROM smart_scripts WHERE entryorguid=97766 AND source_type=0 AND id=0; -- replique sans texte
DELETE FROM smart_scripts WHERE entryorguid=98224 AND source_type=0 AND id=0; -- replique sans texte
DELETE FROM smart_scripts WHERE entryorguid=1965600 AND source_type=9 AND id=1; -- replique sans texte
DELETE FROM smart_scripts WHERE entryorguid=1965601 AND source_type=9 AND id=1; -- replique sans texte
UPDATE smart_scripts SET link=0 WHERE entryorguid=4857 AND source_type=2 AND id=0; -- lien vers une ligne absente
UPDATE smart_scripts SET link=0 WHERE entryorguid=4858 AND source_type=2 AND id=0; -- lien vers une ligne absente
UPDATE smart_scripts SET link=0 WHERE entryorguid=4860 AND source_type=2 AND id=0; -- lien vers une ligne absente
UPDATE smart_scripts SET link=0 WHERE entryorguid=45547 AND source_type=0 AND id=3; -- lien vers une ligne absente
UPDATE smart_scripts SET link=0 WHERE entryorguid=46496 AND source_type=0 AND id=0; -- lien vers une ligne absente
UPDATE smart_scripts SET link=0 WHERE entryorguid=55092 AND source_type=0 AND id=0; -- lien vers une ligne absente
UPDATE smart_scripts SET link=0 WHERE entryorguid=95893 AND source_type=0 AND id=0; -- lien vers une ligne absente
UPDATE smart_scripts SET link=0 WHERE entryorguid=98797 AND source_type=0 AND id=2; -- lien vers une ligne absente
UPDATE smart_scripts SET link=0 WHERE entryorguid=112472 AND source_type=0 AND id=1; -- lien vers une ligne absente
UPDATE smart_scripts SET link=0 WHERE entryorguid=112485 AND source_type=0 AND id=0; -- lien vers une ligne absente
UPDATE smart_scripts SET link=0 WHERE entryorguid=113077 AND source_type=0 AND id=0; -- lien vers une ligne absente
UPDATE smart_scripts SET link=0 WHERE entryorguid=113078 AND source_type=0 AND id=0; -- lien vers une ligne absente
