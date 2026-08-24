-- =====================================================================
-- Anneau du sang (Nagrand) — « The Ring of Blood: The Final Challenge »
-- (quête 9977) ne se validait jamais.
--
-- SIGNALÉ EN JEU
-- « le dernier boss ne rez pas du coup on peut pas faire la quête »,
-- puis « elle me dit qu'elle est validée mais je suis devant le mob pour
-- la rendre, il me dit qu'elle n'est pas finie ».
--
-- CE QUI SE PASSAIT VRAIMENT
-- Ni un problème de réapparition ni un objectif manquant. Les six quêtes
-- de la chaîne portent `SpecialFlags = 2`, c'est-à-dire
-- QUEST_SPECIAL_FLAGS_EXPLORATION_OR_EVENT : elles n'ont volontairement
-- AUCUN objectif dans `quest_objectives` et ne peuvent se terminer que
-- si un script appelle explicitement l'événement de quête.
-- D'où le symptôme exact décrit : le client, ne voyant aucun objectif à
-- remplir, affiche la quête comme terminée ; le serveur, lui, attend un
-- signal qui n'arrive jamais et refuse la remise.
--
-- Les quatre adversaires qui fonctionnent portent tous le même motif :
--
--     événement 6 (à la mort) → action 15 (crédit de quête) → cible 16
--
--   18398 Brokentoe              → quête 9962
--   18400 Rokdar                 → quête 9970
--   18401 Skra'gath              → quête 9972
--   18402 Champion Casse-Maul    → quête 9973
--
-- Mogor est le seul à ne pas l'avoir. Sa liste d'actions de mort
-- (1806901) se contente de le faire ressusciter et prononcer une
-- réplique — elle ne crédite rien.
--
-- La cible 16 est SMART_TARGET_INVOKER_PARTY : le crédit va au tueur ET
-- à tout son groupe, comme pour les quatre autres. `event_flags = 513`
-- et l'identifiant d'événement 6 sont repris à l'identique du modèle.
--
-- On n'ajoute PAS de ligne dans `quest_objectives` : ce serait contraire
-- au fonctionnement voulu par le drapeau, et ça casserait la cohérence
-- avec les cinq autres quêtes de la chaîne.
--
-- Rechargeable à chaud : reload smart_scripts
-- =====================================================================

DELETE FROM `smart_scripts`
 WHERE `entryorguid`=18069 AND `source_type`=0 AND `id`=14;

INSERT INTO `smart_scripts`
 (`entryorguid`,`source_type`,`id`,`link`,
  `event_type`,`event_phase_mask`,`event_chance`,`event_flags`,
  `event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`event_param_string`,
  `action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,
  `target_type`,`target_param1`,`target_param2`,`target_param3`,
  `target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(18069, 0, 14, 0,
  6, 0, 100, 513,
  0, 0, 0, 0, 0, '',
  15, 9977, 0, 0, 0, 0, 0,
  16, 0, 0, 0,
  0, 0, 0, 0, 'Mogor - On Death - Give Quest Credit');
