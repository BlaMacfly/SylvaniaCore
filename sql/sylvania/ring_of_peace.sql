-- Ring of Peace (116844) : bon binding = areatrigger_template.ScriptName sur l AreaTriggerId 3983
-- (SpellMiscId 718 -> AreaTriggerId 3983, sphere rayon 8). areatrigger_scripts etait la MAUVAISE table.
UPDATE areatrigger_template SET ScriptName="at_monk_ring_of_peace" WHERE Id=3983;
DELETE FROM areatrigger_scripts WHERE entry=718;
-- Bonus meme bug : Chant de Chi-Ji (SpellMiscId 5484 -> AreaTriggerId 10191) jamais binde non plus
UPDATE areatrigger_template SET ScriptName="at_monk_song_of_chiji" WHERE Id=10191;
