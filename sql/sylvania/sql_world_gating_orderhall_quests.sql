-- ============================================================================
-- Gating de classe : quêtes de hall d'ordre offertes à TOUTES les classes.
-- 2026-06-14.
-- ----------------------------------------------------------------------------
-- PROBLÈME : sur ce core, ces quêtes de campagne d'ordre ont AllowableClasses=0
--   (aucune restriction) dans quest_template_addon → un Chasseur de démons (et
--   n'importe quelle classe) pouvait les prendre. Repéré depuis Dalaran/Krasus.
--
-- Classes confirmées via les donneurs / objectifs :
--   40392 « Call of the Marksman » / « L'appel du tireur d'élite »      -> Chasseur
--   39427 « The Eagle Spirit's Blessing » / « bénédiction esprit aigle » -> Chasseur (Apata Highmountain)
--   41574 « Stolen Thunder » / « Le tonnerre volé »                      -> Chasseur (Grif Wildheart)
--   42002 « To Northrend » / « En route pour le Norfendre »             -> Chevalier de la mort (Shield Hill/Acherus)
--
-- Bitmask classes : Chasseur=4, Chevalier de la mort=32.
-- Application : SQL puis « .reload quest_template » en jeu (à chaud, pas de restart).
-- ============================================================================

UPDATE quest_template_addon SET AllowableClasses = 4  WHERE ID IN (40392, 39427, 41574); -- Chasseur
UPDATE quest_template_addon SET AllowableClasses = 32 WHERE ID = 42002;                  -- Chevalier de la mort
