-- Carmines : textes de remise et d'attente manquants (38 + 25 quetes)
-- Anglais : Krigsgaldrnet/AshamaneCore (sql/ashamane/world/2026_10_0x) ; francais officiel releve sur Wowhead FR le 14/10/2026
-- INSERT IGNORE : ne remplace jamais un texte existant

-- 2026_10_04_00_world.sql
-- WANTED: Redridge Gnolls (26504) - Sets quest completion description.
INSERT IGNORE INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(26504, 0, 0, 0, 0, 0, 0, 0, 0, 'A job well done deserves a reward, wouldn\'t you say?\n\nDon\'t spend this all in one place, $c. Better to spread it around, if you catch my drift.', 0);

INSERT IGNORE INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) VALUES
(26504, 0, 0, 0, 0, 'Come to collect on a bounty?', 0);

-- 2026_10_04_01_world.sql
-- An Unwelcome Guest (26509)
INSERT IGNORE INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(26509, 0, 0, 0, 0, 0, 0, 0, 0, 'Finally the menace is laid to rest!  Thank you, $n, you have done me a great service.  The garden shall be in full bloom this season!', 0);

INSERT IGNORE INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) VALUES
(26509, 0, 0, 0, 0, 'Is Bellygrub still at it or were you able to rid Lakeshire of the pest once and for all?', 0);

-- 2026_10_04_02_world.sql
-- Nidas Necklace (26508)
INSERT IGNORE INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(26508, 0, 0, 0, 0, 0, 0, 0, 0, 'Thank you for finding my necklace mister $c... you are very kind!  My kitty thanks you too - isn\'t that right Effsee?', 0);

INSERT IGNORE INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) VALUES
(26508, 0, 0, 0, 0, 'Hi.  I miss my necklace.  My daddy got it for me.  Daddy says that there are monsters in the lake.  Did you beat up any monsters?', 0);

-- 2026_10_04_03_world.sql
-- Lake Everstill Clean Up (26511)
INSERT IGNORE INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(26511, 0, 0, 0, 0, 0, 0, 0, 0, 'That ought to teach those murlocs a lesson. Hopefully the next time they decide to raid our town they\'ll think twice.\n\nWe both know that won\'t happen.', 0);

INSERT IGNORE INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) VALUES
(26511, 0, 0, 0, 0, 'Have you killed all the murlocs?', 0);

-- 2026_10_05_00_world.sql
-- Franks and Beans (26506)
INSERT IGNORE INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(26506, 0, 0, 0, 0, 0, 0, 0, 0, 'PERFECT! I\'ll put these in the pot right away. Dinner should be ready in a few hours.\n\nThank you, darling!', 0);

INSERT IGNORE INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) VALUES
(26506, 0, 0, 0, 0, 'Have you gotten my ingredients?', 0);

-- 2026_10_05_01_world.sql
-- Hero's Call: Redridge Mountains!
INSERT IGNORE INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(26365, 0, 0, 0, 0, 0, 0, 0, 0, 'Heard Westfall was in some deep doody.\n\n<Parker doesn\'t even turn to face you.>\n\nWell, we got our own set of problems here. See them gnolls out there? Looks like they\'re actin\' up again. I don\'t like it. Don\'t like it one bit.', 0),
(28563, 0, 0, 0, 0, 0, 0, 0, 0, 'Heard Westfall was in some deep doody.\n\n<Parker doesn\'t even turn to face you.>\n\nWell, we got our own set of problems here. See them gnolls out there? Looks like they\'re actin\' up again. I don\'t like it. Don\'t like it one bit.', 0);

-- 2026_10_05_02_world.sql
-- Threat to the Kingdom (26761)
INSERT IGNORE INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(26761, 0, 0, 0, 0, 0, 0, 0, 0, 'I heard about the Defias making a return. Terrible news. I wish I had better news, but it would appear that Lakeshire is under attack! We are losing citizens left and right. Our own guards are spread far too thin to handle the situation. We need a hero to step up!', 0);

-- 2026_10_05_03_world.sql
-- Still Assessing the Threat (26503)
INSERT IGNORE INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(26503, 0, 0, 0, 0, 0, 0, 0, 0, 'I knew it! Looks like Yowler is behind this uprising - which is incredible, because we keep killing gnolls named Yowler. I don\'t know how many sons the original Yowler had, but it\'s got to be close to a hundred.\n\nWell, looks like we got ourselves another Yowler to kill.\n\nMagistrate Solomon must be notified.', 0);
  
INSERT IGNORE INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) VALUES
(26503, 0, 0, 0, 0, 'Did you find the gnoll plans?', 0);

-- 2026_10_05_04_world.sql
-- We Must Prepare! (26510)
INSERT IGNORE INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) VALUES
(26510, 0, 0, 0, 0, 'Have you recovered the gnomecorder?', 0);
  
INSERT IGNORE INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(26510, 0, 0, 0, 0, 0, 0, 0, 0, 'Excellent! Let me make a few adjustments here and we should be good to go.', 0);

-- 2026_10_07_00_world.sql
-- Tuning the Gnomecorder (26512)
INSERT IGNORE INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(26512, 0, 0, 0, 0, 0, 0, 0, 0, '<The gnomecorder crackles and pops.>\n\nCan you hear me, $n? Is this thing on? Ah, yes, I see you there now.\n\nLet\'s get to work!', 0);

-- 2026_10_07_01_world.sql
-- Yowler Must Die! (26545)
INSERT IGNORE INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(26545, 0, 0, 0, 0, 0, 0, 0, 0, '<Magistrate Solomon takes the plans from you and begins reading.>\n\nShadowhide army!? Damn those orcs to hell! These invasion plans speak of a massive build up of orcish and gnoll forces in the east. Looks like Gath\'Ilzogg, the Blackrock general, is preparing to march his armies across Lakeshire and attack Stormwind directly!', 0);
  
INSERT IGNORE INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) VALUES
(26545, 0, 0, 0, 0, 'Do you have the Blackrock invasion plans?', 0);

-- 2026_10_07_02_world.sql
-- They've Wised Up (26544)
INSERT IGNORE INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(26544, 0, 0, 0, 0, 0, 0, 0, 0, '<The gnomecorder buzzes and whirs.>\n\nJust put the missive in the little compartment and I\'ll read it. I am fluent in orcish.\n\n<You hear a distraught yell in the background.>\n\nIt looks like these orcs are here under the direct command of Yowler. That means Yowler must have the orc invasion plan.', 0);
  
INSERT IGNORE INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) VALUES
(26544, 0, 0, 0, 0, 'What have you found out?', 0);

-- 2026_10_07_03_world.sql
-- Like a Fart in the Wind (26513)
INSERT IGNORE INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(26513, 0, 0, 0, 0, 0, 0, 0, 0, 'Thank you, citizen. Without you, we would have starved or worse, been forced to go out and get food for ourselves.', 0);
  
INSERT IGNORE INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) VALUES
(26513, 0, 0, 0, 0, 'Did you recover the supplies?', 0);

-- 2026_10_07_04_world.sql
-- Canyon Romp (26514)
INSERT IGNORE INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(26514, 0, 0, 0, 0, 0, 0, 0, 0, '<The gnomecorder crackles and pops.>\n\nGood work, $n. I\'ve just been handed some important information. It would appear that our most hated enemy, the Blackrock orcs, have wised up...\n\n\n\nI\'ve transferred a few silver over to you for the gnome, erm, gnoll kills.', 0);
  
INSERT IGNORE INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) VALUES
(26514, 0, 0, 0, 0, 'Did you recover those collars?', 0);

-- 2026_10_07_05_world.sql
-- He Who Controls the Ettins (26519)
INSERT IGNORE INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(26519, 0, 0, 0, 0, 0, 0, 0, 0, '<The orb hisses as you touch it.>', 0);
  
INSERT IGNORE INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) VALUES
(26519, 0, 0, 0, 0, '<The orb emanates powerful magic.>', 0);

-- 2026_10_08_00_world.sql
-- Weapons of War (26571)
INSERT IGNORE INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(26571, 0, 0, 0, 0, 0, 0, 0, 0, '<The gnomecorder buzzes with energy.>\n\nCome in, $n. Do you copy? Troteman here! Great job on getting Keeshan\'s weapons back! Now there\'s one final mission you have to run. Are you up to the challenge?', 0);
  
INSERT IGNORE INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) VALUES
(26571, 0, 0, 0, 0, 'Did you terminate Murdunk and Homurk?', 0);

-- 2026_10_08_01_world.sql
-- Surveying Equipment (26569)
INSERT IGNORE INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(26569, 0, 0, 0, 0, 0, 0, 0, 0, 'Fantastic work, $n! These will come in handy for our next project, the Lakeshire SUPER BRIDGE, meant to traverse the length of Lake Everstill. It should be done in 20 or so years. Give or take a decade or two.', 0);

INSERT IGNORE INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) VALUES
(26569, 0, 0, 0, 0, 'Did you recover the spyglasses?', 0);

-- 2026_10_08_02_world.sql
-- Render's Army (26570)
INSERT IGNORE INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(26570, 0, 0, 0, 0, 0, 0, 0, 0, 'You\'ve probably bought us another day, maybe two. Nice work, $n.', 0);

-- 2026_10_08_03_world.sql
-- In Search of Bravo Company (26586)
INSERT IGNORE INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(26586, 0, 0, 0, 0, 0, 0, 0, 0, 'Keeshan? You mean JOHNNY\'S ALIVE? You bet your sweet behind I\'ll help, but first you gotta get me out of this damned cage.', 0);

-- 2026_10_08_04_world.sql
-- Jorgensen (26560)
INSERT IGNORE INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(26560, 0, 0, 0, 0, 0, 0, 0, 0, 'I know where they\'re holding Krakauer and Danforth. We gotta hurry. They were prepping those two for a sacrifice!', 0);
  
INSERT IGNORE INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) VALUES
(26560, 0, 0, 0, 0, 'Messner! Damn, it\'s good to see a friendly face. Get me out of here!', 0);

-- 2026_10_08_05_world.sql
-- Krakauer (26561)
INSERT IGNORE INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(26561, 0, 0, 0, 0, 0, 0, 0, 0, 'Wha... Where am I? What happened? Messner? Jorgensen?\n\nOH MY GOSH! We have to get to Danforth! It might already be too late!', 0);
  
INSERT IGNORE INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) VALUES
(26561, 0, 0, 0, 0, '<Krakauer groans.>', 0);

-- 2026_10_08_06_world.sql
-- And Last But Not Least... Danforth (2656)
INSERT IGNORE INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(26562, 0, 0, 0, 0, 0, 0, 0, 0, 'About damn time you sissies showed up. My arms were gettin\' tired.', 0);
  
INSERT IGNORE INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) VALUES
(26562, 0, 0, 0, 0, 'Well look at that! The team\'s all here... everyone but Keeshan.', 0);

-- 2026_10_08_07_world.sql
-- His Heart Must Be In It (26573)
INSERT IGNORE INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(26573, 0, 0, 0, 0, 0, 0, 0, 0, 'I hope with these items and with his crew all rescued he\'ll have a change of heart. We can\'t do this without Keeshan.', 0);
  
INSERT IGNORE INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) VALUES
(26573, 0, 0, 0, 0, 'Did you locate the headband and amulet?', 0);

-- 2026_10_08_08_world.sql
-- Breaking Out is Hard to Do (26587)
INSERT IGNORE INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(26587, 0, 0, 0, 0, 0, 0, 0, 0, 'IT\'S PAYBACK TIME!', 0);

INSERT IGNORE INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) VALUES
(26587, 0, 0, 0, 0, 'Did you get the cage key?', 0);

-- 2026_10_10_00_world.sql
-- Unspeakable Atrocities (26640)
INSERT IGNORE INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(26640, 0, 0, 0, 0, 0, 0, 0, 0, '<Keeshan reads the report.>\n\nDAMN IT! This just got complicated. We\'ve got prisoners of war to rescue before we can blow up the valley. Not to mention the orcs have black dragons on their side.\n\nAre you ready, $n?', 0);
  
INSERT IGNORE INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) VALUES
(26640, 0, 0, 0, 0, 'They got Brubaker?', 0);

-- 2026_10_10_01_world.sql
-- They Drew First Blood (26607)
INSERT IGNORE INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(26607, 0, 0, 0, 0, 0, 0, 0, 0, '<Keeshan takes the bundle from you and opens it.>\n\nMy bow... and knife! Where did you...\n\nJade\'s amulet... My darling Jade.\n\n<Keeshan picks up his red headband.>\n\nWe got orcs to kill.', 0);
  
INSERT IGNORE INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) VALUES
(26607, 0, 0, 0, 0, 'You again?', 0);

-- 2026_10_10_02_world.sql
-- Return of the Bravo Company (26563)
INSERT IGNORE INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(26563, 0, 0, 0, 0, 0, 0, 0, 0, '<Colonel Troteman salutes.>\n\nUnbelievable work, $n. You\'ve managed to rescue the entire Bravo Company from the clutches of the Blackrock orcs? With Keeshan\'s team rescued and Keeshan\'s belongings returned, there\'s no way Keeshan could refuse us.', 0);

-- 2026_10_10_03_world.sql
-- Point of Contact: Brubaker (26639)
INSERT IGNORE INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(26639, 0, 0, 0, 0, 0, 0, 0, 0, 'Brubaker is dead. It looks like the orcs are attempting to send a message with this grisly display. Upon closer examination you notice something in Brubaker\'s pouch.', 0);

-- 2026_10_10_04_world.sql
-- It's Never Over (26616)
INSERT IGNORE INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(26616, 0, 0, 0, 0, 0, 0, 0, 0, 'It\'s orc killin\' time.', 0);

-- 2026_10_10_05_world.sql
-- Hunting the Hunters (26638)
INSERT IGNORE INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(26638, 0, 0, 0, 0, 0, 0, 0, 0, 'Great work, $n. We need to move quickly before they send for reinforcements.', 0);

-- 2026_10_10_06_world.sql
-- Bravo Company Field Kit Chloroform (26637)
INSERT IGNORE INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(26637, 0, 0, 0, 0, 0, 0, 0, 0, 'Perfect. Those orcs won\'t know what hit \'em - literally. I\'ll need a few minutes to get these in working order and then I\'ll put them in the Bravo Company field kit.', 0);
  
INSERT IGNORE INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) VALUES
(26637, 0, 0, 0, 0, 'Did you recover the glands?', 0);

-- 2026_10_10_07_world.sql
-- Bravo Company Field Kit: Camouflage (26636)
INSERT IGNORE INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(26636, 0, 0, 0, 0, 0, 0, 0, 0, 'Nice job, rookie. I\'m gonna go ahead and put the camo in the box. We should be ready soon.', 0);
  
INSERT IGNORE INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) VALUES
(26636, 0, 0, 0, 0, 'Leaves and poop - that\'s what I need.', 0);

-- 2026_10_12_00_world.sql
-- Prisoners of War (26646)
INSERT IGNORE INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(26646, 0, 0, 0, 0, 0, 0, 0, 0, '<The radio on the Bravo Company field kit crackles.>\n\nLooks like the P.O.W.s are free. Time to initiate Operation: End All.', 0);

-- 2026_10_12_01_world.sql
-- To Win a War, You Gotta Become War (26651)
INSERT IGNORE INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(26651, 0, 0, 0, 0, 0, 0, 0, 0, 'And now, we blow the whole damned thing up.', 0);

-- 2026_10_12_02_world.sql
-- Detonation (26668)
INSERT IGNORE INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(26668, 0, 0, 0, 0, 0, 0, 0, 0, 'Did you see those orcs explode? THAT\'S HOW WE DO IT IN BRAVO COMPANY! Now to clean up the rest of these jackasses.', 0);

-- 2026_10_12_03_world.sql
-- Shadowhide Extinction (26692) - Sets quest completion description.
INSERT IGNORE INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(26692, 0, 0, 0, 0, 0, 0, 0, 0, 'We\'re closing in on the Blackrock high command. There\'s nowhere left for those dogs to run.', 0);

-- 2026_10_12_04_world.sql
-- The Dark Tower (26693)
INSERT IGNORE INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(26693, 0, 0, 0, 0, 0, 0, 0, 0, '<Keeshan comes in over the Bravo Company field kit.>\n\nNow that the easy part is over, it\'s time for phase two.', 0);
  
INSERT IGNORE INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) VALUES
(26693, 0, 0, 0, 0, 'I hear you loud and clear, $n.', 0);

-- 2026_10_12_05_world.sql
-- The Grand Magus Doane (26694)
INSERT IGNORE INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(26694, 0, 0, 0, 0, 0, 0, 0, 0, 'He teleported away? Mentioned Darkblaze? What the hell is going on here.\n\nLooks like it\'s time to strap in and finish this nonsense.', 0);
  
INSERT IGNORE INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) VALUES
(26694, 0, 0, 0, 0, 'I hear you loud and clear, $n.', 0);

INSERT IGNORE INTO `quest_offer_reward_locale` (`ID`,`locale`,`RewardText`,`VerifiedBuild`) VALUES
(26365,'frFR','J’ai entendu dire que la marche de l’Ouest était dans la mouise jusqu’au cou.\n\n<Parker ne se retourne même pas pour vous parler.>\n\nEh ben, on a notre propre lot de problèmes ici. Vous avez vu les Gnolls, là-bas ? Je les sens agités. Ça ne me plaît pas. Mais pas du tout !',0),
(26503,'frFR','J’en étais sûr ! On dirait que Couineur est à l’origine de ce complot… Ce qui est surprenant, vu qu’on n’arrête pas de tuer des Gnolls du nom de Couineur. Je ne sais pas combien de fils a eu le premier Couineur, mais ça doit se rapprocher d’une centaine !\n\nEnfin, on dirait bien qu’on a un nouveau Couineur dans notre ligne de mire.\n\nIl faut avertir le magistrat Salomon.',0),
(26504,'frFR','Tout travail bien fait mérite récompense, n’est-ce pas ?\n\nNe dépensez pas tout au même endroit, $c. Il vaut mieux disséminer l’argent, si vous voyez où je veux en venir.',0),
(26506,'frFR','PARFAIT ! Je vais les mettre tout de suite dans la marmite. Le dîner devrait être prêt dans quelques heures.\n\nMerci, trésor !',0),
(26508,'frFR','Merci d’avoir retrouvé mon collier, monsieur le $c… C’est très gentil ! Mon chat vous remercie aussi, pas vrai Effsee ?',0),
(26509,'frFR','Ce danger public a enfin disparu ! Merci, $n, vous m’avez rendu un immense service. Grâce à vous, il y aura plein de fleurs dans mon jardin cette saison !',0),
(26510,'frFR','Excellent ! Laissez-moi juste le temps de faire quelques réglages, et nous serons prêts à partir !',0),
(26511,'frFR','Les murlocs ont dû comprendre leur douleur ! J’espère que la prochaine fois qu’ils décideront d’attaquer notre ville, ils y réfléchiront à deux fois.\n\nMais nous savons tous les deux que cela n’arrivera pas.',0),
(26513,'frFR','Merci, citoyen. Sans vous, nous serions probablement morts de faim ou pire, nous aurions été forcés d’aller chercher de la nourriture par nous-mêmes.',0),
(26519,'frFR','<L’orbe émet un sifflement lorsque vous le touchez.>',0),
(26545,'frFR','<Le magistrat Salomon saisit les plans que vous lui tendez, puis les examine.>\n\nUne armée de Sombrepoils ? Maudits soient ces Orcs ! Ces plans d’invasion indiquent que des troupes orques et gnolles s’accumulent dangereusement, à l’est. Il semblerait que Gath’Ilzogg, le général rochenoire, soit en train de préparer son armée à attaquer Comté-du-Lac puis Hurlevent !',0),
(26560,'frFR','Je sais où Krakauer et Danforth sont retenus prisonniers. Faut qu’on se dépêche. Ils allaient bientôt servir de sacrifice !',0),
(26561,'frFR','Qu’est-ce que… Où suis-je ? Que s’est-il passé ? Messner ? Jorgensen ?\n\nOH MON DIEU ! Il faut trouver Danforth ! J’espère qu’il n’est pas déjà trop tard !',0),
(26562,'frFR','Vous en avez mis du temps ! Bande de mauviettes ! Mes bras commençaient à fatiguer.',0),
(26563,'frFR','<Le colonel Troteman vous salue.>\n\nQuel travail remarquable, $n. Vous avez réussi à libérer tous les membres de la compagnie Bravo des griffes des Orcs rochenoires ? Vous avez sauvé l’équipe de Keeshan et récupéré ses affaires. Il ne pourra pas nous refuser cela.',0),
(26569,'frFR','Excellent travail, $n ! Ces longues-vues me seront utiles pour mon prochain projet, le SUPER PONT des Carmines, censé traverser le lac Placide dans toute sa longueur. La construction devrait durer vingt ans ou plus. À une ou deux décennies près.',0),
(26570,'frFR','Vous nous avez probablement fait gagner un jour ou deux. Bon travail, $n.',0),
(26573,'frFR','J’espère que la vue de ces deux objets et de son équipe réunie au grand complet le fera changer d’avis. Nous sommes impuissants sans Keeshan.',0),
(26586,'frFR','Keeshan ? Vous voulez dire que JOHNNY EST EN VIE ? Bien sûr que je vais vous aider, mais d’abord faites-moi sortir de cette fichue cage.',0),
(26587,'frFR','L’HEURE DE LA REVANCHE A SONNÉ !',0),
(26607,'frFR','<Keeshan saisit le paquet que vous lui tendez, puis l’ouvre.>\n\nMon arc… Et mon couteau ! Où avez-vous…\n\nL’amulette de Jade… Ma chère Jade.\n\n<Keeshan s’empare de son bandeau rouge.>\n\nOn a des Orcs à tuer, il me semble.',0),
(26616,'frFR','La chasse à l’orc est ouverte !',0),
(26636,'frFR','Bon travail, recrue. Je vais aller mettre ce camouflage dans la boîte. On devrait bientôt être prêt.',0),
(26637,'frFR','Parfait. Les Orcs ne comprendront pas ce qui leur arrive. Il va me falloir quelques minutes pour rendre les glandes utilisables, puis je les mettrai dans le paquetage de la compagnie Bravo.',0),
(26638,'frFR','Excellent travail, $n. Il faut agir rapidement avant qu’ils n’envoient des renforts.',0),
(26639,'frFR','Brubaker est mort. On dirait que les Orcs essaient de faire passer un message en utilisant la manière forte. En examinant de plus près son cadavre, vous remarquez quelque chose qui dépasse de sa sacoche.',0),
(26640,'frFR','<Keeshan lit le rapport.>\n\nBON SANG ! La situation se complique. On va devoir libérer les prisonniers de guerre avant de faire sauter la vallée. Sans compter que les Orcs ont des dragons noirs à leurs côtés.\n\nVous êtes prêt, $n ?',0),
(26651,'frFR','Et maintenant, on fait tout sauter !',0),
(26668,'frFR','Vous avez vu les Orcs exploser ? ÇA SE PASSE COMME ÇA CHEZ LA COMPAGNIE BRAVO ! Et une deuxième tournée pour les abrutis qui auraient survécu !',0),
(26694,'frFR','Il s’est volatilisé en se téléportant ? Il a parlé de Sombrembrase ? Bon sang, mais qu’est-ce qui se passe, ici ?!\n\nJe crois qu’il est temps d’en finir avec ces bêtises.',0),
(26761,'frFR','J’ai eu vent du retour des Défias. C’est terrible. J’aimerais avoir de meilleures nouvelles à vous annoncer, mais il semblerait que Comté-du-Lac soit prise d’assaut ! D’honnêtes citoyens meurent sur les deux fronts. Nos gardes sont trop éparpillés pour pouvoir maîtriser la situation. Nous avons besoin d’un héros pour faire face !',0),
(28563,'frFR','J’ai entendu que la marche de l’Ouest était dans de sales draps.\n\n<Parker ne prend même pas la peine de se tourner vers vous pour vous parler.>\n\nEh bien, ils ne sont pas les seuls à avoir des problèmes. Vous avez vu les gnolls, dehors ? On dirait qu’ils nous préparent encore un coup fumant. Je n’aime pas ça. Je n’aime pas ça du tout.',0);

INSERT IGNORE INTO `quest_request_items_locale` (`ID`,`locale`,`CompletionText`,`VerifiedBuild`) VALUES
(26503,'frFR','Vous avez trouvé les plans gnolls ?',0),
(26506,'frFR','Vous avez pu récupérer les ingrédients ?',0),
(26508,'frFR','Bonjour. J’aimerais retrouver mon collier. C’est mon papa qui me l’a offert. Il dit qu’il y a des monstres dans le lac. Vous en avez tué ?',0),
(26509,'frFR','Est-ce que Fouailleventre est toujours en vie, ou avez-vous débarrassé Comté-du-Lac de cette nuisance une bonne fois pour toutes ?',0),
(26510,'frFR','Vous avez pu récupérer le gnomotophone ?',0),
(26513,'frFR','Vous avez pu récupérer les provisions ?',0),
(26545,'frFR','Vous avez les plans d’invasion rochenoire ?',0),
(26560,'frFR','Messner ! Bon sang, ça fait plaisir de voir un visage amical ! Fais-moi sortir d’ici !',0),
(26562,'frFR','Eh bien, regardez-moi ça ! L’équipe est au grand complet… Il ne manque plus que Keeshan.',0),
(26569,'frFR','Vous avez pu récupérer des longues-vues ?',0),
(26573,'frFR','Vous avez retrouvé le bandeau et l’amulette ?',0),
(26587,'frFR','Vous avez pu récupérer la clé de la cage ?',0),
(26607,'frFR','Encore vous ?',0),
(26636,'frFR','Des feuilles et des crottes, c’est tout ce qu’il me faut.',0),
(26637,'frFR','Vous avez pu récupérer des glandes ?',0),
(26640,'frFR','Ils ont eu Brubaker ?',0);
