-- Filtres de cibles de vieux combats morts depuis la 7.x : la zone d effet a ete deplacee dans un sort declenche, le
-- script restait accroche au sort lanceur (qui n a plus cette cible). Purs filtres de cibles : rattaches en plus au
-- sort declenche qui porte la zone (le rattachement d origine est garde).
-- Isiset (Supernova : seulement ceux qui lui font face), Throngus (barrage : une cible au hasard), Benedictus (Seaping
-- Light : distance), Erudax (Shadow Gale : distance, ennemis), Sinestra (Twilight Slicer : entre les deux orbes).
DELETE FROM `spell_script_names` WHERE (`spell_id`, `ScriptName`) IN ((76670, "spell_isiset_supernova"), (74137, "spell_isiset_supernova"),
  (74945, "spell_throngus_arrow_barage"), (104528, "spell_seaping_light"), (75692, "spell_shadow_gale_damage"), (92852, "spell_sinestra_twilight_slicer"));
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(76670, "spell_isiset_supernova"), (74137, "spell_isiset_supernova"), (74945, "spell_throngus_arrow_barage"),
(104528, "spell_seaping_light"), (75692, "spell_shadow_gale_damage"), (92852, "spell_sinestra_twilight_slicer");
