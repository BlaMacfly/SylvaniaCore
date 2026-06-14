-- ============================================================================
-- Quête 42782 « To Be Prepared » (client FR « Fin Prêts ») — intro « Bataille
--   pour la Rive Brisée », port de Hurlevent (Alliance). 2026-06-14.
-- ----------------------------------------------------------------------------
-- PROBLÈME (diagnostic confirmé sur la base world du VPS) :
--   Le donneur Recruiter Lee (107934) EST spawné, mais TOUT le reste de la
--   préparation manque (intro NPE incomplète, héritée de TrinityCore) :
--     - les 4 objectifs (Type 0 = crédit créature) n'ont aucun support en jeu ;
--     - le rendeur Knight Dameron (108916) n'est pas spawné ;
--     - le PNJ de duel Ramall Trueoak (108722) n'est pas spawné ;
--     - les 3 crédits armure/arme/repas (108787/108788/108789) sont des
--       triggers INVISIBLES (modelid 44820) : sur retail le joueur clique un
--       GameObject à chaque station, qui crédite l'objectif.
--   La minimap affiche quand même les POI car ils viennent du DB2 client
--   (quest_poi_points), indépendamment des spawns serveur.
--
-- SOLUTION (données réelles) :
--   Coordonnées = quest_poi_points de 42782 (= ce que dessine ta minimap).
--   Modèles = modelid1 réels (ce core lit modelid1 ; creature_template_model
--     est vide). Mécanique de crédit = pattern bannières Mardum DÉJÀ VALIDÉ
--     (GO type 10 goober + SmartGameObjectAI + event 64 -> KILLCREDIT cible 7).
--   On NE touche PAS aux templates partagés (Weapon Rack/Rations/Crate sont
--     spawnés 17/44/9x ailleurs) : on crée 3 templates dédiés (600001-600003).
--
--   Stations (map 0, bas des quais, z≈5.6-5.8 confirmé par GO décor voisins) :
--     Armure  108787  ->  GO 600001  @ (-8494, 1206, 5.6)
--     Arme    108788  ->  GO 600002  @ (-8392, 1200, 5.8)
--     Repas   108789  ->  GO 600003  @ (-8340, 1207, 5.7)
--   Duel      108722  Ramall Trueoak @ (-8390, 1140, 18.0)  [Z À VÉRIFIER*]
--   Rendu     108916  Knight Dameron @ (-8495, 1079, 17.95) (à côté de Lee)
--
--   * Le Z du duel est le SEUL point incertain (aucun spawn voisin pour le
--     déduire ; la zone est entre quai bas z5.8 et plateforme z25). Après
--     application, vérifier en jeu : se placer sur Ramall, `.gps`, puis si
--     besoin : UPDATE creature SET position_z=<z .gps> WHERE guid=280000201;
--
-- APPLICATION : exécuter ce fichier sur la base `world`, puis REDÉMARRER le
--   worldserver (tmux) — un nouveau gameobject_template ne se charge qu'au
--   (re)spawn / boot, comme noté pour les bannières.
-- ============================================================================

-- ---------------------------------------------------------------------------
-- 1) Templates de GameObject dédiés (type 10 = goober cliquable)
--    Displays repris des vrais objets de la quête (armure/arme/festin).
-- ---------------------------------------------------------------------------
DELETE FROM gameobject_template WHERE entry IN (600001,600002,600003);
INSERT INTO gameobject_template (entry,type,displayId,name,size,AIName,ScriptName) VALUES
 (600001,10,26997,'Crate of Mail Armor [Q42782 armure]',1,'SmartGameObjectAI',''),
 (600002,10,29526,'Weapon Rack [Q42782 arme]',1,'SmartGameObjectAI',''),
 (600003,10,22665,'Hearty Feast [Q42782 repas]',1,'SmartGameObjectAI','');

-- ---------------------------------------------------------------------------
-- 2) Spawns des 3 stations (GameObject) aux coords POI réelles
-- ---------------------------------------------------------------------------
DELETE FROM gameobject WHERE guid IN (210200001,210200002,210200003);
INSERT INTO gameobject
 (guid,id,map,zoneId,areaId,spawnDifficulties,position_x,position_y,position_z,orientation,
  rotation0,rotation1,rotation2,rotation3,spawntimesecs,animprogress,state) VALUES
 (210200001,600001,0,1519,4411,'0', -8494, 1206, 5.6, 0, 0,0,0,1, 300,255,1),
 (210200002,600002,0,1519,4411,'0', -8392, 1200, 5.8, 0, 0,0,0,1, 300,255,1),
 (210200003,600003,0,1519,4411,'0', -8340, 1207, 5.7, 0, 0,0,0,1, 300,255,1);

-- ---------------------------------------------------------------------------
-- 3) Crédit à l'usage (SmartGameObjectAI) : clic -> KILLCREDIT vers l'invocateur
--    event 64 = GOSSIP_HELLO (clic), action 33 = KILLCREDIT, target 7 = INVOKER
-- ---------------------------------------------------------------------------
DELETE FROM smart_scripts WHERE source_type=1 AND entryorguid IN (600001,600002,600003);
INSERT INTO smart_scripts
 (entryorguid,source_type,id,link,event_type,event_phase_mask,event_chance,event_flags,
  event_param1,event_param2,event_param3,event_param4,
  action_type,action_param1,action_param2,action_param3,action_param4,action_param5,action_param6,
  target_type,target_param1,target_param2,target_param3,target_x,target_y,target_z,target_o,comment) VALUES
 (600001,1,0,0, 64,0,100,0, 0,0,0,0, 33,108787,0,0,0,0,0, 7,0,0,0, 0,0,0,0, 'Q42782: credit Armure polie (108787)'),
 (600002,1,0,0, 64,0,100,0, 0,0,0,0, 33,108788,0,0,0,0,0, 7,0,0,0, 0,0,0,0, 'Q42782: credit Arme renforcee (108788)'),
 (600003,1,0,0, 64,0,100,0, 0,0,0,0, 33,108789,0,0,0,0,0, 7,0,0,0, 0,0,0,0, 'Q42782: credit Dernier repas (108789)');

-- ---------------------------------------------------------------------------
-- 4) Ramall Trueoak (duel) : rendre cliquable (gossip) + crédit via SmartAI
-- ---------------------------------------------------------------------------
UPDATE creature_template SET npcflag = npcflag | 1, AIName='SmartAI' WHERE entry=108722;

DELETE FROM creature WHERE guid=280000201;
INSERT INTO creature
 (guid,id,map,zoneId,areaId,spawnDifficulties,position_x,position_y,position_z,orientation,
  spawntimesecs,MovementType) VALUES
 (280000201,108722,0,1519,4411,'0', -8390, 1140, 18.0, 3.0, 300,0);

DELETE FROM smart_scripts WHERE source_type=0 AND entryorguid=108722;
INSERT INTO smart_scripts
 (entryorguid,source_type,id,link,event_type,event_phase_mask,event_chance,event_flags,
  event_param1,event_param2,event_param3,event_param4,
  action_type,action_param1,action_param2,action_param3,action_param4,action_param5,action_param6,
  target_type,target_param1,target_param2,target_param3,target_x,target_y,target_z,target_o,comment) VALUES
 (108722,0,0,0, 64,0,100,0, 0,0,0,0, 33,108722,0,0,0,0,0, 7,0,0,0, 0,0,0,0, 'Q42782: credit Duel (Ramall 108722)');

-- ---------------------------------------------------------------------------
-- 5) Knight Dameron (rendeur) : déjà npcflag=2 + dans creature_questender(42782)
--    -> il suffit de le spawner à côté de Recruiter Lee.
-- ---------------------------------------------------------------------------
DELETE FROM creature WHERE guid=280000202;
INSERT INTO creature
 (guid,id,map,zoneId,areaId,spawnDifficulties,position_x,position_y,position_z,orientation,
  spawntimesecs,MovementType) VALUES
 (280000202,108916,0,1519,4411,'0', -8495, 1079, 17.95, 1.5, 300,0);
