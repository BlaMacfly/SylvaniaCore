-- « Un piege a assassins » (42387, chasseur) : le piege (objet 137551 -> sort 189038 -> 189039) emet
-- l evenement 52363, qui doit faire apparaitre le capitaine Tevaris (109189) pour 10 min. Chez nous :
-- evenement absent (le piege ne faisait rien), Tevaris AMICAL (faction 35) et pose en permanence, donc
-- impossible a tuer (Blez, 04/10/2026). Repris de LegionCore : evenement, faction 14, pas d exemplaire fixe.
DELETE FROM event_scripts WHERE id=52363;
INSERT INTO event_scripts (id,delay,command,datalong,datalong2,dataint,x,y,z,o) VALUES (52363,0,10,109189,600000,0,2713.67,7433.72,5.31,3.4);
UPDATE creature_template SET faction=14, unit_flags=32768 WHERE entry=109189;
DELETE FROM creature WHERE guid=20544513 AND id=109189;
