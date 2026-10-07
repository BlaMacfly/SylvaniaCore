-- Registre des expeditions (quetes mondiales).
-- 1) Retire 38 entrees qui ne sont pas des expeditions jouables : invasions de l avant-patch 7.0,
--    hebdomadaires de donjon, archeologie, quetes sans titre ni objectif, points d invasion sans objectif.
--    Gardes : emissaires (128), assauts de la Legion (146), Time to Rumble (113).
-- 2) Importe 315 expeditions relevees en officiel (lc_world_ref.world_quest_update, builds <= 26972),
--    QuestType 3, avec objectifs, cibles presentes dans le monde ; exclues : liees a un evenement,
--    quetes d assaut (139/142, seulement pendant l assaut), boss mondiaux (144).
-- Sauvegarde : ~/tmp/sauvegardes/world_quest_2026-10-07.sql (+ dc_characters.world_quest)
-- Rollback   : 2026_10_07_expeditions_registre_rollback.sql

DELETE FROM world_quest WHERE id IN (40168,40173,40786,40787,41177,43242,43245,43282,43283,43284,43285,43286,43287,43288,43289,43290,43291,43292,43296,43297,43298,43299,43300,43301,43476,45563,48982,49091,49096,49097,49098,49099,49166,49167,49168,49169,49170,49171);

INSERT INTO world_quest (id, duration, variable, value) VALUES
(40277, 86400, 11430, 1), -- Fight Night: Tiffany Nelson
(40278, 86400, 11506, 1), -- My Beasts's Bidding
(40279, 86400, 11412, 1), -- Training with Durian
(40280, 86400, 11199, 1), -- Training with Bredda
(40282, 86400, 11272, 1), -- Tiny Poacher, Tiny Animals
(40298, 86400, 11431, 1), -- Fight Night: Sir Galveston
(40299, 86400, 11432, 1), -- Fight Night: Bodhi Sunwayver
(41013, 21600, 10797, 1), -- Darkbrul Arena
(41219, 43200, 10887, 1), -- Flourishing Foxflower
(41223, 86400, 10889, 1), -- Work Order: Foxflower
(41233, 43200, 10896, 1), -- Bristled Bear Skin
(41240, 86400, 10902, 1), -- Work Order: Highmountain Salmon
(41242, 259200, 10907, 1), -- Slab of Bacon
(41243, 43200, 10916, 1), -- Huge Highmountain Salmon
(41244, 43200, 10929, 1), -- Lively Highmountain Salmon
(41252, 43200, 10917, 1), -- Wild Northern Barracuda
(41259, 259200, 10925, 1), -- Slab of Bacon
(41260, 259200, 10926, 1), -- Slab of Bacon
(41261, 259200, 10927, 1), -- Slab of Bacon
(41262, 64800, 10928, 1), -- Slab of Bacon
(41264, 43200, 10930, 1), -- Lively Cursed Queenfish
(41266, 43200, 10932, 1), -- Raft Fishing
(41270, 43200, 10936, 1), -- Huge Mossgill Perch
(41275, 43200, 10941, 1), -- Huge Stormrays
(41279, 64800, 10945, 1), -- Lively Runescale Koi
(41287, 86400, 10957, 1), -- Work Order: Aethril
(41289, 43200, 10959, 1), -- Flourishing Aethril
(41290, 43200, 10960, 1), -- Aqueous Aethril
(41292, 86400, 10962, 1), -- Work Order: Dreamleaf
(41294, 43200, 10964, 1), -- Flourishing Dreamleaf
(41297, 86400, 10967, 1), -- Work Order: Fjarnskaggl
(41303, 86400, 10973, 1), -- Supplies Needed: Starlight Roses
(41304, 64800, 10974, 1), -- Flourishing Starlight Roses
(41315, 86400, 10981, 1), -- Supplies Needed: Leystone
(41316, 86400, 10982, 1), -- Supplies Needed: Leystone
(41317, 86400, 10983, 1), -- Supplies Needed: Leystone
(41318, 86400, 10984, 1), -- Supplies Needed: Felslate
(41323, 43200, 10987, 1), -- Fatty Lion Seal Skin
(41324, 43200, 10988, 1), -- Silky Prowler Fur
(41326, 86400, 10990, 1), -- Work Order: Stormscales
(41333, 43200, 10992, 1), -- Rugged Wolf Hide
(41338, 86400, 10996, 1), -- Work Order: Stonehide Leather
(41340, 43200, 10998, 1), -- Perfect Storm Drake Scale
(41343, 43200, 11001, 1), -- Solid Crabshell Fragment
(41344, 86400, 11002, 1), -- Work Order: Stormscales
(41346, 64800, 11004, 1), -- Velvety Stalker Hide
(41525, 43200, 11172, 1), -- Wispy Foxflower
(41526, 43200, 11173, 1), -- Bushy Foxflower
(41527, 43200, 11174, 1), -- Lively Aethril
(41528, 43200, 11175, 1), -- Iridescent Aethril
(41530, 43200, 11177, 1), -- Lively Dreamleaf
(41531, 43200, 11178, 1), -- Iridescent Dreamleaf
(41532, 43200, 11179, 1), -- Bushy Dreamleaf
(41533, 43200, 11180, 1), -- Fragrant Dreamleaf
(41534, 43200, 11181, 1), -- Brambly Fjarnskaggl
(41535, 43200, 11182, 1), -- Prickly Fjarnskaggl
(41536, 43200, 11183, 1), -- Pungent Fjarnskaggl
(41549, 259200, 11200, 1), -- Slab of Bacon
(41550, 259200, 11201, 1), -- Slab of Bacon
(41551, 259200, 11202, 1), -- Slab of Bacon
(41552, 259200, 11203, 1), -- Slab of Bacon
(41553, 259200, 11204, 1), -- Slab of Bacon
(41555, 259200, 11206, 1), -- Slab of Bacon
(41556, 259200, 11207, 1), -- Slab of Bacon
(41557, 64800, 11208, 1), -- Slab of Bacon
(41558, 64800, 11209, 1), -- Slab of Bacon
(41582, 43200, 11726, 1), -- Smooth Sunrunner Hide
(41600, 43200, 11248, 1), -- Lively Mossgill Perch
(41601, 43200, 11249, 1), -- Lively Mossgill Perch
(41605, 64800, 11253, 1), -- Lively Runescale Koi
(41609, 43200, 11255, 1), -- Huge Highmountain Salmon
(41610, 43200, 11256, 1), -- Huge Cursed Queenfish
(41611, 43200, 11257, 1), -- Huge Cursed Queenfish
(41612, 43200, 11258, 1), -- Huge Mossgill Perch
(41613, 43200, 11259, 1), -- Huge Mossgill Perch
(41614, 43200, 11260, 1), -- Huge Stormrays
(41615, 43200, 11261, 1), -- Huge Stormrays
(41616, 64800, 11262, 1), -- Huge Runescale Koi
(41622, 86400, 11271, 1), -- Crawliac's Legacy
(41624, 86400, 11274, 1), -- Rocko Needs a Shave
(41638, 86400, 11281, 1), -- Work Order: Leystone Gauntlets
(41642, 86400, 11285, 1), -- Work Order: Warhide Footpads
(41643, 86400, 11286, 1), -- Work Order: Battlebound Leggings
(41644, 86400, 13418, 1), -- Work Order: Warhide Gloves
(41647, 86400, 11290, 1), -- Work Order: Silkweave Robe
(41650, 86400, 13416, 1), -- Work Order: Silkweave Hood
(41656, 86400, 13417, 1), -- Work Order: Azsunite Loop
(41658, 86400, 11301, 1), -- Work Order: Sylvan Elixirs
(41662, 86400, 13415, 1), -- Work Order: Ancient Rejuvenation Potions
(41666, 86400, 11309, 1), -- Vantus Rune Work Order: Nythendra
(41667, 86400, 11310, 1), -- Vantus Rune Work Order: Xavius
(41668, 86400, 13414, 1), -- Vantus Rune Work Order: Il'gynoth, The Heart of Corruption
(41669, 86400, 13413, 1), -- Work Order: Word of Critical Strike
(41670, 86400, 11313, 1), -- Work Order: Word of Agility
(41671, 86400, 11314, 1), -- Work Order: Word of Strength
(41672, 86400, 11315, 1), -- Work Order: Word of Haste
(41673, 86400, 11316, 1), -- Work Order: Word of Mastery
(41674, 86400, 11317, 1), -- Work Order: Word of Intellect
(41675, 86400, 11318, 1), -- Work Order: Blink-Trigger Headgun
(41676, 86400, 11319, 1), -- Work Order: Pump-Action Bandage Gun
(41677, 86400, 11320, 1), -- Work Order: Auto-Hammer
(41678, 86400, 11321, 1), -- Work Order: Gunpack
(41679, 86400, 11322, 1), -- Work Order: Deployable Bullet Dispenser
(41680, 86400, 11323, 1), -- Work Order: Failure Detection Pylon
(41687, 86400, 11339, 1), -- Snail Fight!
(41691, 86400, 11342, 1), -- Sea of Feathers
(41706, 86400, 11351, 1), -- Briny Waters
(41766, 86400, 11368, 1), -- Wildlife Protection Force
(41789, 86400, 11372, 1), -- Return to the Crag
(41794, 86400, 11373, 1), -- Drakestalker
(41818, 86400, 11387, 1), -- WANTED: Majestic Elderhorn
(41819, 86400, 11388, 1), -- WANTED: Gurbog da Basher
(41821, 86400, 11390, 2), -- WANTED: Shara Felbreath
(41826, 86400, 11396, 2), -- WANTED: Crawshuk the Hungry
(41828, 86400, 11397, 2), -- WANTED: Bristlemaul
(41836, 86400, 12193, 2), -- WANTED: Bodash the Hoarder
(41838, 86400, 11406, 2), -- WANTED: Slumber
(41844, 86400, 11409, 1), -- WANTED: Sekhan
(41855, 86400, 11411, 1), -- Stand Up to Bullies
(41860, 86400, 11423, 1), -- Dealing with Satyrs
(41861, 86400, 11424, 1), -- Meet The Maw
(41862, 86400, 11427, 1), -- Only Pets Can Prevent Forest Fires
(41881, 86400, 11433, 1), -- Fight Night: Heliosus
(41886, 86400, 11434, 1), -- Fight Night: Rats!
(41895, 86400, 11440, 1), -- The Master of Pets
(41896, 21600, 12349, 1), -- Operation Murloc Freedom
(41914, 86400, 11446, 1), -- Clear the Catacombs
(41926, 86400, 11448, 1), -- Returning Champion
(41935, 86400, 11455, 1), -- Beasts of Burden
(41948, 86400, 11490, 1), -- All Pets Go to Heaven
(41955, 86400, 11489, 1), -- Bloodline of Stone
(41956, 86400, 11489, 2), -- Petrified Acolytes
(41958, 86400, 11493, 1), -- Oh, Ominitron
(41992, 86400, 11518, 1), -- Twisted Ash
(41996, 86400, 11521, 1), -- Tangled Nightmare
(42013, 86400, 11532, 1), -- The Helmouth
(42015, 86400, 11535, 1), -- Threads of Fate
(42021, 86400, 11539, 1), -- Investigation at Mak'rana
(42063, 86400, 11558, 1), -- Size Doesn't Matter
(42064, 86400, 11559, 1), -- It's Illid... Wait.
(42067, 86400, 11560, 1), -- All Howl, No Bite
(42071, 86400, 11571, 1), -- Honoring the Past
(42089, 86400, 11576, 1), -- The Fallen Ones
(42146, 86400, 11618, 1), -- Dazed and Confused and Adorable
(42148, 86400, 11620, 1), -- The Wine's Gone Bad
(42154, 86400, 11626, 1), -- Help a Whelp
(42165, 86400, 11665, 1), -- Azsuna Specimens
(42169, 86400, 11643, 1), -- Left for Dead
(42190, 86400, 11672, 1), -- Wildlife Conservationist
(42242, 259200, 12211, 1), -- Halls of Valor: A Gift for Vethir
(42243, 259200, 12608, 5), -- Halls of Valor: Deeds of the Past
(42442, 86400, 11724, 1), -- Fight Night: Amalia
(42620, 86400, 11753, 1), -- WANTED: Arcavellus
(42652, 86400, 11884, 1), -- Ancient Exemplars
(42712, 345600, 11883, 1), -- Eye of Azshara: Termination Claws
(42725, 86400, 11911, 1), -- Sharing the Wealth
(42744, 259200, 12211, 1), -- Darkheart Thicket: Preserving the Preservers
(42745, 259200, 12211, 1), -- Darkheart Thicket: A Burden to Bear
(42746, 259200, 12211, 1), -- Eye of Azshara: Dread End
(42755, 259200, 12211, 1), -- Eye of Azshara: Azsunian Pearls
(42781, 259200, 12211, 1), -- Court of Stars: Disarming the Watch
(42783, 259200, 12211, 1), -- Court of Stars: They Bloom at Night
(42795, 64800, 11984, 2), -- WANTED: Sanaar
(42796, 64800, 11985, 1), -- WANTED: Broodmother Shu'malis
(42962, 86400, 12070, 1), -- Secret Correspondence
(43027, 259200, 12099, 1), -- DANGER: Mortiferous
(43040, 259200, 12100, 1), -- DANGER: Valakar the Thirsty
(43059, 259200, 12101, 1), -- DANGER: Fjordun
(43063, 259200, 12102, 1), -- DANGER: Stormfeather
(43101, 259200, 12112, 1), -- DANGER: Witchdoctor Grgl-Brgl
(43121, 259200, 12114, 1), -- DANGER: Chief Treasurer Jabrill
(43175, 259200, 12119, 1), -- DANGER: Deepclaw
(43324, 86400, 12159, 1), -- Rage of the Owlbeasts
(43345, 259200, 23423, 1), -- DANGER: Harbinger of Screams
(43346, 259200, 23424, 1), -- DANGER: Ealdis
(43435, 86400, 12206, 1), -- The Battle Rages On
(43456, 86400, 12149, 2), -- WANTED: Skul'vrax
(43605, 86400, 11772, 3), -- WANTED: Arcanist Shal'iman
(43607, 86400, 12098, 3), -- WANTED: Brogozog
(43611, 86400, 11767, 3), -- WANTED: Inquisitor Tivos
(43612, 86400, 12125, 3), -- WANTED: Normantis the Deposed
(43613, 86400, 12120, 3), -- WANTED: Syphonus
(43614, 86400, 11769, 3), -- WANTED: Vorthax
(43615, 86400, 12124, 3), -- WANTED: Warbringer Mox'na
(43618, 86400, 11388, 3), -- WANTED: Gurbog da Basher
(43619, 86400, 11390, 3), -- WANTED: Shara Felbreath
(43620, 86400, 12189, 3), -- WANTED: Egyl the Enduring
(43621, 86400, 12146, 3), -- WANTED: Fathnyr
(43624, 86400, 12187, 3), -- WANTED: Isel the Hammer
(43627, 86400, 12184, 3), -- WANTED: Tiptog the Lost
(43628, 86400, 12186, 3), -- WANTED: Urgev the Flayer
(43633, 86400, 12154, 3), -- WANTED: Thondrax
(43814, 86400, 12336, 1), -- Unspeakable Collaborators
(43930, 86400, 12360, 1), -- Fiends of Tel'anor
(43963, 86400, 12382, 1), -- Vampirates!
(44010, 64800, 12387, 2), -- WANTED: Oreth the Vile
(44012, 64800, 12388, 2), -- WANTED: Siegemaster Aedrin
(44015, 64800, 12391, 2), -- WANTED: Mal'Dreth the Corruptor
(44016, 64800, 12392, 2), -- WANTED: Cadraeus
(44021, 64800, 12397, 1), -- WANTED: Hertha Grimdottir
(44022, 64800, 12405, 1), -- WANTED: Shal'an
(44027, 64800, 12394, 3), -- WANTED: Magister Phaedris
(44028, 64800, 12395, 3), -- WANTED: Lieutenant Strathmar
(44044, 259200, 12420, 1), -- Felled Experiment
(44187, 259200, 12480, 1), -- DANGER: Cinderwing
(44192, 259200, 12482, 1), -- DANGER: Lysanis Shadesoul
(44193, 259200, 12484, 1), -- DANGER: Sea King Tidross
(44194, 259200, 12486, 1), -- DANGER: Torrentius
(44290, 86400, 11397, 3), -- WANTED: Bristlemaul
(44294, 86400, 11409, 3), -- WANTED: Sekhan
(44302, 86400, 12509, 3), -- WANTED: Seersei
(44748, 86400, 13250, 1), -- Winged Terrors
(44815, 86400, 12712, 1), -- Sick of the Sycophants
(44857, 86400, 12779, 1), -- Not There, Not Then, Not Forever
(45379, 259200, 13498, 1), -- Treasure Master Iks'reeged
(45791, 86400, 12985, 1), -- War Materiel
(45792, 86400, 12982, 4), -- Occultist Onslaught
(45973, 86400, 13065, 1), -- Unchecked Power
(46111, 86400, 13142, 1), -- Illidari Masters: Sissix
(46112, 86400, 13143, 1), -- Illidari Masters: Madam Viciosa
(46113, 86400, 13144, 1), -- Illidari Masters: Nameless Mystic
(46198, 86400, 13405, 2), -- Gems of Destruction
(46932, 86400, 13173, 1), -- A Tad More Corruption
(46933, 86400, 13173, 2), -- Felrglrglrglrgl
(47507, 86400, 14044, 1), -- Khazaduum
(47542, 86400, 13624, 1), -- Siegemaster Voraan
(47552, 86400, 13623, 1), -- Mistress Il'thendra
(47561, 86400, 13625, 1), -- Blistermaw
(47566, 86400, 13626, 1), -- Gar'zoth
(47625, 86400, 13636, 2), -- The Ritual We Share
(47646, 86400, 13636, 3), -- Rope Around
(47705, 86400, 13931, 1), -- Behind Legion Lines
(47720, 86400, 13671, 1), -- Eternal Vengeance
(47728, 86400, 13676, 1), -- Talestra the Vile
(47828, 86400, 13746, 1), -- Memories of the Fallen
(47833, 86400, 13747, 1), -- Shadowcaster Voruun
(47844, 86400, 13684, 2), -- Recurring Madness
(47953, 86400, 13824, 1), -- Tereck the Selector
(48091, 86400, 13875, 1), -- Vagath the Betrayed
(48094, 86400, 14000, 1), -- Void Clot
(48099, 86400, 14021, 1), -- Hostile Echology
(48100, 86400, 14205, 1), -- The Defense of Mac'Aree
(48102, 86400, 13989, 2), -- Scale Samples
(48192, 86400, 13890, 1), -- Tar Spitter
(48282, 86400, 13930, 1), -- Imp Mother Laglath
(48284, 86400, 13621, 1), -- Reap the Fields
(48286, 86400, 13621, 2), -- Crystal Methods
(48337, 86400, 13960, 1), -- Work Order: Astral Glory
(48349, 86400, 13974, 1), -- Work Order: Empyrium
(48359, 86400, 13976, 1), -- Work Order: Fiendish Leather
(48465, 86400, 14009, 1), -- Vrax'thul
(48466, 86400, 14010, 1), -- Ven'orn
(48467, 86400, 14011, 1), -- Puscilla
(48502, 86400, 14024, 1), -- Naroua, King of the Forest
(48509, 86400, 14046, 1), -- Commander Sathrenael
(48510, 86400, 14045, 1), -- Commander Vecaya
(48511, 86400, 14047, 1), -- Commander Endaxis
(48512, 86400, 14048, 1), -- Sister Subversia
(48691, 43200, 14165, 1), -- Soul Chain
(48694, 86400, 14166, 1), -- Soultwisted Monstrosity
(48696, 86400, 14167, 1), -- Wrangler Kravos
(48698, 86400, 14168, 1), -- Kaara the Pale
(48701, 86400, 14169, 1), -- Baruut the Bloodthirsty
(48722, 86400, 14172, 1), -- Feasel the Muffin Thief
(48724, 86400, 14174, 1), -- Vigilant Kuro
(48725, 86400, 14175, 1), -- Venomtail Skyfin
(48726, 86400, 14176, 1), -- Turek the Lucid
(48727, 86400, 14177, 1), -- Captain Faruq
(48728, 86400, 14178, 1), -- Umbraliss
(48729, 86400, 14179, 1), -- Ataxon
(48730, 86400, 14180, 1), -- Sorolis the Ill-Fated
(48731, 86400, 14181, 1), -- Herald of Chaos
(48732, 86400, 14182, 1), -- Sabuul
(48733, 86400, 14183, 1), -- Jed'hin Champion Vorusk
(48734, 86400, 14184, 1), -- Overseer Y'Beda
(48735, 86400, 14185, 1), -- Overseer Y'Sorna
(48736, 86400, 14186, 1), -- Overseer Y'Morna
(48737, 86400, 14187, 1), -- Instructor Tarahna
(48738, 86400, 14188, 1), -- Zul'tan the Numerous
(48739, 86400, 14189, 1), -- Commander Xethgar
(48740, 86400, 14190, 1), -- Skreeg the Devourer
(48777, 43200, 14191, 1), -- Den of Fiends
(48827, 86400, 14209, 1), -- Varga
(48828, 86400, 14210, 1), -- Lieutenant Xakaar
(48829, 86400, 14211, 1), -- Wrath-Lord Yarez
(48830, 86400, 14212, 1), -- Inquisitor Vethroz
(48831, 86400, 14213, 1), -- Commander Texlaz
(48832, 86400, 14214, 1), -- Admiral Rel'var
(48834, 86400, 14217, 1), -- Worldsplitter Skuul
(48835, 86400, 14218, 1), -- Houndmaster Kerrax
(48836, 86400, 14219, 1), -- Watcher Aival
(48837, 86400, 14215, 1), -- All-Seer Xanarian
(48866, 86400, 14232, 1), -- Void Warden Valsuran
(48867, 86400, 14233, 1), -- Chief Alchemist Munculus
(48936, 86400, 14275, 1), -- Slithon the Last
(48952, 43200, 14294, 1), -- Throw Them a Bone
(48953, 604800, 14287, 1), -- Seat of the Triumvirate: Darkcaller
(48958, 43200, 14299, 1), -- Ritual Interruption
(49041, 86400, 14307, 1), -- Ruinhoof
(49042, 86400, 14308, 1), -- Foulclaw
(49043, 86400, 14309, 1), -- Baneglow
(49044, 86400, 14310, 1), -- Retch
(49045, 86400, 14311, 1), -- Deathscreech
(49046, 86400, 14312, 1), -- Gnasher
(49047, 86400, 14313, 1), -- Bucky
(49048, 86400, 14314, 1), -- Snozz
(49049, 86400, 14315, 1), -- Gloamwing
(49050, 86400, 14316, 1), -- Shadeflicker
(49051, 86400, 14317, 1), -- Corrupted Blood of Argus
(49052, 86400, 14318, 1), -- Mar'cuus
(49053, 86400, 14319, 1), -- Watcher
(49055, 86400, 14321, 1), -- Earseeker
(49056, 86400, 14322, 1), -- Pilfer
(49057, 86400, 14323, 1), -- Minixis
(49058, 86400, 14324, 1); -- One-of-Many
