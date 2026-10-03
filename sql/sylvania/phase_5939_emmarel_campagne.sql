-- Emmarel « campagne » du Pavillon (107317, phase 5939) disparaissait trop tot : la condition ajoutee le
-- 01/10 (« jusqu au recrutement de Loren ») la coupait alors qu elle recoit encore 42384 Rapport de
-- reconnaissance, 42388, 42393 et donne le recrutement d Hilaire et Rexxar (Blez, 03/10/2026).
-- Elle reste desormais jusqu a 42399 Ready to Work, apres quoi l Emmarel 107973 (phase 5955) prend sa place
-- au meme endroit -- et recoit aussi ses quetes, pour qu aucune ne reste orpheline au relais.
DELETE FROM conditions WHERE SourceTypeOrReferenceId=26 AND SourceGroup=5939 AND ElseGroup IN (3,4);
INSERT INTO conditions (SourceTypeOrReferenceId,SourceGroup,SourceEntry,SourceId,ElseGroup,ConditionTypeOrReference,ConditionTarget,ConditionValue1,ConditionValue2,ConditionValue3,NegativeCondition,ErrorType,ErrorTextId,ScriptName,Comment) VALUES
(26,5939,7503,0,3,8,0,42519,0,0,0,0,0,"","Emmarel 107317 : Rise, Champions rendue"),
(26,5939,7503,0,3,8,0,42399,0,0,1,0,0,"","... jusqu a Ready to Work (relais par 107973)"),
(26,5939,7503,0,4,28,0,42519,0,0,0,0,0,"","Emmarel 107317 : Rise, Champions terminee"),
(26,5939,7503,0,4,8,0,42399,0,0,1,0,0,"","... jusqu a Ready to Work (relais par 107973)");
INSERT IGNORE INTO creature_queststarter (id,quest) VALUES (107973,40957),(107973,41540),(107973,42385),(107973,42389),(107973,42390);
INSERT IGNORE INTO creature_questender (id,quest) VALUES (107973,40957),(107973,42384),(107973,42388),(107973,42393);
