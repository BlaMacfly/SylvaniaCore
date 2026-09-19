-- Silithus : separer la population de l'ancienne zone de celle de La Plaie.
--
-- Un echange de terrain ne phase PAS les creatures : PhaseShift tient trois
-- conteneurs distincts (Phases, VisibleMapIds, UiWorldMapAreaIdSwaps) et
-- PhaseShift::CanSee ne regarde que Phases. Le sol change donc sous les pieds du
-- joueur sans qu'une seule creature bouge -- d'ou les PNJ de l'ancienne Silithus
-- croises au milieu de La Plaie, alors qu'ils y sont morts.
--
-- Le pont entre les deux systemes est CONDITION_TERRAIN_SWAP (type 41), qui teste
-- GetPhaseShift().HasVisibleMapId(ConditionValue1). Aucun usage jusqu'ici.
--
-- Montage :
--   169  phase par defaut. INDISPENSABLE : UpdateUnphasedFlag ne conserve le
--        statut << sans phase >> du joueur que si DefaultReferences > 0. Sans elle,
--        le joueur perdrait ce statut et tout le decor non phase lui deviendrait
--        invisible (CanSee ne renvoie vrai entre deux objets sans phase que si les
--        DEUX le sont).
--   2392 ancienne Silithus, quand le joueur n'est PAS dans le terrain 1817.
--   2407 La Plaie, quand il y est.
--
-- Les identifiants viennent de Phase.db2, qui n'en compte que 24 : LoadAreaPhases
-- rejette tout identifiant absent de ce magasin. 2392 et 2407 y figurent et
-- n'etaient utilises nulle part chez nous.
--
-- Une seule aire suffit : PhasingHandler::OnAreaChange remonte la chaine des aires
-- parentes, donc l'aire de zone 1377 couvre toutes les sous-aires (ruches, camps...).
--
-- Annulation : /home/ubuntu/db-backups/silithus-phases-*.sql

DELETE FROM `phase_area` WHERE `AreaId` = 1377;
INSERT INTO `phase_area` (`AreaId`, `PhaseId`, `Comment`) VALUES
(1377,  169, 'Silithus - phase par defaut, preserve la visibilite du decor non phase'),
(1377, 2392, 'Silithus - ancienne zone, hors du terrain de La Plaie'),
(1377, 2407, 'Silithus - La Plaie, terrain 1817');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 26 AND `SourceEntry` = 1377;
INSERT INTO `conditions`
 (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`,
  `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`,
  `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(26, 2392, 1377, 0, 0, 41, 0, 1817, 0, 0, 1, 0, 0, '', 'Phase 2392 : ancienne Silithus, si le joueur n est PAS dans le terrain 1817'),
(26, 2407, 1377, 0, 0, 41, 0, 1817, 0, 0, 0, 0, 0, '', 'Phase 2407 : La Plaie, si le joueur est dans le terrain 1817');

-- Les creatures sans role -- ruches, Crepuscule, faune -- appartiennent a l'ancienne
-- zone. Les 145 PNJ de service (guerisseurs d'esprit, maitres de vol, donneurs de
-- quete, mascottes sauvages) restent non phases, donc visibles des deux cotes : rien
-- de ce qui rend un service ne doit disparaitre.
UPDATE `creature` c
  JOIN `creature_template` ct ON ct.`entry` = c.`id`
   SET c.`PhaseId` = 2392
 WHERE c.`map` = 1 AND c.`zoneId` = 1377 AND c.`PhaseId` = 0 AND ct.`npcflag` = 0;
