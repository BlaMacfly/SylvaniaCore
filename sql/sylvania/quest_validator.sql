-- =====================================================================
--  quest_validator.sql  —  Validateur statique de quetes (Couche 1)
--  Serveur : DestinyCore / SylvaniaCore  (Legion 7.3.5, base dc_world)
--  LECTURE SEULE : ne cree que des TEMPORARY TABLE, aucun write persistant.
--  Usage : MYSQL_PWD=xxx mysql -u blamacfly -t dc_world < quest_validator.sql
--
--  Regle flags effectifs (confirmee Creature.cpp, chemin save l.1189) :
--      effectif = spawn.<flag> si <>0, sinon creature_template.<flag>
--  Constantes :
--      NPC_FLAG_QUESTGIVER      = 0x2        = 2
--      UNIT_FLAG_NOT_SELECTABLE = 0x02000000 = 33554432
--      gameobject_template.type : 3=CHEST(Data1=lootId)  10=GOOBER(Data1=questID)
--      quest_objectives.Type    : 0=Kill 2=GameObject 3=TalkTo
--  Limite MySQL geree : une TEMP table ne peut etre lue 2x dans 1 requete
--      -> copie _cre_b pour les regles qui lisent _cre deux fois.
-- =====================================================================

SET SESSION sql_mode = '';                 -- desactive ONLY_FULL_GROUP_BY + strict (truncation -> warning)
SET SESSION group_concat_max_len = 8192;

-- ---------- table de resultats ----------
DROP TEMPORARY TABLE IF EXISTS _qfind;
CREATE TEMPORARY TABLE _qfind (
  severity   TINYINT,        -- 1=CRITIQUE  2=ELEVE  3=MOYEN
  scope      VARCHAR(6),     -- INST = touche un donjon/raid, sinon WORLD
  rule       VARCHAR(32),
  quest_id   INT NULL,
  object_id  INT NULL,
  detail     VARCHAR(255)
) ENGINE=MEMORY;

-- ---------- jeux d'aide ----------
DROP TEMPORARY TABLE IF EXISTS _cre;
CREATE TEMPORARY TABLE _cre ENGINE=MEMORY AS
SELECT c.id AS entry,
       MAX(it.map IS NOT NULL)                                                AS on_inst,
       MAX(((IF(c.npcflag<>0,  c.npcflag,  t.npcflag))  & 2)        <> 0)     AS qg,
       MAX(((IF(c.unit_flags<>0,c.unit_flags,t.unit_flags)) & 33554432) = 0)  AS selectable
FROM creature c
JOIN creature_template t ON t.entry = c.id
LEFT JOIN instance_template it ON it.map = c.map
GROUP BY c.id;
ALTER TABLE _cre ADD PRIMARY KEY(entry);

DROP TEMPORARY TABLE IF EXISTS _cre_b;          -- copie (limite reopen TEMP)
CREATE TEMPORARY TABLE _cre_b ENGINE=MEMORY AS SELECT * FROM _cre;
ALTER TABLE _cre_b ADD PRIMARY KEY(entry);

DROP TEMPORARY TABLE IF EXISTS _killcredit;     -- entrees atteignables via KillCredit1/2 d'un spawn
CREATE TEMPORARY TABLE _killcredit ENGINE=MEMORY AS
SELECT DISTINCT k AS entry FROM (
  SELECT DISTINCT t.KillCredit1 k FROM creature c JOIN creature_template t ON t.entry=c.id WHERE t.KillCredit1<>0
  UNION
  SELECT DISTINCT t.KillCredit2   FROM creature c JOIN creature_template t ON t.entry=c.id WHERE t.KillCredit2<>0
) z;
ALTER TABLE _killcredit ADD PRIMARY KEY(entry);

DROP TEMPORARY TABLE IF EXISTS _go;
CREATE TEMPORARY TABLE _go ENGINE=MEMORY AS
SELECT g.id AS entry, MAX(it.map IS NOT NULL) AS on_inst
FROM gameobject g LEFT JOIN instance_template it ON it.map = g.map
GROUP BY g.id;
ALTER TABLE _go ADD PRIMARY KEY(entry);

DROP TEMPORARY TABLE IF EXISTS _qinst;          -- quetes touchant une map d'instance
CREATE TEMPORARY TABLE _qinst ENGINE=MEMORY AS
SELECT DISTINCT q AS quest FROM (
  SELECT cs.quest q FROM creature_queststarter cs JOIN creature c ON c.id=cs.id JOIN instance_template it ON it.map=c.map
  UNION SELECT ce.quest FROM creature_questender ce JOIN creature c ON c.id=ce.id JOIN instance_template it ON it.map=c.map
  UNION SELECT o.QuestID  FROM quest_objectives o JOIN creature   c ON c.id=o.ObjectID JOIN instance_template it ON it.map=c.map WHERE o.Type IN (0,3)
  UNION SELECT o.QuestID  FROM quest_objectives o JOIN gameobject g ON g.id=o.ObjectID JOIN instance_template it ON it.map=g.map WHERE o.Type=2
) z;
ALTER TABLE _qinst ADD PRIMARY KEY(quest);

DROP TEMPORARY TABLE IF EXISTS _qdisabled;      -- quetes desactivees volontairement (sourceType 1 = QUEST)
CREATE TEMPORARY TABLE _qdisabled ENGINE=MEMORY AS SELECT DISTINCT entry AS quest FROM disables WHERE sourceType=1;
ALTER TABLE _qdisabled ADD PRIMARY KEY(quest);

-- _qlive : quetes qu'un joueur peut REELLEMENT obtenir (donneur spawne + flag QUESTGIVER + selectionnable).
--   Filtre cle : une quete a objectif/rendu casse n'est un VRAI bug joueur que si elle est obtenable.
DROP TEMPORARY TABLE IF EXISTS _qlive;
CREATE TEMPORARY TABLE _qlive ENGINE=MEMORY AS
SELECT DISTINCT s.quest AS quest
FROM creature_queststarter s
JOIN creature c ON c.id=s.id
JOIN creature_template t ON t.entry=c.id
WHERE ((IF(c.npcflag<>0,  c.npcflag,  t.npcflag))  & 2)        <> 0
  AND ((IF(c.unit_flags<>0,c.unit_flags,t.unit_flags)) & 33554432) =  0;
ALTER TABLE _qlive ADD PRIMARY KEY(quest);

-- =====================================================================
--  REGLES
-- =====================================================================

-- R1 STARTER_NO_SPAWN (sev2) : donneurs presents mais aucun spawne -> indonnable
INSERT INTO _qfind
SELECT 2, IF(qi.quest IS NULL,'WORLD','INST'), 'STARTER_NO_SPAWN', s.quest, NULL,
       LEFT(CONCAT('donneur(s) jamais spawne(s): ', GROUP_CONCAT(DISTINCT s.id)),255)
FROM creature_queststarter s
LEFT JOIN _qinst qi ON qi.quest=s.quest
WHERE s.quest NOT IN (SELECT quest FROM _qdisabled)
  AND NOT EXISTS (SELECT 1 FROM creature_queststarter cs JOIN creature c ON c.id=cs.id WHERE cs.quest=s.quest)
GROUP BY s.quest, qi.quest;

-- R2 ENDER_NO_SPAWN (sev1) : rendeurs presents mais aucun spawne -> inrendable
INSERT INTO _qfind
SELECT 1, IF(qi.quest IS NULL,'WORLD','INST'), 'ENDER_NO_SPAWN', e.quest, NULL,
       LEFT(CONCAT('rendeur(s) jamais spawne(s): ', GROUP_CONCAT(DISTINCT e.id)),255)
FROM creature_questender e
LEFT JOIN _qinst qi ON qi.quest=e.quest
WHERE e.quest NOT IN (SELECT quest FROM _qdisabled)
  AND NOT EXISTS (SELECT 1 FROM creature_questender ce JOIN creature c ON c.id=ce.id WHERE ce.quest=e.quest)
GROUP BY e.quest, qi.quest;

-- R3 STARTER_NO_QGFLAG (sev2) : donneur spawne mais aucun spawn flag QUESTGIVER
INSERT INTO _qfind
SELECT 2, IF(qi.quest IS NULL,'WORLD','INST'), 'STARTER_NO_QGFLAG', s.quest, NULL,
       LEFT(CONCAT('donneur spawne sans flag QUESTGIVER: ', GROUP_CONCAT(DISTINCT s.id)),255)
FROM creature_queststarter s
LEFT JOIN _qinst qi ON qi.quest=s.quest
WHERE s.quest NOT IN (SELECT quest FROM _qdisabled)
  AND EXISTS     (SELECT 1 FROM creature_queststarter c1 JOIN _cre   x  ON x.entry=c1.id  WHERE c1.quest=s.quest)
  AND NOT EXISTS (SELECT 1 FROM creature_queststarter c2 JOIN _cre_b x2 ON x2.entry=c2.id WHERE c2.quest=s.quest AND x2.qg=1)
GROUP BY s.quest, qi.quest;

-- R4 ENDER_NO_QGFLAG (sev1) : rendeur spawne mais aucun spawn flag QUESTGIVER
INSERT INTO _qfind
SELECT 1, IF(qi.quest IS NULL,'WORLD','INST'), 'ENDER_NO_QGFLAG', e.quest, NULL,
       LEFT(CONCAT('rendeur spawne sans flag QUESTGIVER: ', GROUP_CONCAT(DISTINCT e.id)),255)
FROM creature_questender e
LEFT JOIN _qinst qi ON qi.quest=e.quest
WHERE e.quest NOT IN (SELECT quest FROM _qdisabled)
  AND EXISTS     (SELECT 1 FROM creature_questender c1 JOIN _cre   x  ON x.entry=c1.id  WHERE c1.quest=e.quest)
  AND NOT EXISTS (SELECT 1 FROM creature_questender c2 JOIN _cre_b x2 ON x2.entry=c2.id WHERE c2.quest=e.quest AND x2.qg=1)
GROUP BY e.quest, qi.quest;

-- R5 GIVER_NOT_SELECTABLE (sev1) : donneur/rendeur dont aucun spawn n'est selectionnable (cas A'zak)
INSERT INTO _qfind
SELECT 1, IF(qi.quest IS NULL,'WORLD','INST'), 'GIVER_NOT_SELECTABLE', g.quest, NULL,
       LEFT(CONCAT('PNJ donneur/rendeur non selectionnable: ', GROUP_CONCAT(DISTINCT g.id)),255)
FROM (SELECT quest,id FROM creature_queststarter UNION SELECT quest,id FROM creature_questender) g
JOIN _cre x ON x.entry=g.id AND x.selectable=0
LEFT JOIN _qinst qi ON qi.quest=g.quest
WHERE g.quest NOT IN (SELECT quest FROM _qdisabled)
  AND NOT EXISTS (SELECT 1
                  FROM (SELECT quest,id FROM creature_queststarter UNION SELECT quest,id FROM creature_questender) g2
                  JOIN _cre_b x2 ON x2.entry=g2.id
                  WHERE g2.quest=g.quest AND x2.selectable=1)
GROUP BY g.quest, qi.quest;

-- R6 OBJ_KILL_UNSPAWNED (sev2) : objectif kill/talk cible ni spawnee ni credit de mise a mort
INSERT INTO _qfind
SELECT 2, IF(qi.quest IS NULL,'WORLD','INST'), 'OBJ_KILL_UNSPAWNED', o.QuestID, o.ObjectID,
       LEFT(CONCAT('objectif Type', o.Type, ' cible creature ', o.ObjectID, ' jamais spawnee (verifier summon scripte)'),255)
FROM quest_objectives o
LEFT JOIN _qinst qi ON qi.quest=o.QuestID
WHERE o.Type IN (0,3) AND o.ObjectID>0
  AND o.QuestID NOT IN (SELECT quest FROM _qdisabled)
  AND NOT EXISTS (SELECT 1 FROM _cre        x WHERE x.entry=o.ObjectID)
  AND NOT EXISTS (SELECT 1 FROM _killcredit k WHERE k.entry=o.ObjectID);

-- R7 OBJ_GO_UNSPAWNED (sev2) : objectif sur objet de jeu jamais spawne
--   ⚠️ CALIBRE 23/06 : beaucoup d'objectifs GO Legion sont spawnes par scenario/phasing/script, PAS en statique
--   (meme la TDB 7.3.5 propre ne les a pas dans `gameobject`). Donc un hit ici = candidat ; le FIX est souvent
--   de la reconstruction de contenu scenarise (coords introuvables en reference), pas une simple copie de spawn.
INSERT INTO _qfind
SELECT 2, IF(qi.quest IS NULL,'WORLD','INST'), 'OBJ_GO_UNSPAWNED', o.QuestID, o.ObjectID,
       LEFT(CONCAT('objectif GameObject ', o.ObjectID, ' jamais spawne'),255)
FROM quest_objectives o
LEFT JOIN _qinst qi ON qi.quest=o.QuestID
WHERE o.Type=2 AND o.ObjectID>0
  AND o.QuestID NOT IN (SELECT quest FROM _qdisabled)
  AND NOT EXISTS (SELECT 1 FROM _go x WHERE x.entry=o.ObjectID);

-- R8 GOOBER_QUESTID_MISMATCH (sev2) : goober objectif dont Data1(questID) != la quete (cas oeufs Azjol)
INSERT INTO _qfind
SELECT 2, IF(qi.quest IS NULL,'WORLD','INST'), 'GOOBER_QUESTID_MISMATCH', o.QuestID, o.ObjectID,
       LEFT(CONCAT('goober ', o.ObjectID, ' Data1=', gt.Data1, ' != quete ', o.QuestID, ' -> Use() break avant credit'),255)
FROM quest_objectives o
JOIN gameobject_template gt ON gt.entry=o.ObjectID AND gt.type=10
LEFT JOIN _qinst qi ON qi.quest=o.QuestID
WHERE o.Type=2 AND o.QuestID NOT IN (SELECT quest FROM _qdisabled)
  AND gt.Data1<>0 AND gt.Data1<>o.QuestID;

-- R9 CHEST_EMPTY_LOOT (sev2) : coffre OBJECTIF de quete, SANS gameobject_questitem, au loot vide (cas lames SM, WotLK)
--   ⚠️ CALIBRE 23/06 : en Legion l'objet de quete est souvent credite a l'ouverture via gameobject_questitem
--   (butin personnel) -> loot_template vide = NORMAL, pas un bug. On EXCLUT donc les coffres a questitem
--   (sinon 100% faux-positifs, ex: 25 coffres 237xxx INST). Reste seulement le vrai cas "doit looter mais loot vide".
INSERT INTO _qfind
SELECT 2, IF(g.on_inst=1,'INST','WORLD'), 'CHEST_EMPTY_LOOT', NULL, gt.entry,
       LEFT(CONCAT('coffre ', gt.entry, ' Data1(lootId)=', gt.Data1,
              IF(gt.Data1=0,' (aucun loot)',' (gameobject_loot_template vide)')),255)
FROM gameobject_template gt
JOIN _go g ON g.entry=gt.entry
WHERE gt.type=3
  AND EXISTS     (SELECT 1 FROM quest_objectives o    WHERE o.Type=2 AND o.ObjectID=gt.entry)
  AND NOT EXISTS (SELECT 1 FROM gameobject_questitem q WHERE q.GameObjectEntry=gt.entry)
  AND ( gt.Data1=0 OR NOT EXISTS (SELECT 1 FROM gameobject_loot_template lt WHERE lt.Entry=gt.Data1) );

-- R10 SMARTAI_NOT_WIRED_CRE (sev2) : smart_scripts presents mais AIName != 'SmartAI' -> script mort
INSERT INTO _qfind
SELECT 2, IF(EXISTS(SELECT 1 FROM _cre x WHERE x.entry=ss.entryorguid AND x.on_inst=1),'INST','WORLD'),
       'SMARTAI_NOT_WIRED_CRE', NULL, ss.entryorguid,
       LEFT(CONCAT('creature ', ss.entryorguid, ' a ', COUNT(*), ' smart_scripts mais AIName="', COALESCE(t.AIName,''), '"'),255)
FROM smart_scripts ss
JOIN creature_template t ON t.entry=ss.entryorguid
WHERE ss.source_type=0 AND ss.entryorguid>0 AND COALESCE(t.AIName,'')<>'SmartAI'
GROUP BY ss.entryorguid, t.AIName;

-- R11 SMARTAI_NOT_WIRED_GO (sev2) : idem objets de jeu (AIName != 'SmartGameObjectAI')
INSERT INTO _qfind
SELECT 2, IF(EXISTS(SELECT 1 FROM _go x WHERE x.entry=ss.entryorguid AND x.on_inst=1),'INST','WORLD'),
       'SMARTAI_NOT_WIRED_GO', NULL, ss.entryorguid,
       LEFT(CONCAT('gameobject ', ss.entryorguid, ' a ', COUNT(*), ' smart_scripts mais AIName="', COALESCE(gt.AIName,''), '"'),255)
FROM smart_scripts ss
JOIN gameobject_template gt ON gt.entry=ss.entryorguid
WHERE ss.source_type=1 AND ss.entryorguid>0 AND COALESCE(gt.AIName,'')<>'SmartGameObjectAI'
GROUP BY ss.entryorguid, gt.AIName;

-- =====================================================================
--  RAPPORTS
-- =====================================================================
SELECT '===== RESUME PAR REGLE =====' AS '';
SELECT scope, severity AS sev, rule, COUNT(*) AS n
FROM _qfind GROUP BY scope, severity, rule
ORDER BY scope DESC, severity, n DESC;

SELECT '===== TOTAL PAR PERIMETRE =====' AS '';
SELECT scope, COUNT(*) AS anomalies, COUNT(DISTINCT quest_id) AS quetes_distinctes
FROM _qfind GROUP BY scope;

SELECT '===== DETAIL DONJON/RAID (INST) — backlog prioritaire =====' AS '';
SELECT severity AS sev, rule, quest_id, object_id, detail
FROM _qfind WHERE scope='INST'
ORDER BY severity, rule, quest_id;

-- LIVE & CASSE : findings sur des quetes qu'un joueur peut REELLEMENT obtenir = vrais pieges a corriger en priorite.
SELECT '===== LIVE & CASSE (donneur jouable) — backlog VRAIMENT actionnable =====' AS '';
SELECT f.severity AS sev, f.scope, f.rule, f.quest_id, f.object_id, f.detail
FROM _qfind f JOIN _qlive l ON l.quest=f.quest_id
ORDER BY f.scope DESC, f.severity, f.rule, f.quest_id;

SELECT '===== LIVE & CASSE : compte par regle/perimetre =====' AS '';
SELECT f.scope, f.severity AS sev, f.rule, COUNT(*) AS n
FROM _qfind f JOIN _qlive l ON l.quest=f.quest_id
GROUP BY f.scope, f.severity, f.rule
ORDER BY f.scope DESC, f.severity, n DESC;
