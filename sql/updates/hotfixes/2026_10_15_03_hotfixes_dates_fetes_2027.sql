-- Dates officielles des fetes (Holidays.db2 du jeu actuel, export wago.tools) : nos listes s arretaient en fevrier 2026
-- (Fete lunaire, De l amour dans l air) et en avril 2027 (Foire de Sombrelune). GameEventMgr prend la premiere date
-- non passee : la liste reste triee, les plus anciennes sortent.
-- Fete lunaire (327) : 2007 a 2027 (le 02/02/2027 a 10 h).
UPDATE `holidays` SET `Date1` = 118749568, `Date2` = 135346560, `Date3` = 151386496, `Date4` = 169048448, `Date5` = 184924160,
  `Date6` = 201684992, `Date7` = 218544128, `Date8` = 235207296, `Date9` = 252967552, `Date10` = 269499008, `Date11` = 285555328,
  `Date12` = 386267776, `Date13` = 403749504, `Date14` = 419887744, `Date15` = 437516928, `Date16` = 454064768 WHERE `ID` = 327;
-- De l amour dans l air (423) : le 08/02/2027 a 10 h.
UPDATE `holidays` SET `Date14` = 454163072 WHERE `ID` = 423 AND `Date14` = 0;
-- Foire de Sombrelune (479) : de septembre 2026 a decembre 2027.
UPDATE `holidays` SET `Date1` = 444659712, `Date2` = 445675520, `Date3` = 446134272, `Date4` = 447805440, `Date5` = 452999168,
  `Date6` = 454113280, `Date7` = 455161856, `Date8` = 456161280, `Date9` = 456620032, `Date10` = 458291200, `Date11` = 459307008,
  `Date12` = 459765760, `Date13` = 461420544, `Date14` = 462436352, `Date15` = 463550464, `Date16` = 464566272 WHERE `ID` = 479;
-- Bienfaits du Pelerin (404) 2028 : le lundi 20/11 selon les donnees officielles (corrige le 19/11 pose le 14/10).
UPDATE `holidays` SET `Date12` = 480574080 WHERE `ID` = 404 AND `Date12` = 480557696;
