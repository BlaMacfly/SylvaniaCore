-- =====================================================================
-- Rivage brise, phase 7 : la conversation du gouffre, cote Horde.
--
-- Le bloc Horde (99393-99399) repond un pour un a celui de l'Alliance
-- (99229-99234) : meme scene, memes roles, deux distributions.
--
--   Alliance                          Horde
--   Genn   « Ils battent en retraite » Vol'jin « Dey be retreatin' »
--   Varian « pas encore terminee »     Sylvanas« trop facile »
--   Jaina  repere Tirion               Thrall  repere Gul'dan et Tirion
--   Varian « suivez Jaina »            Vol'jin « get ta Thrall »
--   Gelbin « comment traverser ? »     Baine   « une idee ? »
--   Jaina  gele un passage             Thrall  invoque les esprits
--
-- Thrall appelle la terre la ou Jaina gele l'eau : « Spirits of earth,
-- aid me! ». Le gouffre se franchit donc dans les deux camps, par deux
-- magies differentes.
--
-- ATTRIBUTIONS. Le journal de conversation de la video est illisible --
-- l'enregistrement est un ecran partage de 1280 pixels, chaque moitie
-- n'en fait que 640 et la police y occupe deux pixels de haut. Les
-- locuteurs viennent donc du wiki Warcraft, recoupes par le parler troll
-- de Vol'jin (« da », « dis », « dat ») qui ne trompe pas.
--
-- Seule la replique 99397 reste attribuee par deduction : cote Alliance
-- c'est l'ingenieur Gelbin qui pose la question, on donne donc le role a
-- Baine, second de la meme maniere.
--
-- Groupes 30 et 31, comme cote Alliance.
-- =====================================================================

DELETE FROM `creature_text` WHERE `CreatureID` IN (90708, 90709, 90710, 90711) AND `GroupID` BETWEEN 30 AND 31;

INSERT INTO `creature_text`
  (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`,`TextRange`,`comment`) VALUES
-- Vol'jin
(90708,30,0,'Dey be retreatin''.',                                                14,0,100,0,0,0,99393,0,'Rivage p7 Horde - Vol jin : ils battent en retraite'),
(90708,31,0,'All da Horde, get ta Thrall!',                                       14,0,100,0,0,0,99396,0,'Rivage p7 Horde - Vol jin : tous vers Thrall'),
-- Sylvanas
(90709,30,0,'That was too easy, something''s wrong.',                             14,0,100,0,0,0,99394,0,'Rivage p7 Horde - Sylvanas : trop facile'),
-- Thrall
(90711,30,0,'There, across the chasm, Gul''dan! He has Tirion!',                  14,0,100,0,0,0,99395,0,'Rivage p7 Horde - Thrall : de l autre cote du gouffre'),
(90711,31,0,'Spirits of earth, aid me!',                                          14,0,100,0,0,0,99398,0,'Rivage p7 Horde - Thrall : esprits de la terre'),
-- Baine
(90710,30,0,'Anyone have any ideas how we''re going to get across this thing?',   14,0,100,0,0,0,99397,0,'Rivage p7 Horde - Baine : comment traverser');
