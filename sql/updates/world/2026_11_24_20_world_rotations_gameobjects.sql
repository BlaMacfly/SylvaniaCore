-- Rotations de gameobjects invalides (quaternion de norme differente de 1) : 106 apparitions sur 10 cartes.
-- Le core ramene le quaternion a la norme 1 avant de l'envoyer : (0,0,1,1) devient une rotation de 90 degres au lieu
-- de 180. Jugement des valeureux / Trial of Valor (1648) : le pont 246144, les portes et les runes d'Odyn etaient tournes d'un quart de
-- tour (« le chemin part a droite vers nulle part, le vrai chemin est invisible »). Siege d'Orgrimmar (1136) et autres :
-- valeurs presque nulles venues de LegionCore. On fait comme TrinityCore master au chargement : rotation sur Z seule,
-- recalculee depuis l'orientation (juste partout ; identique au donjon des Salles des Valeureux pour les objets de 1648).
UPDATE `gameobject` SET `rotation0`=0, `rotation1`=0, `rotation2`=SIN(`orientation`/2), `rotation3`=COS(`orientation`/2)
WHERE ABS(`rotation0`*`rotation0`+`rotation1`*`rotation1`+`rotation2`*`rotation2`+`rotation3`*`rotation3`-1) > 0.01;
