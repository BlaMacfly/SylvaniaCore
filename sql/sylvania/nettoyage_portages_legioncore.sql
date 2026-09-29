-- Nettoyage apres les portages de campagnes de domaine (30/09/2026) :
-- 2 spawns d entrees propres a LegionCore (>= 400000) et 246 objets dont le modele n existe pas
-- chez nous. Tous etaient deja refuses au chargement (« non existing ... entry »). A REPRENDRE :
-- 77 modeles d objets des campagnes manquent dans gameobject_template (LegionCore les a).
DELETE FROM creature WHERE guid IN (290306567,290308062) AND id>=400000;
DELETE FROM gameobject WHERE guid>=210300217 AND id NOT IN (SELECT entry FROM gameobject_template);
