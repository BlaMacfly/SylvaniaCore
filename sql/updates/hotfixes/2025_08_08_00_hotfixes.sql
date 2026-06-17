
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for battle_pet_ability
-- ----------------------------
DROP TABLE IF EXISTS `battle_pet_ability`;
CREATE TABLE `battle_pet_ability`  (
  `ID` int(11) NOT NULL DEFAULT 0,
  `Name` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `Description` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `IconFileDataID` int(11) NOT NULL DEFAULT 0,
  `BattlePetVisualID` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `PetTypeEnum` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `Flags` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `Cooldown` int(11) NOT NULL DEFAULT 0,
  `VerifiedBuild` smallint(6) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;


SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for battle_pet_ability_effect
-- ----------------------------
DROP TABLE IF EXISTS `battle_pet_ability_effect`;
CREATE TABLE `battle_pet_ability_effect`  (
  `BattlePetAbilityTurnID` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `BattlePetVisualID` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `AuraBattlePetAbilityID` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `BattlePetEffectPropertiesID` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `Param1` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `Param2` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `Param3` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `Param4` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `Param5` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `Param6` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `OrderIndex` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `ID` int(11) NOT NULL DEFAULT 0,
  `VerifiedBuild` smallint(6) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Fixed;

SET FOREIGN_KEY_CHECKS = 1;


SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for battle_pet_ability_locale
-- ----------------------------
DROP TABLE IF EXISTS `battle_pet_ability_locale`;
CREATE TABLE `battle_pet_ability_locale`  (
  `ID` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `locale` varchar(4) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Name_lang` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `Description_lang` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `VerifiedBuild` smallint(6) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`, `locale`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;


SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for battle_pet_ability_state
-- ----------------------------
DROP TABLE IF EXISTS `battle_pet_ability_state`;
CREATE TABLE `battle_pet_ability_state`  (
  `ID` int(11) NOT NULL DEFAULT 0,
  `Value` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `BattlePetStateID` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `BattlePetAbilityID` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `VerifiedBuild` smallint(6) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Fixed;

SET FOREIGN_KEY_CHECKS = 1;


SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for battle_pet_ability_turn
-- ----------------------------
DROP TABLE IF EXISTS `battle_pet_ability_turn`;
CREATE TABLE `battle_pet_ability_turn`  (
  `BattlePetAbilityID` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `BattlePetVisualID` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `OrderIndex` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `TurnTypeEnum` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `EventTypeEnum` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `ID` int(11) NOT NULL DEFAULT 0,
  `VerifiedBuild` smallint(6) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Fixed;

SET FOREIGN_KEY_CHECKS = 1;


SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for battle_pet_breed_quality
-- ----------------------------
DROP TABLE IF EXISTS `battle_pet_breed_quality`;
CREATE TABLE `battle_pet_breed_quality`  (
  `ID` int(11) NOT NULL DEFAULT 0,
  `StateMultiplier` float NOT NULL DEFAULT 0,
  `QualityEnum` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `VerifiedBuild` smallint(6) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Fixed;

SET FOREIGN_KEY_CHECKS = 1;


SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for battle_pet_breed_state
-- ----------------------------
DROP TABLE IF EXISTS `battle_pet_breed_state`;
CREATE TABLE `battle_pet_breed_state`  (
  `ID` int(11) NOT NULL DEFAULT 0,
  `Value` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `BattlePetStateID` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `BreedID` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `VerifiedBuild` smallint(6) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Fixed;

SET FOREIGN_KEY_CHECKS = 1;


SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for battle_pet_display_override
-- ----------------------------
DROP TABLE IF EXISTS `battle_pet_display_override`;
CREATE TABLE `battle_pet_display_override`  (
  `ID` int(11) NOT NULL DEFAULT 0,
  `BattlePetSpeciesID` int(11) NOT NULL DEFAULT 0,
  `PlayerConditionID` int(11) NOT NULL DEFAULT 0,
  `CreatureDisplayInfoID` int(11) NOT NULL DEFAULT 0,
  `PriorityCategory` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `VerifiedBuild` smallint(6) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Fixed;

SET FOREIGN_KEY_CHECKS = 1;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for battle_pet_effect_properties
-- ----------------------------
DROP TABLE IF EXISTS `battle_pet_effect_properties`;
CREATE TABLE `battle_pet_effect_properties`  (
  `ID` int(11) NOT NULL DEFAULT 0,
  `ParamLabel1` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `ParamLabel2` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `ParamLabel3` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `ParamLabel4` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `ParamLabel5` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `ParamLabel6` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `BattlePetVisualID` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `ParamTypeEnum1` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `ParamTypeEnum2` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `ParamTypeEnum3` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `ParamTypeEnum4` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `ParamTypeEnum5` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `ParamTypeEnum6` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `VerifiedBuild` smallint(6) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for battle_pet_effect_properties_locale
-- ----------------------------
DROP TABLE IF EXISTS `battle_pet_effect_properties_locale`;
CREATE TABLE `battle_pet_effect_properties_locale`  (
  `ID` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `locale` varchar(4) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `ParamLabel1_lang` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `ParamLabel2_lang` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `ParamLabel3_lang` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `ParamLabel4_lang` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `ParamLabel5_lang` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `ParamLabel6_lang` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `VerifiedBuild` smallint(6) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`, `locale`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;


SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for battle_pet_n_p_c_team_member
-- ----------------------------
DROP TABLE IF EXISTS `battle_pet_n_p_c_team_member`;
CREATE TABLE `battle_pet_n_p_c_team_member`  (
  `ID` int(11) NOT NULL DEFAULT 0,
  `Name` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `VerifiedBuild` smallint(6) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;


SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for battle_pet_n_p_c_team_member_locale
-- ----------------------------
DROP TABLE IF EXISTS `battle_pet_n_p_c_team_member_locale`;
CREATE TABLE `battle_pet_n_p_c_team_member_locale`  (
  `ID` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `locale` varchar(4) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Name_lang` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `VerifiedBuild` smallint(6) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`, `locale`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;


SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for battle_pet_species
-- ----------------------------
DROP TABLE IF EXISTS `battle_pet_species`;
CREATE TABLE `battle_pet_species`  (
  `SourceText` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `Description` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `CreatureID` int(11) NOT NULL DEFAULT 0,
  `IconFileDataID` int(11) NOT NULL DEFAULT 0,
  `SummonSpellID` int(11) NOT NULL DEFAULT 0,
  `Flags` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `PetTypeEnum` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `SourceTypeEnum` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `ID` int(11) NOT NULL DEFAULT 0,
  `CardUIModelSceneID` int(11) NOT NULL DEFAULT 0,
  `LoadoutUIModelSceneID` int(11) NOT NULL DEFAULT 0,
  `VerifiedBuild` smallint(6) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of battle_pet_species
-- ----------------------------
INSERT INTO `battle_pet_species` VALUES ('|cFFFFD200Achievement:|r Priority Mail|n', 'The Postmaster is often described as esoteric, mystical, even inexplicable. For the precious little known about the enigmatic mail-master, perhaps none outside of the wax seal can confirm the existence of the fantastical letter-loving Mailemental', 132366, 413580, 260887, 82, 5, 5, 2158, 6, 7, 0);
INSERT INTO `battle_pet_species` VALUES ('|cFFFFD200Vendor: |rLhara|n|cFFFFD200Zone: |rDarkmoon Island|n|cFFFFD200Cost: |r90|TINTERFACE\\ICONS\\inv_misc_ticket_darkmoon_01:0|t', 'Most of Violet\'s numerous forest strider hatchlings are turned into Faire fare by Stamp Thunderhorn, though a few are raised as mounts or purchased by adventurers looking for a petite purple pet', 67319, 132198, 132762, 2, 4, 2, 1061, 35, 7, 0);
INSERT INTO `battle_pet_species` VALUES ('', '', 91337, 134205, 0, 34, 6, 255, 1642, 6, 7, 0);
INSERT INTO `battle_pet_species` VALUES ('', '', 83562, 134048, 167336, 2, 3, 0, 1428, 6, 7, 0);
INSERT INTO `battle_pet_species` VALUES ('|cFFFFD200World Event:|r Love is in the Air|n|cFFFFD200Vendor: |rLovely Merchant|n|cFFFFD200Cost: |r40|TINTERFACEICONSINV_ValentinesCard01:0|', 'Most of Violet\'s numerous forest strider hatchlings are turned into Faire fare by Stamp Thunderhorn, though a few are raised as mounts or purchased by adventurers looking for a petite purple pet', 85710, 132198, 171118, 2, 4, 2, 1511, 35, 7, 0);
INSERT INTO `battle_pet_species` VALUES ('', '', 78895, 134062, 159296, 2, 5, 3, 1395, 33, 7, 0);

SET FOREIGN_KEY_CHECKS = 1;


SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for battle_pet_species_locale
-- ----------------------------
DROP TABLE IF EXISTS `battle_pet_species_locale`;
CREATE TABLE `battle_pet_species_locale`  (
  `ID` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `locale` varchar(4) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `SourceText_lang` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `Description_lang` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `VerifiedBuild` smallint(6) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`, `locale`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;


SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for battle_pet_species_state
-- ----------------------------
DROP TABLE IF EXISTS `battle_pet_species_state`;
CREATE TABLE `battle_pet_species_state`  (
  `ID` int(11) NOT NULL DEFAULT 0,
  `Value` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `BattlePetStateID` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `SpeciesID` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `VerifiedBuild` smallint(6) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Fixed;

SET FOREIGN_KEY_CHECKS = 1;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for battle_pet_species_x_ability
-- ----------------------------
DROP TABLE IF EXISTS `battle_pet_species_x_ability`;
CREATE TABLE `battle_pet_species_x_ability`  (
  `ID` int(11) NOT NULL DEFAULT 0,
  `BattlePetAbilityID` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `RequiredLevel` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `SlotEnum` tinyint(4) NOT NULL DEFAULT 0,
  `BattlePetSpeciesID` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `VerifiedBuild` smallint(6) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Fixed;

SET FOREIGN_KEY_CHECKS = 1;


SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for battle_pet_state
-- ----------------------------
DROP TABLE IF EXISTS `battle_pet_state`;
CREATE TABLE `battle_pet_state`  (
  `ID` int(11) NOT NULL DEFAULT 0,
  `LuaName` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `BattlePetVisualID` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `Flags` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `VerifiedBuild` smallint(6) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;


SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for battle_pet_state_locale
-- ----------------------------
DROP TABLE IF EXISTS `battle_pet_state_locale`;
CREATE TABLE `battle_pet_state_locale`  (
  `ID` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `locale` varchar(4) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `LuaName_lang` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `VerifiedBuild` smallint(6) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`, `locale`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;


SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for battle_pet_visual
-- ----------------------------
DROP TABLE IF EXISTS `battle_pet_visual`;
CREATE TABLE `battle_pet_visual`  (
  `ID` int(11) NOT NULL DEFAULT 0,
  `SceneScriptFunction` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `SpellVisualID` int(11) NOT NULL DEFAULT 0,
  `CastMilliSeconds` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `ImpactMilliSeconds` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `SceneScriptPackageID` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `RangeTypeEnum` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `Flags` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `VerifiedBuild` smallint(6) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;


SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for battle_pet_visual_locale
-- ----------------------------
DROP TABLE IF EXISTS `battle_pet_visual_locale`;
CREATE TABLE `battle_pet_visual_locale`  (
  `ID` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `locale` varchar(4) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `SceneScriptFunction_lang` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `VerifiedBuild` smallint(6) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`, `locale`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
