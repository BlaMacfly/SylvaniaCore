-- Recompenses de donjon aleatoire : la fin du donjon n'etait jamais reconnue.
-- Base : dc_world. Rejouable. Signalement du 02/11/2026 (Wisstiti, mage Wissmerill niveau 51) :
-- « les recompenses de fin de donjon aleatoire ne marchent pas ».
-- LFGMgr::FinishDungeon n'est appele que si le boss tue est la rencontre marquee « derniere » du donjon
-- (instance_encounters.lastEncounterDungeon). Sur 130 donjons des tirages aleatoires, seuls 30 avaient
-- leur rencontre finale ; d'autres lignes portaient un identifiant de Guide (1492...) au lieu d'un
-- donjon et etaient rejetees au chargement.
-- Source : client 7.3.5. LFGDungeons.FinalEncounterID (= JournalEncounter) -> nom du boss ->
-- DungeonEncounter de la meme carte -> creature du meme nom posee sur cette carte. 107 donjons
-- retenus (normal et heroique partagent la rencontre ; le core accepte desormais la fin du donjon
-- pour toute difficulte de la carte). 23 ecartes (boss invoque par script, homonymes, donnees du
-- client incoherentes).

UPDATE `instance_encounters` SET `creditType` = 0, `creditEntry` = 9018, `lastEncounterDungeon` = 30 WHERE `entry` = 227; -- Blackrock Depths - Detention Block - High Interrogator Gerstahn
UPDATE `instance_encounters` SET `creditType` = 0, `creditEntry` = 9019, `lastEncounterDungeon` = 276 WHERE `entry` = 245; -- Blackrock Depths - Upper City - Emperor Dagran Thaurissan
UPDATE `instance_encounters` SET `creditType` = 0, `creditEntry` = 9568, `lastEncounterDungeon` = 32 WHERE `entry` = 275; -- Lower Blackrock Spire - Overlord Wyrmthalak
UPDATE `instance_encounters` SET `creditType` = 0, `creditEntry` = 11492, `lastEncounterDungeon` = 34 WHERE `entry` = 346; -- Dire Maul - Warpwood Quarter - Alzzin the Wildshaper
UPDATE `instance_encounters` SET `creditType` = 0, `creditEntry` = 11486, `lastEncounterDungeon` = 36 WHERE `entry` = 361; -- Dire Maul - Capital Gardens - Prince Tortheldrin
UPDATE `instance_encounters` SET `creditType` = 0, `creditEntry` = 11501, `lastEncounterDungeon` = 38 WHERE `entry` = 368; -- Dire Maul - Gordok Commons - King Gordok
UPDATE `instance_encounters` SET `creditType` = 0, `creditEntry` = 7800, `lastEncounterDungeon` = 14 WHERE `entry` = 382; -- Gnomeregan - Mekgineer Thermaplugg
UPDATE `instance_encounters` SET `creditType` = 0, `creditEntry` = 12258, `lastEncounterDungeon` = 26 WHERE `entry` = 423; -- Maraudon - Foulspore Cavern - Razorlash
UPDATE `instance_encounters` SET `creditType` = 0, `creditEntry` = 12236, `lastEncounterDungeon` = 272 WHERE `entry` = 424; -- Maraudon - The Wicked Grotto - Lord Vyletongue
UPDATE `instance_encounters` SET `creditType` = 0, `creditEntry` = 12201, `lastEncounterDungeon` = 273 WHERE `entry` = 429; -- Maraudon - Earth Song Falls - Princess Theradras
UPDATE `instance_encounters` SET `creditType` = 0, `creditEntry` = 10813, `lastEncounterDungeon` = 40 WHERE `entry` = 478; -- Stratholme - Main Gate - Balnazzar
UPDATE `instance_encounters` SET `creditType` = 0, `creditEntry` = 45412, `lastEncounterDungeon` = 274 WHERE `entry` = 484; -- Stratholme - Service Entrance - Lord Aurius Rivendare
UPDATE `instance_encounters` SET `creditType` = 0, `creditEntry` = 5709, `lastEncounterDungeon` = 28 WHERE `entry` = 493; -- Sunken Temple - Shade of Eranikus
UPDATE `instance_encounters` SET `creditType` = 0, `creditEntry` = 26723, `lastEncounterDungeon` = 225 WHERE `entry` = 526; -- The Nexus - Keristrasza
UPDATE `instance_encounters` SET `creditType` = 0, `creditEntry` = 27656, `lastEncounterDungeon` = 206 WHERE `entry` = 534; -- The Oculus - Ley-Guardian Eregos
UPDATE `instance_encounters` SET `creditType` = 0, `creditEntry` = 2748, `lastEncounterDungeon` = 22 WHERE `entry` = 554; -- Uldaman - Archaedas
UPDATE `instance_encounters` SET `creditType` = 0, `creditEntry` = 3654, `lastEncounterDungeon` = 1 WHERE `entry` = 592; -- Wailing Caverns - Mutanus the Devourer
UPDATE `instance_encounters` SET `creditType` = 0, `creditEntry` = 7267, `lastEncounterDungeon` = 24 WHERE `entry` = 600; -- ZulFarrak - Chief Ukorz Sandscalp
UPDATE `instance_encounters` SET `creditType` = 0, `creditEntry` = 39705, `lastEncounterDungeon` = 303 WHERE `entry` = 1036; -- Blackrock Caverns - Ascendant Lord Obsidius
UPDATE `instance_encounters` SET `creditType` = 0, `creditEntry` = 43875, `lastEncounterDungeon` = 311 WHERE `entry` = 1042; -- The Vortex Pinnacle - Asaad, Caliph of Zephyrs
UPDATE `instance_encounters` SET `creditType` = 0, `creditEntry` = 44566, `lastEncounterDungeon` = 302 WHERE `entry` = 1047; -- Throne of the Tides - Ozumat
UPDATE `instance_encounters` SET `creditType` = 0, `creditEntry` = 40484, `lastEncounterDungeon` = 304 WHERE `entry` = 1049; -- Grim Batol - Erudax
UPDATE `instance_encounters` SET `creditType` = 0, `creditEntry` = 44819, `lastEncounterDungeon` = 312 WHERE `entry` = 1055; -- Lost City of the Tolvir - Siamat
UPDATE `instance_encounters` SET `creditType` = 0, `creditEntry` = 42333, `lastEncounterDungeon` = 307 WHERE `entry` = 1057; -- The Stonecore - High Priestess Azil
UPDATE `instance_encounters` SET `creditType` = 0, `creditEntry` = 47739, `lastEncounterDungeon` = 6 WHERE `entry` = 1060; -- Deadmines - "Captain" Cookie
UPDATE `instance_encounters` SET `creditType` = 0, `creditEntry` = 46964, `lastEncounterDungeon` = 8 WHERE `entry` = 1072; -- Shadowfang Keep - Lord Godfrey
UPDATE `instance_encounters` SET `creditType` = 0, `creditEntry` = 39378, `lastEncounterDungeon` = 305 WHERE `entry` = 1078; -- Halls of Origination - Rajh
UPDATE `instance_encounters` SET `creditType` = 0, `creditEntry` = 46264, `lastEncounterDungeon` = 12 WHERE `entry` = 1144; -- Stormwind Stockade - Hogger
UPDATE `instance_encounters` SET `creditType` = 0, `creditEntry` = 52148, `lastEncounterDungeon` = 334 WHERE `entry` = 1182; -- ZulGurub - Jindo the Godbreaker
UPDATE `instance_encounters` SET `creditType` = 0, `creditEntry` = 23863, `lastEncounterDungeon` = 340 WHERE `entry` = 1194; -- ZulAman - Daakara
DELETE FROM `instance_encounters` WHERE `entry` = 1271;
INSERT INTO `instance_encounters` (`entry`,`creditType`,`creditEntry`,`lastEncounterDungeon`,`comment`) VALUES (1271,0,54432,435,'End Time - Murozond');
UPDATE `instance_encounters` SET `creditType` = 0, `creditEntry` = 54969, `lastEncounterDungeon` = 437 WHERE `entry` = 1274; -- Well of Eternity - Mannoroth
DELETE FROM `instance_encounters` WHERE `entry` = 1306;
INSERT INTO `instance_encounters` (`entry`,`creditType`,`creditEntry`,`lastEncounterDungeon`,`comment`) VALUES (1306,0,56884,466,'Shado-Pan Monastery - Taran Zhu');
UPDATE `instance_encounters` SET `creditType` = 0, `creditEntry` = 54938, `lastEncounterDungeon` = 439 WHERE `entry` = 1339; -- Hour of Twilight - Archbishop Benedictus
UPDATE `instance_encounters` SET `creditType` = 0, `creditEntry` = 59479, `lastEncounterDungeon` = 465 WHERE `entry` = 1414; -- Stormstout Brewery - Yan-Zhu the Uncasked
DELETE FROM `instance_encounters` WHERE `entry` = 1419;
INSERT INTO `instance_encounters` (`entry`,`creditType`,`creditEntry`,`lastEncounterDungeon`,`comment`) VALUES (1419,0,56877,631,'Gate of the Setting Sun - Raigonn');
DELETE FROM `instance_encounters` WHERE `entry` = 1420;
INSERT INTO `instance_encounters` (`entry`,`creditType`,`creditEntry`,`lastEncounterDungeon`,`comment`) VALUES (1420,0,59150,163,'Scarlet Halls - Flameweaver Koegler');
DELETE FROM `instance_encounters` WHERE `entry` = 1425;
INSERT INTO `instance_encounters` (`entry`,`creditType`,`creditEntry`,`lastEncounterDungeon`,`comment`) VALUES (1425,0,3977,164,'Scarlet Monastery - High Inquisitor Whitemane');
UPDATE `instance_encounters` SET `creditType` = 0, `creditEntry` = 59080, `lastEncounterDungeon` = 2 WHERE `entry` = 1430; -- Scholomance - Darkmaster Gandling
UPDATE `instance_encounters` SET `creditType` = 0, `creditEntry` = 56439, `lastEncounterDungeon` = 464 WHERE `entry` = 1439; -- Temple of the Jade Serpent - Sha of Doubt
DELETE FROM `instance_encounters` WHERE `entry` = 1446;
INSERT INTO `instance_encounters` (`entry`,`creditType`,`creditEntry`,`lastEncounterDungeon`,`comment`) VALUES (1446,0,61528,4,'Ragefire Chasm - Lava Guard Gordoth');
DELETE FROM `instance_encounters` WHERE `entry` = 1464;
INSERT INTO `instance_encounters` (`entry`,`creditType`,`creditEntry`,`lastEncounterDungeon`,`comment`) VALUES (1464,0,62205,630,'Siege of Niuzao Temple - Wing Leader Neronok');
DELETE FROM `instance_encounters` WHERE `entry` = 1654;
INSERT INTO `instance_encounters` (`entry`,`creditType`,`creditEntry`,`lastEncounterDungeon`,`comment`) VALUES (1654,0,74790,787,'Bloodmaul Slag Mines - Gugrokk');
DELETE FROM `instance_encounters` WHERE `entry` = 1666;
INSERT INTO `instance_encounters` (`entry`,`creditType`,`creditEntry`,`lastEncounterDungeon`,`comment`) VALUES (1666,0,7358,20,'Razorfen Downs - Amnennar the Coldbringer');
DELETE FROM `instance_encounters` WHERE `entry` = 1672;
INSERT INTO `instance_encounters` (`entry`,`creditType`,`creditEntry`,`lastEncounterDungeon`,`comment`) VALUES (1672,0,4829,10,'Blackfathom Deeps - Akumai');
DELETE FROM `instance_encounters` WHERE `entry` = 1701;
INSERT INTO `instance_encounters` (`entry`,`creditType`,`creditEntry`,`lastEncounterDungeon`,`comment`) VALUES (1701,0,76266,779,'Skyreach - High Sage Viryx');
DELETE FROM `instance_encounters` WHERE `entry` = 1714;
INSERT INTO `instance_encounters` (`entry`,`creditType`,`creditEntry`,`lastEncounterDungeon`,`comment`) VALUES (1714,0,77734,820,'Auchindoun - Terongor');
DELETE FROM `instance_encounters` WHERE `entry` = 1762;
INSERT INTO `instance_encounters` (`entry`,`creditType`,`creditEntry`,`lastEncounterDungeon`,`comment`) VALUES (1762,0,77120,330,'Upper Blackrock Spire - Warlord Zaela');
DELETE FROM `instance_encounters` WHERE `entry` = 1793;
INSERT INTO `instance_encounters` (`entry`,`creditType`,`creditEntry`,`lastEncounterDungeon`,`comment`) VALUES (1793,0,91007,1206,'Neltharions Lair - Dargrul');
UPDATE `instance_encounters` SET `creditType` = 0, `creditEntry` = 95676, `lastEncounterDungeon` = 1193 WHERE `entry` = 1809; -- Halls of Valor - Odyn
UPDATE `instance_encounters` SET `creditType` = 0, `creditEntry` = 96028, `lastEncounterDungeon` = 1174 WHERE `entry` = 1814; -- Eye of Azshara - Wrath of Azshara
DELETE FROM `instance_encounters` WHERE `entry` = 1824;
INSERT INTO `instance_encounters` (`entry`,`creditType`,`creditEntry`,`lastEncounterDungeon`,`comment`) VALUES (1824,0,96759,1191,'Maw of Souls - Helya');
DELETE FROM `instance_encounters` WHERE `entry` = 1829;
INSERT INTO `instance_encounters` (`entry`,`creditType`,`creditEntry`,`lastEncounterDungeon`,`comment`) VALUES (1829,0,98208,1189,'The Arcway - Advisor Vandros');
UPDATE `instance_encounters` SET `creditType` = 0, `creditEntry` = 99611, `lastEncounterDungeon` = 1204 WHERE `entry` = 1835; -- Black Rook Hold - Lord Kurtalos Ravencrest
UPDATE `instance_encounters` SET `creditType` = 0, `creditEntry` = 99192, `lastEncounterDungeon` = 1201 WHERE `entry` = 1839; -- Darkheart Thicket - Shade of Xavius
DELETE FROM `instance_encounters` WHERE `entry` = 1851;
INSERT INTO `instance_encounters` (`entry`,`creditType`,`creditEntry`,`lastEncounterDungeon`,`comment`) VALUES (1851,0,102387,1208,'Assault on Violet Hold - Saelorn');
DELETE FROM `instance_encounters` WHERE `entry` = 1889;
INSERT INTO `instance_encounters` (`entry`,`creditType`,`creditEntry`,`lastEncounterDungeon`,`comment`) VALUES (1889,0,18373,149,'Auchenai Crypts - Exarch Maladaar');
DELETE FROM `instance_encounters` WHERE `entry` = 1892;
INSERT INTO `instance_encounters` (`entry`,`creditType`,`creditEntry`,`lastEncounterDungeon`,`comment`) VALUES (1892,0,17307,136,'Hellfire Ramparts - Vazruden the Herald');
DELETE FROM `instance_encounters` WHERE `entry` = 1894;
INSERT INTO `instance_encounters` (`entry`,`creditType`,`creditEntry`,`lastEncounterDungeon`,`comment`) VALUES (1894,0,24664,198,'Magisters Terrace - Kaelthas Sunstrider');
DELETE FROM `instance_encounters` WHERE `entry` = 1899;
INSERT INTO `instance_encounters` (`entry`,`creditType`,`creditEntry`,`lastEncounterDungeon`,`comment`) VALUES (1899,0,18344,148,'Mana-Tombs - Nexus-Prince Shaffar');
DELETE FROM `instance_encounters` WHERE `entry` = 1902;
INSERT INTO `instance_encounters` (`entry`,`creditType`,`creditEntry`,`lastEncounterDungeon`,`comment`) VALUES (1902,0,18473,150,'Sethekk Halls - Talon King Ikiss');
DELETE FROM `instance_encounters` WHERE `entry` = 1906;
INSERT INTO `instance_encounters` (`entry`,`creditType`,`creditEntry`,`lastEncounterDungeon`,`comment`) VALUES (1906,0,18096,170,'The Escape from Durnholde - Epoch Hunter');
DELETE FROM `instance_encounters` WHERE `entry` = 1910;
INSERT INTO `instance_encounters` (`entry`,`creditType`,`creditEntry`,`lastEncounterDungeon`,`comment`) VALUES (1910,0,18708,151,'Shadow Labyrinth - Murmur');
DELETE FROM `instance_encounters` WHERE `entry` = 1923;
INSERT INTO `instance_encounters` (`entry`,`creditType`,`creditEntry`,`lastEncounterDungeon`,`comment`) VALUES (1923,0,17377,137,'Blood Furnace - Kelidan the Breaker');
DELETE FROM `instance_encounters` WHERE `entry` = 1929;
INSERT INTO `instance_encounters` (`entry`,`creditType`,`creditEntry`,`lastEncounterDungeon`,`comment`) VALUES (1929,0,17977,173,'The Botanica - Warp Splinter');
DELETE FROM `instance_encounters` WHERE `entry` = 1931;
INSERT INTO `instance_encounters` (`entry`,`creditType`,`creditEntry`,`lastEncounterDungeon`,`comment`) VALUES (1931,0,19220,172,'The Mechanar - Pathaleon the Calculator');
DELETE FROM `instance_encounters` WHERE `entry` = 1938;
INSERT INTO `instance_encounters` (`entry`,`creditType`,`creditEntry`,`lastEncounterDungeon`,`comment`) VALUES (1938,0,16808,138,'Shattered Halls - Warchief Kargath Bladefist');
DELETE FROM `instance_encounters` WHERE `entry` = 1940;
INSERT INTO `instance_encounters` (`entry`,`creditType`,`creditEntry`,`lastEncounterDungeon`,`comment`) VALUES (1940,0,17942,140,'Slave Pens - Quagmirran');
DELETE FROM `instance_encounters` WHERE `entry` = 1944;
INSERT INTO `instance_encounters` (`entry`,`creditType`,`creditEntry`,`lastEncounterDungeon`,`comment`) VALUES (1944,0,17798,147,'The Steamvault - Warlord Kalithresh');
DELETE FROM `instance_encounters` WHERE `entry` = 1948;
INSERT INTO `instance_encounters` (`entry`,`creditType`,`creditEntry`,`lastEncounterDungeon`,`comment`) VALUES (1948,0,17882,146,'Underbog - The Black Stalker');
DELETE FROM `instance_encounters` WHERE `entry` = 1968;
INSERT INTO `instance_encounters` (`entry`,`creditType`,`creditEntry`,`lastEncounterDungeon`,`comment`) VALUES (1968,0,29311,218,'Ahnkahet: The Old Kingdom - Herald Volazj');
DELETE FROM `instance_encounters` WHERE `entry` = 1973;
INSERT INTO `instance_encounters` (`entry`,`creditType`,`creditEntry`,`lastEncounterDungeon`,`comment`) VALUES (1973,0,29120,204,'Azjol-Nerub - Anubarak');
DELETE FROM `instance_encounters` WHERE `entry` = 1975;
INSERT INTO `instance_encounters` (`entry`,`creditType`,`creditEntry`,`lastEncounterDungeon`,`comment`) VALUES (1975,0,26632,214,'DrakTharon Keep - The Prophet Tharonja');
DELETE FROM `instance_encounters` WHERE `entry` = 1981;
INSERT INTO `instance_encounters` (`entry`,`creditType`,`creditEntry`,`lastEncounterDungeon`,`comment`) VALUES (1981,0,29306,216,'Gundrak - Galdarah');
DELETE FROM `instance_encounters` WHERE `entry` = 1986;
INSERT INTO `instance_encounters` (`entry`,`creditType`,`creditEntry`,`lastEncounterDungeon`,`comment`) VALUES (1986,0,28923,207,'Halls of Lightning - Loken');
DELETE FROM `instance_encounters` WHERE `entry` = 1998;
INSERT INTO `instance_encounters` (`entry`,`creditType`,`creditEntry`,`lastEncounterDungeon`,`comment`) VALUES (1998,0,27978,208,'Halls of Stone - Sjonnir The Ironshaper');
DELETE FROM `instance_encounters` WHERE `entry` = 2005;
INSERT INTO `instance_encounters` (`entry`,`creditType`,`creditEntry`,`lastEncounterDungeon`,`comment`) VALUES (2005,0,26533,209,'The Culling of Stratholme - MalGanis');
DELETE FROM `instance_encounters` WHERE `entry` = 2020;
INSERT INTO `instance_encounters` (`entry`,`creditType`,`creditEntry`,`lastEncounterDungeon`,`comment`) VALUES (2020,0,31134,220,'Violet Hold - Cyanigosa');
DELETE FROM `instance_encounters` WHERE `entry` = 2028;
INSERT INTO `instance_encounters` (`entry`,`creditType`,`creditEntry`,`lastEncounterDungeon`,`comment`) VALUES (2028,0,26861,203,'Utgarde Pinnacle - King Ymiron');
DELETE FROM `instance_encounters` WHERE `entry` = 2068;
INSERT INTO `instance_encounters` (`entry`,`creditType`,`creditEntry`,`lastEncounterDungeon`,`comment`) VALUES (2068,0,124729,1535,'Seat of the Triumvirate - Lura');
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 1 AND `entry` <> 592;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 2 AND `entry` <> 1430;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 4 AND `entry` <> 1446;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 6 AND `entry` <> 1060;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 8 AND `entry` <> 1072;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 10 AND `entry` <> 1672;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 12 AND `entry` <> 1144;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 14 AND `entry` <> 382;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 20 AND `entry` <> 1666;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 22 AND `entry` <> 554;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 24 AND `entry` <> 600;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 26 AND `entry` <> 423;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 28 AND `entry` <> 493;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 30 AND `entry` <> 227;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 32 AND `entry` <> 275;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 34 AND `entry` <> 346;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 36 AND `entry` <> 361;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 38 AND `entry` <> 368;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 40 AND `entry` <> 478;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 136 AND `entry` <> 1892;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 137 AND `entry` <> 1923;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 138 AND `entry` <> 1938;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 140 AND `entry` <> 1940;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 146 AND `entry` <> 1948;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 147 AND `entry` <> 1944;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 148 AND `entry` <> 1899;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 149 AND `entry` <> 1889;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 150 AND `entry` <> 1902;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 151 AND `entry` <> 1910;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 163 AND `entry` <> 1420;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 164 AND `entry` <> 1425;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 170 AND `entry` <> 1906;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 172 AND `entry` <> 1931;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 173 AND `entry` <> 1929;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 198 AND `entry` <> 1894;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 203 AND `entry` <> 2028;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 204 AND `entry` <> 1973;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 206 AND `entry` <> 534;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 207 AND `entry` <> 1986;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 208 AND `entry` <> 1998;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 209 AND `entry` <> 2005;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 214 AND `entry` <> 1975;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 216 AND `entry` <> 1981;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 218 AND `entry` <> 1968;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 220 AND `entry` <> 2020;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 225 AND `entry` <> 526;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 272 AND `entry` <> 424;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 273 AND `entry` <> 429;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 274 AND `entry` <> 484;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 276 AND `entry` <> 245;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 302 AND `entry` <> 1047;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 303 AND `entry` <> 1036;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 304 AND `entry` <> 1049;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 305 AND `entry` <> 1078;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 307 AND `entry` <> 1057;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 311 AND `entry` <> 1042;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 312 AND `entry` <> 1055;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 330 AND `entry` <> 1762;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 334 AND `entry` <> 1182;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 340 AND `entry` <> 1194;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 435 AND `entry` <> 1271;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 437 AND `entry` <> 1274;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 439 AND `entry` <> 1339;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 464 AND `entry` <> 1439;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 465 AND `entry` <> 1414;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 466 AND `entry` <> 1306;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 630 AND `entry` <> 1464;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 631 AND `entry` <> 1419;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 779 AND `entry` <> 1701;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 787 AND `entry` <> 1654;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 820 AND `entry` <> 1714;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 1174 AND `entry` <> 1814;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 1189 AND `entry` <> 1829;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 1191 AND `entry` <> 1824;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 1193 AND `entry` <> 1809;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 1201 AND `entry` <> 1839;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 1204 AND `entry` <> 1835;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 1206 AND `entry` <> 1793;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 1208 AND `entry` <> 1851;
UPDATE `instance_encounters` SET `lastEncounterDungeon` = 0 WHERE `lastEncounterDungeon` = 1535 AND `entry` <> 2068;


-- Sacoches de recompense des donjons aleatoires (classique 156683, Outreterre 156682) : aucun contenu
-- chez nous, d'ou les « sacs vides ». Contenu LegionCore (somme des chances 156682 : 100.4 %, 156683 : 100.6 %), place dans un
-- groupe pour tirer exactement un objet selon ces poids (tirage independant = parfois rien).
DELETE FROM `item_loot_template` WHERE `Entry` IN (156683, 156682);
INSERT INTO `item_loot_template` (`Entry`,`Item`,`Reference`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(156682,51959,0,1.3,0,1,1,1,1,'sacoche LFG (LegionCore)'),
(156682,51960,0,3.6,0,1,1,1,1,'sacoche LFG (LegionCore)'),
(156682,51961,0,1.7,0,1,1,1,1,'sacoche LFG (LegionCore)'),
(156682,51962,0,3.2,0,1,1,1,1,'sacoche LFG (LegionCore)'),
(156682,51963,0,1.4,0,1,1,1,1,'sacoche LFG (LegionCore)'),
(156682,51967,0,2.4,0,1,1,1,1,'sacoche LFG (LegionCore)'),
(156682,51969,0,6,0,1,1,1,1,'sacoche LFG (LegionCore)'),
(156682,51970,0,4.8,0,1,1,1,1,'sacoche LFG (LegionCore)'),
(156682,51971,0,3.7,0,1,1,1,1,'sacoche LFG (LegionCore)'),
(156682,51972,0,5,0,1,1,1,1,'sacoche LFG (LegionCore)'),
(156682,51975,0,3.3,0,1,1,1,1,'sacoche LFG (LegionCore)'),
(156682,51977,0,2,0,1,1,1,1,'sacoche LFG (LegionCore)'),
(156682,51979,0,2.9,0,1,1,1,1,'sacoche LFG (LegionCore)'),
(156682,51981,0,1.5,0,1,1,1,1,'sacoche LFG (LegionCore)'),
(156682,51982,0,3.6,0,1,1,1,1,'sacoche LFG (LegionCore)'),
(156682,51983,0,6,0,1,1,1,1,'sacoche LFG (LegionCore)'),
(156682,51985,0,2.4,0,1,1,1,1,'sacoche LFG (LegionCore)'),
(156682,51987,0,3.2,0,1,1,1,1,'sacoche LFG (LegionCore)'),
(156682,51989,0,2.7,0,1,1,1,1,'sacoche LFG (LegionCore)'),
(156682,51990,0,2.7,0,1,1,1,1,'sacoche LFG (LegionCore)'),
(156682,51991,0,15,0,1,1,1,1,'sacoche LFG (LegionCore)'),
(156682,51993,0,8,0,1,1,1,1,'sacoche LFG (LegionCore)'),
(156682,51995,0,14,0,1,1,1,1,'sacoche LFG (LegionCore)'),
(156683,51962,0,3.3,0,1,1,1,1,'sacoche LFG (LegionCore)'),
(156683,51963,0,2.9,0,1,1,1,1,'sacoche LFG (LegionCore)'),
(156683,51964,0,3,0,1,1,1,1,'sacoche LFG (LegionCore)'),
(156683,51965,0,3.4,0,1,1,1,1,'sacoche LFG (LegionCore)'),
(156683,51966,0,3.3,0,1,1,1,1,'sacoche LFG (LegionCore)'),
(156683,51967,0,5,0,1,1,1,1,'sacoche LFG (LegionCore)'),
(156683,51968,0,5,0,1,1,1,1,'sacoche LFG (LegionCore)'),
(156683,51972,0,4.7,0,1,1,1,1,'sacoche LFG (LegionCore)'),
(156683,51973,0,4.9,0,1,1,1,1,'sacoche LFG (LegionCore)'),
(156683,51974,0,5,0,1,1,1,1,'sacoche LFG (LegionCore)'),
(156683,51976,0,1.8,0,1,1,1,1,'sacoche LFG (LegionCore)'),
(156683,51981,0,1.6,0,1,1,1,1,'sacoche LFG (LegionCore)'),
(156683,51982,0,1.9,0,1,1,1,1,'sacoche LFG (LegionCore)'),
(156683,51984,0,2.9,0,1,1,1,1,'sacoche LFG (LegionCore)'),
(156683,51989,0,2.7,0,1,1,1,1,'sacoche LFG (LegionCore)'),
(156683,51990,0,2.5,0,1,1,1,1,'sacoche LFG (LegionCore)'),
(156683,51992,0,13,0,1,1,1,1,'sacoche LFG (LegionCore)'),
(156683,51994,0,13,0,1,1,1,1,'sacoche LFG (LegionCore)'),
(156683,51996,0,12,0,1,1,1,1,'sacoche LFG (LegionCore)'),
(156683,51999,0,0,0,1,1,1,1,'sacoche LFG (LegionCore)'),
(156683,52000,0,0,0,1,1,1,1,'sacoche LFG (LegionCore)'),
(156683,52001,0,0,0,1,1,1,1,'sacoche LFG (LegionCore)'),
(156683,52002,0,0,0,1,1,1,1,'sacoche LFG (LegionCore)'),
(156683,52003,0,0,0,1,1,1,1,'sacoche LFG (LegionCore)'),
(156683,52004,0,0,0,1,1,1,1,'sacoche LFG (LegionCore)'),
(156683,52005,0,0,0,1,1,1,1,'sacoche LFG (LegionCore)'),
(156683,67248,0,0,0,1,1,1,1,'sacoche LFG (LegionCore)'),
(156683,67250,0,0,0,1,1,1,1,'sacoche LFG (LegionCore)'),
(156683,143580,0,1.5,0,1,1,1,1,'sacoche LFG (LegionCore)'),
(156683,143581,0,2,0,1,1,1,1,'sacoche LFG (LegionCore)'),
(156683,143582,0,3,0,1,1,1,1,'sacoche LFG (LegionCore)'),
(156683,143583,0,2.2,0,1,1,1,1,'sacoche LFG (LegionCore)');
-- Retour arriere : sauvegardes db-backups/recompenses-lfg-avant-*.sql (instance_encounters complete, item_loot_template de ces deux sacs).
