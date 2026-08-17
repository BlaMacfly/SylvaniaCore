-- =====================================================================
-- Mardum — second lot de liaisons de scripts (suite de mardum_scriptnames.sql)
--
-- Déclencheur : la quête 38766 « Avant d'être submergés » ne se valide pas
-- en tuant Doom Commander Beliash. Cause identique à la quête 39049 traitée
-- précédemment : la quête réclame le crédit 106003 (« Beliash slain & power
-- taken »), que rien n'accorde, alors que l'IA C++ `npc_doom_commander_beliash`
-- l'accorde dans son JustDied().
--
-- Particularité de Beliash et de Fel Lord Caza : ils portaient DÉJÀ un
-- ScriptName, mais MAL ORTHOGRAPHIÉ — `npc_mardum_doom_commander_beliash` et
-- `npc_mardum_fel_lord_caza`, deux noms qui n'existent nulle part dans le
-- core (vérifié par grep sur tout src/). Ils ne pointaient donc sur rien, et
-- ce core ne journalise aucun avertissement pour un ScriptName inconnu.
--
-- Ayant constaté que le défaut se répétait, j'ai remonté TOUS les crédits de
-- quête accordés par zone_mardum.cpp et vérifié, pour chacun, que la quête
-- correspondante les réclame bien. Trois blocages supplémentaires étaient en
-- embuscade sur la suite de la campagne :
--   38728 « La Clé »               <- crédit 101760, accordé par Tyranna
--   39495 « Hidden No More »       <- crédit 106014, accordé par Caza
--   38727 « Halte au bombardement » <- crédits 96692 / 96733 / 96734,
--                                      accordés par les trois bannières
--
-- INNOCUITÉ vérifiée une par une :
--   * Beliash : son SmartAI ne lance que 195401 et 196403 ; l'IA C++ lance
--     les deux mêmes, plus Shadow Retreat et les répliques avec Tyranna.
--   * Caza : SmartAI = 197180 seul ; l'IA C++ lance 197180 + Sweeping Slash.
--   * Tous les autres (Tyranna, les 4 compagnons du combat, les 4 objets)
--     n'ont aujourd'hui NI AIName, NI ScriptName, NI ligne smart_scripts :
--     ils sont totalement inertes, la liaison ne peut rien casser.
--
-- IDENTIFICATION DES ENTRÉES, relevée et non devinée :
--   * Tyranna : deux entrées sont spawnées. 93802 (GUID 20542608) se tient à
--     (1570, 1413, 237), au milieu des quatre compagnons du combat dont les
--     GUID se suivent (20542609, 20542610, 20542497, 20542498). L'autre,
--     95048, est à 1 300 m de là en phase 50 : ce n'est pas celle du combat.
--   * Bannière de la Légion : l'objectif 1 de la quête 40077 est de type 2
--     (gameobject) et cible explicitement l'entrée 250560.
--   * Compagnons du combat : entrées données en commentaire dans le fichier
--     (97244 Kayn, 97962 Allari, 97959 Jace, 98712 Kor'vas).
--
-- RESTE OUVERT après ce patch, car cela remplacerait un SmartAI actif dont
-- je n'ai pas comparé le contenu ligne à ligne :
--   94410 Allari the Souleater (6 lignes)  -> npc_mardum_allari
--   99915 Sevis Brightflame    (12 lignes) -> npc_mardum_sevis_brightflame_shivarra
--
-- REDÉMARRAGE OBLIGATOIRE : la liste des noms de scripts est figée au boot.
-- =====================================================================

-- Correction des deux ScriptName mal orthographiés
UPDATE `creature_template` SET `ScriptName`='npc_doom_commander_beliash' WHERE `entry`=93221;
UPDATE `creature_template` SET `ScriptName`='npc_fel_lord_caza'          WHERE `entry`=96441;

-- Combat final : Tyranna et ses quatre compagnons
UPDATE `creature_template` SET `ScriptName`='npc_brood_queen_tyranna'  WHERE `entry`=93802;
UPDATE `creature_template` SET `ScriptName`='npc_kayn_tyranna_fight'   WHERE `entry`=97244;
UPDATE `creature_template` SET `ScriptName`='npc_jace_tyranna_fight'   WHERE `entry`=97959;
UPDATE `creature_template` SET `ScriptName`='npc_allari_tyranna_fight' WHERE `entry`=97962;
UPDATE `creature_template` SET `ScriptName`='npc_korvas_tyranna_fight' WHERE `entry`=98712;

-- Bannières
UPDATE `gameobject_template` SET `ScriptName`='go_mardum_illidari_banner' WHERE `entry` IN (243965,243967,243968);
UPDATE `gameobject_template` SET `ScriptName`='go_mardum_legion_banner_1' WHERE `entry`=250560;
