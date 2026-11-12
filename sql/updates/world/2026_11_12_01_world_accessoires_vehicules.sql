-- Vehicle accessories are skipped at loading when the vehicle has no npc_spellclick_spells row:
-- Olin Umberhide never sat on his Rope Bunny (Winds of Change 34462), nor the passengers of these vehicles.
-- Rows of LegionCore, Gnomeregan Stealth Fighter of TrinityCore master.
DELETE FROM `npc_spellclick_spells` WHERE `npc_entry` IN (35995, 37939, 38363, 38918, 38929, 39039, 43336, 43337, 52358, 80578, 91465);
INSERT INTO `npc_spellclick_spells` (`npc_entry`, `spell_id`, `cast_flags`, `user_type`) VALUES
(35995, 46598, 1, 0), -- Strangle Vine
(37939, 46598, 1, 0), -- Riding War Wolf
(38363, 46598, 1, 0), -- Forsaken Invader
(38918, 73137, 1, 0), -- Flying Bomber
(38929, 46598, 1, 0), -- Flying Bomber
(39039, 46598, 1, 0), -- Gnomeregan Stealth Fighter
(43336, 46598, 1, 0), -- Stagecoach Harness
(43337, 46598, 1, 0), -- Stagecoach Carriage
(52358, 46598, 1, 0), -- Craggle Wobbletop
(80578, 46598, 0, 0), -- Rope Bunny (Olin Umberhide)
(91465, 46598, 1, 0); -- Malfurion Stormrage
