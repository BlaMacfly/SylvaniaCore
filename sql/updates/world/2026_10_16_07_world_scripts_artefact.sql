-- Scripts d artefact presents dans spell_artifact.cpp mais rattaches a AUCUN sort (aucun core de reference ne les lie
-- non plus) : ces traits ne faisaient rien. Effets et drapeaux de proc verifies dans notre client 7.3.5.
--   224968 Mark of Aluneth : PERIODIC_DUMMY 1 s -> 211088 autour de la cible, explosion 211076 = 20 % du mana max.
--   207407 Soul Carver : 2 fragments a l impact (EFFECT_3 = 2), 1 par tic du DoT.
--   213010 Charred Warblades : DUMMY 15 %, soin 213011 sur degats de Feu.
--   213017 Fueled by Pain : DUMMY, PPM 86, Metamorphose 5 s a la consommation d un fragment (210042 / 203794).
--   194230 Sphere of Insanity : aura posee par 194182 EFFECT_3, duplique 5 % des degats sur les cibles de Mot de l ombre : Douleur.
-- Ecartes : 212817 Fiery Demise (le script s applique a tout proc, pas seulement a la Marque ardente) et le
-- ralentissement de 70 % (211056) pose par le script de 211088, absent de l infobulle 7.3.5.
DELETE FROM `spell_script_names` WHERE `spell_id` IN (224968, 207407, 213010, 213017, 194230);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(224968, 'aura_arti_mage_mark_of_aluneth'),
(207407, 'spell_dh_artifact_soul_carver'),
(213010, 'spell_dh_artifact_charred_warblades'),
(213017, 'spell_dh_artifact_fueled_by_pain'),
(194230, 'spell_arti_pri_sphere_of_insanity');
