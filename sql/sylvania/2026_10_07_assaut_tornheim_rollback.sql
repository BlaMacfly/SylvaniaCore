-- Annule 2026_10_07_assaut_tornheim.sql
DELETE FROM creature WHERE guid BETWEEN 290319833 AND 290319953;
DELETE FROM phase_area WHERE AreaId=7541 AND Comment LIKE 'Assaut de la Legion%';
DELETE FROM conditions WHERE SourceTypeOrReferenceId=26 AND SourceEntry=7541 AND Comment LIKE 'Assaut tornheim :%';
DELETE FROM quest_poi WHERE QuestID IN (45786,46011,46012,46179,46216,46264);
DELETE FROM quest_poi_points WHERE QuestID IN (45786,46011,46012,46179,46216,46264);
DELETE FROM world_quest WHERE id IN (45786,46011,46012,46179,46216,46264);
