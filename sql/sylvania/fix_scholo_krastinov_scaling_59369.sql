-- ============================================================
-- Fix scaling : Doctor Theolen Krastinov (creature 59369) — Scholomance (map 1007)
-- Bug : minlevel=91 maxlevel=91 => boss épinglé à 91, ne scale pas vers le joueur
--       (trash voisin = 41-90 => ~57). Les 3 autres boss rank3 (Jandice 59184,
--       Rattlegore 59153, Chillheart 58633) = 43-92. Krastinov avait perdu sa borne basse.
-- Fix : aligner sur la plage des boss frères -> 43..92 (scale down au joueur).
-- Date : 2026-06-19  | Rollback : minlevel=91,maxlevel=91
-- ============================================================
UPDATE creature_template SET minlevel=43, maxlevel=92 WHERE entry=59369;
