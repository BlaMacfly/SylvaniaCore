-- SylvaniaCore - Module "Mercenaires"
-- Base : dc_world
--
-- Le Portail d Invocation de Mercenaire. Rang « boss » pour le contour dore,
-- faction 35 (amical avec tout le monde) et unit_flags 770 pour qu il ne puisse
-- ni etre attaque ni entrer en combat : c est un decor qui parle.
--
-- Le PNJ n est PAS spawne par ce fichier : il se pose en jeu avec
--     .npc add 1000010

DELETE FROM `creature_template` WHERE `entry` = 1000010;
INSERT INTO `creature_template`
    (`entry`, `modelid1`, `name`, `subname`, `gossip_menu_id`, `minlevel`, `maxlevel`,
     `HealthScalingExpansion`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`,
     `rank`, `unit_class`, `unit_flags`, `type`, `RegenHealth`, `flags_extra`,
     `AIName`, `MovementType`, `InhabitType`, `HealthModifier`, `ManaModifier`,
     `ArmorModifier`, `DamageModifier`, `ExperienceModifier`, `ScriptName`)
VALUES
    (1000010, 74465, "Portail d'Invocation de Mercenaire", 'Compagnie franche de Sylvania', 0, 110, 110,
     6, 35, 1, 1, 1.14286, 1,
     3, 1, 770, 10, 1, 2,
     '', 0, 3, 1, 1,
     1, 1, 1, 'npc_mercenary_portal');
