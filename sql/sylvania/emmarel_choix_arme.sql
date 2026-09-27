-- Emmarel Shadewarden (102478, Dalaran) : le chasseur ne pouvait pas choisir son arme prodigieuse.
-- Aucun gossip_menu_id : l option SmartAI (menu 19115) pour rouvrir le choix n apparaissait jamais,
-- et le script C++ npc_40618_artifact (option FR + choix a l acceptation) n etait rattache a rien.
-- Le SmartAI ne faisait rien d autre d utile (son Say LOS pointe vers un texte inexistant).
UPDATE creature_template SET AIName="", ScriptName="npc_40618_artifact" WHERE entry=102478;
DELETE FROM smart_scripts WHERE entryorguid=102478 AND source_type=0;
