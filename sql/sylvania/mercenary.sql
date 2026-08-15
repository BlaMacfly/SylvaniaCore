-- SylvaniaCore - Module "Mercenaires"
-- Base : dc_world
--
-- Le Portail d Invocation de Mercenaire. Faction 35 (amical avec tout le monde),
-- echelle 0.5 et unit_flags 770 pour qu il ne puisse ni etre attaque ni entrer
-- en combat : c est un decor qui parle.
--
-- rank 3 donne le contour dore du portrait, mais c est type_flags 4
-- (CREATURE_TYPE_FLAG_BOSS_MOB) qui remplace le niveau par « ?? » cote client :
-- les deux champs voyagent separement dans SMSG_QUERY_CREATURE_RESPONSE
-- (QueryHandler.cpp, Classification et Flags[0]).
--
-- Le PNJ n est PAS spawne par ce fichier : il se pose en jeu avec
--     .npc add 1000010

DELETE FROM `creature_template` WHERE `entry` = 1000010;
INSERT INTO `creature_template`
    (`entry`, `modelid1`, `name`, `subname`, `gossip_menu_id`, `minlevel`, `maxlevel`,
     `HealthScalingExpansion`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`,
     `rank`, `unit_class`, `unit_flags`, `type`, `type_flags`, `RegenHealth`, `flags_extra`,
     `AIName`, `MovementType`, `InhabitType`, `HealthModifier`, `ManaModifier`,
     `ArmorModifier`, `DamageModifier`, `ExperienceModifier`, `ScriptName`)
VALUES
    (1000010, 74465, "Portail d'Invocation de Mercenaire", '', 0, 110, 110,
     6, 35, 1, 1, 1.14286, 0.5,
     3, 1, 770, 10, 4, 1, 2,
     '', 0, 3, 1, 1,
     1, 1, 1, 'npc_mercenary_portal');
