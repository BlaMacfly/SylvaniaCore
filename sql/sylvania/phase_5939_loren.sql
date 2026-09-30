-- Pavillon du Traqueur, phase 5939 (Loren Stormhoof 107315, Emmarel 107317...) : coupee des que 42395 est
-- rendue. Un joueur en avance (42395 rendue avant d avoir recrute Loren) perdait Loren, donneur de
-- « Champion: Loren Stormhoof » (42409) -- Blez, 01/10/2026. Phase maintenue apres Rise, Champions (42519)
-- tant que Loren n est pas recrute.
DELETE FROM conditions WHERE SourceTypeOrReferenceId=26 AND SourceGroup=5939 AND ElseGroup IN (3,4);
INSERT INTO conditions (SourceTypeOrReferenceId,SourceGroup,SourceEntry,SourceId,ElseGroup,ConditionTypeOrReference,ConditionTarget,ConditionValue1,ConditionValue2,ConditionValue3,NegativeCondition,ErrorType,ErrorTextId,ScriptName,Comment) VALUES
(26,5939,7503,0,3,8,0,42519,0,0,0,0,0,"","Loren visible : Rise, Champions rendue"),
(26,5939,7503,0,3,8,0,42409,0,0,1,0,0,"","... et Loren pas encore recrute"),
(26,5939,7503,0,4,28,0,42519,0,0,0,0,0,"","Loren visible : Rise, Champions terminee"),
(26,5939,7503,0,4,8,0,42409,0,0,1,0,0,"","... et Loren pas encore recrute");
