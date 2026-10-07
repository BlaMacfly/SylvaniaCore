-- (base dc_characters) TEST : relance l assaut d Azsuna en cours pour 6 h a partir de maintenant,
-- afin de verifier en jeu les quetes et les demons d assaut ajoutes le 07/10/2026.
-- Sans effet de bord : seule l heure de debut de la quete principale 45838 change.
UPDATE world_quest SET starttime = UNIX_TIMESTAMP() WHERE id = 45838;
