-- Annule 2026_10_08_farondis_option_assaut.sql
UPDATE gossip_menu_option SET OptionText = 'I''m $gready:ready; launch the decisive attack. [Stand in line for the script.]' WHERE MenuId = 20846 AND OptionIndex = 0;
DELETE FROM gossip_menu_option_locale WHERE MenuId = 20846 AND OptionIndex = 0 AND Locale = 'frFR';
