-- Scripts de sorts de classe lies au mauvais sort (crochet mort au demarrage, verifie contre les donnees 7.3.5 du client).
-- Frappe nerveuse : le script reagit a la fin d'un etourdissement, il va sur Aiguillon perfide et Coup bas ; le malus sur 112947.
DELETE FROM `spell_script_names` WHERE `spell_id` = 108210 AND `ScriptName` IN ('spell_rog_nerve_strike', 'spell_rog_nerve_strike_aura');
DELETE FROM `spell_script_names` WHERE `ScriptName` IN ('spell_rog_nerve_strike', 'spell_rog_nerve_strike_aura') AND `spell_id` IN (408, 1833, 112947);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(408, 'spell_rog_nerve_strike'),
(1833, 'spell_rog_nerve_strike'),
(112947, 'spell_rog_nerve_strike_aura');

-- Faucheur d'ame 7.3.5 (130736) : branche sur l'eclatement des Blessures purulentes ; l'ancien script (version Pandarie) est retire
DELETE FROM `spell_script_names` WHERE `spell_id` = 130736 AND `ScriptName` = 'spell_dk_soul_reaper';
DELETE FROM `spell_script_names` WHERE `spell_id` = 194311 AND `ScriptName` = 'spell_dk_festering_wound_soul_reaper';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (194311, 'spell_dk_festering_wound_soul_reaper');

-- Liaisons mortes et deja couvertes ailleurs (seul effet : le message d'erreur au demarrage)
DELETE FROM `spell_script_names` WHERE (`spell_id`, `ScriptName`) IN (
  (14062, 'spell_rog_nightstalker'),          -- Rodeur nocturne : gere par le script de Camouflage
  (49184, 'spell_dk_icy_touch'),              -- Rafale hurlante : la Fievre de givre est posee par spell_dk_howling_blast
  (5394, 'spell_sha_healing_stream_totem'),   -- Totem guerisseur : le totem lance lui-meme son aura de soin (5672)
  (106832, 'spell_dru_thrash_bear'),          -- Rosser : le script vise les degats de 77758
  (97463, 'spell_warr_rallying_cry'));        -- Cri de ralliement : le script vise 97462
