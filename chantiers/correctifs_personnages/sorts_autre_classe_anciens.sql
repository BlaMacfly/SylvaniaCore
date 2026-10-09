-- Sorts d'une autre classe trouves par audit_sorts_classes.py le 09/10/2026, deja presents dans la
-- plus ancienne sauvegarde (25/09) : restes anciens, sans lien avec le choix d arme du chasseur.

-- Botqa (guid 67, mage, compte PLAYERBOT1) : arsenal de guerrier Armes.
DELETE FROM character_spell WHERE guid = 67 AND spell IN
(71, 845, 1464, 1680, 1715, 1719, 5246, 12294, 18499, 34428, 76838, 86101, 97462, 118038, 137049,
 162698, 163201, 167105, 184783, 227847, 231830, 231833, 261900, 261901);
DELETE FROM character_action WHERE guid = 67 AND type = 0 AND action IN
(71, 845, 1464, 1680, 1715, 1719, 5246, 12294, 18499, 34428, 76838, 86101, 97462, 118038, 137049,
 162698, 163201, 167105, 184783, 227847, 231830, 231833, 261900, 261901);

-- Taelia (guid 2, paladin) : 231437 Archdruid's Lunarwing Form (druide).
DELETE FROM character_spell WHERE guid = 2 AND spell = 231437;
DELETE FROM character_action WHERE guid = 2 AND type = 0 AND action = 231437;

-- Minilara (guid 34, guerrier) : 198013 Eye Beam (chasseur de demons).
DELETE FROM character_spell WHERE guid = 34 AND spell = 198013;
DELETE FROM character_action WHERE guid = 34 AND type = 0 AND action = 198013;
