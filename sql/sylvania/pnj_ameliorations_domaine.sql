-- PNJ d ameliorations des domaines de classe (talents du domaine) : drapeau UNIT_NPC_FLAG_CLASS_HALLS_TALENT
-- (0x20000000000, npcflag2 512 chez LegionCore) absent chez nous. Avec lui, notre core ouvre la fenetre des
-- talents (HandleGossipHelloOpcode). Survivaliste Bahn (108050) : « Tech It Up A Notch » (Blez, 03/10/2026).
UPDATE creature_template SET npcflag = npcflag | 2199023255552 WHERE entry IN (97485,97989,98939,105998,107994,108331,112199,108527,108050,110725,108018,109901);
