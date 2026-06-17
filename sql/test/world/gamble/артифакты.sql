DELETE FROM `gameobject_template` WHERE `entry` IN (248832 /*248832*/, 244940 /*244940*/, 251430 /*251430*/, 247501 /*247501*/, 245290 /*245290*/, 245188 /*245188*/, 244751 /*244751*/, 245215 /*245215*/, 251429 /*251429*/);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `RequiredLevel`, `VerifiedBuild`) VALUES
(248832, 3, 9806, 'Warswords of Valor', 'questinteract', 'Wielding', '', 2, 1691, 62339, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 107711, 0, 0, 36386, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 248832
(244940, 10, 28714, 'Prison Runestone', 'questinteract', 'Destroying', '', 0.6, 99, 0, 46970, 500000, 0, 0, 60000, 0, 0, 0, 194802, 0, 0, 1, 24585, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 244940
(251430, 5, 35068, 'Thick Fog', 'Cast', '', '', 1.15, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 251430
(247501, 0, 31838, 'Door', '', '', '', 0.65, 0, 0, 0, 0, 0, 0, 0, 27108, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 247501
(245290, 10, 1967, 'Mystic Bonfire', 'questinteract', '', '', 1.75, 2474, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 245290
(245188, 10, 1967, 'Mystic Bonfire', 'questinteract', '', '', 1.75, 2474, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 245188
(244751, 5, 9951, 'Thick Fog', 'Cast', '', '', 2, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 244751
(245215, 5, 29746, 'Thick Fog', 'Cast', '', '', 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 245215
(251429, 5, 35067, 'Thick Fog', '', '', '', 1.1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 23420); -- 251429

DELETE FROM `gameobject_template_addon` WHERE `entry` IN (244940 /*244940*/, 195318 /*195318*/, 251430 /*251430*/, 247501 /*247501*/, 245188 /*245188*/, 245290 /*245290*/, 244751 /*244751*/, 245215 /*245215*/, 266845 /*266845*/, 251429 /*251429*/, 245726 /*245726*/, 252887 /*252887*/, 250879 /*250879*/, 250878 /*250878*/, 252016 /*252016*/, 250880 /*250880*/);
INSERT INTO `gameobject_template_addon` (`entry`, `faction`, `flags`) VALUES
(244940, 0, 32), -- 244940
(195318, 114, 0), -- 195318
(251430, 0, 8192), -- Туман полоса
(247501, 1375, 32), -- Ворота деревяные сломанные
(245188, 0, 32), -- 245188
(245290, 0, 32), -- 245290
(244751, 0, 8192), -- тУМАН МАЛЕНЬКИЙ
(245215, 0, 8192), -- 245215
(266845, 114, 32), -- 266845
(251429, 0, 8192), -- 251429
(245726, 0, 270336), -- 245726
(252887, 0, 262144), -- 252887
(250879, 0, 262144), -- 250879
(250878, 0, 262144), -- 250878
(252016, 0, 262144), -- 252016
(250880, 0, 262144); -- 250880


DELETE FROM spell_script_names WHERE `ScriptName` = ('spell_item_sunreaver_beacon');
INSERT INTO spell_script_names VALUE (140300, 'spell_item_sunreaver_beacon'); 

DELETE FROM spell_script_names WHERE `ScriptName` = ('spell_item_the_perfect_blossom');
INSERT INTO spell_script_names VALUE (187676, 'spell_item_the_perfect_blossom');

DELETE FROM spell_script_names WHERE spell_id = 161399 AND ScriptName = "spell_item_Swapblaster";
INSERT INTO `spell_script_names`(`spell_id`,`ScriptName`) VALUES ( 161399,'spell_item_Swapblaster');

DELETE FROM spell_script_names WHERE `ScriptName` = ('spell_item_super_simian_sphere');
INSERT INTO spell_script_names VALUE (48333, 'spell_item_super_simian_sphere'); 

DELETE FROM spell_script_names WHERE spell_id IN(156614, 169923, 161788, 161787, 161789, 169926, 169925, 169924);

INSERT INTO spell_script_names(spell_id, ScriptName) VALUES(156614, "spell_draenor_profession");
INSERT INTO spell_script_names(spell_id, ScriptName) VALUES(169923, "spell_draenor_profession");
INSERT INTO spell_script_names(spell_id, ScriptName) VALUES(161788, "spell_draenor_profession");
INSERT INTO spell_script_names(spell_id, ScriptName) VALUES(161787, "spell_draenor_profession");
INSERT INTO spell_script_names(spell_id, ScriptName) VALUES(161789, "spell_draenor_profession");
INSERT INTO spell_script_names(spell_id, ScriptName) VALUES(169926, "spell_draenor_profession");
INSERT INTO spell_script_names(spell_id, ScriptName) VALUES(169925, "spell_draenor_profession");
INSERT INTO spell_script_names(spell_id, ScriptName) VALUES(169924, "spell_draenor_profession");

DELETE FROM creature_template WHERE entry IN(144173, 143208, 132601, 132604, 132603, 132600, 141997, 112673, 102671, 102281, 102279, 102267, 140146, 117473, 132602, 132599);


UPDATE gameobject_template SET data1 = 272270 WHERE entry = 272270 AND type IN (3, 50);
DELETE FROM `gameobject_loot_template` WHERE `entry` = '272270';
INSERT INTO `gameobject_loot_template` (`entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
('272270', '151623', '0', '0', '0', '1', '0', '1', '1', '');