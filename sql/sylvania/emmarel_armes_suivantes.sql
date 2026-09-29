-- Emmarel Shadewarden au Pavillon du Traqueur (107317, 107973) : « Perpetuer la legende » (44043) et
-- « Une derniere aventure » (44366) demandent de choisir une nouvelle arme prodigieuse, mais rien ne
-- proposait le choix (Blez, 30/09/2026). Script C++ npc_emmarel_artifact_next ; le SmartAI LegionCore
-- de 107973 (remise de 42659 -> sort 216477) est repris dans ce script.
UPDATE creature_template SET AIName="", ScriptName="npc_emmarel_artifact_next" WHERE entry IN (107317,107973);
DELETE FROM smart_scripts WHERE entryorguid=107973 AND source_type=0;
