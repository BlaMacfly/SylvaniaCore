-- ============================================================================
-- CORRECTIF qualite — retrait de 13 rendeurs REDONDANTS (doublons), 2026-06-14.
-- Suite a l'audit multi-enders : batch3/4 testaient "cet id d'ender precis non
-- spawne" sans verifier "AUCUN ender de la quete spawne". Resultat : 13 spawns
-- ou un ENDER-FRERE (souvent une entry phasee consecutive) etait deja present
-- SUR LA MEME MAP et rendait deja la quete livrable => doublon visible inutile.
-- (Filtre strict "no ender spawned" applique depuis batch5.)
--
-- Pour chaque guid : id retire -> ender-frere deja spawne qui couvre la quete :
--   280000283 Jarod 94977          -> 92850 @1220  (Kur'talos Ravencrest)
--   280000285 Altruis 101927       -> 89362 @1220  (Dark Revelations / Into the Fray)
--   280000302 Kirin Tor Magus 80193-> 79393 @1116  (inscription x3)
--   280000305 Magister Serena 80260-> 79392 @1116  (inscription x3)
--   280000306 Fiona 76239          -> 76204 @1116  (Crippled Caravan)
--   280000310 Drek'Thar 76616      -> 74272/80456 @1116 (Honor Has Its Rewards)
--   280000311 Ga'nar 70878         -> 74000 @1116  (Let the Hunt Begin!)
--   280000313 Burrian 81600        -> 81601 @1116  (Dark Iron Down)
--   280000314 Burrian 81927        -> 81601 @1116  (Coalpart's Revenge)
--   280000320 Reshad 82621         -> 82611 @1116  (All Due Respect)
--   280000321 Shadow-Sage Iskar 82720-> 80153 @1116 (A Gathering of Shadows)
--   280000323 Dark Ranger Velonara 83899-> 83903 @1116 (Gardul Venomshiv / We Have Him Now)
--   280000324 Alice Finn 82124     -> 82126 @1116  (A Parting Favor / A Piece of the Puzzle)
--
-- Reste NET apres correctif : batch3 3 PNJ (Khadgar/Ly'leth/Oculeth) + batch4 15 + batch5 2 = 20.
-- ⚠️ DELETE de spawns deja charges => RESTART worldserver pour les faire disparaitre.
-- ============================================================================
DELETE FROM creature WHERE guid IN
 (280000283,280000285,280000302,280000305,280000306,280000310,
  280000311,280000313,280000314,280000320,280000321,280000323,280000324);
