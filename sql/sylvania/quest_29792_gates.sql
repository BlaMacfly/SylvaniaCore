-- =====================================================================
-- Quête 29792 « Voués à la grandeur » — portes de Mandori et Pei-Wu
--
-- Le mécanisme d'ouverture n'existait tout simplement pas :
--   * Les deux crédits de quête existent (59946 « Forest Door One Credit »
--     et 59947 « Forest Door Two Credit ») mais RIEN dans la base ne les
--     accordait.
--   * Les portes sont des gameobject de type 0 (porte) : non cliquables par
--     un joueur, elles ne s'ouvrent que par script.
--   * Les compagnons censés escorter le joueur et ouvrir les portes (Aysa
--     59962, Ji 59960, Jojo 59963, présents près de Mandori) n'ont AUCUNE
--     IA (ni AIName, ni ScriptName, ni smart_scripts).
--   * Chaque emplacement porte deux objets empilés — une version ouverte et
--     une fermée — que le phasing retail sépare mais qui sont tous deux en
--     PhaseId 0 ici. D'où le symptôme : une porte semble ouverte, l'autre
--     bloque et ne réagit à rien.
--   Bug connu des serveurs privés (fil EmuCoach « Wandering Isle gate in
--   Mandori Village not opening due to Phasemask »).
--
-- Correctif : un déclencheur invisible dédié devant chaque porte accorde le
-- crédit et ouvre la porte quand un joueur s'approche à 12 m.
-- Choix d'implémentation : entrée custom 900000 (et non l'Invisible Stalker
-- 15214 partagé) pour ne pas ajouter SmartAI à un template utilisé partout
-- dans le monde ; scripts attachés aux GUID pour différencier les 2 portes.
-- Nécessite un redémarrage (les spawns ne sont lus qu'au démarrage).
-- Validé en jeu.
-- =====================================================================

DELETE FROM `creature_template` WHERE `entry`=900000;
INSERT INTO `creature_template` (`entry`,`name`,`subname`,`minlevel`,`maxlevel`,`faction`,`npcflag`,`speed_walk`,`speed_run`,`scale`,`rank`,`unit_class`,`unit_flags`,`unit_flags2`,`type`,`type_flags`,`flags_extra`,`AIName`,`modelid1`,`HealthModifier`,`ManaModifier`,`ArmorModifier`,`DamageModifier`,`ExperienceModifier`,`RegenHealth`,`MovementType`,`VerifiedBuild`) VALUES
(900000,'Pei-Wu Gate Trigger','',1,1,35,0,1,1.14286,1,0,1,33554432,0,10,0,128,'SmartAI',1126,1,1,1,1,1,1,0,0);

DELETE FROM `creature` WHERE `guid` IN (290000003, 290000004);
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`PhaseId`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`MovementType`) VALUES
(290000003,900000,860,0,0,'0',0,695.26,3601.00,142.38,3.03626,300,0),
(290000004,900000,860,0,0,'0',0,566.52,3583.47,92.16,3.13054,300,0);

DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid` IN (-290000003, -290000004);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(-290000003,0,0,0,10,0,100,0,1,12,4000,6000,33,59946,0,0,0,0,0,7,0,0,0,0,0,0,0,'Porte Mandori - joueur a proximite - credit 59946'),
(-290000003,0,1,0,10,0,100,0,1,12,4000,6000,9,0,0,0,0,0,0,20,210965,25,0,0,0,0,0,'Porte Mandori - joueur a proximite - ouvrir la porte'),
(-290000004,0,0,0,10,0,100,0,1,12,4000,6000,33,59947,0,0,0,0,0,7,0,0,0,0,0,0,0,'Porte Pei-Wu - joueur a proximite - credit 59947'),
(-290000004,0,1,0,10,0,100,0,1,12,4000,6000,9,0,0,0,0,0,0,20,210964,25,0,0,0,0,0,'Porte Pei-Wu - joueur a proximite - ouvrir la porte');
