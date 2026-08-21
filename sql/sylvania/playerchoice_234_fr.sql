-- =====================================================================
-- Choix du compagnon (Kayn / Altruis) — texte affiché en RUSSE
--
-- Signalé en jeu : la fenêtre « На какого соратника падет ваш выбор? »
-- s'affiche en russe pour un joueur francophone.
--
-- Cause : la table `playerchoice` stocke ce texte directement en russe
-- (ChoiceId 234), et aucune ligne de localisation frFR n'existait.
-- `Player::SendPlayerChoice` lit d'abord la table de base puis l'écrase par
-- la version localisée SI elle existe :
--     displayPlayerChoice.Question = playerChoice->Question;
--     if (playerChoiceLocale)
--         ObjectMgr::GetLocaleString(playerChoiceLocale->Question, locale, ...);
-- On remplit donc les tables de localisation plutôt que d'écraser la base :
-- réversible, et sans perte pour un joueur russophone.
--
-- Traduction rédigée (aucune source officielle disponible), dans la
-- terminologie française du jeu : Kayn Chassesoleil, Altruis le Souffrant,
-- seigneur Illidan Hurlorage, la Légion, les Illidari.
-- Le balisage de couleur |cFF7a0000 ... |r et les sauts de ligne sont
-- préservés à l'identique.
--
-- SIX AUTRES CHOIX SONT ÉGALEMENT EN RUSSE et restent à traduire :
--   237, 238         — choix de gemme et d'anneau (joaillerie)
--   247, 262, 265, 280 — « quelle arme rechercher en priorité ? »,
--                        c'est-à-dire le choix d'arme prodigieuse, qui
--                        concerne TOUTES les classes
--
-- Rechargeable à chaud : reload playerchoice
-- =====================================================================

DELETE FROM `playerchoice_locale` WHERE `ChoiceId`=234 AND `locale`='frFR';
INSERT INTO `playerchoice_locale` (`ChoiceId`,`locale`,`Question`,`VerifiedBuild`) VALUES
(234,'frFR','Sur quel compagnon se portera votre choix ?',0);

DELETE FROM `playerchoice_response_locale` WHERE `ChoiceId`=234 AND `locale`='frFR';
INSERT INTO `playerchoice_response_locale` (`ChoiceId`,`ResponseId`,`locale`,`Header`,`Answer`,`Description`,`Confirmation`,`VerifiedBuild`) VALUES
(234,486,'frFR','','Kayn Chassesoleil','Kayn Chassesoleil est l''un des guerriers les plus dévoués du seigneur Illidan Hurlorage.\n\nIl est convaincu que la Légion ne peut être vaincue qu''en agissant de concert et en sacrifiant ses intérêts personnels.\n\nNoble et exigeant, il vit selon les principes d''Illidan et atteint ses objectifs quel qu''en soit le prix.\n\n|cFF7a0000 Ce choix n''aura aucune incidence sur la puissance de votre personnage.|r','CONFIRM_ARTIFACT_CHOICE',0),
(234,487,'frFR','','Altruis le Souffrant','Altruis le Souffrant est un dissident, habitué à régler seul tous les problèmes.\n\nBien qu''il partage les objectifs d''Illidan, Altruis désapprouve souvent ses méthodes.\n\nIl estime qu''Illidan a perdu le contrôle de ses pouvoirs démoniaques et que les Illidari ont besoin d''un nouveau chef.\n\n|cFF7a0000 Ce choix n''aura aucune incidence sur la puissance de votre personnage.|r','CONFIRM_ARTIFACT_CHOICE',0);
