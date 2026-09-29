-- On Eagle s Wings (40953) exigeait 40952 Hunter to Hunter, qui n est que la fin du parcours
-- Precision. Les chasseurs Maitrise des betes finissent par l autre variante 41009, et la Survie
-- par 40385 The Spear in the Shadow (rendue aussi a Emmarel) : ils etaient bloques.
-- Signalement joueur (Blez, BM) le 29/09/2026. LegionCore n a pas ce prerequis.
UPDATE quest_template_addon SET PrevQuestID=0, AllowableClasses=4 WHERE ID=40953;
DELETE FROM conditions WHERE SourceTypeOrReferenceId=19 AND SourceEntry=40953;
INSERT INTO conditions (SourceTypeOrReferenceId,SourceGroup,SourceEntry,SourceId,ElseGroup,ConditionTypeOrReference,ConditionTarget,ConditionValue1,ConditionValue2,ConditionValue3,NegativeCondition,ErrorType,ErrorTextId,ScriptName,Comment) VALUES
(19,0,40953,0,0,8,0,40952,0,0,0,0,0,"","On Eagle s Wings : apres Hunter to Hunter (Precision)"),
(19,0,40953,0,1,8,0,41009,0,0,0,0,0,"","On Eagle s Wings : apres Hunter to Hunter (Maitrise des betes)"),
(19,0,40953,0,2,8,0,40385,0,0,0,0,0,"","On Eagle s Wings : apres The Spear in the Shadow (Survie)");
