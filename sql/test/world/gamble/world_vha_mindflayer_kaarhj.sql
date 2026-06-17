UPDATE `creature_template` SET 
`ScriptName` = 'boss_mind_flayer_kaarhj', 
`minLevel` = 110, 
`maxLevel` = 110, 
`faction` = 16,
`unit_class` = 1,
`unit_flags` = `unit_flags` |64,
`unit_flags` = `unit_flags` |2099200
WHERE `entry` = 101950;

DELETE FROM `spell_script_names` WHERE `spell_id` IN(201153, 201920, 201172);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES 
(201153, 'spell_eternal_darkness'),
(201172, 'spell_eternal_darkness_dmg'),
(201920, 'spell_shadow_crash');

UPDATE `creature_template` SET 
`ScriptName` = 'npc_faceless_tendril',
`minLevel` = 110, 
`maxLevel` = 110, 
`faction` = 16,
`unit_flags` = `unit_flags` &~4,
`InhabitType` = 8
WHERE `entry` = 101994;

DELETE FROM `areatrigger_template` WHERE `id` IN (5129, 5718, 5721);
INSERT INTO `areatrigger_template` (`id`, `type`, `flags`, `Data0`, `Data1`, `Data2`, `ScriptName`) VALUES
(5129, 0, 0, 5, 5, 0, 'at_shadow_crash'),
(5718, 0, 0, 50, 50, 8, ''),
(5721, 0, 0, 5, 5, 0, 'at_collapsing_shadow');

DELETE FROM `areatrigger_template_actions` WHERE `AreaTriggerId` IN (5721, 5718);
INSERT INTO `areatrigger_template_actions` (`AreaTriggerId`, `ActionType`, `ActionParam`, `TargetType`) VALUES
(5718, 10, 0, 2);


DELETE FROM `spell_areatrigger` WHERE `SpellMiscId` IN (5129,5721,5718);
INSERT INTO `spell_areatrigger` (`SpellMiscId`, `AreaTriggerId`, `MoveCurveId`, `ScaleCurveId`, `MorphCurveId`, `FacingCurveId`, `DecalPropertiesId`, `TimeToTarget`, `TimeToTargetScale`, `VerifiedBuild`) VALUES
(5129, 5129, 0, 0, 0, 0, 0, 0, 15000, 23420),
(5721, 5721, 0, 0, 0, 0, 0, 0, 15000, 23420),
(5718, 5718, 0, 0, 0, 0, 0, 0, 15000, 23420);

SET @MINDFLAYER := 101950;

DELETE FROM `creature_text` WHERE `entry` = @MINDFLAYER;
INSERT INTO `creature_text`(`entry`, `groupid`, `id`, `text`, `type`, `probability`, `sound`, `comment`) VALUES
(@MINDFLAYER, '0', '0', 'Phriagg\'ba teq\'nir seq qwai N\'Zoth!', '14', '100', '57750', 'MINDFLAYER - INTRO'),
(@MINDFLAYER, '1', '0', 'Shath\'mag vwyq shu et\'agthu, Shath\'mag sshk ye! Krz\'ek fhn\'z agash zz maqdahl or\'kaaxth\'ma amqa!', '14', '100', '57748', 'MINDFLAYER - AGGRO'),
(@MINDFLAYER, '1', '1', 'Shath\'mag vwyq shu et\'agthu, Shath\'mag sshk ye! Ag\'rr hazz ak\'yel ksh ga\'halahs pahg!', '14', '100', '57749', 'MINDFLAYER - AGGRO2'),
(@MINDFLAYER, '2', '0', 'Iilth qi mah\'shar fhn oorql N\'Zoth!', '14', '100', '57741', 'MINDFLAYER - HYSTERIA'),
(@MINDFLAYER, '3', '0', 'Iilth ma paf\'qi\'ag sk\'halas. GAZ SKSHGN!', '14', '100', '57740', 'MINDFLAYER - HYSTERIA2'),
(@MINDFLAYER, '4', '0', 'Shath\'gral ynyq. Weq... weq... weq...', '14', '100', '57746', 'MINDFLAYER - HYSTERIA3'),
(@MINDFLAYER, '5', '0', 'N\'Zoth iiyoq raz\'tal\'vsak! IIYOQ NEL\'OTHK AR\'AFGH!', '14', '100', '57738', 'MINDFLAYER - ETERNAL_DARKNESS'),
(@MINDFLAYER, '6', '0', 'Mg\'uulwi N\'Zoth, eth\'razzqi worg zz oou.', '14', '100', '57739', 'MINDFLAYER - ETERNAL_DARKNESS_2'),
(@MINDFLAYER, '7', '0', 'Al\'ksh syq iir awan? Iilth sythn aqev... aqev... aqev...', '14', '100', '57737', 'MINDFLAYER - ETERNAL_DARKNESS_3'),
(@MINDFLAYER, '8', '0', 'Sk\'yahf q\'magg luk sshoq anagg\'gen.', '14', '100', '57747', 'MINDFLAYER - KILL'),
(@MINDFLAYER, '8', '1', 'Poq\'yith mazzka awan ki uhnish\'philfgsh.', '14', '100', '57743', 'MINDFLAYER - KILL_2'),
(@MINDFLAYER, '8', '2', 'En\'othk uulg\'shuul. Mh\'za uulwi skshgn kar.', '14', '100', '57742', 'MINDFLAYER - KILL_3'),
(@MINDFLAYER, '9', '0', 'Il\'zarq N\'Zoth phgwa an\'zig. Il\'zarq taag ov\'kadaq..', '14', '100', '57751', 'MINDFLAYER - WIPE'),
(@MINDFLAYER, '10', '0', 'Y\'za noq mah... Y\'za noq ormz...', '14', '100', '57745', 'MINDFLAYER - DEATH'),
(@MINDFLAYER, '11', '0', 'Yeh\'glu N\'Zoth okom hoq... Y\'za sythn oou...', '14', '100', '57744', 'MINDFLAYER - DEATH'),
(@MINDFLAYER, '12', '0', 'The Black Empire once ruled this pitiful world, and it will do so again! We will reforge our dread citadels atop the fly-blown corpse of this kingdom!', '15', '100', '0', 'MINDFLAYER - AGRRO_WHISPER'),
(@MINDFLAYER, '13', '0', 'Your soul will wander roads that twist in endless spirals.', '15', '100', '0', 'MINDFLAYER - KILL_WHISPER'),
(@MINDFLAYER, '14', '0', 'You will be the first of many to glimpse the madness of N\'Zoth!', '15', '100', '0', 'MINDFLAYER - HYSTERIA_WHISPER'),
(@MINDFLAYER, '15', '0', 'You are a prisoner in your own body. A SERVANT OF FEAR!', '15', '100', '0', 'MINDFLAYER - HYSTERIA_WHISPER_1'),
(@MINDFLAYER, '16', '0', 'The Old Ones beckon. Go... go... go...', '15', '100', '0', 'MINDFLAYER - HYSTERIA_WHISPER_2'),
(@MINDFLAYER, '17', '0', 'The will of N\'Zoth is made manifest! IT CANNOT BE CONTAINED!', '15', '100', '0', 'MINDFLAYER - ETERNAL_DARKNESS_WHISPER'),
(@MINDFLAYER, '18', '0', 'In the writhing shadow of N\'Zoth, all light fades and dies.', '15', '100', '0', 'MINDFLAYER - ETERNAL_DARKNESS_WHISPER_2'),
(@MINDFLAYER, '19', '0', 'Is this real or an illusion? You are going mad... mad... mad...', '15', '100', '0', 'MINDFLAYER - ETERNAL_DARKNESS_WHISPER_3'),
(@MINDFLAYER, '20', '0', 'I am not the first... I am not the last...', '15', '100', '0', 'MINDFLAYER - DEATH_WHISPER'),
(@MINDFLAYER, '21', '0', 'The blood of N\'Zoth runs through me... I cannot die...', '15', '100', '0', 'MINDFLAYER - DEATH_WHISPER_2');
