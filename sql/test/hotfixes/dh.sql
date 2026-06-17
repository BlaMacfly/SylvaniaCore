DELETE FROM `broadcast_text` WHERE `ID` IN (147324, 147325);
INSERT INTO `broadcast_text` (`ID`, `Text`, `Text1`, `EmoteID1`, `EmoteID2`, `EmoteID3`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmotesID`, `LanguageID`, `Flags`, `ConditionID`, `SoundEntriesID1`, `SoundEntriesID2`, `VerifiedBuild`) VALUES
(147324, '<Saurfang looks you up and down with narrowed eyes.>\n\nWhen Khadgar claimed we would be seeing demon hunters today, I laughed in his face. When he said I should hear you out, I laught louder.\n\nAnd yet, here you are.\n\nI will permit you alone to enter the Hold. You will leave your weapons and companions at the door. You will not speak until spoken to.\n\nOne false move and my axe will end you.', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 27404),
(147325, 'You are the demon hunters who escaped the Vault of the Wardens?\n\nYou draw your very power from those who seek to destroy our world. Tell me, why should I possibly trust you?', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 27404),
(147326, 'We are indomitable. We are Illidari.', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 27404),
(147327, 'Let nothing stand in your way.', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 27404);
(147328, 'I don\'t have time for pleasantries, demon hunter.\n\nAs I told the other Illidari, I have much to contemplate.\n\nI must prepare our armies to take on the Legion, even as some of my allies cry out for vengeance against the Horde.', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 27404);

DELETE FROM `spell` WHERE `ID`=197627;
INSERT INTO `spell` (`ID`,`Name`,`NameSubtext`,`Description`,`AuraDescription`,`VerifiedBuild`) VALUES
(197627,'Brood Swarm','','A Swarm of Spiders attacks nearby players, inflicting Shadow damage to all nearby enemies.','A Swarm of Spiders attacks nearby players, inflicting Shadow damage to all nearby enemies.', 26972);

DELETE FROM `spell_misc` WHERE `ID`=197627;
INSERT INTO `spell_misc` (`ID`,`CastingTimeIndex`,`DurationIndex`,`RangeIndex`,`SchoolMask`,`SpellIconFileDataID`,`Speed`,`ActiveIconFileDataID`,`LaunchDelay`,`DifficultyID`,`Attributes1`,`Attributes2`,`Attributes3`,`Attributes4`,`Attributes5`,`Attributes6`,`Attributes7`,`Attributes8`,`Attributes9`,`Attributes10`,`Attributes11`,`Attributes12`,`Attributes13`,`Attributes14`,`SpellID`,`VerifiedBuild`) VALUES
(197627,1,31,291,1,132091,0,0,0,0,327696,0,67108864,0,2048,-2147483648,8388608,25165824,1,0,0,0,0,0,223591,26972);