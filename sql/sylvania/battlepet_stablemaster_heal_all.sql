-- =====================================================================
-- OPTIONNEL (non applique le 2026-09-10) - a valider avant execution.
--
-- Complement de battlepet_stablemaster_heal.sql : rend l'option
-- « J'aimerais soigner et ressusciter mes mascottes de combat » reellement
-- fonctionnelle chez TOUS les maitres d'ecurie du menu 9821, et pas
-- seulement chez les 12 PNJ concernes par la quete « On The Mend ».
--
-- Sans ce complement, ~89 maitres d'ecurie affichent l'option mais ne
-- font rien quand on la choisit (bug present avant le correctif).
--
-- Portee : uniquement les PNJ qui ont deja le drapeau STABLEMASTER, le
-- menu 9821, et AUCUNE IA (AIName et ScriptName vides) - donc aucun
-- script existant n'est ecrase. Trois maitres d'ecurie deja en SmartAI
-- (Wesley 9978, Maluressian 10052, Thomas Partridge 33854) sont exclus :
-- il faudrait leur ajouter les lignes avec des `id` libres.
-- =====================================================================

CREATE TEMPORARY TABLE `_sm_heal` AS
    SELECT `entry` FROM `creature_template`
    WHERE `gossip_menu_id`=9821 AND `npcflag` & 4194304
      AND `AIName`='' AND `ScriptName`='';

UPDATE `creature_template` SET `AIName`='SmartAI'
    WHERE `entry` IN (SELECT `entry` FROM `_sm_heal`);

DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid` IN (SELECT `entry` FROM `_sm_heal`);

INSERT INTO `smart_scripts`
    (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,
     `event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`event_param_string`,
     `action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,
     `target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`)
SELECT `entry`,0,0,1,62,0,100,0,9821,2,0,0,0,'',85,125801,2,0,0,0,0,7,0,0,0,0,0,0,0,'Stable Master - Gossip Select - Cast Heal Battle Pets' FROM `_sm_heal`
UNION ALL
SELECT `entry`,0,1,2,61,0,100,0,   0,0,0,0,0,'',85,133994,2,0,0,0,0,7,0,0,0,0,0,0,0,'Stable Master - Link - Cast Revive Battle Pets' FROM `_sm_heal`
UNION ALL
SELECT `entry`,0,2,0,61,0,100,0,   0,0,0,0,0,'',72,     0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Stable Master - Link - Close Gossip' FROM `_sm_heal`;

DROP TEMPORARY TABLE `_sm_heal`;
