-- Work order npcs without a gossip menu of their own (Turga and the other garrison workers):
-- the option of the default menu (LegionCore 0/18), shown when the npc has an order for the player
DELETE FROM `gossip_menu_option` WHERE `MenuId`=0 AND `OptionIndex`=18;
INSERT INTO `gossip_menu_option` (`MenuId`, `OptionIndex`, `OptionIcon`, `OptionText`, `OptionBroadcastTextId`, `OptionType`, `OptionNpcFlag`, `VerifiedBuild`) VALUES
(0, 18, 28, 'I''d like to submit a work order.', 85816, 22, 1, 0);
