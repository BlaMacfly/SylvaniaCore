-- ============================================================================
-- CORRECTIF durable — lieu de depart Worgen + Gobelin (playercreateinfo).
-- 2026-06-16. BUG signale en jeu : un worgen cree apparait au depart HUMAIN
-- (Northshire, map 0) ; les gobelins au depart ORC (Durotar, map 1). La table
-- playercreateinfo avait ete copiee du humain/orc pour ces 2 races Cata.
--
-- Corrige vers les zones OFFICIELLES (ref Cataclysm Preservation Project) :
--   Worgen (race 22) -> Gilneas (map 654, zone 4756) ~ -1451.53, 1403.35, 35.56
--   Gobelin (race 9) -> Kezan/Iles Brisees (map 648, zone 4765) ~ -8423.81, 1361.3, 104.67
-- Classe 6 (Chevalier de la mort) NON touchee (depart Ebonhold map 609 = correct).
-- Necessite RESTART (playercreateinfo charge au boot). Idempotent.
-- ============================================================================
UPDATE playercreateinfo SET map=654, zone=4756, position_x=-1451.53, position_y=1403.35, position_z=35.5561, orientation=0.333847 WHERE race=22 AND class<>6;
UPDATE playercreateinfo SET map=648, zone=4765, position_x=-8423.81, position_y=1361.3, position_z=104.671, orientation=1.55428 WHERE race=9 AND class<>6;
