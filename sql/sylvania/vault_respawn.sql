-- =====================================================================
-- Caveau des Gardiennes (1468) — les démons ne réapparaissaient plus
--
-- Signalé en jeu : dans le secteur de la Garde illidari, là où se
-- trouvent l'objectif bonus « Caveau des Gardiennes » et la quête 38689
-- « Infusion gangrenée », les démons tués ne revenaient pas. Une fois le
-- secteur nettoyé, plus rien à tuer — l'objectif bonus et la quête
-- devenaient infranchissables sans `.respawn all`, dont un joueur ne
-- dispose pas.
--
-- Cause : TOUTE la carte 1468 était à `spawntimesecs = 7200`, soit deux
-- heures. 474 apparitions sur 476 portaient cette valeur. C'est la
-- signature d'un import en masse laissé au défaut, pas une donnée
-- authentique — la preuve par la zone jumelle : Mardum (1481), même
-- campagne, même contenu, a 1250 de ses créatures à 120 secondes, y
-- compris ses quatre rares (Comte Néfarius, Général Volroth, Roi Voras,
-- Surveillant Brutarg) et tous ses élites.
--
-- Valeur retenue : 60 secondes, choisie par l'utilisateur. Deux fois
-- plus rapide que Mardum, ce qui se défend ici : le Caveau est un
-- scénario instancié où l'objectif bonus demande un volume de morts
-- important dans un espace clos.
--
-- Portée : uniquement les créatures de faction hostile, celles qu'on
-- tue. Les éléments de décor (Generic Bunny, Safety Net, Vault Roach,
-- Soul Leech, Cavern Rat, statues) et les PNJ de quête (Maiev, Kayn,
-- Altruis, les cellules) gardent leur délai : ils ne meurent pas, et y
-- toucher n'aurait aucun effet visible tout en brouillant les données.
--
-- ⚠️ NÉCESSITE UN REDÉMARRAGE : `spawntimesecs` est lu dans les données
-- de spawn au chargement de la carte. Aucune commande de rechargement à
-- chaud ne couvre la table `creature`, et les créatures déjà apparues
-- conservent en mémoire le délai lu à leur naissance.
-- =====================================================================

UPDATE `creature` c
JOIN `creature_template` ct ON ct.entry = c.id
SET c.spawntimesecs = 60
WHERE c.map = 1468
  AND ct.faction IN (14,16,954,2102,2104,90,1771);
