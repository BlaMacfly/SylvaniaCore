-- Blez (guid 5, chasseur) : sorts de chasseur de demons Vengeance restes dans le grimoire.
-- Le 27/09 au soir, le choix d arme prodigieuse du chasseur activait la specialisation 581
-- (Vengeance, classe 12) au lieu de Maitrise des betes : LearnSpecializationSpells lui a appris
-- l arsenal Vengeance, et RemoveSpecializationSpells ne retire que les sorts des specialisations
-- de SA classe. Bascule retiree le 28/09 (d4f9f5946), sorts jamais nettoyes.
-- Liste = SpecializationSpells.db2 de la spe 581, moins 162697 (Stat Negation Aura - Agility DPS),
-- passif legitime de tout chasseur. Seul personnage touche (verifie sur toute la base).
DELETE FROM character_spell WHERE guid = 5 AND spell IN
(162700, 178740, 185244, 185245, 187827, 189110, 189926, 202137, 203513, 203720, 203747, 203782,
 203783, 204021, 204157, 204254, 204596, 207197, 207684, 212613, 218256, 226359, 228477);

-- Boutons de barre d action qui pointaient vers ces sorts.
DELETE FROM character_action WHERE guid = 5 AND type = 0 AND action IN (218256, 204596, 204021);
