-- ============================================================================
-- Passe "retour Blizzlike Legion 7.3.5 / niveau 110" — 2026-06-12
-- Objectif serveur : Blizzlike L110. Custom CONSERVÉ = Solocraft + Solo LFG + Klauss (1000000).
-- ----------------------------------------------------------------------------
-- NB IMPORTANT (ne PAS supprimer) :
--   * Créatures niveau 111-113 = boss/élites Legion OFFICIELS (boss = cap+3). Blizzlike.
--   * Entries >= 1 000 000 = infra ArgusCore (raid Highmaul, npc_dh_spell_trainer,
--     bunnies/triggers de scripts, météores...) + Klauss. Supprimer casserait le serveur.
--   * MaxPlayerLevel = 110 déjà configuré (worldserver.conf) + player_levelstats cap 110.
--
-- 1) Revert de 5 PNJ utilitaires gonflés à 120-123 -> 110 (corrige aussi les warnings
--    "Missing base stats" 116-120 sans toucher creature_classlevelstats). Backup:
--    ~/fixes/backup_level_revert_20260612.sql.gz
UPDATE creature_template SET minlevel=110, maxlevel=110
 WHERE entry IN (48736 /*Genn Greymane*/, 3838 /*Vesprystus*/, 3841 /*Teldira Moonfeather*/,
                 47584 /*Aladrel Whitespire*/, 89715 /*Franklin Martin*/);

-- 2) Suppression des 2 PNJ QoL custom (Blizzlike strict). Pas de dépendance quête.
--    Backup: ~/fixes/backup_qol_npcs_20260612.sql.gz
--    1000001 Wrathion "Artifact Seller" (vendeur 36 artéfacts) ; 1000003 Sandrath Worrow "Demon Hunter Trainer".
DELETE FROM npc_vendor        WHERE entry IN (1000001,1000003);
DELETE FROM creature          WHERE id    IN (1000001,1000003);
DELETE FROM creature_template WHERE entry IN (1000001,1000003);
-- Effet complet au prochain redémarrage du worldserver (despawn des PNJ en mémoire).
