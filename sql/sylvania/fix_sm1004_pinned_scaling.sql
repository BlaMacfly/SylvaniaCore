-- Fix scaling : Monastère Écarlate (map 1004) — créatures épinglées rendues scalantes
-- (hexp=4 mais plage perdue => figées pendant que trash/boss scalent => "60 niveaux d écart")
--   59893 Empowering Spirit 100-101 (x18 adds) ; 60106 Durand aux 90 ;
--   60107 Dashing Strike Stalker 90 ; 64827 Hooded Crusader 42
-- Fix : plage 33..92 (celle des boss rank3 Korloff/Durand60040/Thalnos qui marchent).
-- NON touché : 3977 Whitemane & 4542 Fairbanks = entrées vanilla partagées map 189.
-- 2026-06-19 | Rollback : 59893->100/101 ; 60106,60107->90/90 ; 64827->42/42
UPDATE creature_template SET minlevel=33, maxlevel=92 WHERE entry IN (59893,60106,60107,64827);
