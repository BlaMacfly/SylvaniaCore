-- correct offer rewards for quest 28785 join the battle!
/*
SELECT * FROM quest_template WHERE LogTitle IN  ('Join the Battle!');
SELECT * FROM quest_offer_reward WHERE id IN  (SELECT id FROM quest_template WHERE LogTitle IN  ('Join the Battle!'));
SELECT * FROM quest_offer_reward_locale WHERE id IN  (SELECT id FROM quest_template WHERE LogTitle IN  ('Join the Battle!'));
*/

-- correct offer rewards for quest 28785 join the battle!
UPDATE `creature_template` SET `npcflag`='0' WHERE  `entry`=50039;

DELETE FROM `quest_offer_reward` WHERE `ID` IN (28780, 28784, 28785, 28786, 28787, 28788, 28789, 29080, 31143);
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES 
(28780, 0, 0, 0, 0, 0, 0, 0, 0, 'It\'s true, we were ambushed. I don\'t dare send any more soldiers out there and risk losing them too. I need a volunteer. Someone willing to risk their life!', 0),
(28784, 0, 0, 0, 0, 0, 0, 0, 0, 'It\'s true, we were ambushed. I don\'t dare send any more soldiers out there and risk losing them too. I need a volunteer. Someone willing to risk their life!', 0),
(28785, 0, 0, 0, 0, 0, 0, 0, 0, 'It\'s true, we were ambushed. I don\'t dare send any more soldiers out there and risk losing them too. I need a volunteer. Someone willing to risk their life!', 0),
(28786, 0, 0, 0, 0, 0, 0, 0, 0, 'It\'s true, we were ambushed. I don\'t dare send any more soldiers out there and risk losing them too. I need a volunteer. Someone willing to risk their life!', 0),
(28787, 0, 0, 0, 0, 0, 0, 0, 0, 'It\'s true, we were ambushed. I don\'t dare send any more soldiers out there and risk losing them too. I need a volunteer. Someone willing to risk their life!', 0),
(28788, 0, 0, 0, 0, 0, 0, 0, 0, 'It\'s true, we were ambushed. I don\'t dare send any more soldiers out there and risk losing them too. I need a volunteer. Someone willing to risk their life!', 0),
(28789, 0, 0, 0, 0, 0, 0, 0, 0, 'It\'s true, we were ambushed. I don\'t dare send any more soldiers out there and risk losing them too. I need a volunteer. Someone willing to risk their life!', 0),
(29080, 0, 0, 0, 0, 0, 0, 0, 0, 'It\'s true, we were ambushed. I don\'t dare send any more soldiers out there and risk losing them too. I need a volunteer. Someone willing to risk their life!', 0),
(31143, 0, 0, 0, 0, 0, 0, 0, 0, 'It\'s true, we were ambushed. I don\'t dare send any more soldiers out there and risk losing them too. I need a volunteer. Someone willing to risk their life!', 0);
-- locales
DELETE FROM `quest_offer_reward_locale` WHERE `ID` IN (28780, 28784, 28785, 28786, 28787, 28788, 28789, 29080, 31143);
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES 
(28780, 'deDE', 'Es stimmt, man hat uns aus dem Hinterhalt angegriffen. Ich wage es nicht, noch weitere Soldaten dort hinauszuschicken und zu riskieren, sie auch noch zu verlieren. Ich brauche einen Freiwilligen. Jemanden, der bereit ist, sein Leben zu riskieren!', 0),
(28780, 'ruRU', 'Да, мы и правда в западне. Я опасаюсь снова посылать туда солдат, так как и они могут погибнуть. Мне нужен доброволец, кто-то, кто рискнет своей жизнью!', 0),
(28780, 'frFR', 'C’est vrai, on nous a tendu une embuscade. Je n’ose plus envoyer de soldats là-bas et risquer de les perdre aussi. Il me faut un volontaire qui serait prêt à risquer sa vie !', 0),
(28780, 'esES', 'Es verdad, nos tendieron una emboscada. No me atrevo a enviar más soldados y arriesgarme a perderlos. Necesito un voluntario. ¡Alguien dispuesto a jugarse la vida!', 0),
(28780, 'itIT', 'È vero, ci hanno teso un\'imboscata. Non oso mandare altri soldati per timore di perderli. Mi serve una volontaria. Qualcuno disposto a rischiare la propria vita!', 0),
(28780, 'ptBR', 'É verdade, eles nos pegaram de surpresa. Não posso enviar mais soldados e correr o risco de perdê-los também. Preciso de um voluntário. Alguém disposto a arriscar a vida!', 0),
(28780, 'koKR', '우리가 공격받았단 건 사실입니다. 전 감히 그곳으로 병사들을 더 보내지 못합니다. 그들을 잃는 위험도 감당하지 못한단 말입니다. 지원자가 필요합니다. 자신의 목숨을 걸 의지가 있는 누군가가 말입니다!', 0),

(28784, 'deDE', 'Es stimmt, man hat uns aus dem Hinterhalt angegriffen. Ich wage es nicht, noch weitere Soldaten dort hinauszuschicken und zu riskieren, sie auch noch zu verlieren. Ich brauche einen Freiwilligen. Jemanden, der bereit ist, sein Leben zu riskieren!', 0),
(28784, 'ruRU', 'Да, мы и правда в западне. Я опасаюсь снова посылать туда солдат, так как и они могут погибнуть. Мне нужен доброволец, кто-то, кто рискнет своей жизнью!', 0),
(28784, 'frFR', 'C’est vrai, on nous a tendu une embuscade. Je n’ose plus envoyer de soldats là-bas et risquer de les perdre aussi. Il me faut un volontaire qui serait prêt à risquer sa vie !', 0),
(28784, 'esES', 'Es verdad, nos tendieron una emboscada. No me atrevo a enviar más soldados y arriesgarme a perderlos. Necesito un voluntario. ¡Alguien dispuesto a jugarse la vida!', 0),
(28784, 'itIT', 'È vero, ci hanno teso un\'imboscata. Non oso mandare altri soldati per timore di perderli. Mi serve una volontaria. Qualcuno disposto a rischiare la propria vita!', 0),
(28784, 'ptBR', 'É verdade, eles nos pegaram de surpresa. Não posso enviar mais soldados e correr o risco de perdê-los também. Preciso de um voluntário. Alguém disposto a arriscar a vida!', 0),
(28784, 'koKR', '우리가 공격받았단 건 사실입니다. 전 감히 그곳으로 병사들을 더 보내지 못합니다. 그들을 잃는 위험도 감당하지 못한단 말입니다. 지원자가 필요합니다. 자신의 목숨을 걸 의지가 있는 누군가가 말입니다!', 0),

(28785, 'deDE', 'Es stimmt, man hat uns aus dem Hinterhalt angegriffen. Ich wage es nicht, noch weitere Soldaten dort hinauszuschicken und zu riskieren, sie auch noch zu verlieren. Ich brauche einen Freiwilligen. Jemanden, der bereit ist, sein Leben zu riskieren!', 0),
(28785, 'ruRU', 'Да, мы и правда в западне. Я опасаюсь снова посылать туда солдат, так как и они могут погибнуть. Мне нужен доброволец, кто-то, кто рискнет своей жизнью!', 0),
(28785, 'frFR', 'C’est vrai, on nous a tendu une embuscade. Je n’ose plus envoyer de soldats là-bas et risquer de les perdre aussi. Il me faut un volontaire qui serait prêt à risquer sa vie !', 0),
(28785, 'esES', 'Es verdad, nos tendieron una emboscada. No me atrevo a enviar más soldados y arriesgarme a perderlos. Necesito un voluntario. ¡Alguien dispuesto a jugarse la vida!', 0),
(28785, 'itIT', 'È vero, ci hanno teso un\'imboscata. Non oso mandare altri soldati per timore di perderli. Mi serve una volontaria. Qualcuno disposto a rischiare la propria vita!', 0),
(28785, 'ptBR', 'É verdade, eles nos pegaram de surpresa. Não posso enviar mais soldados e correr o risco de perdê-los também. Preciso de um voluntário. Alguém disposto a arriscar a vida!', 0),
(28785, 'koKR', '우리가 공격받았단 건 사실입니다. 전 감히 그곳으로 병사들을 더 보내지 못합니다. 그들을 잃는 위험도 감당하지 못한단 말입니다. 지원자가 필요합니다. 자신의 목숨을 걸 의지가 있는 누군가가 말입니다!', 0),

(28786, 'deDE', 'Es stimmt, man hat uns aus dem Hinterhalt angegriffen. Ich wage es nicht, noch weitere Soldaten dort hinauszuschicken und zu riskieren, sie auch noch zu verlieren. Ich brauche einen Freiwilligen. Jemanden, der bereit ist, sein Leben zu riskieren!', 0),
(28786, 'ruRU', 'Да, мы и правда в западне. Я опасаюсь снова посылать туда солдат, так как и они могут погибнуть. Мне нужен доброволец, кто-то, кто рискнет своей жизнью!', 0),
(28786, 'frFR', 'C’est vrai, on nous a tendu une embuscade. Je n’ose plus envoyer de soldats là-bas et risquer de les perdre aussi. Il me faut un volontaire qui serait prêt à risquer sa vie !', 0),
(28786, 'esES', 'Es verdad, nos tendieron una emboscada. No me atrevo a enviar más soldados y arriesgarme a perderlos. Necesito un voluntario. ¡Alguien dispuesto a jugarse la vida!', 0),
(28786, 'itIT', 'È vero, ci hanno teso un\'imboscata. Non oso mandare altri soldati per timore di perderli. Mi serve una volontaria. Qualcuno disposto a rischiare la propria vita!', 0),
(28786, 'ptBR', 'É verdade, eles nos pegaram de surpresa. Não posso enviar mais soldados e correr o risco de perdê-los também. Preciso de um voluntário. Alguém disposto a arriscar a vida!', 0),
(28786, 'koKR', '우리가 공격받았단 건 사실입니다. 전 감히 그곳으로 병사들을 더 보내지 못합니다. 그들을 잃는 위험도 감당하지 못한단 말입니다. 지원자가 필요합니다. 자신의 목숨을 걸 의지가 있는 누군가가 말입니다!', 0),

(28787, 'deDE', 'Es stimmt, man hat uns aus dem Hinterhalt angegriffen. Ich wage es nicht, noch weitere Soldaten dort hinauszuschicken und zu riskieren, sie auch noch zu verlieren. Ich brauche einen Freiwilligen. Jemanden, der bereit ist, sein Leben zu riskieren!', 0),
(28787, 'ruRU', 'Да, мы и правда в западне. Я опасаюсь снова посылать туда солдат, так как и они могут погибнуть. Мне нужен доброволец, кто-то, кто рискнет своей жизнью!', 0),
(28787, 'frFR', 'C’est vrai, on nous a tendu une embuscade. Je n’ose plus envoyer de soldats là-bas et risquer de les perdre aussi. Il me faut un volontaire qui serait prêt à risquer sa vie !', 0),
(28787, 'esES', 'Es verdad, nos tendieron una emboscada. No me atrevo a enviar más soldados y arriesgarme a perderlos. Necesito un voluntario. ¡Alguien dispuesto a jugarse la vida!', 0),
(28787, 'itIT', 'È vero, ci hanno teso un\'imboscata. Non oso mandare altri soldati per timore di perderli. Mi serve una volontaria. Qualcuno disposto a rischiare la propria vita!', 0),
(28787, 'ptBR', 'É verdade, eles nos pegaram de surpresa. Não posso enviar mais soldados e correr o risco de perdê-los também. Preciso de um voluntário. Alguém disposto a arriscar a vida!', 0),
(28787, 'koKR', '우리가 공격받았단 건 사실입니다. 전 감히 그곳으로 병사들을 더 보내지 못합니다. 그들을 잃는 위험도 감당하지 못한단 말입니다. 지원자가 필요합니다. 자신의 목숨을 걸 의지가 있는 누군가가 말입니다!', 0),

(28788, 'deDE', 'Es stimmt, man hat uns aus dem Hinterhalt angegriffen. Ich wage es nicht, noch weitere Soldaten dort hinauszuschicken und zu riskieren, sie auch noch zu verlieren. Ich brauche einen Freiwilligen. Jemanden, der bereit ist, sein Leben zu riskieren!', 0),
(28788, 'ruRU', 'Да, мы и правда в западне. Я опасаюсь снова посылать туда солдат, так как и они могут погибнуть. Мне нужен доброволец, кто-то, кто рискнет своей жизнью!', 0),
(28788, 'frFR', 'C’est vrai, on nous a tendu une embuscade. Je n’ose plus envoyer de soldats là-bas et risquer de les perdre aussi. Il me faut un volontaire qui serait prêt à risquer sa vie !', 0),
(28788, 'esES', 'Es verdad, nos tendieron una emboscada. No me atrevo a enviar más soldados y arriesgarme a perderlos. Necesito un voluntario. ¡Alguien dispuesto a jugarse la vida!', 0),
(28788, 'itIT', 'È vero, ci hanno teso un\'imboscata. Non oso mandare altri soldati per timore di perderli. Mi serve una volontaria. Qualcuno disposto a rischiare la propria vita!', 0),
(28788, 'ptBR', 'É verdade, eles nos pegaram de surpresa. Não posso enviar mais soldados e correr o risco de perdê-los também. Preciso de um voluntário. Alguém disposto a arriscar a vida!', 0),
(28788, 'koKR', '우리가 공격받았단 건 사실입니다. 전 감히 그곳으로 병사들을 더 보내지 못합니다. 그들을 잃는 위험도 감당하지 못한단 말입니다. 지원자가 필요합니다. 자신의 목숨을 걸 의지가 있는 누군가가 말입니다!', 0),

(28789, 'deDE', 'Es stimmt, man hat uns aus dem Hinterhalt angegriffen. Ich wage es nicht, noch weitere Soldaten dort hinauszuschicken und zu riskieren, sie auch noch zu verlieren. Ich brauche einen Freiwilligen. Jemanden, der bereit ist, sein Leben zu riskieren!', 0),
(28789, 'ruRU', 'Да, мы и правда в западне. Я опасаюсь снова посылать туда солдат, так как и они могут погибнуть. Мне нужен доброволец, кто-то, кто рискнет своей жизнью!', 0),
(28789, 'frFR', 'C’est vrai, on nous a tendu une embuscade. Je n’ose plus envoyer de soldats là-bas et risquer de les perdre aussi. Il me faut un volontaire qui serait prêt à risquer sa vie !', 0),
(28789, 'esES', 'Es verdad, nos tendieron una emboscada. No me atrevo a enviar más soldados y arriesgarme a perderlos. Necesito un voluntario. ¡Alguien dispuesto a jugarse la vida!', 0),
(28789, 'itIT', 'È vero, ci hanno teso un\'imboscata. Non oso mandare altri soldati per timore di perderli. Mi serve una volontaria. Qualcuno disposto a rischiare la propria vita!', 0),
(28789, 'ptBR', 'É verdade, eles nos pegaram de surpresa. Não posso enviar mais soldados e correr o risco de perdê-los também. Preciso de um voluntário. Alguém disposto a arriscar a vida!', 0),
(28789, 'koKR', '우리가 공격받았단 건 사실입니다. 전 감히 그곳으로 병사들을 더 보내지 못합니다. 그들을 잃는 위험도 감당하지 못한단 말입니다. 지원자가 필요합니다. 자신의 목숨을 걸 의지가 있는 누군가가 말입니다!', 0),

(29080, 'deDE', 'Es stimmt, man hat uns aus dem Hinterhalt angegriffen. Ich wage es nicht, noch weitere Soldaten dort hinauszuschicken und zu riskieren, sie auch noch zu verlieren. Ich brauche einen Freiwilligen. Jemanden, der bereit ist, sein Leben zu riskieren!', 0),
(29080, 'ruRU', 'Да, мы и правда в западне. Я опасаюсь снова посылать туда солдат, так как и они могут погибнуть. Мне нужен доброволец, кто-то, кто рискнет своей жизнью!', 0),
(29080, 'frFR', 'C’est vrai, on nous a tendu une embuscade. Je n’ose plus envoyer de soldats là-bas et risquer de les perdre aussi. Il me faut un volontaire qui serait prêt à risquer sa vie !', 0),
(29080, 'esES', 'Es verdad, nos tendieron una emboscada. No me atrevo a enviar más soldados y arriesgarme a perderlos. Necesito un voluntario. ¡Alguien dispuesto a jugarse la vida!', 0),
(29080, 'itIT', 'È vero, ci hanno teso un\'imboscata. Non oso mandare altri soldati per timore di perderli. Mi serve una volontaria. Qualcuno disposto a rischiare la propria vita!', 0),
(29080, 'ptBR', 'É verdade, eles nos pegaram de surpresa. Não posso enviar mais soldados e correr o risco de perdê-los também. Preciso de um voluntário. Alguém disposto a arriscar a vida!', 0),
(29080, 'koKR', '우리가 공격받았단 건 사실입니다. 전 감히 그곳으로 병사들을 더 보내지 못합니다. 그들을 잃는 위험도 감당하지 못한단 말입니다. 지원자가 필요합니다. 자신의 목숨을 걸 의지가 있는 누군가가 말입니다!', 0),

(31143, 'deDE', 'Es stimmt, man hat uns aus dem Hinterhalt angegriffen. Ich wage es nicht, noch weitere Soldaten dort hinauszuschicken und zu riskieren, sie auch noch zu verlieren. Ich brauche einen Freiwilligen. Jemanden, der bereit ist, sein Leben zu riskieren!', 0),
(31143, 'ruRU', 'Да, мы и правда в западне. Я опасаюсь снова посылать туда солдат, так как и они могут погибнуть. Мне нужен доброволец, кто-то, кто рискнет своей жизнью!', 0),
(31143, 'frFR', 'C’est vrai, on nous a tendu une embuscade. Je n’ose plus envoyer de soldats là-bas et risquer de les perdre aussi. Il me faut un volontaire qui serait prêt à risquer sa vie !', 0),
(31143, 'esES', 'Es verdad, nos tendieron una emboscada. No me atrevo a enviar más soldados y arriesgarme a perderlos. Necesito un voluntario. ¡Alguien dispuesto a jugarse la vida!', 0),
(31143, 'itIT', 'È vero, ci hanno teso un\'imboscata. Non oso mandare altri soldati per timore di perderli. Mi serve una volontaria. Qualcuno disposto a rischiare la propria vita!', 0),
(31143, 'ptBR', 'É verdade, eles nos pegaram de surpresa. Não posso enviar mais soldados e correr o risco de perdê-los também. Preciso de um voluntário. Alguém disposto a arriscar a vida!', 0),
(31143, 'koKR', '우리가 공격받았단 건 사실입니다. 전 감히 그곳으로 병사들을 더 보내지 못합니다. 그들을 잃는 위험도 감당하지 못한단 말입니다. 지원자가 필요합니다. 자신의 목숨을 걸 의지가 있는 누군가가 말입니다!', 0);

-- correct offer rewards for quest 28806 fear no evil
DELETE FROM `quest_offer_reward` WHERE `ID` IN (28806, 28808, 28809, 28810, 28811, 28812, 28813, 29082);
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES 
(28806, 0, 0, 0, 0, 0, 0, 0, 0, 'I think you now understand the power of the Light. The Light giveth hope, $g brother:sister; and the Light taketh from the darkness! BLESSED BE THE LIGHT!', 0),
(28808, 0, 0, 0, 0, 0, 0, 0, 0, 'I think you now understand the power of the Light. The Light giveth hope, $g brother:sister; and the Light taketh from the darkness! BLESSED BE THE LIGHT!', 0),
(28809, 0, 0, 0, 0, 0, 0, 0, 0, 'I think you now understand the power of the Light. The Light giveth hope, $g brother:sister; and the Light taketh from the darkness! BLESSED BE THE LIGHT!', 0),
(28810, 0, 0, 0, 0, 0, 0, 0, 0, 'I think you now understand the power of the Light. The Light giveth hope, $g brother:sister; and the Light taketh from the darkness! BLESSED BE THE LIGHT!', 0),
(28811, 0, 0, 0, 0, 0, 0, 0, 0, 'I think you now understand the power of the Light. The Light giveth hope, $g brother:sister; and the Light taketh from the darkness! BLESSED BE THE LIGHT!', 0),
(28812, 0, 0, 0, 0, 0, 0, 0, 0, 'I think you now understand the power of the Light. The Light giveth hope, $g brother:sister; and the Light taketh from the darkness! BLESSED BE THE LIGHT!', 0),
(28813, 0, 0, 0, 0, 0, 0, 0, 0, 'I think you now understand the power of the Light. The Light giveth hope, $g brother:sister; and the Light taketh from the darkness! BLESSED BE THE LIGHT!', 0),
(29082, 0, 0, 0, 0, 0, 0, 0, 0, 'I think you now understand the power of the Light. The Light giveth hope, $g brother:sister; and the Light taketh from the darkness! BLESSED BE THE LIGHT!', 0);

-- locales
DELETE FROM `quest_offer_reward_locale` WHERE `ID` IN (28806, 28808, 28809, 28810, 28811, 28812, 28813, 29082);
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES 
(28806, 'frFR', 'Je pense que désormais, vous comprenez le pouvoir de la Lumière. La Lumière donne l’espoir, mon frère, la Lumière combat les ténèbres ! LOUÉE SOIT LA LUMIÈRE !', 0),
(28806, 'ptBR', 'Acho que você finalmente compreendeu o poder da Luz. A Luz nos dá esperança, irmão, e nos afasta da escuridão! BENDITA SEJA A LUZ!', 0),
(28806, 'ruRU', 'Надеюсь, теперь ты осознаешь всю полноту силы Света. Он дарует нам надежду, сестра, и изгоняет тьму! ДА БЛАГОСЛОВЕН БУДЕТ СВЕТ!', 0),
(28806, 'deDE', 'Ich glaube, Ihr versteht nun, welche Macht dem Licht innewohnt. Das Licht spendet Hoffnung, Schwester, und das Licht lässt die Finsternis schwinden! GESEGNET SEI DAS LICHT!', 0),
(28806, 'esES', 'Creo que ya comprendes el poder de la Luz. ¡La Luz da esperanza, hermano, y la Luz disipa la oscuridad! ¡BENDITA SEA LA LUZ!', 0),
(28806, 'itIT', 'Credo che tu ora comprenda il potere della Luce. La Luce trasmette speranza, sorella. E la Luce ci salva dall\'oscurità! SIA LODATA LA LUCE!', 0),

(28808, 'frFR', 'Je pense que désormais, vous comprenez le pouvoir de la Lumière. La Lumière donne l’espoir, mon frère, la Lumière combat les ténèbres ! LOUÉE SOIT LA LUMIÈRE !', 0),
(28808, 'ptBR', 'Acho que você finalmente compreendeu o poder da Luz. A Luz nos dá esperança, irmão, e nos afasta da escuridão! BENDITA SEJA A LUZ!', 0),
(28808, 'ruRU', 'Надеюсь, теперь ты осознаешь всю полноту силы Света. Он дарует нам надежду, сестра, и изгоняет тьму! ДА БЛАГОСЛОВЕН БУДЕТ СВЕТ!', 0),
(28808, 'deDE', 'Ich glaube, Ihr versteht nun, welche Macht dem Licht innewohnt. Das Licht spendet Hoffnung, Schwester, und das Licht lässt die Finsternis schwinden! GESEGNET SEI DAS LICHT!', 0),
(28808, 'esES', 'Creo que ya comprendes el poder de la Luz. ¡La Luz da esperanza, hermano, y la Luz disipa la oscuridad! ¡BENDITA SEA LA LUZ!', 0),
(28808, 'itIT', 'Credo che tu ora comprenda il potere della Luce. La Luce trasmette speranza, sorella. E la Luce ci salva dall\'oscurità! SIA LODATA LA LUCE!', 0),

(28809, 'frFR', 'Je pense que désormais, vous comprenez le pouvoir de la Lumière. La Lumière donne l’espoir, mon frère, la Lumière combat les ténèbres ! LOUÉE SOIT LA LUMIÈRE !', 0),
(28809, 'ptBR', 'Acho que você finalmente compreendeu o poder da Luz. A Luz nos dá esperança, irmão, e nos afasta da escuridão! BENDITA SEJA A LUZ!', 0),
(28809, 'ruRU', 'Надеюсь, теперь ты осознаешь всю полноту силы Света. Он дарует нам надежду, сестра, и изгоняет тьму! ДА БЛАГОСЛОВЕН БУДЕТ СВЕТ!', 0),
(28809, 'deDE', 'Ich glaube, Ihr versteht nun, welche Macht dem Licht innewohnt. Das Licht spendet Hoffnung, Schwester, und das Licht lässt die Finsternis schwinden! GESEGNET SEI DAS LICHT!', 0),
(28809, 'esES', 'Creo que ya comprendes el poder de la Luz. ¡La Luz da esperanza, hermano, y la Luz disipa la oscuridad! ¡BENDITA SEA LA LUZ!', 0),
(28809, 'itIT', 'Credo che tu ora comprenda il potere della Luce. La Luce trasmette speranza, sorella. E la Luce ci salva dall\'oscurità! SIA LODATA LA LUCE!', 0),

(28810, 'frFR', 'Je pense que désormais, vous comprenez le pouvoir de la Lumière. La Lumière donne l’espoir, mon frère, la Lumière combat les ténèbres ! LOUÉE SOIT LA LUMIÈRE !', 0),
(28810, 'ptBR', 'Acho que você finalmente compreendeu o poder da Luz. A Luz nos dá esperança, irmão, e nos afasta da escuridão! BENDITA SEJA A LUZ!', 0),
(28810, 'ruRU', 'Надеюсь, теперь ты осознаешь всю полноту силы Света. Он дарует нам надежду, сестра, и изгоняет тьму! ДА БЛАГОСЛОВЕН БУДЕТ СВЕТ!', 0),
(28810, 'deDE', 'Ich glaube, Ihr versteht nun, welche Macht dem Licht innewohnt. Das Licht spendet Hoffnung, Schwester, und das Licht lässt die Finsternis schwinden! GESEGNET SEI DAS LICHT!', 0),
(28810, 'esES', 'Creo que ya comprendes el poder de la Luz. ¡La Luz da esperanza, hermano, y la Luz disipa la oscuridad! ¡BENDITA SEA LA LUZ!', 0),
(28810, 'itIT', 'Credo che tu ora comprenda il potere della Luce. La Luce trasmette speranza, sorella. E la Luce ci salva dall\'oscurità! SIA LODATA LA LUCE!', 0),

(28811, 'frFR', 'Je pense que désormais, vous comprenez le pouvoir de la Lumière. La Lumière donne l’espoir, mon frère, la Lumière combat les ténèbres ! LOUÉE SOIT LA LUMIÈRE !', 0),
(28811, 'ptBR', 'Acho que você finalmente compreendeu o poder da Luz. A Luz nos dá esperança, irmão, e nos afasta da escuridão! BENDITA SEJA A LUZ!', 0),
(28811, 'ruRU', 'Надеюсь, теперь ты осознаешь всю полноту силы Света. Он дарует нам надежду, сестра, и изгоняет тьму! ДА БЛАГОСЛОВЕН БУДЕТ СВЕТ!', 0),
(28811, 'deDE', 'Ich glaube, Ihr versteht nun, welche Macht dem Licht innewohnt. Das Licht spendet Hoffnung, Schwester, und das Licht lässt die Finsternis schwinden! GESEGNET SEI DAS LICHT!', 0),
(28811, 'esES', 'Creo que ya comprendes el poder de la Luz. ¡La Luz da esperanza, hermano, y la Luz disipa la oscuridad! ¡BENDITA SEA LA LUZ!', 0),
(28811, 'itIT', 'Credo che tu ora comprenda il potere della Luce. La Luce trasmette speranza, sorella. E la Luce ci salva dall\'oscurità! SIA LODATA LA LUCE!', 0),

(28812, 'frFR', 'Je pense que désormais, vous comprenez le pouvoir de la Lumière. La Lumière donne l’espoir, mon frère, la Lumière combat les ténèbres ! LOUÉE SOIT LA LUMIÈRE !', 0),
(28812, 'ptBR', 'Acho que você finalmente compreendeu o poder da Luz. A Luz nos dá esperança, irmão, e nos afasta da escuridão! BENDITA SEJA A LUZ!', 0),
(28812, 'ruRU', 'Надеюсь, теперь ты осознаешь всю полноту силы Света. Он дарует нам надежду, сестра, и изгоняет тьму! ДА БЛАГОСЛОВЕН БУДЕТ СВЕТ!', 0),
(28812, 'deDE', 'Ich glaube, Ihr versteht nun, welche Macht dem Licht innewohnt. Das Licht spendet Hoffnung, Schwester, und das Licht lässt die Finsternis schwinden! GESEGNET SEI DAS LICHT!', 0),
(28812, 'esES', 'Creo que ya comprendes el poder de la Luz. ¡La Luz da esperanza, hermano, y la Luz disipa la oscuridad! ¡BENDITA SEA LA LUZ!', 0),
(28812, 'itIT', 'Credo che tu ora comprenda il potere della Luce. La Luce trasmette speranza, sorella. E la Luce ci salva dall\'oscurità! SIA LODATA LA LUCE!', 0),

(28813, 'frFR', 'Je pense que désormais, vous comprenez le pouvoir de la Lumière. La Lumière donne l’espoir, mon frère, la Lumière combat les ténèbres ! LOUÉE SOIT LA LUMIÈRE !', 0),
(28813, 'ptBR', 'Acho que você finalmente compreendeu o poder da Luz. A Luz nos dá esperança, irmão, e nos afasta da escuridão! BENDITA SEJA A LUZ!', 0),
(28813, 'ruRU', 'Надеюсь, теперь ты осознаешь всю полноту силы Света. Он дарует нам надежду, сестра, и изгоняет тьму! ДА БЛАГОСЛОВЕН БУДЕТ СВЕТ!', 0),
(28813, 'deDE', 'Ich glaube, Ihr versteht nun, welche Macht dem Licht innewohnt. Das Licht spendet Hoffnung, Schwester, und das Licht lässt die Finsternis schwinden! GESEGNET SEI DAS LICHT!', 0),
(28813, 'esES', 'Creo que ya comprendes el poder de la Luz. ¡La Luz da esperanza, hermano, y la Luz disipa la oscuridad! ¡BENDITA SEA LA LUZ!', 0),
(28813, 'itIT', 'Credo che tu ora comprenda il potere della Luce. La Luce trasmette speranza, sorella. E la Luce ci salva dall\'oscurità! SIA LODATA LA LUCE!', 0),

(29082, 'frFR', 'Je pense que désormais, vous comprenez le pouvoir de la Lumière. La Lumière donne l’espoir, mon frère, la Lumière combat les ténèbres ! LOUÉE SOIT LA LUMIÈRE !', 0),
(29082, 'ptBR', 'Acho que você finalmente compreendeu o poder da Luz. A Luz nos dá esperança, irmão, e nos afasta da escuridão! BENDITA SEJA A LUZ!', 0),
(29082, 'ruRU', 'Надеюсь, теперь ты осознаешь всю полноту силы Света. Он дарует нам надежду, сестра, и изгоняет тьму! ДА БЛАГОСЛОВЕН БУДЕТ СВЕТ!', 0),
(29082, 'deDE', 'Ich glaube, Ihr versteht nun, welche Macht dem Licht innewohnt. Das Licht spendet Hoffnung, Schwester, und das Licht lässt die Finsternis schwinden! GESEGNET SEI DAS LICHT!', 0),
(29082, 'esES', 'Creo que ya comprendes el poder de la Luz. ¡La Luz da esperanza, hermano, y la Luz disipa la oscuridad! ¡BENDITA SEA LA LUZ!', 0),
(29082, 'itIT', 'Credo che tu ora comprenda il potere della Luce. La Luce trasmette speranza, sorella. E la Luce ci salva dall\'oscurità! SIA LODATA LA LUCE!', 0);

-- correct locales for quest 28796 they sent assasins
DELETE FROM `quest_offer_reward` WHERE `ID` IN (28791, 28792, 28793, 28794, 28795, 28796, 28797, 29081, 31144);
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES 
(28791, 0, 0, 0, 0, 0, 0, 0, 0, 'That will teach those monsters! They\'ll think twice before taking another mercenary job for orcs.', 0),
(28792, 0, 0, 0, 0, 0, 0, 0, 0, 'That will teach those monsters! They\'ll think twice before taking another mercenary job for orcs.', 0),
(28793, 0, 0, 0, 0, 0, 0, 0, 0, 'That will teach those monsters! They\'ll think twice before taking another mercenary job for orcs.', 0),
(28794, 0, 0, 0, 0, 0, 0, 0, 0, 'That will teach those monsters! They\'ll think twice before taking another mercenary job for orcs.', 0),
(28795, 0, 0, 0, 0, 0, 0, 0, 0, 'That will teach those monsters! They\'ll think twice before taking another mercenary job for orcs.', 0),
(28796, 0, 0, 0, 0, 0, 0, 0, 0, 'That will teach those monsters! They\'ll think twice before taking another mercenary job for orcs.', 0),
(28797, 0, 0, 0, 0, 0, 0, 0, 0, 'That will teach those monsters! They\'ll think twice before taking another mercenary job for orcs.', 0),
(29081, 0, 0, 0, 0, 0, 0, 0, 0, 'That will teach those monsters! They\'ll think twice before taking another mercenary job for orcs.', 0),
(31144, 0, 0, 0, 0, 0, 0, 0, 0, 'That will teach those monsters! They\'ll think twice before taking another mercenary job for orcs.', 0);

DELETE FROM `quest_offer_reward_locale` WHERE `ID` IN (28791, 28792, 28793, 28794, 28795, 28796, 28797, 29081, 31144);
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES 
(28791, 'frFR', 'Ça leur apprendra, à ces monstres ! Ils y réfléchiront à deux fois avant d’accepter une autre mission de mercenaire pour les orcs.', 0),
(28791, 'esES', '¡Así aprenderán esos monstruos! Se lo pensarán dos veces antes de aceptar trabajos de mercenarios de los orcos.', 0),
(28791, 'ruRU', 'Вот им наука на будущее! Пусть теперь подумают дважды, прежде чем наниматься к оркам.', 0),
(28791, 'deDE', 'Ihr habt diesen Monstern eine Lektion erteilt! Sie werden es sich zweimal überlegen, bevor sie noch einen Mordauftrag der Orcs annehmen.', 0),
(28791, 'itIT', 'Così imparano, quei piccoli mostri! Ora ci penseranno due volte prima di accettare un altro lavoro dagli Orchi.', 0),
(28791, 'ptBR', 'Você ensinou uma boa lição àqueles monstros! Eles vão pensar duas vezes antes de aceitarem outros serviços dos orcs.', 0),

(28792, 'frFR', 'Ça leur apprendra, à ces monstres ! Ils y réfléchiront à deux fois avant d’accepter une autre mission de mercenaire pour les orcs.', 0),
(28792, 'esES', '¡Así aprenderán esos monstruos! Se lo pensarán dos veces antes de aceptar trabajos de mercenarios de los orcos.', 0),
(28792, 'ruRU', 'Вот им наука на будущее! Пусть теперь подумают дважды, прежде чем наниматься к оркам.', 0),
(28792, 'deDE', 'Ihr habt diesen Monstern eine Lektion erteilt! Sie werden es sich zweimal überlegen, bevor sie noch einen Mordauftrag der Orcs annehmen.', 0),
(28792, 'itIT', 'Così imparano, quei piccoli mostri! Ora ci penseranno due volte prima di accettare un altro lavoro dagli Orchi.', 0),
(28792, 'ptBR', 'Você ensinou uma boa lição àqueles monstros! Eles vão pensar duas vezes antes de aceitarem outros serviços dos orcs.', 0),

(28793, 'frFR', 'Ça leur apprendra, à ces monstres ! Ils y réfléchiront à deux fois avant d’accepter une autre mission de mercenaire pour les orcs.', 0),
(28793, 'esES', '¡Así aprenderán esos monstruos! Se lo pensarán dos veces antes de aceptar trabajos de mercenarios de los orcos.', 0),
(28793, 'ruRU', 'Вот им наука на будущее! Пусть теперь подумают дважды, прежде чем наниматься к оркам.', 0),
(28793, 'deDE', 'Ihr habt diesen Monstern eine Lektion erteilt! Sie werden es sich zweimal überlegen, bevor sie noch einen Mordauftrag der Orcs annehmen.', 0),
(28793, 'itIT', 'Così imparano, quei piccoli mostri! Ora ci penseranno due volte prima di accettare un altro lavoro dagli Orchi.', 0),
(28793, 'ptBR', 'Você ensinou uma boa lição àqueles monstros! Eles vão pensar duas vezes antes de aceitarem outros serviços dos orcs.', 0),

(28794, 'frFR', 'Ça leur apprendra, à ces monstres ! Ils y réfléchiront à deux fois avant d’accepter une autre mission de mercenaire pour les orcs.', 0),
(28794, 'esES', '¡Así aprenderán esos monstruos! Se lo pensarán dos veces antes de aceptar trabajos de mercenarios de los orcos.', 0),
(28794, 'ruRU', 'Вот им наука на будущее! Пусть теперь подумают дважды, прежде чем наниматься к оркам.', 0),
(28794, 'deDE', 'Ihr habt diesen Monstern eine Lektion erteilt! Sie werden es sich zweimal überlegen, bevor sie noch einen Mordauftrag der Orcs annehmen.', 0),
(28794, 'itIT', 'Così imparano, quei piccoli mostri! Ora ci penseranno due volte prima di accettare un altro lavoro dagli Orchi.', 0),
(28794, 'ptBR', 'Você ensinou uma boa lição àqueles monstros! Eles vão pensar duas vezes antes de aceitarem outros serviços dos orcs.', 0),

(28795, 'frFR', 'Ça leur apprendra, à ces monstres ! Ils y réfléchiront à deux fois avant d’accepter une autre mission de mercenaire pour les orcs.', 0),
(28795, 'esES', '¡Así aprenderán esos monstruos! Se lo pensarán dos veces antes de aceptar trabajos de mercenarios de los orcos.', 0),
(28795, 'ruRU', 'Вот им наука на будущее! Пусть теперь подумают дважды, прежде чем наниматься к оркам.', 0),
(28795, 'deDE', 'Ihr habt diesen Monstern eine Lektion erteilt! Sie werden es sich zweimal überlegen, bevor sie noch einen Mordauftrag der Orcs annehmen.', 0),
(28795, 'itIT', 'Così imparano, quei piccoli mostri! Ora ci penseranno due volte prima di accettare un altro lavoro dagli Orchi.', 0),
(28795, 'ptBR', 'Você ensinou uma boa lição àqueles monstros! Eles vão pensar duas vezes antes de aceitarem outros serviços dos orcs.', 0),

(28796, 'frFR', 'Ça leur apprendra, à ces monstres ! Ils y réfléchiront à deux fois avant d’accepter une autre mission de mercenaire pour les orcs.', 0),
(28796, 'esES', '¡Así aprenderán esos monstruos! Se lo pensarán dos veces antes de aceptar trabajos de mercenarios de los orcos.', 0),
(28796, 'ruRU', 'Вот им наука на будущее! Пусть теперь подумают дважды, прежде чем наниматься к оркам.', 0),
(28796, 'deDE', 'Ihr habt diesen Monstern eine Lektion erteilt! Sie werden es sich zweimal überlegen, bevor sie noch einen Mordauftrag der Orcs annehmen.', 0),
(28796, 'itIT', 'Così imparano, quei piccoli mostri! Ora ci penseranno due volte prima di accettare un altro lavoro dagli Orchi.', 0),
(28796, 'ptBR', 'Você ensinou uma boa lição àqueles monstros! Eles vão pensar duas vezes antes de aceitarem outros serviços dos orcs.', 0),

(28797, 'frFR', 'Ça leur apprendra, à ces monstres ! Ils y réfléchiront à deux fois avant d’accepter une autre mission de mercenaire pour les orcs.', 0),
(28797, 'esES', '¡Así aprenderán esos monstruos! Se lo pensarán dos veces antes de aceptar trabajos de mercenarios de los orcos.', 0),
(28797, 'ruRU', 'Вот им наука на будущее! Пусть теперь подумают дважды, прежде чем наниматься к оркам.', 0),
(28797, 'deDE', 'Ihr habt diesen Monstern eine Lektion erteilt! Sie werden es sich zweimal überlegen, bevor sie noch einen Mordauftrag der Orcs annehmen.', 0),
(28797, 'itIT', 'Così imparano, quei piccoli mostri! Ora ci penseranno due volte prima di accettare un altro lavoro dagli Orchi.', 0),
(28797, 'ptBR', 'Você ensinou uma boa lição àqueles monstros! Eles vão pensar duas vezes antes de aceitarem outros serviços dos orcs.', 0),

(29081, 'frFR', 'Ça leur apprendra, à ces monstres ! Ils y réfléchiront à deux fois avant d’accepter une autre mission de mercenaire pour les orcs.', 0),
(29081, 'esES', '¡Así aprenderán esos monstruos! Se lo pensarán dos veces antes de aceptar trabajos de mercenarios de los orcos.', 0),
(29081, 'ruRU', 'Вот им наука на будущее! Пусть теперь подумают дважды, прежде чем наниматься к оркам.', 0),
(29081, 'deDE', 'Ihr habt diesen Monstern eine Lektion erteilt! Sie werden es sich zweimal überlegen, bevor sie noch einen Mordauftrag der Orcs annehmen.', 0),
(29081, 'itIT', 'Così imparano, quei piccoli mostri! Ora ci penseranno due volte prima di accettare un altro lavoro dagli Orchi.', 0),
(29081, 'ptBR', 'Você ensinou uma boa lição àqueles monstros! Eles vão pensar duas vezes antes de aceitarem outros serviços dos orcs.', 0),

(31144, 'frFR', 'Ça leur apprendra, à ces monstres ! Ils y réfléchiront à deux fois avant d’accepter une autre mission de mercenaire pour les orcs.', 0),
(31144, 'esES', '¡Así aprenderán esos monstruos! Se lo pensarán dos veces antes de aceptar trabajos de mercenarios de los orcos.', 0),
(31144, 'ruRU', 'Вот им наука на будущее! Пусть теперь подумают дважды, прежде чем наниматься к оркам.', 0),
(31144, 'deDE', 'Ihr habt diesen Monstern eine Lektion erteilt! Sie werden es sich zweimal überlegen, bevor sie noch einen Mordauftrag der Orcs annehmen.', 0),
(31144, 'itIT', 'Così imparano, quei piccoli mostri! Ora ci penseranno due volte prima di accettare un altro lavoro dagli Orchi.', 0),
(31144, 'ptBR', 'Você ensinou uma boa lição àqueles monstros! Eles vão pensar duas vezes antes de aceitarem outros serviços dos orcs.', 0);

-- correct locales for quest 28757 Beating Them Back!
DELETE FROM `quest_offer_reward` WHERE `ID` IN (28757, 28762, 28763, 28764, 28765, 28766, 28767, 29078, 28769, 31139);
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES 
(28757, 1, 1, 0, 0, 0, 0, 0, 0, 'You\'ve bought us a little time, $n, but we\'ve got even bigger problems to deal with now.', 22522),
(28762, 1, 1, 0, 0, 0, 0, 0, 0, 'You\'ve bought us a little time, $n, but we\'ve got even bigger problems to deal with now.', 22522),
(28763, 1, 1, 0, 0, 0, 0, 0, 0, 'You\'ve bought us a little time, $n, but we\'ve got even bigger problems to deal with now.', 22522),
(28764, 1, 1, 0, 0, 0, 0, 0, 0, 'You\'ve bought us a little time, $n, but we\'ve got even bigger problems to deal with now.', 22522),
(28765, 1, 1, 0, 0, 0, 0, 0, 0, 'You\'ve bought us a little time, $n, but we\'ve got even bigger problems to deal with now.', 22522),
(28766, 1, 1, 0, 0, 0, 0, 0, 0, 'You\'ve bought us a little time, $n, but we\'ve got even bigger problems to deal with now.', 22522),
(28767, 1, 1, 0, 0, 0, 0, 0, 0, 'You\'ve bought us a little time, $n, but we\'ve got even bigger problems to deal with now.', 22522),
(29078, 1, 1, 0, 0, 0, 0, 0, 0, 'You\'ve bought us a little time, $n, but we\'ve got even bigger problems to deal with now.', 22522),
(28769, 1, 1, 0, 0, 0, 0, 0, 0, 'You\'ve bought us a little time, $n, but we\'ve got even bigger problems to deal with now.', 22522),
(31139, 1, 1, 0, 0, 0, 0, 0, 0, 'You\'ve bought us a little time, $n, but we\'ve got even bigger problems to deal with now.', 22522);

DELETE FROM `quest_offer_reward_locale` WHERE `ID` IN (28757, 28762, 28763, 28764, 28765, 28766, 28767, 29078, 28769, 31139);
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES 
(28757, 'frFR', 'Vous nous avez fait gagner un peu de temps, $N, mais des problèmes encore plus importants nous attendent.', 0),
(28757, 'deDE', 'Ihr habt uns ein wenig Zeit verschafft, $N, aber wir haben jetzt ein noch größeres Problem, um das wir uns kümmern müssen.', 0),
(28757, 'ruRU', 'Вы сэкономили нам немного времени, $N, но впереди нас ждут ещё большие проблемы', 0),
(28757, 'esES', 'Nos has conseguido algo de tiempo, $N, pero ahora tenemos que ocuparnos de problemas aún más importantes.', 0),
(28757, 'itIT', 'Così imparano, quei piccoli mostri! Ora ci penseranno due volte prima di accettare un altro lavoro dagli Orchi.', 0),
(28757, 'ptBR', 'Você ensinou uma boa lição àqueles monstros! Eles vão pensar duas vezes antes de aceitarem outros serviços dos orcs.', 0),

(28762, 'frFR', 'Vous nous avez fait gagner un peu de temps, $N, mais des problèmes encore plus importants nous attendent.', 0),
(28762, 'deDE', 'Ihr habt uns ein wenig Zeit verschafft, $N, aber wir haben jetzt ein noch größeres Problem, um das wir uns kümmern müssen.', 0),
(28762, 'ruRU', 'Вы сэкономили нам немного времени, $N, но впереди нас ждут ещё большие проблемы', 0),
(28762, 'esES', 'Nos has conseguido algo de tiempo, $N, pero ahora tenemos que ocuparnos de problemas aún más importantes.', 0),
(28762, 'itIT', 'Così imparano, quei piccoli mostri! Ora ci penseranno due volte prima di accettare un altro lavoro dagli Orchi.', 0),
(28762, 'ptBR', 'Você ensinou uma boa lição àqueles monstros! Eles vão pensar duas vezes antes de aceitarem outros serviços dos orcs.', 0),

(28763, 'frFR', 'Vous nous avez fait gagner un peu de temps, $N, mais des problèmes encore plus importants nous attendent.', 0),
(28763, 'deDE', 'Ihr habt uns ein wenig Zeit verschafft, $N, aber wir haben jetzt ein noch größeres Problem, um das wir uns kümmern müssen.', 0),
(28763, 'ruRU', 'Вы сэкономили нам немного времени, $N, но впереди нас ждут ещё большие проблемы', 0),
(28763, 'esES', 'Nos has conseguido algo de tiempo, $N, pero ahora tenemos que ocuparnos de problemas aún más importantes.', 0),
(28763, 'itIT', 'Così imparano, quei piccoli mostri! Ora ci penseranno due volte prima di accettare un altro lavoro dagli Orchi.', 0),
(28763, 'ptBR', 'Você ensinou uma boa lição àqueles monstros! Eles vão pensar duas vezes antes de aceitarem outros serviços dos orcs.', 0),

(28764, 'frFR', 'Vous nous avez fait gagner un peu de temps, $N, mais des problèmes encore plus importants nous attendent.', 0),
(28764, 'deDE', 'Ihr habt uns ein wenig Zeit verschafft, $N, aber wir haben jetzt ein noch größeres Problem, um das wir uns kümmern müssen.', 0),
(28764, 'ruRU', 'Вы сэкономили нам немного времени, $N, но впереди нас ждут ещё большие проблемы', 0),
(28764, 'esES', 'Nos has conseguido algo de tiempo, $N, pero ahora tenemos que ocuparnos de problemas aún más importantes.', 0),
(28764, 'itIT', 'Così imparano, quei piccoli mostri! Ora ci penseranno due volte prima di accettare un altro lavoro dagli Orchi.', 0),
(28764, 'ptBR', 'Você ensinou uma boa lição àqueles monstros! Eles vão pensar duas vezes antes de aceitarem outros serviços dos orcs.', 0),

(28765, 'frFR', 'Vous nous avez fait gagner un peu de temps, $N, mais des problèmes encore plus importants nous attendent.', 0),
(28765, 'deDE', 'Ihr habt uns ein wenig Zeit verschafft, $N, aber wir haben jetzt ein noch größeres Problem, um das wir uns kümmern müssen.', 0),
(28765, 'ruRU', 'Вы сэкономили нам немного времени, $N, но впереди нас ждут ещё большие проблемы', 0),
(28765, 'esES', 'Nos has conseguido algo de tiempo, $N, pero ahora tenemos que ocuparnos de problemas aún más importantes.', 0),
(28765, 'itIT', 'Così imparano, quei piccoli mostri! Ora ci penseranno due volte prima di accettare un altro lavoro dagli Orchi.', 0),
(28765, 'ptBR', 'Você ensinou uma boa lição àqueles monstros! Eles vão pensar duas vezes antes de aceitarem outros serviços dos orcs.', 0),

(28766, 'frFR', 'Vous nous avez fait gagner un peu de temps, $N, mais des problèmes encore plus importants nous attendent.', 0),
(28766, 'deDE', 'Ihr habt uns ein wenig Zeit verschafft, $N, aber wir haben jetzt ein noch größeres Problem, um das wir uns kümmern müssen.', 0),
(28766, 'ruRU', 'Вы сэкономили нам немного времени, $N, но впереди нас ждут ещё большие проблемы', 0),
(28766, 'esES', 'Nos has conseguido algo de tiempo, $N, pero ahora tenemos que ocuparnos de problemas aún más importantes.', 0),
(28766, 'itIT', 'Così imparano, quei piccoli mostri! Ora ci penseranno due volte prima di accettare un altro lavoro dagli Orchi.', 0),
(28766, 'ptBR', 'Você ensinou uma boa lição àqueles monstros! Eles vão pensar duas vezes antes de aceitarem outros serviços dos orcs.', 0),

(28767, 'frFR', 'Vous nous avez fait gagner un peu de temps, $N, mais des problèmes encore plus importants nous attendent.', 0),
(28767, 'deDE', 'Ihr habt uns ein wenig Zeit verschafft, $N, aber wir haben jetzt ein noch größeres Problem, um das wir uns kümmern müssen.', 0),
(28767, 'ruRU', 'Вы сэкономили нам немного времени, $N, но впереди нас ждут ещё большие проблемы', 0),
(28767, 'esES', 'Nos has conseguido algo de tiempo, $N, pero ahora tenemos que ocuparnos de problemas aún más importantes.', 0),
(28767, 'itIT', 'Così imparano, quei piccoli mostri! Ora ci penseranno due volte prima di accettare un altro lavoro dagli Orchi.', 0),
(28767, 'ptBR', 'Você ensinou uma boa lição àqueles monstros! Eles vão pensar duas vezes antes de aceitarem outros serviços dos orcs.', 0),

(29078, 'frFR', 'Vous nous avez fait gagner un peu de temps, $N, mais des problèmes encore plus importants nous attendent.', 0),
(29078, 'deDE', 'Ihr habt uns ein wenig Zeit verschafft, $N, aber wir haben jetzt ein noch größeres Problem, um das wir uns kümmern müssen.', 0),
(29078, 'ruRU', 'Вы сэкономили нам немного времени, $N, но впереди нас ждут ещё большие проблемы', 0),
(29078, 'esES', 'Nos has conseguido algo de tiempo, $N, pero ahora tenemos que ocuparnos de problemas aún más importantes.', 0),
(29078, 'itIT', 'Così imparano, quei piccoli mostri! Ora ci penseranno due volte prima di accettare un altro lavoro dagli Orchi.', 0),
(29078, 'ptBR', 'Você ensinou uma boa lição àqueles monstros! Eles vão pensar duas vezes antes de aceitarem outros serviços dos orcs.', 0),

(31139, 'frFR', 'Vous nous avez fait gagner un peu de temps, $N, mais des problèmes encore plus importants nous attendent.', 0),
(31139, 'deDE', 'Ihr habt uns ein wenig Zeit verschafft, $N, aber wir haben jetzt ein noch größeres Problem, um das wir uns kümmern müssen.', 0),
(31139, 'ruRU', 'Вы сэкономили нам немного времени, $N, но впереди нас ждут ещё большие проблемы', 0),
(31139, 'esES', 'Nos has conseguido algo de tiempo, $N, pero ahora tenemos que ocuparnos de problemas aún más importantes.', 0),
(31139, 'itIT', 'Così imparano, quei piccoli mostri! Ora ci penseranno due volte prima di accettare un altro lavoro dagli Orchi.', 0),
(31139, 'ptBR', 'Você ensinou uma boa lição àqueles monstros! Eles vão pensar duas vezes antes de aceitarem outros serviços dos orcs.', 0);

-- quest offer rewards lions for lambs
DELETE FROM `quest_offer_reward` WHERE `ID`IN (28759, 28769, 28770, 28771, 28772, 28773, 28774, 29079, 31140);
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES 
(28759, 21, 0, 0, 0, 0, 0, 0, 0, 'Excellent work, $N. You\'ve turned out to be quite an asset to this garrison. It\'s time for you to train!', 0),
(28769, 21, 0, 0, 0, 0, 0, 0, 0, 'Excellent work, $N. You\'ve turned out to be quite an asset to this garrison. It\'s time for you to train!', 0),
(28770, 21, 0, 0, 0, 0, 0, 0, 0, 'Excellent work, $N. You\'ve turned out to be quite an asset to this garrison. It\'s time for you to train!', 0),
(28771, 21, 0, 0, 0, 0, 0, 0, 0, 'Excellent work, $N. You\'ve turned out to be quite an asset to this garrison. It\'s time for you to train!', 0),
(28772, 21, 0, 0, 0, 0, 0, 0, 0, 'Excellent work, $N. You\'ve turned out to be quite an asset to this garrison. It\'s time for you to train!', 0),
(28773, 21, 0, 0, 0, 0, 0, 0, 0, 'Excellent work, $N. You\'ve turned out to be quite an asset to this garrison. It\'s time for you to train!', 0),
(28774, 21, 0, 0, 0, 0, 0, 0, 0, 'Excellent work, $N. You\'ve turned out to be quite an asset to this garrison. It\'s time for you to train!', 0),
(29079, 21, 0, 0, 0, 0, 0, 0, 0, 'Excellent work, $N. You\'ve turned out to be quite an asset to this garrison.

Feel free to speak with any of our trainers within and around the abbey if you need to sharpen any of your combat skills.

When you\'re ready, I have another assignment for you...', 0),
(31140, 21, 0, 0, 0, 0, 0, 0, 0, 'Excellent work, $N. You\'ve turned out to be quite an asset to this garrison. It\'s time for you to train!', 0);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`IN (28759, 28769, 28770, 28771, 28772, 28773, 28774, 29079, 31140);
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES 
(28759, 'frFR', 'Excellent travail, $N. Vous avez prouvé que vous étiez un réel atout pour cette garnison. Il est temps d’aller vous exercer !', 0),
(28759, 'deDE', 'Hervorragende Arbeit, $N. Es hat sich herausgestellt, dass Ihr ein echter Gewinn für die Garnison seid. Es wird Zeit für Eure Ausbildung!', 0),
(28759, 'esES', 'Un trabajo excelente, $N. Has resultado ser todo un hallazgo para este cuartel. ¡Ha llegado el momento de que entrenes!', 0),
(28759, 'itIT', 'Ottimo lavoro, $N. Ti sei rivelata una vera risorsa per questa guarnigione. È tempo per te di allenarti!', 0),
(28759, 'ptBR', 'Bom trabalho, $N. Até que você se revelou um bem valioso para a guarnição. Só falta o treinamento!!', 0),
(28759, 'ruRU', 'Молодчина, $N. Ты $gоказался:оказалась; ценным приобретением для нашего гарнизона. Настало время тренировки!', 0),

(28769, 'frFR', 'Excellent travail, $N. Vous avez prouvé que vous étiez un réel atout pour cette garnison. Il est temps d’aller vous exercer !', 0),
(28769, 'deDE', 'Hervorragende Arbeit, $N. Es hat sich herausgestellt, dass Ihr ein echter Gewinn für die Garnison seid. Es wird Zeit für Eure Ausbildung!', 0),
(28769, 'esES', 'Un trabajo excelente, $N. Has resultado ser todo un hallazgo para este cuartel. ¡Ha llegado el momento de que entrenes!', 0),
(28769, 'itIT', 'Ottimo lavoro, $N. Ti sei rivelata una vera risorsa per questa guarnigione. È tempo per te di allenarti!', 0),
(28769, 'ptBR', 'Bom trabalho, $N. Até que você se revelou um bem valioso para a guarnição. Só falta o treinamento!!', 0),
(28769, 'ruRU', 'Молодчина, $N. Ты $gоказался:оказалась; ценным приобретением для нашего гарнизона. Настало время тренировки!', 0),

(28770, 'frFR', 'Excellent travail, $N. Vous avez prouvé que vous étiez un réel atout pour cette garnison. Il est temps d’aller vous exercer !', 0),
(28770, 'deDE', 'Hervorragende Arbeit, $N. Es hat sich herausgestellt, dass Ihr ein echter Gewinn für die Garnison seid. Es wird Zeit für Eure Ausbildung!', 0),
(28770, 'esES', 'Un trabajo excelente, $N. Has resultado ser todo un hallazgo para este cuartel. ¡Ha llegado el momento de que entrenes!', 0),
(28770, 'itIT', 'Ottimo lavoro, $N. Ti sei rivelata una vera risorsa per questa guarnigione. È tempo per te di allenarti!', 0),
(28770, 'ptBR', 'Bom trabalho, $N. Até que você se revelou um bem valioso para a guarnição. Só falta o treinamento!!', 0),
(28770, 'ruRU', 'Молодчина, $N. Ты $gоказался:оказалась; ценным приобретением для нашего гарнизона. Настало время тренировки!', 0),

(28771, 'frFR', 'Excellent travail, $N. Vous avez prouvé que vous étiez un réel atout pour cette garnison. Il est temps d’aller vous exercer !', 0),
(28771, 'deDE', 'Hervorragende Arbeit, $N. Es hat sich herausgestellt, dass Ihr ein echter Gewinn für die Garnison seid. Es wird Zeit für Eure Ausbildung!', 0),
(28771, 'esES', 'Un trabajo excelente, $N. Has resultado ser todo un hallazgo para este cuartel. ¡Ha llegado el momento de que entrenes!', 0),
(28771, 'itIT', 'Ottimo lavoro, $N. Ti sei rivelata una vera risorsa per questa guarnigione. È tempo per te di allenarti!', 0),
(28771, 'ptBR', 'Bom trabalho, $N. Até que você se revelou um bem valioso para a guarnição. Só falta o treinamento!!', 0),
(28771, 'ruRU', 'Молодчина, $N. Ты $gоказался:оказалась; ценным приобретением для нашего гарнизона. Настало время тренировки!', 0),

(28772, 'frFR', 'Excellent travail, $N. Vous avez prouvé que vous étiez un réel atout pour cette garnison. Il est temps d’aller vous exercer !', 0),
(28772, 'deDE', 'Hervorragende Arbeit, $N. Es hat sich herausgestellt, dass Ihr ein echter Gewinn für die Garnison seid. Es wird Zeit für Eure Ausbildung!', 0),
(28772, 'esES', 'Un trabajo excelente, $N. Has resultado ser todo un hallazgo para este cuartel. ¡Ha llegado el momento de que entrenes!', 0),
(28772, 'itIT', 'Ottimo lavoro, $N. Ti sei rivelata una vera risorsa per questa guarnigione. È tempo per te di allenarti!', 0),
(28772, 'ptBR', 'Bom trabalho, $N. Até que você se revelou um bem valioso para a guarnição. Só falta o treinamento!!', 0),
(28772, 'ruRU', 'Молодчина, $N. Ты $gоказался:оказалась; ценным приобретением для нашего гарнизона. Настало время тренировки!', 0),

(28773, 'frFR', 'Excellent travail, $N. Vous avez prouvé que vous étiez un réel atout pour cette garnison. Il est temps d’aller vous exercer !', 0),
(28773, 'deDE', 'Hervorragende Arbeit, $N. Es hat sich herausgestellt, dass Ihr ein echter Gewinn für die Garnison seid. Es wird Zeit für Eure Ausbildung!', 0),
(28773, 'esES', 'Un trabajo excelente, $N. Has resultado ser todo un hallazgo para este cuartel. ¡Ha llegado el momento de que entrenes!', 0),
(28773, 'itIT', 'Ottimo lavoro, $N. Ti sei rivelata una vera risorsa per questa guarnigione. È tempo per te di allenarti!', 0),
(28773, 'ptBR', 'Bom trabalho, $N. Até que você se revelou um bem valioso para a guarnição. Só falta o treinamento!!', 0),
(28773, 'ruRU', 'Молодчина, $N. Ты $gоказался:оказалась; ценным приобретением для нашего гарнизона. Настало время тренировки!', 0),

(28774, 'frFR', 'Excellent travail, $N. Vous avez prouvé que vous étiez un réel atout pour cette garnison. Il est temps d’aller vous exercer !', 0),
(28774, 'deDE', 'Hervorragende Arbeit, $N. Es hat sich herausgestellt, dass Ihr ein echter Gewinn für die Garnison seid. Es wird Zeit für Eure Ausbildung!', 0),
(28774, 'esES', 'Un trabajo excelente, $N. Has resultado ser todo un hallazgo para este cuartel. ¡Ha llegado el momento de que entrenes!', 0),
(28774, 'itIT', 'Ottimo lavoro, $N. Ti sei rivelata una vera risorsa per questa guarnigione. È tempo per te di allenarti!', 0),
(28774, 'ptBR', 'Bom trabalho, $N. Até que você se revelou um bem valioso para a guarnição. Só falta o treinamento!!', 0),
(28774, 'ruRU', 'Молодчина, $N. Ты $gоказался:оказалась; ценным приобретением для нашего гарнизона. Настало время тренировки!', 0),

(29079, 'frFR', 'Excellent travail, $N. Vous avez prouvé que vous étiez un réel atout pour cette garnison.$B$BN’hésitez pas à vous adresser à nos maîtres de classe dans l’abbaye et ses jardins si vous avez besoin d’affûter vos compétences martiales.$B$BQuand vous serez prêt, il y a une autre mission dont j’aimerais vous faire part…', 0),
(29079, 'deDE', 'Hervorragende Arbeit, $N. Es hat sich herausgestellt, dass Ihr ein echter Gewinn für die Garnison seid.$B$BEs steht Euch frei, mit unseren Ausbildern in und um die Abtei herum zu sprechen, wenn Ihr Eure Kampfkünste schulen wollt.$B$BWenn Ihr so weit seid, habe ich einen weiteren Auftrag für Euch...', 0),
(29079, 'esES', 'Un trabajo excelente, $N. Has resultado ser todo un hallazgo para este cuartel.$B$BNo dudes en hablar con cualquiera de nuestros instructores dentro o alrededor de la abadía si necesitas mejorar tus facultades de combate.$B$BCuando estés listo tengo otra tarea para ti...', 0),
(29079, 'itIT', 'Eccellente, $N. Ti sei rivelata una risorsa importante per la guarnigione.$B$BParla pure con qualsiasi istruttore all\'interno e nei dintorni dell\'abbazia se senti il bisogno di affinare le tue abilità di combattente.$B$BQuando sarai pronta ho un altro incarico da affidarti...', 0),
(29079, 'ptBR', 'Excelente trabalho, $N. Até que você se revelou um bem valioso para a guarnição.$B$BSinta-se a vontade para falar com qualquer um dos instrutores ao redor da abadia se precisar afiar as suas habilidades de combate.$B$BQuando estiver pronto, tenho mais uma missão para você...', 0),
(29079, 'ruRU', 'Прекрасно, $N. Ты $gпринес:принесла; много пользы нашему гарнизону.$B$BЕсли тебе нужно отточить свои боевые навыки, не стесняйся, поговори с любым из наставников в аббатстве или возле него.$B$BКогда будешь $gготов:готова;, приходи, у меня для тебя есть еще одно задание...', 0),

(31140, 'frFR', 'Excellent travail, $N. Vous avez prouvé que vous étiez un réel atout pour cette garnison. Il est temps d’aller vous exercer !', 0),
(31140, 'deDE', 'Hervorragende Arbeit, $N. Es hat sich herausgestellt, dass Ihr ein echter Gewinn für die Garnison seid. Es wird Zeit für Eure Ausbildung!', 0),
(31140, 'esES', 'Un trabajo excelente, $N. Has resultado ser todo un hallazgo para este cuartel. ¡Ha llegado el momento de que entrenes!', 0),
(31140, 'itIT', 'Ottimo lavoro, $N. Ti sei rivelata una vera risorsa per questa guarnigione. È tempo per te di allenarti!', 0),
(31140, 'ptBR', 'Bom trabalho, $N. Até que você se revelou um bem valioso para a guarnição. Só falta o treinamento!!', 0),
(31140, 'ruRU', 'Молодчина, $N. Ты $gоказался:оказалась; ценным приобретением для нашего гарнизона. Настало время тренировки!', 0);

-- quest offer rewards The Rear is Clear
DELETE FROM `quest_offer_reward` WHERE `ID` IN (28817, 28818, 28819, 28820, 28821, 28822, 28823, 29083, 31145);
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES 
(28817, 1, 1, 0, 0, 0, 0, 0, 0, 'With your help we have managed to secure the northern and western sectors of Northshire. We still have a rather large contingency of Blackrock orcs to the east and they\'ve begun burning down the forest!', 0),
(28818, 1, 1, 0, 0, 0, 0, 0, 0, 'With your help we have managed to secure the northern and western sectors of Northshire. We still have a rather large contingency of Blackrock orcs to the east and they\'ve begun burning down the forest!', 0),
(28819, 1, 1, 0, 0, 0, 0, 0, 0, 'With your help we have managed to secure the northern and western sectors of Northshire. We still have a rather large contingency of Blackrock orcs to the east and they\'ve begun burning down the forest!', 0),
(28820, 1, 1, 0, 0, 0, 0, 0, 0, 'With your help we have managed to secure the northern and western sectors of Northshire. We still have a rather large contingency of Blackrock orcs to the east and they\'ve begun burning down the forest!', 0),
(28821, 1, 1, 0, 0, 0, 0, 0, 0, 'With your help we have managed to secure the northern and western sectors of Northshire. We still have a rather large contingency of Blackrock orcs to the east and they\'ve begun burning down the forest!', 0),
(28822, 1, 1, 0, 0, 0, 0, 0, 0, 'With your help we have managed to secure the northern and western sectors of Northshire. We still have a rather large contingency of Blackrock orcs to the east and they\'ve begun burning down the forest!', 0),
(28823, 1, 1, 0, 0, 0, 0, 0, 0, 'With your help we have managed to secure the northern and western sectors of Northshire. We still have a rather large contingency of Blackrock orcs to the east and they\'ve begun burning down the forest!', 0),
(29083, 1, 1, 0, 0, 0, 0, 0, 0, 'With your help we have managed to secure the northern and western sectors of Northshire. We still have a rather large contingency of Blackrock orcs to the east and they\'ve begun burning down the forest!', 0),
(31145, 1, 1, 0, 0, 0, 0, 0, 0, 'With your help we have managed to secure the northern and western sectors of Northshire. We still have a rather large contingency of Blackrock orcs to the east and they\'ve begun burning down the forest!', 0);

DELETE FROM `quest_offer_reward_locale` WHERE `ID` IN (28817, 28818, 28819, 28820, 28821, 28822, 28823, 29083, 31145);
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES 
(28817, 'frFR', 'Grâce à vous, nous avons réussi à sécuriser les secteurs nord et ouest de Comté-du-Nord. Il reste encore un grand nombre d’orcs rochenoires à l’est et ils ont commencé à incendier la forêt !', 0),
(28817, 'deDE', 'Dank Eurer Hilfe ist es uns gelungen, die nördlichen und westlichen Abschnitte von Nordhain zu sichern. Dennoch gibt es im Osten noch immer eine ziemlich große Ansammlung von Schwarzfelsorcs und sie haben damit begonnen, den Wald niederzubrennen!', 0),
(28817, 'esES', 'Con tu ayuda hemos podido asegurar los sectores norte y oeste de Villanorte. Aún queda un contingente bastante grande de orcos Roca Negra al este, ¡y han empezado a prenderle fuego al bosque!', 0),
(28817, 'itIT', 'Grazie al tuo aiuto, siamo riusciti a mettere in sicurezza i settori settentrionali e occidentali della Contea del Nord. A est, tuttavia, c\'è ancora un grosso contingente di Orchi Roccianera che ha iniziato a bruciare la foresta!', 0),
(28817, 'ptBR', 'Com a sua ajuda, conseguimos proteger as áreas norte e oeste de Vila Norte. Ainda há um grande contingente de orcs Rocha Negra na área leste, e eles estão começando a botar fogo na floresta!', 0),
(28817, 'ruRU', 'С твоей помощью нам удалось обеспечить безопасность северного и западного секторов Североземья. Но к востоку отсюда орков Черной горы все еще много. И они начали жечь лес!', 0),

(28818, 'frFR', 'Grâce à vous, nous avons réussi à sécuriser les secteurs nord et ouest de Comté-du-Nord. Il reste encore un grand nombre d’orcs rochenoires à l’est et ils ont commencé à incendier la forêt !', 0),
(28818, 'deDE', 'Dank Eurer Hilfe ist es uns gelungen, die nördlichen und westlichen Abschnitte von Nordhain zu sichern. Dennoch gibt es im Osten noch immer eine ziemlich große Ansammlung von Schwarzfelsorcs und sie haben damit begonnen, den Wald niederzubrennen!', 0),
(28818, 'esES', 'Con tu ayuda hemos podido asegurar los sectores norte y oeste de Villanorte. Aún queda un contingente bastante grande de orcos Roca Negra al este, ¡y han empezado a prenderle fuego al bosque!', 0),
(28818, 'itIT', 'Grazie al tuo aiuto, siamo riusciti a mettere in sicurezza i settori settentrionali e occidentali della Contea del Nord. A est, tuttavia, c\'è ancora un grosso contingente di Orchi Roccianera che ha iniziato a bruciare la foresta!', 0),
(28818, 'ptBR', 'Com a sua ajuda, conseguimos proteger as áreas norte e oeste de Vila Norte. Ainda há um grande contingente de orcs Rocha Negra na área leste, e eles estão começando a botar fogo na floresta!', 0),
(28818, 'ruRU', 'С твоей помощью нам удалось обеспечить безопасность северного и западного секторов Североземья. Но к востоку отсюда орков Черной горы все еще много. И они начали жечь лес!', 0),

(28819, 'frFR', 'Grâce à vous, nous avons réussi à sécuriser les secteurs nord et ouest de Comté-du-Nord. Il reste encore un grand nombre d’orcs rochenoires à l’est et ils ont commencé à incendier la forêt !', 0),
(28819, 'deDE', 'Dank Eurer Hilfe ist es uns gelungen, die nördlichen und westlichen Abschnitte von Nordhain zu sichern. Dennoch gibt es im Osten noch immer eine ziemlich große Ansammlung von Schwarzfelsorcs und sie haben damit begonnen, den Wald niederzubrennen!', 0),
(28819, 'esES', 'Con tu ayuda hemos podido asegurar los sectores norte y oeste de Villanorte. Aún queda un contingente bastante grande de orcos Roca Negra al este, ¡y han empezado a prenderle fuego al bosque!', 0),
(28819, 'itIT', 'Grazie al tuo aiuto, siamo riusciti a mettere in sicurezza i settori settentrionali e occidentali della Contea del Nord. A est, tuttavia, c\'è ancora un grosso contingente di Orchi Roccianera che ha iniziato a bruciare la foresta!', 0),
(28819, 'ptBR', 'Com a sua ajuda, conseguimos proteger as áreas norte e oeste de Vila Norte. Ainda há um grande contingente de orcs Rocha Negra na área leste, e eles estão começando a botar fogo na floresta!', 0),
(28819, 'ruRU', 'С твоей помощью нам удалось обеспечить безопасность северного и западного секторов Североземья. Но к востоку отсюда орков Черной горы все еще много. И они начали жечь лес!', 0),

(28820, 'frFR', 'Grâce à vous, nous avons réussi à sécuriser les secteurs nord et ouest de Comté-du-Nord. Il reste encore un grand nombre d’orcs rochenoires à l’est et ils ont commencé à incendier la forêt !', 0),
(28820, 'deDE', 'Dank Eurer Hilfe ist es uns gelungen, die nördlichen und westlichen Abschnitte von Nordhain zu sichern. Dennoch gibt es im Osten noch immer eine ziemlich große Ansammlung von Schwarzfelsorcs und sie haben damit begonnen, den Wald niederzubrennen!', 0),
(28820, 'esES', 'Con tu ayuda hemos podido asegurar los sectores norte y oeste de Villanorte. Aún queda un contingente bastante grande de orcos Roca Negra al este, ¡y han empezado a prenderle fuego al bosque!', 0),
(28820, 'itIT', 'Grazie al tuo aiuto, siamo riusciti a mettere in sicurezza i settori settentrionali e occidentali della Contea del Nord. A est, tuttavia, c\'è ancora un grosso contingente di Orchi Roccianera che ha iniziato a bruciare la foresta!', 0),
(28820, 'ptBR', 'Com a sua ajuda, conseguimos proteger as áreas norte e oeste de Vila Norte. Ainda há um grande contingente de orcs Rocha Negra na área leste, e eles estão começando a botar fogo na floresta!', 0),
(28820, 'ruRU', 'С твоей помощью нам удалось обеспечить безопасность северного и западного секторов Североземья. Но к востоку отсюда орков Черной горы все еще много. И они начали жечь лес!', 0),

(28821, 'frFR', 'Grâce à vous, nous avons réussi à sécuriser les secteurs nord et ouest de Comté-du-Nord. Il reste encore un grand nombre d’orcs rochenoires à l’est et ils ont commencé à incendier la forêt !', 0),
(28821, 'deDE', 'Dank Eurer Hilfe ist es uns gelungen, die nördlichen und westlichen Abschnitte von Nordhain zu sichern. Dennoch gibt es im Osten noch immer eine ziemlich große Ansammlung von Schwarzfelsorcs und sie haben damit begonnen, den Wald niederzubrennen!', 0),
(28821, 'esES', 'Con tu ayuda hemos podido asegurar los sectores norte y oeste de Villanorte. Aún queda un contingente bastante grande de orcos Roca Negra al este, ¡y han empezado a prenderle fuego al bosque!', 0),
(28821, 'itIT', 'Grazie al tuo aiuto, siamo riusciti a mettere in sicurezza i settori settentrionali e occidentali della Contea del Nord. A est, tuttavia, c\'è ancora un grosso contingente di Orchi Roccianera che ha iniziato a bruciare la foresta!', 0),
(28821, 'ptBR', 'Com a sua ajuda, conseguimos proteger as áreas norte e oeste de Vila Norte. Ainda há um grande contingente de orcs Rocha Negra na área leste, e eles estão começando a botar fogo na floresta!', 0),
(28821, 'ruRU', 'С твоей помощью нам удалось обеспечить безопасность северного и западного секторов Североземья. Но к востоку отсюда орков Черной горы все еще много. И они начали жечь лес!', 0),

(28822, 'frFR', 'Grâce à vous, nous avons réussi à sécuriser les secteurs nord et ouest de Comté-du-Nord. Il reste encore un grand nombre d’orcs rochenoires à l’est et ils ont commencé à incendier la forêt !', 0),
(28822, 'deDE', 'Dank Eurer Hilfe ist es uns gelungen, die nördlichen und westlichen Abschnitte von Nordhain zu sichern. Dennoch gibt es im Osten noch immer eine ziemlich große Ansammlung von Schwarzfelsorcs und sie haben damit begonnen, den Wald niederzubrennen!', 0),
(28822, 'esES', 'Con tu ayuda hemos podido asegurar los sectores norte y oeste de Villanorte. Aún queda un contingente bastante grande de orcos Roca Negra al este, ¡y han empezado a prenderle fuego al bosque!', 0),
(28822, 'itIT', 'Grazie al tuo aiuto, siamo riusciti a mettere in sicurezza i settori settentrionali e occidentali della Contea del Nord. A est, tuttavia, c\'è ancora un grosso contingente di Orchi Roccianera che ha iniziato a bruciare la foresta!', 0),
(28822, 'ptBR', 'Com a sua ajuda, conseguimos proteger as áreas norte e oeste de Vila Norte. Ainda há um grande contingente de orcs Rocha Negra na área leste, e eles estão começando a botar fogo na floresta!', 0),
(28822, 'ruRU', 'С твоей помощью нам удалось обеспечить безопасность северного и западного секторов Североземья. Но к востоку отсюда орков Черной горы все еще много. И они начали жечь лес!', 0),

(28823, 'frFR', 'Grâce à vous, nous avons réussi à sécuriser les secteurs nord et ouest de Comté-du-Nord. Il reste encore un grand nombre d’orcs rochenoires à l’est et ils ont commencé à incendier la forêt !', 0),
(28823, 'deDE', 'Dank Eurer Hilfe ist es uns gelungen, die nördlichen und westlichen Abschnitte von Nordhain zu sichern. Dennoch gibt es im Osten noch immer eine ziemlich große Ansammlung von Schwarzfelsorcs und sie haben damit begonnen, den Wald niederzubrennen!', 0),
(28823, 'esES', 'Con tu ayuda hemos podido asegurar los sectores norte y oeste de Villanorte. Aún queda un contingente bastante grande de orcos Roca Negra al este, ¡y han empezado a prenderle fuego al bosque!', 0),
(28823, 'itIT', 'Grazie al tuo aiuto, siamo riusciti a mettere in sicurezza i settori settentrionali e occidentali della Contea del Nord. A est, tuttavia, c\'è ancora un grosso contingente di Orchi Roccianera che ha iniziato a bruciare la foresta!', 0),
(28823, 'ptBR', 'Com a sua ajuda, conseguimos proteger as áreas norte e oeste de Vila Norte. Ainda há um grande contingente de orcs Rocha Negra na área leste, e eles estão começando a botar fogo na floresta!', 0),
(28823, 'ruRU', 'С твоей помощью нам удалось обеспечить безопасность северного и западного секторов Североземья. Но к востоку отсюда орков Черной горы все еще много. И они начали жечь лес!', 0),

(29083, 'frFR', 'Grâce à vous, nous avons réussi à sécuriser les secteurs nord et ouest de Comté-du-Nord. Il reste encore un grand nombre d’orcs rochenoires à l’est et ils ont commencé à incendier la forêt !', 0),
(29083, 'deDE', 'Dank Eurer Hilfe ist es uns gelungen, die nördlichen und westlichen Abschnitte von Nordhain zu sichern. Dennoch gibt es im Osten noch immer eine ziemlich große Ansammlung von Schwarzfelsorcs und sie haben damit begonnen, den Wald niederzubrennen!', 0),
(29083, 'esES', 'Con tu ayuda hemos podido asegurar los sectores norte y oeste de Villanorte. Aún queda un contingente bastante grande de orcos Roca Negra al este, ¡y han empezado a prenderle fuego al bosque!', 0),
(29083, 'itIT', 'Grazie al tuo aiuto, siamo riusciti a mettere in sicurezza i settori settentrionali e occidentali della Contea del Nord. A est, tuttavia, c\'è ancora un grosso contingente di Orchi Roccianera che ha iniziato a bruciare la foresta!', 0),
(29083, 'ptBR', 'Com a sua ajuda, conseguimos proteger as áreas norte e oeste de Vila Norte. Ainda há um grande contingente de orcs Rocha Negra na área leste, e eles estão começando a botar fogo na floresta!', 0),
(29083, 'ruRU', 'С твоей помощью нам удалось обеспечить безопасность северного и западного секторов Североземья. Но к востоку отсюда орков Черной горы все еще много. И они начали жечь лес!', 0),

(31145, 'frFR', 'Grâce à vous, nous avons réussi à sécuriser les secteurs nord et ouest de Comté-du-Nord. Il reste encore un grand nombre d’orcs rochenoires à l’est et ils ont commencé à incendier la forêt !', 0),
(31145, 'deDE', 'Dank Eurer Hilfe ist es uns gelungen, die nördlichen und westlichen Abschnitte von Nordhain zu sichern. Dennoch gibt es im Osten noch immer eine ziemlich große Ansammlung von Schwarzfelsorcs und sie haben damit begonnen, den Wald niederzubrennen!', 0),
(31145, 'esES', 'Con tu ayuda hemos podido asegurar los sectores norte y oeste de Villanorte. Aún queda un contingente bastante grande de orcos Roca Negra al este, ¡y han empezado a prenderle fuego al bosque!', 0),
(31145, 'itIT', 'Grazie al tuo aiuto, siamo riusciti a mettere in sicurezza i settori settentrionali e occidentali della Contea del Nord. A est, tuttavia, c\'è ancora un grosso contingente di Orchi Roccianera che ha iniziato a bruciare la foresta!', 0),
(31145, 'ptBR', 'Com a sua ajuda, conseguimos proteger as áreas norte e oeste de Vila Norte. Ainda há um grande contingente de orcs Rocha Negra na área leste, e eles estão começando a botar fogo na floresta!', 0),
(31145, 'ruRU', 'С твоей помощью нам удалось обеспечить безопасность северного и западного секторов Североземья. Но к востоку отсюда орков Черной горы все еще много. И они начали жечь лес!', 0);

-- quest offer rewards rest and relaxation
DELETE FROM `quest_offer_reward` WHERE `ID` IN (2158, 37112);
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES 
(2158, 0, 0, 0, 0, 0, 0, 0, 0, 'Rest and relaxation for the tired and cold -- that\'s our motto! Please, take a seat by the fire and rest your weary bones.$B$BWould you like to try a sampling of some of our fine food and drink?', 0),
(37112, 0, 0, 0, 0, 0, 0, 0, 0, 'Rest and relaxation for the tired and cold -- that\'s our motto! Please, take a seat by the fire and rest your weary bones.$B$BWould you like to try a sampling of some of our fine food and drink?', 0);

DELETE FROM `quest_offer_reward_locale` WHERE `ID` IN (2158, 37112);
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES 
(2158, 'deDE', 'Ruhe und Entspannung für die Müden und Frierenden – das ist unser Leitspruch! Bitte setzt Euch ans Feuer und wärmt Eure müden Knochen.$B$BMöchtet Ihr von unseren erlesenen Speisen und Getränken kosten?', 0),
(2158, 'esES', '¡Descanso y relax para quien no puede más! ¡Ese es nuestro lema! Por favor, toma asiento cerca del fuego y da un respiro a tus cansados huesos. $B$B¿Te gustaría probar una selección de nuestra excelente comida y bebida?', 0),
(2158, 'frFR', 'Le repos et la détente pour ceux qui sont fatigués et qui ont froid – c\'est notre devise ! Je vous en prie, prenez place près du feu et reposez-vous.$B$BVoudriez-vous goûter quelques-uns de nos plus excellents mets et boissons ?', 0),
(2158, 'itIT', 'Riposo e relax contro la stanchezza e il freddo, questo è il nostro motto! Prego, siediti vicino al fuoco e riposa le tue ossa stanche.$B$BTi va un po\' del nostro cibo e delle nostre bevande?', 0),
(2158, 'ptBR', 'Repouso e relaxamento para os cansados e famintos, esse é nosso lema! Por favor, sente-se ao pé do fogo e descanse os ossos.$B$BVocê gostaria de alguma coisa para comer e beber?', 0),
(2158, 'ruRU', 'Отдых и расслабление для уставших и холодных - это наш девиз! Пожалуйста, присядьте у огня и отдохните.$B$BНе могли бы вы попробовать некоторые из наших лучших блюд и напитков ?', 0),

(37112, 'deDE', 'Ruhe und Entspannung für die Müden und Frierenden – das ist unser Leitspruch! Bitte setzt Euch ans Feuer und wärmt Eure müden Knochen.$B$BMöchtet Ihr von unseren erlesenen Speisen und Getränken kosten?', 0),
(37112, 'esES', '¡Descanso y relax para quien no puede más! ¡Ese es nuestro lema! Por favor, toma asiento cerca del fuego y da un respiro a tus cansados huesos. $B$B¿Te gustaría probar una selección de nuestra excelente comida y bebida?', 0),
(37112, 'frFR', 'Le repos et la détente pour ceux qui sont fatigués et qui ont froid – c\'est notre devise ! Je vous en prie, prenez place près du feu et reposez-vous.$B$BVoudriez-vous goûter quelques-uns de nos plus excellents mets et boissons ?', 0),
(37112, 'itIT', 'Riposo e relax contro la stanchezza e il freddo, questo è il nostro motto! Prego, siediti vicino al fuoco e riposa le tue ossa stanche.$B$BTi va un po\' del nostro cibo e delle nostre bevande?', 0),
(37112, 'ptBR', 'Repouso e relaxamento para os cansados e famintos, esse é nosso lema! Por favor, sente-se ao pé do fogo e descanse os ossos.$B$BVocê gostaria de alguma coisa para comer e beber?', 0),
(37112, 'ruRU', 'Отдых и расслабление для уставших и холодных - это наш девиз! Пожалуйста, присядьте у огня и отдохните.$B$BНе могли бы вы попробовать некоторые из наших лучших блюд и напитков ?', 0);

-- quest Return to Argus
DELETE FROM `quest_offer_reward` WHERE `ID` IN (26396);
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES 
(26396, 1, 1, 0, 0, 0, 0, 0, 0, 'Great, you brought the armor!  We\'ll get this divvied to those who need it immediately.$B$BThank you, $N.  Your efforts have been a great help to us.  And now that you\'re no stranger to gryphons, I hope you\'ll come and lend your aid to Goldshire often!', 0);

DELETE FROM `quest_offer_reward_locale` WHERE `ID` IN (26396);
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES 
(26396, 'deDE', 'Wunderbar, Ihr habt die Rüstungen gebracht! Wir werden sie sofort unter denen verteilen, die sie brauchen.$B$BVielen Dank, $N. Ihr wart uns wirklich eine große Hilfe. Und jetzt, da Ihr Euch ein wenig mit den Greifen vertraut gemacht habt, hoffe ich, dass Ihr öfter kommt und Goldhain unterstützt!', 0),
(26396, 'esES', '¡Genial, has traído las armaduras! Las distribuiremos entre los que más la necesitan de inmediato.$B$BGracias, $N. Nos has ayudado mucho a todos. Ahora que te has acostumbrado a volar en grifo, ¡espero que vuelvas a prestar ayuda a Villadorada con frecuencia!', 0),
(26396, 'frFR', 'Fantastique ! Vous avez apporté les armures ! Nous allons immédiatement répartir tout ça entre ceux qui en ont le plus besoin.$B$BMerci, $N. Vous nous avez grandement aidés. Maintenant que vous n’êtes plus un étranger pour les griffons, j’espère que vous reviendrez souvent nous prêter main-forte.', 0),
(26396, 'itIT', 'Ottimo, hai portato l\'armatura! Lo divideremo a chi ne ha bisogno immediatamente.$B$BGrazie, $N. I tuoi sforzi sono stati di grande aiuto per noi. E ora che non sei estraneo ai grifoni, spero che verrai a prestare spesso il tuo aiuto a Goldshire!', 0),
(26396, 'ptBR', 'Você trouxe as armaduras? Ótimo! Vamos dividi-las entre as pessoas que necessitam delas imediatamente.$B$BObrigado, $N. Seu esforço tem sido de grande ajuda. E agora que você já voou num grifo, espero que venha sempre nos dar uma ajuda aqui em Vila d\'Ouro!', 0),
(26396, 'ruRU', 'Замечательно, ты $gпринес:принесла; оружие! Мы разделим его между теми, кто нуждается в нем прямо сейчас.$B$BСпасибо тебе, $N. Ты очень нам $gпомог:помогла;. И поскольку теперь ты хорошо $gзнаком:знакома; с грифонами, надеюсь, ты часто будешь помогать Златоземью!', 0);

-- quest offer rewards 28768 winterspring

DELETE FROM `quest_offer_reward` WHERE `ID` IN (28768);
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES 
(28768, 1, 1, 0, 0, 0, 0, 0, 0, 'Thank goodness you\'re here. I\'ve discovered the secret of the fierce Winterfall furbolg', 22522);
