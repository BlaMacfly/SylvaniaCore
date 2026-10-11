-- Base : dc_characters. A jouer serveur ARRETE, juste avant le premier demarrage du binaire
-- qui ecrit les etats de boss dans la sauvegarde du Siege d'Orgrimmar (carte 1136).
-- Ancien format : "S O O" + 6 evenements, relus a tort comme etats des boss 0 a 5.
-- Seule l'instance 1 (Blez, mythique, creee le 11/10 a 0h12) existe a ce format ; ses quatre
-- premiers boss ont ete vaincus (criteres de hauts faits, Vaillance, porte de Norushen).
-- Rejouable : la condition ne correspond plus une fois convertie.
UPDATE `instance` SET `data` = 'S O O 3 3 3 3 0 0 0 0 0 0 0 0 0 0 3 0 0 0 3 0 '
WHERE `id` = 1 AND `map` = 1136 AND TRIM(`data`) = 'S O O 3 0 0 0 3 0';
