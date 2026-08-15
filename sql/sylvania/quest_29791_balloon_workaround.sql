-- =====================================================================
-- Quête 29791 « Les souffrances de Shen-zin Su » — CONTOURNEMENT
--
-- CE N'EST PAS UN CORRECTIF DE FOND. Le vol en montgolfière souffre d'une
-- désynchronisation client/serveur non résolue :
--   - Côté serveur, la montgolfière (55649, VehicleId 1820) suit
--     parfaitement ses 21 points de passage (vérifié par sonde journalisant
--     la position chaque seconde ; le joueur assis colle à 3 m près).
--   - Côté client, le joueur voit un trajet totalement différent (part vers
--     l'est au lieu du nord-ouest). Confirmé en extrayant les coordonnées
--     TomTom image par image d'une vidéo et en les convertissant via les
--     bornes WorldMapArea de la carte 860.
--
-- Pistes ÉLIMINÉES par la mesure (ne pas refaire) :
--   * VEHICLE_SEAT_FLAG_CAN_CONTROL : aucun siège du véhicule 1820 ne le
--     porte (lu dans VehicleSeat.db2) ; le joueur est en siège 0, qui porte
--     UNCONTROLLED (0x2000).
--   * Conflit de sièges : les 5 sièges sont correctement occupés.
--   * Course à l'embarquement : retarder WP_START à 8 s ne change rien.
--   * État de vol : bytes1 = 0x03000000 (anim tier vol) correct.
--   * Repli socket realm : écarté (sinon aucune créature ne bougerait).
--
-- ANGLE MORT à explorer si le sujet est rouvert : le contenu réel du paquet
-- de spline envoyé au client (MoveSplineInit), par opposition à la position
-- interne du serveur. Piste secondaire : splines catmullrom des créatures
-- volantes (issues TrinityCore #13467 et #22434).
--
-- CONTOURNEMENT : à l'acceptation de la quête chez Aysa (56662), les deux
-- objectifs sont crédités et le joueur est téléporté au point d'atterrissage
-- officiel (745, 3665, 194 — coordonnées relevées sur la vidéo du serveur
-- officiel), à quelques pas d'Elder Shaopai qui reçoit la quête.
--
-- Les 21 points de passage authentiques restent INTACTS en base : réactiver
-- WP_START dans la liste d'actions 5564900 suffira le jour où la désync sera
-- corrigée (cherry-pick prioritaire si ArgusCore publie un correctif).
--
-- Note : les actions sont volontairement INDÉPENDANTES (chacune sur son
-- propre événement 19) et non chaînées par `link` — ce core ne propage pas
-- les liens au-delà d'un niveau, la chaîne s'interrompait après la première.
-- =====================================================================

UPDATE `smart_scripts` SET `link`=0
WHERE `entryorguid`=56662 AND `source_type`=0 AND `id`=5;

DELETE FROM `smart_scripts` WHERE `entryorguid`=56662 AND `source_type`=0 AND `id` IN (6,7,8);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(56662,0,6,0,19,0,100,0,29791,0,0,0,33,56378,0,0,0,0,0,7,0,0,0,0,0,0,0,'Credit Monter a bord de la montgolfiere (56378)'),
(56662,0,7,0,19,0,100,0,29791,0,0,0,33,55939,0,0,0,0,0,7,0,0,0,0,0,0,0,'Credit Decouvrir la source de la souffrance (55939)'),
(56662,0,8,0,19,0,100,0,29791,0,0,0,62,860,0,0,0,0,0,7,0,0,0,745,3665,194,0,'Teleportation au point datterrissage (contournement desync montgolfiere)');
