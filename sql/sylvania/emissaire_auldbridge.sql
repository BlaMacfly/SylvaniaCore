-- =====================================================================
-- Dalaran (Legion) - Emissaire Pont-Vetuste (111109) : quetes de domaine de classe jamais donnees
-- Signale par Wisstiti (Wissmerill, mage, guid 339) le 10/11/2026 : aucune quete de domaine ni d'arme prodigieuse.
-- Le script npc_emissary_auldbridge_111109 (RegisterCreatureAI) existe mais le PNJ n'avait pas de ScriptName :
-- a la remise de "D'un battement de cil" (44663/44184), rien ne donnait la quete de classe
-- (mage : L'appel a l'aide de Gangrorage 41035).
-- Textes : LegionCore creature_text 111109 (groupes 0 et 2), anglais repris de broadcast_text.
-- =====================================================================
UPDATE `creature_template` SET `ScriptName` = 'npc_emissary_auldbridge_111109' WHERE `entry` = 111109;

DELETE FROM `creature_text` WHERE `CreatureID` = 111109;
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`,`TextRange`,`comment`) VALUES
(111109,0,0,'Welcome to Dalaran! I''m happy to assist with anything you need.',12,0,100,0,0,0,119644,0,'Emissary Auldbridge - In the Blink of an Eye (LC)'),
(111109,2,0,'I must inform the Council of your news. Good luck, $n!',12,0,100,0,0,0,119646,0,'Emissary Auldbridge - In the Blink of an Eye (LC)');
