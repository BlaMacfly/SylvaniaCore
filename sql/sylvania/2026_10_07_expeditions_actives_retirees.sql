-- (base dc_characters) Les expeditions retirees du registre ne doivent plus figurer parmi les actives :
-- sinon le chargement les rejette a chaque demarrage (« not a world quest ») et la ligne reste a vie.
-- Sauvegarde : ~/tmp/sauvegardes/characters_world_quest_2026-10-07.sql (rollback = recharger ce fichier)
DELETE FROM world_quest WHERE id IN (40168,40173,40786,40787,41177,43242,43245,43282,43283,43284,43285,43286,43287,43288,43289,43290,43291,43292,43296,43297,43298,43299,43300,43301,43476,45563,48982,49091,49096,49097,49098,49099,49166,49167,49168,49169,49170,49171);
