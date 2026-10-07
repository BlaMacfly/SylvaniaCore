-- Rares d'Argus suivis par le Rare Finder de World Quest Tracker (addon du site).
-- 1) 30 rares jamais poses : 29 spawns repris de LegionCore (lc_world_ref), + Commander Xethgar par Wowhead.
--    Non poses : Squadron Commander Vishax et Rezira the Seer (invoques par objet en officiel),
--    Soultender Videx (aucune position connue).
-- 2) 17 rares classes « normal » passes en elite rare (rank 2), classification officielle Wowhead.
-- 3) VignetteID manquants : appariement par VisibleTrackingQuestID de Vignette.db2 = quete de suivi du rare.
-- Sauvegarde : ~/tmp/sauvegardes/creature_template_rares_argus_2026-10-07.sql
-- Rollback   : 2026_10_07_rares_argus_rollback.sql

INSERT INTO creature (guid, id, map, zoneId, areaId, spawnDifficulties, phaseUseFlags, PhaseId, PhaseGroup, terrainSwapMap,
  modelid, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint,
  curhealth, curmana, MovementType, npcflag, unit_flags, unit_flags2, unit_flags3, dynamicflags, ScriptName, movementmode, VerifiedBuild) VALUES
(290319245, 120393, 1669, 8574, 8674, '0', 0, 0, 0, -1, 0, 0, 775.085, 1611.37, 589.305, 1.99561, 120, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, '', 0, 0), -- Siegemaster Voraan
(290319246, 122838, 1669, 8701, 8702, '0', 0, 0, 0, -1, 0, 0, 5066.19, 10094.4, -72.711, 4.97938, 120, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, '', 0, 0), -- Shadowcaster Voruun
(290319247, 123464, 1669, 8574, 9038, '0', 0, 0, 0, -1, 0, 0, 1887.14, 1810.66, 399.053, 3.1444, 120, 10, 0, 1, 0, 1, 0, 0, 0, 0, 0, '', 0, 0), -- Sister Subversia
(290319248, 124775, 1669, 8574, 8933, '0', 0, 0, 0, -1, 0, 0, 1197.2, 2090.23, 426.334, 2.19583, 120, 10, 0, 1, 0, 1, 0, 0, 0, 0, 0, '', 0, 0), -- Commander Endaxis
(290319249, 124804, 1669, 8574, 8574, '0', 0, 0, 0, -1, 0, 0, 1255.99, 1189.31, 498.123, 2.98142, 120, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, '', 0, 0), -- Tereck the Selector
(290319250, 125388, 1669, 8574, 9038, '0', 0, 0, 0, -1, 0, 0, 2165.61, 1513.36, 390.119, 3.75679, 120, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, '', 0, 0), -- Vagath the Betrayed
(290319251, 125497, 1669, 8701, 8884, '0', 0, 0, 0, -1, 0, 0, 5958.67, 9686.8, -85.5178, 2.90372, 120, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, '', 0, 0), -- Overseer Y'Sorna
(290319252, 125824, 1669, 8574, 9050, '0', 0, 0, 0, -1, 0, 0, 2476.89, 2131.63, 313.194, 1.25311, 120, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, '', 0, 0), -- Khazaduum
(290319253, 126040, 1669, 8899, 9160, '0', 0, 0, 0, -1, 0, 0, -2269.04, 9111.58, -110.447, 5.39356, 120, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, '', 0, 0), -- Puscilla
(290319254, 126199, 1669, 8899, 9156, '0', 0, 0, 0, -1, 0, 0, -2607.33, 9475, -163.271, 3.89211, 120, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, '', 0, 0), -- Vrax'thul
(290319255, 126815, 1669, 8701, 8682, '0', 0, 0, 0, -1, 0, 0, 5161.62, 9817.18, -76.7963, 3.58192, 120, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, '', 0, 0), -- Soultwisted Monstrosity
(290319256, 126862, 1669, 8701, 8702, '0', 0, 0, 0, -1, 0, 0, 5305.22, 10117.5, -90.7508, 5.10461, 120, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, '', 0, 0), -- Baruut the Bloodthirsty
(290319257, 126866, 1669, 8701, 8701, '0', 0, 0, 0, -1, 0, 0, 5224.65, 9464.93, -85.4236, 0.742359, 120, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, '', 0, 0), -- Vigilant Kuro
(290319258, 126867, 1669, 8701, 8701, '0', 0, 0, 0, -1, 0, 0, 5578.54, 10449.5, -71.2762, 2.99513, 120, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, '', 0, 0), -- Venomtail Skyfin
(290319259, 126868, 1669, 8701, 8705, '0', 0, 0, 0, -1, 0, 0, 5228.47, 10295.6, -155.528, 0.0491831, 120, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, '', 0, 0), -- Turek the Lucid
(290319260, 126887, 1669, 8701, 9195, '0', 0, 0, 0, -1, 0, 0, 5749.22, 10564.4, -14.5783, 3.79547, 120, 10, 0, 1, 0, 1, 0, 0, 0, 0, 0, '', 0, 0), -- Ataxon
(290319261, 126889, 1669, 8701, 8882, '0', 0, 0, 0, -1, 0, 0, 5623.73, 9255.38, -65.1667, 5.96526, 120, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, '', 0, 0), -- Sorolis the Ill-Fated
(290319262, 126896, 1669, 8701, 8706, '0', 0, 0, 0, -1, 0, 0, 5341.36, 10374.2, -34.2675, 4.11854, 120, 10, 0, 1, 0, 1, 0, 0, 0, 0, 0, '', 0, 0), -- Herald of Chaos
(290319263, 126899, 1669, 8701, 8703, '0', 0, 0, 0, -1, 0, 0, 5740.39, 9978.51, -63.6473, 3.93481, 120, 10, 0, 1, 0, 1, 0, 0, 0, 0, 0, '', 0, 0), -- Jed'hin Champion Vorusk
(290319264, 126946, 1669, 8899, 9144, '0', 0, 0, 0, -1, 0, 0, -2890.53, 9216.94, -137.122, 5.10075, 120, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, '', 0, 0), -- Inquisitor Vethroz
(290319265, 127084, 1669, 8899, 9153, '0', 0, 0, 0, -1, 0, 0, -3275.67, 8468.38, -72.6521, 2.63687, 120, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, '', 0, 0), -- Commander Texlaz
(290319266, 127090, 1669, 8899, 9153, '0', 0, 0, 0, -1, 0, 0, -3420.55, 8779.11, -147.096, 3.27115, 120, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, '', 0, 0), -- Admiral Rel'var
(290319267, 127096, 1669, 8899, 8899, '0', 0, 0, 0, -1, 0, 0, -3064.37, 8693.44, -127.44, 4.961, 120, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, '', 0, 0), -- All-Seer Xanarian
(290319268, 127118, 1669, 8899, 9162, '0', 0, 0, 0, -1, 0, 0, -3040.96, 9546.37, -155.499, 5.78394, 120, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, '', 0, 0), -- Worldsplitter Skuul
(290319269, 127300, 1669, 8899, 9158, '0', 0, 0, 0, -1, 0, 0, -2278.24, 9400.34, -68.5853, 1.16496, 120, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, '', 0, 0), -- Void Warden Valsuran
(290319270, 127376, 1669, 8899, 9160, '0', 0, 0, 0, -1, 0, 0, -2262.56, 9191.5, -96.582, 0, 120, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, '', 0, 0), -- Chief Alchemist Munculus
(290319271, 127581, 1669, 8899, 9156, '0', 0, 0, 0, -1, 0, 0, -2671.7, 9408.8, -163.871, 2.19978, 120, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, '', 0, 0), -- The Many-Faced Devourer
(290319272, 127703, 1669, 8899, 9158, '0', 0, 0, 0, -1, 0, 0, -2057.78, 9287.59, -66.1987, 5.63193, 120, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, '', 0, 0), -- Doomcaster Suprax
(290319273, 127705, 1669, 8899, 8899, '0', 0, 0, 0, -1, 0, 0, -2191.57, 9002.75, -117.64, 1.79106, 120, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, '', 0, 0), -- Mother Rosula
(290319274, 126910, 1669, 8701, 8884, '0', 0, 0, 0, -1, 0, 0, 6296.3, 9697.5, -77.41, 0, 120, 10, 0, 1, 0, 1, 0, 0, 0, 0, 0, '', 0, 0); -- Commander Xethgar

UPDATE creature_template SET `rank` = 2, VignetteID = 1996 WHERE entry = 120393 AND `rank` = 0 AND VignetteID = 0;
UPDATE creature_template SET `rank` = 2, VignetteID = 2230 WHERE entry = 122838 AND `rank` = 0 AND VignetteID = 0;
UPDATE creature_template SET `rank` = 2, VignetteID = 2247 WHERE entry = 125497 AND `rank` = 0 AND VignetteID = 0;
UPDATE creature_template SET `rank` = 2, VignetteID = 2232 WHERE entry = 126815 AND `rank` = 0 AND VignetteID = 0;
UPDATE creature_template SET `rank` = 2, VignetteID = 2234 WHERE entry = 126862 AND `rank` = 0 AND VignetteID = 0;
UPDATE creature_template SET `rank` = 2, VignetteID = 2238 WHERE entry = 126867 AND `rank` = 0 AND VignetteID = 0;
UPDATE creature_template SET `rank` = 2, VignetteID = 2239 WHERE entry = 126868 AND `rank` = 0 AND VignetteID = 0;
UPDATE creature_template SET `rank` = 2, VignetteID = 2242 WHERE entry = 126887 AND `rank` = 0 AND VignetteID = 0;
UPDATE creature_template SET `rank` = 2, VignetteID = 2244 WHERE entry = 126896 AND `rank` = 0 AND VignetteID = 0;
UPDATE creature_template SET `rank` = 2, VignetteID = 2271 WHERE entry = 126946 AND `rank` = 0 AND VignetteID = 0;
UPDATE creature_template SET `rank` = 2, VignetteID = 2273 WHERE entry = 127090 AND `rank` = 0 AND VignetteID = 0;
UPDATE creature_template SET `rank` = 2, VignetteID = 2300 WHERE entry = 127581 AND `rank` = 0 AND VignetteID = 0;
UPDATE creature_template SET `rank` = 2, VignetteID = 2301 WHERE entry = 127700 AND `rank` = 0 AND VignetteID = 0;
UPDATE creature_template SET `rank` = 2, VignetteID = 2302 WHERE entry = 127703 AND `rank` = 0 AND VignetteID = 0;
UPDATE creature_template SET `rank` = 2, VignetteID = 2303 WHERE entry = 127704 AND `rank` = 0 AND VignetteID = 0;
UPDATE creature_template SET `rank` = 2, VignetteID = 2304 WHERE entry = 127705 AND `rank` = 0 AND VignetteID = 0;
UPDATE creature_template SET `rank` = 2, VignetteID = 2305 WHERE entry = 127706 AND `rank` = 0 AND VignetteID = 0;
UPDATE creature_template SET VignetteID = 2231 WHERE entry = 126852 AND VignetteID = 0;
