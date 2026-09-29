-- Emmarel 102574 (phase 5934) recoit « Un serment d allegeance » (40955). La phase LegionCore la cache
-- des qu on a pris « Rise, Champions » (42519) : chez nous 42519 n a pas de prerequis, un joueur peut
-- la prendre avant d avoir rendu le serment (Blez, 29/09) et perd alors celle qui doit le recevoir.
-- Ajout : la phase reste active tant que 40955 est en cours ou terminee (non rendue).
DELETE FROM conditions WHERE SourceTypeOrReferenceId=26 AND SourceGroup=5934 AND ElseGroup IN (2,3);
INSERT INTO conditions (SourceTypeOrReferenceId,SourceGroup,SourceEntry,SourceId,ElseGroup,ConditionTypeOrReference,ConditionTarget,ConditionValue1,ConditionValue2,ConditionValue3,NegativeCondition,ErrorType,ErrorTextId,ScriptName,Comment) VALUES
(26,5934,7503,0,2,9,0,40955,0,0,0,0,0,"","Emmarel 102574 : visible tant que 40955 est en cours"),
(26,5934,7503,0,3,28,0,40955,0,0,0,0,0,"","Emmarel 102574 : visible tant que 40955 est terminee, non rendue");
