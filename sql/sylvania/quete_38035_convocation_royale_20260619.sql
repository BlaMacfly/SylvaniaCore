-- =====================================================================
-- Quete 38035 "A Royal Summons" / "Une convocation royale"
-- Intro Bruleciel (Skyfire) cote Hurlevent - scenario Rive Brisee.
-- Bug: les 2 objectifs (credit PNJ 96663 "Skyfire boarded" +
--      96644 "Royal Summons read") n'ont AUCUN mecanisme
--      (96663 non spawne, 0 script/areatrigger/spell) -> quete bloquee.
-- Fix: Sky Admiral Rogers (96644) passe en SmartAI et credite les
--      2 objectifs a l'acceptation de la quete -> completion instantanee,
--      rendu immediat a Rogers. ScriptName d'origine de 96644 = vide.
-- Date: 2026-06-19
-- =====================================================================

UPDATE creature_template SET ScriptName='SmartAI' WHERE entry=96644;

DELETE FROM smart_scripts WHERE entryorguid=96644 AND source_type=0;
INSERT INTO smart_scripts
(entryorguid, source_type, id, link, event_type, event_phase_mask, event_chance, event_flags,
 event_param1, event_param2, event_param3, event_param4, event_param5,
 action_type, action_param1, action_param2, action_param3, action_param4, action_param5, action_param6,
 target_type, target_param1, target_param2, target_param3, target_x, target_y, target_z, target_o, comment) VALUES
(96644,0,0,0,19,0,100,0, 38035,0,0,0,0, 33,96663,0,0,0,0,0, 7,0,0,0,0,0,0,0, 'A Royal Summons - on quest accept: credit Skyfire boarded (96663)'),
(96644,0,1,0,19,0,100,0, 38035,0,0,0,0, 33,96644,0,0,0,0,0, 7,0,0,0,0,0,0,0, 'A Royal Summons - on quest accept: credit Royal Summons read (96644)');
