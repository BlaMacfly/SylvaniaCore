-- =====================================================================
-- « Le destin de la Horde » (40522) — Sylvanas rapprochée d'Eitrigg
-- =====================================================================
--
-- DÉCISION DE L'UTILISATEUR, prise en jeu : Dame Sylvanas se tenait trop
-- loin du reste de la chaîne. Il l'a déplacée par `.npc move` de
-- (1251,0 ; −4376,0) à (1345,6 ; −4397,8), soit à une dizaine de mètres
-- d'Eitrigg qui donne la quête.
--
-- Pour mémoire, sa position d'origine était JUSTE : l'épingle Wowhead
-- (45,6 ; 15,8), convertie en coordonnées monde par calibration sur
-- l'aubergiste Grosk et maître Gadrin, retombe à 5,6 mètres de l'ancienne
-- ligne — dans le bruit de mesure. Le déplacement est un choix de confort
-- assumé, pas une correction.
--
-- CE QUI DEVAIT SUIVRE. Les deux derniers objectifs ne sont PAS crédités
-- par Sylvanas : ce sont deux créatures invisibles, 100934 et 100985, qui
-- les donnent à vue dans un rayon de dix mètres. Restées sur place, elles
-- se retrouvaient à 98 mètres d'elle — le joueur l'aurait donc rejointe
-- sans que rien ne se valide. On les déplace avec elle, en conservant
-- exactement l'écart d'origine : deux mètres au sud, quatre à l'ouest.
--
-- Altitudes relevées sur le terrain : 28,77 sous Sylvanas, 28,30 sous les
-- marqueurs.
--
-- ENFIN les points d'intérêt, que le serveur envoie au client : laissés
-- en place, la flèche du journal aurait pointé quatre cents mètres à côté.
-- On les recale sur la nouvelle position.
-- =====================================================================

UPDATE `creature` SET `position_x` = 1345.590, `position_y` = -4397.810,
                      `position_z` = 28.770, `orientation` = 1.4412
 WHERE `guid` = 290000102;

UPDATE `creature` SET `position_x` = 1343.590, `position_y` = -4401.810,
                      `position_z` = 28.300
 WHERE `guid` IN (290000113, 290000114);

UPDATE `quest_poi_points` p
  JOIN `quest_poi` q ON q.`QuestID` = p.`QuestID` AND q.`Idx1` = p.`Idx1`
   SET p.`X` = 1345, p.`Y` = -4398
 WHERE p.`QuestID` = 40522 AND q.`ObjectiveIndex` IN (-1, 3);
