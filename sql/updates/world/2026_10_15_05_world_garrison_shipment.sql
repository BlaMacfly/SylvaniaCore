-- Commandes de travail : PNJ -> conteneur de commandes (troupes du domaine de classe, cuisine de Nomi,
-- batiments du fief), table de LegionCore. Lue par GarrisonMgr::LoadShipments.
DROP TABLE IF EXISTS `garrison_shipment`;
CREATE TABLE `garrison_shipment` (
  `SiteID` int(11) NOT NULL DEFAULT '2',
  `ContainerID` int(11) NOT NULL,
  `NpcEntry` int(10) unsigned NOT NULL,
  `questReq` int(10) unsigned NOT NULL DEFAULT '0',
  `classReq` int(10) unsigned NOT NULL DEFAULT '0',
  `ShipmentID` int(10) unsigned NOT NULL DEFAULT '0',
  `comment` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ContainerID`,`NpcEntry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
INSERT INTO `garrison_shipment` (`SiteID`,`ContainerID`,`NpcEntry`,`questReq`,`classReq`,`ShipmentID`,`comment`) VALUES
(0,65,86639,0,0,137,'Horde.Conqueror\'s Tribute'),
(0,122,101846,40991,0,247,NULL),
(0,124,105015,41946,512,0,NULL),
(0,125,105019,0,512,0,NULL),
(0,128,106217,0,256,0,NULL),
(0,129,106216,41797,256,0,NULL),
(0,131,106377,42127,128,0,NULL),
(0,132,106433,0,128,0,NULL),
(0,134,106435,43266,32,0,NULL),
(0,135,106436,47078,32,0,NULL),
(0,137,103025,42679,2048,0,NULL),
(0,138,103760,0,2048,0,NULL),
(0,140,108393,42585,1024,0,NULL),
(0,141,106442,0,1024,0,NULL),
(0,143,106444,42524,4,0,NULL),
(0,144,106446,0,4,0,NULL),
(0,146,106447,42848,2,0,NULL),
(0,147,106448,0,2,0,NULL),
(0,149,106450,43275,16,0,NULL),
(0,150,106451,0,16,0,NULL),
(0,152,105979,43013,8,0,NULL),
(0,153,106083,0,8,0,NULL),
(0,155,112208,0,64,0,NULL),
(0,156,106457,42142,64,0,NULL),
(0,158,106459,42609,1,0,NULL),
(0,159,106460,0,1,0,NULL),
(0,173,110624,47070,128,0,NULL),
(0,181,97111,46809,32,0,NULL),
(0,182,111736,0,2048,0,NULL),
(0,183,111737,47075,1024,0,NULL),
(0,184,98737,47073,4,0,NULL),
(0,185,106942,47069,512,0,NULL),
(0,186,91190,47071,2,0,NULL),
(0,187,111738,47077,16,0,NULL),
(0,188,102641,47079,8,0,NULL),
(0,189,111739,47074,64,0,NULL),
(0,190,111740,47076,256,0,NULL),
(0,191,111741,47072,1,0,NULL),
(0,198,110433,0,2048,0,NULL),
(2,31,77791,0,0,60,'Alliance. Alchemical Catalyst + 236639'),
(2,36,84248,0,0,71,'Alliance. lamber mill'),
(2,37,77778,0,0,72,'Alliance. Hexweave Cloth + 237665 + 237666'),
(2,49,77792,0,0,103,'Alliance.Truesteel Ingot'),
(2,50,78207,0,0,104,'Alliance. Burnished Leather'),
(2,51,77775,0,0,105,'Alliance. Taladite Crystal + 236652 for lvl2'),
(2,52,77781,0,0,106,'Alliance. Temporal Crystal + 236643 + 236644'),
(2,53,77831,0,0,107,'Alliance. Gearspring Parts + 236647'),
(2,54,77777,0,0,108,'Alliance. War Paints + 236649'),
(2,55,85514,0,0,109,'Alliance.Garden'),
(2,56,77730,0,0,110,'Alliance. Mine Shipment'),
(2,64,79863,0,0,135,'Horde. Hexweave Cloth + 237186 + 237190'),
(2,66,87211,0,0,138,'Alliance. Garrison Resources.Trading Post'),
(2,66,87212,0,0,143,'Alliance. Garrison Resources'),
(2,78,89065,0,0,176,'Alliance. WarMil'),
(2,109,95002,0,0,222,'Alliance. Ships.'),
(71,32,88884,0,0,85,'Horde.Barn Shipment.Barn Crafter - Leather L1'),
(71,32,88885,0,0,86,'Horde.Barn Shipment.Barn Crafter - Leather L2'),
(71,32,88883,0,0,83,'Horde.Barn Shipment.Barn Crafter - Fur L2'),
(71,32,88894,0,0,82,'Horde.Barn Shipment.Barn Crafter - Fur L1'),
(71,32,88899,0,0,89,'Horde.Barn Shipment.Barn Crafter - Meat L2'),
(71,32,88895,0,0,83,'Horde.Barn Shipment.Barn Crafter - Fur L2'),
(71,32,88898,0,0,88,'Horde.Barn Shipment.Barn Crafter - Meat L1'),
(71,32,88882,0,0,82,'Horde.Barn Shipment.Barn Crafter - Fur L1'),
(71,32,88897,0,0,86,'Horde.Barn Shipment.Barn Crafter - Leather L2'),
(71,32,88886,0,0,88,'Horde.Barn Shipment.Barn Crafter - Meat L1'),
(71,32,88896,0,0,85,'Horde.Barn Shipment.Barn Crafter - Leather L1'),
(71,32,88887,0,0,89,'Horde.Barn Shipment.Barn Crafter - Meat L2'),
(71,36,84247,0,0,71,'Horde.Lumber Mill Shipment'),
(71,57,79814,0,0,121,'Horde.Alchemical Catalyst'),
(71,58,79817,0,0,123,'Horde.Truesteel Ingot'),
(71,59,79820,0,0,125,'Horde.Temporal Crystal'),
(71,60,86696,0,0,127,'Horde.Gearspring Parts'),
(71,61,79831,0,0,129,'Horde.War Paints'),
(71,62,79830,0,0,131,'Horde.Taladite Crystal + 237067 + 237068'),
(71,63,79833,0,0,133,'Horde.Burnished Leather'),
(71,70,87119,0,0,162,'Horde.Garrison Resources.Trading Post'),
(71,77,89066,0,0,175,'Horde.War Mill'),
(71,79,81688,0,0,177,'Horde.Mine Shipment'),
(71,80,85783,0,0,178,'Horde.Garden Shipment'),
(71,100,91577,0,0,203,'Horde. noname.Spirit Lodge');

-- le PNJ doit proposer le dialogue (LegionCore le force au chargement)
UPDATE `creature_template` SET `npcflag` = `npcflag` | 1 WHERE `entry` IN (77730,77775,77777,77778,77781,77791,77792,77831,78207,79814,79817,79820,79830,79831,79833,79863,81688,84247,84248,85514,85783,86639,86696,87119,87211,87212,88882,88883,88884,88885,88886,88887,88894,88895,88896,88897,88898,88899,89065,89066,91190,91577,95002,97111,98737,101846,102641,103025,103760,105015,105019,105979,106083,106216,106217,106377,106433,106435,106436,106442,106444,106446,106447,106448,106450,106451,106457,106459,106460,106942,108393,110433,110624,111736,111737,111738,111739,111740,111741,112208);

-- menus de dialogue de LegionCore pour les PNJ qui n'en avaient pas
UPDATE `creature_template` SET `gossip_menu_id` = 16994 WHERE `entry` = 77730 AND `gossip_menu_id` = 0;
UPDATE `creature_template` SET `gossip_menu_id` = 17429 WHERE `entry` = 77775 AND `gossip_menu_id` = 0;
UPDATE `creature_template` SET `gossip_menu_id` = 17428 WHERE `entry` = 77777 AND `gossip_menu_id` = 0;
UPDATE `creature_template` SET `gossip_menu_id` = 17430 WHERE `entry` = 79833 AND `gossip_menu_id` = 0;
UPDATE `creature_template` SET `gossip_menu_id` = 16994 WHERE `entry` = 81688 AND `gossip_menu_id` = 0;
UPDATE `creature_template` SET `gossip_menu_id` = 16868 WHERE `entry` = 84247 AND `gossip_menu_id` = 0;
UPDATE `creature_template` SET `gossip_menu_id` = 16995 WHERE `entry` = 85783 AND `gossip_menu_id` = 0;
UPDATE `creature_template` SET `gossip_menu_id` = 19110 WHERE `entry` = 91190 AND `gossip_menu_id` = 0;
UPDATE `creature_template` SET `gossip_menu_id` = 18486 WHERE `entry` = 95002 AND `gossip_menu_id` = 0;
UPDATE `creature_template` SET `gossip_menu_id` = 18904 WHERE `entry` = 98737 AND `gossip_menu_id` = 0;
UPDATE `creature_template` SET `gossip_menu_id` = 19241 WHERE `entry` = 101846 AND `gossip_menu_id` = 0;
UPDATE `creature_template` SET `gossip_menu_id` = 20179 WHERE `entry` = 102641 AND `gossip_menu_id` = 0;
UPDATE `creature_template` SET `gossip_menu_id` = 20000 WHERE `entry` = 106377 AND `gossip_menu_id` = 0;
UPDATE `creature_template` SET `gossip_menu_id` = 20001 WHERE `entry` = 106433 AND `gossip_menu_id` = 0;
UPDATE `creature_template` SET `gossip_menu_id` = 20004 WHERE `entry` = 106442 AND `gossip_menu_id` = 0;
UPDATE `creature_template` SET `gossip_menu_id` = 20079 WHERE `entry` = 106450 AND `gossip_menu_id` = 0;
UPDATE `creature_template` SET `gossip_menu_id` = 20003 WHERE `entry` = 108393 AND `gossip_menu_id` = 0;
UPDATE `creature_template` SET `gossip_menu_id` = 20086 WHERE `entry` = 110624 AND `gossip_menu_id` = 0;
UPDATE `creature_template` SET `gossip_menu_id` = 20176 WHERE `entry` = 111736 AND `gossip_menu_id` = 0;
UPDATE `creature_template` SET `gossip_menu_id` = 20177 WHERE `entry` = 111737 AND `gossip_menu_id` = 0;
UPDATE `creature_template` SET `gossip_menu_id` = 20178 WHERE `entry` = 111738 AND `gossip_menu_id` = 0;
UPDATE `creature_template` SET `gossip_menu_id` = 20180 WHERE `entry` = 111739 AND `gossip_menu_id` = 0;
UPDATE `creature_template` SET `gossip_menu_id` = 20181 WHERE `entry` = 111740 AND `gossip_menu_id` = 0;
UPDATE `creature_template` SET `gossip_menu_id` = 20182 WHERE `entry` = 111741 AND `gossip_menu_id` = 0;
INSERT IGNORE INTO `gossip_menu` (`MenuId`,`TextId`,`VerifiedBuild`) VALUES (16995,24692,0);
INSERT IGNORE INTO `gossip_menu` (`MenuId`,`TextId`,`VerifiedBuild`) VALUES (17428,25004,0);
INSERT IGNORE INTO `gossip_menu` (`MenuId`,`TextId`,`VerifiedBuild`) VALUES (17429,25004,0);
INSERT IGNORE INTO `gossip_menu` (`MenuId`,`TextId`,`VerifiedBuild`) VALUES (17430,25004,0);
INSERT IGNORE INTO `npc_text` (`ID`,`Probability0`,`Probability1`,`Probability2`,`Probability3`,`Probability4`,`Probability5`,`Probability6`,`Probability7`,`BroadcastTextID0`,`BroadcastTextID1`,`BroadcastTextID2`,`BroadcastTextID3`,`BroadcastTextID4`,`BroadcastTextID5`,`BroadcastTextID6`,`BroadcastTextID7`,`VerifiedBuild`) VALUES (30274,1,0,0,0,0,0,0,0,121509,0,0,0,0,0,0,0,0);
INSERT IGNORE INTO `gossip_menu` (`MenuId`,`TextId`,`VerifiedBuild`) VALUES (20004,30274,0);
INSERT IGNORE INTO `npc_text` (`ID`,`Probability0`,`Probability1`,`Probability2`,`Probability3`,`Probability4`,`Probability5`,`Probability6`,`Probability7`,`BroadcastTextID0`,`BroadcastTextID1`,`BroadcastTextID2`,`BroadcastTextID3`,`BroadcastTextID4`,`BroadcastTextID5`,`BroadcastTextID6`,`BroadcastTextID7`,`VerifiedBuild`) VALUES (30029,1,0,0,0,0,0,0,0,120267,0,0,0,0,0,0,0,0);
INSERT IGNORE INTO `gossip_menu` (`MenuId`,`TextId`,`VerifiedBuild`) VALUES (20177,30029,0);
INSERT IGNORE INTO `gossip_menu` (`MenuId`,`TextId`,`VerifiedBuild`) VALUES (20180,30032,0);
INSERT IGNORE INTO `npc_text` (`ID`,`Probability0`,`Probability1`,`Probability2`,`Probability3`,`Probability4`,`Probability5`,`Probability6`,`Probability7`,`BroadcastTextID0`,`BroadcastTextID1`,`BroadcastTextID2`,`BroadcastTextID3`,`BroadcastTextID4`,`BroadcastTextID5`,`BroadcastTextID6`,`BroadcastTextID7`,`VerifiedBuild`) VALUES (30033,1,0,0,0,0,0,0,0,120275,0,0,0,0,0,0,0,0);
INSERT IGNORE INTO `gossip_menu` (`MenuId`,`TextId`,`VerifiedBuild`) VALUES (20181,30033,0);
INSERT IGNORE INTO `npc_text` (`ID`,`Probability0`,`Probability1`,`Probability2`,`Probability3`,`Probability4`,`Probability5`,`Probability6`,`Probability7`,`BroadcastTextID0`,`BroadcastTextID1`,`BroadcastTextID2`,`BroadcastTextID3`,`BroadcastTextID4`,`BroadcastTextID5`,`BroadcastTextID6`,`BroadcastTextID7`,`VerifiedBuild`) VALUES (30034,1,0,0,0,0,0,0,0,120281,0,0,0,0,0,0,0,0);
INSERT IGNORE INTO `gossip_menu` (`MenuId`,`TextId`,`VerifiedBuild`) VALUES (20182,30034,0);

-- option « commande de travail » (icone 28) de LegionCore, seulement si l'index est libre chez nous
INSERT IGNORE INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES (16966,0,28,'Can you sprout these Draenor seeds?',86940,1,1,0);
INSERT IGNORE INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES (16994,0,28,'Can you get the ore from this Draenor stone?',87263,1,1,0);
INSERT IGNORE INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES (16995,0,28,'Can you sprout these Draenor seeds?',86940,1,1,0);
INSERT IGNORE INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES (17428,0,28,'I\'d like to order.',85816,1,1,0);
INSERT IGNORE INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES (17429,0,28,'I\'d like to order.',85816,1,1,0);
INSERT IGNORE INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES (17430,0,28,'I\'d like to order.',85816,1,1,0);
INSERT IGNORE INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES (18904,0,28,'Let\'s continue researching my artifact.',118599,1,1,0);
INSERT IGNORE INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES (18919,0,28,'Let\'s continue researching my artifact.',118599,1,1,0);
INSERT IGNORE INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES (19110,0,28,'Let\'s continue researching my artifact.',118599,1,1,0);
INSERT IGNORE INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES (19241,12,28,'Learn recipes for making silver mackerel.',104858,1,1,0);
INSERT IGNORE INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES (19918,0,28,'I want to summon several demons.',115147,1,1,0);
INSERT IGNORE INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES (19918,1,28,'I want to summon several demons.',115147,1,1,0);
INSERT IGNORE INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES (19918,2,28,'I want to summon several demons.',115147,1,1,0);
INSERT IGNORE INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES (19920,0,28,'I need the Dark Harvest Council fighters.',123023,1,1,0);
INSERT IGNORE INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES (19920,1,28,'I need the Dark Harvest Council fighters.',123023,1,1,0);
INSERT IGNORE INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES (19941,0,28,'I need a squad of novices.',115477,1,1,0);
INSERT IGNORE INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES (19941,1,28,'I need a squad of novices.',115477,1,1,0);
INSERT IGNORE INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES (19941,2,28,'I need a squad of novices.',115477,1,1,0);
INSERT IGNORE INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES (19942,0,28,'I need a squad of novices.',115477,1,1,0);
INSERT IGNORE INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES (19942,1,28,'I need a squad of novices.',115477,1,1,0);
INSERT IGNORE INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES (19959,0,28,'How about summoning elementals?',115692,1,1,0);
INSERT IGNORE INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES (19959,1,28,'How about summoning elementals?',115692,1,1,0);
INSERT IGNORE INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES (19959,2,28,'How about summoning elementals?',115692,1,1,0);
INSERT IGNORE INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES (19997,0,28,'Archers are ready!',117230,1,1,0);
INSERT IGNORE INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES (19997,1,28,'Archers ready!',117230,1,1,0);
INSERT IGNORE INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES (19998,0,28,'I need a troop of hunters.',119576,1,1,0);
INSERT IGNORE INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES (19998,1,28,'I would like to requisition some Rangers.',119577,1,1,0);
INSERT IGNORE INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES (20000,0,28,'It\'s ... Elementary ...',117229,1,1,0);
INSERT IGNORE INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES (20001,0,28,'I want to recruit a squad of students.',121578,1,1,0);
INSERT IGNORE INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES (20003,0,28,'Do you wish to summon Elementals?',115692,1,1,0);
INSERT IGNORE INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES (20004,0,28,'We are waiting for your orders.',121509,1,1,0);
INSERT IGNORE INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES (20004,1,28,'We are waiting for your orders.',121509,1,1,0);
INSERT IGNORE INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES (20005,0,28,'You need a gunman?',117227,1,1,0);
INSERT IGNORE INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES (20005,1,28,'You need a gunman?',117227,1,1,0);
INSERT IGNORE INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES (20005,2,28,'You need a gunman?',117227,1,1,0);
INSERT IGNORE INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES (20006,0,28,'Recruit Knights of the Silver Hand',122520,1,1,0);
INSERT IGNORE INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES (20006,1,28,'Recruit Templars from the Order of the Silver Hand',122521,1,1,0);
INSERT IGNORE INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES (20007,0,28,'Valarjars are waiting.',117226,1,1,0);
INSERT IGNORE INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES (20008,0,28,'I need new virgo shields.',122095,1,1,0);
INSERT IGNORE INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES (20008,1,28,'I want to recruit val\'kyr in my squad.',122094,1,1,0);
INSERT IGNORE INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES (20018,0,28,'We the broken, salute you.',116346,1,1,0);
INSERT IGNORE INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES (20018,1,28,'We the broken, salute you.',116346,1,1,0);
INSERT IGNORE INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES (20018,2,28,'We the broken, salute you.',116346,1,1,0);
INSERT IGNORE INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES (20019,0,28,'Illidari are ready to serve.',116345,1,1,0);
INSERT IGNORE INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES (20019,1,28,'Illidari are ready to serve.',116345,1,1,0);
INSERT IGNORE INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES (20064,0,28,'Let\'s see if I can ... make my way ...',116435,1,1,0);
INSERT IGNORE INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES (20064,1,28,'Let\'s see if I can ... make my way ...',116435,1,1,0);
INSERT IGNORE INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES (20064,2,28,'Let\'s see if I can ... make my way ...',116435,1,1,0);
INSERT IGNORE INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES (20066,0,28,'The Order of the Ebon Blade awaits orders.',116439,1,1,0);
INSERT IGNORE INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES (20066,1,28,'The Order of the Ebon Blade awaits orders.',116439,1,1,0);
INSERT IGNORE INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES (20068,0,28,'The deep sea is calling!',116493,1,1,0);
INSERT IGNORE INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES (20069,0,28,'We act in the shadows.',116494,1,1,0);
INSERT IGNORE INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES (20079,0,28,'The light is ready to serve.',118339,1,1,0);
INSERT IGNORE INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES (20079,1,28,'The light is ready to serve.',118339,1,1,0);
INSERT IGNORE INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES (20079,2,28,'The light is ready to serve.',118339,1,1,0);
INSERT IGNORE INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES (20080,0,28,'Do you want to train fanatics?',121600,1,1,0);
INSERT IGNORE INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES (20080,1,28,'Do you want to train dark zealots?',121601,1,1,0);
INSERT IGNORE INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES (20086,0,28,'Let\'s continue researching my artifact.',118599,1,1,0);
INSERT IGNORE INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES (20175,0,28,'Let\'s continue researching my artifact.',118599,1,1,0);
INSERT IGNORE INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES (20176,0,28,'Let\'s continue researching my artifact.',118599,1,1,0);
INSERT IGNORE INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES (20177,0,28,'Let\'s continue researching my artifact.',118599,1,1,0);
INSERT IGNORE INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES (20178,0,28,'Let\'s continue researching my artifact.',118599,1,1,0);
INSERT IGNORE INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES (20179,0,28,'Let\'s continue researching my artifact.',118599,1,1,0);
INSERT IGNORE INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES (20180,0,28,'Let\'s continue researching my artifact.',118599,1,1,0);
INSERT IGNORE INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES (20181,0,28,'Let\'s continue researching my artifact.',118599,1,1,0);
INSERT IGNORE INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES (20182,0,28,'Let\'s continue researching my artifact.',118599,1,1,0);
INSERT IGNORE INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES (20214,0,28,'How about summoning elementals?',115692,1,1,0);
INSERT IGNORE INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES (20214,1,28,'How about summoning elementals?',115692,1,1,0);
INSERT IGNORE INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES (20346,0,28,'Place an armament for defenders.',122260,1,1,0);

-- type d'option 0 = rejete a la construction du menu (« The Valarjar await. » etait invisible)
UPDATE `gossip_menu_option` SET `OptionType` = 1, `OptionNpcFlag` = 1 WHERE `OptionIcon` = 28 AND `OptionType` = 0 AND `MenuId` IN (16868,16966,16994,16995,17428,17429,17430,18486,18904,18919,19110,19241,19918,19920,19941,19942,19959,19997,19998,20000,20001,20003,20004,20005,20006,20007,20008,20018,20019,20064,20066,20068,20069,20079,20080,20086,20175,20176,20177,20178,20179,20180,20181,20182,20214,20346);
