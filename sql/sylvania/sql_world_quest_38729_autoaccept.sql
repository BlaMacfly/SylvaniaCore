-- ============================================================================
-- Fix hand-off quête DH Mardum : 38728 "La Clé" -> 38729 "Return to the Black Temple"
-- 2026-06-12
-- ----------------------------------------------------------------------------
-- Problème : après avoir rendu 38728 à Kayn (97303), le phasing fait disparaître
--   Kayn avant que le joueur accepte 38729 -> bloqué devant la Pierre angulaire.
-- Fix : passer 38729 en AUTO-ACCEPT (2 flags nécessaires sur ce core ArgusCore) :
--   - quest_template.Flags |= 0x80000  (QUEST_FLAGS_AUTO_ACCEPT, client)
--   - quest_template_addon.SpecialFlags |= 0x004 (QUEST_SPECIAL_FLAGS_AUTO_ACCEPT, serveur)
-- Valeurs d'origine (revert) : Flags=35651848, SpecialFlags=0.
-- Effet après `.reload quest_template` (à chaud) ou redémarrage. À valider sur un
--   nouveau perso Démoniste... Chasseur de démons de test.
-- ============================================================================
UPDATE quest_template       SET Flags        = Flags        | 0x80000 WHERE ID=38729;
UPDATE quest_template_addon SET SpecialFlags = SpecialFlags | 0x004   WHERE ID=38729;
