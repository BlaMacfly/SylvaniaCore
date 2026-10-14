-- DB/Events: Marches du temps au rythme officiel (remplace la rotation hebdomadaire continue de 2026_10_14_00, qui ne l'etait pas).
-- Calendrier du client (Holidays.db2, dates 2016-2018) : chaque extension revient toutes les 14 semaines, une semaine, dans cet
-- ordre : WotLK, BC 3 semaines apres, Cataclysm 7 semaines apres, Pandarie 10 semaines apres ; entre deux, pas de Marches du temps
-- (le retail y placait d'autres evenements bonus). Cycle officiel prolonge depuis la derniere date du client (WotLK 13/11/2018),
-- au reset europeen du mercredi 6 h : Cataclysm cette semaine (14/10/2026), Pandarie le 04/11, WotLK le 02/12, BC le 23/12.
UPDATE `game_event` SET `start_time` = '2026-12-23 06:00:00', `occurence` = 141120, `length` = 10080 WHERE `eventEntry` = 100; -- Timewalker BC
UPDATE `game_event` SET `start_time` = '2026-12-02 06:00:00', `occurence` = 141120, `length` = 10080 WHERE `eventEntry` = 101; -- Timewalker WotLK
UPDATE `game_event` SET `start_time` = '2026-10-14 06:00:00', `occurence` = 141120, `length` = 10080 WHERE `eventEntry` = 102; -- Timewalker Cataclysm
UPDATE `game_event` SET `start_time` = '2026-11-04 06:00:00', `occurence` = 141120, `length` = 10080 WHERE `eventEntry` = 103; -- Timewalker MoP
