-- Phases reprises de LegionCore (phase_area « LC: ») qui ne sont pas cosmetiques dans Phase.db2.
-- Chez nous (TrinityCore), un joueur qui porte une phase non cosmetique perd la vue de tout ce qui n'a pas de phase :
-- a Azsuna, Wissmerill (quete 38857 rendue -> phase 1001) ne voyait plus les ennemis ni les donneurs de la zone.
-- Chez LegionCore, d'ou viennent ces phases et leurs apparitions, ce qui n'a pas de phase reste toujours visible :
-- on reproduit ce comportement en les marquant cosmetiques (0x10) cote serveur. Pas de hotfix_data : le client
-- n'utilise pas ces drapeaux, seul le serveur les lit au demarrage.
-- Exception a la regle « contenu officiel » : on change les drapeaux officiels de ces 52 phases.
INSERT INTO `phase` (`ID`,`Flags`,`VerifiedBuild`) VALUES
(1001,0x50,0),(4316,0x14,0),(4599,0x14,0),(4602,0x14,0),(4604,0x14,0),(4695,0x234,0),(4702,0x2B0,0),(4704,0x14,0),
(4705,0x14,0),(5144,0x34,0),(5149,0x10,0),(5348,0x34,0),(5365,0x14,0),(5832,0x10,0),(5962,0x14,0),(6002,0x10,0),
(6065,0x234,0),(6068,0x14,0),(6071,0x14,0),(6120,0x14,0),(6215,0x14,0),(6355,0x14,0),(6534,0x234,0),(6545,0x14,0),
(6576,0x234,0),(6595,0x14,0),(6773,0x34,0),(6810,0x10,0),(6826,0x14,0),(6936,0x234,0),(6944,0x214,0),(6945,0x34,0),
(6946,0x14,0),(6950,0x14,0),(6953,0x14,0),(7027,0x234,0),(7102,0x14,0),(7124,0x14,0),(7142,0x234,0),(7164,0x14,0),
(7469,0x14,0),(7617,0x14,0),(7626,0x10,0),(7813,0x30,0),(7814,0x30,0),(7815,0x30,0),(7962,0x234,0),(8082,0x14,0),
(8224,0x234,0),(8227,0x14,0),(8370,0x14,0),(8401,0x14,0)
ON DUPLICATE KEY UPDATE `Flags`=VALUES(`Flags`);
