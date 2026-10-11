-- Base : dc_characters. A jouer personnage(s) HORS LIGNE (en ligne, la table est reecrite
-- a la sauvegarde). Rejouable.
-- Seeping Sha (143286, flaque d'Immerseus, Siege d'Orgrimmar) : aura de degats sans duree
-- restee collee apres la rencontre. Seule cette aura est retiree, aucune autre.
DELETE FROM `character_aura_effect` WHERE `spell` = 143286;
DELETE FROM `character_aura` WHERE `spell` = 143286;
