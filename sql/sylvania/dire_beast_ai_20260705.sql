-- Dire Beast (spell 120679 "Bête féroce") — the summoned "Beast" guardians had no AI/ScriptName
-- and never engaged the hunter's target (they idled next to the owner).
-- Bind them to the new C++ AI npc_pet_hun_dire_beast (added to src/server/scripts/Pet/pet_hunter.cpp),
-- which orders the summon to attack the summoner's target on spawn.
-- Targets the 108 inert level-1 friendly "Beast" summon templates (one per zone/expansion).
-- 2026-07-05
UPDATE `creature_template`
SET `ScriptName` = 'npc_pet_hun_dire_beast'
WHERE `name` = 'Beast'
  AND `type` = 1
  AND `faction` = 35
  AND `minlevel` = 1
  AND `maxlevel` = 1
  AND (`AIName` IS NULL OR `AIName` = '')
  AND (`ScriptName` IS NULL OR `ScriptName` = '');
