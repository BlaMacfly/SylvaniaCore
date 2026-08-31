-- =====================================================================
-- Aubergiste du port de Hurlevent — phase manquante
--
-- Spawn cree en jeu par `.npc add 6727` (Innkeeper Brianna) a
-- (-8296.06, 1388.89, 4.95), aire 4411 « Port de Hurlevent ».
--
-- La commande a enregistre la ligne SANS phase, alors que `phase_area`
-- place tout joueur de cette aire en 6666 « Pre-Broken Shore Stormwind
-- Harbor » (et 13306 pour la rampe). PhaseShift::CanSee exigeant une
-- intersection, la creature etait invisible a tout joueur normal, et
-- visible en mode MJ seulement -- SetAlwaysVisible court-circuitant le
-- test de phase.
--
-- La cause est corrigee dans le core (cs_npc.cpp) : les prochains
-- `.npc add` conserveront la phase. Cette ligne repare le spawn deja
-- pose, pour ne pas avoir a le recreer.
--
-- 6666 et non 13306 : l'aubergiste est sur le quai, pas sur la rampe,
-- et c'est la phase que portent les 371 autres creatures de cette aire.
-- =====================================================================

UPDATE `creature`
   SET `PhaseId` = 6666
 WHERE `guid` = 290200759
   AND `id` = 6727
   AND `PhaseId` = 0;
