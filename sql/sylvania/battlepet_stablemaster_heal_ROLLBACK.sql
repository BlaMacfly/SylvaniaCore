-- Rollback de battlepet_stablemaster_heal.sql (2026-09-10)
DELETE FROM `gossip_menu_option` WHERE `MenuId`=9821  AND `OptionIndex` IN (0,4);
DELETE FROM `gossip_menu_option` WHERE `MenuId`=12106 AND `OptionIndex` IN (2,3);
UPDATE `gossip_menu_option` SET `OptionType`=1, `OptionNpcFlag`=1 WHERE `MenuId`=12106 AND `OptionIndex`=0;

UPDATE `creature_template` SET `gossip_menu_id`=0 WHERE `entry` IN (47764,10085);
UPDATE `creature_template` SET `npcflag`=130     WHERE `entry`=10051;
UPDATE `creature_template` SET `AIName`=''
    WHERE `entry` IN (6749,9980,9987,10050,10051,10085,16185,17485,45789,47764);

DELETE FROM `smart_scripts`
    WHERE `source_type`=0 AND `entryorguid` IN (6749,9980,9987,10050,10051,10085,16185,17485,45789,47764);
UPDATE `smart_scripts` SET `action_param1`=64320, `comment`='Stable Master - Link - Quest Credit 31309'
    WHERE `source_type`=0 AND `entryorguid`=11069 AND `id`=2;
