-- =====================================================================
-- Rivage brisé (carte 1460) — rattachement du script des Flèches
--
-- L'étape 1 « Storm The Beach » exige trois Flèches de la Détresse
-- détruites (critère 27619, arbre 46548). Ce critère est de type
-- CRITERIA_TYPE_SEND_EVENT_SCENARIO : il ne se remplit que si le serveur
-- émet l'événement 44077.
--
-- La Flèche est un objet de type 10, c'est-à-dire ACTIONNÉ et non
-- détruit. Aucun point d'entrée d'instance ne rapporte cette
-- utilisation : ni `OnGameObjectCreate` ni `OnGameObjectRemove` ne se
-- déclenchent. Le seul accrochage disponible est
-- `GameObjectScript::OnGossipHello`, que `GameObject::Use` appelle avant
-- tout traitement spécifique (GameObject.cpp:1379).
--
-- Sans cette ligne, la classe `go_spire_of_woe` existerait dans le code
-- sans jamais être invoquée — un script non rattaché de plus.
--
-- Rechargeable à chaud : reload gameobject_template
-- =====================================================================

UPDATE `gameobject_template`
   SET `ScriptName` = 'go_spire_of_woe'
 WHERE `entry` = 240194;
