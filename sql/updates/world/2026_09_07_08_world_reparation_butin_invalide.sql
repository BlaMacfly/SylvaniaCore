-- 142 lignes de butin rejetees a chaque chargement : REPARATION, pas suppression.
--
-- Les supprimer aurait ete destructeur : ce ne sont pas des lignes vides mais du butin
-- reel rendu inoperant par deux defauts d'import distincts.
--
-- 1) 62 lignes a chance NEGATIVE, sur 35 creatures. Signe inverse a l'import : les memes
--    objets existent ailleurs dans la table avec la meme valeur en positif (69815 entre
--    50 et 100 %, 71141 entre 75 et 100 %). On remet la valeur absolue.
--
-- 2) 80 lignes a chance nulle sans GroupId, sur 6 boss de points d'invasion majeurs
--    d'Argus (Sotanathor, Inquisitor Meto, Mistress Alluradel, Pit Lord Vilemus,
--    Matron Folnuna, Occularus), 12 a 14 objets chacun. C'est l'encodage classique d'un
--    groupe equiprobable dont le GroupId a ete perdu : sans lui le core rejette tout et
--    ces boss ne lachent rien. Verifie sur Wowhead : Mistress Alluradel liste exactement
--    les 14 memes objets que nous. GroupId = 1 les fait tirer un objet parmi le lot.
--
-- Effet : 41 creatures retrouvent leur butin, dont 6 boss d'Argus qui n'en avaient aucun.

UPDATE `creature_loot_template` SET `Chance` = ABS(`Chance`)
 WHERE `Reference` = 0 AND `Chance` <> 0 AND `Chance` < 0.000001;

UPDATE `creature_loot_template` SET `GroupId` = 1
 WHERE `Reference` = 0 AND `Chance` = 0 AND `GroupId` = 0
   AND `Entry` IN (124492,124514,124555,124592,124625,124719);
