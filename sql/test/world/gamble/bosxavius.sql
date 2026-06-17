 delete from creature where map = 1520 and id in (103769,104548, 109847);
INSERT INTO `creature` (`id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `PhaseId`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `npcflag2`, `unit_flags`, `dynamicflags`, `AiID`, `MovementID`, `MeleeID`, `isActive`, `skipClone`) VALUES
(103769, 1520, 8026, 8043, 245760, 1, '0', 0, 0, -3019.56, -5060.42, 147.877, 0.752509, 604800, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(104548, 1520, 8026, 8043, 245760, 1, '0', 0, 0, -2990, -5030, 147.788, 0.00420353, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(109847, 1520, 8026, 8043, 245760, 1, '0', 0, 0, -2990.17, -5029.86, 147.788, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

update creature_template_wdb set displayId1 = 11686, displayId2 = 0 where entry = 104422;
update creature_template_wdb set displayId2 = 0 where entry in (105611,110732);

delete from areatrigger_template where entry in (7648,6143);
INSERT INTO `areatrigger_template` (`entry`, `spellId`, `customEntry`, `VisualID`, `DecalPropertiesId`, `Radius`, `RadiusTarget`, `Height`, `HeightTarget`, `Float4`, `Float5`, `isMoving`, `Distance`, `MoveCurveID`, `ElapsedTime`, `MorphCurveID`, `FacingCurveID`, `ScaleCurveID`, `HasFollowsTerrain`, `HasAttached`, `HasAbsoluteOrientation`, `HasDynamicShape`, `HasFaceMovementDir`, `hasAreaTriggerBox`, `RollPitchYaw1X`, `RollPitchYaw1Y`, `RollPitchYaw1Z`, `TargetRollPitchYawX`, `TargetRollPitchYawY`, `TargetRollPitchYawZ`, `windX`, `windY`, `windZ`, `windSpeed`, `windType`, `polygon`, `comment`) VALUES
(7648, 217989, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Tormenting Infection'),
(6143, 205780, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Tormenting Detonation');
Нет такой таблицы
delete from areatrigger_data where entry in (6452);
INSERT INTO `areatrigger_data` (`entry`, `spellId`, `customEntry`, `moveType`, `waitTime`, `speed`, `activationDelay`, `updateDelay`, `maxCount`, `hitType`, `AngleToCaster`, `AnglePointA`, `AnglePointB`, `maxActiveTargets`, `Param`) VALUES
(6452, 208363, 0, 0, 0, 0, 0, 1000, 0, 0, 0, 0, 0, 0, 0);

delete from areatrigger_actions where entry in (7648,6790,6452,6143);
INSERT INTO `areatrigger_actions` (`entry`, `customEntry`, `id`, `moment`, `actionType`, `targetFlags`, `spellId`, `maxCharges`, `aura`, `hasspell`, `chargeRecoveryTime`, `scale`, `hitMaxCount`, `amount`, `onDespawn`, `comment`) VALUES
(7648, 0, 0, 1, 0, 8, 217990, 1, 0, 0, 0, 0, 0, 0, 0, 'Tormenting Infection'),
(6143, 0, 0, 1, 0, 8, 205782, 1, 0, 0, 0, 0, 0, 0, 0, 'Tormenting Detonation'),
(6790, 0, 0, 1, 1, 12, 209034, 1, 209034, 0, 0, 0, 0, 0, 0, 'Bonds of Terror'),
(6790, 0, 1, 1, 1, 16388, 210451, 1, 210451, 0, 0, 0, 0, 0, 0, 'Bonds of Terror'),
(6452, 0, 0, 5, 0, 8, 208385, 5, 0, 0, 0, 0, 0, 0, 1, 'Tainted Discharge - Apply'),
(6452, 0, 1, 42, 1, 8, 208385, 0, 0, 0, 0, 0, 0, 0, 0, 'Tainted Discharge - Remove');


delete from spell_target_filter where spellId in (208322,206308,209032,210449);
INSERT INTO `spell_target_filter` (`spellId`, `targetId`, `option`, `param1`, `param2`, `param3`, `aura`, `chance`, `effectMask`, `resizeType`, `count`, `maxcount`, `addcount`, `addcaster`, `comments`) VALUES
(208322, 15, 0, 0, 0, 0, 0, 0, 1, 2, 1, 0, 0, 0, 'Lurking Eruption'),
(206308, 15, 9, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 'Corruption Meteor'),
(209032, 15, 9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 'Bonds of Terror'),
(209032, 15, 1, -209034, -210451, 0, 0, 0, 1, 0, 0, 0, 0, 0, 'Bonds of Terror'),
(210449, 30, 1, -209034, -210451, 0, 0, 0, 1, 0, 0, 0, 0, 0, 'Bonds of Terror');

delete from spell_dummy_trigger where spell_id in (208322,211579,206308,209032,210449);
INSERT INTO `spell_dummy_trigger` (`spell_id`, `spell_trigger`, `option`, `target`, `caster`, `targetaura`, `bp0`, `bp1`, `bp2`, `effectmask`, `aura`, `group`, `comment`) VALUES
(208322, 208237, 11, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'Lurking Eruption'),
(211579, 0, 11, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'Nightmare Blades'),
(206308, 206341, 11, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'Corruption Meteor - Dmg'),
(206308, 224508, 11, 0, 0, 0, 0, 0, 0, 2, 0, 0, 'Corruption Meteor - Mark'),
(209032, 209034, 11, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'Bonds of Terror'),
(210449, 210451, 11, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'Bonds of Terror');

delete from spell_aura_trigger where spell_id in (209288);
INSERT INTO `spell_aura_trigger` (`spell_id`, `spell_trigger`, `option`, `option2`, `target`, `caster`, `bp0`, `bp1`, `bp2`, `effectmask`, `hastype`, `hastalent`, `hasparam`, `hastype2`, `hastalent2`, `hasparam2`, `chance`, `slot`, `comment`) VALUES
(209288, 209294, 0, 0, 0, 5, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dark Ruination');


delete from spell_script_names where spell_id in (207830);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(207830, 'spell_xavius_corrupting_nova'); 