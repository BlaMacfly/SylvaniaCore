-- Vereesa Windrunner (121754), menu 21013 : son texte 31708 manquait (« gossip_menu is using non-existing TextId ») - repris de LegionCore
DELETE FROM `npc_text` WHERE `ID` = 31708;
INSERT INTO `npc_text` (`ID`, `Probability0`, `Probability1`, `Probability2`, `Probability3`, `Probability4`, `Probability5`, `Probability6`, `Probability7`,
  `BroadcastTextID0`, `BroadcastTextID1`, `BroadcastTextID2`, `BroadcastTextID3`, `BroadcastTextID4`, `BroadcastTextID5`, `BroadcastTextID6`, `BroadcastTextID7`, `VerifiedBuild`)
VALUES (31708, 1, 0, 0, 0, 0, 0, 0, 0, 130103, 0, 0, 0, 0, 0, 0, 0, 25549);
