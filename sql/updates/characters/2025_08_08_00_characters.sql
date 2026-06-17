SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for account_battlepet
-- ----------------------------
DROP TABLE IF EXISTS `account_battlepet`;
CREATE TABLE `account_battlepet`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `account` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `slot` int(11) NOT NULL DEFAULT -1,
  `name` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nameTimeStamp` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `species` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `quality` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `breed` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `level` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `xp` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `display` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `health` int(11) NOT NULL DEFAULT 0,
  `flags` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `infoPower` int(11) NOT NULL DEFAULT 0,
  `infoMaxHealth` int(11) NOT NULL DEFAULT 0,
  `infoSpeed` int(11) NOT NULL DEFAULT 0,
  `infoGender` int(11) NOT NULL DEFAULT 0,
  `declinedGenitive` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `declinedNative` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `declinedAccusative` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `declinedInstrumental` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `declinedPrepositional` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `account`(`account`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of account_battlepet
-- ----------------------------
INSERT INTO `account_battlepet` VALUES (1, 24, -1, '', 0, 379, 0, 10, 1, 0, 134, 142, 0, 8, 142, 8, 1, '', '', '', '', '');
INSERT INTO `account_battlepet` VALUES (3, 25, -1, '', 0, 1934, 3, 8, 1, 0, 0, 155, 0, 11, 155, 10, 1, '', '', '', '', '');
INSERT INTO `account_battlepet` VALUES (4, 24, 0, 'Shiko', 1584803282, 225, 2, 6, 12, 170, 0, 820, 1, 115, 820, 115, 1, '', '', '', '', '');
INSERT INTO `account_battlepet` VALUES (5, 25, 0, '', 0, 196, 2, 8, 1, 0, 0, 17, 0, 10, 151, 10, 1, '', '', '', '', '');

SET FOREIGN_KEY_CHECKS = 1;
