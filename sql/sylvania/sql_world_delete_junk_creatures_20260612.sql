-- ============================================================================
-- Suppression de 8 creatures "junk" (nom '0' ou vide, 0 spawn, aucune ref quete)
-- Import BfA inacheve + vieilles lignes vides. Sans effet en jeu (jamais spawnees).
-- Backup VPS : ~/fixes/backup_junk_creatures_20260612.sql.gz
-- Entries : 30618, 141706, 141767, 141804, 141826, 141845, 141903, 142154
-- ============================================================================
SET @E := '30618,141706,141767,141804,141826,141845,141903,142154';
DELETE FROM creature_equip_template   WHERE CreatureID IN (30618,141706,141767,141804,141826,141845,141903,142154);
DELETE FROM creature_template_locale  WHERE entry      IN (30618,141706,141767,141804,141826,141845,141903,142154);
DELETE FROM creature_template_addon   WHERE entry      IN (30618,141706,141767,141804,141826,141845,141903,142154);
DELETE FROM creature_template_scaling WHERE entry      IN (30618,141706,141767,141804,141826,141845,141903,142154);
DELETE FROM creature_template         WHERE entry      IN (30618,141706,141767,141804,141826,141845,141903,142154);
