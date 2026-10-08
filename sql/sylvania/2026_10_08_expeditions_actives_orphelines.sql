-- (base dc_characters) Expeditions actives absentes du registre (ex. 43284, reinseree par l ancien binaire juste
-- apres le nettoyage du 07/10) : rejetees a chaque demarrage, jamais expirees. Sauvegarde du 08/10 dans ~/tmp/sauvegardes.
DELETE FROM world_quest WHERE id NOT IN (SELECT id FROM dc_world.world_quest);
