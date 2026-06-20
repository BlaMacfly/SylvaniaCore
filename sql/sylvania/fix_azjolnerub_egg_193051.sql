-- Fix Azjol-Nerub (map 601) quete oeufs : GO 193051 Nerubian Scourge Egg
-- goober.questID(Data1)=13182 (quete WotLK Kilix) gatait l usage => joueurs sur la
-- quete ACTIVE 29808 (A zak) cliquent dans le vide (Use() break avant KillCreditGO).
-- Fix : Data1=0 -> credit via quest_objectives (gere 13182 ET 29808). Rollback: Data1=13182.
-- NB: gameobject_template charge au boot => effet au prochain restart.
UPDATE gameobject_template SET Data1=0 WHERE entry=193051;
