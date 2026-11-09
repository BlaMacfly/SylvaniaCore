-- =====================================================================
-- Fief de Draenor (Horde/Alliance) - quetes signalees par Wissmerill (guid 339) le 08/11/2026
-- PARTIE A : donnees seules, sans dependance au nouveau binaire.
--   Givrefeu et artillerie lourde (36627), Vents du changement / Olin (34462),
--   Mission possible (34775, le critere est corrige en C++), prerequis de la chaine,
--   butin de Heavy Arms (36589), mine refusee au niveau 1 (35154/34192), vols de Bron Corne Celeste.
-- Sources : lc_world_ref (LegionCore) sauf les lignes marquees RECONSTRUCTION ou non sourcees.
-- =====================================================================

-- ----------------------------------------------------------------------------
-- 1. Prerequis de la chaine (lc_world_ref.quest_template_addon, ordre confirme
--    par la serie Wowhead « Foothold in a Savage Land » et « Heavy Arms »)
-- ----------------------------------------------------------------------------
UPDATE `quest_template_addon` SET `PrevQuestID` = 34592 WHERE `ID` = 34765; -- The Den of Skog      <- A Gronnling Problem
UPDATE `quest_template_addon` SET `PrevQuestID` = 34822 WHERE `ID` = 34461; -- Build Your Barracks  <- What We Need
UPDATE `quest_template_addon` SET `PrevQuestID` = 34861 WHERE `ID` = 34462; -- Winds of Change      <- We Need An Army (etait 34461)
UPDATE `quest_template_addon` SET `PrevQuestID` = 34462 WHERE `ID` = 34775; -- Mission Probable     <- Winds of Change
UPDATE `quest_template_addon` SET `PrevQuestID` = 36589 WHERE `ID` = 36594; -- "Spare" Parts        <- Heavy Arms
UPDATE `quest_template_addon` SET `PrevQuestID` = 36594 WHERE `ID` = 36627; -- Big Frostfire Gun    <- "Spare" Parts

-- « Heavy Arms » (36589) commence par l'objet 116438, qui ne tombait que
-- « si quete requise » : il faut la quete pour l'avoir et l'objet pour la quete.
-- LegionCore : chance positive, donc pas de quete requise.
UPDATE `creature_loot_template`   SET `QuestRequired` = 0 WHERE `Entry` = 74254  AND `Item` = 116438; -- Dorogg the Ruthless
UPDATE `gameobject_loot_template` SET `QuestRequired` = 0 WHERE `Entry` = 231977 AND `Item` = 116438; -- Bounty of Bladespire

-- ----------------------------------------------------------------------------
-- 2. Big Frostfire Gun (36627) : l'objet 116759 lance 171772 (dummy, cible 25)
--    sur un Gentle Clefthoof (86000) -> credit 86055 x5.
--    RECONSTRUCTION : aucun core (LC, TDB 7.3.5, TDB 1200, TC master,
--    Ashamane, ArgusCore) ne scripte 171772. Wowhead : « handled by a
--    server-side script ». Choix : credit a l'invocateur puis disparition 3 s
--    plus tard (reapparition normale), comme le canon 85820 de ce matin.
-- ----------------------------------------------------------------------------
DELETE FROM `smart_scripts` WHERE `entryorguid` = 86000 AND `source_type` = 0 AND `id` IN (1, 2);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`event_param_string`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(86000,0,1,2,8,0,100,0,171772,0,5000,5000,0,'',33,86055,0,0,0,0,0,7,0,0,0,0,0,0,0,'Gentle Clefthoof - On Spellhit Blixthraz Cannon - Quest Credit Big Frostfire Gun (RECONSTRUCTION)'),
(86000,0,2,0,61,0,100,0,0,0,0,0,0,'',41,3000,0,0,0,0,0,1,0,0,0,0,0,0,0,'Gentle Clefthoof - Linked - Despawn (RECONSTRUCTION)');
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 86000; -- deja SmartAI

-- Zone de quete (quest_poi 36627) : 3 Gentle Clefthoof chez nous, 15 chez LC.
-- 10 apparitions LC de l'aire 7055 sans equivalent chez nous (les autres LC
-- tombent a moins de 15 m des notres). 335231 et 335255 avaient MovementType 2
-- sans trajet chez LC : poses immobiles.
DELETE FROM `creature` WHERE `guid` BETWEEN 290401782 AND 290401791;
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`dynamicflags`,`ScriptName`,`movementmode`,`VerifiedBuild`) VALUES
(290401782,86000,1116,6720,7055,'0',0,0,0,-1,0,0,5293.56,4347.29,148.438,0.64272, 180,0, 0,1,0,0,0,0,0,0,0,'',0,0), -- LC 335189
(290401783,86000,1116,6720,7055,'0',0,0,0,-1,0,0,5312.04,4728.9, 108.873,3.67519, 180,1, 0,1,0,1,0,0,0,0,0,'',0,0), -- LC 335229
(290401784,86000,1116,6720,7055,'0',0,0,0,-1,0,0,5281.9, 4658.23,110.261,4.55061, 180,1, 0,1,0,1,0,0,0,0,0,'',0,0), -- LC 335230
(290401785,86000,1116,6720,7055,'0',0,0,0,-1,0,0,5249.15,4695.01,105.262,2.61152, 180,0, 0,1,0,0,0,0,0,0,0,'',0,0), -- LC 335231
(290401786,86000,1116,6720,7055,'0',0,0,0,-1,0,0,5296.81,4784.27,99.6162,5.07084, 180,0, 0,1,0,0,0,0,0,0,0,'',0,0), -- LC 335255
(290401787,86000,1116,6720,7055,'0',0,0,0,-1,0,0,5212.83,4575.49,114.851,4.76123, 180,0, 0,1,0,0,0,0,0,0,0,'',0,0), -- LC 335270
(290401788,86000,1116,6720,7055,'0',0,0,0,-1,0,0,5198.7, 4452.62,116.867,3.88,    180,4, 0,1,0,1,0,0,0,0,0,'',0,0), -- LC 335273
(290401789,86000,1116,6720,7055,'0',0,0,0,-1,0,0,5194.98,4525.49,117.057,5.91265, 180,0, 0,1,0,0,0,0,0,0,0,'',0,0), -- LC 335274
(290401790,86000,1116,6720,7055,'0',0,0,0,-1,0,0,5240.15,4414.04,128.879,0.862805,180,0, 0,1,0,0,0,0,0,0,0,'',0,0), -- LC 335277
(290401791,86000,1116,6720,7055,'0',0,0,0,-1,0,0,5238.2, 4357.86,127.92, 5.5932,  180,10,0,1,0,1,0,0,0,0,0,'',0,0); -- LC 335279

-- ----------------------------------------------------------------------------
-- 3. Winds of Change (34462) : sauver Olin -> sort 160951 = sujet 34 (Olin).
--    Mecanique LC : un « Rope Bunny » 80578 (vehicule 3593) porte Olin captif
--    80577 ; clic -> 162720 (credit 80577 + invocation personnelle 80582,
--    script npc_q34462 qui remercie et s'en va). Rien de tout cela chez nous.
-- ----------------------------------------------------------------------------
UPDATE `creature_template` SET `npcflag` = 16777216, `faction` = 2361, `unit_flags2` = 2048, `InhabitType` = 4 WHERE `entry` = 80577;
UPDATE `creature_template` SET `VehicleId` = 3593, `unit_flags` = 33570816, `unit_flags2` = 2048, `InhabitType` = 4 WHERE `entry` = 80578;
UPDATE `creature_template` SET `ScriptName` = 'npc_q34462' WHERE `entry` = 80582;

DELETE FROM `vehicle_template_accessory` WHERE `entry` = 80578;
INSERT INTO `vehicle_template_accessory` (`entry`,`accessory_entry`,`seat_id`,`minion`,`description`,`summontype`,`summontimer`) VALUES
(80578,80577,0,1,'Rope Bunny - Olin Umberhide (captif)',8,0);

DELETE FROM `npc_spellclick_spells` WHERE `npc_entry` = 80577;
INSERT INTO `npc_spellclick_spells` (`npc_entry`,`spell_id`,`cast_flags`,`user_type`) VALUES
(80577,162720,3,0);

DELETE FROM `creature` WHERE `guid` = 290401792;
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`dynamicflags`,`ScriptName`,`movementmode`,`VerifiedBuild`) VALUES
(290401792,80578,1116,6720,6966,'0',0,3311,0,-1,0,0,5709.61,4001.04,70.6441,4.02747,120,0,0,1,0,0,0,0,0,0,0,'',0,0); -- LC 345237

-- Phase 3311 « Draenor. Q34462 » (LC phase_definitions zone 6720 entree 14 :
-- quete 34462 prise et pas rendue).
DELETE FROM `phase_area` WHERE `AreaId` = 6720 AND `PhaseId` = 3311;
INSERT INTO `phase_area` (`AreaId`,`PhaseId`,`Comment`) VALUES (6720,3311,'Frostfire Ridge - Winds of Change (34462) - Olin captif');
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 26 AND `SourceGroup` = 3311 AND `SourceEntry` = 6720;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(26,3311,6720,0,0,47,0,34462,10,0,0,0,0,'','Phase 3311 - Winds of Change en cours ou terminee, pas rendue (LC)');

-- AJOUT DE PRUDENCE (pas dans LC, qui masque le captif en C++ avec une API
-- absente chez nous) : un seul clic utile, tant que l'objectif n'est pas fait.
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 18 AND `SourceGroup` = 80577 AND `SourceEntry` = 162720;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(18,80577,162720,0,0,47,0,34462,8,0,0,0,0,'','Olin captif - clic seulement si Winds of Change en cours');

-- Texte de 80582 (LC creature_text, BroadcastText 82767 present dans dc_hotfixes)
DELETE FROM `creature_text` WHERE `CreatureID` = 80582;
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`,`TextRange`,`comment`) VALUES
(80582,0,0,'You have my thanks once again, commander. These fiends were going to eat me alive. I will meet you back at the garrison.',12,0,100,5,0,0,82767,0,'Olin Umberhide to Player');

-- ---------------------------------------------------------------------
-- 4. La mine n'existe qu'à partir du fief niveau 2
-- Sources :
--   * GarrSiteLevelPlotInst.db2 : le terrain 59 (la mine) n'existe pas au niveau 258
--     (Horde, niveau 1, carte 1152). Il existe aux niveaux 445 (niveau 2, carte 1330) et 259 (niveau 3, carte 1153).
--   * vmaps de la carte 1152 : elles contiennent 6Or_Garrison_Mine_V0_Snow.wmo, la mine scellée.
--     Les cartes 1330 et 1153 ne l'ont pas.
--   * Wowpedia, « Frostwall Mine » : disponible quand le fief passe au niveau 2.
--   * LegionCore : Gorsol, Stonetooth et les 8 goren n'apparaissent que sur le terrain 59
--     vide (garrison_building_creature, plotID 59, BuildID 0, carte 1330).
--     LC garde Gorsol sur la carte 1152, mais avec des phases que le fief ne donne pas.
-- Gorsol reste pose en dur sur la carte 1152 (sans phase) : on interdit donc la quête sur la carte du niveau 1. Ce n'est pas une donnée officielle :
-- c'est la traduction en condition de la règle officielle.
-- ---------------------------------------------------------------------
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=19 AND `SourceEntry` IN (35154,34192) AND `ConditionTypeOrReference`=22;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(19,0,35154,0,0,22,0,1152,0,0,1,0,0,'','Things Are Not Goren Our Way (H) - pas sur la carte du fief niveau 1 (GarrSiteLevelPlotInst : pas de terrain 59 au niveau 258)'),
(19,0,34192,0,0,22,0,1158,0,0,1,0,0,'','Things Are Not Goren Our Way (A) - pas sur la carte du fief niveau 1 (GarrSiteLevelPlotInst : pas de terrain 59 au niveau 5)');

-- (Les cibles de la mine viennent des tables garrison_building_* de la partie B : parcelle 59 vide, carte 1330.)

-- ---------------------------------------------------------------------
-- 5. Bron Skyhorn (79407) : menu 42010 absent, donc pas de vol de quête vers Talador
-- Source : LegionCore (creature_template.gossip_menu_id, gossip_menu_option, conditions 15/42010 et smart_scripts 79407).
-- Textes : broadcast_text 12271, 83474, 87851, 83511 et 87474 (le français est déjà dans dc_hotfixes).
-- L'option 4 (Spires of Arak, BroadcastText 91501) n'est pas reprise : LC ne lui attache aucune action.
-- Les sorts viennent de SpellEffect.db2 :
--   * 164201 : SEND_TAXI chemin 4263 (fief > Talador) + KILL_CREDIT 81426, qui valide l'objectif de 34681/36953.
--   * 172428 : SEND_TAXI chemin 4600 + KILL_CREDIT 79407 + DISCOVER_TAXI 1408/1432 (Warspear).
--   * 164317 : SEND_TAXI chemin 4270 (vers Nagrand) + KILL_CREDIT 81563.
--   * 179346 : SEND_TAXI chemin 4958 (quais de Fer) + KILL_CREDIT 79407.
-- ---------------------------------------------------------------------
UPDATE `creature_template` SET `gossip_menu_id`=42010 WHERE `entry`=79407;

DELETE FROM `gossip_menu_option` WHERE `MenuId`=42010;
INSERT INTO `gossip_menu_option` (`MenuId`,`OptionIndex`,`OptionIcon`,`OptionText`,`OptionBroadcastTextId`,`OptionType`,`OptionNpcFlag`,`VerifiedBuild`) VALUES
(42010,0,2,'Show me where I can fly.',12271,4,8192,0),
(42010,1,0,'Take me to my base in Talador.',83474,1,1,0),
(42010,2,0,'Take me to Ashran.',87851,1,1,0),
(42010,3,0,'I need a flight to the border of Nagrand.',83511,1,1,0),
(42010,5,0,'I am needed urgently at the Iron Docks.',87474,1,1,0);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=42010;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(15,42010,1,0,0,28,0,36953,0,0,0,0,0,'','Bron Skyhorn - Talador si 36953 complete (LC)'),
(15,42010,1,0,1,28,0,34681,0,0,0,0,0,'','Bron Skyhorn - Talador si 34681 complete (LC)'),
(15,42010,2,0,0,9,0,36706,0,0,0,0,0,'','Bron Skyhorn - Ashran si 36706 en cours (LC)'),
(15,42010,3,0,0,28,0,36952,0,0,0,0,0,'','Bron Skyhorn - Nagrand si 36952 complete (LC)'),
(15,42010,3,0,1,28,0,34794,0,0,0,0,0,'','Bron Skyhorn - Nagrand si 34794 complete (LC)'),
(15,42010,5,0,0,28,0,38568,0,0,0,0,0,'','Bron Skyhorn - Quais de Fer si 38568 complete (LC)');

-- Supprimé : l'ancien id 0 (choix 79407/0 → liste 79407 → téléportation vers la carte 962).
-- Il était mort, car le menu 79407 n'existe pas, et ne vient d'aucune source.
-- Conservé : l'id 1 (au bonjour, crédit 79407 pour 36706), ajouté par nous plus tôt.
DELETE FROM `smart_scripts` WHERE `entryorguid`=79407 AND `source_type`=9;
DELETE FROM `smart_scripts` WHERE `entryorguid`=79407 AND `source_type`=0 AND `id` IN (0,2,3,4);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`event_param_string`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(79407,0,0,0,62,0,100,0,42010,1,0,0,0,'',85,164201,0,0,0,0,0,7,0,0,0,0,0,0,0,'Bron Skyhorn - Choix 1 - Vol vers Talador (LC)'),
(79407,0,2,0,62,0,100,0,42010,2,0,0,0,'',85,172428,0,0,0,0,0,7,0,0,0,0,0,0,0,'Bron Skyhorn - Choix 2 - Vol vers Ashran (LC)'),
(79407,0,3,0,62,0,100,0,42010,3,0,0,0,'',85,164317,0,0,0,0,0,7,0,0,0,0,0,0,0,'Bron Skyhorn - Choix 3 - Vol vers Nagrand (LC)'),
(79407,0,4,0,62,0,100,0,42010,5,0,0,0,'',85,179346,0,0,0,0,0,7,0,0,0,0,0,0,0,'Bron Skyhorn - Choix 5 - Vol vers les quais de Fer (LC)');

