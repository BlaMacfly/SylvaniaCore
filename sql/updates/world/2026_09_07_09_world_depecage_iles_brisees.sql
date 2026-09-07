-- Depecage manquant : betes des Iles Brisees (carte 1220).
--
-- 81 betes spawnees avaient skinloot = 0. Relevees sur Wowhead (onglet 'skinning',
-- distinct de l'onglet des butins), avec controle du statut HTTP 200 et du marqueur
-- g_npcs. Aucun refus rencontre.
--
-- 67 n'ont AUCUN onglet depecage sur Wowhead : oiseaux, insectes, gasteropodes,
-- araignees, tortues en cage. Verifie a la main sur cinq d'entre elles (Suramar
-- Skyhunter, Gritslime Snail, Ruins Recluse, Cove Seagull, Penned Turtle) : l'onglet
-- est reellement absent, ce n'est pas un defaut d'extraction. Elles ne sont pas touchees.
--
-- Methode validee avant collecte sur un temoin dont la table existe deja chez nous
-- (90134 Llothien Grizzly) : les 8 memes objets, memes intervalles de pile, ecarts de
-- taux sous le bruit statistique. Nos donnees existantes viennent de la meme source.
--
-- Attention, l'onglet 'skinning' de Wowhead n'est PAS du JSON strict comme celui des
-- butins : les cles y sont non quotees (count:148807,stack:[1,2]) et il y a une espace
-- avant outof. JSON.parse echoue, et un motif trop strict renvoie zero partout.

DELETE FROM `skinning_loot_template` WHERE `Entry` IN (89013,89014,89016,89385,89386,89391,89652,89653,89696,89891,97928,98356,111380,113408);
INSERT INTO `skinning_loot_template`
  (`Entry`,`Item`,`Reference`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(89013,124113,0,99.5800,0,1,0,1,2,'Azsuna Lion Seal'),
(89013,124124,0,1.6500,0,1,0,1,1,'Azsuna Lion Seal'),
(89013,124439,0,13.0700,0,1,0,2,8,'Azsuna Lion Seal'),
(89013,129746,0,1.7000,0,1,0,1,1,'Azsuna Lion Seal'),
(89013,129888,0,1.7800,0,1,0,1,1,'Azsuna Lion Seal'),
(89013,129906,0,17.8800,0,1,0,1,1,'Azsuna Lion Seal'),
(89013,134807,0,15.8800,0,1,0,1,1,'Azsuna Lion Seal'),
(89014,124113,0,99.9400,0,1,0,1,2,'Grassland Heron'),
(89014,124438,0,17.3400,0,1,0,3,8,'Grassland Heron'),
(89014,129888,0,35.5800,0,1,0,1,1,'Grassland Heron'),
(89014,139894,0,2.1800,0,1,0,1,1,'Grassland Heron'),
(89016,124113,0,99.4900,0,1,0,1,2,'Ravyn-Drath'),
(89016,124439,0,16.4600,0,1,0,2,8,'Ravyn-Drath'),
(89016,129860,0,2.7000,0,1,0,1,1,'Ravyn-Drath'),
(89016,129888,0,2.8300,0,1,0,1,1,'Ravyn-Drath'),
(89016,129906,0,15.9400,0,1,0,1,1,'Ravyn-Drath'),
(89385,124113,0,100.0000,0,1,0,1,2,'Azsuna Fox'),
(89385,124124,0,0.8100,0,1,0,1,1,'Azsuna Fox'),
(89385,124438,0,13.4100,0,1,0,3,8,'Azsuna Fox'),
(89385,124439,0,12.2400,0,1,0,3,8,'Azsuna Fox'),
(89385,129746,0,1.1800,0,1,0,1,1,'Azsuna Fox'),
(89385,129888,0,8.0600,0,1,0,1,1,'Azsuna Fox'),
(89386,124115,0,99.2400,0,1,0,1,3,'Cliffwing Hippogryph'),
(89386,124124,0,1.3500,0,1,0,1,1,'Cliffwing Hippogryph'),
(89386,124438,0,16.6800,0,1,0,3,8,'Cliffwing Hippogryph'),
(89386,129746,0,1.5200,0,1,0,1,1,'Cliffwing Hippogryph'),
(89386,129894,0,4.0300,0,1,0,1,1,'Cliffwing Hippogryph'),
(89386,129908,0,55.0500,0,1,0,1,1,'Cliffwing Hippogryph'),
(89386,134806,0,19.0100,0,1,0,1,1,'Cliffwing Hippogryph'),
(89391,124113,0,100.0000,0,1,0,1,1,'Cursefeather Owl'),
(89391,124438,0,4.5900,0,1,0,3,8,'Cursefeather Owl'),
(89391,129888,0,8.1800,0,1,0,1,1,'Cursefeather Owl'),
(89652,124113,0,100.0000,0,1,0,1,2,'Shallows Heron'),
(89652,124438,0,6.5600,0,1,0,3,8,'Shallows Heron'),
(89652,129860,0,1.5900,0,1,0,1,1,'Shallows Heron'),
(89652,129888,0,18.0300,0,1,0,1,1,'Shallows Heron'),
(89652,139894,0,0.7300,0,1,0,1,1,'Shallows Heron'),
(89653,124115,0,99.9900,0,1,0,1,3,'Gangamesh'),
(89653,124438,0,10.3400,0,1,0,2,8,'Gangamesh'),
(89653,124439,0,7.0700,0,1,0,1,8,'Gangamesh'),
(89653,129862,0,8.3100,0,1,0,1,1,'Gangamesh'),
(89653,129894,0,12.6400,0,1,0,1,1,'Gangamesh'),
(89696,124115,0,99.9700,0,1,0,1,3,'Horned Leatherback'),
(89696,124438,0,13.1400,0,1,0,1,8,'Horned Leatherback'),
(89696,129862,0,1.0100,0,1,0,1,1,'Horned Leatherback'),
(89696,129894,0,25.9800,0,1,0,1,1,'Horned Leatherback'),
(89891,124115,0,99.9800,0,1,0,1,3,'Dragon Turtle'),
(89891,124438,0,9.8200,0,1,0,3,8,'Dragon Turtle'),
(89891,129746,0,1.3500,0,1,0,1,1,'Dragon Turtle'),
(89891,129862,0,2.3200,0,1,0,1,1,'Dragon Turtle'),
(89891,129865,0,5.2200,0,1,0,1,1,'Dragon Turtle'),
(89891,129894,0,4.5600,0,1,0,1,1,'Dragon Turtle'),
(89891,139894,0,0.7700,0,1,0,1,1,'Dragon Turtle'),
(97928,124115,0,99.9500,0,1,0,1,1,'Tamed Coralback'),
(97928,124438,0,13.2100,0,1,0,3,8,'Tamed Coralback'),
(97928,129862,0,3.5900,0,1,0,1,1,'Tamed Coralback'),
(97928,129894,0,15.6200,0,1,0,1,1,'Tamed Coralback'),
(98356,124113,0,100.0000,0,1,0,1,1,'Corrupted Great Eagle'),
(98356,124438,0,4.5500,0,1,0,5,7,'Corrupted Great Eagle'),
(98356,129746,0,2.2700,0,1,0,1,1,'Corrupted Great Eagle'),
(98356,129888,0,2.2700,0,1,0,1,1,'Corrupted Great Eagle'),
(111380,124115,0,100.0000,0,1,0,1,1,'Killer Orca'),
(111380,124439,0,72.5500,0,1,0,3,6,'Killer Orca'),
(111380,129862,0,45.1000,0,1,0,1,1,'Killer Orca'),
(111380,129894,0,1.9600,0,1,0,1,1,'Killer Orca'),
(113408,124113,0,100.0000,0,1,0,1,1,'Salty');

UPDATE `creature_template` SET `skinloot` = `entry` WHERE `entry` IN (89013,89014,89016,89385,89386,89391,89652,89653,89696,89891,97928,98356,111380,113408);
