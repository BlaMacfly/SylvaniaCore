-- Annule l application PARTIELLE de 2026_10_07_assaut_valsharah.sql (arretee par un doublon de calque :
-- (7558, 6160) existait deja, porte d une session precedente). Ne touche qu a ce que ce fichier avait ajoute.
DELETE FROM creature WHERE guid BETWEEN 290319491 AND 290319691;
DELETE FROM gameobject WHERE guid BETWEEN 210313779 AND 210313790;
DELETE FROM phase_area WHERE AreaId = 7558 AND Comment LIKE "Assaut de la Legion%";
