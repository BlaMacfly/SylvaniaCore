-- Option de dialogue du prince Farondis (menu 20846) : elle annoncait une file d'attente (« [Stand in line for the
-- script.] ») qui n'existe pas chez nous (entree directe dans le scenario). Texte anglais nettoye + traduction frFR
-- (aucun texte officiel trouve dans broadcast_text). Rollback : ..._rollback.sql
UPDATE gossip_menu_option SET OptionText = 'I''m $gready:ready; launch the decisive attack.' WHERE MenuId = 20846 AND OptionIndex = 0;
INSERT INTO gossip_menu_option_locale (MenuId, OptionIndex, Locale, OptionText, BoxText) VALUES
(20846, 0, 'frFR', 'Je suis $gprêt:prête; : lancez l''assaut décisif.', '');
