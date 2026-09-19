-- Rhonormu : le voyage dans le temps de Silithus.
--
-- Le PNJ existait en gabarit mais sans spawn, sans script et sans npcflag : il etait
-- donc pose depuis le peuplement de La Plaie, mais muet et non interpellable.
--
-- Mecanisme, calque sur un precedent deja present dans nos donnees -- l'echange de
-- terrain 976 utilise exactement ce patron avec le sort 118233 :
--   l'echange 1817 (La Plaie) exige le niveau 110 ET l'absence de l'aura 255152.
--   Rhonormu pose ou retire l'aura, puis PhasingHandler::OnConditionChange reevalue
--   les cartes visibles ET les phases. Terrain et population basculent sur place.
--
-- Les phases 2392 et 2407 sont conditionnees sur CONDITION_TERRAIN_SWAP 1817 : elles
-- suivent donc automatiquement, sans ligne supplementaire.

UPDATE `creature_template`
   SET `ScriptName` = 'npc_rhonormu_133263',
       `npcflag`    = 1                      -- GOSSIP : sans cela, on ne peut pas lui parler
 WHERE `entry` = 133263;

-- L'echange vers La Plaie ne s'applique plus a qui voyage dans le temps.
-- Meme ElseGroup que la condition de niveau : les deux sont donc combinees en ET.
DELETE FROM `conditions`
 WHERE `SourceTypeOrReferenceId` = 25 AND `SourceEntry` = 1817 AND `ConditionTypeOrReference` = 1;
INSERT INTO `conditions`
 (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`,
  `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`,
  `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(25, 0, 1817, 0, 0, 1, 0, 255152, 2, 0, 1, 0, 0, '', 'La Plaie : seulement si le joueur ne voyage pas dans le temps (aura 255152, effet 2)');

-- Annulation : db-backups/rhonormu-*.sql

-- Rhonormu doit etre visible des DEUX cotes, sinon le voyage est a sens unique : un
-- joueur renvoye dans le passe passe en phase 2392 et ne le verrait plus pour revenir.
-- Sa position le permet : le terrain y est identique sur la carte 1 et sur la 1817
-- (9.63 des deux cotes), il ne flottera donc ni ne s enterrera dans aucune version.
UPDATE `creature` SET `PhaseId` = 0 WHERE `id` = 133263;
