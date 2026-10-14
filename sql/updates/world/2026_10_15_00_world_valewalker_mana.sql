-- The Valewalker's Burden (42230) : la recompense 215108 est la mise en scene ; le +300 de plafond de Mana ancien
-- (222381 « Currency Increase - The Valewalker's Burden ») n'etait relie a rien. Lance avec la recompense.
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 215108 AND `spell_effect` = 222381;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
(215108, 222381, 0, 'The Valewalker''s Burden - plafond de Mana ancien +300');
