-- Scripts/Uldum : l'introduction d'Uldum se joue enfin, d'apres Titans-Project (beadf8e9, e4ebf2b0), adaptee a notre base.
-- Easy Money (27003, la premiere quete d'Uldum) attendait le credit 44833 « Caravane escortee » et Traitors! (27922, la
-- suivante) le credit 47466 : rien ne les donnait, toute la zone etait bloquee des le depart. Lady Humps n'avait ni clic ni
-- script, la Fronde Neferset aucun script.

-- Lady Humps (46517) : le clic lance Initialize Uldum Intro (86748), seulement pendant Easy Money ; le script joue la scene
-- (repliques d'Adarrah, fondu au noir sur l'embuscade des pygmees, reveil dans la cage de la Cite perdue) et donne le credit.
UPDATE `creature_template` SET `npcflag` = `npcflag` | 16777216 WHERE `entry` = 46517;
DELETE FROM `npc_spellclick_spells` WHERE `npc_entry` = 46517;
INSERT INTO `npc_spellclick_spells` (`npc_entry`, `spell_id`, `cast_flags`, `user_type`) VALUES (46517, 86748, 1, 0);
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 18 AND `SourceGroup` = 46517 AND `SourceEntry` = 86748;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(18, 46517, 86748, 0, 0, 9, 0, 27003, 0, 0, 0, 0, 0, '', 'Lady Humps - Initialize Uldum Intro seulement pendant Easy Money');
DELETE FROM `spell_script_names` WHERE `spell_id` = 86748;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (86748, 'spell_uldum_initialize_intro');

-- Rendre Easy Money ouvre la cage (crochet d'Adarrah) et fait entrer un geolier ; sa mort fait parler le prince Nadun.
UPDATE `creature_template` SET `ScriptName` = 'npc_uldum_adarrah_cage' WHERE `entry` = 46873;
UPDATE `creature_template` SET `ScriptName` = 'npc_uldum_neferset_jailer', `AIName` = '' WHERE `entry` = 48029;
-- Traitors! : la Fronde Neferset fait un fondu au noir puis donne le credit.
UPDATE `gameobject_template` SET `AIName` = '', `ScriptName` = 'go_uldum_neferset_frond' WHERE `entry` = 206579;

DELETE FROM `creature_text` WHERE `CreatureID` IN (44833, 46719, 46873, 46872);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(44833, 0, 0, 'No, no, silly $r...', 12, 0, 100, 11, 0, 0, 46688, 0, 'Adarrah - Easy Money, clic sur Lady Humps'),
(44833, 1, 0, 'No one rides the Lady!', 12, 0, 100, 274, 0, 0, 46689, 0, 'Adarrah - Easy Money, clic sur Lady Humps'),
(46719, 0, 0, 'Attack!', 12, 0, 100, 0, 0, 18260, 46761, 0, 'Pygmy Ambusher - embuscade'),
(46719, 1, 0, 'How many coconuts can we get for the ugly one?', 12, 0, 100, 396, 0, 18259, 46774, 0, 'Pygmy Ambusher - embuscade'),
(46719, 2, 0, 'THREE? He woulda paid five, easy... Dummy!', 12, 0, 100, 0, 0, 18259, 46839, 0, 'Pygmy Ambusher - embuscade'),
(46873, 0, 0, 'Crap!  That was my last lock pick!', 12, 0, 100, 0, 0, 0, 48272, 0, 'Adarrah - Easy Money rendue, cage ouverte'),
(46872, 0, 0, 'Our captors have allied with Deathwing, $r.', 12, 0, 100, 396, 0, 0, 46820, 0, 'Prince Nadun - geolier tue'),
(46872, 1, 0, 'No mercy remains in them. Make your peace.', 12, 0, 100, 396, 0, 0, 46821, 0, 'Prince Nadun - geolier tue');

-- Acteurs de scene empiles sur les PNJ de quete dans les cages (nos propres apparitions) : quatre autres Adarrah
-- (46781, 47912, 48030, 48028), un second Budd (46782) et un geolier immobile dans la salle (48011). Gardes : Adarrah 46873
-- (recoit Easy Money), Budd 46875, Tanzar, le prince Nadun 46872, et les deux geoliers qui patrouillent dehors (48029).
DELETE FROM `creature` WHERE `guid` IN (373015, 373014, 373013, 286629, 373019, 301092) AND `id` IN (46781, 47912, 48030, 48028, 46782, 48011);
DELETE FROM `creature_addon` WHERE `guid` IN (373015, 373014, 373013, 286629, 373019, 301092);
-- La cage de Tanzar portait aussi une porte ouverte du modele de la cage du joueur : le script fermait la mauvaise.
DELETE FROM `gameobject` WHERE `guid` = 179425 AND `id` = 206953;
UPDATE `creature` SET `MovementType` = 0, `spawndist` = 0 WHERE `guid` = 286631 AND `id` = 46877;
-- La porte de la cage du joueur : seul le crochet d'Adarrah l'ouvre (le script), le joueur ne peut pas la cliquer.
INSERT INTO `gameobject_template_addon` (`entry`, `flags`) VALUES (206953, 18) ON DUPLICATE KEY UPDATE `flags` = `flags` | 18;  -- verrouillee, non selectionnable
