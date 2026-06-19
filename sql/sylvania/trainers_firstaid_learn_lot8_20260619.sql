-- =====================================================================
-- Lot 8 (2026-06-19) : Secourisme « impossible d'apprendre »
-- Cause : le sort 3273 (Secourisme apprenti = apprendre la profession)
--   manque dans le trainer moderne generique 160 ET dans le template
--   legacy 202007. 8 maitres de Secourisme ne pouvaient donc PAS
--   enseigner la profession a un debutant :
--   menu0 -> creature_default_trainer 160 : Aresella 18991, Joseph Wilson 33589
--   menus dedies (option type5 -> legacy vide) :
--     Shaina Fuller 2327(657), Arnok 3373(4761),
--     Nus 16731 + Amelia Atherton 50574(5855),
--     Anchorite Yazmina 23734(8802), Jandros Terres 133396(22169).
-- Fix HOT (.reload trainer + .reload gossip_menu_option) :
--   1) ajouter 3273 au TrainerId 160 (corrige menu0 + complete 160)
--   2) router l'option type5 (OptionIndex 0) des 5 menus dedies -> 160
-- Tous les menus concernes = 100% Secourisme (verifie).
-- =====================================================================
INSERT INTO trainer_spell
  (TrainerId, SpellId, MoneyCost, ReqSkillLine, ReqSkillRank, ReqAbility1, ReqAbility2, ReqAbility3, ReqLevel, VerifiedBuild)
VALUES
  (160, 3273, 100, 0, 0, 0, 0, 0, 0, 0)
ON DUPLICATE KEY UPDATE MoneyCost=VALUES(MoneyCost), ReqSkillLine=VALUES(ReqSkillLine), ReqSkillRank=VALUES(ReqSkillRank), ReqLevel=VALUES(ReqLevel);

INSERT INTO gossip_menu_option_trainer (MenuId, OptionIndex, TrainerId) VALUES
  (657,   0, 160),
  (4761,  0, 160),
  (5855,  0, 160),
  (8802,  0, 160),
  (22169, 0, 160),
  (10826, 0, 160)
ON DUPLICATE KEY UPDATE TrainerId=VALUES(TrainerId);
