-- Siege d'Orgrimmar (carte 1136) - boss 1 a 4 : malus persistant et butin de Norushen.
-- Base : dc_world. Rejouable (DELETE puis INSERT, OR binaire idempotent).
-- Va avec le binaire qui ajoute spell_immerseus_seeping_sha_dmg (boss_immerseus.cpp).

-- 1. Seeping Sha (143286) : aura de degats sans duree posee par la flaque d'Immerseus
--    (zone de 143281). Elle restait sur le joueur apres la rencontre et survivait au relog
--    (constate sur Blez le 11/10/2026 : 17 549 degats/s en mythique). Le script d'aura la
--    retire des que la rencontre n'est plus en cours.
DELETE FROM `spell_script_names` WHERE `spell_id` = 143286 AND `ScriptName` = 'spell_immerseus_seeping_sha_dmg';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (143286, 'spell_immerseus_seeping_sha_dmg');

-- 2. Amalgame de corruption (72276, porteur du Guide de la rencontre 866 Norushen).
--    Une partie de ses degats lui est infligee par des PNJ (boss_norushen.cpp : DamageTaken
--    des manifestations et essences, copie par me->DealDamage), qui ne comptent pas comme
--    degats de joueur. Sous 50 % de degats joueurs, Unit::Kill refuse la recompense : ni
--    credit de kill, ni butin. Constat : la porte de sortie de Norushen s'est ouverte (etat
--    DONE, pose par la mort de l'Amalgame) mais Blez n'a aucun credit de kill 72276.
--    CREATURE_FLAG_EXTRA_NO_PLAYER_DAMAGE_REQ = 0x00200000.
UPDATE `creature_template` SET `flags_extra` = `flags_extra` | 0x00200000 WHERE `entry` = 72276;

-- Retour arriere :
-- DELETE FROM `spell_script_names` WHERE `spell_id` = 143286 AND `ScriptName` = 'spell_immerseus_seeping_sha_dmg';
-- UPDATE `creature_template` SET `flags_extra` = `flags_extra` & ~0x00200000 WHERE `entry` = 72276;
