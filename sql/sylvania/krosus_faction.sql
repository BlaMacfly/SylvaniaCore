-- =====================================================================
-- Rivage brisé — Krosus était inattaquable
--
-- SIGNALÉ EN JEU : « le Krosus du lac de lave en p8 est inattaquable ».
--
-- Il portait la faction 2878. C'est exactement le défaut résolu en août
-- pour les autres démons de cette carte : les factions 2780 et 1768 les
-- rendaient inattaquables — le refus vient du client, aucune sonde
-- serveur ne peut l'observer — et on les avait toutes basculées en 16,
-- la seule dont le fonctionnement soit démontré ici. La 2878 n'était
-- pas dans le lot, personne n'étant jamais allé aussi loin dans le
-- scénario.
--
-- PORTÉE VÉRIFIÉE : l'entrée 90544 n'existe QUE sur la carte 1460, un
-- seul exemplaire. Aucun autre contenu n'est touché.
-- =====================================================================

UPDATE `creature_template` SET `faction` = 16 WHERE `entry` = 90544;
