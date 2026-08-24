-- =====================================================================
-- Sagesse de Mari — elle n'avait aucun dialogue, ni texte ni voix
--
-- Signalé en jeu : le boss est muet. Vérifié : `creature_text` ne
-- contenait AUCUNE ligne pour l'entrée 56448, alors que son script
-- appelle Talk() sept fois — intro, engagement, emote, appel de l'eau,
-- changement de phase, mort, victime. Chaque appel ne faisait rien.
--
-- D'OÙ VIENNENT LES DONNÉES
-- Les identifiants de sons ont été relevés sur la fiche Wowhead du PNJ
-- (section « sounds ») : VO_TJS_MARI_INTRO_01, _AGGRO_01,
-- _CALLWATER_SPELL_01/03/04, _PHASE2_START_01, _SLAY_01/02,
-- _DEATHEVENT_01/02/03. Chacun a ensuite été retrouvé dans la table
-- `broadcast_text` du serveur par son `SoundEntriesID1`, ce qui donne
-- l'identifiant de texte officiel correspondant.
--
-- Et les traductions françaises existent toutes déjà dans
-- `broadcast_text_locale` : « Vous osez déranger ces eaux ? Vous serez
-- submergés ! », « Les eaux… m'emportent… », etc. Rien n'est traduit à
-- la main ici.
--
-- On renseigne donc `BroadcastTextId` en plus du texte : le client
-- affichera la réplique dans SA langue et jouera la voix, quel que soit
-- le client du joueur. `Sound` est renseigné en doublon par sécurité.
--
-- ⚠️ LE GROUPE 2 RESTE VIDE, VOLONTAIREMENT
-- Le script appelle Talk(TEXT_BOSS_EMOTE_AGGRO) à l'engagement, mais
-- aucun texte d'emote n'existe pour ce boss, ni dans `broadcast_text`
-- ni côté Wowhead. Plutôt que d'inventer une phrase, on laisse le groupe
-- absent : l'appel restera sans effet et le serveur le signalera une
-- fois par pull, ce qui garde la lacune visible.
--
-- Les trois provocations (28269-28271, « Come in, the water's fine ! »)
-- ne sont pas reprises : le script ne prévoit aucun groupe pour elles.
--
-- Rechargeable à chaud : reload creature_text
-- =====================================================================

DELETE FROM `creature_text` WHERE `CreatureID`=56448;
INSERT INTO `creature_text`
 (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`,`TextRange`,`comment`) VALUES

-- groupe 0 : intro, quand un joueur approche
(56448,0,0,'Les eaux murmurent à mes oreilles… des ennemis approchent.',1,0,100,0,0,28265,55723,0,'Sagesse de Mari - intro'),

-- groupe 1 : engagement
(56448,1,0,'Vous osez déranger ces eaux ? Vous serez submergés !',1,0,100,0,0,28257,55118,0,'Sagesse de Mari - engagement'),

-- groupe 2 : ABSENT, aucun texte d'emote officiel (voir l'en-tête)

-- groupe 3 : appel de l'eau, trois répliques au hasard
(56448,3,0,'Source, prends vie !',1,0,100,0,0,28258,55606,0,'Sagesse de Mari - appel de l eau 1'),
(56448,3,1,'Montez !',1,0,100,0,0,28260,62958,0,'Sagesse de Mari - appel de l eau 2'),
(56448,3,2,'Eaux vivantes, donnez-leur la mort !',1,0,100,0,0,28261,62960,0,'Sagesse de Mari - appel de l eau 3'),

-- groupe 4 : passage en phase 2, quand le bouclier tombe
(56448,4,0,'Contemplez la puissance des torrents !',1,0,100,0,0,28266,55605,0,'Sagesse de Mari - phase 2'),

-- groupe 5 : mort, trois répliques au hasard
(56448,5,0,'Les ténèbres se dissipent…',1,0,100,0,0,28262,55719,0,'Sagesse de Mari - mort 1'),
(56448,5,1,'J''observe les eaux et mon reflet est vide…',1,0,100,0,0,28263,55720,0,'Sagesse de Mari - mort 2'),
(56448,5,2,'Les eaux… m''emportent…',1,0,100,0,0,28264,55721,0,'Sagesse de Mari - mort 3'),

-- groupe 6 : quand elle tue un joueur
(56448,6,0,'Comme les eaux l''avaient prédit.',1,0,100,0,0,28267,62988,0,'Sagesse de Mari - victime 1'),
(56448,6,1,'Votre cause est perdue.',1,0,100,0,0,28268,62989,0,'Sagesse de Mari - victime 2');
