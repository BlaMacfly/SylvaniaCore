-- Bienfaits du Pelerin (fete 404) : deux dates de la ligne hotfix tombaient en fevrier (champ du mois faux).
-- Le dimanche avant Thanksgiving, comme les annees precedentes : 21/11/2027 et 19/11/2028, 10 h.
UPDATE `holidays` SET `Date11` = 463813248 WHERE `ID` = 404 AND `Date11` = 454376064;
UPDATE `holidays` SET `Date12` = 480557696 WHERE `ID` = 404 AND `Date12` = 471136896;
