-- ============================================================================
-- AUDIT INTEGRITE MONDE (couche 1) — detecteurs deterministes d'anomalies data.
-- LECTURE SEULE (SELECT only). A relancer apres chaque build / import :
--     mysql -u<user> -p<pass> world < scripts/sylvania/audit_world_integrity.sql
--
-- But : transformer les bugs joueurs en bugs detectes EN LOT, avant report.
--  - checks marques "DOIT ETRE 0" = garde-fous (toute valeur > 0 = regression).
--  - checks "backlog" = liste a corriger ; pour le contenu, recouper avec le
--    core de reference de la BONNE epoque :
--      vanilla/TBC/WotLK -> AzerothCore (3.3.5)   |  MoP -> Skyfire 5.4.8
--      Cata -> TrinityCore 4.3.4                   |  Legion -> AshamaneCore / TC 7.x
--
-- Etat initial 2026-06-15 : Q2=0 Q3=0 Q5=0 (propre) | Q4=237 | Q6=4 | Q1=221 (a recouper).
-- ============================================================================

SELECT '=== Q1 : PNJ donneurs de quete (npcflag&2) sur maps d instance — A RECOUPER vs reference ===' AS audit;
-- Heuristique (le cas "Chadwick"). Beaucoup de faux positifs (PNJ de donjon
-- legitimes). La confirmation "ce PNJ ne doit pas etre sur cette map" exige la
-- reaction de faction (DB2) ou un diff couche 2 (AzerothCore/TC). Liste 'amicale'
-- a ajuster selon les faux positifs.
SELECT COUNT(DISTINCT c.id) AS nb_candidats
  FROM creature c JOIN creature_template ct ON ct.entry = c.id
 WHERE c.map IN (SELECT map FROM instance_template)
   AND (ct.npcflag & 2) <> 0
   AND ct.faction NOT IN (35);
SELECT DISTINCT c.map, c.id, ct.name, ct.faction, ct.npcflag
  FROM creature c JOIN creature_template ct ON ct.entry = c.id
 WHERE c.map IN (SELECT map FROM instance_template)
   AND (ct.npcflag & 2) <> 0
   AND ct.faction NOT IN (35)
 ORDER BY c.map, c.id;

SELECT '=== Q2 : spawns creature SANS creature_template (orphelins) — DOIT ETRE 0 ===' AS audit;
SELECT COUNT(*) AS orphan_creatures
  FROM creature c LEFT JOIN creature_template ct ON ct.entry = c.id
 WHERE ct.entry IS NULL;

SELECT '=== Q3 : creature avec smart_scripts mais AIName != SmartAI (script mort) — DOIT ETRE 0 ===' AS audit;
SELECT ct.entry, ct.name, ct.AIName
  FROM creature_template ct
 WHERE ct.AIName <> 'SmartAI'
   AND EXISTS (SELECT 1 FROM smart_scripts ss WHERE ss.source_type = 0 AND ss.entryorguid = ct.entry);

SELECT '=== Q4 : spawns en patrouille (MovementType=2) SANS chemin waypoint (figes) — backlog ===' AS audit;
SELECT c.map, COUNT(*) AS nb
  FROM creature c
 WHERE c.MovementType = 2
   AND c.guid NOT IN (SELECT DISTINCT id FROM waypoint_data)
   AND c.guid NOT IN (SELECT DISTINCT guid FROM creature_addon WHERE path_id <> 0)
 GROUP BY c.map ORDER BY nb DESC;

SELECT '=== Q5 : PNJ spawnes invisibles (modelid1..4 = 0) — DOIT ETRE 0 ===' AS audit;
SELECT COUNT(DISTINCT c.id) AS invisible_npcs
  FROM creature c JOIN creature_template ct ON ct.entry = c.id
 WHERE ct.modelid1 = 0 AND ct.modelid2 = 0 AND ct.modelid3 = 0 AND ct.modelid4 = 0;

SELECT '=== Q6 : spawns gameobject SANS gameobject_template (orphelins) — backlog ===' AS audit;
SELECT g.map, g.id, COUNT(*) AS nb
  FROM gameobject g LEFT JOIN gameobject_template gt ON gt.entry = g.id
 WHERE gt.entry IS NULL
 GROUP BY g.map, g.id;
