-- ============================================================
-- Campagne moine — intro « Before the Storm » (12103)
-- + scénario « Serenity's End » (943, map 1014)
-- + choix d'artefact via PlayerChoice 242 (Ponshu)
-- ============================================================

-- 1) Réactiver la quête d'intro (elle était dans disables) et la réserver aux moines
DELETE FROM disables WHERE sourceType=1 AND entry=12103;
UPDATE quest_template_addon SET AllowableClasses=512 WHERE ID IN (12103,40236,40793,40638,40639,40640);

-- 2) Da-Nel : donneur de 12103, IA liée, spawn à Dalaran (Aire de Krasus, près du maître de vol)
REPLACE INTO creature_queststarter (id, quest) VALUES (98519, 12103);
UPDATE creature_template SET ScriptName='npc_initiate_da_nel', npcflag=npcflag|2, minlevel=100, maxlevel=100 WHERE entry=98519;
DELETE FROM creature WHERE guid=290000001;
INSERT INTO creature (guid, id, map, zoneId, areaId, spawnDifficulties, position_x, position_y, position_z, orientation, spawntimesecs, curhealth)
VALUES (290000001, 98519, 1220, 0, 0, '0', -858.5, 4295.0, 745.4, 2.30, 300, 1);

-- 3) Scénario : rattachement map 1014 -> scénario 943 (les 2 factions) + script d'instance
REPLACE INTO scenarios (map, difficulty, scenario_A, scenario_H, zoneid) VALUES (1014, 0, 943, 943, 0);
UPDATE instance_template SET script='scenario_monk_serenitys_end' WHERE map=1014;

-- 4) Gabarits créatures du scénario
-- hostiles (gabarits stub importés à 1/1 faction 35)
UPDATE creature_template SET faction=16, minlevel=98, maxlevel=100
 WHERE entry IN (98011,98286,105256,97966,98785,98505,98496,97811,97968);
UPDATE creature_template SET faction=16, minlevel=100, maxlevel=100, HealthModifier=GREATEST(HealthModifier*6,6), `rank`=1 WHERE entry=98217;
UPDATE creature_template SET faction=16, minlevel=100, maxlevel=100, HealthModifier=GREATEST(HealthModifier*4,4), unit_flags=unit_flags|4 WHERE entry=98353;
-- Keletress : projection intouchable (IMMUNE_TO_PC|NON_ATTACKABLE)
UPDATE creature_template SET faction=16, minlevel=110, maxlevel=110, unit_flags=unit_flags|258 WHERE entry=104755;
-- amicaux : niveaux corrects + Chen scénario
UPDATE creature_template SET minlevel=100, maxlevel=100 WHERE entry IN (97778,98515,97777,97774,98939,97954,97958,97679,98001,98074);
UPDATE creature_template SET faction=35, minlevel=102, maxlevel=102 WHERE entry=100307;

-- liaisons ScriptName (entrées sans spawn ailleurs, vérifié)
UPDATE creature_template SET npcflag=npcflag|1, ScriptName='npc_serenity_master_hight'   WHERE entry=97778;
UPDATE creature_template SET npcflag=npcflag|1, ScriptName='npc_serenity_number_nine_jia' WHERE entry=98939;
UPDATE creature_template SET ScriptName='npc_serenity_infernal_destroyer' WHERE entry=98011;
UPDATE creature_template SET ScriptName='npc_serenity_vizznak'   WHERE entry=97968;
UPDATE creature_template SET ScriptName='npc_serenity_morvath'   WHERE entry=97811;
UPDATE creature_template SET ScriptName='npc_serenity_invader'   WHERE entry=98496;
UPDATE creature_template SET ScriptName='npc_serenity_jorvinax'  WHERE entry=98217;
UPDATE creature_template SET ScriptName='npc_serenity_fel_stone' WHERE entry=98353;
UPDATE creature_template SET ScriptName='npc_serenity_chen'      WHERE entry=100307;

-- 5) Textes FR du scénario
DELETE FROM creature_text WHERE CreatureID IN (98519,97778,98001,104755,98939,100307,98217,98515);
INSERT INTO creature_text (CreatureID, GroupID, ID, Text, Type, Language, Probability, Emote, Duration, Sound, BroadcastTextId, TextRange, comment) VALUES
(98519, 0, 0, 'Maître ! Grand Maître Hight vous demande au pic de la Sérénité. C''est urgent !', 12, 0, 100, 1, 0, 0, 0, 0, 'Da-Nel salut'),
(98519, 1, 0, 'Que les vents vous portent, maître. Le pèlerinage zen vous y conduira !', 12, 0, 100, 66, 0, 0, 0, 0, 'Da-Nel accept'),
(97778, 0, 0, 'Ah, te voilà. Le conseil peut commencer.', 12, 0, 100, 1, 0, 0, 0, 0, 'Hight accueil'),
(97778, 1, 0, 'Maîtres, la Légion ardente a écrasé nos armées au Rivage Brisé. L''heure est grave : nous devons décider de l''avenir de notre ordre.', 12, 0, 100, 1, 0, 0, 0, 0, 'Hight conseil'),
(97778, 2, 0, 'Par les Célestes ! Défendez le temple !', 14, 0, 100, 5, 0, 0, 0, 0, 'Hight attaque'),
(97778, 3, 0, 'File au sanctuaire de la Grue, au nord ! Nos frères sont en danger !', 14, 0, 100, 25, 0, 0, 0, 0, 'Hight ordre'),
(98001, 0, 0, 'Des démons ! Des démons surgissent de part--', 14, 0, 100, 5, 0, 0, 0, 0, 'Chuang alerte'),
(104755, 0, 0, 'Je te vois, moine ! Ta résistance est vaine.', 14, 0, 100, 0, 0, 0, 0, 0, 'Keletress 1'),
(104755, 1, 0, 'Ce temple brûlera, comme tout ce que vous chérissez.', 14, 0, 100, 0, 0, 0, 0, 0, 'Keletress 2'),
(104755, 2, 0, 'Jorvinax ! Débarrasse-moi de ces insectes !', 14, 0, 100, 0, 0, 0, 0, 0, 'Keletress 3'),
(98939, 0, 0, 'Vizznak est à moi ! Protège les parchemins sacrés !', 14, 0, 100, 0, 0, 0, 0, 0, 'Jia combat'),
(98939, 1, 0, 'Je vais concentrer mon chi pour t''envoyer de l''autre côté. Chen et ses élèves ont besoin de toi ! Parle-moi quand tu es prêt.', 12, 0, 100, 1, 0, 0, 0, 0, 'Jia teleport'),
(100307, 0, 0, 'Hé ! Par ici !', 14, 0, 100, 22, 0, 0, 0, 0, 'Chen appel'),
(100307, 1, 0, 'Tu as de la force, mais il te manque de la vitesse !', 12, 0, 100, 0, 0, 0, 0, 0, 'Chen reprise'),
(100307, 2, 0, 'Merci, l''ami. Ramenons les petits en lieu sûr, vite !', 12, 0, 100, 1, 0, 0, 0, 0, 'Chen escorte'),
(100307, 3, 0, 'Une embuscade ! Protégez les enfants !', 14, 0, 100, 5, 0, 0, 0, 0, 'Chen embuscade'),
(98217, 0, 0, 'Mortels pathétiques ! Les armées de la Légion vous écraseront !', 14, 0, 100, 15, 0, 0, 0, 0, 'Jorvinax aggro'),
(98217, 1, 0, 'Keletress... le portail... doit tenir...', 14, 0, 100, 0, 0, 0, 0, 0, 'Jorvinax mort'),
(98515, 0, 0, 'Cette pierre gangrenée alimente le portail. Détruis-la !', 14, 0, 100, 25, 0, 0, 0, 0, 'Hight pierre'),
(98515, 1, 0, 'Le pic est perdu... mais l''ordre survivra. Repliez-vous sur l''île Vagabonde !', 14, 0, 100, 1, 0, 0, 0, 0, 'Hight fin');

-- 6) Île Vagabonde : crédits de la quête 40236 « The Dawning Light »
-- Jang (99181) crédite « Accompany Fearsome Jang » à l'acceptation ;
-- Jia (100355) crédite « Establish the Order » quand le joueur arrive près d'elle.
UPDATE creature_template SET AIName='SmartAI' WHERE entry IN (99181,100355);
DELETE FROM smart_scripts WHERE entryorguid IN (99181,100355) AND source_type=0;
INSERT INTO smart_scripts (entryorguid, source_type, id, link, event_type, event_phase_mask, event_chance, event_flags, event_param1, event_param2, event_param3, event_param4, action_type, action_param1, action_param2, action_param3, action_param4, action_param5, action_param6, target_type, target_param1, target_param2, target_param3, target_x, target_y, target_z, target_o, comment) VALUES
(99181, 0, 0, 0, 19, 0, 100, 0, 40236, 0, 0, 0, 33, 99181, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Fearsome Jang - quete 40236 acceptee - credit accompagnement'),
(100355, 0, 0, 0, 10, 0, 100, 0, 1, 10, 15000, 15000, 33, 100355, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Number Nine Jia - joueur proche - credit fondation de l''ordre');

-- 7) PlayerChoice 242 (choix d'artefact moine) : textes FR (base importée en russe)
UPDATE playerchoice SET Question='Quelle arme devons-nous rechercher en priorité ?' WHERE ChoiceId=242;
UPDATE playerchoice_response SET header='Tisse-brume',        answer='Choisir' WHERE choiceId=242 AND responseId=241;
UPDATE playerchoice_response SET header='Maître brasseur',    answer='Choisir' WHERE choiceId=242 AND responseId=242;
UPDATE playerchoice_response SET header='Marche-vent',        answer='Choisir' WHERE choiceId=242 AND responseId=243;

-- 8) PNJ critiques pour la progression du scénario : PV blindés (anti soft-lock)
UPDATE creature_template SET HealthModifier=GREATEST(HealthModifier*20,20) WHERE entry IN (98939,98515,100307,97778);
