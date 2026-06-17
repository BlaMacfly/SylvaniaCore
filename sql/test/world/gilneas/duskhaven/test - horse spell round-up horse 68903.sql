-- fix - horse spell round-up horse 68903

UPDATE `creature_template` SET `npcflag`='2', `spell1`='68903', `unit_flags`='16777216' WHERE `entry`='36540';
UPDATE `creature_template` SET `modelid1`='20570', `modelid2`='11686', `flags_extra`='128' WHERE  `entry`='35374';
DELETE FROM `spell_linked_spell` WHERE `spell_trigger`=68903 AND `spell_effect`=68908 AND `type`=0;
DELETE FROM `spell_linked_spell` WHERE `spell_trigger`=68903 AND `spell_effect`=68908 AND `type`=1;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (68903, 68908, 1, 'Get horse in rope');

UPDATE `world`.`creature_template` SET `unit_flags`='0' WHERE  `entry`=36555;