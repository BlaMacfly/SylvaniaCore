-- =====================================================================
-- « Arrêtez Gul'dan ! » proposée en double — quêtes jumelles de spé
--
-- Signalé en jeu, à répétition : Maiev propose DEUX fois la même quête.
--
-- 38723 et 40253 portent le même titre, le même prérequis (38690), le
-- même tri (-407) et sont ouvertes à TOUTES les races
-- (AllowableRaces = 0xFFFFFFFFFFFFFFFF). Rien, absolument rien dans les
-- données ne les départageait : les deux étaient donc offertes ensemble.
--
-- Ce ne sont PAS des variantes Horde / Alliance, malgré le nom trompeur
-- des constantes du core (QUEST_STOP_GULDAN_H / _A). Le même fichier les
-- nomme correctement plus bas :
--     QUEST_STOP_GULDAN_DMG_SPEC  = 38723,   -> Dévastation
--     QUEST_STOP_GULDAN_TANK_SPEC = 40253,   -> Vengeance
-- Ce sont des jumelles de SPÉCIALISATION.
--
-- Pourquoi une modification du moteur a été nécessaire
-- Le gestionnaire de conditions n'avait aucun moyen de tester la
-- spécialisation d'un joueur. Le contournement évident — tester un sort
-- caractéristique de chaque spé — ne tient pas debout ici : les sorts de
-- spécialisation ne sont quasiment pas enseignés sur ce serveur (les
-- trois Chasseurs de démons existants ne connaissent que Morsure de
-- démon ; celui de niveau 98 n'a même pas sa Métamorphose). Une
-- condition bâtie là-dessus aurait masqué les DEUX quêtes.
-- CONDITION_SPECIALIZATION (53) a donc été ajoutée au core, et elle lit
-- directement `Player::GetPrimarySpecialization()`.
--
-- Choix de formulation : la quête Vengeance exige la spé Vengeance ; la
-- quête Dévastation exige de NE PAS être Vengeance, au lieu d'exiger
-- Dévastation. Ainsi il y a TOUJOURS exactement une quête proposée, même
-- pour un personnage dont la spécialisation serait à zéro ou inattendue.
-- Un doublon est agaçant ; zéro quête serait bloquant.
--
-- Ce n'est pas un cas isolé : le serveur compte 1488 paires de quêtes
-- homonymes partageant prérequis et races. La nouvelle condition servira
-- ailleurs.
--
-- Rechargeable à chaud : reload conditions (après redémarrage du binaire)
-- =====================================================================

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=19 AND `SourceEntry` IN (38723,40253);
INSERT INTO `conditions`
 (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,
  `ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,
  `NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(19,0,40253,0,0, 53,0,581,0,0, 0,0,0,'', 'Arretez Guldan ! version Vengeance - uniquement si spe Vengeance (581)'),
(19,0,38723,0,0, 53,0,581,0,0, 1,0,0,'', 'Arretez Guldan ! version Devastation - uniquement si spe PAS Vengeance');
