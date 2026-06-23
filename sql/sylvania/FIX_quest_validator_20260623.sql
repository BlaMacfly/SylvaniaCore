-- Fixes issus de quest_validator.sql (23/06/2026) — verifies un par un avant application
-- Thal'ena 102431 (boss map 1544) : IA morte (smart_scripts = rotation de sorts en combat, AIName vide)
UPDATE creature_template SET AIName='SmartAI' WHERE entry=102431;
-- Rocknot 9503 (BRD, quete 4295 Rocknot's Ale, script npc_rocknot OnQuestReward) : NOT_SELECTABLE bloque le rendu
-- Alurmi 57864 (maps 938/939, quetes 30097/30104) : NOT_SELECTABLE bloque donneur/rendeur, aucun script
UPDATE creature_template SET unit_flags = unit_flags & ~33554432 WHERE entry IN (9503,57864);
-- Goober 232625 Cooking Pot : Data1 35496->0 pour crediter 35496 ET 35764 (pattern Azjol)
UPDATE gameobject_template SET Data1=0 WHERE entry=232625;
