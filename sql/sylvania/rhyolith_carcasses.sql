-- Lord Rhyolith (Terres de feu) : coherence des quatre carcasses du colosse.
--
-- Le combat officiel ne fait apparaitre qu'un seul personnage : c'est la meme
-- creature qui change d'entree a 75, 50 puis 25 pour cent (54192, 54199, puis
-- 53772). Les quatre gabarits doivent donc se comporter comme un seul boss :
-- une seule reserve de vie, un seul butin, et un corps intargetable tant que la
-- phase 1 dure. Trois ecarts sont corriges ici.
--
-- Voir docs/debug/rhyolith-root-cause.md, points R3, R4 et R5.

-- 1. Reserve de vie unique.
--    53772 portait 234.624 contre 152.517 pour les trois autres, soit une fois et
--    demie la reserve de tout le combat qui precede. Vestige de l'architecture
--    precedente, ou 53772 etait invoque comme un boss autonome ; depuis qu'il
--    n'est plus qu'une transformation, la barre doit continuer a 25 pour cent au
--    lieu de repartir pleine.
UPDATE `creature_template` SET `HealthModifier` = 152.517 WHERE `entry` = 53772;

-- 2. Butin unique.
--    Le colosse meurt sous l'entree 53772, dont la table de butin ne comptait que
--    quatre lignes (dont deux exigeant une quete) au lieu des vingt-trois de
--    52558 : jetons de palier, epiques, Essence du Vol draconique, Cendres
--    embrasees, Elementium vivant. On fait pointer les trois carcasses abimees
--    sur la table de Rhyolith plutot que de la dupliquer.
UPDATE `creature_template` SET `lootid` = 52558 WHERE `entry` IN (53772, 54192, 54199);

-- 3. Corps intargetable pendant toute la phase 1.
--    52558 porte UNIT_FLAG2_SELECTION_DISABLED (0x4000000) : on ne peut frapper
--    que les pieds. 54192 et 54199 l'avaient perdu, si bien qu'a partir de 75
--    pour cent le corps redevenait attaquable en pleine phase 1 et les degats
--    directs court-circuitaient toute la mecanique des pieds. 53772 ne doit PAS
--    le porter : la phase 2 se joue au corps a corps.
UPDATE `creature_template` SET `unit_flags2` = `unit_flags2` | 0x4000000 WHERE `entry` IN (54192, 54199);
