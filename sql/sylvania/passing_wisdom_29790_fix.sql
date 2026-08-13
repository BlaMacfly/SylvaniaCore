-- =====================================================================
-- Île Vagabonde — quête « Transmission de sagesse » (29790) RÉPARÉE
--
-- Bug TrinityCore connu et JAMAIS corrigé publiquement
-- (cf. issue #22243, fermée sans solution) : en acceptant la quête,
-- Maître Shang Xi disparaît, aucun dialogue ne se lance, la quête est
-- impossible à terminer.
--
-- Diagnostic (sondes temporaires dans SmartAI/SmartScript + .debug phase) :
--   1. PHASE — le PNJ de la scène (56686) est invoqué par le PNJ donneur
--      (55672, PhaseId 1527). Or accepter la quête FAIT PERDRE 1527 au
--      joueur (phase_area : 1527 = "avant que 29790 soit prise"), qui ne
--      garde que 1327 (phase de zone). Le PNJ invoqué héritait donc d'une
--      phase que le joueur venait de quitter -> créé mais INVISIBLE.
--      Mesuré : summon=OK, cibleVoitSummon=NON, phasesSummon=1527,
--      phasesCible=1327.
--   2. DIALOGUES — répliques et sons ciblaient « invocateur » (7) ou
--      « propriétaire/invocateur » (23) : ces cibles ne se résolvent pas
--      dans les listes d'actions différées (source_type 9) -> muet.
--   3. CRÉDIT — le sort « Planting Stave Credit » (106625, crédit du PNJ
--      56688 = l'objectif) ciblait 23 (idem) ET s'exécutait au même
--      instant que la disparition du PNJ.
--
-- Correctifs ci-dessous. Validé en jeu : PNJ visible, 6 répliques jouées,
-- objectif validé, quête rendable.
-- =====================================================================

-- 1) Donneur : retirer la phase AVANT d'invoquer, puis laisser le JOUEUR
--    invoquer (il doit être l'invocateur pour la suite de la scène).
UPDATE `smart_scripts` SET `action_type`=44, `action_param1`=1527, `action_param2`=0, `action_param3`=0,
  `comment`='Master Shang - On Accepted Quest - Remove Phase 1527 (AVANT invocation)'
WHERE `entryorguid`=55672 AND `source_type`=0 AND `id`=0;

UPDATE `smart_scripts` SET `action_type`=85, `action_param1`=106623, `action_param2`=2, `action_param3`=0,
  `action_param4`=0, `action_param5`=0, `action_param6`=0,
  `comment`='Master Shang - On Accepted Quest - Invoker Cast Summon Master Shang Xi'
WHERE `entryorguid`=55672 AND `source_type`=0 AND `id`=1;

-- 2) PNJ invoqué : forcer sa phase sur celle du joueur (1327), sinon invisible.
DELETE FROM `smart_scripts` WHERE `entryorguid`=56686 AND `source_type`=0 AND `id` IN (16,17);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(56686,0,16,0,54,0,100,0,0,0,0,0,44,1527,0,0,0,0,0,1,0,0,0,0,0,0,0,'Master Shang (summoned) - Just Summoned - Remove inherited phase 1527'),
(56686,0,17,0,54,0,100,0,0,0,0,0,44,1327,1,0,0,0,0,1,0,0,0,0,0,0,0,'Master Shang (summoned) - Just Summoned - Set phase 1327 (= phase du joueur, sinon invisible)');

-- 3) Dialogues et sons : cibler le PNJ lui-même (les cibles 7/23 ne se
--    résolvent pas en liste d'actions différée).
UPDATE `smart_scripts` SET `target_type`=1
WHERE `action_type` IN (1,4)
  AND ((`entryorguid`=56686 AND `source_type`=0)
    OR (`entryorguid` IN (5668600,5668601,5668602,5668603) AND `source_type`=9));

-- 4) Crédit de quête : attribution directe (KilledMonster) au joueur le
--    plus proche, et disparition repoussée de 3 s pour ne pas la couper.
UPDATE `smart_scripts` SET `action_type`=33, `action_param1`=56688, `action_param2`=0,
  `target_type`=21, `target_param1`=50,
  `comment`='Master Shang - Credit direct de la quete (KilledMonster 56688) sur le joueur le plus proche'
WHERE `entryorguid`=5668603 AND `source_type`=9 AND `id`=5;

UPDATE `smart_scripts` SET `event_param1`=3000,
  `comment`='Master Shang - Despawn (3s apres le credit)'
WHERE `entryorguid`=5668603 AND `source_type`=9 AND `id`=6;
