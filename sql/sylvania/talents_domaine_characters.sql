-- Talents des domaines de classe recherches par chaque personnage (03/10/2026).
-- flags : 0 en recherche, 1 pret, 2 reattribution (comme LegionCore, ClassHallTalentFlag).
CREATE TABLE IF NOT EXISTS character_garrison_talents (
  guid bigint unsigned NOT NULL,
  garrTalentId int unsigned NOT NULL,
  researchStartTime int unsigned NOT NULL DEFAULT 0,
  flags int unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (guid, garrTalentId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
