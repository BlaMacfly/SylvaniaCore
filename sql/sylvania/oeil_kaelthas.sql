-- =====================================================================
-- L'Oeil (550) - Kael'thas : reset en derniere phase et corps impossible a fouiller (Wisstiti, 10/11/2026)
-- Controle mental 36797 : filtre de TrinityCore 3.3.5 (jamais la cible actuelle, 3 cibles au plus).
-- Sans lui, en solo, la seule cible etait charmee et Kael faisait un evade.
-- =====================================================================
DELETE FROM `spell_script_names` WHERE `spell_id` = 36797;
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES (36797,'spell_kaelthas_mind_control');
