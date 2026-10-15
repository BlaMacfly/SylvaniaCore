-- spell_proc sans SpellPhaseMask alors que les declencheurs du sort en exigent un : « Proc will not be triggered » au chargement.
-- Phase de l'impact (PROC_SPELL_PHASE_HIT = 2), la valeur de TrinityCore. Dont Boule de demolition (215569, guerrier Fureur).
UPDATE `spell_proc` SET `SpellPhaseMask` = 2 WHERE `SpellPhaseMask` = 0 AND `SpellId` IN
(70854, 215569, 7434, 37603, 38394, 39958, 40438, 40478, 45054, 55380, 60170, 60487, 64752, 64824, 64914, 70664, 70727, 71606, 71637, 209566);
