-- Legionfall : construction des batiments du Rivage brise (Tour des mages, Centre de commandement, Perturbateur du Neant).
-- Les trois quetes de contribution deviennent repetables, comme au retail : un personnage contribue tant qu'il a 100 Fournitures
-- de guerre (Titans-Project 2026_09_27_01). Aucune n'avait de ligne dans quest_template_addon.
INSERT INTO `quest_template_addon` (`ID`, `SpecialFlags`) VALUES (46277, 1), (46735, 1), (46736, 1)
  ON DUPLICATE KEY UPDATE `SpecialFlags` = `SpecialFlags` | 1;

-- La table de construction de Legionfall (Point de Delivrance) n'avait pas le drapeau de collecteur de contributions
-- (UNIT_NPC_FLAG2_CONTRIBUTION_COLLECTOR, 0x400 << 32) : le client n'ouvrait pas la fenetre. 119305 est la version que
-- LegionCore porte avec ce drapeau ; 122082 est celle qui est posee chez nous, au meme endroit.
UPDATE `creature_template` SET `npcflag` = `npcflag` | 4398046511104 WHERE `entry` IN (119305, 122082);
