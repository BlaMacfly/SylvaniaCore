-- ============================================================================
-- Fix définitif des warnings "Missing base stats for creature class N level N"
-- (niveaux 116-120 ET 220-233) — 2026-06-12 — SANS toucher creature_classlevelstats
-- ----------------------------------------------------------------------------
-- Cause : ObjectMgr applique `level = MAX_LEVEL(110) + level` quand
--   HealthScalingExpansion = -1 (EXPANSION_LEVEL_CURRENT). Le champ level sert
--   alors de DELTA (0 => 110, 3 => 113...). 11 PNJ avaient un delta mal saisi
--   (110/113 absolus) => effectif 220/223 => aucune stat (GameTable cap ~115) => warning.
--   Ré-insérer ces niveaux dans creature_classlevelstats CRASHE le worldserver
--   (GetRow() hors bornes GameTable) -> voir incident classlevelstats.
--
-- Fix : ramener le delta à sa vraie valeur (110 -> 0, 113 -> 3) => effectif 110/113,
--   stats valides, plus aucun warning. PNJ concernés = maîtres griffons/hippogriffes,
--   transporteurs/chauffeurs, Grand Magister Rommath, + reliquat Darkspear Bat Rider.
-- Backup : ~/fixes/backup_hse_delta_20260612.sql.gz
UPDATE creature_template
   SET minlevel = minlevel - 110, maxlevel = maxlevel - 110
 WHERE HealthScalingExpansion = -1 AND maxlevel >= 110;

-- Darkspear Bat Rider (HSE=0 absolu, 0 spawn, reliquat BfA) : cap 120 -> 110
UPDATE creature_template SET maxlevel = 110 WHERE entry = 141707 AND maxlevel = 120;

-- Vérif : SELECT COUNT(*) doit = 0
--   SELECT COUNT(*) FROM creature_template
--   WHERE (CASE WHEN HealthScalingExpansion=-1 THEN 110+maxlevel ELSE maxlevel END) > 115;
