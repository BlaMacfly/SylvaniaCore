-- =====================================================================
-- Campagne chasseur de démons — traduction française des répliques scriptées
--
-- Suite de mardum_fr_broadcast.sql. Concerne les 119 lignes de creature_text
-- des cartes 1481 (Mardum) et 1468 (Vigie brisée) qui ne portent AUCUN
-- BroadcastTextId : le pont broadcast_text_locale -> creature_text_locale ne
-- pouvait donc rien pour elles, et aucune traduction officielle n'existe
-- (vérifié : client, wago.tools tous builds, Wowhead, cores de référence).
--
-- Ces traductions sont RÉDIGÉES. Terminologie alignée sur le français
-- officiel du jeu : Illidari, Légion ardente, clé de voûte, Temple noir,
-- Langue-de-cendre, Rensang, shivarra, énergie gangrenée, vue spectrale,
-- Moteur d'âmes, reine de la couvée, Maiev Chantorage, Gul'dan, Argus.
-- Le marqueur $n (nom du joueur) est préservé partout.
--
-- Deux lignes contiennent du balisage d'interface (chemin d'icône et lien
-- de sort) : elles sont traitées en fin de fichier par substitution ciblée
-- sur le texte anglais d'origine, afin de ne toucher qu'aux mots et de
-- laisser le balisage strictement intact.
--
-- Rejouable : les lignes frFR concernées sont supprimées avant insertion.
-- Rechargeable à chaud : reload locales_creature_text
--
-- À appliquer sur dc_world :
--   mysql --default-character-set=utf8mb4 dc_world < ce_fichier.sql
-- =====================================================================

DELETE FROM `creature_text_locale` WHERE `Locale`='frFR' AND (`CreatureID`,`GroupID`,`ID`) IN (
 (90247,0,0),(90247,1,0),(92718,0,0),(92980,0,0),(92980,1,0),(92986,0,0),(92986,1,0),
 (93011,0,0),(93011,1,0),(93105,0,0),(93105,1,0),(93105,2,0),(93117,0,0),(93117,1,0),
 (93127,0,0),(93127,1,0),(93127,2,0),(93127,3,0),(93127,4,0),(93127,5,0),
 (93221,0,0),(93221,1,0),(93230,0,0),(93230,1,0),(93693,0,0),(93759,0,0),(93759,1,0),
 (93802,0,0),(93802,1,0),(93802,2,0),(94377,0,0),(94377,1,0),(94400,0,0),(94400,1,0),
 (94435,0,0),(95048,0,0),(95226,0,0),(95226,1,0),(95226,2,0),(95226,3,0),
 (96277,0,0),(96277,1,0),(96279,0,0),(96279,1,0),(96279,2,0),(96402,0,0),(96402,1,0),
 (96420,0,0),(96420,1,0),(96436,0,0),(96436,1,0),(96441,0,0),(96441,1,0),(96441,2,0),
 (96473,0,0),(96494,0,0),(96494,1,0),(96494,2,0),(96494,3,0),(96494,4,0),(96494,5,0),
 (96503,0,0),(96652,0,0),(96652,1,0),(96653,0,0),(96654,0,0),(96655,0,0),(96655,1,0),
 (96847,0,0),(97034,0,0),(97034,1,0),(97057,0,0),(97057,1,0),
 (97058,0,0),(97058,1,0),(97058,2,0),(97058,3,0),(97059,0,0),(97059,1,0),(97059,2,0),
 (97244,0,0),(97303,0,0),(97370,0,0),(97370,1,0),(97370,2,0),(97459,0,0),(97459,1,0),
 (98229,0,0),(98229,1,0),(98292,0,0),(98354,0,0),(98459,0,0),(98483,0,0),(98486,1,0),
 (98497,0,0),(98497,1,0),(98497,2,0),(98497,3,0),(98497,4,0),(98497,5,0),(98497,6,0),(98497,7,0),
 (98711,0,0),(98986,0,0),(98986,1,0),(99045,0,0),(99045,1,0),(99631,0,0),(99632,0,0),
 (99915,0,0),(99915,1,0),(99917,0,0),(99917,1,0),(99917,2,0),
 (100545,0,0),(100545,1,0),(102726,0,0),(103432,0,0),(103432,1,0));

INSERT INTO `creature_text_locale` (`CreatureID`,`GroupID`,`ID`,`Locale`,`Text`) VALUES
(90247,0,0,'frFR','Il en sera fait selon vos ordres.'),
(90247,1,0,'frFR','Langue-de-cendre, avec moi !'),
(92718,0,0,'frFR','J’aurai besoin de votre aide pour arrêter Gul’dan. Libérez les autres Illidari, vite !'),
(92980,0,0,'frFR','Pourquoi Maiev nous libérerait-elle ? Il ne peut y avoir qu’une seule raison…'),
(92980,1,0,'frFR','Les démons veulent détruire notre monde. Nous devons libérer nos alliés.'),
(92986,0,0,'frFR','La Légion est ici.'),
(92986,1,0,'frFR','Les explications attendront. Il y a des démons à tuer.'),
(93011,0,0,'frFR','Vous avez entendu le seigneur Illidan. Trouvons cette clé de voûte.'),
(93011,1,0,'frFR','Avec elle, nous pourrons envahir n’importe quel monde de la Légion, même Argus.'),
(93105,0,0,'frFR','Mes yeux… Mes yeux !'),
(93105,1,0,'frFR','Je vois vos secrets…'),
(93105,2,0,'frFR','Assez ! Mon infernal colossal vous écrasera.'),
(93117,0,0,'frFR','La douleur !'),
(93117,1,0,'frFR','Un léger contretemps. Je vous assure que cela ne se reproduira pas.'),
(93127,0,0,'frFR','La forteresse des araignées, le Moteur d’âmes et la forge sont leurs cibles prioritaires. Les Serviteurs d’Illidan doivent réussir.'),
(93127,1,0,'frFR','Nous ne tiendrons pas longtemps si ces dévastateurs ne sont pas détruits !'),
(93127,2,0,'frFR','Enseignez-nous ce que vous avez appris, $n.'),
(93127,3,0,'frFR','Je la sens courir dans mes veines. Elle transforme mon corps.'),
(93127,4,0,'frFR','Non… Mannethrel.'),
(93127,5,0,'frFR','Allez, montons là-haut !'),
(93221,0,0,'frFR','Ils vont mourir.'),
(93221,1,0,'frFR','Vous ne survivrez pas au pic Infernal…'),
(93230,0,0,'frFR','Si faible… j’ai du mal à contenir… mon énergie.'),
(93230,1,0,'frFR','J’ai bien failli perdre le combat contre l’énergie gangrenée qui est en moi.'),
(93693,0,0,'frFR','Une belle mission pour les Rensang. J’approuve.'),
(93759,0,0,'frFR','Je sens en vous une puissance accrue, $n. Auriez-vous dérobé l’essence d’un démon ?'),
(93759,1,0,'frFR','Utilisez le creuset pour achever le rituel.'),
(93802,0,0,'frFR','Venez, mes enfants. Repaissez-vous de nos ennemis.'),
(93802,1,0,'frFR','Nul ne résiste à mon baiser.'),
(93802,2,0,'frFR','Seigneur Sargeras, non !!!'),
(94377,0,0,'frFR','Je… ne céderai… pas !'),
(94377,1,0,'frFR','On ne me fera plus jamais prisonnière. Jamais !'),
(94400,0,0,'frFR','Je vais tous vous détruire.'),
(94400,1,0,'frFR','Je tuerai jusqu’au dernier démon sur ma route.'),
(94435,0,0,'frFR','Ce sera fait. Je vous invite à ne pas oublier que le Temple noir est attaqué.'),
(95048,0,0,'frFR','Occupe-toi de ces insectes, Beliash.'),
(95226,0,0,'frFR','Je vais ouvrir votre chair et me repaître de votre âme.'),
(95226,1,0,'frFR','Ici, c’est vous la proie.'),
(95226,2,0,'frFR','Je suis votre juge, votre jury et votre bourreau.'),
(95226,3,0,'frFR','Dans ma cage, et plus vite que ça.'),
(96277,0,0,'frFR','Je vais vous démembrer.'),
(96277,1,0,'frFR','Pour la Légion !'),
(96279,0,0,'frFR','Votre âme sera mienne.'),
(96279,1,0,'frFR','Dans ma cage, et plus vite que ça.'),
(96279,2,0,'frFR','Si pressé d’être asservi.'),
(96402,0,0,'frFR','Pitoyable.'),
(96402,1,0,'frFR','Mourez dans la gloire du combat !'),
(96420,0,0,'frFR','Ils sont dix fois plus nombreux que nous. Pouvons-nous vraiment les vaincre ?'),
(96420,1,0,'frFR','Encore… Je veux plus de puissance !'),
(96436,0,0,'frFR','$n, voulez-vous poser votre vue spectrale sur l’entrée de la grotte ? Quelque chose cloche.'),
(96436,1,0,'frFR','Ils ne nous échapperont pas. Illidari, à l’attaque !'),
(96441,0,0,'frFR','Ma hache ne manque jamais sa cible.'),
(96441,1,0,'frFR','Maudite soit votre vue spectrale !'),
(96441,2,0,'frFR','J’aurais anéanti vos forces…'),
(96473,0,0,'frFR','Ils ont la vue spectrale !'),
(96494,0,0,'frFR','Pour la Légion !'),
(96494,1,0,'frFR','La gangrefeu que vous maniez ne suffira pas.'),
(96494,2,0,'frFR','Des chasseurs de démons ? Comment êtes-vous arrivés ici ?'),
(96494,3,0,'frFR','Meurs, imbécile d’Illidari.'),
(96494,4,0,'frFR','Vous osez nous attaquer ici ?!'),
(96494,5,0,'frFR','Des intrus. Prévenez la reine de la couvée !'),
(96503,0,0,'frFR','Merci à vous. Venez, mes frères… retournons au combat !'),
(96652,0,0,'frFR','$n, attendez… je n’arrive pas à contenir cette puissance.'),
(96652,1,0,'frFR','Aaaaggggghhhhh !'),
(96653,0,0,'frFR','Bonne chance à vous tous. Je me charge de faire monter les autres, $n.'),
(96654,0,0,'frFR','$n, vous avez réussi à passer !'),
(96655,0,0,'frFR','Aux dernières nouvelles, Kor’vas taillait tout en pièces sur le pont.'),
(96655,1,0,'frFR','L’énergie démoniaque… Je me sens plus redoutable.'),
(96847,0,0,'frFR','J’espère que Maiev a eu raison de vous libérer, chasseur de démons. Allez-y, je tiens la ligne.'),
(97034,0,0,'frFR','Je vis pour servir.'),
(97034,1,0,'frFR','Ma lame vous transpercera.'),
(97057,0,0,'frFR','Elle vous plaît, ma nouvelle épée ? Approchez donc.'),
(97057,1,0,'frFR','Stupides petites choses…'),
(97058,0,0,'frFR','Mon essaim se repaîtra de votre âme !'),
(97058,2,0,'frFR','Tyranna… à l’aide.'),
(97058,3,0,'frFR','Parfait, encore une âme pour mon moteur.'),
(97059,0,0,'frFR','La couvée de ma reine va bientôt éclore.'),
(97059,1,0,'frFR','Ils m’ont tué, ma reine…'),
(97244,0,0,'frFR','Prenez la clé de voûte ! Filons au portail en contrebas et rentrons au Temple noir !'),
(97303,0,0,'frFR','Vite, $n. Utilisez la clé de voûte pour activer le portail. Nous devons rejoindre le combat au Temple noir.'),
(97370,0,0,'frFR','Vous ne les aurez pas. Ils sont à moi !'),
(97370,1,0,'frFR','Mon feu ne laissera de vous que des os.'),
(97370,2,0,'frFR','Impossible !'),
(97459,0,0,'frFR','Mes forces sont décimées. Je vous ai fait défaut.'),
(97459,1,0,'frFR','Je jure de donner ma vie s’il le faut.'),
(98229,0,0,'frFR','Activez les trois passerelles et invoquez le reste de nos forces.'),
(98229,1,0,'frFR','Je vais me frayer un chemin dans les démons et vous retrouver dans le volcan.'),
(98292,0,0,'frFR','Tuez-les tous !'),
(98354,0,0,'frFR','Je viens avec vous. Allons tuer encore quelques démons.'),
(98459,0,0,'frFR','Vous savez, c’est moi qui devrais commander.'),
(98483,0,0,'frFR','De la bonne viande à croquer pour moi.'),
(98486,1,0,'frFR','Nous purifierons l’univers par le feu.'),
(98497,0,0,'frFR','J’ai si faim.'),
(98497,1,0,'frFR','Mon repas vient à moi.'),
(98497,2,0,'frFR','Venez, mes petits diablotins, dansez pour maman.'),
(98497,3,0,'frFR','Mes enfants vous cuisineront à point.'),
(98497,4,0,'frFR','La victoire de la Légion est inévitable, mon enfant.'),
(98497,5,0,'frFR','Je vous livrerai à Tyranna moi-même.'),
(98497,6,0,'frFR','Sale petit elfe. Je sens le goût de la gangrefeu sur vous.'),
(98497,7,0,'frFR','Des intrus ! Que quelqu’un prévienne le commandant funeste !'),
(98711,0,0,'frFR','La mère des diablotins est dans cette grotte, juste là.'),
(98986,0,0,'frFR','Mes secrets gangrenés vous dévoreront !'),
(98986,1,0,'frFR','Ils volent nos secrets, ma reine…'),
(99045,0,0,'frFR','Quel que soit votre choix, ce sera un plaisir de retourner davantage de la puissance de la Légion contre elle.'),
(99045,1,0,'frFR','Je pourrais détruire la Légion à moi seule !'),
(99631,0,0,'frFR','Je suis réveillé ? Comment est-ce possible ?'),
(99632,0,0,'frFR','Combien d’années ai-je perdues dans cette cellule ?'),
(99915,0,0,'frFR','$n, nous avons un énorme problème.'),
(99915,1,0,'frFR','Votre sacrifice ne sera PAS vain !'),
(99917,0,0,'frFR','$n, vite ! Vous n’avez pas beaucoup de temps.'),
(99917,1,0,'frFR','Sevis baisse les yeux vers le mystique brisé, agonisant.'),
(99917,2,0,'frFR','Je vous retrouverai à la dernière passerelle.'),
(100545,0,0,'frFR','Pour le seigneur Illidan !'),
(100545,1,0,'frFR','Merci, $n. Je retourne au combat.'),
(102726,0,0,'frFR','Ils ont la vue spectrale !'),
(103432,0,0,'frFR','Je vais vous démembrer.'),
(103432,1,0,'frFR','Pour la Légion !');

-- Les deux lignes à balisage d'interface : on ne substitue que les mots,
-- le chemin d'icône et le lien de sort restent strictement intacts.
INSERT INTO `creature_text_locale` (`CreatureID`,`GroupID`,`ID`,`Locale`,`Text`)
SELECT ct.`CreatureID`, ct.`GroupID`, ct.`ID`, 'frFR',
       REPLACE(REPLACE(ct.`Text`, 'begins to cast', 'commence à lancer'),
               '[Carrion Storm]', '[Tempête de charogne]')
FROM `creature_text` ct WHERE ct.`CreatureID`=97058 AND ct.`GroupID`=1 AND ct.`ID`=0;

INSERT INTO `creature_text_locale` (`CreatureID`,`GroupID`,`ID`,`Locale`,`Text`)
SELECT ct.`CreatureID`, ct.`GroupID`, ct.`ID`, 'frFR',
       REPLACE(REPLACE(REPLACE(ct.`Text`, 'Nearby', 'Les'),
               '[Spider Eggs]', '[Œufs d’araignée]'),
               'will hatch soon if not destroyed!.', 'proches vont bientôt éclore s’ils ne sont pas détruits !')
FROM `creature_text` ct WHERE ct.`CreatureID`=97059 AND ct.`GroupID`=2 AND ct.`ID`=0;

-- Dernière option de gossip de la zone sans traduction : elle n'a aucun
-- OptionBroadcastTextId, elle échappait donc aussi au pont. Ajoutée à la main.
INSERT INTO `gossip_menu_option_locale` (`MenuId`,`OptionIndex`,`Locale`,`OptionText`,`BoxText`) VALUES
(18776,0,'frFR','Whitemoon, je vais vous emprunter une de vos chauves-souris gangrenées. Nous allons chercher ce pour quoi nous sommes venus.','')
ON DUPLICATE KEY UPDATE `OptionText`=VALUES(`OptionText`);
