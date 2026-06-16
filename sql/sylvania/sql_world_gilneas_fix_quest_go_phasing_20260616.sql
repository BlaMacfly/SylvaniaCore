-- ============================================================================
-- CORRECTIF durable — Gilneas/Worgen (map 654) : phasing des GameObjects de
-- quete (objets de quete INVISIBLES). 2026-06-16.
--
-- Signale en jeu : quete 14348 "Impossible de s en charger seul" - les Black
-- Gunpowder Keg (196403) etaient invisibles (PhaseId=0) alors que le joueur et
-- les abominations sont en PhaseId 182. Diff couche 2 (CPP) : des GO pre-existants
-- de Gilneas etaient en PhaseId=0 alors que le CPP leur donne une phase story
-- (183/182/170/169/181/171/186/172) -> invisibles dans la bonne phase du joueur.
--
-- On ne fait QUE "phase 0 -> phase story du CPP" (on n enleve AUCUNE phase
-- existante = sous-ensemble sur). Match par entry+position vs CPP. Necessite
-- RESTART (phasing GO charge au boot). Idempotent (UPDATE par guid).
-- ============================================================================
UPDATE gameobject SET PhaseId=182 WHERE map=654 AND id=196403;
UPDATE gameobject SET PhaseId=186 WHERE guid=21009562 AND map=654;
UPDATE gameobject SET PhaseId=172 WHERE guid=20406560 AND map=654;
UPDATE gameobject SET PhaseId=171 WHERE guid=20406559 AND map=654;
UPDATE gameobject SET PhaseId=171 WHERE guid=20406558 AND map=654;
UPDATE gameobject SET PhaseId=170 WHERE guid=20406553 AND map=654;
UPDATE gameobject SET PhaseId=170 WHERE guid=20406552 AND map=654;
UPDATE gameobject SET PhaseId=170 WHERE guid=20406547 AND map=654;
UPDATE gameobject SET PhaseId=170 WHERE guid=20406546 AND map=654;
UPDATE gameobject SET PhaseId=170 WHERE guid=20406536 AND map=654;
UPDATE gameobject SET PhaseId=169 WHERE guid=20406522 AND map=654;
UPDATE gameobject SET PhaseId=169 WHERE guid=20406521 AND map=654;
UPDATE gameobject SET PhaseId=169 WHERE guid=20406520 AND map=654;
UPDATE gameobject SET PhaseId=169 WHERE guid=20406518 AND map=654;
UPDATE gameobject SET PhaseId=182 WHERE guid=51003254 AND map=654;
UPDATE gameobject SET PhaseId=183 WHERE guid=51003298 AND map=654;
UPDATE gameobject SET PhaseId=183 WHERE guid=51003297 AND map=654;
UPDATE gameobject SET PhaseId=183 WHERE guid=51003296 AND map=654;
UPDATE gameobject SET PhaseId=183 WHERE guid=51003295 AND map=654;
UPDATE gameobject SET PhaseId=183 WHERE guid=51003294 AND map=654;
UPDATE gameobject SET PhaseId=183 WHERE guid=51003293 AND map=654;
UPDATE gameobject SET PhaseId=183 WHERE guid=51003292 AND map=654;
UPDATE gameobject SET PhaseId=183 WHERE guid=51003291 AND map=654;
UPDATE gameobject SET PhaseId=183 WHERE guid=51003290 AND map=654;
UPDATE gameobject SET PhaseId=183 WHERE guid=51003289 AND map=654;
UPDATE gameobject SET PhaseId=183 WHERE guid=51003288 AND map=654;
UPDATE gameobject SET PhaseId=183 WHERE guid=51003287 AND map=654;
UPDATE gameobject SET PhaseId=183 WHERE guid=51003286 AND map=654;
UPDATE gameobject SET PhaseId=183 WHERE guid=51003285 AND map=654;
UPDATE gameobject SET PhaseId=183 WHERE guid=51003284 AND map=654;
UPDATE gameobject SET PhaseId=183 WHERE guid=51003283 AND map=654;
UPDATE gameobject SET PhaseId=183 WHERE guid=51003282 AND map=654;
UPDATE gameobject SET PhaseId=183 WHERE guid=51003281 AND map=654;
UPDATE gameobject SET PhaseId=183 WHERE guid=51003280 AND map=654;
UPDATE gameobject SET PhaseId=183 WHERE guid=51003279 AND map=654;
UPDATE gameobject SET PhaseId=183 WHERE guid=51003278 AND map=654;
UPDATE gameobject SET PhaseId=183 WHERE guid=51003277 AND map=654;
UPDATE gameobject SET PhaseId=183 WHERE guid=51003276 AND map=654;
UPDATE gameobject SET PhaseId=183 WHERE guid=51003275 AND map=654;
UPDATE gameobject SET PhaseId=183 WHERE guid=51003274 AND map=654;
UPDATE gameobject SET PhaseId=183 WHERE guid=51003273 AND map=654;
UPDATE gameobject SET PhaseId=183 WHERE guid=51003272 AND map=654;
UPDATE gameobject SET PhaseId=183 WHERE guid=51003271 AND map=654;
UPDATE gameobject SET PhaseId=183 WHERE guid=51003270 AND map=654;
UPDATE gameobject SET PhaseId=183 WHERE guid=51003269 AND map=654;
UPDATE gameobject SET PhaseId=183 WHERE guid=51003268 AND map=654;
UPDATE gameobject SET PhaseId=183 WHERE guid=51003267 AND map=654;
UPDATE gameobject SET PhaseId=183 WHERE guid=51003266 AND map=654;
UPDATE gameobject SET PhaseId=183 WHERE guid=51003265 AND map=654;
UPDATE gameobject SET PhaseId=183 WHERE guid=51003264 AND map=654;
UPDATE gameobject SET PhaseId=183 WHERE guid=51003263 AND map=654;
UPDATE gameobject SET PhaseId=182 WHERE guid=51003262 AND map=654;
UPDATE gameobject SET PhaseId=181 WHERE guid=51003260 AND map=654;
UPDATE gameobject SET PhaseId=182 WHERE guid=51003258 AND map=654;
UPDATE gameobject SET PhaseId=182 WHERE guid=51003244 AND map=654;
UPDATE gameobject SET PhaseId=181 WHERE guid=51003242 AND map=654;
UPDATE gameobject SET PhaseId=181 WHERE guid=51003239 AND map=654;
