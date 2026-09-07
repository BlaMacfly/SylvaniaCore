-- Quete 46765 "Le rivage Brise : enquete sur la Legion" : objet 147430 introuvable.
--
-- Quete classique (QuestType 2, donneur present), donc reellement jouable, mais son
-- objectif n'existait dans aucune table de butin. Wowhead liste 199 lacheurs sur tout
-- le jeu : 199 existent dans notre creature_template, mais seulement 58 sont spawnes
-- chez nous. Sur ces 58, 49 lachent effectivement l'objet.
--
-- Taux releves une par une sur les fiches PNJ (pas la fiche objet), avec controle du
-- statut HTTP 200 et du marqueur g_npcs. Ils vont de 0,03 a 100 pour cent : les taux
-- tres bas sont conformes au releve, et l'abondance de sources compense.
-- QuestRequired = 1 : l'objet ne tombe que pour un joueur ayant la quete.

DELETE FROM `creature_loot_template` WHERE `Item` = 147430;
INSERT INTO `creature_loot_template`
  (`Entry`,`Item`,`Reference`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(91535,147430,0,7.6900,1,1,0,1,1,'Quartermaster Ricard'),
(91590,147430,0,100.0000,1,1,0,1,1,'Apothecary Withers'),
(91693,147430,0,12.5000,1,1,0,1,1,'Black Rose Apothecary'),
(92333,147430,0,25.0000,1,1,0,1,1,'Grue cendrecime'),
(92792,147430,0,33.3300,1,1,0,1,1,'Nightmare Rider'),
(95958,147430,0,20.0000,1,1,0,1,1,'Floating Treasure'),
(98112,147430,0,16.6700,1,1,0,1,1,'Steward Dayton'),
(100054,147430,0,10.0000,1,1,0,1,1,'Feltotem Warmonger'),
(100055,147430,0,9.0900,1,1,0,1,1,'Feltotem Bloodsinger'),
(101390,147430,0,1.2700,1,1,0,1,1,'Arch-Desecrator Malithar'),
(102660,147430,0,11.1100,1,1,0,1,1,'Jandvik Metalsmith'),
(102741,147430,0,1.2200,1,1,0,1,1,'Highcliff Gull'),
(104845,147430,0,1.1900,1,1,0,1,1,'Caged Macaw'),
(105645,147430,0,2.5600,1,1,0,1,1,'Penned Turtle'),
(105646,147430,0,8.3300,1,1,0,1,1,'Captive Basilisk'),
(105650,147430,0,2.5600,1,1,0,1,1,'Confined Raptor'),
(105687,147430,0,100.0000,1,1,0,1,1,'Valkyra Shieldmaiden'),
(106798,147430,0,1.0400,1,1,0,1,1,'Nora Blackfire'),
(108027,147430,0,1.1100,1,1,0,1,1,'Webmistress Shinaris'),
(108033,147430,0,2.3800,1,1,0,1,1,'Fal''dorei Web Walker'),
(108034,147430,0,2.3800,1,1,0,1,1,'Fal''dorei Reaver'),
(110354,147430,0,0.8400,1,1,0,1,1,'Coryn'),
(110839,147430,0,1.1600,1,1,0,1,1,'Stormwing Drake'),
(111643,147430,0,6.2500,1,1,0,1,1,'Cove Seagull'),
(112090,147430,0,16.6700,1,1,0,1,1,'Shoalfin Warrior'),
(115054,147430,0,0.1900,1,1,0,1,1,'Wyrmtongue Scavenger'),
(115056,147430,0,0.1300,1,1,0,1,1,'Felwing Devourer'),
(117088,147430,0,0.0500,1,1,0,1,1,'Arachniarch Bybee'),
(117093,147430,0,0.9000,1,1,0,1,1,'Felbringer Xar''thok'),
(117094,147430,0,1.0800,1,1,0,1,1,'Malorus the Soulkeeper'),
(117096,147430,0,1.2300,1,1,0,1,1,'Potionmaster Gloop'),
(117136,147430,0,1.4200,1,1,0,1,1,'Doombringer Zar''thoz'),
(117289,147430,0,0.0300,1,1,0,1,1,'Felblade Sentry'),
(117559,147430,0,0.5400,1,1,0,1,1,'Wrathguard Dreadblade'),
(118322,147430,0,0.2800,1,1,0,1,1,'Felborne Punisher'),
(118390,147430,0,0.3200,1,1,0,1,1,'Toiling Collector'),
(118971,147430,0,0.8300,1,1,0,1,1,'Felfin Terrorscale'),
(119139,147430,0,0.2100,1,1,0,1,1,'Stoneblood Basilisk'),
(119634,147430,0,0.0600,1,1,0,1,1,'Restless Remains'),
(119788,147430,0,0.1500,1,1,0,1,1,'Ravenous Carrionstalker'),
(120323,147430,0,0.1600,1,1,0,1,1,'Weary Lion Seal'),
(120342,147430,0,0.5900,1,1,0,1,1,'Dread Felbat'),
(120386,147430,0,5.8200,1,1,0,1,1,'Scavenging Crow'),
(120820,147430,0,0.1100,1,1,0,1,1,'Fixated Corruptor'),
(120896,147430,0,0.0500,1,1,0,1,1,'Dark Tormentor'),
(121034,147430,0,0.1100,1,1,0,1,1,'Ravenous Felstalker'),
(121035,147430,0,0.0600,1,1,0,1,1,'Felblade Sentry'),
(121058,147430,0,0.0700,1,1,0,1,1,'Wrathguard Soulflayer'),
(121346,147430,0,0.3000,1,1,0,1,1,'Dreadwing Terror');

-- Les lacheurs qui n'avaient encore aucune table doivent pointer sur elle.
UPDATE `creature_template` SET `lootid` = `entry` WHERE `entry` IN (91535,91590,91693,92333,92792,95958,98112,100054,100055,101390,102660,102741,104845,105645,105646,105650,105687,106798,108027,108033,108034,110354,110839,111643,112090,115054,115056,117088,117093,117094,117096,117136,117289,117559,118322,118390,118971,119139,119634,119788,120323,120342,120386,120820,120896,121034,121035,121058,121346) AND `lootid` = 0;

-- 100231 : seul objet valide de son releve, Meteorite gangrenee (147869), objet de
-- pacotille. Il etait ecarte par mon filtre "deja utilise ailleurs", trop prudent ici.
DELETE FROM `creature_loot_template` WHERE `Entry` = 100231 AND `Item` = 147869;
INSERT INTO `creature_loot_template`
  (`Entry`,`Item`,`Reference`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(100231,147869,0,5.8800,0,1,0,1,1,'Meteorite gangrenee');
UPDATE `creature_template` SET `lootid` = `entry` WHERE `entry` = 100231 AND `lootid` = 0;
