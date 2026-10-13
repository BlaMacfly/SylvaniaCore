-- DB/Quests: Wings Over Mount Hyjal (25985) n'est donnee que par Tiala Whitemane (40833), et rendue a Choluna (41005)
-- d'apres Wowhead ; Choluna la proposait aussi.
DELETE FROM `creature_queststarter` WHERE `quest` = 25985 AND `id` = 41005;
