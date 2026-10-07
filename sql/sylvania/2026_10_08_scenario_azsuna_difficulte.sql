-- Les apparitions du scenario d Azsuna (carte 1705) etaient en difficultes 1 et 12 ; la 1 est refusee
-- au chargement (170 avertissements a chaque demarrage). Rollback : remettre "1,12" sur les memes lignes.
UPDATE creature SET spawnDifficulties = "12" WHERE map = 1705 AND spawnDifficulties = "1,12";
