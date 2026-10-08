-- (base dc_characters) Les expeditions deja actives des categories sans recompense ont ete tirees avec rewardid 0 :
-- on leur attribue une option au hasard parmi celles de leur categorie (2026_10_08_expeditions_recompenses.sql).
-- Sauvegarde : ~/tmp/sauvegardes/characters_world_quest_2026-10-08.sql (rollback = recharger ce fichier).
UPDATE world_quest a
JOIN dc_world.quest_template q ON q.ID = a.id
SET a.rewardid = (SELECT r.id FROM dc_world.world_quest_reward r WHERE r.questType = q.QuestInfoID GROUP BY r.id ORDER BY RAND() LIMIT 1)
WHERE a.rewardid = 0 AND q.QuestInfoID IN (116, 117, 121, 122, 123, 126, 136, 139, 142);
