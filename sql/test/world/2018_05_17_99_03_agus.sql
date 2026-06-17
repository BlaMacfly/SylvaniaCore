DELETE FROM `creature` WHERE `id`=441732 AND `map`=1779;

UPDATE `creature_template` SET `npcflag`=49 WHERE `entry`=96786;
UPDATE `creature_template` SET `npcflag`=2 WHERE `entry` IN (15608, 93775);
DELETE FROM `creature_addon` WHERE `guid` IN (400012, 220010,600022, 220011,230000, 230006,230005, 230007);

UPDATE `creature` SET `spawnMask`=8589950976 WHERE `map`=564 and `spawnMask`=3;
UPDATE `creature` SET `spawnMask`=6 WHERE `map`=643 and `spawnMask`=3;
UPDATE `creature` SET `spawnMask`=1 WHERE `map`=1220 and `spawnMask`=3;

DELETE FROM `creature_addon` WHERE `guid` IN (20529527, 20546618, 452941, 452762, 452759, 452758, 452472, 453358, 453895, 454382, 454180, 454167, 454166, 454164);
UPDATE `creature_addon` SET `auras`='' WHERE `guid` IN(452414, 445994);
UPDATE `gameobject` SET `spawnMask`=6 WHERE `map`=643 and `spawnMask`=3;
DELETE FROM `gameobject_addon` WHERE `guid` IN (20365518, 20365527, 20366300, 20374987, 101251, 101252, 101699);
UPDATE `gameobject` SET `spawnMask`=8388870 WHERE `map`=1501 and `spawnMask`=3;
UPDATE `gameobject` SET `spawnMask`=4096 WHERE `map`=1599 and `spawnMask`=1;
UPDATE `gameobject` SET `spawnMask`=1 WHERE `map`=1220 and `spawnMask`=3;
UPDATE `creature_template_addon` SET `auras`='' WHERE `entry`=121394 ;
UPDATE `creature_template_addon` SET `auras`='' WHERE `entry`=121397 ;

DELETE FROM `npc_spellclick_spells` WHERE (`npc_entry`=107772 AND `spell_id`=234590) OR (`npc_entry`=116419 AND `spell_id`=231849) OR (`npc_entry`=116408 AND `spell_id`=231849) OR (`npc_entry`=113901 AND `spell_id`=234595) OR (`npc_entry`=116420 AND `spell_id`=231849) OR (`npc_entry`=68232 AND `spell_id`=75648) OR (`npc_entry`=68239 AND `spell_id`=75648) OR (`npc_entry`=68238 AND `spell_id`=75648) OR (`npc_entry`=119436 AND `spell_id`=237066) OR (`npc_entry`=119396 AND `spell_id`=237066) OR (`npc_entry`=119437 AND `spell_id`=237066) OR (`npc_entry`=112947 AND `spell_id`=234593) OR (`npc_entry`=119438 AND `spell_id`=237066) OR (`npc_entry`=98266 AND `spell_id`=193618) OR (`npc_entry`=29152 AND `spell_id`=83580) OR (`npc_entry`=123085 AND `spell_id`=250647) OR (`npc_entry`=123041 AND `spell_id`=246188) OR (`npc_entry`=123070 AND `spell_id`=246188) OR (`npc_entry`=123069 AND `spell_id`=246188) OR (`npc_entry`=123344 AND `spell_id`=245892) OR (`npc_entry`=122974 AND `spell_id`=245096) OR (`npc_entry`=121254 AND `spell_id`=242632) OR (`npc_entry`=123074 AND `spell_id`=245298) OR (`npc_entry`=126608 AND `spell_id`=251249) OR (`npc_entry`=125966 AND `spell_id`=251249) OR (`npc_entry`=128135 AND `spell_id`=254208) OR (`npc_entry`=126609 AND `spell_id`=251249) OR (`npc_entry`=122794 AND `spell_id`=244710) OR (`npc_entry`=122794 AND `spell_id`=255314) OR (`npc_entry`=122794 AND `spell_id`=255315) OR (`npc_entry`=123589 AND `spell_id`=248463) OR (`npc_entry`=126700 AND `spell_id`=251479);
INSERT INTO `npc_spellclick_spells` (`npc_entry`, `spell_id`, `cast_flags`, `user_type`) VALUES
(107772, 234590, 0, 0),
(116419, 231849, 0, 0),
(116408, 231849, 0, 0),
(113901, 234595, 0, 0),
(116420, 231849, 0, 0),
(68232, 75648, 0, 0),
(68239, 75648, 0, 0),
(68238, 75648, 0, 0),
(119436, 237066, 0, 0),
(119396, 237066, 0, 0),
(119437, 237066, 0, 0),
(112947, 234593, 0, 0),
(119438, 237066, 0, 0),
(98266, 193618, 0, 0),
(29152, 83580, 0, 0),

(123085, 250647, 0, 0),
(123041, 246188, 0, 0),
(123070, 246188, 0, 0),
(123069, 246188, 0, 0),
(123344, 245892, 0, 0),
(122974, 245096, 0, 0),
(121254, 242632, 0, 0),
(123074, 245298, 0, 0),
(126608, 251249, 0, 0),
(125966, 251249, 0, 0),
(128135, 254208, 0, 0),
(126609, 251249, 0, 0),
(122794, 244710, 0, 0),
(122794, 255314, 0, 0),
(122794, 255315, 0, 0),
(123589, 248463, 0, 0),
(126700, 251479, 0, 0);


SET NAMES 'utf8';
SET @GROUP_ID=0;
SET @ID =0;

