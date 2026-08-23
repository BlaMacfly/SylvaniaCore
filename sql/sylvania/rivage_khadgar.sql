-- =====================================================================
-- Rivage brisé — la campagne du Déclin de la Légion ne démarrait pas
--
-- Suite de l'audit du 23/08/2026. Deux quêtes de la campagne n'avaient
-- NI donneur NI récepteur, et leur objectif commun n'avait aucune source :
--
--   46730 « Les armées du Déclin de la Légion »
--          objectif 0 : crédit 120215 « Meet Khadgar at Krasus' Landing »
--          -> RewardNextQuest 46734
--   46734 « L'assaut du rivage Brisé »
--          objectif 1 : crédit 120215 « Speak to Khadgar »
--
-- La chaîne 46730 -> 46734 était donc inaccessible de bout en bout : la
-- campagne du Déclin de la Légion ne pouvait pas commencer.
--
-- À QUEL KHADGAR ATTRIBUER LA CHAÎNE
-- L'entrée 120215 « Archmage Khadgar » (faction 2890) n'est posée nulle
-- part. Plutôt que d'ajouter un Khadgar de plus à Dalaran, on confie le
-- rôle à celui qui est déjà en place au bon endroit — même méthode que
-- pour Maiev au Caveau et pour Anduin sur son trône.
--
-- Le choix entre les trois Khadgar de Dalaran est tranché par leur
-- voisinage, pas au jugé :
--   86563  (-841, 4258, 746.3) -> Haut-seigneur Saurfang à 3,7 m, la
--          Table de commandement à 6,9 m, Danath Trollbane à 10,9 m.
--          C'est le conseil de guerre du Déclin de la Légion. RETENU.
--   91172  (-825, 4294) -> un trou de ver, Grif Sauvecoeur. Écarté.
--   90417  (-848, 4639) -> à 380 m, autre quartier. Écarté.
-- 86563 porte déjà npcflag 3 et donne/reçoit trois quêtes : il est
-- pleinement capable.
--
-- POURQUOI SON SmartAI FONCTIONNE
-- 86563 déclare `ScriptName = npc_khadgar_dalaran`, mais **ce script
-- n'existe nulle part dans le core** : c'est un nom fantôme. Or
-- `FactorySelector` teste le ScriptName d'abord et ne retombe sur
-- l'AIName que si le script est introuvable — c'est le cas ici, donc son
-- `AIName = SmartAI` reste actif. La ligne 0 existante (téléportation au
-- choix de dialogue) le confirme. On ajoute la ligne 1 sans y toucher.
-- (Relevé au passage : 42 ScriptName du serveur n'ont aucune
--  implémentation. À auditer séparément.)
--
-- MÉCANISME : évènement 10 (à vue, hors combat), non hostile, portée
-- 15 m, recharge 2 s -> action 33, crédit à celui qui approche. Une
-- seule règle couvre les deux objectifs : « rencontrer » et « parler à »
-- Khadgar se résolvent tous deux en l'approchant. Simplification
-- assumée — l'objectif « parler » mériterait un déclenchement au
-- dialogue, mais le crédit est le même et le résultat identique pour le
-- joueur.
--
-- ⚠️ CE QUI RESTE BLOQUÉ, ET QU'ON NE PEUT PAS RÉPARER ICI
-- L'objectif 0 de 46734 est de type 14 (arbre de critères), identifiant
-- 58013 « Gain a Foothold on Broken Shore ». Il est satisfait par le
-- scénario d'assaut de la carte 1666 — dont le script déclaré
-- `scenario_7.2_broken_shore_intro` n'existe pas davantage dans le core,
-- et dont la carte est vide. 46734 restera donc inachevable tant que ce
-- scénario ne sera pas implémenté. 46730, elle, devient terminable.
--
-- Rechargeable à chaud : reload smart_scripts. Les lignes de donneur et
-- de récepteur exigent en revanche un redémarrage.
-- =====================================================================

DELETE FROM `creature_queststarter` WHERE `id`=86563 AND `quest` IN (46730,46734);
INSERT INTO `creature_queststarter` (`id`,`quest`) VALUES
(86563,46730),
(86563,46734);

DELETE FROM `creature_questender` WHERE `id`=86563 AND `quest` IN (46730,46734);
INSERT INTO `creature_questender` (`id`,`quest`) VALUES
(86563,46730),
(86563,46734);

DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=86563 AND `id`=1;
INSERT INTO `smart_scripts`
 (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,
  `event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`event_param_string`,
  `action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,
  `target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(86563,0,1,0,10,0,100,0, 1,15,2000,2000,0,'', 33,120215,0,0,0,0,0, 7,0,0,0, 0,0,0,0,
 'Archimage Khadgar - A vue hors combat - Credit rencontre (quetes 46730 et 46734)');
