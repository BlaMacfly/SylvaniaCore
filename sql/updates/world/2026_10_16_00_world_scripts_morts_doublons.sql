-- Rattachements de scripts de sorts entierement morts (toutes leurs accroches refusees au demarrage, « did not match dbc
-- effect data ») alors que le meme script fonctionne sur un autre sort : aucun effet en jeu, seulement du bruit au boot.
-- Plusieurs accrochaient un script de boss a un sort de classe (Projectiles des arcanes 79683, Barriere 81782).
DELETE FROM `spell_script_names` WHERE (`spell_id`, `ScriptName`) IN (
  (81782, "aura_barrier"), (168375, "aura_grasping_vine"), (177731, "spell_agitated_water"),
  (177731, "spell_agitated_water_trig"), (164834, "spell_barrage_of_leaves"), (172578, "spell_bounding_whirl"),
  (35244, "spell_choking_vines"), (165213, "spell_enraged_growth"), (79683, "spell_entanglement_missile"),
  (153276, "spell_exhume_the_crypts"), (108374, "spell_rising_fire_totem"),
  (170404, "spell_vine_pull"), (177694, "spell_water_burst_targeting"));
