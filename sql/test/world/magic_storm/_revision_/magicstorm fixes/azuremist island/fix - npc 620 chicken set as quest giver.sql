-- fix - npc 620 chicken set as quest giver

UPDATE creature_template SET npcflag=2 WHERE entry=620;