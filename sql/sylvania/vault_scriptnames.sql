-- =====================================================================
-- Caveau des Gardiennes (carte 1468) — rattachement des IA C++ orphelines
--
-- zone_vault_of_wardens.cpp déclare 26 scripts ; UN SEUL était rattaché
-- (npc_vault_of_the_wardens_vampiric_felbat -> 99443). Toute la fin de la
-- campagne chasseur de démons en dépendait : Bastillax, le Bassin du
-- Jugement, Khadgar, le choix entre Kayn et Altruis.
--
-- ⚠️ MÉTHODE : les commentaires de ce fichier sont TROMPEURS et m'ont
-- induit en erreur trois fois. L'entrée 243967 y est donnée pour DEUX
-- scripts différents (go_reflective_mirror et go_pool_of_judgements) et
-- elle est fausse dans les deux cas ; 197180 est un identifiant de SORT
-- présenté comme une créature. Chaque correspondance ci-dessous a donc été
-- établie par les DONNÉES — nom en base, rôle de donneur/récepteur de
-- quête, ou proximité géographique — puis vérifiée. Aucune n'est reprise
-- d'un commentaire sans contrôle.
--
-- Comment chaque entrée a été identifiée :
--   244455 Pool of Judgment / 244449 Reflective Mirror : par leur NOM en
--          base sur la carte 1468 (les commentaires disaient 243967 pour
--          les deux, c'était faux)
--   96783  Bastillax          : par son nom ; son JustDied accorde 113812
--          et 106255, les deux objectifs de « La liberté à portée d'ailes »
--   96665  Kayn Sunfury       : récepteur de 38690, dont le script gère
--          justement OnQuestReward(QUEST_RISE_OF_THE_ILLIDARI)
--   96666 / 96669             : récepteurs de 39688, les « 4e » incarnations
--   97644  Kor'vas Bloodthorn : récepteur de 39686 ET de 40373
--   97978  Archmage Khadgar   : récepteur de 39689/39690, que son script gère
--   96681  Ash'golm / 96682 Immolanth : par leur nom en base
--   96672  Cyana Nightglaive  : le seul spawn de Cyana à 27 m d'Immolanth
--          (les deux autres sont à 462 et 635 m)
--
-- INNOCUITÉ : les 11 cibles n'ont NI ScriptName NI ligne smart_scripts.
-- Il n'y a donc rien à remplacer, aucune régression possible.
--
-- DÉLIBÉRÉMENT NON RATTACHÉS (SmartAI actif, exigeraient une comparaison
-- ligne à ligne avant de trancher — même prudence qu'à Mardum, où deux IA
-- C++ se sont révélées être des ébauches inférieures au SmartAI en place) :
--   92718 Maiev (5 lignes), 92986 Altruis (4), 99631 Kayn (9),
--   99632 Altruis (8), 92984/92985/92990/97632 (les scripts de combat),
--   103655/103658 (les cellules, 4 lignes chacune).
-- Et deux non identifiés : npc_fel_infusion (aucune créature de ce nom) et
-- npc_vault_of_the_wardens_sledge_or_crusher (son commentaire donne un
-- identifiant de sort ; son rôle — créditer 106241 par proximité — est de
-- toute façon déjà couvert par vault_crusher_sledge_credit.sql).
--
-- REDÉMARRAGE OBLIGATOIRE : les noms de scripts sont figés au démarrage.
-- =====================================================================

UPDATE `creature_template` SET `ScriptName`='npc_kayn_3'                WHERE `entry`=96665;
UPDATE `creature_template` SET `ScriptName`='npc_kayn_sunfury_4'        WHERE `entry`=96666;
UPDATE `creature_template` SET `ScriptName`='npc_altruis_sufferer_4'    WHERE `entry`=96669;
UPDATE `creature_template` SET `ScriptName`='npc_cyana_immolanth_fight' WHERE `entry`=96672;
UPDATE `creature_template` SET `ScriptName`='npc_vow_ashgolm'           WHERE `entry`=96681;
UPDATE `creature_template` SET `ScriptName`='npc_immolanth'             WHERE `entry`=96682;
UPDATE `creature_template` SET `ScriptName`='npc_bastillax'             WHERE `entry`=96783;
UPDATE `creature_template` SET `ScriptName`='npc_korvas_bloodthorn'     WHERE `entry`=97644;
UPDATE `creature_template` SET `ScriptName`='npc_khadgar'               WHERE `entry`=97978;

UPDATE `gameobject_template` SET `ScriptName`='go_reflective_mirror'    WHERE `entry`=244449;
UPDATE `gameobject_template` SET `ScriptName`='go_pool_of_judgements'   WHERE `entry`=244455;
