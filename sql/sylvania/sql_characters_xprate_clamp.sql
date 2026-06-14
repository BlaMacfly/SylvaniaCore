-- Bride défensive : aucun personnage ne doit conserver un taux d'XP personnel > x7
-- (vérifié le 11/06/2026 : aucune ligne concernée — requête sans effet, gardée par sécurité)
UPDATE characters SET xpRate = 7 WHERE xpRate > 7;
