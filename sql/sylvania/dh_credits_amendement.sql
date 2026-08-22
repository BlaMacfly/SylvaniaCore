-- =====================================================================
-- Complément à dh_quest_credits.sql et dh_loot_wowhead.sql
-- Deux points relevés dans le journal du premier démarrage.
-- =====================================================================


-- ---------------------------------------------------------------------
-- 1. Les huit lignes MORTES de « Infusion gangrenée » sur les démons
--
-- 92776 et 92782 portaient chacun HUIT lignes identiques :
--     évènement 32 (SMART_EVENT_DAMAGED), tous paramètres à zéro
--     -> action 85, l'attaquant lance 133511 « Fel Infusion: Kill Credit »
--
-- Elles ne se sont jamais déclenchées une seule fois. Le test du core est :
--     if (var0 > e.event.minMaxRepeat.max || var0 < e.event.minMaxRepeat.min)
--         return;
-- avec max = 0, tout dégât supérieur à zéro sort immédiatement. Ces
-- seize lignes étaient donc inertes depuis toujours — ce qui confirme
-- que le crédit 89297 n'avait effectivement aucune source, et explique
-- pourquoi la quête 38689 ne pouvait pas se terminer.
--
-- On les supprime : le crédit est désormais accordé à la mort du démon,
-- ce que décrit le texte officiel de la quête (« gather their souls »),
-- et les conserver ne ferait qu'entretenir la confusion. Au passage, un
-- déclenchement « à chaque coup reçu » aurait de toute façon rempli les
-- 100 points sans tuer quoi que ce soit.
-- ---------------------------------------------------------------------
DELETE FROM `smart_scripts`
 WHERE `source_type`=0 AND `entryorguid` IN (92776,92782) AND `event_type`=32
   AND `action_type`=85 AND `action_param1`=133511;


-- ---------------------------------------------------------------------
-- 2. Pourquoi l'action 33 est conservée malgré l'avertissement du core
--
-- SmartAIMgr signale à chaque démarrage, pour chacune de nos quarante
-- lignes :
--     « Kill Credit: There is a killcredit spell for creatureEntry 89297
--       (SpellId: 133511 effect: 0) »
-- C'est un simple conseil — la ligne est chargée normalement, la
-- fonction ne renvoie pas d'échec. Il invite à passer par le sort
-- plutôt que par l'action 33.
--
-- On ne le suit PAS, délibérément. Il faut dix crédits par démon (le
-- script C++ npc_fel_infusion accorde +10 d'énergie et dix crédits) ; or
-- dix incantations successives du même sort ne sont garanties que si
-- 133511 n'a aucun temps de recharge, ce qu'aucune donnée disponible ici
-- ne permet de vérifier. Si le sort en avait un, une seule incantation
-- passerait, il faudrait cent démons, et la quête resterait bloquée.
-- L'action 33 produit exactement le même effet visible pour le joueur —
-- Player::KilledMonsterCredit dans les deux cas — sans ce risque.
-- Le prix est de quarante lignes de conseil dans le journal à chaque
-- démarrage ; c'est assumé.
-- (rien à exécuter pour ce point, note de conception)


-- ---------------------------------------------------------------------
-- 3. 132138 « Cendres gangrenées radieuses » : objet inconnu du serveur
--
-- Le démarrage a répondu :
--     Table 'creature_loot_template' Entry 97228 Item 132138:
--     item entry not listed in `item_template` - skipped
-- L'objet n'existe pas dans les données de ce client 7.3.5 ; la ligne
-- était ignorée. On la retire pour ne pas laisser de référence morte.
--
-- À l'inverse, 132753 « Rations de la Légion » et 147430 « Parchemin
-- runique mystérieux » n'ont provoqué AUCUNE erreur : le serveur les
-- connaît, ces ajouts-là sont valides.
-- ---------------------------------------------------------------------
DELETE FROM `creature_loot_template` WHERE `Entry`=97228 AND `Item`=132138;
