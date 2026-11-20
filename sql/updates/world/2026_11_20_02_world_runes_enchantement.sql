-- Volte-face et traitrise (39916) : la Rune incrustee de gangrene (137286) etait marquee QuestRequired,
-- or la quete ne la demande pas (objectif = poussiere 129751, pas d ItemDrop) : rune jamais affichee,
-- cadavre qui reste brillant. Methode LC : objet normal reserve par condition a la quete en cours.
-- Taux : ~15-18 % releve par un joueur ayant la quete (Wowhead), les 2-4 % de Wowhead comptent tous les tueurs.
UPDATE `creature_loot_template` SET `QuestRequired`=0, `Chance`=15 WHERE `Item`=137286 AND `Entry` IN (92445,92450);
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=1 AND `SourceGroup` IN (92445,92450) AND `SourceEntry`=137286;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(1,92445,137286,0,0,9,0,39916,0,0,0,0,0,'','Fel-Crusted Rune - quete Volte-face et traitrise en cours'),
(1,92450,137286,0,0,9,0,39916,0,0,0,0,0,'','Fel-Crusted Rune - quete Volte-face et traitrise en cours');

-- Pas de gaspillage (39880) : les pieces d armure de Haut-Mont (249826-249828) n etaient ni posees ni pourvues
-- de butin (TDB non plus). Apparitions et butin repris de LegionCore.
UPDATE `gameobject_template` SET `Data1`=`entry` WHERE `entry` IN (249826,249827,249828);
DELETE FROM `gameobject_loot_template` WHERE `Entry` IN (249826,249827,249828);
INSERT INTO `gameobject_loot_template` (`Entry`,`Item`,`Reference`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(249826,137195,0,100,1,1,0,1,1,'Highmountain Jerkin - objet de la quete 39880'),
(249827,137195,0,100,1,1,0,1,1,'Highmountain Shoulderpad - objet de la quete 39880'),
(249828,137195,0,100,1,1,0,1,1,'Highmountain Pants - objet de la quete 39880');
SET @GUID := 290400411;
DELETE FROM `gameobject` WHERE `guid` BETWEEN @GUID AND @GUID+21;
INSERT INTO `gameobject` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`,`isActive`,`ScriptName`,`VerifiedBuild`) VALUES
(@GUID+0,249828,1220,7503,7845,'0',0,0,0,-1,4380.05,4007.64,741.238,2.39441,0,0,0.931022,0.364962,300,0,1,0,'',0),
(@GUID+1,249827,1220,7503,7845,'0',0,0,0,-1,4477.62,4046.42,744.835,2.83502,0,0,0.988275,0.152685,300,0,1,0,'',0),
(@GUID+2,249826,1220,7503,7845,'0',0,0,0,-1,4482.27,4106,745.531,1.49253,0,0,0.678903,0.734228,300,0,1,0,'',0),
(@GUID+3,249826,1220,7503,7845,'0',0,0,0,-1,4502,4064.15,744.459,0.809237,0,0,0.393668,0.919253,300,0,1,0,'',0),
(@GUID+4,249826,1220,7503,7845,'0',0,0,0,-1,4463.61,4080.35,744.037,4.61765,0,0,0.739798,-0.672829,300,0,1,0,'',0),
(@GUID+5,249826,1220,7503,7845,'0',0,0,0,-1,4519.01,4058.34,746.785,0.247681,0,0,0.123524,0.992342,300,0,1,0,'',0),
(@GUID+6,249826,1220,7503,7845,'0',0,0,0,-1,4524.59,4089.61,747.963,0.189561,0,0,0.0946386,0.995512,300,0,1,0,'',0),
(@GUID+7,249826,1220,7503,7845,'0',0,0,0,-1,4512.42,4102.1,747.495,3.33665,0,0,0.995248,-0.0973751,300,0,1,0,'',0),
(@GUID+8,249826,1220,7503,7845,'0',0,0,0,-1,4414.76,4029.39,744.38,1.5695,0,0,0.70665,0.707563,300,0,1,0,'',0),
(@GUID+9,249826,1220,7503,7845,'0',0,0,0,-1,4384.96,3997.52,742.605,3.57149,0,0,0.976988,-0.213295,300,0,1,0,'',0),
(@GUID+10,249826,1220,7503,7845,'0',0,0,0,-1,4384.16,3905.26,748.976,3.73249,0,0,0.956671,-0.291171,300,0,1,0,'',0),
(@GUID+11,249826,1220,7503,7845,'0',0,0,0,-1,4412.36,3962.63,740.534,0.137723,0,0,0.0688073,0.99763,300,0,1,0,'',0),
(@GUID+12,249826,1220,7503,7845,'0',0,0,0,-1,4472.8,4068.25,744.956,3.76259,0,0,0.952181,-0.305533,300,0,1,0,'',0),
(@GUID+13,249826,1220,7503,7845,'0',0,0,0,-1,4488.61,4104.58,745.521,1.19094,0,0,0.560898,0.827885,300,0,1,0,'',0),
(@GUID+14,249826,1220,7503,7845,'0',0,0,0,-1,4489.32,3978.55,739.608,0.353706,0,0,0.175933,0.984402,300,0,1,0,'',0),
(@GUID+15,249826,1220,7503,7845,'0',0,0,0,-1,4361.32,3927.08,744.837,3.24633,0,0,0.998629,-0.0523455,300,0,1,0,'',0),
(@GUID+16,249826,1220,7503,7845,'0',0,0,0,-1,4374.79,3975.48,744.265,2.81357,0,0,0.986581,0.163275,300,0,1,0,'',0),
(@GUID+17,249826,1220,7503,7845,'0',0,0,0,-1,4396.25,4017.48,742.096,2.96673,0,0,0.99618,0.0873206,300,0,1,0,'',0),
(@GUID+18,249826,1220,7503,7845,'0',0,0,0,-1,4451.52,4005.54,745.112,1.76193,0,0,0.771353,0.636408,300,0,1,0,'',0),
(@GUID+19,249826,1220,7503,7845,'0',0,0,0,-1,4513.36,4106.01,747.931,2.31249,0,0,0.915298,0.402778,300,0,1,0,'',0),
(@GUID+20,249826,1220,7503,7845,'0',0,0,0,-1,4499.63,4096.35,745.418,0.817094,0,0,0.397276,0.917699,300,0,1,0,'',0),
(@GUID+21,249826,1220,7503,7845,'0',0,0,0,-1,4500.38,4073.4,743.824,5.93004,0,0,0.175657,-0.984451,300,0,1,0,'',0);
