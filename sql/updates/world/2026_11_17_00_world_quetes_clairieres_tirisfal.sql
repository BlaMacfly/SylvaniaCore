-- Clairieres de Tirisfal (depart mort-vivant).
-- 24970 "No Better Than the Zombies" : drapeau 0x10000 (rendu automatique par le journal) ajoute en 2019,
-- impossible de rendre la quete a Darnell. Valeur de LegionCore et de la TDB master.
UPDATE `quest_template` SET `Flags`=1572864 WHERE `ID`=24970;

-- 24974 "Ever So Lonely" : la laisse (73108, aura factice) ne declenchait rien sur le murloc.
-- Repris de LegionCore : le murloc force le joueur a invoquer le captif (73110 -> 73109 -> 38923), credit, disparition.
DELETE FROM `smart_scripts` WHERE `entryorguid`=1543 AND `source_type`=0 AND `id` IN (3,4,5);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(1543,0,3,4,8,0,100,0,73108,0,0,0,11,73110,0,0,0,0,0,7,0,0,0,0,0,0,0,'Vile Fin Puddlejumper - On Spellhit Murloc Leash - Cast Summon Puddlejumper: Force Cast'),
(1543,0,4,5,61,0,100,0,0,0,0,0,33,38923,0,0,0,0,0,7,0,0,0,0,0,0,0,'Vile Fin Puddlejumper - Linked - Quest Credit'),
(1543,0,5,0,61,0,100,0,0,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Vile Fin Puddlejumper - Linked - Despawn');

-- Captif rendu a Sedrick : credit avant la disparition (et non apres), comme LegionCore.
UPDATE `smart_scripts` SET `action_type`=33, `action_param1`=38887, `target_type`=23, `comment`='Captured Vile Fin Puddlejumper - On Distance To Creature - Quest Credit' WHERE `entryorguid`=38923 AND `source_type`=0 AND `id`=3;
UPDATE `smart_scripts` SET `action_type`=41, `action_param1`=0, `target_type`=1, `comment`='Captured Vile Fin Puddlejumper - Linked - Despawn Instant' WHERE `entryorguid`=38923 AND `source_type`=0 AND `id`=4;
