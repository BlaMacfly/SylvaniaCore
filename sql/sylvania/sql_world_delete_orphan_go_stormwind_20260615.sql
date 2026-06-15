-- ============================================================================
-- CORRECTIF durable — retrait de 4 gameobjects ORPHELINS (sans gameobject_template)
-- en Hurlevent (map 0, zone 1519). 2026-06-15.
--
-- Spawns morts : guid 21002153..21002156, entries 254079/258989/258990/258991.
-- Aucun gameobject_template => le worldserver ne peut pas les charger (erreurs au
-- load) et ils sont invisibles. Range de GUID custom = pose custom inachevee
-- (templates jamais crees/supprimes). Confirme : aucune ref pool/event.
--
-- Idempotent + garde "no template" : ne supprime QUE si l'entry n'a toujours pas
-- de template (si un template est ajoute plus tard, ce correctif devient inactif).
-- ============================================================================
DELETE FROM gameobject
 WHERE guid IN (21002153,21002154,21002155,21002156)
   AND id NOT IN (SELECT entry FROM gameobject_template);
