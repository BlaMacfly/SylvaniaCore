-- =====================================================================
-- Caveau des Gardiennes (1468) — réapparition, deuxième passe
--
-- Après la première passe, signalé en jeu : « certains PNJ réapparaissent
-- et d'autres non ». C'est ma faute : j'avais restreint la correction à
-- une liste de factions fixée à l'avance (14, 16, 954, 2102, 2104, 90,
-- 1771), ce qui laissait à 7200 s plusieurs créatures qui meurent
-- pourtant bel et bien :
--
--   96656 Illidari libéré      35 apparitions, faction 2804 — allié, il
--                              tombe en combattant les démons
--   96645 Gardien du Caveau    36, faction 2805 — idem
--   94655 Sangsue d'âme        47, faction 190
--   101648 Cafard du Caveau    44 et 101647 Rat des cavernes 12, faction 31
--   92990 Pilon / 97632 Marteau   faction 1786, les deux gardes de
--                              « Arrêtez Gul'dan ! » : deux heures
--                              d'attente après un échec
--
-- La zone jumelle règle le débat : Mardum (1481) applique ses 120
-- secondes UNIFORMÉMENT, PNJ de quête compris — Allari, Kayn, Kor'vas,
-- Sevis, Jace, Belath y sont tous à 120. Il n'y a donc pas lieu de trier
-- ici entre « combattants » et « figurants » : on aligne toute la carte.
--
-- Effet secondaire assumé et souhaitable : les PNJ scriptés qui
-- disparaissent en fin de séquence (Maiev après son trajet, les cellules
-- de Kayn et d'Altruis une fois ouvertes) reviennent en une minute au
-- lieu de deux heures. C'est ce qu'il faut pour qu'un second joueur
-- puisse enchaîner la même étape.
--
-- Seule exception : les Portails de la Légion (99501, 114358). Ce sont
-- les cibles de l'objectif bonus et le moyen de transport de la zone ;
-- leur rythme est un réglage à part, on ne le touche pas dans un
-- correctif de réapparition.
--
-- ⚠️ REDÉMARRAGE NÉCESSAIRE — voir vault_respawn.sql.
-- =====================================================================

UPDATE `creature`
SET `spawntimesecs` = 60
WHERE `map` = 1468
  AND `id` NOT IN (99501, 114358);

-- --- Portails de la Légion : six sur sept étaient à deux heures --------
-- Relevé juste après : des 7 apparitions de 99501, une seule portait 300
-- secondes, les six autres 7200. Ce sont les cibles de l'objectif bonus
-- « Caveau des Gardiennes » : détruites une fois, elles disparaissaient
-- pour deux heures, rendant l'objectif infaisable pour le joueur suivant.
-- Alignées sur la valeur déjà présente dans les données (300) plutôt que
-- sur une valeur inventée. 114358, le portail de transport, n'est jamais
-- détruit et n'est pas touché.
UPDATE  SET =300 WHERE uid=1000(blamacfly) gid=1000(blamacfly) groupes=1000(blamacfly),24(cdrom),25(floppy),27(sudo),29(audio),30(dip),44(video),46(plugdev),100(users),101(netdev),102(scanner),106(bluetooth),108(lpadmin),988(docker)=99501 AND =1468;
