-- Voidling (112673) : modele 67 inexistant dans le client (« this can crash the client ») ; affichage officiel 61032 (Wowhead)
UPDATE `creature_template` SET `modelid1` = 61032 WHERE `entry` = 112673 AND `modelid1` = 67;
