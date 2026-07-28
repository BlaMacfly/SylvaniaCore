-- ============================================================
-- Artefacts toutes classes : choix universel + UI d'étapes
-- pour les scénarios d'artefact déjà scriptés
-- ============================================================

-- 1) Ritssyn Flamescowl (démoniste, Dreadscar) déclenche le choix d'artefact
UPDATE creature_template SET ScriptName='npc_ritssyn_flamescowl', npcflag=npcflag|1 WHERE entry=104795;

-- 2) UI d'étapes pour les scénarios d'artefact déjà scriptés (correspondances sûres)
REPLACE INTO scenarios (map, difficulty, scenario_A, scenario_H, zoneid) VALUES
(1536, 0,  990,  990, 0),  -- Ursoc's Lair (druide gardien)
(1533, 0,  988,  988, 0),  -- The Dark Riders (Karazhan catacombs)
(1539, 0,  972,  972, 0),  -- Legacy of the Windrunners (Tirisfal, chasseur précision)
(1495, 0, 1082, 1082, 0),  -- Claiming the Truthguard (paladin protection)
(1583, 0, 1065, 1065, 0),  -- The Nexus Vault (mage arcanes)
(1599, 0, 1061, 1061, 0);  -- Cleansing the Mother Tree (druide restauration)

-- 3) Textes FR du choix d'artefact (les bases importées sont en russe)
UPDATE playerchoice SET Question='Quelle arme devons-nous rechercher en priorité ?' WHERE ChoiceId IN (231,235,236,240,245,248,253,255,266);
UPDATE playerchoice_response SET answer='Choisir' WHERE choiceId IN (231,235,236,240,245,248,253,255,266);
UPDATE playerchoice_response SET header='Sang'                 WHERE choiceId=253 AND responseId=400;
UPDATE playerchoice_response SET header='Givre'                WHERE choiceId=253 AND responseId=401;
UPDATE playerchoice_response SET header='Impie'                WHERE choiceId=253 AND responseId=402;
UPDATE playerchoice_response SET header='Affliction'           WHERE choiceId=245 AND responseId=420;
UPDATE playerchoice_response SET header='Démonologie'          WHERE choiceId=245 AND responseId=421;
UPDATE playerchoice_response SET header='Destruction'          WHERE choiceId=245 AND responseId=422;
UPDATE playerchoice_response SET header='Survie'               WHERE choiceId=240 AND responseId=450;
UPDATE playerchoice_response SET header='Précision'            WHERE choiceId=240 AND responseId=451;
UPDATE playerchoice_response SET header='Maîtrise des bêtes'   WHERE choiceId=240 AND responseId=452;
UPDATE playerchoice_response SET header='Sacré'                WHERE choiceId=235 AND responseId=460;
UPDATE playerchoice_response SET header='Vindicte'             WHERE choiceId=235 AND responseId=461;
UPDATE playerchoice_response SET header='Protection'           WHERE choiceId=235 AND responseId=462;
UPDATE playerchoice_response SET header='Protection'           WHERE choiceId=236 AND responseId=470;
UPDATE playerchoice_response SET header='Armes'                WHERE choiceId=236 AND responseId=471;
UPDATE playerchoice_response SET header='Fureur'               WHERE choiceId=236 AND responseId=472;
UPDATE playerchoice_response SET header='Dévastation'          WHERE choiceId=231 AND responseId=478;
UPDATE playerchoice_response SET header='Vengeance'            WHERE choiceId=231 AND responseId=479;
UPDATE playerchoice_response SET header='Vengeance'            WHERE choiceId=255 AND responseId=640;
UPDATE playerchoice_response SET header='Dévastation'          WHERE choiceId=255 AND responseId=641;
UPDATE playerchoice_response SET header='Sacré'                WHERE choiceId=248 AND responseId=480;
UPDATE playerchoice_response SET header='Discipline'           WHERE choiceId=248 AND responseId=481;
UPDATE playerchoice_response SET header='Ombre'                WHERE choiceId=248 AND responseId=482;
UPDATE playerchoice_response SET header='Amélioration'         WHERE choiceId=266 AND responseId=587;
UPDATE playerchoice_response SET header='Élémentaire'          WHERE choiceId=266 AND responseId=588;
UPDATE playerchoice_response SET header='Restauration'         WHERE choiceId=266 AND responseId=589;
