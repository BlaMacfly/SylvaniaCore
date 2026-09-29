-- Statue d Ohn ahra (102694), Un serment d allegeance (40955) : l aigle blanc apparaissait mais le
-- serment ne se validait pas. cast_flags=0 -> c est la STATUE qui lancait 203240 ; ce sort force son
-- lanceur a lancer 203239 (l aigle) puis 203156 (credit 102794, cible = lanceur) : le credit partait a
-- la statue. cast_flags=1 (le joueur lance), comme chez LegionCore. Signale en jeu par Blez le 29/09.
UPDATE npc_spellclick_spells SET cast_flags=1 WHERE npc_entry=102694 AND spell_id=203240;
