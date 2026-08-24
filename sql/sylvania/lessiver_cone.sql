-- =====================================================================
-- « Lessiver » (Wash Away) — le jet d'eau de la Sagesse de Mari
-- frappait aussi les joueurs placés DERRIÈRE le boss.
--
-- Signalé en jeu : « il me fait des dégâts même si je suis derrière le
-- rayon d'eau, comme s'il y avait des dégâts de zone autour du boss ».
--
-- CE QUE DISENT LES DONNÉES OFFICIELLES (DB2, build 7.3.5.26972)
--   106329  la canalisation ; son effet 1 est un « script côté serveur »,
--           c'est-à-dire une logique Blizzard jamais distribuée ;
--   106331  l'aura posée sur le boss, qui déclenche 106334 toutes
--           les 250 ms ;
--   106334  LES DÉGÂTS RÉELS : école Givre, recul 200, rayon 60 m,
--           drapeau « ignore la ligne de vue », ciblage implicite 110.
--
--   SpellTargetRestrictions, ligne 7514 : ConeDegrees = 12
--   SpellRadius, ligne 48              : Radius = 60
--   => le jet officiel est un cône FRONTAL de 12° sur 60 mètres.
--
-- POURQUOI ÇA DÉBORDAIT
-- Le cœur classe correctement la cible 110 en cône, mais l'ouverture
-- vient de `SpellInfo::ConeAngle`, alimenté par une entrée DB2
-- facultative — `ConeAngle = _target ? _target->ConeDegrees : 0.f`.
-- Et le mode de contrôle associé, TARGET_CHECK_ENTRY, ne filtre sans
-- `conditions` NI l'hostilité NI la position. Toute la forme du jet
-- tenait donc à cette unique valeur.
--
-- Le script C++ `spell_wise_mari_wash_away` réimpose les 12° officiels
-- en dur et rétablit le contrôle d'hostilité. Cette ligne le rattache
-- au sort ; sans elle, le script existe mais ne s'exécute jamais.
--
-- Rechargeable à chaud : reload spell_script_names (puis reload spell_proc)
-- =====================================================================

DELETE FROM `spell_script_names` WHERE `spell_id`=106334;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(106334, 'spell_wise_mari_wash_away');
