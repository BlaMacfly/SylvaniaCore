-- Options de dialogue reservees a une quete « terminee » (condition 28) que nos donnees posaient sur une quete
-- « en cours » (condition 9). Ces quetes se terminent des l'acceptation (objet de depart = seul objectif) :
-- l'option n'apparaissait jamais. Ex. : Vlagga Fileplume (18930), « Send me to Thrallmar! » pour « En route pour
-- Thrallmar » (10289). Lignes reprises a l'identique de la TDB 7.3.5.
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND ((`SourceGroup`=7938 AND `SourceEntry`=1) OR (`SourceGroup`=7967 AND `SourceEntry`=4) OR (`SourceGroup`=8081 AND `SourceEntry`=0) OR (`SourceGroup`=9143 AND `SourceEntry`=0));
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(15,7938,1,0,0,28,0,10289,0,0,0,0,0,'','Show gossip option 1 if player has complete quest Journey to Thrallmar'),
(15,7967,4,0,0,28,0,10242,0,0,0,0,0,'','Show gossip option 4 if player has Quest 10242 "Spinebreaker Post"'),
(15,8081,0,0,0,28,0,10286,0,0,0,0,0,'','Show gossip option 0 if player has quest Arelion''s Secret completed OR'),
(15,8081,0,0,1,8,0,10286,0,0,0,0,0,'','Show gossip option 0 if player has quest Arelion''s Secret rewarded'),
(15,9143,0,0,0,28,0,11542,0,0,0,0,0,'','Show gossip option if player has quest 11542 complete OR'),
(15,9143,0,0,1,28,0,11543,0,0,0,0,0,'','Show gossip option if player has quest 11543 complete');
