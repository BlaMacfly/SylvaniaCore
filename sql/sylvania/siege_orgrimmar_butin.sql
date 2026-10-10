-- Siege d Orgrimmar : butin d equipement (Guide d aventure).
-- Les boss qui meurent : une ligne creature_template_journal (2 objets tires a la mort, cf. Unit::Kill).
-- Protecteurs dechus et chamans Kor kron : un seul porteur par rencontre, sinon 2 objets par boss.
-- Parangons : les neuf, car seul le dernier meurt vraiment (les autres simulent leur mort).
INSERT IGNORE INTO creature_template_journal (entry, JournalEncounterID) VALUES (71454, 846); -- Malkorok
INSERT IGNORE INTO creature_template_journal (entry, JournalEncounterID) VALUES (71475, 849); -- Protecteurs dechus : Rook Stonetoe
INSERT IGNORE INTO creature_template_journal (entry, JournalEncounterID) VALUES (71515, 850); -- General Nazgrim
INSERT IGNORE INTO creature_template_journal (entry, JournalEncounterID) VALUES (71529, 851); -- Thok
INSERT IGNORE INTO creature_template_journal (entry, JournalEncounterID) VALUES (71859, 856); -- Chamans Kor kron : Haromm
INSERT IGNORE INTO creature_template_journal (entry, JournalEncounterID) VALUES (71466, 864); -- Mastodonte de fer
INSERT IGNORE INTO creature_template_journal (entry, JournalEncounterID) VALUES (71504, 865); -- Siegecrafter Blackfuse
INSERT IGNORE INTO creature_template_journal (entry, JournalEncounterID) VALUES (72276, 866); -- Norushen : Amalgame de corruption
INSERT IGNORE INTO creature_template_journal (entry, JournalEncounterID) VALUES (71734, 867); -- Sha de l orgueil
INSERT IGNORE INTO creature_template_journal (entry, JournalEncounterID) VALUES (72249, 868); -- Galakras
INSERT IGNORE INTO creature_template_journal (entry, JournalEncounterID) VALUES (71865, 869); -- Garrosh Hurlenfer
INSERT IGNORE INTO creature_template_journal (entry, JournalEncounterID) VALUES (71161, 853); -- Parangons
INSERT IGNORE INTO creature_template_journal (entry, JournalEncounterID) VALUES (71157, 853); -- Parangons
INSERT IGNORE INTO creature_template_journal (entry, JournalEncounterID) VALUES (71156, 853); -- Parangons
INSERT IGNORE INTO creature_template_journal (entry, JournalEncounterID) VALUES (71155, 853); -- Parangons
INSERT IGNORE INTO creature_template_journal (entry, JournalEncounterID) VALUES (71160, 853); -- Parangons
INSERT IGNORE INTO creature_template_journal (entry, JournalEncounterID) VALUES (71154, 853); -- Parangons
INSERT IGNORE INTO creature_template_journal (entry, JournalEncounterID) VALUES (71152, 853); -- Parangons
INSERT IGNORE INTO creature_template_journal (entry, JournalEncounterID) VALUES (71158, 853); -- Parangons
INSERT IGNORE INTO creature_template_journal (entry, JournalEncounterID) VALUES (71153, 853); -- Parangons

-- Rencontres qui finissent par un coffre : 2 objets tires parmi ceux du Guide, version selon la difficulte.
-- Larmes du Val (Immerseus) : 22 objets
DELETE FROM reference_loot_template WHERE Entry=990852;
INSERT INTO reference_loot_template (Entry,Item,Reference,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment) VALUES (990852,110761,0,0,0,1,1,1,1,'Guide 852');
INSERT INTO reference_loot_template (Entry,Item,Reference,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment) VALUES (990852,110784,0,0,0,1,1,1,1,'Guide 852');
INSERT INTO reference_loot_template (Entry,Item,Reference,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment) VALUES (990852,110785,0,0,0,1,1,1,1,'Guide 852');
INSERT INTO reference_loot_template (Entry,Item,Reference,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment) VALUES (990852,112382,0,0,0,1,1,1,1,'Guide 852');
INSERT INTO reference_loot_template (Entry,Item,Reference,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment) VALUES (990852,112383,0,0,0,1,1,1,1,'Guide 852');
INSERT INTO reference_loot_template (Entry,Item,Reference,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment) VALUES (990852,112416,0,0,0,1,1,1,1,'Guide 852');
INSERT INTO reference_loot_template (Entry,Item,Reference,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment) VALUES (990852,112417,0,0,0,1,1,1,1,'Guide 852');
INSERT INTO reference_loot_template (Entry,Item,Reference,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment) VALUES (990852,112418,0,0,0,1,1,1,1,'Guide 852');
INSERT INTO reference_loot_template (Entry,Item,Reference,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment) VALUES (990852,112419,0,0,0,1,1,1,1,'Guide 852');
INSERT INTO reference_loot_template (Entry,Item,Reference,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment) VALUES (990852,112420,0,0,0,1,1,1,1,'Guide 852');
INSERT INTO reference_loot_template (Entry,Item,Reference,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment) VALUES (990852,112421,0,0,0,1,1,1,1,'Guide 852');
INSERT INTO reference_loot_template (Entry,Item,Reference,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment) VALUES (990852,112422,0,0,0,1,1,1,1,'Guide 852');
INSERT INTO reference_loot_template (Entry,Item,Reference,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment) VALUES (990852,112423,0,0,0,1,1,1,1,'Guide 852');
INSERT INTO reference_loot_template (Entry,Item,Reference,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment) VALUES (990852,112424,0,0,0,1,1,1,1,'Guide 852');
INSERT INTO reference_loot_template (Entry,Item,Reference,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment) VALUES (990852,112425,0,0,0,1,1,1,1,'Guide 852');
INSERT INTO reference_loot_template (Entry,Item,Reference,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment) VALUES (990852,112426,0,0,0,1,1,1,1,'Guide 852');
INSERT INTO reference_loot_template (Entry,Item,Reference,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment) VALUES (990852,112427,0,0,0,1,1,1,1,'Guide 852');
INSERT INTO reference_loot_template (Entry,Item,Reference,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment) VALUES (990852,112428,0,0,0,1,1,1,1,'Guide 852');
INSERT INTO reference_loot_template (Entry,Item,Reference,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment) VALUES (990852,112429,0,0,0,1,1,1,1,'Guide 852');
INSERT INTO reference_loot_template (Entry,Item,Reference,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment) VALUES (990852,112445,0,0,0,1,1,1,1,'Guide 852');
INSERT INTO reference_loot_template (Entry,Item,Reference,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment) VALUES (990852,112447,0,0,0,1,1,1,1,'Guide 852');
INSERT INTO reference_loot_template (Entry,Item,Reference,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment) VALUES (990852,112448,0,0,0,1,1,1,1,'Guide 852');
DELETE FROM gameobject_loot_template WHERE Entry=990852;
INSERT INTO gameobject_loot_template (Entry,Item,Reference,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment) VALUES (990852,0,990852,100,0,1,0,2,2,'2 objets du Guide 852');
UPDATE gameobject_template SET data1=990852 WHERE entry=221776;
-- Reserve deverrouillee (Butins de Pandarie) : 21 objets
DELETE FROM reference_loot_template WHERE Entry=990870;
INSERT INTO reference_loot_template (Entry,Item,Reference,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment) VALUES (990870,112825,0,0,0,1,1,1,1,'Guide 870');
INSERT INTO reference_loot_template (Entry,Item,Reference,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment) VALUES (990870,112826,0,0,0,1,1,1,1,'Guide 870');
INSERT INTO reference_loot_template (Entry,Item,Reference,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment) VALUES (990870,112827,0,0,0,1,1,1,1,'Guide 870');
INSERT INTO reference_loot_template (Entry,Item,Reference,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment) VALUES (990870,112828,0,0,0,1,1,1,1,'Guide 870');
INSERT INTO reference_loot_template (Entry,Item,Reference,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment) VALUES (990870,112829,0,0,0,1,1,1,1,'Guide 870');
INSERT INTO reference_loot_template (Entry,Item,Reference,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment) VALUES (990870,112831,0,0,0,1,1,1,1,'Guide 870');
INSERT INTO reference_loot_template (Entry,Item,Reference,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment) VALUES (990870,112832,0,0,0,1,1,1,1,'Guide 870');
INSERT INTO reference_loot_template (Entry,Item,Reference,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment) VALUES (990870,112833,0,0,0,1,1,1,1,'Guide 870');
INSERT INTO reference_loot_template (Entry,Item,Reference,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment) VALUES (990870,112834,0,0,0,1,1,1,1,'Guide 870');
INSERT INTO reference_loot_template (Entry,Item,Reference,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment) VALUES (990870,112835,0,0,0,1,1,1,1,'Guide 870');
INSERT INTO reference_loot_template (Entry,Item,Reference,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment) VALUES (990870,112836,0,0,0,1,1,1,1,'Guide 870');
INSERT INTO reference_loot_template (Entry,Item,Reference,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment) VALUES (990870,112837,0,0,0,1,1,1,1,'Guide 870');
INSERT INTO reference_loot_template (Entry,Item,Reference,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment) VALUES (990870,112838,0,0,0,1,1,1,1,'Guide 870');
INSERT INTO reference_loot_template (Entry,Item,Reference,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment) VALUES (990870,112839,0,0,0,1,1,1,1,'Guide 870');
INSERT INTO reference_loot_template (Entry,Item,Reference,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment) VALUES (990870,112841,0,0,0,1,1,1,1,'Guide 870');
INSERT INTO reference_loot_template (Entry,Item,Reference,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment) VALUES (990870,112842,0,0,0,1,1,1,1,'Guide 870');
INSERT INTO reference_loot_template (Entry,Item,Reference,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment) VALUES (990870,112843,0,0,0,1,1,1,1,'Guide 870');
INSERT INTO reference_loot_template (Entry,Item,Reference,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment) VALUES (990870,112844,0,0,0,1,1,1,1,'Guide 870');
INSERT INTO reference_loot_template (Entry,Item,Reference,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment) VALUES (990870,112845,0,0,0,1,1,1,1,'Guide 870');
INSERT INTO reference_loot_template (Entry,Item,Reference,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment) VALUES (990870,112846,0,0,0,1,1,1,1,'Guide 870');
INSERT INTO reference_loot_template (Entry,Item,Reference,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment) VALUES (990870,112847,0,0,0,1,1,1,1,'Guide 870');
DELETE FROM gameobject_loot_template WHERE Entry=990870;
INSERT INTO gameobject_loot_template (Entry,Item,Reference,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment) VALUES (990870,0,990870,100,0,1,0,2,2,'2 objets du Guide 870');
UPDATE gameobject_template SET data1=990870 WHERE entry=222749;
