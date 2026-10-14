-- Textes de remise et d'attente restes en RUSSE (depart troll, iles de l'Echo) et un en francais dans la table anglaise (38819).
-- Anglais officiel releve sur Wowhead le 14/10/2026 ; seules les lignes encore en cyrillique (ou en francais pour 38819) sont touchees.

UPDATE `quest_offer_reward` SET `RewardText` = 'Nice ta see new faces \'round here, mon. It\'s easy ta get ta feelin\' isolated since we left Orgrimmar.' WHERE `ID` = 24622 AND HEX(`RewardText`) REGEXP '^(..)*D[0-4]';
UPDATE `quest_offer_reward` SET `RewardText` = 'Thank ya so much! They can be vicious when provoked, but most of da time dey don\'t know betta.' WHERE `ID` = 24623 AND HEX(`RewardText`) REGEXP '^(..)*D[0-4]';
UPDATE `quest_request_items` SET `CompletionText` = 'Poor little tings.' WHERE `ID` = 24623 AND HEX(`CompletionText`) REGEXP '^(..)*D[0-4]';
UPDATE `quest_offer_reward` SET `RewardText` = 'Thank you, $c.$B$BIt will be takin\' brave and determined people like you ta drive da Darkspear up again. I hope dere are more people even half as dedicated to come.' WHERE `ID` = 24624 AND HEX(`RewardText`) REGEXP '^(..)*D[0-4]';
UPDATE `quest_offer_reward` SET `RewardText` = 'Well done, $n! Dis naga has set us back quite some time, but nothin\' will be holdin\' us down foreva.$B$BIt\'s good ta be havin\' ya wit us, $n. Ya have a fierce heart within ya.' WHERE `ID` = 24625 AND HEX(`RewardText`) REGEXP '^(..)*D[0-4]';
UPDATE `quest_request_items` SET `CompletionText` = 'Da naga have been our enemies for a long, long time, and our previous encounters with dem have not gone well. It be clear dat dis time will be different. Tings have changed, and you be part of dat change.' WHERE `ID` = 24625 AND HEX(`CompletionText`) REGEXP '^(..)*D[0-4]';
UPDATE `quest_offer_reward` SET `RewardText` = 'Swiftclaw! Kijara was tellin\' me about him and he sounded like he\'d be a handful. I don\'t mind da challenge - it\'s da spirited ones like dat that be makin\' da bravest and truest companions when real times of need be comin\'.$B$BTank ya, hon. Ya\'ve been very helpful.' WHERE `ID` = 24626 AND HEX(`RewardText`) REGEXP '^(..)*D[0-4]';
UPDATE `quest_request_items` SET `CompletionText` = 'Did ya come back wit one of the raptors I sent ya for?' WHERE `ID` = 24626 AND HEX(`CompletionText`) REGEXP '^(..)*D[0-4]';
UPDATE `quest_offer_reward` SET `RewardText` = 'Dese are some fine pelts, boy. We could make some hefty cloaks outta dese.' WHERE `ID` = 24761 AND HEX(`RewardText`) REGEXP '^(..)*D[0-4]';
UPDATE `quest_request_items` SET `CompletionText` = 'I doubt dey too much of a challenge, mon, but they\'ll still claw up ya ankles if ya don\'t stay quick footed.' WHERE `ID` = 24761 AND HEX(`CompletionText`) REGEXP '^(..)*D[0-4]';
UPDATE `quest_offer_reward` SET `RewardText` = 'Well fought, young $r.' WHERE `ID` = 24812 AND HEX(`RewardText`) REGEXP '^(..)*D[0-4]';
UPDATE `quest_offer_reward` SET `RewardText` = 'Dat should keep dem at bay.' WHERE `ID` = 24813 AND HEX(`RewardText`) REGEXP '^(..)*D[0-4]';
UPDATE `quest_offer_reward` SET `RewardText` = 'Tha power d\'at burst forth when tha Sea Witch died was immense. I can use d\'is power ta enact a vision of places far away.$B$BObserve, youngblood. I want ya ta be here when I make contact wit\' Thrall, perhaps it will be grantin\' ya insight as well.' WHERE `ID` = 24814 AND HEX(`RewardText`) REGEXP '^(..)*D[0-4]';
UPDATE `quest_request_items` SET `CompletionText` = 'I did not think we\'d be afforded da opportunity to fight her again. She was foolish to be returnin\'.' WHERE `ID` = 24814 AND HEX(`CompletionText`) REGEXP '^(..)*D[0-4]';
UPDATE `quest_offer_reward` SET `RewardText` = 'Good to have ya, brotha.$B$BVol\'jin makes us all proud in dese moments. It feels good ta be tacklin\' threats head on.' WHERE `ID` = 25035 AND HEX(`RewardText`) REGEXP '^(..)*D[0-4]';
UPDATE `quest_offer_reward` SET `RewardText` = 'Oi! Tasty, mon. Thank ya for your great kindness, young one. Da spirits shall surely be regardin\' ya with great favor.' WHERE `ID` = 25037 AND HEX(`RewardText`) REGEXP '^(..)*D[0-4]';
UPDATE `quest_request_items` SET `CompletionText` = 'Da sea be offerin\' few boons as delicious as fresh crawler meat.' WHERE `ID` = 25037 AND HEX(`CompletionText`) REGEXP '^(..)*D[0-4]';
UPDATE `quest_offer_reward` SET `RewardText` = 'I am in complete agreement. From where I\'m standing, you utterly decimated their forces.$B$BWhat do you think? Are we ready to fly up to that command center and take the Sargerite Keystone?' WHERE `ID` = 38819 AND `RewardText` LIKE BINARY 'Je suis tout%';

-- francais officiel manquant (Wowhead FR)
INSERT IGNORE INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(24812, 'frFR', 'Bien combattu, jeune $r.', 0),
(24813, 'frFR', 'Ça devrait les garder à l\'écart.', 0);
INSERT IGNORE INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(24761, 'frFR', 'J’crois pas qu\'ça s\'ra trop dur, mon pote, mais faut dire ce qui est, si vous vous bougez pas un peu, y vous griffent les chevilles.', 0);
