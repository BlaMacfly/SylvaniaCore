UPDATE `creature` SET `spawntimesecs` = 3600 WHERE `id` = 72775;

UPDATE `creature` SET `position_x` = -741.8226, `position_y` = -5075.0253, `position_z` = -6.2773, `orientation` = 0.7702 WHERE `guid` = 10574987 AND `id` = 71955;
UPDATE `creature_template` SET `faction` = 35, `unit_flags` = 256 WHERE `entry` IN (71952, 71955, 71953, 71954);
DELETE FROM `creature` WHERE `guid` = 10655823 AND `id` = 73082;
UPDATE `creature` SET `spawndist` = 10, `MovementType` = 1 WHERE `id` IN (72777);

UPDATE `creature_template` SET `ScriptName` = "npc_emperor_shaohao" WHERE `entry` = 73303;
UPDATE `creature_template` SET `ScriptName` = "boss_chi_ji_celestial" WHERE `entry` = 71952;
UPDATE `creature_template` SET `ScriptName` = "boss_niuzao_celestial" WHERE `entry` = 71954;
UPDATE `creature_template` SET `ScriptName` = "boss_xuen_celestial" WHERE `entry` = 71953;
UPDATE `creature_template` SET `ScriptName` = "boss_yu_lon_celestial" WHERE `entry` = 71955;
UPDATE `creature_template` SET `ScriptName` = "boss_ordos" WHERE entry = 72057;

UPDATE `creature_template` SET `faction` = 16, `ScriptName` = "npc_child_of_chi_ji" WHERE `entry` = 71990;
UPDATE `creature_template` SET `ScriptName` = "npc_jadefire_wall" WHERE `entry` = 72020;

DELETE FROM `spell_script_names` WHERE `spell_id` IN (144608, 144610, 144475, 144688, 144689, 144691, 144634, 144642);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(144608, "spell_niuzao_charge"),
(144610, "spell_niuzao_headbutt"),
(144475, "spell_chi_ji_beacon_of_hope"),
(144688, "spell_ordos_magma_crush"),
(144689, "spell_ordos_burning_soul_aura"),
(144691, "spell_ordos_ancient_flames"),
(144634, "spell_xuen_crackling_lightning"),
(144642, "spell_xuen_chi_barrage");

DELETE FROM `creature_text` WHERE `CreatureID` IN (73303, 71955, 71954, 71953, 71952, 72057);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `Comment`, `BroadcastTextId`) VALUES 
(73303, 0, 0, "Long ago, the Jade Serpent instructed me to purify my spirit and become one with the land, my doubts were vanquished.", 14, 0, 100, 0, 0, 38036, "Emperor Shaohao - Yu'lon Intro", 75933),
(73303, 1, 0, "When my journey began, I was reckless in my strength. The White Tiger taught me control. My hatred, anger, and violence were vanquished.", 14, 0, 100, 0, 0, 38037, "Emperor Shaohao - Xuen Intro", 75934),
(73303, 2, 0, "The Red Crane saw hope in me, and instructed me to look inward. Despite my visage of despair, I found this hope, and the despair was vanquished.", 14, 0, 100, 0, 0, 38038, "Emperor Shaohao - Chi-Ji Intro", 75935),
(73303, 3, 0, "In the face of great fear, the Black Ox taught me fortitude. Through terror and darkness it persevered. The fear was vanquished.", 14, 0, 100, 0, 0, 38039, "Emperor Shaohao - Niuzao Intro", 75936),
(73303, 4, 0, "You have walked the trial of wisdom, and learned of the path of the Jade Serpent. May you learn from this lesson, as I did.", 14, 0, 100, 0, 0, 38040, "Emperor Shaohao - Yulon Outro", 75937),
(73303, 5, 0, "You have walked the trial of strength, and learned of the path of the White Tiger. May you remember this lesson, always.", 14, 0, 100, 0, 0, 38041, "Emperor Shaohao - Xuen Outro", 75938),
(73303, 6, 0, "You have walked the trial of hope, and learned of the path of the Red Crane. May it guide your footsteps through time.", 14, 0, 100, 0, 0, 38042, "Emperor Shaohao - Red Crane Outro", 75939),
(73303, 7, 0, "You have walked the trial of fortitude, and learned of the path of the Black Ox. May it bless your passage.", 14, 0, 100, 0, 0, 38043, "Emperor Shaohao - Niuzao Outro", 75940),
(73303, 8, 0, "Welcome to a very special trial!  The wisdom of a leader is reflected in the greatness of his followers. Let us see if your training has truly inspired those you lead...", 14, 0, 100, 0, 0, 38044, "Emperor Shaohao - Intro", 75309),

(71955, 0, 0, "The trial begins!", 14, 0, 100, 0, 0, 38222, "Yu'lon", 75905),
(71955, 1, 0, "The lesson of true wisdom lies within you dear heroes, and in the choices you make. When faced with overwhelming darkness, will you make the right decisions?", 14, 0, 100, 0, 0, 38224, "Yu'lon", 75904),
(71955, 2, 0, "Your wisdom has seen you through this trial. May it ever light your way out of dark places.", 14, 0, 100, 0, 0, 38223, "Yu'lon", 75910),
(71955, 3, 0, "Learn from your mistakes!", 14, 0, 100, 0, 0, 38225, "Yu'lon", 75909),
(71955, 4, 0, "Listen to your inner voice, and seek out the truth!", 14, 0, 100, 0, 0, 38226, "Yu'lon", 75906),
(71955, 5, 0, "Do not let your judgment be clouded in trying times!", 14, 0, 100, 0, 0, 38227, "Yu'lon", 75907),
(71955, 6, 0, "Always consider the consequences of your actions!", 14, 0, 100, 0, 0, 38228, "Yu'lon", 75908),

(71954, 0, 0, "We shall see.", 14, 0, 100, 0, 0, 38755, "Niuzao", 75891),
(71954, 1, 0, "Can you stand on the tallest peak, winds and sleet buffeting your skin, until the trees wither and the mountains fall into the sea?", 14, 0, 100, 0, 0, 38757, "Niuzao", 75890),
(71954, 2, 0, "Though you will be surrounded by foes greater than you can imagine, your fortitude shall allow you to endure. Remember this in the times ahead.", 14, 0, 100, 0, 0, 38756, "Niuzao", 75896),
(71954, 3, 0, "You must persevere!", 14, 0, 100, 0, 0, 38759, "Niuzao", 75895),
(71954, 4, 0, "The winds may be strong, and the sleet may sting.", 14, 0, 100, 0, 0, 38759, "Niuzao", 75892),
(71954, 5, 0, "You are the mountain, unmovable by all but time.", 14, 0, 100, 0, 0, 38760, "Niuzao", 75893),
(71954, 6, 0, "Be vigilant in your stand, or you will never achieve your goals.", 14, 0, 100, 0, 0, 38761, "Niuzao", 75894),

(71953, 0, 0, "Ha ha! The trial commences!", 14, 0, 100, 0, 0, 38211, "Xuen", 75912),
(71953, 1, 0, "Strength. It is far more than simple physical prowess. When you are truly tested, will you be able to tell the difference between strength and power?", 14, 0, 100, 0, 0, 38213, "Xuen", 75911),
(71953, 2, 0, "You are strong, stronger even than you realize. Carry this thought with you into the darkness ahead, and let it shield you.", 14, 0, 100, 0, 0, 38212, "Xuen", 75917),
(71953, 3, 0, "Return twice as powerful!", 14, 0, 100, 0, 0, 38214, "Xuen", 75916),
(71953, 4, 0, "Believe in your strength!", 14, 0, 100, 0, 0, 38215, "Xuen", 75913),
(71953, 5, 0, "You have the power to change your destiny!", 14, 0, 100, 0, 0, 38216, "Xuen", 75914),
(71953, 6, 0, "Do not mistake the power that darkness offers for true strength!", 14, 0, 100, 0, 0, 38217, "Xuen", 75915),

(71952, 0, 0, "Then let us begin.", 14, 0, 100, 0, 0, 38024, "Chi-ji", 75898),
(71952, 1, 0, "When faced with challenges the like you have never seen, what do you hope for? What is the future you seek?", 14, 0, 100, 0, 0, 38026, "Chi-ji", 75897),
(71952, 2, 0, "Your hope shines brightly, and even more brightly when you work together to overcome. It will ever light your way in even the darkest of places.", 14, 0, 100, 0, 0, 38025, "Chi-ji", 75903),
(71952, 3, 0, "Do not give up on yourself!", 14, 0, 100, 0, 0, 38027, "Chi-ji", 75902),
(71952, 4, 0, "Believe in one another, and let others carry hope for you!", 14, 0, 100, 0, 0, 38028, "Chi-ji", 75899),
(71952, 5, 0, "Without hope, there is no brightness in the future!", 14, 0, 100, 0, 0, 38029, "Chi-ji", 75900),
(71952, 6, 0, "Create the destiny you seek!", 14, 0, 100, 0, 0, 38030, "Chi-ji", 75901),

(72057, 0, 0, "You will take my place on the eternal brazier.", 14, 0, 100, 0, 0, 38971, "Ordos", 76160),
(72057, 1, 0, "My pain... is endless...", 14, 0, 100, 0, 0, 38974, "Ordos", 76157),
(72057, 2, 0, "The flames... never cease...", 14, 0, 100, 0, 0, 38975, "Ordos", 76158),
(72057, 3, 0, "I burn... for all time...", 14, 0, 100, 0, 0, 38976, "Ordos", 76159),
(72057, 4, 0, "The eternal fire will never be extinguished.", 14, 0, 100, 0, 0, 38972, "Ordos", 76166),
(72057, 5, 0, "Up in smoke.", 14, 0, 100, 0, 0, 38977, "Ordos", 76165),
(72057, 6, 0, "You will feel but a fraction of my agony.", 14, 0, 100, 0, 0, 38980, "Ordos", 76163),
(72057, 7, 0, "Your flesh will melt.", 14, 0, 100, 0, 0, 38978, "Ordos", 76161),
(72057, 8, 0, "Burn!", 14, 0, 100, 0, 0, 38981, "Ordos", 76164),
(72057, 9, 0, "Your pain will be endless.", 14, 0, 100, 0, 0, 38979, "Ordos", 76162);

-- Loot Rework
DELETE FROM `creature_loot_template` WHERE `Entry` IN (72775);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES
(72775, 105715, 0, 25, 0, 1, 0, 1, 1),
(72775, 103982, 0, 4, 0, 1, 0, 1, 1),
(72775, 103642, 0, 4, 0, 1, 0, 1, 1),
(72775, 103641, 0, 4, 0, 1, 0, 1, 1),
(72775, 103643, 0, 4, 0, 1, 0, 1, 1),
(72775, 104169, 0, 3, 0, 1, 0, 1, 1),
(72775, 102318, 0, 2, 0, 1, 0, 1, 1),
(72775, 102291, 0, 1.2, 0, 1, 0, 1, 1),
(72775, 102268, 0, 1.1, 0, 1, 0, 1, 1),
(72775, 102278, 0, 0.9, 0, 1, 0, 1, 1),
(72775, 102265, 0, 0.9, 0, 1, 0, 1, 1),
(72775, 104347, 0, 0.8, 0, 1, 0, 1, 1),
(72775, 102274, 0, 0.8, 0, 1, 0, 1, 1),
(72775, 102288, 0, 0.8, 0, 1, 0, 1, 1),
(72775, 102286, 0, 0.8, 0, 1, 0, 1, 1),
(72775, 102276, 0, 0.8, 0, 1, 0, 1, 1),
(72775, 102269, 0, 0.8, 0, 1, 0, 1, 1),
(72775, 102322, 0, 0.7, 0, 1, 0, 1, 1),
(72775, 102279, 0, 0.7, 0, 1, 0, 1, 1),
(72775, 102281, 0, 0.7, 0, 1, 0, 1, 1),
(72775, 102272, 0, 0.7, 0, 1, 0, 1, 1),
(72775, 102320, 0, 0.7, 0, 1, 0, 1, 1),
(72775, 102267, 0, 0.7, 0, 1, 0, 1, 1),
(72775, 102321, 0, 0.7, 0, 1, 0, 1, 1),
(72775, 102277, 0, 0.7, 0, 1, 0, 1, 1),
(72775, 102283, 0, 0.7, 0, 1, 0, 1, 1),
(72775, 102270, 0, 0.7, 0, 1, 0, 1, 1),
(72775, 102275, 0, 0.7, 0, 1, 0, 1, 1),
(72775, 102273, 0, 0.7, 0, 1, 0, 1, 1),
(72775, 102266, 0, 0.7, 0, 1, 0, 1, 1),
(72775, 102290, 0, 0.7, 0, 1, 0, 1, 1),
(72775, 102287, 0, 0.7, 0, 1, 0, 1, 1),
(72775, 102323, 0, 0.6, 0, 1, 0, 1, 1),
(72775, 102271, 0, 0.6, 0, 1, 0, 1, 1),
(72775, 102264, 0, 0.6, 0, 1, 0, 1, 1),
(72775, 102285, 0, 0.6, 0, 1, 0, 1, 1),
(72775, 102282, 0, 0.6, 0, 1, 0, 1, 1),
(72775, 102280, 0, 0.6, 0, 1, 0, 1, 1),
(72775, 102289, 0, 0.6, 0, 1, 0, 1, 1),
(72775, 102284, 0, 0.5, 0, 1, 0, 1, 1),
(72775, 104345, 0, 0.5, 0, 1, 0, 1, 1),
(72775, 102263, 0, 0.5, 0, 1, 0, 1, 1);

-- SAI Rework
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (72045, 73161, 72765, 72764, 72763) AND `source_type` = 0;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (73361, 73362, 71940, 71939, 73343) AND `source_type` = 0;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (73163, 72841) AND `source_type` = 0;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (73160, 72842, 72843, 72844) AND `source_type` = 0;

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (72777, 72775) AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(72045, 0, 0, 0, 0, 0, 100, 0, 5000, 8000, 12000, 15000, 11, 147572, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Chelon - In Combat - Cast Spell 'Geyser'"),
(72045, 0, 1, 0, 9, 0, 100, 0, 0, 8, 15000, 25000, 11, 147571, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Chelon - On Close < 8 Yard - Cast Spell 'Shell Spin'"),
(72045, 0, 2, 0, 2, 0, 100, 0, 0, 40, 22000, 25000, 11, 147569, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Chelon - 0-40% HP - Cast 'Snapping Bite'"),
(73161, 0, 0, 0, 0, 0, 100, 0, 5000, 8000, 12000, 15000, 11, 147572, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Great Turtle Furyshell - In Combat - Cast Spell 'Geyser'"),
(73161, 0, 1, 0, 9, 0, 100, 0, 0, 8, 15000, 25000, 11, 147571, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Great Turtle Furyshell - On Close < 8 Yard - Cast Spell 'Shell Spin'"),
(72765, 0, 0, 0, 0, 0, 100, 0, 5000, 8000, 12000, 15000, 11, 147573, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Elder Great Turtle - In Combat - Cast Spell 'Geyser'"),
(72764, 0, 0, 0, 2, 0, 100, 0, 0, 40, 22000, 25000, 11, 147568, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Great Turtle - 0-40% HP - Cast Spell 'Snapping Bite'"),
(72764, 0, 1, 0, 9, 0, 100, 0, 0, 8, 15000, 25000, 11, 147571, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Great Turtle - On Close < 8 Yards - Cast Spell 'Shell Spin'"),
(72763, 0, 0, 0, 2, 0, 100, 0, 0, 40, 22000, 25000, 11, 147568, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Great Turtle Hatchling - 0-40% HP - Cast Spell 'Snapping Bite'"),

(73361, 0, 0, 0, 0, 0, 100, 0, 5000, 8000, 12000, 15000, 11, 19643, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Tushui Sentry - In Combat - Cast Spell 'Mortal Strike'"),
(73361, 0, 1, 0, 9, 0, 100, 0, 0, 20, 15000, 25000, 11, 81210, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Tushui Sentry - On Close < 20 Yards - Cast Spell 'Net'"),
(73361, 0, 2, 0, 13, 0, 100, 0, 12000, 15000, 0, 0, 11, 15618, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Tushui Sentry - On Target Casting - Cast Spell 'Snap Kick'"),
(73362, 0, 0, 0, 0, 0, 100, 0, 5000, 8000, 12000, 15000, 11, 19643, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Huojin Sentry - In Combat - Cast Spell 'Mortal Strike'"),
(73362, 0, 1, 0, 9, 0, 100, 0, 0, 20, 15000, 25000, 11, 81210, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Huojin Sentry - On Close < 20 Yards - Cast Spell 'Net'"),
(73362, 0, 2, 0, 13, 0, 100, 0, 12000, 15000, 0, 0, 11, 15618, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Huojin Sentry - On Target Casting - Cast Spell 'Snap Kick'"),
(71940, 0, 0, 0, 9, 0, 100, 0, 0, 20, 15000, 25000, 11, 81210, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Michi Windblossom - On Close < 20 Yards - Cast Spell 'Net'"),
(71939, 0, 0, 0, 0, 0, 100, 0, 5000, 8000, 12000, 15000, 11, 19643, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Chi-Ro the Skytamer - In Combat - Cast Spell 'Mortal Strike'"),
(71939, 0, 1, 0, 9, 0, 100, 0, 0, 20, 15000, 25000, 11, 81210, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Chi-Ro the Skytamer - On Close < 20 Yards - Cast Spell 'Net'"),
(73343, 0, 0, 0, 0, 0, 100, 0, 5000, 8000, 12000, 15000, 11, 19643, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Celestial Guard - In Combat - Cast Spell 'Mortal Strike'"),
(73343, 0, 1, 0, 9, 0, 100, 0, 0, 20, 15000, 25000, 11, 81210, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Celestial Guard - On Close < 20 Yards - Cast Spell 'Net'"),
(73343, 0, 2, 0, 13, 0, 100, 0, 12000, 15000, 0, 0, 11, 15618, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Celestial Guard - On Target Casting - Cast Spell 'Snap Kick'"),

(73163, 0, 0, 0, 0, 0, 100, 0, 5000, 8000, 12000, 15000, 11, 147290, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Imperial Python - In Combat - Cast Spell 'Huge Fang'"),
(72841, 0, 0, 0, 0, 0, 100, 0, 5000, 8000, 12000, 15000, 11, 147289, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Death Adder - In Combat - Cast Spell 'Huge Fang'"),

(73160, 0, 0, 0, 2, 0, 100, 1, 0, 30, 0, 0, 11, 147368, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Ironfur Steelhorn - 0-30% HP - Cast Spell 'Iron Fur'"),
(72842, 0, 0, 0, 0, 0, 100, 0, 5000, 8000, 12000, 15000, 11, 147354, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Ironfur Herdling - In Combat - Cast Spell 'Headbutt'"),
(72843, 0, 0, 0, 0, 0, 100, 0, 5000, 8000, 12000, 15000, 11, 147382, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Ironfur Grazer - In Combat - Cast Spell 'Headbutt'"),
(72843, 0, 1, 0, 2, 0, 100, 1, 0, 30, 0, 0, 11, 147368, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Ironfur Grazer - 0-30% HP - Cast Spell 'Iron Fur'"),
(72844, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 147386, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Ironfur Great Bull - On Aggro - Cast Spell 'Ox Charge'"),
(72844, 0, 1, 0, 2, 0, 100, 1, 0, 30, 0, 0, 11, 147368, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Ironfur Great Bull - 0-30% HP - Cast Spell 'Iron Fur'"),

-- 73158
-- 72762
-- 71143
-- 72095

-- 72909
-- 72908

-- 72766
-- 73166

-- 73021
-- 73025
-- 73018

-- 72807
-- 72805

-- 71919

-- 73162
-- 72769

-- 72809
-- 72970

(72777, 0, 0, 0, 0, 0, 100, 0, 5000, 8000, 12000, 15000, 11, 147655, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Gulp Frog - In Combat - Cast Spell 'Gulp Frog Toxin'"),
(72777, 0, 1, 0, 2, 0, 100, 0, 0, 40, 15000, 15000, 11, 147654, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Gulp Frog - 0-40% HP - Cast Spell 'Toxic Skin'"),
(72775, 0, 0, 0, 0, 0, 100, 0, 5000, 8000, 12000, 15000, 11, 147655, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Bufo - In Combat - Cast Spell 'Gulp Frog Toxin'"),
(72775, 0, 1, 0, 2, 0, 100, 0, 0, 40, 15000, 15000, 11, 147654, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Bufo - 0-40% HP - Cast Spell 'Toxic Skin'");

-- 72876
-- 73167

-- 72897
-- 72896
-- 72898
-- 73172
-- 73173
-- 73666

-- 73528

-- 72771
-- 73157
-- 71864

-- 72892
-- 73169

-- 72895
-- 73171

-- 72894
-- 73170

-- 72888
-- 73175

-- 73277
-- 72877

-- 72193
-- 72245
-- 72767
-- 72049
-- 71823
-- 72875
-- 73282
-- 72048
-- 73718
-- 71883
-- 71986
-- 73704
-- 71987

-- 73174
-- 73666
-- 73171
-- 72045
-- 73175
-- 72049
-- 73281
-- 73158
-- 73279
-- 73172
-- 72970
-- 73161
-- 72909
-- 73167
-- 73160
-- 73163
-- 73169
-- 72193
-- 73277
-- 73166
-- 72048
-- 73157
-- 71864
-- 72769
-- 72808
-- 73173
-- 73170
-- 72245
-- 71919
-- 73704

UPDATE `creature_template` SET `gossip_menu_id` = 15879 WHERE `entry` = 73343;
DELETE FROM `gossip_menu` WHERE `MenuId` = 15879;
INSERT INTO `gossip_menu` (`MenuId`, `TextId`, `VerifiedBuild`) VALUES
(15879, 22858, 28153);

UPDATE `creature_template` SET `gossip_menu_id` = 15832 WHERE `entry` = 73019;
DELETE FROM `gossip_menu` WHERE `MenuId` = 15832;
INSERT INTO `gossip_menu` (`MenuId`, `TextId`, `VerifiedBuild`) VALUES
(15832, 22764, 28153);

UPDATE `creature_template` SET `gossip_menu_id` = 15831 WHERE `entry` = 73016;
DELETE FROM `gossip_menu` WHERE `MenuId` = 15831;
INSERT INTO `gossip_menu` (`MenuId`, `TextId`, `VerifiedBuild`) VALUES
(15831, 22763, 28153);

UPDATE `creature_template` SET `gossip_menu_id` = 15829 WHERE `entry` = 73017;
DELETE FROM `gossip_menu` WHERE `MenuId` = 15829;
INSERT INTO `gossip_menu` (`MenuId`, `TextId`, `VerifiedBuild`) VALUES
(15829, 22761, 28153);

UPDATE `creature_template` SET `gossip_menu_id` = 15828 WHERE `entry` = 73020;
DELETE FROM `gossip_menu` WHERE `MenuId` = 15828;
INSERT INTO `gossip_menu` (`MenuId`, `TextId`, `VerifiedBuild`) VALUES
(15828, 22760, 28153);

UPDATE `creature_template` SET `gossip_menu_id` = 15884 WHERE `entry` = 73434;
DELETE FROM `gossip_menu` WHERE `MenuId` = 15884;
INSERT INTO `gossip_menu` (`MenuId`, `TextId`, `VerifiedBuild`) VALUES
(15884, 22876, 28153);

UPDATE `creature_template` SET `gossip_menu_id` = 15883 WHERE `entry` = 73433;
DELETE FROM `gossip_menu` WHERE `MenuId` = 15883;
INSERT INTO `gossip_menu` (`MenuId`, `TextId`, `VerifiedBuild`) VALUES
(15883, 23009, 28153);

UPDATE `creature_template` SET `gossip_menu_id` = 15993 WHERE `entry` = 73820;
DELETE FROM `gossip_menu` WHERE `MenuId` = 15993;
INSERT INTO `gossip_menu` (`MenuId`, `TextId`, `VerifiedBuild`) VALUES
(15993, 23044, 28153);

UPDATE `creature_template` SET `gossip_menu_id` = 15827 WHERE `entry` = 72994;
DELETE FROM `gossip_menu` WHERE `MenuId` = 15827;
INSERT INTO `gossip_menu` (`MenuId`, `TextId`, `VerifiedBuild`) VALUES
(15827, 22759, 28153);
