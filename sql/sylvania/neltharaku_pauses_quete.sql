-- Neltharaku (21657), Shadowmoon Valley: make the flying questgiver accessible.
-- Its reference run speed (2.85714) and all flight coordinates remain unchanged.
-- Local accessibility adjustment, not a claimed retail waypoint timing:
-- wait 20 seconds at four existing, spaced nodes so players can target/interact.
-- Normal gossip already stops the creature for Creature.MovingStopTimeForPlayer.
-- Only update the path actually assigned to this creature; replay is idempotent.
UPDATE `waypoint_data` AS w
INNER JOIN `creature_template_addon` AS a ON a.`path_id` = w.`id` AND a.`entry` = 21657
SET w.`delay` = 20000
WHERE w.`id` = 756540 AND w.`point` IN (1, 10, 20, 30) AND w.`delay` = 0;
-- Rollback (original delays were zero): use the same join/filter, SET delay=0
-- and restrict to delay=20000 to preserve unrelated subsequent changes.
