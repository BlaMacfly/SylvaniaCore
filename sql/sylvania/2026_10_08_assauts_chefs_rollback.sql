-- Annule 2026_10_08_assauts_chefs.sql
DELETE FROM creature WHERE guid BETWEEN 290320727 AND 290320732;
DELETE FROM phase_area WHERE AreaId=7558 AND PhaseId=6209 AND Comment='Assaut de la Legion - chefs valsharah';
DELETE FROM conditions WHERE SourceTypeOrReferenceId=26 AND SourceEntry=7558 AND SourceGroup=6209 AND Comment LIKE 'Assaut valsharah : chefs%';
DELETE FROM phase_area WHERE AreaId=7503 AND PhaseId=6210 AND Comment='Assaut de la Legion - chefs hautroc';
DELETE FROM conditions WHERE SourceTypeOrReferenceId=26 AND SourceEntry=7503 AND SourceGroup=6210 AND Comment LIKE 'Assaut hautroc : chefs%';
DELETE FROM phase_area WHERE AreaId=7541 AND PhaseId=6214 AND Comment='Assaut de la Legion - chefs tornheim';
DELETE FROM conditions WHERE SourceTypeOrReferenceId=26 AND SourceEntry=7541 AND SourceGroup=6214 AND Comment LIKE 'Assaut tornheim : chefs%';
UPDATE creature_template SET npcflag = 0 WHERE entry = 118183;
UPDATE creature_template SET npcflag = 0 WHERE entry = 118440;
UPDATE creature_template SET npcflag = 0 WHERE entry = 119676;
UPDATE creature_template SET npcflag = 0 WHERE entry = 119944;
UPDATE creature_template SET npcflag = 0 WHERE entry = 116868;
UPDATE creature_template SET npcflag = 0 WHERE entry = 118781;
