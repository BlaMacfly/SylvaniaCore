-- Klauss (entry 1000000) : sous-nom en français
-- Template (vu par tous les clients sans locale dédiée)
UPDATE creature_template
SET subname = 'Sélecteur de taux d''expérience'
WHERE entry = 1000000;

-- Locale frFR explicite (clients français)
REPLACE INTO creature_template_locale (entry, locale, Name, NameAlt, Title, TitleAlt, VerifiedBuild)
VALUES (1000000, 'frFR', 'Klauss', NULL, 'Sélecteur de taux d''expérience', NULL, 26972);
