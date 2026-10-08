-- Zul'Aman : les otages Cataclysm deviennent les seuls otages de la course contre la montre.
-- Rejouable : simples UPDATE cibles par entree.

-- Hazlek, Norkani et Kasha vivants portaient l'aura de leur cadavre (42726, Cosmetic -
-- Immolation (Whole Body)), et les deux derniers sa posture de mort (bytes1 = 7) : on les
-- voyait bruler des l'entree. Seuls les cadavres (52940, 52942, 52944, 52946) la gardent.
UPDATE creature_template_addon SET auras = '', bytes1 = 0 WHERE entry IN (52939, 52943, 52945);

-- Ils remettent desormais le coffre a la place des captifs Burning Crusade (voir
-- instance_zulaman.cpp et zulaman.cpp).
UPDATE creature_template SET ScriptName = 'npc_zulaman_hostage' WHERE entry IN (52939, 52941, 52943, 52945);

-- Kasha etait hostile (faction 14) : impossible de lui parler pour recevoir son coffre.
-- Meme faction neutre que les trois autres otages.
UPDATE creature_template SET faction = 7 WHERE entry = 52945;
