-- =====================================================================
-- Rivage brisé (carte 1460) — retrait du drapeau UNIT_FLAG2_UNK5
--
-- Signalé en jeu : « les démons invoqués c'est ok mais pas les autres au
-- fond », puis « les fameux démons inattaquables se battent avec les
-- démons attaquables ». Nommément : Gangreseigneur Rakkan, Légionnaire
-- gangregarde, Molosse de l'effroi gangrené.
--
-- LA CAUSE, et elle est de mon fait
-- La transposition des modèles depuis le dump de référence a importé
-- `unit_flags2` sur 147 entrées. Ces trois-là valaient 0 avant ; elles
-- ont reçu 2097152, soit 0x200000 — UNIT_FLAG2_UNK5 dans notre cœur.
--
-- CE QUI REND CE DRAPEAU PARTICULIER : notre serveur l'IGNORE
-- totalement. Aucune de ses vérifications ne le consulte. Mais le client,
-- lui, l'interprète et refuse de désigner la créature comme cible.
--
-- C'est ce qui explique le symptôme le plus déroutant de la série : une
-- sonde posée dans `Unit::_IsValidAttackTarget` n'a JAMAIS produit la
-- moindre ligne pour ces créatures. Le client refusait de lui-même, sans
-- jamais interroger le serveur. L'absence de trace était l'information.
--
-- LA CORRÉLATION QUI TRANCHE
--   démons INVOQUÉS par le script (attaquables) : unit_flags2 = 0
--   démons STATIQUES (bloqués) : bit 0x200000 présent
--   67 entrées, 420 spawns concernés
--
-- On retire UNIQUEMENT ce bit, en préservant le reste de la colonne.
-- Le serveur ne s'en sert pas : ce retrait ne peut rien casser côté
-- logique, il lève seulement le refus du client.
--
-- Retour arrière : chantiers/rivage_brise/retour_unk5_1460.sql
-- =====================================================================

UPDATE `creature_template` ct
   JOIN (SELECT DISTINCT c.id
           FROM creature c
           JOIN creature_template t ON t.entry = c.id
          WHERE c.map = 1460
            AND (t.unit_flags2 & 2097152)) AS cible
     ON cible.id = ct.entry
    SET ct.unit_flags2 = ct.unit_flags2 & ~2097152;
