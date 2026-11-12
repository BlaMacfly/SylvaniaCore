-- Revive Battle Pets (125439) was never learned: the pet journal button did nothing.
-- Battle Pet Training (125610) learns the training, Track Pets and Revive Battle Pets (TrinityCore master)
DELETE FROM `spell_learn_spell` WHERE `entry`=125610;
INSERT INTO `spell_learn_spell` (`entry`, `SpellID`, `Active`) VALUES
(125610, 119467, 1),
(125610, 122026, 1),
(125610, 125439, 1);
-- our battle pet trainers teach the training and Track Pets apart: Revive Battle Pets with them
DELETE FROM `npc_trainer` WHERE `SpellID`=125439 AND `ID` IN (63075, 63073, 63070, 63067, 63061, 63596, 63014, 63077, 63080, 63083, 63086, 63626);
INSERT INTO `npc_trainer` (`ID`, `SpellID`, `MoneyCost`, `ReqSkillLine`, `ReqSkillRank`, `ReqLevel`, `Index`) VALUES
(63075, 125439, 0, 0, 0, 5, 0),
(63073, 125439, 0, 0, 0, 5, 0),
(63070, 125439, 0, 0, 0, 5, 0),
(63067, 125439, 0, 0, 0, 5, 0),
(63061, 125439, 0, 0, 0, 5, 0),
(63596, 125439, 0, 0, 0, 5, 0),
(63014, 125439, 0, 0, 0, 5, 0),
(63077, 125439, 0, 0, 0, 5, 0),
(63080, 125439, 0, 0, 0, 5, 0),
(63083, 125439, 0, 0, 0, 5, 0),
(63086, 125439, 0, 0, 0, 5, 0),
(63626, 125439, 0, 0, 0, 5, 0);
