-- =====================================================================
-- Campagne chasseur de démons — traduction française des textes diffusés
--
-- Constat établi par mesure : les 57 textes diffusés utilisés par les PNJ
-- des cartes 1481 (Mardum) et 1468 (Vigie brisée) n'ont AUCUNE ligne de
-- traduction, dans AUCUNE langue. Ce sont des entrées de l'ère Legion
-- (identifiants > 90 000), absentes de broadcast_text_locale chez nous,
-- absentes du BroadcastText.db2 du client (qui n'en stocke que 3 869),
-- absentes de wago.tools pour tous les builds, et non exposées par Wowhead
-- (l'URL broadcast-text= renvoie 404). Aucune source officielle n'existe.
--
-- Ces 55 traductions sont donc RÉDIGÉES, pas relevées. C'est un écart
-- assumé au « blizz adaptatif » : entre du français écrit par nous et de
-- l'anglais à l'écran, le premier sert mieux l'intention.
--
-- Terminologie alignée sur le français officiel du jeu : Illidari, Légion
-- ardente, chasseur de démons, clé de voûte sargérite, Néant distordu,
-- Temple noir, Gardiennes, vue spectrale, énergie gangrenée, Moteur d'âmes,
-- Forge de la corruption, Rive en fusion, Faux des âmes, Tome des secrets
-- gangrenés, et les noms de PNJ tels qu'ils s'affichent en jeu (Sevis
-- Viveflamme, Kayn Chassesoleil, Altruis le Souffrant, Allari la Mangeuse
-- d'âmes, Cyana Lamenocturne, Jace Sombretisseur, Kor'vas Sang-d'épine,
-- Mannethrel Sombreastre).
--
-- Les marqueurs du jeu sont préservés à l'identique : $n (nom du joueur),
-- $B (saut de ligne), $g x:y; (variante selon le genre).
--
-- Les répliques dont le genre du locuteur est inconnu sont tournées de
-- façon à éviter tout accord (ex. « je ferai tout ce qu'il faudra »).
--
-- La colonne remplie suit l'original : Text_lang si l'entrée anglaise a un
-- Text, Text1_lang si elle a un Text1 — d'où le CASE plutôt que des valeurs
-- en dur.
--
-- Effet en chaîne : ces textes alimentent à la fois le corps des dialogues
-- (via npc_text), les options de gossip et une partie des répliques
-- scriptées. Relancer ensuite pont_traductions_broadcast.sql pour propager
-- vers gossip_menu_option_locale et creature_text_locale.
--
-- À appliquer sur dc_hotfixes :
--   mysql --default-character-set=utf8mb4 dc_hotfixes < ce_fichier.sql
-- =====================================================================

DROP TEMPORARY TABLE IF EXISTS `tmp_fr`;
CREATE TEMPORARY TABLE `tmp_fr` (`id` INT PRIMARY KEY, `fr` TEXT) CHARACTER SET utf8mb4;

INSERT INTO `tmp_fr` (`id`,`fr`) VALUES
(92162, 'J’attends vos ordres, $g monsieur:madame;.'),
(94883, 'Ahahahahaha ! Je vais vous tailler en pièces.'),
(95397, 'Je vous vois, $n. Quel est le plan ?'),
(96307, 'Oui ? Que puis-je pour vous, $n ?'),
(96441, '$n, par ici.'),
(96676, 'Bonne chance. Je rejoindrai le point d’ancrage dès que j’en aurai fini avec ce démon.'),
(97901, 'La mort approche.'),
(97902, 'Goûtez à ma lame.'),
(97903, 'Chassez donc ça, pour voir.'),
(97904, 'Pitoyable.'),
(97905, 'Mourez dans la gloire du combat !'),
(97906, 'Pour Tyranna !'),
(97907, 'Je vais vous détruire, petit chasseur de démons.'),
(98385, 'Seigneur de guerre, vos forces prendront d’assaut la Forteresse funeste, au sud-est. Empêchez le gros de leurs démons de nous attaquer.'),
(98555, 'Madame, vous emmènerez vos nagas au nord. Interrompez le rituel que les démons accomplissent à leur Moteur d’âmes.'),
(98562, 'Mère matrone, menez vos shivarra de l’autre côté du gouffre, jusqu’à la Forge de la corruption. Faites-les souffrir.'),
(98759, 'Je vis pour servir.'),
(98760, 'Ma vie pour la Légion.'),
(98761, 'Vous n’aurez pas la clé de voûte.'),
(98762, 'La reine de la couvée Tyranna ordonne votre mort.'),
(98763, 'Ma lame vous transpercera.'),
(98764, 'Vous êtes surclassé et en infériorité numérique.'),
(98765, 'C’est ici que vous mourrez.'),
(98766, 'Nous purifierons l’univers par le feu.'),
(98916, 'Beaucoup se sont opposés à lui, mais Illidan avait raison depuis le début. Nous sommes les armes qui abattront la Légion ardente.'),
(98960, 'Il y a des éons, Sargeras créa Mardum pour y emprisonner les démons. Il forgea aussi la clé de voûte sargérite pour les y enfermer.  Mais lorsque le Titan décida de réduire toute la création en cendres, il brisa Mardum et en dispersa les fragments à travers le Néant distordu. Ainsi naquit la Légion ardente.  Sargeras mit sa clé de voûte à l’abri sur ce fragment précis. C’est un passe-partout : elle ouvre l’accès à n’importe quel monde de la Légion. Et c’est aussi la clé du plan du seigneur Illidan pour anéantir la Légion.'),
(99020, '$n, j’ai capturé quelques chauves-souris gangrenées. Elles seront prêtes quand vous déciderez de vous envoler vers ce vaisseau de commandement de la Légion.'),
(99834, 'Mieux vaut sans doute que je reste ici, au point d’ancrage. Mes blessures de captivité, en bas, ne sont pas encore refermées.  Ce monde déborde d’énergie démoniaque. J’ai de plus en plus de mal à contenir ma propre puissance gangrenée.'),
(99855, 'Pendant des années, nous avons été rejetés, bannis par les Gardiennes dans les profondeurs les plus sombres du monde.   Aujourd’hui, nous devons relever le défi le plus rude que notre monde ait jamais connu. Aujourd’hui, nous devons défendre Azeroth contre ses pires ennemis.'),
(100342, 'J’utilise la Faux des âmes pour interroger ces démons, mais ils ignorent tout de l’emplacement de la clé de voûte sargérite.  Ils ne font que répéter leur allégeance à une quelconque reine.  Cyana et Jace ont pris de l’avance. Hélas, je crois que Cyana s’est fait capturer en tentant de secourir d’autres de nos chasseurs de démons.  Il y a quelque chose qui cloche chez elle…'),
(100733, 'Notre objectif premier ici, c’est de mettre la main sur la clé de voûte sargérite.  Il faut en finir en bas et monter jusqu’au centre de commandement volant de Tyranna.'),
(100734, 'Allari, voici les secrets que j’ai mis au jour.'),
(100737, 'Je ne sais pas pour vous, mais je ferai tout ce qu’il faudra pour survivre.  Ce qu’il nous faut, c’est plus de puissance !'),
(100738, 'Écoutez bien, Cyana. Voici ce que j’ai appris du Tome des secrets gangrenés.'),
(100749, 'Si le Temple noir n’était pas attaqué, cela ne me dérangerait pas de rester ici plus longtemps.  Il y a tant de démons à tuer.'),
(100750, 'Êtes-vous prête à apprendre les secrets de la Légion, Kor’vas ?'),
(100752, 'Mannethrel, préparez-vous. Je vais vous emplir de la puissance des secrets de la Légion.'),
(101473, 'Autre chose ?'),
(101616, 'Ils se comportent comme des enfants.$B$BCela dit, je m’y attendais. Autant qu’ils règlent leurs différends maintenant.'),
(101647, '<Le mystique brisé s’accroche à peine à la vie.>  Je suis déjà mort. Faites… ce qui… doit être fait.'),
(101648, 'Mystique, merci pour votre sacrifice.'),
(101649, '<Le corps du mystique Langue-de-cendre gît ici, privé de son âme, qui a alimenté la passerelle de la Légion.>'),
(101650, 'La reine de la couvée a dû faire quelque chose à cette passerelle. Même les âmes de plusieurs mo’arg n’ont pas suffi à la déverrouiller.  L’âme d’un chasseur de démons, en revanche, ferait l’affaire. Vous avez un choix à faire, $n…  … L’un de nous deux doit mourir.'),
(101651, 'Sevis, je dois vous sacrifier pour alimenter la dernière passerelle.'),
(101652, 'Je veux que vous me sacrifiiez pour alimenter la passerelle.'),
(101654, '<Sevis a payé le prix ultime pour que vous puissiez utiliser la passerelle de la Légion et invoquer vos forces shivarra.>  <Ne laissez pas son sacrifice avoir été vain.>'),
(101656, 'Bien des âmes ont été sacrifiées ici. L’activateur est alimenté.'),
(101657, 'Je pars devant retrouver Allari.'),
(103080, 'Le creuset ? C’est un dispositif qui permet d’épier autrui ou de communiquer sur de grandes distances.  On peut même s’en servir pour contacter d’autres dimensions.  Il se nourrit d’énergie gangrenée. Plus la cible est lointaine, plus le rituel exige d’énergie.'),
(103349, 'Je vous retrouverai en bas, à la passerelle de la Rive en fusion.'),
(103959, '$n, je crois qu’il y a quelque chose de très puissant dans cette grotte. Mais l’immense énergie gangrenée qui imprègne Mardum m’empêche d’en être certain. Ma vision est trouble.  S’il y a bien quelque chose là-dedans, nous ne pouvons pas nous permettre de l’ignorer. Votre maîtrise de la vue spectrale surpasse celle de tous, hormis le seigneur Illidan.  Voulez-vous tourner votre vue spectrale vers la grotte et confirmer mes soupçons ?'),
(103960, 'Oui, Jace, je vais utiliser ma vue spectrale pour sonder la grotte.'),
(104587, 'Sera-ce Kayn ou Altruis ?'),
(104592, 'Il y a bien des années, du temps où le seigneur Illidan régnait sur le Temple noir, Altruis le Souffrant s’est détourné de notre chef et des chasseurs de démons.$B$BConvaincu qu’Illidan était devenu ce qu’il haïssait le plus, Altruis a lancé une sinistre campagne pour orchestrer la chute de notre maître.$B$BIl a joué un rôle décisif dans la mort de quatre de nos camarades : Alandien, Theras, Netharel et Varedis.$B$BC’étaient nos maîtres, nos frères et nos sœurs.$B$BPour cela, je ne peux pas lui pardonner.'),
(104596, 'Kayn a toujours été un soldat loyal, un chef intrépide et un stratège hors pair.$B$BMais je crois que sa loyauté envers Illidan l’a aveuglé.$B$BÀ mesure que la puissance d’Illidan grandissait, il perdait le contrôle face à l’énergie démoniaque qu’il avait absorbée.$B$BJe savais que mes actes pourraient passer pour une trahison, mais je n’ai fait que ce qui me semblait juste.$B$BAujourd’hui, Kayn s’engage sur la même voie. Un tel homme ne devrait pas diriger les Illidari.');

DELETE FROM `broadcast_text_locale`
 WHERE `locale`='frFR' AND `ID` IN (SELECT `id` FROM `tmp_fr`);

INSERT INTO `broadcast_text_locale` (`ID`,`locale`,`Text_lang`,`Text1_lang`,`VerifiedBuild`)
SELECT t.`id`, 'frFR',
       CASE WHEN bt.`Text`  IS NOT NULL AND bt.`Text`  <> '' THEN t.`fr` ELSE '' END,
       CASE WHEN bt.`Text1` IS NOT NULL AND bt.`Text1` <> '' THEN t.`fr` ELSE '' END,
       0
FROM `tmp_fr` t
JOIN `broadcast_text` bt ON bt.`ID` = t.`id`;

DROP TEMPORARY TABLE `tmp_fr`;
