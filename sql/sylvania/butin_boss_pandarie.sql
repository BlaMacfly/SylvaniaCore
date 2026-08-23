-- =====================================================================
-- Donjons de Pandarie — les boss ne lâchaient RIEN
--
-- Signalé sur Discord par « le baltring » le 23/08/2026 : « il y a
-- beaucoup d'instances où les boss ne lootent rien, ni les mobs de
-- l'instance ». Vérifié le 24/08 et confirmé : les 18 boss des donjons
-- de Pandarie avaient tous `lootid = 0`. Aucun butin, nulle part.
--
-- Ce n'est pas propre à la Pandarie — 54 des 93 boss d'instance du
-- serveur sont dans ce cas — mais ces donjons-là sont à zéro absolu.
--
-- SOURCE DES DONNÉES
-- Tables de butin officielles relevées sur les pages PNJ de Wowhead.
-- Ces tables sont rendues en JavaScript : ni `curl` (403) ni un export
-- de page ne les voient, il faut passer par un navigateur. Les taux sont
-- ceux de Wowhead, calculés sur ses relevés (`count / outof`).
--
-- CE QUI A ÉTÉ ÉCARTÉ, ET POURQUOI
-- Wowhead agrège les relevés de TOUTES les époques, y compris le
-- Marche-temps (ces donjons se refont au niveau 110 en Legion) et le
-- Legion Remix de 2025. Trois familles d'objets ont donc été retirées :
--   * identifiants >= 210000 — Legion Remix, postérieurs à notre client
--   * 187904 et 21xxxx — mêmes raisons
--   * 141689, 143xxx, 144xxx, 143776 — récompenses de Marche-temps,
--     obtenues à 110 en Legion. Elles existent bien dans un client
--     7.3.5, mais les faire tomber pour un groupe de niveau 90 en donjon
--     normal n'aurait aucun sens.
-- Seule la plage authentique Mists of Pandaria est conservée : 71xxx,
-- 80xxx, 81xxx, 85xxx, 87xxx et 100xxx. 67 objets écartés au total.
--
-- CONVENTION : `lootid` prend la valeur de l'entrée de la créature.
--
-- ⚠️ QUATRE BOSS RESTENT SANS BUTIN, faute de donnée exploitable :
--   56843 Pisteur du savoir Marchepierre
--   61442 Kuai la Brute, 61444 Ming le Malin, 61445 Haiyan l'Inarrêtable
-- Wowhead ne leur attribue que des objets de Marche-temps. Pour les
-- trois derniers c'est cohérent : ils forment le conseil de « L'épreuve
-- du roi » au Palais Mogu'shan, dont le butin est porté par Gekkan.
-- Marchepierre reste à élucider.
--
-- Rechargeable à chaud : reload creature_loot_template. Le changement de
-- `lootid` exige en revanche un redémarrage (il est lu dans le modèle).
-- =====================================================================

UPDATE `creature_template` SET `lootid`=`entry` WHERE `entry` IN (56541,56719,56747,56884,56448,56732,56589,56636,56877,56906,61243,61398,61567,61634);

DELETE FROM `creature_loot_template` WHERE `Entry` IN (56541,56719,56747,56884,56448,56732,56589,56636,56877,56906,61243,61398,61567,61634);
INSERT INTO `creature_loot_template` (`Entry`,`Item`,`Reference`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(56541,80912,0,27.56,0,1,0,1,1,'Maitre Neigederive - Monastere Shado-Pan'),
(56541,80937,0,27.13,0,1,0,1,1,'Maitre Neigederive - Monastere Shado-Pan'),
(56541,80911,0,25.68,0,1,0,1,1,'Maitre Neigederive - Monastere Shado-Pan'),
(56541,81181,0,17.39,0,1,0,1,1,'Maitre Neigederive - Monastere Shado-Pan'),
(56541,81101,0,17.18,0,1,0,1,1,'Maitre Neigederive - Monastere Shado-Pan'),
(56541,81108,0,16.83,0,1,0,1,1,'Maitre Neigederive - Monastere Shado-Pan'),
(56541,81087,0,16.75,0,1,0,1,1,'Maitre Neigederive - Monastere Shado-Pan'),
(56541,81182,0,16.64,0,1,0,1,1,'Maitre Neigederive - Monastere Shado-Pan'),
(56719,80915,0,20.70,0,1,0,1,1,'Sha de la violence - Monastere Shado-Pan'),
(56719,80883,0,20.45,0,1,0,1,1,'Sha de la violence - Monastere Shado-Pan'),
(56719,80913,0,20.23,0,1,0,1,1,'Sha de la violence - Monastere Shado-Pan'),
(56719,81184,0,13.11,0,1,0,1,1,'Sha de la violence - Monastere Shado-Pan'),
(56719,81185,0,12.80,0,1,0,1,1,'Sha de la violence - Monastere Shado-Pan'),
(56719,81113,0,12.80,0,1,0,1,1,'Sha de la violence - Monastere Shado-Pan'),
(56719,81089,0,12.74,0,1,0,1,1,'Sha de la violence - Monastere Shado-Pan'),
(56719,81102,0,12.52,0,1,0,1,1,'Sha de la violence - Monastere Shado-Pan'),
(56747,80909,0,20.00,0,1,0,1,1,'Gu Frappenuage - Monastere Shado-Pan'),
(56747,80910,0,19.60,0,1,0,1,1,'Gu Frappenuage - Monastere Shado-Pan'),
(56747,80908,0,19.48,0,1,0,1,1,'Gu Frappenuage - Monastere Shado-Pan'),
(56747,81092,0,12.24,0,1,0,1,1,'Gu Frappenuage - Monastere Shado-Pan'),
(56747,81110,0,11.99,0,1,0,1,1,'Gu Frappenuage - Monastere Shado-Pan'),
(56747,81086,0,11.90,0,1,0,1,1,'Gu Frappenuage - Monastere Shado-Pan'),
(56747,81180,0,11.80,0,1,0,1,1,'Gu Frappenuage - Monastere Shado-Pan'),
(56747,81179,0,11.76,0,1,0,1,1,'Gu Frappenuage - Monastere Shado-Pan'),
(56884,80936,0,15.78,0,1,0,1,1,'Taran Zhu - Monastere Shado-Pan'),
(56884,80935,0,15.28,0,1,0,1,1,'Taran Zhu - Monastere Shado-Pan'),
(56884,80917,0,15.16,0,1,0,1,1,'Taran Zhu - Monastere Shado-Pan'),
(56884,80918,0,15.09,0,1,0,1,1,'Taran Zhu - Monastere Shado-Pan'),
(56884,80916,0,14.67,0,1,0,1,1,'Taran Zhu - Monastere Shado-Pan'),
(56884,80919,0,14.63,0,1,0,1,1,'Taran Zhu - Monastere Shado-Pan'),
(56884,81187,0,8.39,0,1,0,1,1,'Taran Zhu - Monastere Shado-Pan'),
(56884,81189,0,8.32,0,1,0,1,1,'Taran Zhu - Monastere Shado-Pan'),
(56884,81099,0,8.24,0,1,0,1,1,'Taran Zhu - Monastere Shado-Pan'),
(56884,81096,0,8.21,0,1,0,1,1,'Taran Zhu - Monastere Shado-Pan'),
(56884,81107,0,8.20,0,1,0,1,1,'Taran Zhu - Monastere Shado-Pan'),
(56884,81093,0,8.01,0,1,0,1,1,'Taran Zhu - Monastere Shado-Pan'),
(56884,81114,0,7.97,0,1,0,1,1,'Taran Zhu - Monastere Shado-Pan'),
(56884,81188,0,7.95,0,1,0,1,1,'Taran Zhu - Monastere Shado-Pan'),
(56884,81103,0,7.91,0,1,0,1,1,'Taran Zhu - Monastere Shado-Pan'),
(56884,81186,0,7.90,0,1,0,1,1,'Taran Zhu - Monastere Shado-Pan'),
(56448,80861,0,18.38,0,1,0,1,1,'Sagesse de Mari - Temple du Serpent de jade'),
(56448,80860,0,18.23,0,1,0,1,1,'Sagesse de Mari - Temple du Serpent de jade'),
(56448,80862,0,18.18,0,1,0,1,1,'Sagesse de Mari - Temple du Serpent de jade'),
(56448,81124,0,9.71,0,1,0,1,1,'Sagesse de Mari - Temple du Serpent de jade'),
(56448,81075,0,9.53,0,1,0,1,1,'Sagesse de Mari - Temple du Serpent de jade'),
(56448,81083,0,9.51,0,1,0,1,1,'Sagesse de Mari - Temple du Serpent de jade'),
(56448,81123,0,9.43,0,1,0,1,1,'Sagesse de Mari - Temple du Serpent de jade'),
(56448,81072,0,9.35,0,1,0,1,1,'Sagesse de Mari - Temple du Serpent de jade'),
(56732,80867,0,18.44,0,1,0,1,1,'Liu Coeurdeflamme - Temple du Serpent de jade'),
(56732,80866,0,18.10,0,1,0,1,1,'Liu Coeurdeflamme - Temple du Serpent de jade'),
(56732,80872,0,17.93,0,1,0,1,1,'Liu Coeurdeflamme - Temple du Serpent de jade'),
(56732,81084,0,9.78,0,1,0,1,1,'Liu Coeurdeflamme - Temple du Serpent de jade'),
(56732,81127,0,9.75,0,1,0,1,1,'Liu Coeurdeflamme - Temple du Serpent de jade'),
(56732,81067,0,9.73,0,1,0,1,1,'Liu Coeurdeflamme - Temple du Serpent de jade'),
(56732,81070,0,9.45,0,1,0,1,1,'Liu Coeurdeflamme - Temple du Serpent de jade'),
(56732,81128,0,9.37,0,1,0,1,1,'Liu Coeurdeflamme - Temple du Serpent de jade'),
(56589,81192,0,14.18,0,1,0,1,1,'Frappeur Ga''dok - Porte du Couchant'),
(56589,81111,0,14.00,0,1,0,1,1,'Frappeur Ga''dok - Porte du Couchant'),
(56589,81085,0,13.60,0,1,0,1,1,'Frappeur Ga''dok - Porte du Couchant'),
(56589,81098,0,13.48,0,1,0,1,1,'Frappeur Ga''dok - Porte du Couchant'),
(56589,81229,0,13.46,0,1,0,1,1,'Frappeur Ga''dok - Porte du Couchant'),
(56589,80923,0,12.67,0,1,0,1,1,'Frappeur Ga''dok - Porte du Couchant'),
(56589,80924,0,12.55,0,1,0,1,1,'Frappeur Ga''dok - Porte du Couchant'),
(56589,80922,0,12.51,0,1,0,1,1,'Frappeur Ga''dok - Porte du Couchant'),
(56636,81232,0,14.55,0,1,0,1,1,'Commandant Ri''mok - Porte du Couchant'),
(56636,81105,0,14.18,0,1,0,1,1,'Commandant Ri''mok - Porte du Couchant'),
(56636,81106,0,14.17,0,1,0,1,1,'Commandant Ri''mok - Porte du Couchant'),
(56636,80925,0,13.97,0,1,0,1,1,'Commandant Ri''mok - Porte du Couchant'),
(56636,81088,0,13.91,0,1,0,1,1,'Commandant Ri''mok - Porte du Couchant'),
(56636,81230,0,13.86,0,1,0,1,1,'Commandant Ri''mok - Porte du Couchant'),
(56636,80926,0,13.24,0,1,0,1,1,'Commandant Ri''mok - Porte du Couchant'),
(56636,80933,0,12.30,0,1,0,1,1,'Commandant Ri''mok - Porte du Couchant'),
(56636,71715,0,5.46,0,1,0,1,1,'Commandant Ri''mok - Porte du Couchant'),
(56877,80930,0,17.82,0,1,0,1,1,'Raigonn - Porte du Couchant'),
(56877,80928,0,17.44,0,1,0,1,1,'Raigonn - Porte du Couchant'),
(56877,80932,0,16.89,0,1,0,1,1,'Raigonn - Porte du Couchant'),
(56877,80927,0,16.24,0,1,0,1,1,'Raigonn - Porte du Couchant'),
(56877,81094,0,15.90,0,1,0,1,1,'Raigonn - Porte du Couchant'),
(56877,81234,0,15.83,0,1,0,1,1,'Raigonn - Porte du Couchant'),
(56877,80929,0,15.72,0,1,0,1,1,'Raigonn - Porte du Couchant'),
(56877,81233,0,15.70,0,1,0,1,1,'Raigonn - Porte du Couchant'),
(56877,81100,0,15.51,0,1,0,1,1,'Raigonn - Porte du Couchant'),
(56877,81097,0,15.50,0,1,0,1,1,'Raigonn - Porte du Couchant'),
(56877,81109,0,15.45,0,1,0,1,1,'Raigonn - Porte du Couchant'),
(56877,81236,0,15.40,0,1,0,1,1,'Raigonn - Porte du Couchant'),
(56877,81112,0,15.28,0,1,0,1,1,'Raigonn - Porte du Couchant'),
(56877,81235,0,15.23,0,1,0,1,1,'Raigonn - Porte du Couchant'),
(56877,81091,0,15.22,0,1,0,1,1,'Raigonn - Porte du Couchant'),
(56877,80931,0,15.17,0,1,0,1,1,'Raigonn - Porte du Couchant'),
(56877,87546,0,0.39,0,1,0,1,1,'Raigonn - Porte du Couchant'),
(56906,81095,0,13.93,0,1,0,1,1,'Saboteur Kip''tilak - Porte du Couchant'),
(56906,81190,0,13.64,0,1,0,1,1,'Saboteur Kip''tilak - Porte du Couchant'),
(56906,81191,0,13.31,0,1,0,1,1,'Saboteur Kip''tilak - Porte du Couchant'),
(56906,80920,0,13.30,0,1,0,1,1,'Saboteur Kip''tilak - Porte du Couchant'),
(56906,81104,0,13.08,0,1,0,1,1,'Saboteur Kip''tilak - Porte du Couchant'),
(56906,81090,0,12.99,0,1,0,1,1,'Saboteur Kip''tilak - Porte du Couchant'),
(56906,80934,0,12.07,0,1,0,1,1,'Saboteur Kip''tilak - Porte du Couchant'),
(56906,80921,0,12.01,0,1,0,1,1,'Saboteur Kip''tilak - Porte du Couchant'),
(61243,81245,0,17.99,0,1,0,1,1,'Gekkan - Palais Mogu''shan'),
(61243,81246,0,17.36,0,1,0,1,1,'Gekkan - Palais Mogu''shan'),
(61243,81243,0,17.29,0,1,0,1,1,'Gekkan - Palais Mogu''shan'),
(61243,81242,0,17.22,0,1,0,1,1,'Gekkan - Palais Mogu''shan'),
(61243,81244,0,17.10,0,1,0,1,1,'Gekkan - Palais Mogu''shan'),
(61243,85181,0,16.68,0,1,0,1,1,'Gekkan - Palais Mogu''shan'),
(61243,85183,0,16.47,0,1,0,1,1,'Gekkan - Palais Mogu''shan'),
(61243,85180,0,16.12,0,1,0,1,1,'Gekkan - Palais Mogu''shan'),
(61243,85182,0,15.92,0,1,0,1,1,'Gekkan - Palais Mogu''shan'),
(61243,85184,0,15.22,0,1,0,1,1,'Gekkan - Palais Mogu''shan'),
(61398,81254,0,14.33,0,1,0,1,1,'Xin le Maitrearme - Palais Mogu''shan'),
(61398,81248,0,13.83,0,1,0,1,1,'Xin le Maitrearme - Palais Mogu''shan'),
(61398,81252,0,13.51,0,1,0,1,1,'Xin le Maitrearme - Palais Mogu''shan'),
(61398,81251,0,13.26,0,1,0,1,1,'Xin le Maitrearme - Palais Mogu''shan'),
(61398,81249,0,13.21,0,1,0,1,1,'Xin le Maitrearme - Palais Mogu''shan'),
(61398,81253,0,13.17,0,1,0,1,1,'Xin le Maitrearme - Palais Mogu''shan'),
(61398,81257,0,13.16,0,1,0,1,1,'Xin le Maitrearme - Palais Mogu''shan'),
(61398,81255,0,13.10,0,1,0,1,1,'Xin le Maitrearme - Palais Mogu''shan'),
(61398,85185,0,13.07,0,1,0,1,1,'Xin le Maitrearme - Palais Mogu''shan'),
(61398,85194,0,13.05,0,1,0,1,1,'Xin le Maitrearme - Palais Mogu''shan'),
(61398,81247,0,13.04,0,1,0,1,1,'Xin le Maitrearme - Palais Mogu''shan'),
(61398,85187,0,12.92,0,1,0,1,1,'Xin le Maitrearme - Palais Mogu''shan'),
(61398,81256,0,12.89,0,1,0,1,1,'Xin le Maitrearme - Palais Mogu''shan'),
(61398,85186,0,12.76,0,1,0,1,1,'Xin le Maitrearme - Palais Mogu''shan'),
(61398,85193,0,12.71,0,1,0,1,1,'Xin le Maitrearme - Palais Mogu''shan'),
(61398,85190,0,12.51,0,1,0,1,1,'Xin le Maitrearme - Palais Mogu''shan'),
(61398,85192,0,12.45,0,1,0,1,1,'Xin le Maitrearme - Palais Mogu''shan'),
(61398,85191,0,12.44,0,1,0,1,1,'Xin le Maitrearme - Palais Mogu''shan'),
(61398,85188,0,12.42,0,1,0,1,1,'Xin le Maitrearme - Palais Mogu''shan'),
(61398,85189,0,12.04,0,1,0,1,1,'Xin le Maitrearme - Palais Mogu''shan'),
(61398,71638,0,8.14,0,1,0,1,1,'Xin le Maitrearme - Palais Mogu''shan'),
(61398,71715,0,5.16,0,1,0,1,1,'Xin le Maitrearme - Palais Mogu''shan'),
(61398,87542,0,0.35,0,1,0,1,1,'Xin le Maitrearme - Palais Mogu''shan'),
(61567,81272,0,13.22,0,1,0,1,1,'Vizir Jin''bak - Siege du temple de Niuzao'),
(61567,81262,0,13.19,0,1,0,1,1,'Vizir Jin''bak - Siege du temple de Niuzao'),
(61567,81270,0,12.79,0,1,0,1,1,'Vizir Jin''bak - Siege du temple de Niuzao'),
(61567,81271,0,12.65,0,1,0,1,1,'Vizir Jin''bak - Siege du temple de Niuzao'),
(61567,81263,0,12.49,0,1,0,1,1,'Vizir Jin''bak - Siege du temple de Niuzao'),
(61567,100954,0,7.30,0,1,0,1,1,'Vizir Jin''bak - Siege du temple de Niuzao'),
(61567,100952,0,7.14,0,1,0,1,1,'Vizir Jin''bak - Siege du temple de Niuzao'),
(61567,100951,0,7.07,0,1,0,1,1,'Vizir Jin''bak - Siege du temple de Niuzao'),
(61567,100953,0,6.21,0,1,0,1,1,'Vizir Jin''bak - Siege du temple de Niuzao'),
(61567,100950,0,6.21,0,1,0,1,1,'Vizir Jin''bak - Siege du temple de Niuzao'),
(61634,81274,0,12.78,0,1,0,1,1,'Commandant Vo''jak - Siege du temple de Niuzao'),
(61634,81276,0,12.60,0,1,0,1,1,'Commandant Vo''jak - Siege du temple de Niuzao'),
(61634,81275,0,12.53,0,1,0,1,1,'Commandant Vo''jak - Siege du temple de Niuzao'),
(61634,81277,0,12.50,0,1,0,1,1,'Commandant Vo''jak - Siege du temple de Niuzao'),
(61634,81273,0,12.41,0,1,0,1,1,'Commandant Vo''jak - Siege du temple de Niuzao'),
(61634,100957,0,6.72,0,1,0,1,1,'Commandant Vo''jak - Siege du temple de Niuzao'),
(61634,100955,0,5.67,0,1,0,1,1,'Commandant Vo''jak - Siege du temple de Niuzao'),
(61634,100959,0,5.59,0,1,0,1,1,'Commandant Vo''jak - Siege du temple de Niuzao'),
(61634,100958,0,5.54,0,1,0,1,1,'Commandant Vo''jak - Siege du temple de Niuzao'),
(61634,100956,0,5.49,0,1,0,1,1,'Commandant Vo''jak - Siege du temple de Niuzao');
