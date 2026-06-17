-- Hellfire Ramparts (map 543) : retire 2 scouts Alliance mal spawnes (faction 1737)
-- qui attaquent les Horde a l entree. id 54746 (Honor Hold Recon) + 54603 (Advance Scout Chadwick).
-- A appliquer sur la base world.
DELETE FROM creature WHERE map=543 AND id IN (54746,54603);
