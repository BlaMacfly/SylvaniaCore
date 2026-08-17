-- =====================================================================
-- Quête 38669 « Our Last Hope » — seule quête de la campagne DH sans
-- traduction française.
--
-- Sur les 42 quêtes des cartes 1481 (Mardum) et 1468, 41 disposent déjà
-- d'une ligne frFR complète et remplie dans quest_template_locale
-- (vérifié : titres traduits, descriptions de 200 à 600 caractères,
-- objectifs renseignés). Celle-ci était la seule absente.
--
-- Source : textes officiels français relevés sur Wowhead
--   - page : https://www.wowhead.com/fr/quest=38669
--   - API  : https://nether.wowhead.com/tooltip/quest/38669?locale=2
-- Ce ne sont donc pas des traductions maison mais bien la formulation
-- Blizzard, conforme à la philosophie « blizz adaptatif ».
--
-- Rechargeable à chaud : reload locales_quest
-- =====================================================================

DELETE FROM `quest_template_locale` WHERE `ID`=38669 AND `locale`='frFR';
INSERT INTO `quest_template_locale` (`ID`,`locale`,`LogTitle`,`LogDescription`,`QuestDescription`,`VerifiedBuild`) VALUES
(38669,'frFR',
 'Notre dernier espoir',
 'Récupérez vos nouveaux Glaives de guerre.',
 'Le caveau est tombé aux mains de la Légion ardente. Cela me fait de la peine de le dire, mais tout semble perdu. Une lueur d''espoir demeure cependant… VOUS. Croyez-moi, je ne voulais vraiment pas en arriver là. Hélas, il semblerait que je n''aie pas d''autre choix. Aidez-moi, $gchasseur:chasseuse; de démons, et je vous accorderai la liberté.',
 26972);
