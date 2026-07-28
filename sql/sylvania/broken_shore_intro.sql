-- ============================================================
-- Intro Îles Brisées — scénario « The Battle for Broken Shore »
-- (786, map 1460) pour les 2 factions
-- Alliance : 42740 (Dameron → Angelica → scénario → Genn à Dalaran)
-- Horde    : 44543 (Holgar Stormaxe au dock d'Orgrimmar → scénario → Eitrigg)
-- ============================================================

-- 1) Rattachement scénario + script d'instance
REPLACE INTO scenarios (map, difficulty, scenario_A, scenario_H, zoneid) VALUES (1460, 0, 786, 786, 0);
UPDATE instance_template SET script='scenario_broken_shore_intro' WHERE map=1460;

-- 2) Gabarits : boss et acteurs (stubs importés à 1/1 faction 35)
UPDATE creature_template SET faction=16, minlevel=100, maxlevel=100, HealthModifier=GREATEST(HealthModifier*8,8),  `rank`=1 WHERE entry=90705;  -- Arganoth
UPDATE creature_template SET faction=16, minlevel=102, maxlevel=102, HealthModifier=GREATEST(HealthModifier*15,15), `rank`=3 WHERE entry=90544; -- Krosus
UPDATE creature_template SET faction=16, minlevel=103, maxlevel=103, HealthModifier=GREATEST(HealthModifier*10,10), unit_flags=unit_flags|768 WHERE entry=90413; -- Gul'dan (intouchable)
UPDATE creature_template SET faction=16, minlevel=100, maxlevel=100, HealthModifier=GREATEST(HealthModifier*3,3), unit_flags=unit_flags|4 WHERE entry=90637; -- Ancre dimensionnelle
-- chefs de faction (props d'événement, indestructibles dans les faits)
UPDATE creature_template SET faction=35, minlevel=103, maxlevel=103, HealthModifier=GREATEST(HealthModifier*30,30) WHERE entry IN (90707,90708,90709,90710,90711,90713,90714,90716,90717,90367);
-- troupes
UPDATE creature_template SET faction=35, minlevel=100, maxlevel=100, HealthModifier=GREATEST(HealthModifier*5,5) WHERE entry IN (90750,90751);

-- 3) Cimetières du scénario (aucun graveyard_zone n'existait pour la map 1460)
DELETE FROM graveyard_zone WHERE GhostZone IN (7534,7547,7624,8120,8290,8437,8452,8453,8454);
INSERT INTO graveyard_zone (ID, GhostZone, Faction, Comment) VALUES
(5025, 7534, 469, 'Broken Shore scenario - A city'),   (5684, 7534, 67, 'Broken Shore scenario - H city'),
(5021, 8290, 469, 'Broken Shore scenario - A beach'),  (5682, 8290, 67, 'Broken Shore scenario - H beach'),
(5025, 8437, 469, 'Broken Shore scenario - A nml'),    (5684, 8437, 67, 'Broken Shore scenario - H nml'),
(5025, 7547, 469, 'Broken Shore scenario - A cityA'),  (5684, 7547, 67, 'Broken Shore scenario - H cityA'),
(5025, 8454, 469, 'Broken Shore scenario - A cityH'),  (5684, 8454, 67, 'Broken Shore scenario - H cityH'),
(5027, 7624, 469, 'Broken Shore scenario - A tombA'),  (5686, 7624, 67, 'Broken Shore scenario - H tombA'),
(5027, 8452, 469, 'Broken Shore scenario - A tombH'),  (5686, 8452, 67, 'Broken Shore scenario - H tombH'),
(5026, 8120, 469, 'Broken Shore scenario - A appA'),   (5685, 8120, 67, 'Broken Shore scenario - H appA'),
(5026, 8453, 469, 'Broken Shore scenario - A appH'),   (5685, 8453, 67, 'Broken Shore scenario - H appH');

-- 4) Entrée Horde : Holgar Stormaxe donne 44543 et téléporte à l'acceptation
REPLACE INTO creature_queststarter (id, quest) VALUES (4311, 44543);
UPDATE creature_template SET AIName='SmartAI' WHERE entry=4311;
DELETE FROM smart_scripts WHERE entryorguid=4311 AND source_type=0;
INSERT INTO smart_scripts (entryorguid, source_type, id, link, event_type, event_phase_mask, event_chance, event_flags, event_param1, event_param2, event_param3, event_param4, action_type, action_param1, action_param2, action_param3, action_param4, action_param5, action_param6, target_type, target_param1, target_param2, target_param3, target_x, target_y, target_z, target_o, comment) VALUES
(4311, 0, 0, 0, 19, 0, 100, 0, 44543, 0, 0, 0, 62, 1460, 0, 0, 0, 0, 0, 7, 0, 0, 0, 525.4, 1967.5, 1.2, 5.9, 'Holgar Stormaxe - quete 44543 acceptee - teleport Rive Brisee');

-- 5) Rendeur Horde : Eitrigg au dock d''Orgrimmar (aucun spawn n''existait)
UPDATE creature_template SET npcflag=npcflag|2, minlevel=103, maxlevel=103 WHERE entry=100453;
DELETE FROM creature WHERE guid=290000002;
INSERT INTO creature (guid, id, map, zoneId, areaId, spawnDifficulties, position_x, position_y, position_z, orientation, spawntimesecs, curhealth)
VALUES (290000002, 100453, 1, 0, 0, '0', 1355.5, -4393.5, 29.2, 3.90, 300, 1);

-- 6) Textes FR du scénario
DELETE FROM creature_text WHERE CreatureID IN (90713,90708,90709,90714,90705,90367,90413);
INSERT INTO creature_text (CreatureID, GroupID, ID, Text, Type, Language, Probability, Emote, Duration, Sound, BroadcastTextId, TextRange, comment) VALUES
(90713, 0, 0, 'Soldats de l''Alliance ! La Légion s''abat sur nos terres. Repoussez-la jusqu''aux portes du tombeau de Sargeras !', 14, 0, 100, 5, 0, 0, 0, 0, 'Varian ralliement'),
(90713, 1, 0, 'Partez, sauvez ce qui peut l''être ! Dites à mon fils... que je suis mort en roi. Pour l''Alliance !', 14, 0, 100, 5, 0, 0, 0, 0, 'Varian sacrifice'),
(90708, 0, 0, 'Fils et filles de la Horde ! Montrez à la Légion c''que vaut not'' sang ! LOK''TAR OGAR !', 14, 0, 100, 5, 0, 0, 0, 0, 'Voljin ralliement'),
(90708, 1, 0, 'Argh... la lame... empoisonnée... Sylvanas... sonne la retraite...', 14, 0, 100, 0, 0, 0, 0, 0, 'Voljin blessé'),
(90709, 0, 0, 'La Horde ne mourra pas sur cette plage. Avancez, et que la Légion tombe !', 14, 0, 100, 25, 0, 0, 0, 0, 'Sylvanas'),
(90714, 0, 0, 'Leurs portails déversent des renforts sans fin ! Détruisez les ancres dimensionnelles !', 14, 0, 100, 5, 0, 0, 0, 0, 'Jaina portails'),
(90705, 0, 0, 'Vos armées ne sont que poussière. Je suis Arganoth, et cette plage sera votre tombeau !', 14, 0, 100, 15, 0, 0, 0, 0, 'Arganoth spawn'),
(90705, 1, 0, 'La Légion... est... éternelle...', 14, 0, 100, 0, 0, 0, 0, 0, 'Arganoth mort'),
(90367, 0, 0, 'Ne vous souciez pas de moi ! Le tombeau... Gul''dan ouvre le tombeau ! Arrêtez-le !', 14, 0, 100, 5, 0, 0, 0, 0, 'Tirion crevasse'),
(90413, 0, 0, 'Vous arrivez trop tard ! Les ténèbres s''éveillent sous ce tombeau !', 14, 0, 100, 25, 0, 0, 0, 0, 'Guldan accueil'),
(90413, 1, 0, 'Sargeras... accueille leurs âmes !', 14, 0, 100, 25, 0, 0, 0, 0, 'Guldan invocation'),
(90413, 2, 0, 'Cette victoire ne changera rien. L''Étoile ardente approche !', 14, 0, 100, 25, 0, 0, 0, 0, 'Guldan retraite');
