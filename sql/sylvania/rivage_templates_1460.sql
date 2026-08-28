-- =====================================================================
-- Rivage brise (carte 1460) -- MODELES DE CREATURES incomplets
--
-- Signale en jeu : « exemple lui n'est pas attaquable », capture d'un
-- .npc info montrant Felguard Legionnaire (109591) en Level: 1.
--
-- Nos creature_template de l'epoque Legion sont des SOUCHES : sur les
-- 152 entrees exclusives a cette carte, 141 sont au niveau 1. La
-- faction, corrigee au tour precedent, n'etait que la partie visible.
--
-- Divergences relevees face au dump de reference :
--   minlevel  150/152     unit_flags2  147/152
--   maxlevel  145/152     unit_flags   136/152
--   unit_class 62/152     speed_run     55/152
--
-- EXCLUS VOLONTAIREMENT du correctif :
--   AIName      -- 32 divergences, mais transposer pourrait defaire un
--                  comportement pose sciemment chez nous.
--   flags_extra -- porte des drapeaux que le coeur calcule lui-meme,
--                  dont CREATURE_FLAG_EXTRA_DUNGEON_BOSS, pose au
--                  chargement depuis instance_encounters.
--
-- PORTEE : 151 entrees, toutes exclusives a la carte 1460. Les entrees
-- possedant un spawn ailleurs sont ecartees -- ce sont des declencheurs
-- invisibles pour lesquels les valeurs actuelles sont correctes.
--
-- Retour arriere : chantiers/rivage_brise/retour_templates_1460.sql
-- =====================================================================

UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `speed_run`=1, `unit_class`=8, `unit_flags2`=2048 WHERE `entry`=90506; -- Felfire Imp
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `speed_run`=1.58714, `speed_walk`=0.8888, `unit_flags`=32768, `unit_flags2`=4194304 WHERE `entry`=90515; -- Infernal Siegebreaker
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `unit_flags`=32768, `unit_flags2`=4196352 WHERE `entry`=90516; -- Mo'arg Painbringer
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `unit_class`=8, `unit_flags2`=2048 WHERE `entry`=90525; -- Eredar Chaos Guard
UPDATE `creature_template` SET `maxlevel`=110, `mechanic_immune_mask`=617299967, `minlevel`=110, `speed_run`=2, `unit_class`=2, `unit_flags`=33536, `unit_flags2`=4196352 WHERE `entry`=90544; -- Krosus
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `unit_flags2`=4196352 WHERE `entry`=90677; -- Wrathguard Dreadblade
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `unit_flags`=32768, `unit_flags2`=2097152 WHERE `entry`=90686; -- Felstalker Dreadhound
UPDATE `creature_template` SET `maxlevel`=105, `minlevel`=105, `unit_class`=8, `unit_flags`=33536, `unit_flags2`=4196352 WHERE `entry`=90688; -- Tichondrius the Darkener
UPDATE `creature_template` SET `maxlevel`=110, `mechanic_immune_mask`=617299967, `minlevel`=110, `speed_run`=1.42857, `unit_flags`=32768, `unit_flags2`=2099200 WHERE `entry`=90705; -- Dread Commander Arganoth
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `speed_run`=1.42857, `speed_walk`=1.42857, `unit_class`=2, `unit_flags`=36872, `unit_flags2`=2099200 WHERE `entry`=90708; -- Vol'jin
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `speed_run`=1.42857, `speed_walk`=1.42857, `unit_class`=2, `unit_flags`=36872, `unit_flags2`=2099200 WHERE `entry`=90709; -- Lady Sylvanas Windrunner
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `speed_run`=1.42857, `speed_walk`=1.42857, `unit_flags`=36872, `unit_flags2`=2099200 WHERE `entry`=90710; -- Baine Bloodhoof
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `speed_run`=1.42857, `speed_walk`=1.42857, `unit_class`=2, `unit_flags`=36872, `unit_flags2`=2099200 WHERE `entry`=90711; -- Thrall
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `speed_run`=1.42857, `speed_walk`=1.42857, `unit_class`=2, `unit_flags`=36872, `unit_flags2`=2099200 WHERE `entry`=90712; -- Earthen Ring Shaman
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `speed_run`=1.42857, `unit_flags`=36872, `unit_flags2`=2099200 WHERE `entry`=90713; -- King Varian Wrynn
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `speed_run`=1.42857, `unit_class`=8, `unit_flags`=36872, `unit_flags2`=2099200 WHERE `entry`=90714; -- Lady Jaina Proudmoore
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `speed_run`=1.42857, `unit_flags`=33554432, `unit_flags2`=1073743872 WHERE `entry`=90716; -- Gelbin Mekkatorque
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `speed_run`=1.42857, `unit_flags`=36872, `unit_flags2`=2099200 WHERE `entry`=90717; -- Genn Greymane
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `speed_run`=1.42857, `unit_class`=8, `unit_flags`=32768, `unit_flags2`=2099200 WHERE `entry`=91353; -- Kirin Tor Battle-Mage
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `speed_run`=0.992063, `unit_flags`=32768, `unit_flags2`=2131968 WHERE `entry`=91588; -- Fel Lord Kurduz
UPDATE `creature_template` SET `maxlevel`=105, `minlevel`=105, `unit_class`=8, `unit_flags`=33536, `unit_flags2`=4196352 WHERE `entry`=91902; -- Brutallus
UPDATE `creature_template` SET `minlevel`=110, `npcflag`=0, `unit_flags`=32768 WHERE `entry`=91949; -- Gnomeregan Tinkerer
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `unit_flags`=33536, `unit_flags2`=1073743872 WHERE `entry`=91951; -- Highlord Tirion Fordring
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `speed_run`=1.58714, `speed_walk`=0.8888, `unit_flags2`=2048 WHERE `entry`=91967; -- Infernal Siegebreaker
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `speed_run`=1, `unit_flags`=32768, `unit_flags2`=2099200 WHERE `entry`=91970; -- Felguard Invader
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `speed_run`=1, `unit_flags`=33554496, `unit_flags2`=2113536 WHERE `entry`=92061; -- Cannon
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `unit_class`=8, `unit_flags`=33536, `unit_flags2`=2048 WHERE `entry`=92074; -- Alliance Priest
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `unit_class`=2, `unit_flags`=262912, `unit_flags2`=2097152 WHERE `entry`=92121; -- Argent Dawnbringer
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `unit_flags`=537166336, `unit_flags2`=2099201 WHERE `entry`=92122; -- Gnomeregan Tinkerer
UPDATE `creature_template` SET `maxlevel`=105, `minlevel`=105, `unit_class`=8, `unit_flags`=33536, `unit_flags2`=4196352 WHERE `entry`=92558; -- Arkethrax
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `unit_flags`=32768, `unit_flags2`=4194304 WHERE `entry`=92564; -- Mo'arg Painbringer
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `unit_flags`=32768, `unit_flags2`=2099200 WHERE `entry`=92586; -- Ironforge Cannoneer
UPDATE `creature_template` SET `minlevel`=110, `npcflag`=0, `speed_run`=1.427, `unit_flags`=36872 WHERE `entry`=93219; -- Gilnean Royal Guard
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `speed_run`=1.42857, `speed_walk`=1.42857, `unit_flags`=36872, `unit_flags2`=2099200 WHERE `entry`=93704; -- Darkspear Headhunter
UPDATE `creature_template` SET `maxlevel`=110, `mechanic_immune_mask`=617299967, `minlevel`=110, `speed_run`=1.42857, `unit_flags`=32832, `unit_flags2`=1073743872 WHERE `entry`=93719; -- Fel Commander Azgalor
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `unit_flags`=32768, `unit_flags2`=2099200 WHERE `entry`=94189; -- Living Felblaze
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `unit_flags`=32768, `unit_flags2`=2099200 WHERE `entry`=94190; -- Burning Sentry
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `speed_run`=1, `unit_flags`=32768, `unit_flags2`=2099200 WHERE `entry`=94191; -- Burning Terrorhound
UPDATE `creature_template` SET `minlevel`=110, `npcflag`=0, `unit_flags`=537166336, `unit_flags2`=2099201 WHERE `entry`=94209; -- Stormwind Knight
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `unit_class`=2, `unit_flags`=32768, `unit_flags2`=2099200 WHERE `entry`=94223; -- Argent Dawnbringer
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `unit_flags`=33536, `unit_flags2`=1073743872 WHERE `entry`=94276; -- Gul'dan
UPDATE `creature_template` SET `minlevel`=110, `npcflag`=0, `speed_run`=1.427, `unit_flags`=36872 WHERE `entry`=97486; -- Gilnean Royal Guard
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `speed_run`=1.42857, `unit_class`=8, `unit_flags`=36872, `unit_flags2`=2099200 WHERE `entry`=97496; -- Kirin Tor Battle-Mage
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `unit_class`=2, `unit_flags`=33536, `unit_flags2`=2099200 WHERE `entry`=97502; -- Argent Dawnbringer
UPDATE `creature_template` SET `minlevel`=110, `npcflag`=0, `unit_flags`=537166336, `unit_flags2`=2099201 WHERE `entry`=97503; -- Stormwind Knight
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `unit_class`=2, `unit_flags2`=2048 WHERE `entry`=97510; -- Soulbound Destructor
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `speed_run`=1.42857, `unit_class`=2, `unit_flags`=537166592, `unit_flags2`=2099201 WHERE `entry`=97521; -- Earthen Ring Shaman
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `speed_run`=1.42857, `speed_walk`=1.42857, `unit_flags`=36872, `unit_flags2`=2099200 WHERE `entry`=97525; -- Thunder Bluff Brave
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `unit_flags`=537166336, `unit_flags2`=2099201 WHERE `entry`=97526; -- Deathguard Elite
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `unit_class`=8, `unit_flags`=16640, `unit_flags2`=2099200 WHERE `entry`=97527; -- Argent Lightbringer
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `unit_class`=8, `unit_flags`=32768, `unit_flags2`=2099200 WHERE `entry`=97528; -- Argent Lightbringer
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `speed_run`=1, `unit_class`=2, `unit_flags2`=2048 WHERE `entry`=100621; -- Mother Virila
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `npcflag`=16777216, `speed_run`=1, `unit_flags2`=2097152 WHERE `entry`=100959; -- Unattended Cannon
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `speed_run`=1.57143, `speed_walk`=1.2, `unit_flags`=32768, `unit_flags2`=2099200 WHERE `entry`=101056; -- Gilnean Royal Guard
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `speed_run`=1.57143, `speed_walk`=1.2, `unit_flags`=32768, `unit_flags2`=2099200 WHERE `entry`=101057; -- Gilnean Royal Guard
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `unit_flags2`=2048 WHERE `entry`=101084; -- Captain Angelica
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `unit_flags2`=2048 WHERE `entry`=101086; -- First Mate Tidesong
UPDATE `creature_template` SET `unit_flags`=33554688, `unit_flags2`=1073743872 WHERE `entry`=101103; -- Command Ship
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `unit_flags`=537166592, `unit_flags2`=1073743873 WHERE `entry`=101632; -- Mo'arg Painbringer
UPDATE `creature_template` SET `RegenHealth`=0, `maxlevel`=110, `minlevel`=110, `speed_run`=1, `unit_flags`=262144 WHERE `entry`=101667; -- Shielded Anchor
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `speed_run`=1, `unit_class`=8, `unit_flags2`=2048 WHERE `entry`=102696; -- Felslag Imp
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `speed_run`=1, `unit_class`=8, `unit_flags`=32768, `unit_flags2`=2099200 WHERE `entry`=102698; -- Anostronoth
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `unit_flags`=32768, `unit_flags2`=2099200 WHERE `entry`=102701; -- Mo'arg Painbringer
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `unit_flags2`=2048 WHERE `entry`=102702; -- Wrathguard Dreadblade
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `speed_run`=0.992063, `unit_flags`=32768, `unit_flags2`=2099200 WHERE `entry`=102703; -- Fel Lord Dukaz
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `speed_run`=0.992063, `unit_flags`=32768, `unit_flags2`=2099200 WHERE `entry`=102704; -- Fel Lord Zarnoz
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `speed_run`=0.992063, `unit_flags`=32768, `unit_flags2`=2099200 WHERE `entry`=102705; -- Fel Lord Rakaz
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `unit_flags`=32768, `unit_flags2`=2099200 WHERE `entry`=102706; -- Grinning Shadowstalker
UPDATE `creature_template` SET `maxlevel`=106, `minlevel`=106, `unit_class`=8, `unit_flags`=33536, `unit_flags2`=4196352 WHERE `entry`=105163; -- Destromath
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `unit_flags`=33536, `unit_flags2`=4196352 WHERE `entry`=105164; -- Felgard Legionnaire
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `unit_flags`=33536, `unit_flags2`=4196352 WHERE `entry`=105165; -- Felgard Legionnaire
UPDATE `creature_template` SET `maxlevel`=106, `minlevel`=106, `unit_class`=8, `unit_flags`=33536, `unit_flags2`=4196352 WHERE `entry`=105166; -- Gorgonnash
UPDATE `creature_template` SET `maxlevel`=109, `minlevel`=109, `unit_class`=8, `unit_flags`=33536, `unit_flags2`=4196352 WHERE `entry`=105167; -- Imp Mother Fecunda
UPDATE `creature_template` SET `maxlevel`=98, `minlevel`=98, `unit_class`=8, `unit_flags`=33536, `unit_flags2`=4196352 WHERE `entry`=105168; -- Anetheron
UPDATE `creature_template` SET `maxlevel`=103, `minlevel`=103, `unit_class`=8, `unit_flags`=33536, `unit_flags2`=4196352 WHERE `entry`=105169; -- Mephistroth
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `unit_class`=8, `unit_flags`=33536, `unit_flags2`=4196352 WHERE `entry`=105170; -- Balnazzar
UPDATE `creature_template` SET `maxlevel`=99, `minlevel`=99, `unit_class`=8, `unit_flags`=33536, `unit_flags2`=4196352 WHERE `entry`=105171; -- Mal'ganis
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `speed_run`=1, `unit_flags`=33536, `unit_flags2`=4196352 WHERE `entry`=105172; -- Winged Nightmare
UPDATE `creature_template` SET `maxlevel`=103, `minlevel`=103, `unit_flags`=33536, `unit_flags2`=4196352 WHERE `entry`=105174; -- Smashspite the Hateful
UPDATE `creature_template` SET `maxlevel`=103, `minlevel`=103, `unit_flags`=33536, `unit_flags2`=4196352 WHERE `entry`=105175; -- Blerg
UPDATE `creature_template` SET `maxlevel`=106, `minlevel`=106, `unit_class`=8, `unit_flags`=33536, `unit_flags2`=4196352 WHERE `entry`=105176; -- Sathrovarr the Corruptor
UPDATE `creature_template` SET `maxlevel`=107, `minlevel`=107, `unit_class`=8, `unit_flags`=33536, `unit_flags2`=4196352 WHERE `entry`=105179; -- Lord Jaraxxus
UPDATE `creature_template` SET `maxlevel`=107, `minlevel`=107, `unit_class`=8, `unit_flags`=33536, `unit_flags2`=4196352 WHERE `entry`=105180; -- Grand Warlock Alythess
UPDATE `creature_template` SET `maxlevel`=109, `minlevel`=109, `unit_class`=8, `unit_flags`=33536, `unit_flags2`=4196352 WHERE `entry`=105181; -- Lady Sacrolash
UPDATE `creature_template` SET `maxlevel`=99, `minlevel`=99, `unit_class`=2, `unit_flags`=33536, `unit_flags2`=4196352 WHERE `entry`=105182; -- Gravax the Desecrator
UPDATE `creature_template` SET `maxlevel`=106, `minlevel`=106, `unit_class`=2, `unit_flags`=33536, `unit_flags2`=4196352 WHERE `entry`=105183; -- Lord Kra'vos
UPDATE `creature_template` SET `maxlevel`=107, `minlevel`=107, `unit_class`=8, `unit_flags`=33536, `unit_flags2`=4196352 WHERE `entry`=105185; -- Overseer Lykill
UPDATE `creature_template` SET `maxlevel`=107, `minlevel`=107, `unit_class`=2, `unit_flags`=33536, `unit_flags2`=4196352 WHERE `entry`=105186; -- Oublion
UPDATE `creature_template` SET `maxlevel`=108, `minlevel`=108, `unit_class`=8, `unit_flags`=33536, `unit_flags2`=4196352 WHERE `entry`=105187; -- Azoran
UPDATE `creature_template` SET `maxlevel`=102, `minlevel`=102, `unit_flags`=33536, `unit_flags2`=4196352 WHERE `entry`=105188; -- Cordana Felsong
UPDATE `creature_template` SET `maxlevel`=109, `minlevel`=109, `unit_class`=2, `unit_flags`=33536, `unit_flags2`=4196352 WHERE `entry`=105189; -- Doomlord Kazrok
UPDATE `creature_template` SET `maxlevel`=104, `minlevel`=104, `unit_flags`=33536, `unit_flags2`=4196352 WHERE `entry`=105190; -- Varedis Felsoul
UPDATE `creature_template` SET `maxlevel`=102, `minlevel`=102, `unit_flags`=33536, `unit_flags2`=4196352 WHERE `entry`=105192; -- Caria Felsoul
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `unit_flags`=33536, `unit_flags2`=4196352 WHERE `entry`=105196; -- Brogozog
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `unit_flags`=33536, `unit_flags2`=4196352 WHERE `entry`=105197; -- Felwing
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `unit_flags`=32768, `unit_flags2`=4196352 WHERE `entry`=105199; -- Felstalker Dreadhound
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `unit_flags`=32768, `unit_flags2`=4194304 WHERE `entry`=105200; -- Felguard Invader
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `speed_run`=1, `unit_flags`=32768, `unit_flags2`=4194304 WHERE `entry`=105203; -- Felguard Invader
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `unit_flags`=32768, `unit_flags2`=4194304 WHERE `entry`=105205; -- Mo'arg Spinebreaker
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `unit_flags`=32768, `unit_flags2`=4194304 WHERE `entry`=105206; -- Wrathguard Dreadblade
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `unit_class`=2, `unit_flags2`=2099200 WHERE `entry`=105217; -- Argent Dawnbringer
UPDATE `creature_template` SET `maxlevel`=100, `minlevel`=100, `unit_flags`=537166592, `unit_flags2`=2099201 WHERE `entry`=108990; -- Stormwind Gryphon
UPDATE `creature_template` SET `maxlevel`=85, `minlevel`=85, `unit_flags`=33554432, `unit_flags2`=1073743872 WHERE `entry`=109341; -- General Purpose Bunny JMF
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `speed_run`=0.992063, `unit_flags`=32768, `unit_flags2`=2131968 WHERE `entry`=109586; -- Fel Lord Rakkan
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `speed_run`=0.992063, `unit_flags`=32768, `unit_flags2`=2131968 WHERE `entry`=109587; -- Fel Lord Zardak
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `speed_run`=1, `unit_flags`=32768, `unit_flags2`=2097152 WHERE `entry`=109591; -- Felguard Legionnaire
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `speed_run`=1, `unit_flags`=32768, `unit_flags2`=2097152 WHERE `entry`=109592; -- Felguard Legionnaire
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `speed_run`=1, `unit_flags`=32768, `unit_flags2`=2097152 WHERE `entry`=109604; -- Felguard Legionnaire
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `speed_run`=1, `unit_class`=8, `unit_flags`=32768, `unit_flags2`=2099200 WHERE `entry`=110614; -- Malificus
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `unit_class`=2, `unit_flags`=32768, `unit_flags2`=2099200 WHERE `entry`=110615; -- Argent Dawnbringer
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `unit_class`=8, `unit_flags2`=2048 WHERE `entry`=110616; -- Dark Worshipper
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `unit_class`=2, `unit_flags2`=2048 WHERE `entry`=110617; -- Shadowsworn Harbinger
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `unit_class`=2, `unit_flags2`=2099200 WHERE `entry`=110941; -- Dessicated Crusader
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `unit_flags`=32768, `unit_flags2`=4196352 WHERE `entry`=111074; -- Grinning Shadowstalker
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `unit_class`=8, `unit_flags`=33536, `unit_flags2`=4196352 WHERE `entry`=111079; -- Dantalionax
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `unit_flags`=33536, `unit_flags2`=4196352 WHERE `entry`=111085; -- Geth'xun
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `unit_flags`=33536, `unit_flags2`=4196352 WHERE `entry`=111087; -- Hakkar the Houndmaster
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `unit_flags`=33536, `unit_flags2`=4196352 WHERE `entry`=111088; -- Lord Perdition
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `unit_class`=8, `unit_flags`=33536, `unit_flags2`=4196352 WHERE `entry`=111089; -- Malinoth
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `unit_class`=2, `unit_flags`=33536, `unit_flags2`=2048 WHERE `entry`=111148; -- Lady Ran'zara
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `unit_class`=2, `unit_flags`=33536, `unit_flags2`=2048 WHERE `entry`=111149; -- Talixae Flamewreath
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `unit_class`=2, `unit_flags`=33536, `unit_flags2`=4196352 WHERE `entry`=111152; -- Grand Summoner Abraxeton
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `unit_class`=2, `unit_flags`=33536, `unit_flags2`=4196352 WHERE `entry`=111153; -- Aargoss
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `unit_class`=8, `unit_flags`=33536, `unit_flags2`=4196352 WHERE `entry`=111154; -- Malgalor
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `unit_flags`=33536, `unit_flags2`=2048 WHERE `entry`=111155; -- Makaan the Malevolent
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `unit_flags`=33536, `unit_flags2`=4196352 WHERE `entry`=111156; -- Fel Lord Dakuur
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `unit_flags`=33536, `unit_flags2`=4196352 WHERE `entry`=111157; -- Pilik
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `unit_class`=8, `unit_flags`=33536, `unit_flags2`=2048 WHERE `entry`=111165; -- Lady Keletress
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `unit_flags`=33536, `unit_flags2`=4196352 WHERE `entry`=111167; -- Lochaber
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `unit_flags`=33536, `unit_flags2`=2048 WHERE `entry`=111171; -- Carnivore
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `unit_flags`=33536, `unit_flags2`=4196352 WHERE `entry`=111173; -- Soulchaser
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `unit_flags`=33536, `unit_flags2`=4196352 WHERE `entry`=111174; -- Vaultwarden Umbra
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `unit_flags`=33536, `unit_flags2`=4196352 WHERE `entry`=111175; -- The Overseer
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `unit_class`=8, `unit_flags`=33536, `unit_flags2`=2048 WHERE `entry`=112879; -- Horde Priest
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `speed_run`=1.42857, `speed_walk`=1.42857, `unit_flags`=36872, `unit_flags2`=2099200 WHERE `entry`=112920; -- Dark Ranger
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `unit_flags`=32768, `unit_flags2`=2099200 WHERE `entry`=112921; -- Bilgewater Blastmaster
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `unit_class`=8, `unit_flags`=279296, `unit_flags2`=2048 WHERE `entry`=112976; -- Argent Lightbringer
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `unit_class`=8, `unit_flags`=537150208, `unit_flags2`=2099201 WHERE `entry`=112977; -- Argent Lightbringer
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `speed_run`=0.992063, `unit_flags`=32768, `unit_flags2`=2099200 WHERE `entry`=113036; -- Fel Lord Razzar
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `speed_run`=0.992063, `unit_flags`=32832, `unit_flags2`=4229120 WHERE `entry`=113037; -- Fel Lord Darakk
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `speed_run`=0.992063, `unit_flags`=32768, `unit_flags2`=2131968 WHERE `entry`=113038; -- Fel Lord Kurrz
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `speed_run`=1, `unit_class`=2, `unit_flags`=32768, `unit_flags2`=2099200 WHERE `entry`=113053; -- Mother Sepestra
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `speed_run`=1, `unit_class`=8, `unit_flags`=294912, `unit_flags2`=2099200 WHERE `entry`=113054; -- Diathorus the Seeker
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `speed_run`=1, `unit_class`=8, `unit_flags`=32768, `unit_flags2`=2099200 WHERE `entry`=113055; -- Lord Banehollow
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `speed_run`=1, `unit_class`=8, `unit_flags`=32768, `unit_flags2`=2099200 WHERE `entry`=113056; -- Solenor the Slayer
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `speed_run`=0.992063, `unit_flags`=32768, `unit_flags2`=2099200 WHERE `entry`=113057; -- Fel Lord Durkan
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `speed_run`=0.992063, `unit_flags`=32768, `unit_flags2`=2099200 WHERE `entry`=113058; -- Fel Lord Volak
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `speed_run`=0.992063, `unit_flags`=32768, `unit_flags2`=2099200 WHERE `entry`=113059; -- Fel Lord Garzan
UPDATE `creature_template` SET `maxlevel`=110, `minlevel`=110, `unit_flags`=33555200, `unit_flags2`=2048 WHERE `entry`=113129; -- Fel Lava
UPDATE `creature_template` SET `maxlevel`=100, `minlevel`=100, `unit_flags`=537166592, `unit_flags2`=2099201 WHERE `entry`=113290; -- Riding Bat
UPDATE `creature_template` SET `maxlevel`=100, `minlevel`=100, `unit_flags`=537166592, `unit_flags2`=2099201 WHERE `entry`=113291; -- Wind Rider
