-- ============================================================================
-- La Légion de Sylvania — Fix : maîtres de métier muets (profession trainers)
-- Base : dc_world (LIVE)  |  Date : 2026-06-18
-- ----------------------------------------------------------------------------
-- CAUSE
--   La table legacy `npc_trainer` (38768 lignes, 412 maîtres de métier) EST
--   chargée en mémoire par le core (ObjectMgr::LoadTrainerSpell ->
--   _cacheTrainerSpellStore), mais 27 maîtres de métier spawnés portent le
--   flag GOSSIP (npcflag & 1) SANS aucune option de gossip de type TRAINER (5)
--   sur leur menu. Pour un PNJ à flag gossip, le client ouvre un menu de
--   dialogue : sans option « s'entraîner », la fenêtre est vide / inutile
--   -> le PNJ « ne cause pas » et on ne peut pas s'entraîner.
--   (Les trainers SANS flag gossip ouvrent la fenêtre directement via
--    HandleTrainerListOpcode -> SendTrainerListLegacy : eux marchent déjà.)
-- ----------------------------------------------------------------------------
-- FIX
--   Ajouter UNE option de gossip type 5 (TRAINER) à chacun des 23 menus
--   distincts concernés.
--   - OptionNpcFlag = 16 (UNIT_NPC_FLAG_TRAINER) : l'option ne s'affiche QUE
--     pour les PNJ ayant le flag dresseur -> sans danger même sur menu partagé
--     (Player::PrepareGossipMenu : `if (!(OptionNpcFlag & npcflags)) continue`).
--   - TrainerId laissé à 0 (aucune ligne gossip_menu_option_trainer) : au clic,
--     OnGossipSelect -> SendTrainerList(creature, 0) -> GetTrainer(0)=null ->
--     SendTrainerListLegacy() qui lit les sorts legacy npc_trainer PROPRES au
--     PNJ. Précédent : 366 options type-5 fonctionnent déjà ainsi sur ce monde.
--   - OptionIndex = MAX(OptionIndex existant)+1 par menu (aucune collision PK).
-- ----------------------------------------------------------------------------
-- PÉRIMÈTRE : professions uniquement (npcflag & 64). NON traités ici :
--   - 3 maîtres de CLASSE cassés par le même mécanisme (hors « métier ») ;
--   - 18 maîtres de métier SANS aucune donnée (ni moderne ni legacy)
--     -> reconstruction depuis une référence requise (autre chantier).
-- EFFET : `.reload gossip_menu_option` (supporté) OU prochain restart world.
-- ROLLBACK : trainers_profession_gossip_20260618_ROLLBACK.sql
-- ============================================================================

SET NAMES utf8;

INSERT INTO gossip_menu_option
  (MenuId, OptionIndex, OptionIcon, OptionText, OptionBroadcastTextId, OptionType, OptionNpcFlag, VerifiedBuild)
VALUES
  ( 1041,  0, 3, 'Je voudrais m''entraîner.', 0, 5, 16, 26972), -- 7232  Borgus Steelhand (Forge)
  ( 1042,  0, 3, 'Je voudrais m''entraîner.', 0, 5, 16, 26972), -- 7231  Kelgruk Bloodaxe (Forge)
  ( 1043,  0, 3, 'Je voudrais m''entraîner.', 0, 5, 16, 26972), -- 7230  Shayis Steelfury (Forge)
  ( 2749,  0, 3, 'Je voudrais m''entraîner.', 0, 5, 16, 26972), -- 3557  Guillaume Sorouy (Forge)
  ( 3202,  0, 3, 'Je voudrais m''entraîner.', 0, 5, 16, 26972), -- 11178 Borgosh Corebender (Forge)
  ( 3203,  0, 3, 'Je voudrais m''entraîner.', 0, 5, 16, 26972), -- 11177 Okothos Ironrager (Forge)
  ( 4129,  1, 3, 'Je voudrais m''entraîner.', 0, 5, 16, 26972), -- 2391  Serge Hinott (Alchimie)
  ( 4156,  0, 3, 'Je voudrais m''entraîner.', 0, 5, 16, 26972), -- 3606  Alanna Raveneye (Enchantement)
  ( 4171,  0, 3, 'Je voudrais m''entraîner.', 0, 5, 16, 26972), -- 11073 Annora (Enchantement)
  ( 4208,  0, 3, 'Je voudrais m''entraîner.', 0, 5, 16, 26972), -- 1385  Brawn (Travail du cuir)
  ( 4244,  0, 3, 'Je voudrais m''entraîner.', 0, 5, 16, 26972), -- 11098 Hahrana Ironhide (Travail du cuir)
  ( 4356,  0, 3, 'Je voudrais m''entraîner.', 0, 5, 16, 26972), -- 2399  Daryl Stack (Couture)
  ( 8460,  1, 3, 'Je voudrais m''entraîner.', 0, 5, 16, 26972), -- 19185 Jack Trapper (Cuisine)
  ( 8784,  2, 3, 'Je voudrais m''entraîner.', 0, 5, 16, 26972), -- 19186 Kylene (Cuisine)
  (11637,  0, 3, 'Je voudrais m''entraîner.', 0, 5, 16, 26972), -- 42506 Marogg (Cuisine)
  (12180, 13, 3, 'Je voudrais m''entraîner.', 0, 5, 16, 26972), -- hub Profession Pandarie (Nedric Sallow, Lalum Darkmane, Iranis Shadebloom, Saren, Elder Oakpaw)
  (13283,  2, 3, 'Je voudrais m''entraîner.', 0, 5, 16, 26972), -- 56707 Chin (Cuisine)
  (14615,  2, 3, 'Je voudrais m''entraîner.', 0, 5, 16, 26972), -- 64922 Brann Bronzebeard (Archéologie)
  (14625,  1, 3, 'Je voudrais m''entraîner.', 0, 5, 16, 26972), -- 65098 Mai the Jade Shaper (Joaillerie)
  (14972,  0, 3, 'Je voudrais m''entraîner.', 0, 5, 16, 26972), -- 66222 Elder Muur (Premiers soins)
  (15125, 14, 3, 'Je voudrais m''entraîner.', 0, 5, 16, 26972), -- 57620 Whittler Dewei (Profession)
  (18475,  3, 3, 'Je voudrais m''entraîner.', 0, 5, 16, 26972), -- 92264 Felsmith Nal'ryssa (Forge)
  (56340,  0, 3, 'Je voudrais m''entraîner.', 0, 5, 16, 26972); -- 56340 Shokia (Forge)
