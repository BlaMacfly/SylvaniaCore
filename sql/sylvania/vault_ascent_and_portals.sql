-- =====================================================================
-- Caveau des Gardiennes — l'ascenseur et les Portails de la Légion
--
-- 1) QUÊTE 39686 « Jusqu'au sommet » NE SE VALIDAIT PAS
-- Son unique objectif attend le crédit 96814 (« Ascend to the Hall of
-- Judgment »), qu'aucune source n'accordait : pas une ligne smart_scripts,
-- et le code C++ qui le donne — go_warden_ascent, qui surveille les joueurs
-- à moins de 10 m et crédite dès que leur Z dépasse 253 — n'était pas
-- rattaché. Le gameobject 244644 (type 11, l'ascenseur, posé à z=253 sur la
-- carte 1468) avait un ScriptName vide.
--
-- 2) PORTAILS DE LA LÉGION — demande explicite de l'utilisateur
-- Ils sont indispensables à l'objectif bonus « Caveau des Gardiennes »
-- (quête 39742, 34 ennemis à crédit 97969) : les 119 créatures de la carte
-- qui donnent ce crédit ont un respawn de 2 h, donc un joueur traversant la
-- zone une fois ne peut pas boucler l'objectif. Les portails sont la source
-- renouvelable prévue — npc_legion_portal::OnGossipHello accorde justement
-- le crédit 97969 puis fait disparaître le portail.
-- Trois obstacles cumulés, tous levés ici :
--   * npcflag = 0        -> OnGossipHello ne pouvait pas se déclencher
--   * NOT_SELECTABLE     -> 99501 portait 33555200 = 33554432 + 768 ;
--                           on retire le bit 33554432, on garde les
--                           immunités (768) pour qu'il reste cliquable
--                           sans être frappable
--   * ScriptName vide    -> aucun script rattaché
--
-- REDÉMARRAGE OBLIGATOIRE : la liaison des noms de scripts est figée au boot.
-- =====================================================================

UPDATE `gameobject_template` SET `ScriptName`='go_warden_ascent' WHERE `entry`=244644;

UPDATE `creature_template` SET `ScriptName`='npc_legion_portal', `npcflag`=1, `unit_flags`=768 WHERE `entry`=99501;
UPDATE `creature_template` SET `ScriptName`='npc_legion_portal', `npcflag`=1                      WHERE `entry`=114358;
