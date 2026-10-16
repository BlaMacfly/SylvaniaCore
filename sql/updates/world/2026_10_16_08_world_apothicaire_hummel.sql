-- Amour dans l air : l apothicaire Hummel (Donjon d Ombrecroc, donjon de fete 288). Toute la rencontre existe en C++
-- (boss_apothecary_hummel.cpp : dialogue, appel de Baxter puis Frye, fioles, fin du donjon LFG 288) mais rien n etait
-- rattache : les trois PNJ tournaient en SmartAI de 3 lignes, sans dialogue ni fin de donjon (la file de fete ne
-- recompensait jamais). Donnees reprises de TrinityCore (2017_03_13_00_world, reecriture de la rencontre) ; textes et
-- option verifies dans notre broadcast_text (ID et libelles identiques).
-- Non repris : les deux scripts de flaque (68614 / 68798) visent un PERIODIC_DUMMY qui n existe plus en 7.3.5 (EFFECT_0
-- y est une creation de zone 8752 / 8753 dont aucune source ne donne la forme) ; loot de la boite (hors rencontre).

UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'boss_apothecary_hummel', `unit_flags` = 33280, `mechanic_immune_mask` = 617297791 WHERE `entry` = 36296;
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_apothecary_baxter', `unit_flags` = 33280, `mechanic_immune_mask` = 617297791 WHERE `entry` = 36565;
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_apothecary_frye', `unit_flags` = 33280, `mechanic_immune_mask` = 617297791 WHERE `entry` = 36272;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (36296, 36565, 36272) AND `source_type` = 0;

-- Baxter et Frye sont invoques par Hummel (groupe 1) : leurs apparitions fixes feraient doublon
DELETE FROM `creature` WHERE `guid` IN (357698, 357699);
DELETE FROM `creature_addon` WHERE `guid` IN (357698, 357699);
DELETE FROM `game_event_creature` WHERE `guid` IN (357698, 357699);
DELETE FROM `creature_template_addon` WHERE `entry` IN (36565, 36272, 36296, 36710);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES
(36565, 0, 0, 0, 1, 0, '68946 71869'),
(36272, 0, 0, 0, 1, 0, '68704'),
(36296, 0, 0, 0, 1, 0, '68589 71856'),
(36710, 0, 0, 0, 1, 0, '69216');

DELETE FROM `creature_summon_groups` WHERE `summonerId` = 36296;
INSERT INTO `creature_summon_groups` (`summonerId`, `summonerType`, `groupId`, `entry`, `position_x`, `position_y`, `position_z`, `orientation`, `summonType`, `summonTime`) VALUES
(36296, 0, 1, 36565, -210.3594, 2214.606, 79.84758, 1.047198, 8, 0),
(36296, 0, 1, 36272, -205.1962, 2214.549, 79.84695, 2.408554, 8, 0);

DELETE FROM `gossip_menu_option` WHERE `MenuId` = 10847;
INSERT INTO `gossip_menu_option` (`MenuId`, `OptionIndex`, `OptionIcon`, `OptionText`, `OptionBroadcastTextId`, `OptionType`, `OptionNpcFlag`, `VerifiedBuild`) VALUES
(10847, 0, 0, 'Begin the battle.', 36652, 1, 1, 0);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` IN (68644, 68614, 68798);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 68644, 0, 0, 31, 0, 3, 36530, 0, 0, 0, 0, '', 'Validate Area cible les fioles 36530'),
(13, 1, 68614, 0, 0, 31, 0, 3, 36530, 0, 0, 0, 0, '', 'Cologne Spill cible les fioles 36530'),
(13, 1, 68798, 0, 0, 31, 0, 3, 36530, 0, 0, 0, 0, '', 'Perfume Spill cible les fioles 36530');

DELETE FROM `creature_text` WHERE `CreatureID` IN (36296, 36272, 36565);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(36296, 0, 0, 'Did they bother to tell you who I am and why I am doing this?', 12, 0, 100, 6, 0, 0, 38586, 3, 'SAY_INTRO_0'),
(36296, 1, 0, '...or are they just using you like they do everybody else?', 12, 0, 100, 396, 0, 0, 38600, 3, 'SAY_INTRO_1'),
(36296, 2, 0, 'But what does it matter.  It is time for this to end.', 12, 0, 100, 397, 0, 0, 38591, 3, 'SAY_INTRO_2'),
(36296, 3, 0, 'Baxter! Get in here and help! NOW!', 12, 0, 100, 0, 0, 0, 38592, 3, 'SAY_CALL_BAXTER'),
(36296, 4, 0, 'It is time, Frye!  Attack!', 12, 0, 100, 0, 0, 0, 38593, 3, 'SAY_CALL_FRYE'),
(36296, 5, 0, '...please don''t think less of me.', 12, 0, 100, 0, 0, 0, 38597, 3, 'SAY_HUMMEL_DEATH'),
(36272, 0, 0, 'Great. We''re not gutless, we''re incompetent.', 12, 0, 100, 0, 0, 0, 38596, 3, 'SAY_FRYE_DEATH'),
(36565, 0, 0, 'It has been the greatest honor of my life to serve with you, Hummel.', 12, 0, 100, 0, 0, 0, 38595, 3, 'SAY_BAXTER_DEATH');

DELETE FROM `spell_script_names` WHERE `ScriptName` IN ('spell_apothecary_validate_area', 'spell_apothecary_throw_perfume', 'spell_apothecary_throw_cologne', 'spell_apothecary_lingering_fumes');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(68644, 'spell_apothecary_validate_area'),
(68966, 'spell_apothecary_throw_perfume'),
(69038, 'spell_apothecary_throw_cologne'),
(68965, 'spell_apothecary_lingering_fumes');
