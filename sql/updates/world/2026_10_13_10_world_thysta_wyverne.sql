-- DB/Quests: To Hardwrench Hideaway (29236) se termine, d'apres Titans-Project (1348088a).
-- Son objectif (credit 52762, Arrived at Hardwrench Hideaway) n'etait donne par rien : la quete et toute la suite (29237, 29238)
-- etaient bloquees. Comme au retail, Thysta (1387, Grom'gol) propose la wyverne quand la quete est en cours, donne le credit
-- et envoie le joueur par le trajet 2246. Le menu 6944 est partage par les maitres de vol : l'option ne s'affiche que chez Thysta.
DELETE FROM `gossip_menu_option` WHERE `MenuId` = 6944 AND `OptionIndex` = 2;
INSERT INTO `gossip_menu_option` (`MenuId`, `OptionIndex`, `OptionIcon`, `OptionText`, `OptionBroadcastTextId`, `OptionType`, `OptionNpcFlag`, `VerifiedBuild`) VALUES
(6944, 2, 0, 'I need use of a wyvern to fly me to where the Darkspear emissary went.', 51628, 1, 1, 0);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = 6944 AND `SourceEntry` = 2;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 6944, 2, 0, 0, 9, 0, 29236, 0, 0, 0, 0, 0, '', 'Thysta, wyverne vers Hardwrench : quete To Hardwrench Hideaway en cours'),
(15, 6944, 2, 0, 0, 31, 1, 3, 1387, 0, 0, 0, 0, '', 'Thysta, wyverne vers Hardwrench : seulement chez Thysta');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 1387 AND `source_type` = 0 AND `id` IN (3, 4, 5);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `target_type`, `comment`) VALUES
(1387, 0, 3, 4, 62, 0, 100, 0, 6944, 2, 0, 0, 33, 52762, 0, 0, 7, 'Thysta - On Gossip Option 2 Selected - Quest Credit Arrived at Hardwrench Hideaway'),
(1387, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 7, 'Thysta - On Gossip Option 2 Selected - Close Gossip'),
(1387, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 52, 2246, 0, 0, 7, 'Thysta - On Gossip Option 2 Selected - Fly to Hardwrench Hideaway');
