-- =====================================================================
-- Rivage brisé (carte 1460) — objets affichés comme déjà utilisés
--
-- SIGNALÉ EN JEU : « le gameobject de la flèche n'est physiquement pas
-- visible ni cliquable, à la place il y a un minuscule skin de chien ».
--
-- Les six Flèches de malheur (240194) étaient enregistrées en
-- `state = 2`, soit GO_STATE_ACTIVE_ALTERNATIVE. Le commentaire de notre
-- propre énumération le décrit sans ambiguïté :
--     « show in world as used in alt way and not reset »
-- L'objet est donc affiché dans sa forme CONSOMMÉE dès l'apparition,
-- avec le modèle de remplacement correspondant — et il n'est plus
-- utilisable, puisqu'il se présente comme déjà employé.
--
-- Ce n'était ni le modèle ni l'orientation : `displayId` 37460 existe
-- bien dans GameObjectDisplayInfo du build 7.3.5.26972, avec une boîte
-- englobante de 44 × 44 × 71 unités, et la rotation (0,0,0,1) est
-- l'identité, la même que celle des Cages de la Légion qui s'affichent
-- correctement.
--
-- État attendu : GO_STATE_READY (1), celui de 79 des 101 objets de la
-- carte, dont toutes les cages, les fleurs et les navires.
--
-- PORTÉE : les six flèches uniquement. Les Canons de siège (240214) et
-- deux Portails de la Légion partagent le même défaut apparent, mais
-- rien ne prouve encore que leur état soit fautif — un canon peut
-- légitimement s'afficher chargé. À vérifier en jeu avant d'y toucher.
-- =====================================================================

UPDATE `gameobject`
   SET `state` = 1
 WHERE `id` = 240194
   AND `map` = 1460
   AND `state` = 2;
