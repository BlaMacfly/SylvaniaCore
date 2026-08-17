-- =====================================================================
-- Mardum — IA C++ écrites mais jamais rattachées aux PNJ
--
-- Signalé en jeu : la quête 39049 « L'œil rivé sur l'objectif » ne
-- progresse pas quand on tue l'Inquisiteur Baleful (93105, « Inquisiteur
-- Pernissus » en français), GUID 20541225.
--
-- CAUSE : la quête réclame deux crédits, 96159 (Colossal Infernal) et
-- 105946 (« Baleful slain & power taken »). Rien ne les accorde : le
-- template 93105 ne porte que KillCredit1 = 95226, qui appartient à une
-- autre quête (39279 « Assault on Mardum », 40 mobs normaux).
--
-- L'IA C++ `npc_inquisitor_baleful` (zone_mardum.cpp) fait pourtant tout le
-- travail : elle invoque le Colossal Infernal, et à la mort du boss elle
-- accorde LES DEUX crédits aux joueurs dans un rayon de 50 m, puis leur
-- apprend le sort Faisceau incandescent (195447). Mais le template avait
-- `ScriptName` VIDE et `AIName = SmartAI` : l'IA n'était jamais attachée.
--
-- Audit du fichier : 29 scripts y sont déclarés, 12 seulement étaient
-- rattachés. Les 17 autres étaient du code mort. Ce patch en rattache 6,
-- ceux dont la liaison ne remplace aucun comportement existant (aucun
-- AIName, aucun ScriptName, aucune ligne smart_scripts) — sauf 93105, dont
-- l'unique ligne SmartAI (lancer 194529 Incite Madness) est reproduite à
-- l'identique par l'IA C++, qui y ajoute Legion Aegis et Infernal Smash.
--
-- Les cinq autres sont les recruteurs de compagnons de la quête « Cry
-- Havoc » : sans eux cette quête aurait bloqué la campagne un peu plus loin.
--
-- `AIName` est laissé en place sur 93105 : la sélection d'IA du core
-- (FactorySelector::selectAI) teste le ScriptName AVANT l'AIName, donc le
-- script C++ gagne, et SmartAI reste un filet de sécurité si la liaison
-- échouait.
--
-- RESTE À TRAITER, hors de ce patch car cela remplacerait un SmartAI
-- aujourd'hui actif — à comparer un par un avant de décider :
--   94410 Allari the Souleater      (6 lignes SmartAI)  -> npc_mardum_allari
--   99915 Sevis Brightflame         (12 lignes)         -> npc_mardum_sevis_brightflame_shivarra
--   93221 Doom Commander Beliash    (2 lignes)          -> npc_doom_commander_beliash
--   96441 Fel Lord Caza             (1 ligne)           -> npc_fel_lord_caza
-- Note : ces deux derniers portent déjà un ScriptName, mais MAL ORTHOGRAPHIÉ
-- (`npc_mardum_doom_commander_beliash` et `npc_mardum_fel_lord_caza`), noms
-- qui n'existent nulle part dans le core — ils ne pointent donc sur rien.
-- Restent aussi Brood Queen Tyranna et les scripts *_tyranna_fight.
--
-- REDÉMARRAGE OBLIGATOIRE : la liste des noms de scripts est figée au boot.
-- =====================================================================

UPDATE `creature_template` SET `ScriptName`='npc_inquisitor_baleful' WHERE `entry`=93105;
UPDATE `creature_template` SET `ScriptName`='npc_kayn_sunfury'       WHERE `entry`=93127;
UPDATE `creature_template` SET `ScriptName`='npc_cyana'              WHERE `entry`=96420;
UPDATE `creature_template` SET `ScriptName`='npc_mannethrel'         WHERE `entry`=96652;
UPDATE `creature_template` SET `ScriptName`='npc_allari'             WHERE `entry`=96655;
UPDATE `creature_template` SET `ScriptName`='npc_korvas'             WHERE `entry`=99045;
