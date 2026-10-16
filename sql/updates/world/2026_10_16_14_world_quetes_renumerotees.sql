-- Scripts de quetes du Marecage d'Aprefange qui visaient l'ancien numero (DEPRECATED depuis Cataclysm) au lieu du nouveau.
-- Questioning Reethe : la 27261 (donneur Ogron 4983, receveur Krog 4926) n'avait ni objectif ni drapeau d'evenement et se
-- rendait sans rien faire ; le script d'Ogron et de Paval (escorte, credit, echec a la mort) attendait la 1273.
UPDATE `smart_scripts` SET `event_param1` = 27261 WHERE `entryorguid` = 4983 AND `source_type` = 0 AND `id` = 1 AND `event_type` = 19 AND `event_param1` = 1273;
UPDATE `smart_scripts` SET `action_param1` = 27261 WHERE `entryorguid` = 4983 AND `source_type` = 0 AND `id` = 0 AND `action_type` = 6 AND `action_param1` = 1273;
UPDATE `smart_scripts` SET `action_param1` = 27261 WHERE `entryorguid` = 498001 AND `source_type` = 9 AND `id` = 0 AND `action_type` = 15 AND `action_param1` = 1273;
UPDATE `quest_template_addon` SET `SpecialFlags` = `SpecialFlags` | 2 WHERE `ID` = 27261;
-- Suspicious Hoofprints : la scene de Krog (Kagoro, salut) a la remise attendait la 1268 ; Krog rend la 27259.
UPDATE `smart_scripts` SET `event_param1` = 27259 WHERE `entryorguid` = 4926 AND `source_type` = 0 AND `id` = 0 AND `event_type` = 20 AND `event_param1` = 1268;
