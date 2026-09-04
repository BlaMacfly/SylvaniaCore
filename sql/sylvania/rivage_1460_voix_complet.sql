/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-11.4.7-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: dc_world
-- ------------------------------------------------------
-- Server version	11.4.7-MariaDB-0ubuntu0.25.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Dumping data for table `creature_text`
--
-- WHERE:  CreatureID IN (90367,90413,90544,90705,90708,90709,90710,90711,90713,90714,90716,90717,91951,94276)

LOCK TABLES `creature_text` WRITE;
/*!40000 ALTER TABLE `creature_text` DISABLE KEYS */;
INSERT INTO `creature_text` VALUES (90367,0,0,'Ne vous souciez pas de moi ! Le tombeau... Gul\'dan ouvre le tombeau ! Arrêtez-le !',14,0,100,5,0,0,0,0,'Tirion crevasse');
INSERT INTO `creature_text` VALUES (90367,20,0,'Stay back... it\'s a trap... the Light will protect me...',14,0,100,0,0,53452,99237,0,'mort de Tirion 1');
INSERT INTO `creature_text` VALUES (90367,21,0,'The Light... will... ahh!  Aahhhh!!',14,0,100,0,0,53455,99240,0,'mort de Tirion 5');
INSERT INTO `creature_text` VALUES (90413,0,0,'Vous arrivez trop tard ! Les ténèbres s\'éveillent sous ce tombeau !',14,0,100,25,0,0,0,0,'Guldan accueil');
INSERT INTO `creature_text` VALUES (90413,1,0,'Sargeras... accueille leurs âmes !',14,0,100,25,0,0,0,0,'Guldan invocation');
INSERT INTO `creature_text` VALUES (90413,2,0,'Cette victoire ne changera rien. L\'Étoile ardente approche !',14,0,100,25,0,0,0,0,'Guldan retraite');
INSERT INTO `creature_text` VALUES (90413,20,0,'Ha, you fool! You stand before the temple of a GOD. Your pitiful Light cannot reach you here.',14,0,100,0,0,53453,99238,0,'mort de Tirion 2');
INSERT INTO `creature_text` VALUES (90413,21,0,'Destroy him.',14,0,100,0,0,53454,99239,0,'mort de Tirion 4');
INSERT INTO `creature_text` VALUES (90413,22,0,'All you have worked for, all you have sacrificed, just to see your champions fall to ash one by one.',14,0,100,0,0,53458,99243,0,'mort de Tirion 7');
INSERT INTO `creature_text` VALUES (90413,23,0,'Destroy them!',14,0,100,0,0,53462,99247,0,'mort de Tirion 8');
INSERT INTO `creature_text` VALUES (90544,10,0,'You will know fear.',14,0,100,0,0,53463,99248,0,'voix officielle -- son 53463');
INSERT INTO `creature_text` VALUES (90705,0,0,'Vos armées ne sont que poussière. Je suis Arganoth, et cette plage sera votre tombeau !',14,0,100,15,0,0,0,0,'Arganoth spawn');
INSERT INTO `creature_text` VALUES (90705,1,0,'La Légion... est... éternelle...',14,0,100,0,0,0,0,0,'Arganoth mort');
INSERT INTO `creature_text` VALUES (90708,0,0,'Fils et filles de la Horde ! Montrez à la Légion c\'que vaut not\' sang ! LOK\'TAR OGAR !',14,0,100,5,0,53528,99315,0,'Voljin ralliement');
INSERT INTO `creature_text` VALUES (90708,1,0,'Argh... la lame... empoisonnée... Sylvanas... sonne la retraite...',14,0,100,0,0,0,0,0,'Voljin blessé');
INSERT INTO `creature_text` VALUES (90708,10,0,'Listen up! Dere\'s only one way offa dis beach, and it be t\'rough alla dose demons ahead of us. But dey don\'t know who dey be dealin\' wit. Let\'s show dem what it means ta be Horde!',14,0,100,0,0,53528,99315,0,'voix officielle -- son 53528');
INSERT INTO `creature_text` VALUES (90708,11,0,'Die.',14,0,100,0,0,53536,99323,0,'voix officielle -- son 53536');
INSERT INTO `creature_text` VALUES (90708,13,0,'',14,0,100,0,0,53590,143151,0,'voix officielle -- son 53590');
INSERT INTO `creature_text` VALUES (90708,15,0,'Dis one\'s mine.',14,0,100,0,0,53537,99324,0,'voix officielle -- son 53537');
INSERT INTO `creature_text` VALUES (90709,0,0,'La Horde ne mourra pas sur cette plage. Avancez, et que la Légion tombe !',14,0,100,25,0,53587,99374,0,'Sylvanas');
INSERT INTO `creature_text` VALUES (90709,10,0,'',14,0,100,0,0,53590,99375,0,'voix officielle -- son 53590');
INSERT INTO `creature_text` VALUES (90709,11,0,'',14,0,100,0,0,53587,99374,0,'voix officielle -- son 53587');
INSERT INTO `creature_text` VALUES (90709,12,0,'',14,0,100,0,0,53465,99250,0,'voix officielle -- son 53465');
INSERT INTO `creature_text` VALUES (90709,13,0,'',14,0,100,0,0,53585,99372,0,'voix officielle -- son 53585');
INSERT INTO `creature_text` VALUES (90709,14,0,'',12,0,100,0,0,53610,99397,0,'voix officielle -- son 53610');
INSERT INTO `creature_text` VALUES (90709,15,0,'',12,0,100,0,0,53612,99399,0,'voix officielle -- son 53612');
INSERT INTO `creature_text` VALUES (90710,14,0,'By the Earthmother!',14,0,100,0,0,53591,109421,0,'voix officielle -- son 53591');
INSERT INTO `creature_text` VALUES (90711,10,0,'The elements will destroy you!',14,0,100,0,0,53534,99321,0,'voix officielle -- son 53534');
INSERT INTO `creature_text` VALUES (90711,11,0,'Back to the Nether!',14,0,100,0,0,53533,99320,0,'voix officielle -- son 53533');
INSERT INTO `creature_text` VALUES (90711,12,0,'Spirits of earth, aid me!',12,0,100,0,0,53611,99398,0,'voix officielle -- son 53611');
INSERT INTO `creature_text` VALUES (90711,20,0,'Fordring!',14,0,100,0,0,53456,99241,0,'mort de Tirion 6');
INSERT INTO `creature_text` VALUES (90713,0,0,'Soldats de l\'Alliance ! La Légion s\'abat sur nos terres. Repoussez-la jusqu\'aux portes du tombeau de Sargeras !',14,0,100,5,0,53498,99285,0,'Varian ralliement');
INSERT INTO `creature_text` VALUES (90713,1,0,'Partez, sauvez ce qui peut l\'être ! Dites à mon fils... que je suis mort en roi. Pour l\'Alliance !',14,0,100,5,0,53407,146212,0,'Varian sacrifice');
INSERT INTO `creature_text` VALUES (90713,10,0,'Brace yourselves, Alliance, it\'s coming this way!',14,0,100,0,0,53464,99249,0,'voix officielle -- son 53464');
INSERT INTO `creature_text` VALUES (90713,11,0,'',14,0,100,0,0,53407,146212,0,'voix officielle -- son 53407');
INSERT INTO `creature_text` VALUES (90713,14,0,'We\'re pushing them back! Don\'t let up!',14,0,100,0,0,53405,99189,0,'voix officielle -- son 53405');
INSERT INTO `creature_text` VALUES (90713,15,0,'There is nowhere to run, Gul\'dan. Give up now, and I will grant you a swift death.',14,0,100,0,0,53496,99283,0,'voix officielle -- son 53496');
INSERT INTO `creature_text` VALUES (90713,16,0,'Hold steady, we\'ve broken their lines before, we will again. Charge!',14,0,100,0,0,53498,99285,0,'voix officielle -- son 53498');
INSERT INTO `creature_text` VALUES (90713,17,0,'No matter how many demons you throw at us, we will cut you down, monster.',14,0,100,0,0,53513,99300,0,'voix officielle -- son 53513');
INSERT INTO `creature_text` VALUES (90713,20,0,'We will never give in to hopelessness!',14,0,100,0,0,53459,99244,0,'mort de Tirion, riposte');
INSERT INTO `creature_text` VALUES (90714,0,0,'Leurs portails déversent des renforts sans fin ! Détruisez les ancres dimensionnelles !',14,0,100,5,0,53345,94240,0,'Jaina portails');
INSERT INTO `creature_text` VALUES (90714,10,0,'',14,0,100,0,0,53345,94240,0,'voix officielle -- son 53345');
INSERT INTO `creature_text` VALUES (90714,11,0,'',14,0,100,0,0,53347,94242,0,'voix officielle -- son 53347');
INSERT INTO `creature_text` VALUES (90714,12,0,'',14,0,100,0,0,53357,94594,0,'voix officielle -- son 53357');
INSERT INTO `creature_text` VALUES (90714,13,0,'',12,0,100,0,0,53449,99234,0,'voix officielle -- son 53449');
INSERT INTO `creature_text` VALUES (90714,14,0,'',14,0,100,0,0,53358,94595,0,'voix officielle -- son 53358');
INSERT INTO `creature_text` VALUES (90716,10,0,'How are we going to get across?',12,0,100,1,0,53448,99233,0,'voix officielle -- son 53448');
INSERT INTO `creature_text` VALUES (90716,11,0,'For Gnomeregan!',14,0,100,0,0,53409,99193,0,'voix officielle -- son 53409');
INSERT INTO `creature_text` VALUES (90716,12,0,'',14,0,100,0,0,53408,127434,0,'voix officielle -- son 53408');
INSERT INTO `creature_text` VALUES (90717,10,0,'Just in time. We haven\'t been able to break their line, now we may have a chance.',14,0,100,0,0,53346,94241,0,'voix officielle -- son 53346');
INSERT INTO `creature_text` VALUES (90717,11,0,'There\'s only one way out of this, Alliance, and it\'s through that line of demons! Cannons, lay down covering fire! All forces, CHARGE!',14,0,100,0,0,53348,94585,0,'voix officielle -- son 53348');
INSERT INTO `creature_text` VALUES (90717,12,0,'Go for the throat!',14,0,100,0,0,53354,94591,0,'voix officielle -- son 53354');
INSERT INTO `creature_text` VALUES (90717,13,0,'This one\'s mine!',14,0,100,0,0,53355,117408,0,'voix officielle -- son 53355');
INSERT INTO `creature_text` VALUES (90717,14,0,'Side by side, don\'t let them break through!',14,0,100,0,0,53353,94590,0,'voix officielle -- son 53353');
INSERT INTO `creature_text` VALUES (91951,20,0,'Stay back... it\'s a trap... the Light will protect me...',14,0,100,0,0,53452,99237,0,'mort de Tirion 1');
INSERT INTO `creature_text` VALUES (91951,21,0,'The Light... will... ahh!  Aahhhh!!',14,0,100,0,0,53455,99240,0,'mort de Tirion 5');
INSERT INTO `creature_text` VALUES (94276,0,0,'I have seen the end of your pitiful world, Wrynn. You will perish in felfire.',14,0,100,0,0,53506,99293,0,'finale Guldan 1');
INSERT INTO `creature_text` VALUES (94276,2,0,'Destroy them!',14,0,100,0,0,53462,99247,0,'finale Guldan 2');
INSERT INTO `creature_text` VALUES (94276,20,0,'Ha, you fool! You stand before the temple of a GOD. Your pitiful Light cannot reach you here.',14,0,100,0,0,53453,99238,0,'mort de Tirion 2');
INSERT INTO `creature_text` VALUES (94276,21,0,'Destroy him.',14,0,100,0,0,53454,99239,0,'mort de Tirion 4');
INSERT INTO `creature_text` VALUES (94276,22,0,'All you have worked for, all you have sacrificed, just to see your champions fall to ash one by one.',14,0,100,0,0,53458,99243,0,'mort de Tirion 7');
INSERT INTO `creature_text` VALUES (94276,23,0,'Destroy them!',14,0,100,0,0,53462,99247,0,'mort de Tirion 8');
/*!40000 ALTER TABLE `creature_text` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2026-09-05  0:06:36
