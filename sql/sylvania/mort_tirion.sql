-- =====================================================================
-- Rivage brisé — la mort de Tirion, mise en scène
--
-- SIGNALÉ EN JEU : « p7 c'est Krosus qui plonge Tirion dans le fiel
-- normalement, et là pas de script de scénario ».
--
-- Séquence officielle, relevée sur Warcraft Wiki :
--   Tirion  « Stay back... it's a trap... the Light will protect me... »
--   Gul'dan « Ha, you fool! You stand before the temple of a GOD... »
--   Krosus surgit de la lave.
--   Gul'dan « Destroy him. »
--   Krosus souffle sur Tirion.
--   Tirion  « The Light... will... ahh! Aahhhh!! »  puis il sombre.
--   Thrall  « Fordring! »
--   Gul'dan « All you have worked for... » puis « Destroy them! »
--
-- Les huit répliques portent leur BroadcastTextId et leur Sound
-- d'origine : le client jouera la voix française et affichera son
-- propre texte. Le texte anglais porté ici n'est qu'un repère.
--
-- Groupes 20 et au-delà, pour ne rien écraser.
-- =====================================================================

DELETE FROM `creature_text` WHERE `GroupID` BETWEEN 20 AND 29
  AND `CreatureID` IN (90367, 90413, 90711, 90713);

INSERT INTO `creature_text`
 (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`,`TextRange`,`comment`) VALUES
 (90367,20,0,'Stay back... it''s a trap... the Light will protect me...',14,0,100,0,0,53452,99237,0,'mort de Tirion 1'),
 (90367,21,0,'The Light... will... ahh!  Aahhhh!!',14,0,100,0,0,53455,99240,0,'mort de Tirion 5'),
 (90413,20,0,'Ha, you fool! You stand before the temple of a GOD. Your pitiful Light cannot reach you here.',14,0,100,0,0,53453,99238,0,'mort de Tirion 2'),
 (90413,21,0,'Destroy him.',14,0,100,0,0,53454,99239,0,'mort de Tirion 4'),
 (90413,22,0,'All you have worked for, all you have sacrificed, just to see your champions fall to ash one by one.',14,0,100,0,0,53458,99243,0,'mort de Tirion 7'),
 (90413,23,0,'Destroy them!',14,0,100,0,0,53462,99247,0,'mort de Tirion 8'),
 (90711,20,0,'Fordring!',14,0,100,0,0,53456,99241,0,'mort de Tirion 6'),
 (90713,20,0,'We will never give in to hopelessness!',14,0,100,0,0,53459,99244,0,'mort de Tirion, riposte');
