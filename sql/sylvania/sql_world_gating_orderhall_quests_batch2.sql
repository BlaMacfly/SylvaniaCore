-- ============================================================================
-- Gating de classe — LOT #2 : quêtes de campagne d'ordre (QuestInfoID=107,
-- AllowableClasses=0) données dans les hubs partagés (Dalaran/capitales),
-- classées par leur PNJ donneur de hall d'ordre. 2026-06-14.
-- ----------------------------------------------------------------------------
-- Méthode fiable : un PNJ de hall d'ordre = une classe → on gate ses quêtes.
-- Donneurs AMBIGUS exclus volontairement (Khadgar, Anduin, Sylvanas/Saurfang =
--   faction, King Phaoris = Uldum, Marin Noggenfogger, Sister Elda…) → revue
--   manuelle plus tard. Garde `AllowableClasses=0` = on n'écrase jamais un gating
--   déjà posé. Bitmask : Paladin=2, Chasseur=4, Voleur=8, Mage=128, Druide=1024,
--   Chasseur de démons=2048. Application : SQL puis `.reload quest_template`.
-- ============================================================================

-- Druide (1024) — Rensar Greathoof, Mylune, Keeper Remulos, Skylord Omnuron
UPDATE quest_template_addon SET AllowableClasses=1024
 WHERE AllowableClasses=0 AND ID IN (40646,41255,41468,42428,43409,43980,44431,44443, 41422,41449, 40649, 40653);

-- Voleur (8) — Lord Jorach Ravenholdt, Valeera Sanguinar, Princess Tess Greymane
UPDATE quest_template_addon SET AllowableClasses=8
 WHERE AllowableClasses=0 AND ID IN (40839,40840,40950,40994,44034,44375, 41919,41920,41921,41922, 42501,42502);

-- Chasseur (4) — Emmarel Shadewarden, Grif Wildheart, Holt Thunderhorn
UPDATE quest_template_addon SET AllowableClasses=4
 WHERE AllowableClasses=0 AND ID IN (40955,41053,40954,41540,41541,41542,44043,44366, 41009, 43880);

-- Paladin (2) — Lord Maxwell Tyrosus, Lord Grayson Shadowbreaker
UPDATE quest_template_addon SET AllowableClasses=2
 WHERE AllowableClasses=0 AND ID IN (38376,40408,42000,42231,42770, 39756);

-- Chasseur de démons (2048) — Altruis the Sufferer, Jace Darkweaver
UPDATE quest_template_addon SET AllowableClasses=2048
 WHERE AllowableClasses=0 AND ID IN (40816,41120,41803,41863, 41807);

-- Mage (128) — Archmage Kalec
UPDATE quest_template_addon SET AllowableClasses=128
 WHERE AllowableClasses=0 AND ID IN (41626,41632,42006);
