-- Rollback quete 39800 Greymane's Gambit v3 (2026-06-19)
DELETE FROM smart_scripts WHERE entryorguid=96663 AND source_type=0 AND id IN (1,2,3);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=99923 AND SourceEntry=0;
DELETE FROM gossip_menu_option WHERE MenuId=99923;
DELETE FROM gossip_menu WHERE MenuID=99923;
UPDATE creature_template SET gossip_menu_id=0 WHERE entry=96663;
UPDATE creature SET npcflag=0 WHERE guid=280001398;
