-- Vignettes (marqueurs de minicarte) des rares des Iles brisees qui n en avaient pas.
-- Appariement verifie par Vignette.db2 : le VisibleTrackingQuestID de chaque vignette
-- est la quete de suivi du rare (ex. 1809 -> 45483 Ealdis, 776 -> 38468 Gorebeak).
-- Sauvegarde : ~/tmp/sauvegardes/creature_template_vignettes_rares_2026-10-07.sql
-- Rollback   : 2026_10_07_vignettes_rares_iles_brisees_rollback.sql
UPDATE creature_template SET VignetteID = CASE entry
  WHEN 110342 THEN 1812 -- Rabxach
  WHEN 110367 THEN 1809 -- Ealdis
  WHEN 109648 THEN 1818 -- Witchdoctor Grgl-Brgl
  WHEN 110346 THEN 1811 -- Aodh Witherpetal
  WHEN 109692 THEN 1815 -- Lytheron
  WHEN 109281 THEN 1825 -- Malisandra
  WHEN 109677 THEN 1816 -- Chief Treasurer Jabrill
  WHEN 109584 THEN 1823 -- Fjordun
  WHEN 109641 THEN 1819 -- Arcanor Prime
  WHEN 109702 THEN 1814 -- Deepclaw
  WHEN 109653 THEN 1817 -- Marblub the Massive
  WHEN 109990 THEN 1813 -- Nylaathria the Forgotten
  WHEN 109630 THEN 1820 -- Immolian
  WHEN 110361 THEN 1810 -- Harbinger of Screams
  WHEN 92117  THEN 776  -- Gorebeak
  WHEN 109594 THEN 1822 -- Stormfeather
  WHEN 109575 THEN 1839 -- Valakar the Thirsty
  WHEN 109620 THEN 1821 -- The Whisperer
END
WHERE entry IN (110342,110367,109648,110346,109692,109281,109677,109584,109641,109702,109653,109990,109630,110361,92117,109594,109575,109620) AND VignetteID = 0;
