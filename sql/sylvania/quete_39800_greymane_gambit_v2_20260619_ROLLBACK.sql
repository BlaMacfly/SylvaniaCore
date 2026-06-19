-- Rollback quete 39800 Greymane's Gambit v2 (2026-06-19)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=96663 AND SourceId=0 AND SourceGroup IN (2,3);
DELETE FROM smart_scripts WHERE entryorguid=96663 AND source_type=0 AND id IN (1,2);
