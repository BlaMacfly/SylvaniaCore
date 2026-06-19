-- ============================================================
-- Fix : Coffre "Blade of the Anointed" (GO 214284) — Monastère Ecarlate (map 1004)
-- Quête 31513 "Blades of the Anointed" / 31514 "Unto Dust Thou Shalt Return"
-- Bug : Data1(lootId)=0 + gameobject_loot_template VIDE => coffre s ouvre vide,
--       l item 87282 (lames) jamais donné => roue crantée mais clic sans effet,
--       quête infinissable. Tous les autres coffres de quête suivent Data1=entry+loot.
-- Date : 2026-06-19
-- Rollback : voir bloc ROLLBACK en bas
-- ============================================================
UPDATE gameobject_template SET Data1=214284 WHERE entry=214284;

DELETE FROM gameobject_loot_template WHERE Entry=214284;
INSERT INTO gameobject_loot_template
  (Entry, Item, Reference, Chance, QuestRequired, LootMode, GroupId, MinCount, MaxCount, Comment)
VALUES
  (214284, 87282, 0, 100, 1, 1, 0, 1, 1, "Blades of the Anointed - quest 31513");

-- ---------- ROLLBACK ----------
-- UPDATE gameobject_template SET Data1=0 WHERE entry=214284;
-- DELETE FROM gameobject_loot_template WHERE Entry=214284;
