-- =====================================================================
-- Zone de départ Chasseur de démons — objectifs de quête que RIEN
-- n'accordait
--
-- Audit du 22/08/2026. Quatre objectifs OBLIGATOIRES n'avaient aucune
-- source sur tout le serveur : ni créature apparue, ni `KillCredit` de
-- créature, ni `smart_scripts` action 33, ni script C++ rattaché. Les
-- quêtes concernées étaient donc impossibles à terminer sans commande GM.
--
--   38690 « Le soulèvement des Illidari » — crédit 96762 × 8
--   38672 « La gangr'évasion »            — crédits 92848 et 92849
--   38723 / 40253 « Arrêtez Gul'dan ! »   — crédit 99303
--   38689 « Infusion gangrenée »          — crédit 89297 × 100
--
-- Les crédits FACULTATIFS restent sans source et le restent volontairement :
-- ils portent le drapeau 0x04 (OPTIONNEL) et 0x08 (MASQUÉ), n'apparaissent
-- pas dans le journal et n'empêchent pas la validation. Il s'agit des huit
-- Illidari nommés de 38690 (97614 à 97622) et des quatre compteurs de la
-- barre « War progress » de 38819. Les rattacher demanderait d'inventer
-- quelle cellule enferme quel personnage : la donnée n'existe pas ici.
-- =====================================================================


-- ---------------------------------------------------------------------
-- 1. « Le soulèvement des Illidari » — les huit cellules des Gardiennes
--
-- L'objet 244588 « Warden Cell » est bien posé HUIT fois sur la carte
-- 1468, aux emplacements attendus. Mais il était totalement inerte :
-- type 10 (levier), AUCUN `AIName`, aucun `ScriptName`, aucune ligne
-- `smart_scripts`, et tous ses champs `Data` à zéro sauf `Data10` = 193119
-- (le sort « Déverrouillage », 0,8 s d'incantation) qui ne produit qu'une
-- animation. Cliquer sur une cellule ne déclenchait donc rien.
--
-- Huit cellules pour un objectif de huit prisonniers libérés : la
-- correspondance est directe, il n'y a rien à deviner.
--
-- Le motif employé est celui d'une cage déjà fonctionnelle sur ce
-- serveur, « Scourge Cage » 187854 : évènement 70 (changement d'état de
-- butin) avec paramètre 2 (GO_ACTIVATED), action 33 (crédit) sur la
-- cible 7 (celui qui a cliqué). Le verrou de 244588 est nul et
-- `playerCast` vaut 1 : l'objet est utilisable tel quel.
--
-- Pas de disparition après usage : `AllowMultiInteract` vaut 1 dans les
-- données d'origine de Blizzard (plusieurs joueurs peuvent libérer le
-- même prisonnier) et le délai de réapparition est de 7200 s — faire
-- disparaître une cellule la retirerait deux heures à tout le monde.
-- ---------------------------------------------------------------------
UPDATE `gameobject_template` SET `AIName`='SmartGameObjectAI' WHERE `entry`=244588;

DELETE FROM `smart_scripts` WHERE `source_type`=1 AND `entryorguid`=244588;
INSERT INTO `smart_scripts`
 (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,
  `event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`event_param_string`,
  `action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,
  `target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(244588,1,0,0,70,0,100,0, 2,0,0,0,0,'', 33,96762,0,0,0,0,0, 7,0,0,0, 0,0,0,0,
 'Warden Cell - Activee - Credit Illidari Prisoner (quete 38690)');


-- ---------------------------------------------------------------------
-- 2. « La gangr'évasion » — cellules de Kayn et d'Altruis
--
-- 103655 « Altruis's Cell » et 103658 « Kayn's Cell » possèdent déjà un
-- SmartAI complet : à la réapparition elles reçoivent le drapeau de clic
-- de sort, et au clic elles lancent une liste d'actions (10365500 /
-- 10365800) qui les fait disparaître, place une donnée sur l'Illidari
-- libéré et lui envoie la cible. Il n'y manquait QUE le crédit.
--
-- Le script C++ prévu pour cela (`npc_kayn_cell`, `npc_altruis_cell`)
-- n'aurait rien réglé : il n'est rattaché à aucune créature, ses lignes
-- de crédit sont en commentaire, et les entrées qu'il cite (99326,
-- 112276, 112277, 112287) ne sont PAS celles des objectifs de la quête.
-- On ajoute donc le crédit là où le reste fonctionne déjà, sans toucher
-- aux lignes existantes.
--
--   92848 = « Kayn Sunfury »        -> objectif 1, cellule de Kayn 103658
--   92849 = « Altruis the Sufferer » -> objectif 0, cellule d'Altruis 103655
-- ---------------------------------------------------------------------
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid` IN (103655,103658) AND `id`=10;
INSERT INTO `smart_scripts`
 (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,
  `event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`event_param_string`,
  `action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,
  `target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(103655,0,10,0,73,0,100,0, 0,0,0,0,0,'', 33,92849,0,0,0,0,0, 7,0,0,0, 0,0,0,0,
 'Altruis Cell 103655 - Au clic - Credit Altruis libere (quete 38672)'),
(103658,0,10,0,73,0,100,0, 0,0,0,0,0,'', 33,92848,0,0,0,0,0, 7,0,0,0, 0,0,0,0,
 'Kayn Cell 103658 - Au clic - Credit Kayn libere (quete 38672)');


-- ---------------------------------------------------------------------
-- 3. « Arrêtez Gul'dan ! » — crédit « Face Gul'dan » (99303)
--
-- Sur les serveurs officiels une scène se joue à l'acceptation de la
-- quête ; le crédit tombe à sa fin. Ce core possède bien le script
-- correspondant (`scene_guldan_stealing_illidan_corpse`, scène 1016) mais
-- il est INAPPLICABLE : `scene_template` ne contient aucune ligne pour la
-- scène 1016, et `SceneMgr::PlayScene` abandonne silencieusement quand la
-- scène est inconnue. Impossible d'ajouter cette ligne sans le véritable
-- `ScriptPackageID` du client, que rien ici ne permet de déduire (les
-- correspondances connues — 1053→1451, 1061→1460, 1106→1487 — ne suivent
-- aucune règle).
--
-- Or Maiev reproduit DÉJÀ la scène par SmartAI : sa liste d'actions
-- 9271800 lance les deux mêmes sorts puis téléporte à (4084, -298, -282),
-- exactement la destination codée dans le script C++. Seul le crédit
-- manquait. On l'ajoute au bon moment : juste avant la téléportation,
-- comme le fait `OnSceneEnd`.
--
-- La liste est réécrite en entier pour insérer l'action au bon rang ;
-- les trois actions d'origine sont conservées à l'identique, y compris
-- le délai de 100 s qui correspond à la durée de la scène.
-- ---------------------------------------------------------------------
DELETE FROM `smart_scripts` WHERE `source_type`=9 AND `entryorguid`=9271800;
INSERT INTO `smart_scripts`
 (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,
  `event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`event_param_string`,
  `action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,
  `target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(9271800,9,0,0,0,0,100,0, 0,0,0,0,0,'', 85,223661,0,0,0,0,0, 7,0,0,0, 0,0,0,0,
 'Maiev Shadowsong 92718 - Script - Invocateur lance 223661'),
(9271800,9,1,0,0,0,100,0, 0,0,0,0,0,'', 85,187864,0,0,0,0,0, 7,0,0,0, 0,0,0,0,
 'Maiev Shadowsong 92718 - Script - Invocateur lance 187864'),
(9271800,9,2,0,0,0,100,0, 100000,100000,0,0,0,'', 33,99303,0,0,0,0,0, 7,0,0,0, 0,0,0,0,
 'Maiev Shadowsong 92718 - Script - Credit Face Guldan (quetes 38723/40253)'),
(9271800,9,3,0,0,0,100,0, 0,0,0,0,0,'', 62,1468,0,0,0,0,0, 7,0,0,0,
 4084.52,-297.89,-282.28,3.132,
 'Maiev Shadowsong 92718 - Script - Teleportation dans la chambre');


-- ---------------------------------------------------------------------
-- 4. « Infusion gangrenée » — 100 points d'énergie sur les démons
--
-- Texte de la quête : « The Vault is overrun with demons. Kill them and
-- gather their souls to regain your strength. »
--
-- Le script C++ prévu (`npc_fel_infusion`) accorde +10 d'énergie et DIX
-- crédits 89297 par démon tué — soit dix démons pour les 100 points.
-- Il n'est rattaché à rien, et le rattacher écraserait le SmartAI de deux
-- des quatre démons concernés. On reproduit donc son comportement en
-- données.
--
-- Les quatre démons du caveau (type 3 = démon, faction 954, présents
-- UNIQUEMENT sur la carte 1468, 122 apparitions au total) :
--   92782 Savage Felstalker  (70)   SmartAI déjà présent
--   97225 Wrathguard Legate  (29)   pas d'IA -> SmartAI ajouté
--   92776 Fel Shocktrooper   (17)   SmartAI déjà présent
--   97228 Abyssal Shard      ( 6)   pas d'IA -> SmartAI ajouté
-- « Safety Net » 103093, également de type 3, est écarté : faction 35,
-- c'est un élément de décor.
--
-- Cible 0 (SMART_TARGET_NONE) et non 7 : sur l'action 33, ce cas passe
-- par `RewardPlayerAndGroupAtEvent`, qui crédite le destinataire du butin
-- ET son groupe. C'est le comportement correct en groupe.
--
-- Dix lignes par démon plutôt qu'une liste d'actions appelée à la mort :
-- une liste temporisée sur une créature en train de mourir n'a aucune
-- garantie d'aller à son terme.
--
-- Les identifiants 20 à 29 sont libres sur les quatre entrées.
-- ---------------------------------------------------------------------
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry` IN (97225,97228) AND `AIName`='';

DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid` IN (92782,92776,97225,97228) AND `id` BETWEEN 20 AND 29;
INSERT INTO `smart_scripts`
 (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,
  `event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`event_param_string`,
  `action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,
  `target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`)
SELECT d.entry, 0, 20+n.i, 0, 6, 0, 100, 0,
       0,0,0,0,0,'',
       33, 89297, 0,0,0,0,0,
       0,0,0,0, 0,0,0,0,
       CONCAT(d.nom,' - A la mort - Credit Energie gangrenee (quete 38689)')
FROM (SELECT 92782 entry,'Savage Felstalker' nom UNION ALL
      SELECT 97225,'Wrathguard Legate'  UNION ALL
      SELECT 92776,'Fel Shocktrooper'   UNION ALL
      SELECT 97228,'Abyssal Shard') d
CROSS JOIN (SELECT 0 i UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
            UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) n;
