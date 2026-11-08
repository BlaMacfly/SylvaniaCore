-- Intro de Tanaan : scripts C++ ecrits pour ces PNJ (entree indiquee en commentaire au-dessus de chaque classe)
-- mais jamais rattaches. Aucun n'avait d'IA (AIName vide, aucun smart_scripts).
UPDATE `creature_template` SET `ScriptName` = 'npc_archmage_khadgar_bridge' WHERE `entry` = 78560 AND `ScriptName` = '' AND `AIName` = '';
UPDATE `creature_template` SET `ScriptName` = 'npc_maladaar_liadrin_tanaan_cave' WHERE `entry` IN (79537, 79675) AND `ScriptName` = '' AND `AIName` = '';
UPDATE `creature_template` SET `ScriptName` = 'npc_thaelin_tanaan_questgiver' WHERE `entry` = 80521 AND `ScriptName` = '' AND `AIName` = '';
