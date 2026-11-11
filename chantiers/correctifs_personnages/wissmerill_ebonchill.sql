-- Wissmerill (339), rapport du 11/11 : « Le chasseur de mages » (42479) bloquee a l'etape 5, la quete ne
-- s'abandonne pas. Le runner d'artefact l'avait renvoye vers le palais Mogu'shan (carte 994).
-- A JOUER SERVEUR ARRETE, avec le binaire qui porte instance_faronaar_mage.
-- La quete est retiree : il la reprend aupres de Meryl Felstorm et refait le scenario.
DELETE FROM `character_queststatus_objectives` WHERE `guid`=339 AND `quest`=42479;
DELETE FROM `character_queststatus` WHERE `guid`=339 AND `quest`=42479;
-- liens d'instance : palais Mogu'shan heroique (sortie du runner) et Fort pourpre du domaine (41036)
DELETE FROM `character_instance` WHERE `guid`=339 AND `instance` IN (15, 32);
