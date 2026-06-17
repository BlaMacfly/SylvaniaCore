-- Update spawnDifficulties for creature in all gilneas outside city
UPDATE `creature` SET `spawnDifficulties`='0' WHERE `map`='654';

-- Update spawnDifficulties for gameobject in all gilneas outside city
UPDATE `gameobject` SET `spawnDifficulties`='0' WHERE `map`='654';
