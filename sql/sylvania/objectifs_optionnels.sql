-- Objectifs marques « (Optional) » dans leur texte mais sans le drapeau QUEST_OBJECTIVE_FLAG_OPTIONAL
-- (0x04) : le core les exigeait, la quete restait incomplete. Cas vecu : On Eagle s Wings (40953),
-- Blez arrive au Pavillon mais ne peut pas rendre la quete (29/09/2026). 6 objectifs sur 54.
UPDATE quest_objectives SET Flags = Flags | 4 WHERE Description LIKE "(Optional)%" AND (Flags & 4) = 0;
