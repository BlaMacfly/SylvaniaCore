-- =====================================================================
-- Mascottes de combat : « On The Mend » / soin chez le maitre d'ecurie
-- Signalement Discord : Murog (Orgrimmar) ouvre directement la boutique
-- au lieu du dialogue, la quete 31589 est donc impossible a valider.
--
-- Cause : les maitres d'ecurie n'exposent pas (ou n'implementent pas)
-- l'option de gossip « I'd like to heal and revive my battle pets. ».
--   * Murog (47764) et Jaelysia (10085) n'ont aucun gossip_menu_id :
--     ils retombent sur le menu 0 par defaut, dont la seule option
--     compatible pour un non-chasseur est « vendeur » -> le client 7.3.5
--     selectionne automatiquement l'unique option et ouvre la boutique.
--   * Le menu 9821 (menu standard des maitres d'ecurie) a perdu ses
--     options « vendeur » et « ecurie » : seule l'option de soin restait.
--   * Seuls 2 maitres d'ecurie sur 12 avaient le SmartAI qui soigne les
--     mascottes et donne le credit de quete.
--   * Le credit de Jenova Stoneshield (Hurlevent) pointait sur le credit
--     d'Elwynn (64320) au lieu de celui de Hurlevent (65214).
--
-- Applique le 2026-09-10. Rollback : battlepet_stablemaster_heal_ROLLBACK.sql
-- =====================================================================

-- ---------------------------------------------------------------------
-- 1. Menu 9821 : restaurer les options vendeur et ecurie
--    (l'option 2 « heal and revive my battle pets » existe deja)
-- ---------------------------------------------------------------------
DELETE FROM `gossip_menu_option` WHERE `MenuId`=9821 AND `OptionIndex` IN (0,4);
INSERT INTO `gossip_menu_option`
    (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES
    (9821, 0, 0, 'I\'d like to stable my pet here.', 8912, 14, 4194304, 0),
    (9821, 4, 1, 'I want to browse your goods.',     3370,  3,     128, 0);

-- ---------------------------------------------------------------------
-- 2. Menu 12106 (Bezzil, maitre d'ecurie gobelin) : meme jeu d'options
-- ---------------------------------------------------------------------
UPDATE `gossip_menu_option` SET `OptionType`=14, `OptionNpcFlag`=4194304
    WHERE `MenuId`=12106 AND `OptionIndex`=0;
DELETE FROM `gossip_menu_option` WHERE `MenuId`=12106 AND `OptionIndex` IN (2,3);
INSERT INTO `gossip_menu_option`
    (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES
    (12106, 2, 0, 'I\'d like to heal and revive my battle pets.', 64115, 1,   1, 0),
    (12106, 3, 1, 'I want to browse your goods.',                  3370, 3, 128, 0);

-- ---------------------------------------------------------------------
-- 3. PNJ mal configures
-- ---------------------------------------------------------------------
-- Murog (Orgrimmar) et Jaelysia (Sombrivage) : aucun menu de gossip
UPDATE `creature_template` SET `gossip_menu_id`=9821 WHERE `entry` IN (47764,10085);
-- Seriadne (Teldrassil) : npcflag ampute de GOSSIP et STABLEMASTER
UPDATE `creature_template` SET `npcflag`=`npcflag`|4194305 WHERE `entry`=10051;

-- ---------------------------------------------------------------------
-- 4. SmartAI : soigner + ressusciter les mascottes et donner le credit
-- ---------------------------------------------------------------------
UPDATE `creature_template` SET `AIName`='SmartAI'
    WHERE `entry` IN (6749,9980,9987,10050,10051,10085,16185,17485,45789,47764);

-- Correction du credit de Jenova Stoneshield : Hurlevent (65214), pas Elwynn
UPDATE `smart_scripts` SET `action_param1`=65214, `comment`='Stable Master - Link - Quest Credit 31592'
    WHERE `source_type`=0 AND `entryorguid`=11069 AND `id`=2;

DELETE FROM `smart_scripts`
    WHERE `source_type`=0 AND `entryorguid` IN (6749,9980,9987,10050,10051,10085,16185,17485,45789,47764);
INSERT INTO `smart_scripts`
    (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,
     `event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`event_param_string`,
     `action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,
     `target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
-- Erma (Foret d'Elwynn) - quete 31309
( 6749,0,0,1,62,0,100,0, 9821,2,0,0,0,'', 85,125801,2,0,0,0,0, 7,0,0,0,0,0,0,0,'Erma - Gossip Select - Cast Heal Battle Pets'),
( 6749,0,1,2,61,0,100,0,    0,0,0,0,0,'', 85,133994,2,0,0,0,0, 7,0,0,0,0,0,0,0,'Erma - Link - Cast Revive Battle Pets'),
( 6749,0,2,3,61,0,100,0,    0,0,0,0,0,'', 33, 64320,0,0,0,0,0, 7,0,0,0,0,0,0,0,'Erma - Link - Quest Credit 31309'),
( 6749,0,3,0,61,0,100,0,    0,0,0,0,0,'', 72,     0,0,0,0,0,0, 7,0,0,0,0,0,0,0,'Erma - Link - Close Gossip'),
-- Shelby Stoneflint (Dun Morogh) - quete 31549
( 9980,0,0,1,62,0,100,0, 9821,2,0,0,0,'', 85,125801,2,0,0,0,0, 7,0,0,0,0,0,0,0,'Shelby Stoneflint - Gossip Select - Cast Heal Battle Pets'),
( 9980,0,1,2,61,0,100,0,    0,0,0,0,0,'', 85,133994,2,0,0,0,0, 7,0,0,0,0,0,0,0,'Shelby Stoneflint - Link - Cast Revive Battle Pets'),
( 9980,0,2,3,61,0,100,0,    0,0,0,0,0,'', 33, 65020,0,0,0,0,0, 7,0,0,0,0,0,0,0,'Shelby Stoneflint - Link - Quest Credit 31549'),
( 9980,0,3,0,61,0,100,0,    0,0,0,0,0,'', 72,     0,0,0,0,0,0, 7,0,0,0,0,0,0,0,'Shelby Stoneflint - Link - Close Gossip'),
-- Shoja'my (Durotar) - quete 31572
( 9987,0,0,1,62,0,100,0, 9821,2,0,0,0,'', 85,125801,2,0,0,0,0, 7,0,0,0,0,0,0,0,'Shoja\'my - Gossip Select - Cast Heal Battle Pets'),
( 9987,0,1,2,61,0,100,0,    0,0,0,0,0,'', 85,133994,2,0,0,0,0, 7,0,0,0,0,0,0,0,'Shoja\'my - Link - Cast Revive Battle Pets'),
( 9987,0,2,3,61,0,100,0,    0,0,0,0,0,'', 33, 65180,0,0,0,0,0, 7,0,0,0,0,0,0,0,'Shoja\'my - Link - Quest Credit 31572'),
( 9987,0,3,0,61,0,100,0,    0,0,0,0,0,'', 72,     0,0,0,0,0,0, 7,0,0,0,0,0,0,0,'Shoja\'my - Link - Close Gossip'),
-- Seikwa (Mulgore) - quete 31574
(10050,0,0,1,62,0,100,0, 9821,2,0,0,0,'', 85,125801,2,0,0,0,0, 7,0,0,0,0,0,0,0,'Seikwa - Gossip Select - Cast Heal Battle Pets'),
(10050,0,1,2,61,0,100,0,    0,0,0,0,0,'', 85,133994,2,0,0,0,0, 7,0,0,0,0,0,0,0,'Seikwa - Link - Cast Revive Battle Pets'),
(10050,0,2,3,61,0,100,0,    0,0,0,0,0,'', 33, 65184,0,0,0,0,0, 7,0,0,0,0,0,0,0,'Seikwa - Link - Quest Credit 31574'),
(10050,0,3,0,61,0,100,0,    0,0,0,0,0,'', 72,     0,0,0,0,0,0, 7,0,0,0,0,0,0,0,'Seikwa - Link - Close Gossip'),
-- Seriadne (Teldrassil) - quetes 31553 / 31554
(10051,0,0,1,62,0,100,0, 9821,2,0,0,0,'', 85,125801,2,0,0,0,0, 7,0,0,0,0,0,0,0,'Seriadne - Gossip Select - Cast Heal Battle Pets'),
(10051,0,1,2,61,0,100,0,    0,0,0,0,0,'', 85,133994,2,0,0,0,0, 7,0,0,0,0,0,0,0,'Seriadne - Link - Cast Revive Battle Pets'),
(10051,0,2,3,61,0,100,0,    0,0,0,0,0,'', 33, 65041,0,0,0,0,0, 7,0,0,0,0,0,0,0,'Seriadne - Link - Quest Credit 31553/31554'),
(10051,0,3,0,61,0,100,0,    0,0,0,0,0,'', 72,     0,0,0,0,0,0, 7,0,0,0,0,0,0,0,'Seriadne - Link - Close Gossip'),
-- Jaelysia (Sombrivage) - quete 31583
(10085,0,0,1,62,0,100,0, 9821,2,0,0,0,'', 85,125801,2,0,0,0,0, 7,0,0,0,0,0,0,0,'Jaelysia - Gossip Select - Cast Heal Battle Pets'),
(10085,0,1,2,61,0,100,0,    0,0,0,0,0,'', 85,133994,2,0,0,0,0, 7,0,0,0,0,0,0,0,'Jaelysia - Link - Cast Revive Battle Pets'),
(10085,0,2,3,61,0,100,0,    0,0,0,0,0,'', 33, 65199,0,0,0,0,0, 7,0,0,0,0,0,0,0,'Jaelysia - Link - Quest Credit 31583'),
(10085,0,3,0,61,0,100,0,    0,0,0,0,0,'', 72,     0,0,0,0,0,0, 7,0,0,0,0,0,0,0,'Jaelysia - Link - Close Gossip'),
-- Anathos (Bois des Chants eternels) - quete 31580
(16185,0,0,1,62,0,100,0, 9821,2,0,0,0,'', 85,125801,2,0,0,0,0, 7,0,0,0,0,0,0,0,'Anathos - Gossip Select - Cast Heal Battle Pets'),
(16185,0,1,2,61,0,100,0,    0,0,0,0,0,'', 85,133994,2,0,0,0,0, 7,0,0,0,0,0,0,0,'Anathos - Link - Cast Revive Battle Pets'),
(16185,0,2,3,61,0,100,0,    0,0,0,0,0,'', 33, 65198,0,0,0,0,0, 7,0,0,0,0,0,0,0,'Anathos - Link - Quest Credit 31580'),
(16185,0,3,0,61,0,100,0,    0,0,0,0,0,'', 72,     0,0,0,0,0,0, 7,0,0,0,0,0,0,0,'Anathos - Link - Close Gossip'),
-- Esbina (Azuremyst) - quete 31568
(17485,0,0,1,62,0,100,0, 9821,2,0,0,0,'', 85,125801,2,0,0,0,0, 7,0,0,0,0,0,0,0,'Esbina - Gossip Select - Cast Heal Battle Pets'),
(17485,0,1,2,61,0,100,0,    0,0,0,0,0,'', 85,133994,2,0,0,0,0, 7,0,0,0,0,0,0,0,'Esbina - Link - Cast Revive Battle Pets'),
(17485,0,2,3,61,0,100,0,    0,0,0,0,0,'', 33, 65179,0,0,0,0,0, 7,0,0,0,0,0,0,0,'Esbina - Link - Quest Credit 31568'),
(17485,0,3,0,61,0,100,0,    0,0,0,0,0,'', 72,     0,0,0,0,0,0, 7,0,0,0,0,0,0,0,'Esbina - Link - Close Gossip'),
-- Bezzil (Orgrimmar, gobelins) - quete 31586 - menu 12106
(45789,0,0,1,62,0,100,0,12106,2,0,0,0,'', 85,125801,2,0,0,0,0, 7,0,0,0,0,0,0,0,'Bezzil - Gossip Select - Cast Heal Battle Pets'),
(45789,0,1,2,61,0,100,0,    0,0,0,0,0,'', 85,133994,2,0,0,0,0, 7,0,0,0,0,0,0,0,'Bezzil - Link - Cast Revive Battle Pets'),
(45789,0,2,3,61,0,100,0,    0,0,0,0,0,'', 33, 65200,0,0,0,0,0, 7,0,0,0,0,0,0,0,'Bezzil - Link - Quest Credit 31586'),
(45789,0,3,0,61,0,100,0,    0,0,0,0,0,'', 72,     0,0,0,0,0,0, 7,0,0,0,0,0,0,0,'Bezzil - Link - Close Gossip'),
-- Murog (Orgrimmar) - quete 31589 - le bug signale
(47764,0,0,1,62,0,100,0, 9821,2,0,0,0,'', 85,125801,2,0,0,0,0, 7,0,0,0,0,0,0,0,'Murog - Gossip Select - Cast Heal Battle Pets'),
(47764,0,1,2,61,0,100,0,    0,0,0,0,0,'', 85,133994,2,0,0,0,0, 7,0,0,0,0,0,0,0,'Murog - Link - Cast Revive Battle Pets'),
(47764,0,2,3,61,0,100,0,    0,0,0,0,0,'', 33, 65212,0,0,0,0,0, 7,0,0,0,0,0,0,0,'Murog - Link - Quest Credit 31589'),
(47764,0,3,0,61,0,100,0,    0,0,0,0,0,'', 72,     0,0,0,0,0,0, 7,0,0,0,0,0,0,0,'Murog - Link - Close Gossip');

-- ---------------------------------------------------------------------
-- 5. Menu 12106 : brancher les textes diffuses pour avoir la VF
-- ---------------------------------------------------------------------
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`= 8912 WHERE `MenuId`=12106 AND `OptionIndex`=0;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=56613 WHERE `MenuId`=12106 AND `OptionIndex`=1;
