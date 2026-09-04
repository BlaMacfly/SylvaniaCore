-- =====================================================================
-- Rivage brisé (1460) — la parole et la VOIX rendues aux personnages
--
-- SIGNALÉ EN JEU : « tous les PNJ de la zone sont totalement
-- inexpressifs, ça n'a pas d'âme », « tout est muet même s'il y a du
-- textuel ».
--
-- CAUSE : nos répliques portent un BroadcastTextId à ZÉRO. Le serveur
-- envoie alors du texte brut, que le client affiche sans rien avoir à
-- résoudre — donc sans la version localisée et SANS LA BANDE SON. Le
-- client possède pourtant les deux : c'est pour cela que la vidéo
-- montre du français alors que notre base n'en contient aucune
-- traduction. Il ne lui manquait que l'identifiant.
--
-- SOURCE : creature_text du dump dufernst/LegionCore-7.3.5, qui a
-- conservé les Sound et BroadcastTextID d'origine. Son texte est en
-- russe, sans importance : l'identifiant prime, et le client rendra sa
-- propre version. Le texte porté ici est l'anglais officiel, tiré de
-- notre broadcast_text — il ne sert que de repli et de repère.
--
-- GROUPES DÉCALÉS DE +10. Nos répliques existantes, aux groupes 0 et 1,
-- sont CONSERVÉES : le script les appelle par Talk(0) et Talk(1), et
-- les écraser ferait dire à Varian « Pour l'Alliance ! » au moment de
-- mourir. Le recâblage du script est un travail distinct.
--
-- 34 répliques, toutes avec son et identifiant de diffusion.
-- =====================================================================

DELETE FROM `creature_text` WHERE `GroupID` >= 10 AND `CreatureID` IN (90544,90708,90709,90710,90711,90713,90714,90716,90717);

INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`,`TextRange`,`comment`) VALUES
(90544,10,0,'You will know fear.',14,0,100,0,0,53463,99248,0,'voix officielle -- son 53463'),
(90708,10,0,'Listen up! Dere''s only one way offa dis beach, and it be t''rough alla dose demons ahead of us. But dey don''t know who dey be dealin'' wit. Let''s show dem what it means ta be Horde!',14,0,100,0,0,53528,99315,0,'voix officielle -- son 53528'),
(90708,11,0,'Die.',14,0,100,0,0,53536,99323,0,'voix officielle -- son 53536'),
(90708,13,0,'',14,0,100,0,0,53590,143151,0,'voix officielle -- son 53590'),
(90708,15,0,'Dis one''s mine.',14,0,100,0,0,53537,99324,0,'voix officielle -- son 53537'),
(90709,10,0,'',14,0,100,0,0,53590,99375,0,'voix officielle -- son 53590'),
(90709,11,0,'',14,0,100,0,0,53587,99374,0,'voix officielle -- son 53587'),
(90709,12,0,'',14,0,100,0,0,53465,99250,0,'voix officielle -- son 53465'),
(90709,13,0,'',14,0,100,0,0,53585,99372,0,'voix officielle -- son 53585'),
(90709,14,0,'',12,0,100,0,0,53610,99397,0,'voix officielle -- son 53610'),
(90709,15,0,'',12,0,100,0,0,53612,99399,0,'voix officielle -- son 53612'),
(90710,14,0,'By the Earthmother!',14,0,100,0,0,53591,109421,0,'voix officielle -- son 53591'),
(90711,10,0,'The elements will destroy you!',14,0,100,0,0,53534,99321,0,'voix officielle -- son 53534'),
(90711,11,0,'Back to the Nether!',14,0,100,0,0,53533,99320,0,'voix officielle -- son 53533'),
(90711,12,0,'Spirits of earth, aid me!',12,0,100,0,0,53611,99398,0,'voix officielle -- son 53611'),
(90713,10,0,'Brace yourselves, Alliance, it''s coming this way!',14,0,100,0,0,53464,99249,0,'voix officielle -- son 53464'),
(90713,11,0,'',14,0,100,0,0,53407,146212,0,'voix officielle -- son 53407'),
(90713,14,0,'We''re pushing them back! Don''t let up!',14,0,100,0,0,53405,99189,0,'voix officielle -- son 53405'),
(90713,15,0,'There is nowhere to run, Gul''dan. Give up now, and I will grant you a swift death.',14,0,100,0,0,53496,99283,0,'voix officielle -- son 53496'),
(90713,16,0,'Hold steady, we''ve broken their lines before, we will again. Charge!',14,0,100,0,0,53498,99285,0,'voix officielle -- son 53498'),
(90713,17,0,'No matter how many demons you throw at us, we will cut you down, monster.',14,0,100,0,0,53513,99300,0,'voix officielle -- son 53513'),
(90714,10,0,'',14,0,100,0,0,53345,94240,0,'voix officielle -- son 53345'),
(90714,11,0,'',14,0,100,0,0,53347,94242,0,'voix officielle -- son 53347'),
(90714,12,0,'',14,0,100,0,0,53357,94594,0,'voix officielle -- son 53357'),
(90714,13,0,'',12,0,100,0,0,53449,99234,0,'voix officielle -- son 53449'),
(90714,14,0,'',14,0,100,0,0,53358,94595,0,'voix officielle -- son 53358'),
(90716,10,0,'How are we going to get across?',12,0,100,1,0,53448,99233,0,'voix officielle -- son 53448'),
(90716,11,0,'For Gnomeregan!',14,0,100,0,0,53409,99193,0,'voix officielle -- son 53409'),
(90716,12,0,'',14,0,100,0,0,53408,127434,0,'voix officielle -- son 53408'),
(90717,10,0,'Just in time. We haven''t been able to break their line, now we may have a chance.',14,0,100,0,0,53346,94241,0,'voix officielle -- son 53346'),
(90717,11,0,'There''s only one way out of this, Alliance, and it''s through that line of demons! Cannons, lay down covering fire! All forces, CHARGE!',14,0,100,0,0,53348,94585,0,'voix officielle -- son 53348'),
(90717,12,0,'Go for the throat!',14,0,100,0,0,53354,94591,0,'voix officielle -- son 53354'),
(90717,13,0,'This one''s mine!',14,0,100,0,0,53355,117408,0,'voix officielle -- son 53355'),
(90717,14,0,'Side by side, don''t let them break through!',14,0,100,0,0,53353,94590,0,'voix officielle -- son 53353');
