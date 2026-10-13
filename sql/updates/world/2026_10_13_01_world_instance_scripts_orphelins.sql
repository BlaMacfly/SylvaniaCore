-- DB/World: deux instances tournaient sans script d instance alors que le C++ existe et vise leur carte
-- (le serveur les liste au demarrage comme "Script named ... does not have a script name assigned").
-- Mines de Rochesang (1175) : les 5 boss ont leur script mais tournaient avec instance == nullptr,
-- donc etat des rencontres jamais enregistre. Le SQL amont visait 'instance_bloodmaul_slag_mines',
-- nom qui n existe pas dans le C++.
UPDATE `instance_template` SET `script` = 'instance_Bloodmaul' WHERE `map` = 1175;
-- Retour a Karazhan (1651) : instance encore vide, rattachement pour quand elle sera peuplee.
UPDATE `instance_template` SET `script` = 'instance_new_karazhan' WHERE `map` = 1651;
