-- =====================================================================
-- Domaine du mage (Legion) : les trois premieres quetes d'arme bloquees
-- Signale par Wisstiti (Wissmerill, mage, guid 339) le 10/11/2026.
-- =====================================================================

-- 1. "Le tresor du seigneur de l'effroi" (41036) : le joueur arrive au Fort pourpre (carte 1494),
--    mais les PNJ du scenario n'avaient pas de ScriptName : Meryl, Kathra'natir, les failles
--    et la Forge restaient inertes (RegisterCreatureAI de scenario_the_violet_hold.cpp).
UPDATE `creature_template` SET `ScriptName` = 'npc_kathra_natir_102785'         WHERE `entry` = 102785;
UPDATE `creature_template` SET `ScriptName` = 'npc_forge_of_the_guardian_102786' WHERE `entry` = 102786;
UPDATE `creature_template` SET `ScriptName` = 'npc_siphoning_rift_102787'       WHERE `entry` = 102787;
UPDATE `creature_template` SET `ScriptName` = 'npc_meryl_felstorm_102850'       WHERE `entry` = 102850;

-- 2. "Une arme de mage" (41085) : l'Archive de la Tirisgarde (252292) n'ouvrait le choix (sort 203654,
--    choix 265) qu'apres "Kill Your Hundred" 34429 (intro de Tanaan), herite de DestinyCore comme
--    les PrevQuestID retires le 29/09 (c017adade). On l'ouvre pendant les trois quetes de choix
--    d'arme (41085, 43441, 44310) et apres 41085 pour revoir le choix.
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceGroup` = 1 AND `SourceEntry` = 252292 AND `SourceId` = 1;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(22,1,252292,1,0,9,0,41085,0,0,0,0,0,'','SAI 252292-0 only if invoker has quest A Mage''s Weapon'),
(22,1,252292,1,1,9,0,43441,0,0,0,0,0,'','SAI 252292-0 only if invoker has quest A Second Weapon'),
(22,1,252292,1,2,9,0,44310,0,0,0,0,0,'','SAI 252292-0 only if invoker has quest Thrice the Power'),
(22,1,252292,1,3,8,0,41085,0,0,0,0,0,'','SAI 252292-0 only if invoker rewarded A Mage''s Weapon');

--    Meme prerequisite 34429 sur l'option "revoir le choix d'arme" de 10 autres classes :
--    remplace par la premiere quete d'arme de la classe, comme LegionCore.
UPDATE `conditions` SET `ConditionValue1` = 40408, `Comment` = 'Show gossip option if player rewarded quest 40408' WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = 19044 AND `ConditionTypeOrReference` = 8 AND `ConditionValue1` = 34429; -- paladin
UPDATE `conditions` SET `ConditionValue1` = 40579, `Comment` = 'Show gossip option if player rewarded quest 40579' WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = 19091 AND `ConditionTypeOrReference` = 8 AND `ConditionValue1` = 34429; -- guerrier
UPDATE `conditions` SET `ConditionValue1` = 40618, `Comment` = 'Show gossip option if player rewarded quest 40618' WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = 19115 AND `ConditionTypeOrReference` = 8 AND `ConditionValue1` = 34429; -- chasseur
UPDATE `conditions` SET `ConditionValue1` = 40636, `Comment` = 'Show gossip option if player rewarded quest 40636' WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = 19130 AND `ConditionTypeOrReference` = 8 AND `ConditionValue1` = 34429; -- moine
UPDATE `conditions` SET `ConditionValue1` = 40646, `Comment` = 'Show gossip option if player rewarded quest 40646' WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = 19156 AND `ConditionTypeOrReference` = 8 AND `ConditionValue1` = 34429; -- druide
UPDATE `conditions` SET `ConditionValue1` = 40706, `Comment` = 'Show gossip option if player rewarded quest 40706' WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = 19157 AND `ConditionTypeOrReference` = 8 AND `ConditionValue1` = 34429; -- pretre
UPDATE `conditions` SET `ConditionValue1` = 40715, `Comment` = 'Show gossip option if player rewarded quest 40715' WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = 19169 AND `ConditionTypeOrReference` = 8 AND `ConditionValue1` = 34429; -- chevalier de la mort
UPDATE `conditions` SET `ConditionValue1` = 40684, `Comment` = 'Show gossip option if player rewarded quest 40684' WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = 19326 AND `ConditionTypeOrReference` = 8 AND `ConditionValue1` = 34429; -- demoniste
UPDATE `conditions` SET `ConditionValue1` = 41335, `Comment` = 'Show gossip option if player rewarded quest 41335' WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = 19365 AND `ConditionTypeOrReference` = 8 AND `ConditionValue1` = 34429; -- chaman
UPDATE `conditions` SET `ConditionValue1` = 40840, `Comment` = 'Show gossip option if player rewarded quest 40840' WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = 19545 AND `ConditionTypeOrReference` = 8 AND `ConditionValue1` = 34429; -- voleur

-- 3. "A la recherche de Frissebene" (42452) : les notes etaient des modeles vides (type 0, sans modele)
--    et n'avaient aucune apparition. Modeles et 3 apparitions repris de LegionCore (guid 136339-136341) ;
--    les deux fausses pistes (250544, 250546) n'y sont pas posees non plus.
UPDATE `gameobject_template` SET `type`=10,`displayId`=15781,`IconName`='questinteract',`size`=1,`Data3`=5,`Data7`=5299,`Data9`=1,`Data10`=213603,`Data23`=1 WHERE `entry`=250542;
UPDATE `gameobject_template` SET `type`=10,`displayId`=34236,`IconName`='questinteract',`size`=1,`Data3`=1,`Data7`=5300,`Data9`=1,`Data23`=1 WHERE `entry`=250544;
UPDATE `gameobject_template` SET `type`=10,`displayId`=34237,`IconName`='questinteract',`size`=1,`Data3`=5,`Data7`=5301,`Data9`=1,`Data10`=213603,`Data23`=1 WHERE `entry`=250545;
UPDATE `gameobject_template` SET `type`=10,`displayId`=15781,`IconName`='questinteract',`size`=1,`Data3`=4,`Data7`=5303,`Data9`=1,`Data23`=1 WHERE `entry`=250546;
UPDATE `gameobject_template` SET `type`=10,`displayId`=24896,`IconName`='questinteract',`size`=1,`Data3`=5,`Data7`=5304,`Data9`=1,`Data10`=213603,`Data23`=1 WHERE `entry`=250549;

DELETE FROM `gameobject` WHERE `guid` BETWEEN 290400408 AND 290400410;
INSERT INTO `gameobject` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES
(290400408,250549,1513,7879,7879,'0',0,0,0,-1,-826.52,4675.55,939.992,4.7018,0,0,0.71084,-0.703354,300,0,1),
(290400409,250545,1513,7879,7879,'0',0,0,0,-1,-813.013,4673.46,939.993,4.12846,0,0,0.880711,-0.473654,300,0,1),
(290400410,250542,1513,7879,7879,'0',0,0,0,-1,-819.117,4712.56,939.993,1.12353,0,0,0.53268,0.846317,300,0,1);
